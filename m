Return-Path: <stable+bounces-48111-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DB58FCC7C
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71EB9B26FDD
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C66E1BC06F;
	Wed,  5 Jun 2024 11:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqpozGjA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386C31BC06B;
	Wed,  5 Jun 2024 11:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588564; cv=none; b=n32115CyNNQ/O2IX8Pf9Y8YiNfQDK3Zji9nGatt7gNQPvcgSLVoVb/XvhOqP+p2W6X59lleiZG1JNLYbj336aCQPZSv1E8LU7zAsKS7bsyKbP8htk+1Pi/mYaMPtBoZpIelEWakm4ExqjYdw1PAXaigL7WFSFg1/IZmIA4cbjXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588564; c=relaxed/simple;
	bh=qt56nWNkPEyaYkii4ItmJovPVXzjgXTz0F5q9bi3geY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WwSXb+efIylMDdhLl+wlwVL4SrBn9ATRFj6V5O4r2HQtq7S3AuUjLEuc5jT7PQQa3MTd7alOJP5Or14T0YFAenOJIW10IKOnnmGYjAezolU061SkuQs2X3eis4DdRSn51lyQ7sotf/k7a/Y84QQTXmblG6USIjq3iUzpO1k5zqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HqpozGjA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C73EC3277B;
	Wed,  5 Jun 2024 11:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588564;
	bh=qt56nWNkPEyaYkii4ItmJovPVXzjgXTz0F5q9bi3geY=;
	h=From:To:Cc:Subject:Date:From;
	b=HqpozGjAJ13JSM8pfIMvcafgGEAfIJ2KuyX/MrrS+DOM+07iUwbNM6H1g3kYj8389
	 +gvI4gtATC0UldigBfecaArsFmar4D0f9aOzm1+DxsS3FpMdcOi+kfDr6XUK0nEqNy
	 sJbVYEXwjaoaCAVF/05Eqr9/sV8Z8zkKV4jYsof1l8pryGWXoVpzWKsZzdVAm8O2YD
	 kAweh8C+oUnrEkYUUvgH24R9Ko5W917Sa+zzite/9QP+LxHujegjqNYikcO6LfLx3q
	 TAMuCnhqodU9q+m2aSeDmU3eu8G3L87H7rqRqCix51ojFypqhmg1uV7eMwfG7gvf4w
	 wqWiErphBUyMQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.8 1/6] fs/ntfs3: Mark volume as dirty if xattr is broken
Date: Wed,  5 Jun 2024 07:55:53 -0400
Message-ID: <20240605115602.2964993-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.12
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
index 53e7d1fa036aa..73785dece7a7f 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -219,8 +219,11 @@ static ssize_t ntfs_list_ea(struct ntfs_inode *ni, char *buffer,
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


