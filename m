Return-Path: <stable+bounces-83659-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF0899BE60
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 05:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7BA51F22377
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 03:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E2184037;
	Mon, 14 Oct 2024 03:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ucP+sx0p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A35B231CB1;
	Mon, 14 Oct 2024 03:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878254; cv=none; b=gwOzKJiMfK63dccelmXXthvGLRC1nH5rP26S5Srel9wMApwr7AWXlYt2oFIuP1sK9zxB8uqvOZ41q7ND9dQHHNfYzfxDFOU2z4q5sPzvHM+CJhkJZEFdbGwDX20253LRsOVzpoT9uQvgHiTU9nHfTnywfqBbldCJdpNcGJf9w78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878254; c=relaxed/simple;
	bh=GYXpKPChjBmsHJ2a2FlAWCcORGK9OAC1ii9E31wmD5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AIL7VkwoYJxhkld+9lnYtAvPcsBBdZxaWjk01EMlZoT8kwLs7MM6t53alEjHUbM0iY/cJ1CRHvOEvxoO3Z94SU43Kz7H/fRBq1O2GvH6Fx50w7C9B5cYsy0Z/Gv097zK2u2M4Ob9yNbWFbW+5AZxgz5CbSv0lar5/qOx/RTE9PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ucP+sx0p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B70AC4CEC3;
	Mon, 14 Oct 2024 03:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728878254;
	bh=GYXpKPChjBmsHJ2a2FlAWCcORGK9OAC1ii9E31wmD5g=;
	h=From:To:Cc:Subject:Date:From;
	b=ucP+sx0puwqPduD7DZr6EyO7PebVTbmmTWdXYcbFL6C6xL37MDLw5Ljg6VcIrLhQv
	 2WGYvV1PNBhayHj5m8cF1X5g/nZoNAvH0yK7m03i8BV+i3WDit2GChLaI4+UIYFhOw
	 ebDkR47ImyLKBAUhg5YqDN2yQsMH8KCBYVpnoIoBiLUT0DnFdAng9Sp3jwUiIsOktu
	 F4Sn8X6fphASnjzhCdS8QUNtVEsUHx40/dSfK/zRWFD5CF6+OPGG8LoBGT4zYxoFGK
	 V/m47CH+HIQDz62zbAFLUROoYNm+zR/9NP9SWGgDgxxxmNmr1OH1FHJ1ZcpEF69/PU
	 8UOggtNiDc/Xg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: lei lu <llfamsec@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.11 01/20] ntfs3: Add bounds checking to mi_enum_attr()
Date: Sun, 13 Oct 2024 23:57:03 -0400
Message-ID: <20241014035731.2246632-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.3
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


