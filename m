Return-Path: <stable+bounces-83680-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C78A899BE96
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 06:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D95A280F63
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 04:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466A013CF8E;
	Mon, 14 Oct 2024 03:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNaS8Umm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26B913C81B;
	Mon, 14 Oct 2024 03:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878299; cv=none; b=Q+N200yxq6d8MAgl28Apkkj1BewWriclqxd/IP80dejMi7/rijgMDOR9kDmlTgwRK2oOVbqxro2/V8Du8OJUjTNoEFPREsh7zmS+5dPsil4LutNje+2l9KP4MxscrodCSzzi6i8P8OV/I3AVtPSfBbiZsv4g6pnVUiofHr5kamQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878299; c=relaxed/simple;
	bh=GYXpKPChjBmsHJ2a2FlAWCcORGK9OAC1ii9E31wmD5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GfwzFl7qtMekn2OUjT2nGFHJcIBx2qAZIi8/VqYCfTu5ZXO51RVjBJuGMh3J8iaPWwl28nDn0zmwi4Y1UcLd/jUUJF9eFGhwgkC58YsoGzyXmMItl0LthRT+o5hGas2v10JPtJIltWMyCu2eVknZ1zwDU2MNEaGSiZsBCBYjYYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNaS8Umm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A57FEC4CEC3;
	Mon, 14 Oct 2024 03:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728878297;
	bh=GYXpKPChjBmsHJ2a2FlAWCcORGK9OAC1ii9E31wmD5g=;
	h=From:To:Cc:Subject:Date:From;
	b=ZNaS8Ummrc3XbWMlx6CcK6OwWrGflF2wyYbMp/sLXST3kI1YQys13o9AYNDxC1h8F
	 FTLhGKXAHlhEGd0JmCwquZX8IHSVoB6CNGKSb5HnvT/fWakBHxfXqs3Gxz0YJ4s/OS
	 xjlrcT2TtJUOOVXyKDbuzhyWBB0sbqeEw1XlnoLSjgxzPdzLIL6wqH9EKxx5uobh9O
	 LUiPXr4uKMJRpd1tdTtHdczPVvbPJhF9DiuF8vLlkpv6zcTrsNd4lSsMaW/QaQnrMZ
	 ZgV9D8eDfWX2neMTlr8Mpu1ehu06maJxtARIyjFAkC9zmr9gb1Omc0PkSL1b5nqac9
	 UcSKhTG5ftdIw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: lei lu <llfamsec@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 01/17] ntfs3: Add bounds checking to mi_enum_attr()
Date: Sun, 13 Oct 2024 23:57:51 -0400
Message-ID: <20241014035815.2247153-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.56
Content-Transfer-Encoding: 8bit

From: lei lu <llfamsec@gmail.com>

[ Upstream commit 556bdf27c2dd5c74a9caacbe524b943a6cd42d99 ]

Added bounds checking to make sure that every attr don't stray beyond
valid memory region.

Signed-off-by: lei lu <llfamsec@gmail.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/record.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index 6c76503edc200..2a375247b3c09 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -223,28 +223,19 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 		prev_type = 0;
 		attr = Add2Ptr(rec, off);
 	} else {
-		/* Check if input attr inside record. */
+		/*
+		 * We don't need to check previous attr here. There is
+		 * a bounds checking in the previous round.
+		 */
 		off = PtrOffset(rec, attr);
-		if (off >= used)
-			return NULL;
 
 		asize = le32_to_cpu(attr->size);
-		if (asize < SIZEOF_RESIDENT) {
-			/* Impossible 'cause we should not return such attribute. */
-			return NULL;
-		}
-
-		/* Overflow check. */
-		if (off + asize < off)
-			return NULL;
 
 		prev_type = le32_to_cpu(attr->type);
 		attr = Add2Ptr(attr, asize);
 		off += asize;
 	}
 
-	asize = le32_to_cpu(attr->size);
-
 	/* Can we use the first field (attr->type). */
 	if (off + 8 > used) {
 		static_assert(ALIGN(sizeof(enum ATTR_TYPE), 8) == 8);
@@ -265,6 +256,12 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 	if (t32 < prev_type)
 		return NULL;
 
+	asize = le32_to_cpu(attr->size);
+	if (asize < SIZEOF_RESIDENT) {
+		/* Impossible 'cause we should not return such attribute. */
+		return NULL;
+	}
+
 	/* Check overflow and boundary. */
 	if (off + asize < off || off + asize > used)
 		return NULL;
-- 
2.43.0


