Return-Path: <stable+bounces-64919-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AADB943C6D
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05C25285B33
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3915E1BF328;
	Thu,  1 Aug 2024 00:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RX4+BPtb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D6A14C5AE;
	Thu,  1 Aug 2024 00:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471426; cv=none; b=AR7i7qJMTicFbU40JzKN+eFmiLkgyNcYxSjeHhZZHqQoTJNVytedmyrge4uNtW3gp0JikhzqeUCR1MaZy3tvNjtJNRN1OiczSprs3bUIjBkP2X0uS1+siG/wbWsVciE/MJ6a9B8vrh5SyoTD/KnvEoxLPi8tyQUqDsRUnGCc7us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471426; c=relaxed/simple;
	bh=Yl9B4bekSsZJl1S5dXDTfmH5Qepr+jC/AtijGyvIzNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JIgGVScNZVslWlpFcH9lgkTCWTi7wnNRaFsb93CCi5hCDsoqIocC5RoD0Gq+m5fA4Vuq1JcGoQxq3xj6H2hBOFXPQ107zjxmlL33DPNuvy0ob5iDlVhjtg0cjsaVkcaZCm/JUlUyIMiu3Ac43e2SyYa/HJOCTI7PScSIlAa13dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RX4+BPtb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B485CC4AF0F;
	Thu,  1 Aug 2024 00:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471425;
	bh=Yl9B4bekSsZJl1S5dXDTfmH5Qepr+jC/AtijGyvIzNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RX4+BPtb29ks/QznazfD587TUnz/EK9brhC+0RBVTW9NhvcOW7FbJJEb2AIWeCzLw
	 4dIoCVljxP+1NxaHu372/8WXrNOG8NiU8JHxY0WDT2gIar72Xw3CMH4r+9RuBv5v2D
	 /V8IYkaomdIGMfpV07e6+qUtfIWDcF4096gtuxqUfmWkY0lncGaUOSa5+lYZDi/u8c
	 9z7V/m2yM48FO53ZqouvGdjPJluulujg0m1A5MlfDhFjhsRPSfDNiACaT0iR0iqpAa
	 GW+ey7T1QEoJLiqEiqY4hUBmS1m8Wxq3uqyDa86AYCWzCokcnXxHrP7Ky9ri7TsF8n
	 C3tNayhCUatVQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>,
	jack@suse.com
Subject: [PATCH AUTOSEL 6.10 094/121] udf: Avoid excessive partition lengths
Date: Wed, 31 Jul 2024 20:00:32 -0400
Message-ID: <20240801000834.3930818-94-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
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
index 9381a66c6ce58..8411db883cbce 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -1110,12 +1110,19 @@ static int udf_fill_partdesc_info(struct super_block *sb,
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
@@ -1171,6 +1178,14 @@ static int udf_fill_partdesc_info(struct super_block *sb,
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


