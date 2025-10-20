Return-Path: <stable+bounces-187959-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEF4BEFCB1
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 10:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA0033E5F65
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 08:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359722E3AF1;
	Mon, 20 Oct 2025 08:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XmfVZRsy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37631E5714
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 08:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760947587; cv=none; b=GIMhqcb6t2OJc2P1vs7oiXr/OkmaWe2SKA5oovbe18zIyWF4rcJz81JFVNykVzGFhfBywP6GRhDgq6HDX/I4PLG4Dx1FQYYPEO2H1QOTyzQ3d31HixzIpC7BiBbpGDsPzT2MK0xa9+JO1ZAa6gpH0aZlOio4enqp0zuuzGRDrUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760947587; c=relaxed/simple;
	bh=ARcgq1A00Ho2TwWnMUC2+4zW1otzDletZnH4zkkIwZ8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WRWnLjdbrQeu5tGC2SONiqkGtQ/T2WrwwRQPXIylxk888hffZNEuP8s+6p7C24aBmEFD5SejT03Y06+KuFnqfup23k3NDvpyOILneIMkYCJGnXDAn4ggpCF4RKLnEd/bGCtzS3TZo7abvuy5ON6eoPNxj9osqjSr1o5vbOO4kBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XmfVZRsy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0BA2C4CEF9;
	Mon, 20 Oct 2025 08:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760947586;
	bh=ARcgq1A00Ho2TwWnMUC2+4zW1otzDletZnH4zkkIwZ8=;
	h=Subject:To:Cc:From:Date:From;
	b=XmfVZRsy3wt3l2ZS6tOooludRIc90jppG5fQHrKU3ag8DDlxnGPGVuKsIy2dJEjKV
	 i8STRCsBifiYpZPweOdK4hMroKiNeea5Oy1FgWmBKxKf255/1mJkkCSDXarCpFLdg3
	 8jZLjQKtglMImKBfD9LwuVNZiQhmHLFovXBuUU2o=
Subject: FAILED: patch "[PATCH] NFSD: Define a proc_layoutcommit for the FlexFiles layout" failed to apply to 5.15-stable tree
To: chuck.lever@oracle.com,loghyr@hammerspace.com,rtm@csail.mit.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Oct 2025 10:06:23 +0200
Message-ID: <2025102023-trade-spud-e81a@gregkh>
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
git cherry-pick -x 4b47a8601b71ad98833b447d465592d847b4dc77
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025102023-trade-spud-e81a@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4b47a8601b71ad98833b447d465592d847b4dc77 Mon Sep 17 00:00:00 2001
From: Chuck Lever <chuck.lever@oracle.com>
Date: Thu, 11 Sep 2025 11:12:06 -0400
Subject: [PATCH] NFSD: Define a proc_layoutcommit for the FlexFiles layout
 type

Avoid a crash if a pNFS client should happen to send a LAYOUTCOMMIT
operation on a FlexFiles layout.

Reported-by: Robert Morris <rtm@csail.mit.edu>
Closes: https://lore.kernel.org/linux-nfs/152f99b2-ba35-4dec-93a9-4690e625dccd@oracle.com/T/#t
Cc: Thomas Haynes <loghyr@hammerspace.com>
Cc: stable@vger.kernel.org
Fixes: 9b9960a0ca47 ("nfsd: Add a super simple flex file server")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

diff --git a/fs/nfsd/flexfilelayout.c b/fs/nfsd/flexfilelayout.c
index c318cf74e388..0f1a35400cd5 100644
--- a/fs/nfsd/flexfilelayout.c
+++ b/fs/nfsd/flexfilelayout.c
@@ -125,6 +125,13 @@ nfsd4_ff_proc_getdeviceinfo(struct super_block *sb, struct svc_rqst *rqstp,
 	return 0;
 }
 
+static __be32
+nfsd4_ff_proc_layoutcommit(struct inode *inode, struct svc_rqst *rqstp,
+		struct nfsd4_layoutcommit *lcp)
+{
+	return nfs_ok;
+}
+
 const struct nfsd4_layout_ops ff_layout_ops = {
 	.notify_types		=
 			NOTIFY_DEVICEID4_DELETE | NOTIFY_DEVICEID4_CHANGE,
@@ -133,4 +140,5 @@ const struct nfsd4_layout_ops ff_layout_ops = {
 	.encode_getdeviceinfo	= nfsd4_ff_encode_getdeviceinfo,
 	.proc_layoutget		= nfsd4_ff_proc_layoutget,
 	.encode_layoutget	= nfsd4_ff_encode_layoutget,
+	.proc_layoutcommit	= nfsd4_ff_proc_layoutcommit,
 };


