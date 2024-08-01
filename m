Return-Path: <stable+bounces-65204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18476943FAF
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8A0B280A96
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965051E9AF2;
	Thu,  1 Aug 2024 00:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qU7okuhj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511171E9AEB;
	Thu,  1 Aug 2024 00:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472855; cv=none; b=YLLvCMdKIx/YfvPmSPum4RGoMEEJqqaJbDisx/G5WdDfiS3dQOh4KzavK4A+q6pu5hgotxZ1Ps6brdqlglqH7+ut0kXJ3x0faEBVycUSg7oT73CTMXs96Fi/Hg089nS2K23Oc11/cM9NSmo5jQzLm+g8Q0NQdOjm/xaO6EvxdzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472855; c=relaxed/simple;
	bh=mIiXgnnx25YrOFDqip8rpqIwym2nNNd4VipQ/hvcu1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N4kob2VGRWRB2yjm8MdQ6EZ0l2xwLe0OmV1V551OJnY+LMxkwgD7YMRkfiUelMtj8HybuWbiFek/sJCU2nz1+cMGqigsRyGT03sYGSpdc9l17aiVulL1iNeYb4uL7CwXycjNEqZBaexjQLLO0qvxwvRsftpViP7k0Din5roLKWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qU7okuhj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 826B4C116B1;
	Thu,  1 Aug 2024 00:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472855;
	bh=mIiXgnnx25YrOFDqip8rpqIwym2nNNd4VipQ/hvcu1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qU7okuhjELXVxoibtw9bYqW13btY4/mS1dA6QvFke0kBQtl4EQsnxGkJN7AA1SulG
	 VcL+n8zq6Ni/aVbOey1B0rfwm3w35MyzGIF58oLD/TmNck2PDibKH3CnqUux9GGGjh
	 P1Nmdy0yQKEf2zCAdTeZQr2fQn9W6GXh63jPWt4uomhuvBypxNAh6UX0aQSOpNhuAQ
	 BAIwZW2IhG7wHpHoWhEFF20qk9nCcPrDy+DsWetW9heJzYYap8tK/pWAjjsW87Wthv
	 aDm5EvWj0eLBS61EQ2OLXrwyJKB++A7T/Z3uLuid+rX0HR5kq6CAlSnZ6ZKiXh/tGC
	 fn+VQAZIIqPYw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>,
	jack@suse.com
Subject: [PATCH AUTOSEL 4.19 07/14] udf: Avoid excessive partition lengths
Date: Wed, 31 Jul 2024 20:40:15 -0400
Message-ID: <20240801004037.3939932-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801004037.3939932-1-sashal@kernel.org>
References: <20240801004037.3939932-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.319
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
index bce48a07790cb..077bc40df130e 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -1047,12 +1047,19 @@ static int udf_fill_partdesc_info(struct super_block *sb,
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
@@ -1108,6 +1115,14 @@ static int udf_fill_partdesc_info(struct super_block *sb,
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


