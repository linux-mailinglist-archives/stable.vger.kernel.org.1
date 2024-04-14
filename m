Return-Path: <stable+bounces-37814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2F889CD76
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 23:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE7B4284478
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 21:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472C4148847;
	Mon,  8 Apr 2024 21:20:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF8D146A6A;
	Mon,  8 Apr 2024 21:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712611257; cv=none; b=K15F/gGJjwpPxKpNxmUl1img82dbVQEevHFWH+rCGZyNi26G6drmrKP0eK/KhvABUJ9w7wojsEDhQhfKPmZgy/JXvE/USBWeFtEsghJj+QyN4sPvxhckLMy1Nss3SYese6pbFOQaRAyEaZ2hatGd9ewzUVNGy6cwJj/VnOw0S1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712611257; c=relaxed/simple;
	bh=u7iTJgQnUzw1g/nyBKicIhVE+/2tc6BhkvdPzNTo5hE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FTwlB0ublEBrpITABiDF9oI+a39rvgyzH28Ov6Y7p6SHBedBgPgyBNmd8efwVDrxDEU/UAh+Ax97zL+9yo8HnrI4mpy7Fw1KqpGbTJBmcsPkrtYSLvb5h7kWtWfF38z/sGYD2C66FbM2dy0ztWAj8mavKmQG8BstxNd+BiUCOnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org
Subject: [PATCH 4/5] netfilter: nf_tables: release mutex after nft_gc_seq_end from abort path
Date: Mon,  8 Apr 2024 23:20:41 +0200
Message-Id: <20240408212042.312221-5-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240408212042.312221-1-pablo@netfilter.org>
References: <20240408212042.312221-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 0d459e2ffb541841714839e8228b845458ed3b27 upstream.

The commit mutex should not be released during the critical section
between nft_gc_seq_begin() and nft_gc_seq_end(), otherwise, async GC
worker could collect expired objects and get the released commit lock
within the same GC sequence.

nf_tables_module_autoload() temporarily releases the mutex to load
module dependencies, then it goes back to replay the transaction again.
Move it at the end of the abort phase after nft_gc_seq_end() is called.

Cc: stable@vger.kernel.org
Fixes: 720344340fb9 ("netfilter: nf_tables: GC transaction race with abort path")
Reported-by: Kuan-Ting Chen <hexrabbit@devco.re>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 23ca5c249d0c..12dab452f133 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -8945,11 +8945,6 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 		nf_tables_abort_release(trans);
 	}
 
-	if (action == NFNL_ABORT_AUTOLOAD)
-		nf_tables_module_autoload(net);
-	else
-		nf_tables_module_autoload_cleanup(net);
-
 	return err;
 }
 
@@ -8966,6 +8961,14 @@ static int nf_tables_abort(struct net *net, struct sk_buff *skb,
 
 	WARN_ON_ONCE(!list_empty(&nft_net->commit_list));
 
+	/* module autoload needs to happen after GC sequence update because it
+	 * temporarily releases and grabs mutex again.
+	 */
+	if (action == NFNL_ABORT_AUTOLOAD)
+		nf_tables_module_autoload(net);
+	else
+		nf_tables_module_autoload_cleanup(net);
+
 	mutex_unlock(&nft_net->commit_mutex);
 
 	return ret;
-- 
2.30.2


