Return-Path: <stable+bounces-187960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB02BEFCC0
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 10:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9840118933A5
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 08:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796B12BE639;
	Mon, 20 Oct 2025 08:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sMQc/vWc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362C21FAC42
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 08:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760947630; cv=none; b=TAN7Xy9QR2/DFozzizUNeOtoWzPOAuT/CSBei+byZj5iZE8goCAMru4E4gG//gKPfWRwmRMI3Kp7A+lU5JOLjs2y6k0fXS3nVDhpOSTGMUCcKDqSsLaItHEpcilgvIwacfR9HRJRmahaahiGnx5CP+4xIw7jIjuP+BQmN4y+ZwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760947630; c=relaxed/simple;
	bh=xw9Op3TTiO1tSwoz881yeh+qLAtd7uMuaLASgmPYs8Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=a68FzM5QLOAJD2zbhaGSfmArSFMn1cNdfvQlmHCxF3S5M9fHLiBNJ/P5JveViENYFcsUwiSB7p4mBMgQ5j0ZHf5zFa8yrIsPmYzzZFMfyEyIaj1MK9rZuNQRpGLTW87GbzOATAT+HbYrDPGvPGFAzUiEo9sL0MOSFi/9vQSfQBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sMQc/vWc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA14C4CEF9;
	Mon, 20 Oct 2025 08:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760947629;
	bh=xw9Op3TTiO1tSwoz881yeh+qLAtd7uMuaLASgmPYs8Q=;
	h=Subject:To:Cc:From:Date:From;
	b=sMQc/vWcE6DhTNYupoYtKBmB65Hvdmwaa7Ua+iwSh/5C7ZS8/XbvTxZ4alUebX3VT
	 onjkaqgzJ0xmFK6v+giF8SrM66oid8rhUc/YLibkqhkyy/aNJRm+5cHMaVT6BH9btQ
	 wKtvo2/m2AEZfW3csiIPYw+HyMfEI6JY/aWSggeA=
Subject: FAILED: patch "[PATCH] NFSD: Define a proc_layoutcommit for the FlexFiles layout" failed to apply to 6.1-stable tree
To: chuck.lever@oracle.com,loghyr@hammerspace.com,rtm@csail.mit.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Oct 2025 10:07:07 +0200
Message-ID: <2025102006-approach-hesitancy-3614@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 4b47a8601b71ad98833b447d465592d847b4dc77
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025102006-approach-hesitancy-3614@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


