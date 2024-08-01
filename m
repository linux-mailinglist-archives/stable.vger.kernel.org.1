Return-Path: <stable+bounces-65075-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F7D943E16
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4732C1F22673
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C1419EEB4;
	Thu,  1 Aug 2024 00:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SU2WVovm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E780A19E81F;
	Thu,  1 Aug 2024 00:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472257; cv=none; b=kD9hQY8Yt2cZ7uFbvI7sfE/uCmpw90Eh3PdDQictg1W4Bz9ljiaDvAKG1YzdRAx2UJfoWFb/dnDYpUu1MbYEDCqnrvT3ndqdUmhE32vvfdT9sVKX17G9d/bjnbL3znvYg1R6wP79wtvI9rSW7YB2L+rCjorGwTjwX80fJWqVl58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472257; c=relaxed/simple;
	bh=Dhk6FM7Rw9QLpeF9RIf5C6qB9BslZfKULbvsvrkpfec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YqYUzi5SZp4Edsv/dr84uUDZb4ynlONg9PWfGOEXgExkGdrCvLfDRs1eQseQgroPvzPgRLSueHWHrv4l6/SiRyoL+V/i74DDM1lcMuwmoRlaGjGSSnZZOuPnBVBEBEpEIJULRpl2firQXdBugEn9QvG94t2yxFQnLxvtzTIoZO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SU2WVovm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2659BC4AF0C;
	Thu,  1 Aug 2024 00:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472256;
	bh=Dhk6FM7Rw9QLpeF9RIf5C6qB9BslZfKULbvsvrkpfec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SU2WVovmg4k8HVzNr7p7PmwfZU38hM6CLYuB3ahUlA1/7080bzywf9aePXFOVxe7M
	 sLA/qPmXAF1mMnVO70G1Yfa3zKjsQgmjp/3kimNat0+sj+DvHtPEYjHTBXaXSbGgSx
	 PBZq22MpzHzANWZtssl3mAXjYZzi2Q0+8kL7mozmpU6LLCdEybKGR81vO9/w8CUGYB
	 n4/OKaOQr8nMfbSM90895GkdhqBTsTOw2+1lo38jBObTb2kVaNnsq6kdwCmNk8+LuU
	 6wPd69Koqji1Aptr1v52xDLjhIYxeSPwE+PfcDF6mpVBs/fzo9g5fp40gHJo6ezRft
	 jY3LZ+raJccZA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>,
	jack@suse.com
Subject: [PATCH AUTOSEL 6.1 46/61] udf: Avoid excessive partition lengths
Date: Wed, 31 Jul 2024 20:26:04 -0400
Message-ID: <20240801002803.3935985-46-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002803.3935985-1-sashal@kernel.org>
References: <20240801002803.3935985-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
Content-Transfer-Encoding: 8bit

From: Jan Kara <jack@suse.cz>

[ Upstream commit ebbe26fd54a9621994bc16b14f2ba8f84c089693 ]

Avoid mounting filesystems where the partition would overflow the
32-bits used for block number. Also refuse to mount filesystems where
the partition length is so large we cannot safely index bits in a
block bitmap.

Link: https://patch.msgid.link/20240620130403.14731-1-jack@suse.cz
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/udf/super.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/udf/super.c b/fs/udf/super.c
index 6dc9d8dad88eb..f58ce0ba66130 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -1076,12 +1076,19 @@ static int udf_fill_partdesc_info(struct super_block *sb,
 	struct udf_part_map *map;
 	struct udf_sb_info *sbi = UDF_SB(sb);
 	struct partitionHeaderDesc *phd;
+	u32 sum;
 	int err;
 
 	map = &sbi->s_partmaps[p_index];
 
 	map->s_partition_len = le32_to_cpu(p->partitionLength); /* blocks */
 	map->s_partition_root = le32_to_cpu(p->partitionStartingLocation);
+	if (check_add_overflow(map->s_partition_root, map->s_partition_len,
+			       &sum)) {
+		udf_err(sb, "Partition %d has invalid location %u + %u\n",
+			p_index, map->s_partition_root, map->s_partition_len);
+		return -EFSCORRUPTED;
+	}
 
 	if (p->accessType == cpu_to_le32(PD_ACCESS_TYPE_READ_ONLY))
 		map->s_partition_flags |= UDF_PART_FLAG_READ_ONLY;
@@ -1137,6 +1144,14 @@ static int udf_fill_partdesc_info(struct super_block *sb,
 		bitmap->s_extPosition = le32_to_cpu(
 				phd->unallocSpaceBitmap.extPosition);
 		map->s_partition_flags |= UDF_PART_FLAG_UNALLOC_BITMAP;
+		/* Check whether math over bitmap won't overflow. */
+		if (check_add_overflow(map->s_partition_len,
+				       sizeof(struct spaceBitmapDesc) << 3,
+				       &sum)) {
+			udf_err(sb, "Partition %d is too long (%u)\n", p_index,
+				map->s_partition_len);
+			return -EFSCORRUPTED;
+		}
 		udf_debug("unallocSpaceBitmap (part %d) @ %u\n",
 			  p_index, bitmap->s_extPosition);
 	}
-- 
2.43.0


