Return-Path: <stable+bounces-65010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7472943D80
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E905D1C221FB
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FF51C8EB2;
	Thu,  1 Aug 2024 00:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CyHgBatX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CCA1C8EAD;
	Thu,  1 Aug 2024 00:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471925; cv=none; b=WZOsChoMqn8nGHrqGxRBvbZyacM9IfRbbC7WHwNjo6mgI5vGTZ0amSXtQPcYDrYkpEwYhyP6+Ar7FUo9BWpIMeM1KgzEg6afsnCgE1IeUmjaFzvLFX0Yxxwa+zboEJ0MVBwlH41qYpgkoLC3F8mVy4u9lQR4YWTJTmN/FcUws4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471925; c=relaxed/simple;
	bh=Vr5h5a+y9D5OPNZjQCD3Ck452V+NvTr0pRbXws/X/Co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OHqoNy6JvT7AtAPjfFH964utUoO4vYWqjAxWAgt8di28aDmSnr/zouHMU8UsdjEFne0U9FgldsCIYacae3UXIUUIa/rl9umehaflriGaOGEeG8I6a9SKQSMl4lpLbuvhjEvGaUp0k7HN3ca8RjAoCGPbkuUdl3f4LxVc1dSHX/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyHgBatX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446C5C32786;
	Thu,  1 Aug 2024 00:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471925;
	bh=Vr5h5a+y9D5OPNZjQCD3Ck452V+NvTr0pRbXws/X/Co=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CyHgBatXXj/1YKucKT4wz+l3Aa39bCijQsfIXCtNHXaztVDgpFB7NXT9JS1Omu4hB
	 jOe1S7IgbWGNQb0lH3025XZqdd+s8bMIIf/aJK4EPEdh3SnfpXbDvLpPU3FqUR7xIO
	 xQECm3dx8cSdtuhvn0XBHgY/WfChd6a1hy1LGnh3PTm8Y+002ZlxCiHyfCuVYJDkZU
	 aPF6q5N5zuaFHKOA6QlJwF18/Q+UYkbN7eDFRbDDjvvPLkIi6h94Ib9dBzD0T1jsda
	 tqyVTEnCHkIOBXX2MK/YhUS8bq7ZSc0wAVIsvH4DeKPg5W/3wM7oXDUuGH6Q5zIq24
	 lcj/Tkc/bUxxA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>,
	jack@suse.com
Subject: [PATCH AUTOSEL 6.6 64/83] udf: Avoid excessive partition lengths
Date: Wed, 31 Jul 2024 20:18:19 -0400
Message-ID: <20240801002107.3934037-64-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002107.3934037-1-sashal@kernel.org>
References: <20240801002107.3934037-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
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
index 928a04d9d9e0a..9416aca543a85 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -1079,12 +1079,19 @@ static int udf_fill_partdesc_info(struct super_block *sb,
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
@@ -1140,6 +1147,14 @@ static int udf_fill_partdesc_info(struct super_block *sb,
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


