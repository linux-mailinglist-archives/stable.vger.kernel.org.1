Return-Path: <stable+bounces-36015-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE66A899549
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 08:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83D971F2177B
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 06:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7120225D6;
	Fri,  5 Apr 2024 06:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mPI+L41I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988DE1803D
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 06:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712298444; cv=none; b=NLoVptCI62CDSubgizK4L7RBvyOQp8lahPql/srV9UmfhycQOywGZbxeGg+eDPOlOn8AnV57RJ8lENY20zrROL5I4IWIiUeNcKF5/S+KiFS7F6Y6lNnj2QXpzboDTqPvNwdm5hjt8YJRsIUpxFe6HJj5Rn2Ct9UPXzJM8aYHiWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712298444; c=relaxed/simple;
	bh=iwUbZ0bC5OPLQqTeDR5OesHL+m6IM2EQ/qiTUKcyuiQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ucmxLCiBUXCrnYeIdS8xWj4wnyRSkw8ET5FHx22a5nZoTNvqkikOMC6PnbCFJp0vf552e+7QEONZsacwwEohuK0c0qMP36skXX5uFAzFvVxl0DfXtsYL32zTsek8gJ4iBs/HSniXQergnW+CqLpUqjgiVtscd/RKTGRFj4J/2P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mPI+L41I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087B0C433C7;
	Fri,  5 Apr 2024 06:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712298444;
	bh=iwUbZ0bC5OPLQqTeDR5OesHL+m6IM2EQ/qiTUKcyuiQ=;
	h=Subject:To:Cc:From:Date:From;
	b=mPI+L41IUJKibdxEpPPRumyAHIAzQKp3qhKdSNK444WdrLSwH4JnScpDgFo+4af8x
	 HpbxCjT6bQhZGxJf3vuEkEYwAP62WcA0ym08uGLRkJPC6yyvoZeoQUbZIbdCL5N7wH
	 qeevnZteSGCIeXlhxAkA4JNcGyzVVfEOC6/c+t4g=
Subject: FAILED: patch "[PATCH] netfilter: nf_tables: release mutex after nft_gc_seq_end from" failed to apply to 5.15-stable tree
To: pablo@netfilter.org,hexrabbit@devco.re
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 05 Apr 2024 08:27:13 +0200
Message-ID: <2024040513-earthling-angrily-80da@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 0d459e2ffb541841714839e8228b845458ed3b27
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024040513-earthling-angrily-80da@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0d459e2ffb541841714839e8228b845458ed3b27 Mon Sep 17 00:00:00 2001
From: Pablo Neira Ayuso <pablo@netfilter.org>
Date: Thu, 28 Mar 2024 14:23:55 +0100
Subject: [PATCH] netfilter: nf_tables: release mutex after nft_gc_seq_end from
 abort path

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

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index ffcd3213c335..0d432d0674e1 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -10651,11 +10651,6 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 		nf_tables_abort_release(trans);
 	}
 
-	if (action == NFNL_ABORT_AUTOLOAD)
-		nf_tables_module_autoload(net);
-	else
-		nf_tables_module_autoload_cleanup(net);
-
 	return err;
 }
 
@@ -10672,6 +10667,14 @@ static int nf_tables_abort(struct net *net, struct sk_buff *skb,
 
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


