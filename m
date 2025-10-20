Return-Path: <stable+bounces-187962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1472BEFCCC
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 10:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BC7F3E601E
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 08:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF261E0DD8;
	Mon, 20 Oct 2025 08:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OK+GgoF7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8055B18C2C
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 08:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760947642; cv=none; b=BQrQQO77IrF+iMoJ8Z8Gx6WbhOVvn2QB4Pz+v71aM4tDpswb0lBlEdacKSGu95IGTFXxk1c7hdj9A4sxjS/BYRYzYj03KzeARE5OC56DpQ39Gy/aOoR1mJUWJXuFMaUR55Kp92K+U9PZ2kkC2lzvF0mk7xtNIZmsweJrEVhxbLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760947642; c=relaxed/simple;
	bh=B1b4jVfXlYerEDUwPyHYd6hg0e2QA1zu25BQqxpCv9w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AsFEMF0R/1vUPMPesTJB8W6OLXZoTaOHAetL/AWrwfXMlrLg4jE9t7w1296G6JLlpL4JVSfeWhU0UbEIbHODk5kDFFH+mqP6WeXgYwFUZki1ASDLDoHowgV//m/ElWfbwtvOxFA7f9MEG34MDvB+rrRuwhaUy4gJNYtg1jVx77U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OK+GgoF7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2718C113D0;
	Mon, 20 Oct 2025 08:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760947641;
	bh=B1b4jVfXlYerEDUwPyHYd6hg0e2QA1zu25BQqxpCv9w=;
	h=Subject:To:Cc:From:Date:From;
	b=OK+GgoF7vApbix4MRbXxpQ/yCQV+gcVVxAyltP3noQOu3RA0CYKgqGu5/LudUnpgl
	 9PZ5D/Q/U7bm3uWYmY8J/q693h8L0jF5gf/H7p3n3qlX+UKQAS4dMNbeOW0OaHqhXC
	 yRRo3Q0o4Gf6W4zNNWMUOBHnob5JYU9lwu7tBppI=
Subject: FAILED: patch "[PATCH] NFSD: Define a proc_layoutcommit for the FlexFiles layout" failed to apply to 6.12-stable tree
To: chuck.lever@oracle.com,loghyr@hammerspace.com,rtm@csail.mit.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Oct 2025 10:07:08 +0200
Message-ID: <2025102008-childlike-sneezing-5892@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 4b47a8601b71ad98833b447d465592d847b4dc77
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025102008-childlike-sneezing-5892@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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


