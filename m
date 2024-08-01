Return-Path: <stable+bounces-65125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F50943EE8
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DD122840BB
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD611DCC7A;
	Thu,  1 Aug 2024 00:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="leqdND5f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8FA1DCC71;
	Thu,  1 Aug 2024 00:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472511; cv=none; b=NkMRzKvAItVuRKWXLeOy3Artcihm4hcSSEFGd87jwnbjXgsFXTt+jut9dFrjpj7l2lknv63sOKtdEL44BdEyGpOp8ndmjgHqNKFSxi8Mh8seOASIlleRqgjPY5nXKMu1u86Jo9L6Z+VDr3C5DzooHblj0R8yeCvU0gIQXkQg188=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472511; c=relaxed/simple;
	bh=PJ5Bu8Sidf4fgx2N6nmI4/cdMaw3CIC5JTQzvB8lQ2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cimlwltoLglOtXxOg+sefOrPDFT/7Kih50et6cct0ChYYU4Ib3RmceC9SHImCpD4vkISSs/oLn+nEE1LZRmFo8FXni5G/5JEo4DDUi9GIZR84UnPK46J34QX7qKGdQoNKMB+aDP9RZ+RXfY2sr2Pm726qldsC+wfN4AXj8RaNaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=leqdND5f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6649C4AF0E;
	Thu,  1 Aug 2024 00:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472511;
	bh=PJ5Bu8Sidf4fgx2N6nmI4/cdMaw3CIC5JTQzvB8lQ2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=leqdND5ftj6xRF7UwSISD7m6pwFvmiLHdjq9P2tG20MomHpcAlaHKk2/69dTOyVqk
	 gQsZ5wQupXnkvBU603ygGQKVUnNv3VEAmvoABNaUlsTuiWj97GLdmUU4DgGh+JhHm+
	 pchKfjLk3ayXDZ1k74Qsdn6vjyhP+vpK9IHYjzJWhV+eqYmyhzvQBMRknRNc++GEh4
	 jgvmcpKzXS6hSFLcM8hgbVz/GoWJavRS19M/y1G/vIyQiUMzcbB0iwjebybXoo9hFv
	 7aouQ0CTBoWBniUJqWHfwUH/XO8yzjkz9ZyKwV+mqjVeQMh/TzAgy6kAyxittNEmQn
	 MeVj1gHBEMmEg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>,
	jack@suse.com
Subject: [PATCH AUTOSEL 5.15 35/47] udf: Avoid excessive partition lengths
Date: Wed, 31 Jul 2024 20:31:25 -0400
Message-ID: <20240801003256.3937416-35-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003256.3937416-1-sashal@kernel.org>
References: <20240801003256.3937416-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
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
index 6b85c66722d3a..ba7b58b2b15aa 100644
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


