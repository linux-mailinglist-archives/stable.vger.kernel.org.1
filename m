Return-Path: <stable+bounces-48121-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE4E8FCC9C
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE3DCB2898C
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72F319AD8B;
	Wed,  5 Jun 2024 11:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ssRx4W/z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CF21BE23B;
	Wed,  5 Jun 2024 11:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588593; cv=none; b=qL6QSe4iYvc7kON664YSshPdXjAGBLIVwrhBenIAt1Xg0ODARDQwXFxP9GybqLLMANjnYUIIg3TWfyCOf0Sn05pAkItJ25kjSJzVDr+IPd2OB5e/fQ5HMJhfPVC3V4/A4J6W7f/dMJ/Ct+RBqrNCW+axjc1a3eE/e7d/ET2gkJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588593; c=relaxed/simple;
	bh=ud0KgdxXFmBBJ+h+D1lJUODrVBGzmuTQU7s8hDu5FGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gwGrMdo6IOx15+T27IAfKdvL2AiQC4sZe83/ucWX2BYeJtSkVQX8MxTzCNN0Oe+V4Y3DYizbn6DyKJcGdG0vEKSKahtRJfqyT2AMeUxpSgULzx73rCKU8q3NWWWETuYMgxCTnu7RXu3rz79EyPkhBtub5IayJaJ0k4PnUXs6nyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ssRx4W/z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FBB2C32781;
	Wed,  5 Jun 2024 11:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588593;
	bh=ud0KgdxXFmBBJ+h+D1lJUODrVBGzmuTQU7s8hDu5FGQ=;
	h=From:To:Cc:Subject:Date:From;
	b=ssRx4W/z7w6DT/WG44/1PefD11AjmXyxKc40+7gDojqE2HV+QeogvIMFlITBLidFl
	 oaR6BeVuxniOJ5smBDsjF1slfChZy2uquEWqi2Amj0NoJNpxIirTwOD4k8daxDu92Q
	 +JlMU1Vb/CkVRUjY70mZM2FJjt5ASKQ9DvT69e3wzz+U7vdi9kJETQm/QvUIcE+qcA
	 6ksgLqb2/h1ZX3jTm6eTbmOv7rYlkvjgV3A3C4chutNj2zWT52LQw6Jz5ziWJMNOi3
	 UmAjj1uE+UFrfhoO8CNOv4PdhbYm0upoKb81R4EIe78Xoe2/vaV5WoLWnXNmQ+Al5a
	 4qmSNE6GulLxw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 1/3] fs/ntfs3: Mark volume as dirty if xattr is broken
Date: Wed,  5 Jun 2024 07:56:26 -0400
Message-ID: <20240605115631.2965331-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.92
Content-Transfer-Encoding: 8bit

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 24f6f5020b0b2c89c2cba5ec224547be95f753ee ]

Mark a volume as corrupted if the name length exceeds the space
occupied by ea.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/xattr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index d98cf7b382bcc..2e4eea854bda5 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -217,8 +217,11 @@ static ssize_t ntfs_list_ea(struct ntfs_inode *ni, char *buffer,
 		if (!ea->name_len)
 			break;
 
-		if (ea->name_len > ea_size)
+		if (ea->name_len > ea_size) {
+			ntfs_set_state(ni->mi.sbi, NTFS_DIRTY_ERROR);
+			err = -EINVAL; /* corrupted fs */
 			break;
+		}
 
 		if (buffer) {
 			/* Check if we can use field ea->name */
-- 
2.43.0


