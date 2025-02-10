Return-Path: <stable+bounces-114644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7B0A2F0E0
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 16:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48C591889EDF
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 15:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9265B76410;
	Mon, 10 Feb 2025 15:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lK0Ja9dk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5210425291A
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 15:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739199811; cv=none; b=WrIIN44UtRQf0pBXkOqiSqKkQoHZUnv6rfJpWOQW1aq2laUzOPX1q80ccQm2AzyIbxeUjEY7/OdqfdIhAhMQh7PQopAyOV8uguDx8Ha7HTqkgauUtECSUS/dQXP0rb0pnFQElWdeuZWLJF2sintjMRFqsyf05olKcMmkAYA8psY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739199811; c=relaxed/simple;
	bh=lhNqzLJExm9m9OqbC35RI2sXPoZeRQ7qMuuUq+pij5M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=k+ttoOi+7bvdvPl+hS7doa0dn3ld/dcDVXhuql4umtZ+X8nDHW/Yvd/or6HlG9uJbxvUE7NuYDb7RkvEKSsr2wCarbKvx0LPnPho1sXCeQDf4zx/X7zaGyMVNIpPPut3GNnu3R8t27nJKJWKKivVL3v7aV4C043pccEtIHb7dWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lK0Ja9dk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52591C4CED1;
	Mon, 10 Feb 2025 15:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739199810;
	bh=lhNqzLJExm9m9OqbC35RI2sXPoZeRQ7qMuuUq+pij5M=;
	h=Subject:To:Cc:From:Date:From;
	b=lK0Ja9dkKHVSjrikC3vvDW0EtFNP6h09Xe+as0g1ehQAEWX3Ua2uBcR6kPwJnK6Hn
	 pOLYVsCcQVj8kT5ZzRr0Ks0Rq5XdMiJtsK+gx0BqxWhiAbCgpkaj3XUYtpJTCK9Cnb
	 SSggk4Z9OUUJi9+OrEZVet3CgBudYKtGs3Kl9SHs=
Subject: FAILED: patch "[PATCH] xfs: Add error handling for xfs_reflink_cancel_cow_range" failed to apply to 5.4-stable tree
To: vulab@iscas.ac.cn,cem@kernel.org,djwong@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Feb 2025 16:03:19 +0100
Message-ID: <2025021019-constrain-diligent-85b6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 26b63bee2f6e711c5a169997fd126fddcfb90848
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021019-constrain-diligent-85b6@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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


