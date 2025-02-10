Return-Path: <stable+bounces-114643-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F43CA2F0DF
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 16:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 193A5160CB1
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 15:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE6C20485F;
	Mon, 10 Feb 2025 15:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lpeU97Fn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6B976410
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 15:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739199802; cv=none; b=owXR0oa8nh2LG7QP/gWEHq+dDKfdQhJ5j8zUw5sIotE4r5Np5V9WjfoIgf03uDles2AzOV3IiBBLMvyByxJiot7YUJB1PFwInYCZSuUpWC2ylNjoUO3sUJG1D5gFP2FsaE2vnybawqRB3DmboTethW9OVa0KG3Avh4Z863wBFtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739199802; c=relaxed/simple;
	bh=mHspZemBjKSuLxivUAvqeDi+ma9vd/n1Mr0dkx0iWsg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=X4KvH7jdVv6REdhQVjM9O/KKTQ9mRPr+nJFNGviHtb/ob3oxy8vBQEKVZ/WAy83YlSFVPJ7FRZv4i9ALTewS64gDIyEtSIro44FLXPHQcfWns5rOIEePTAhJGE+hsys6O70HJm14cN7lGaUcTdEFUd2Fy+EzOAW6kMjQmbOTNAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lpeU97Fn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC807C4CED1;
	Mon, 10 Feb 2025 15:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739199802;
	bh=mHspZemBjKSuLxivUAvqeDi+ma9vd/n1Mr0dkx0iWsg=;
	h=Subject:To:Cc:From:Date:From;
	b=lpeU97FnFesB7nR7pihKA0qeEyFFUjpZdu+FWE59sb7kiXgvqHoEZlslKH5gS+3iL
	 y4RUyQtF5Gec3rBlM0/OSiZjrUhjwchupACZQO7Kjyoqh+WTgHfl35EVfz8HxHpAlR
	 cv0cWmFdbFSiff5A72+4LUrxasRcsx9ZqZCC7mz8=
Subject: FAILED: patch "[PATCH] xfs: Add error handling for xfs_reflink_cancel_cow_range" failed to apply to 5.10-stable tree
To: vulab@iscas.ac.cn,cem@kernel.org,djwong@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Feb 2025 16:03:14 +0100
Message-ID: <2025021014-dedicate-recycled-1738@gregkh>
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
git cherry-pick -x 26b63bee2f6e711c5a169997fd126fddcfb90848
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021014-dedicate-recycled-1738@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 26b63bee2f6e711c5a169997fd126fddcfb90848 Mon Sep 17 00:00:00 2001
From: Wentao Liang <vulab@iscas.ac.cn>
Date: Fri, 24 Jan 2025 11:45:09 +0800
Subject: [PATCH] xfs: Add error handling for xfs_reflink_cancel_cow_range

In xfs_inactive(), xfs_reflink_cancel_cow_range() is called
without error handling, risking unnoticed failures and
inconsistent behavior compared to other parts of the code.

Fix this issue by adding an error handling for the
xfs_reflink_cancel_cow_range(), improving code robustness.

Fixes: 6231848c3aa5 ("xfs: check for cow blocks before trying to clear them")
Cc: stable@vger.kernel.org # v4.17
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index c95fe1b1de4e..b1f9f156ec88 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -1404,8 +1404,11 @@ xfs_inactive(
 		goto out;
 
 	/* Try to clean out the cow blocks if there are any. */
-	if (xfs_inode_has_cow_data(ip))
-		xfs_reflink_cancel_cow_range(ip, 0, NULLFILEOFF, true);
+	if (xfs_inode_has_cow_data(ip)) {
+		error = xfs_reflink_cancel_cow_range(ip, 0, NULLFILEOFF, true);
+		if (error)
+			goto out;
+	}
 
 	if (VFS_I(ip)->i_nlink != 0) {
 		/*


