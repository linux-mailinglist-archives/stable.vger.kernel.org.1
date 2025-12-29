Return-Path: <stable+bounces-204141-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5E2CE842E
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 23:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EAB19300AB35
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 22:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9B9330D36;
	Mon, 29 Dec 2025 22:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyEdW5U+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585BA2E613A
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 22:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767045820; cv=none; b=AiFpRRPTPC64EP/FaCicHDK8SE5RHF7FocsMJesrlnn92RBrdxlyx14OJcjlgdEFD/Dlav+2Dk1xW7FhHF0OgvPpLSFCKffIcXLJMihRgexMrBRFynGG7WMvpcPD04vbRk2KojArvlqG/RSP9f//BIo7muVB+gA6ybTuVlz0NOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767045820; c=relaxed/simple;
	bh=mhI1P+R7kTuy2fuNQfRln2gu7iyVpKIHKNOFhR8sW4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dt245YILaSBtSiGKtaD5HgwBRl70qS1ieHfRGjtzrR5pDuZ1gsDXNQLIfbT/FG23zPfhM2wgW/2QiIfwlN4xe+j36Ekbsh83HkyQV4239vwuWEDikUOh5RNTSOggMmaGHfZVAyt3C+peHvhMY2y8sT2Y2U1NUTDx3pTTqoA0ThA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyEdW5U+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06999C4CEF7;
	Mon, 29 Dec 2025 22:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767045819;
	bh=mhI1P+R7kTuy2fuNQfRln2gu7iyVpKIHKNOFhR8sW4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GyEdW5U+XhSEurjcnZeqL978Ow5tn+iCQpBZbXnKQu4f2RC/oPb0R+MEvdnqSxQ5x
	 VDCds6pUKY7mDGALnTyWaHGRwYKh7rFACLJHcS3ozOdNnHecp7FCXhLxU+WdL/9lTM
	 gZx0lrxvXJDcX2HlOy4DG2BLAbqz2sUqvrbIcri2plg0cmqnGPTBPEQ3RHg5grOYJO
	 HfnICDAokj11LWLkGwsoARj9aPoYW4Qqw4CRIqcxYNtcscRYAkg0pVLafao9Zi4kx5
	 5Kir65Jr0ZbBPS1DRvYvVj1hE4zw6yUa5KrGjGUXnI96X2Ja6QUTyt5MUO83IeFyMe
	 IAeM47GDIdFTA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Daniel Vacek <neelx@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] btrfs: don't rewrite ret from inode_permission
Date: Mon, 29 Dec 2025 17:03:37 -0500
Message-ID: <20251229220337.1736680-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122955-nephew-flick-11f1@gregkh>
References: <2025122955-nephew-flick-11f1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit 0185c2292c600993199bc6b1f342ad47a9e8c678 ]

In our user safe ino resolve ioctl we'll just turn any ret into -EACCES
from inode_permission().  This is redundant, and could potentially be
wrong if we had an ENOMEM in the security layer or some such other
error, so simply return the actual return value.

Note: The patch was taken from v5 of fscrypt patchset
(https://lore.kernel.org/linux-btrfs/cover.1706116485.git.josef@toxicpanda.com/)
which was handled over time by various people: Omar Sandoval, Sweet Tea
Dorminy, Josef Bacik.

Fixes: 23d0b79dfaed ("btrfs: Add unprivileged version of ino_lookup ioctl")
CC: stable@vger.kernel.org # 5.4+
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Daniel Vacek <neelx@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
[ add note ]
Signed-off-by: David Sterba <dsterba@suse.com>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/ioctl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index a30379936af5..9b48b9d2d77c 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2897,10 +2897,8 @@ static int btrfs_search_path_in_tree_user(struct user_namespace *mnt_userns,
 			ret = inode_permission(mnt_userns, temp_inode,
 					       MAY_READ | MAY_EXEC);
 			iput(temp_inode);
-			if (ret) {
-				ret = -EACCES;
+			if (ret)
 				goto out_put;
-			}
 
 			if (key.offset == upper_limit.objectid)
 				break;
-- 
2.51.0


