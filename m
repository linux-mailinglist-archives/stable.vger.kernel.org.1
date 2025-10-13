Return-Path: <stable+bounces-185521-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD40DBD665F
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 23:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0779B18A6B63
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 21:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48262DCC1A;
	Mon, 13 Oct 2025 21:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tyU/xEvs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EBB221F15
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 21:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760391908; cv=none; b=ZwCSgwG5cqp/VOtKp2Nyvjv5+GJbQSqQn1z2qummyBibfV8oWsXyfQptRNKXkgvMB/yjfohUSg9PeE1cuzzEyZkgjH4olb8bLy/DZkzTmzSvxp7saq7Q2JojEwL1bi0BHncy8I1PbZGNqYiWiudSPop97nDkaAw4hKdx7rsZKvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760391908; c=relaxed/simple;
	bh=auI4kF96Ov5mjIOIHXwuNHhvI0RkFNraAXup3IXlDZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oREtVjm+TAbviMNzxcClA3wtxACGsm2lsZjZLVtRfyqxgw+iX3YAP5Jyn2d2cHheo2ndXQej6fo4LerR79P6VaPrUp5iJU67Zu8kCL0YZ4CViAnvbldNfYvkwVxciWN5P0joRVn0q3FYoSHBQL4Ey57QDs7BLdgCEd0A/+6vSAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tyU/xEvs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D06C113D0;
	Mon, 13 Oct 2025 21:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760391907;
	bh=auI4kF96Ov5mjIOIHXwuNHhvI0RkFNraAXup3IXlDZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tyU/xEvsh4qgyzid8+tS5kP9yBRuHn6wOYvz+Diza/pcfGf2prRftPRJz1kKCf/tE
	 r9Z8y9PEp4YVIP9C3qUWAmxecri1XfaGbOmwp7Ct/mZKQolwgFzVqMo286/kJApUVK
	 mzJAmuW3J3Rr8DM3JrBHS0o5yab7zt2FXk3Dh3OtmbSXJ1I/ix78TbeiZejAd4ZAVl
	 k1EYXLfKJGA/MoYyKixbmx4xvh8LNpFYUk+Z7XC4JKTVwWeIk3w5eogWv2YSJToJ+U
	 a1l/751928MJAIsKrPyG5XzfScedPrY4l/wQiF9AY6WYo3T3D+JFEIaZMOuK00NDdz
	 i4Bsw4Awh09mQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Phillip Lougher <phillip@squashfs.org.uk>,
	syzbot+f754e01116421e9754b9@syzkaller.appspotmail.com,
	Amir Goldstein <amir73il@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] Squashfs: reject negative file sizes in squashfs_read_inode()
Date: Mon, 13 Oct 2025 17:45:04 -0400
Message-ID: <20251013214504.3637196-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013214504.3637196-1-sashal@kernel.org>
References: <2025101321-update-disprove-8836@gregkh>
 <20251013214504.3637196-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Lougher <phillip@squashfs.org.uk>

[ Upstream commit 9f1c14c1de1bdde395f6cc893efa4f80a2ae3b2b ]

Syskaller reports a "WARNING in ovl_copy_up_file" in overlayfs.

This warning is ultimately caused because the underlying Squashfs file
system returns a file with a negative file size.

This commit checks for a negative file size and returns EINVAL.

[phillip@squashfs.org.uk: only need to check 64 bit quantity]
  Link: https://lkml.kernel.org/r/20250926222305.110103-1-phillip@squashfs.org.uk
Link: https://lkml.kernel.org/r/20250926215935.107233-1-phillip@squashfs.org.uk
Fixes: 6545b246a2c8 ("Squashfs: inode operations")
Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
Reported-by: syzbot+f754e01116421e9754b9@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68d580e5.a00a0220.303701.0019.GAE@google.com/
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/squashfs/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/squashfs/inode.c b/fs/squashfs/inode.c
index eb6f577154d59..f32db16dc18ba 100644
--- a/fs/squashfs/inode.c
+++ b/fs/squashfs/inode.c
@@ -192,6 +192,10 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 			goto failed_read;
 
 		inode->i_size = le64_to_cpu(sqsh_ino->file_size);
+		if (inode->i_size < 0) {
+			err = -EINVAL;
+			goto failed_read;
+		}
 		frag = le32_to_cpu(sqsh_ino->fragment);
 		if (frag != SQUASHFS_INVALID_FRAG) {
 			/*
-- 
2.51.0


