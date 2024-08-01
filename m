Return-Path: <stable+bounces-65165-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 146CB943F54
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4806281092
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DA21C10E3;
	Thu,  1 Aug 2024 00:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0CQa+Zg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF891C10DB;
	Thu,  1 Aug 2024 00:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472709; cv=none; b=aORiu0RwFq9Pa8iG/oEDQZitOBITSKYM2f2BJSgxVvjDNbZPOouxiMycrWRBzjafN9MJTzXjCdFCmafvZoW5VbDqJEaNVPM9SCcXS8ZlMsSiGT/MMBlsoPdhSLwVV51vvyV+6mfHDVA18pt8f2iPuMh7g5KhO4Zo1mLHoKqdYbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472709; c=relaxed/simple;
	bh=d0QJq9U3/wNyI9o1Og4zAxRhooA1NgbhTuVMJq66esY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nc6sqgpppdEN3xx+ahQiIs95dDbtbIhz1F5wabpIH8Sv6rVcVC3MRW2yZt2lLrRKr5lYXZDRgPfHE2LIv4I/I4FPd7e/1RwKyWpP338bQ7seDEqnz/HX3i3Q9YVMyZSPETgjGqd2zCfIjO4v2JV3evflp8Qi3tvKdHqQkZRD6EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0CQa+Zg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4E5C116B1;
	Thu,  1 Aug 2024 00:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472708;
	bh=d0QJq9U3/wNyI9o1Og4zAxRhooA1NgbhTuVMJq66esY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y0CQa+Zg9sFdSJwOQUK8f1lXz0og9QEbOtoPTlMyK1pFGHI1ag+CDo65J1XZuoH8N
	 WsKusomUsK0136wPP9Jm8k57RXq0WY9WsYGy03dmatlonlWGDEDyP7nsrZi74rGOYa
	 pwbr+MYdWgRj4S+odWKgO3k0rxEL133JAp6M8RxGqLg0kLtVJcU88w1P3MTEZyXb3j
	 7J2LvGs5X8qXUbEtzTxQO3BQVMT99mT++R87gcwZuRKIfNaW1bd+6qwNsi/nFc2jXN
	 vNylCny5dT+uXCltAyJt9Tyh0cU1gmw4dWx8TheCXSQSAqFn+2Es+O3yBdY/QHqifp
	 eIcxsyh/v4c6Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>,
	jack@suse.com
Subject: [PATCH AUTOSEL 5.10 28/38] udf: Avoid excessive partition lengths
Date: Wed, 31 Jul 2024 20:35:34 -0400
Message-ID: <20240801003643.3938534-28-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003643.3938534-1-sashal@kernel.org>
References: <20240801003643.3938534-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.223
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
index 4af9ce34ee804..d5da1bce82731 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -1075,12 +1075,19 @@ static int udf_fill_partdesc_info(struct super_block *sb,
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
@@ -1136,6 +1143,14 @@ static int udf_fill_partdesc_info(struct super_block *sb,
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


