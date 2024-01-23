Return-Path: <stable+bounces-15128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B58838405
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28EF61F28A7E
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83B36774C;
	Tue, 23 Jan 2024 02:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xBSJcWLd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5130767733;
	Tue, 23 Jan 2024 02:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705975282; cv=none; b=gRNCapCLF7Y/UAUaclM/m+jhU8fmIOmoZ+K7ltIj+sIaZlasjBUFeWFHgQ0Bkn0tPGbNVZcLo9fmcIwRJ6Hvy8pbgyPYPjs4SjGjnC7CeCHBjlPO6WaaYmgRgGx51JSPtPrwFp7X1zus9s6yYixSQu9o0MQEYDvbNDvQl5W6H2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705975282; c=relaxed/simple;
	bh=skEIN/W+TGUZY5k/Rvvi4ryeL+y4p+x7TLDh1PgEcsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EeKI6QB7OjWpYOb2zL2HpKIPvyJoJ66hhkt/gEUtDlZlSApBEPHmWE3Jo8WMpgsYt7dendRqneznqo87Kc5RSllMUUKPLf7m7owtj311yCmXRvzpTsSeVow9g92OyfRJm99POX7dr46f7ffp2CeROnY2xxk0d36P7QKVRh2qDHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xBSJcWLd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83329C43601;
	Tue, 23 Jan 2024 02:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705975281;
	bh=skEIN/W+TGUZY5k/Rvvi4ryeL+y4p+x7TLDh1PgEcsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xBSJcWLdNJFljOBx2ZkWXxG6W3FbR9TiTRT4/8n7pgDTDzOr5oRNZtBIKd+9RjXc8
	 TsgkbMHOeByJ8mCa7jszi11+RuziXXVFNJda8qzzyVbqW1J4LB1lS95rInWdYdFBUB
	 wxStW62gSBy8OCppHZCc8yBZAkaav/6Y2aTPuMqM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Phil Sutter <phil@nwl.cc>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 5.15 372/374] netfilter: nft_limit: Clone packet limits cost value
Date: Mon, 22 Jan 2024 16:00:28 -0800
Message-ID: <20240122235757.920225147@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235744.598274724@linuxfoundation.org>
References: <20240122235744.598274724@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Phil Sutter <phil@nwl.cc>

commit 558254b0b602b8605d7246a10cfeb584b1fcabfc upstream.

When cloning a packet-based limit expression, copy the cost value as
well. Otherwise the new limit is not functional anymore.

Fixes: 3b9e2ea6c11bf ("netfilter: nft_limit: move stateful fields out of expression data")
Signed-off-by: Phil Sutter <phil@nwl.cc>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/nft_limit.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/netfilter/nft_limit.c
+++ b/net/netfilter/nft_limit.c
@@ -218,6 +218,8 @@ static int nft_limit_pkts_clone(struct n
 	struct nft_limit_priv_pkts *priv_dst = nft_expr_priv(dst);
 	struct nft_limit_priv_pkts *priv_src = nft_expr_priv(src);
 
+	priv_dst->cost = priv_src->cost;
+
 	return nft_limit_clone(&priv_dst->limit, &priv_src->limit);
 }
 



