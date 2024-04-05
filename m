Return-Path: <stable+bounces-36016-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E5F89954A
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 08:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1D4A1F22FD2
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 06:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B19822EF2;
	Fri,  5 Apr 2024 06:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i9obWVDi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12BA1803D
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 06:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712298448; cv=none; b=i2k4HnvqtCxhu5Tn3HtCVi2f8a1PYOz6HQpxQs23M68snXwhuMhrkfrMdcdoMOUKHopSK8flb19zMsQlJ0oqvHfIJVrLlBYi7GLwQucB5S+m24ZJfAFRziyUdmkhNGMSy+X/1kPdKIWn8Dpl9fOsro0YZkrEfV377ZcY3mdC+UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712298448; c=relaxed/simple;
	bh=xzH/Xlh2ISdYtiQHifd+AMZLvKmpJ9tQnlf4N6vRiYU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Rz9MNJOgpIxDJmgxCx+r+ineS5gUb5hqXwyLcHLu2XAoY8kN6v8aKcJQbkTnjHRJBt5U/suK5OkJPhMuBh8QFdED5TFS8paO23/Xm/aYqkHev6yepOUc8tMpvnidLuNlyY782Ev25zY89KdpL1HjkXTNJ7yhLsBLCAwvg7AQV0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i9obWVDi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65648C433F1;
	Fri,  5 Apr 2024 06:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712298447;
	bh=xzH/Xlh2ISdYtiQHifd+AMZLvKmpJ9tQnlf4N6vRiYU=;
	h=Subject:To:Cc:From:Date:From;
	b=i9obWVDisvjjOWtiy8FxjCrj1xYqgySryt44ga6SFHPa/K/Wecg7Jr5MQO4zNAlCK
	 svIwsmvzDpKEHny1pzNQbk493CNztW9Pph/t4AvwEr3PCkldx5U5zO3MFRlZ7MeUyd
	 IozAoCKa7Qaz/PhqXnE3ex3h7fof8Bp+9HOWQ+P4=
Subject: FAILED: patch "[PATCH] netfilter: nf_tables: release mutex after nft_gc_seq_end from" failed to apply to 5.10-stable tree
To: pablo@netfilter.org,hexrabbit@devco.re
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 05 Apr 2024 08:27:14 +0200
Message-ID: <2024040514-countless-ransack-27a4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 0d459e2ffb541841714839e8228b845458ed3b27
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024040514-countless-ransack-27a4@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


