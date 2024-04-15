Return-Path: <stable+bounces-39499-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 128EC8A51DD
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 15:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43DD91C21EC4
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 13:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A5477F2F;
	Mon, 15 Apr 2024 13:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXNgDDoR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE433768EE
	for <stable@vger.kernel.org>; Mon, 15 Apr 2024 13:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713188301; cv=none; b=Xc0wpLR5B+XMPiLelQYvoFJ/8Gm8qE/eazwpGa3T/YRfNY7dRf96aEup2gBgOeijQB5L/jvOgwnPqZW8SxNroF41VRz5Wq5Whc5rD/Dfu4NuNio/DBz8SrNBDhmDZ7L2YoGb6oePXhl7kRjsX5Kp1H3aFwAcOSvhqrknPGAAItY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713188301; c=relaxed/simple;
	bh=AEJrL9fs9hhYzJlG+EEmwRfOyGn7q1tM9HwcU8qGxbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n7VZ5sQptltQ3ardFBO53gVBi97Mt9ArO/xLb76JqLIF2hj2jk/H4xsnk0K6A5JXpFGkZhtDve+WIzYJfUC6VsgmbDxrN+HbyCRWksj/vhD0b04W1+NL0zaZDnhhdtGr9hJXxauG5kthq4tb1fd98hDT7ZaVb3FuIRUefs9mztI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXNgDDoR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3D37C4AF07;
	Mon, 15 Apr 2024 13:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713188301;
	bh=AEJrL9fs9hhYzJlG+EEmwRfOyGn7q1tM9HwcU8qGxbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OXNgDDoR7ye7uKG3l2Uv0Ns69xb/HNfTtlKwJafA2uQ2+SXDfXEn2QRI8rBdduVpw
	 BCjjQ8F65A869ETmuyQjJZ388BpWaaJjvJsv7UOwD8ho9WXGQFLMmlDSczFG6VLdea
	 H5qINgFbCuD2pLrIhMFHFi7w15U6duWuwUbh0poLskaUMOmbUwcLc0o0dPURJqUUiu
	 y4DSn8rwvgGIgA8RJWdK7pJ5K3kKD8OG4id1JR7cK+8HXGBepbD/461K0A3CoG80iC
	 90kJDlbWifQ9B5PxK18onxr/olChOnQlAmHNRbAv5gcthkaZ27i7PT7sAVpvNuZsP9
	 lPrw+8gnM29kw==
From: Sasha Levin <sashal@kernel.org>
To: kernel-lts@openela.org
Cc: Michael Schmitz <schmitzmic@gmail.com>,
	Martin Steigerwald <Martin@lichtvoll.de>,
	stable@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14-openela 009/190] block: fix signed int overflow in Amiga partition support
Date: Mon, 15 Apr 2024 06:48:59 -0400
Message-ID: <20240415105208.3137874-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415105208.3137874-1-sashal@kernel.org>
References: <20240415105208.3137874-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Schmitz <schmitzmic@gmail.com>

[ Upstream commit fc3d092c6bb48d5865fec15ed5b333c12f36288c ]

The Amiga partition parser module uses signed int for partition sector
address and count, which will overflow for disks larger than 1 TB.

Use sector_t as type for sector address and size to allow using disks
up to 2 TB without LBD support, and disks larger than 2 TB with LBD.

This bug was reported originally in 2012, and the fix was created by
the RDB author, Joanne Dow <jdow@earthlink.net>. A patch had been
discussed and reviewed on linux-m68k at that time but never officially
submitted. This patch differs from Joanne's patch only in its use of
sector_t instead of unsigned int. No checking for overflows is done
(see patch 3 of this series for that).

Reported-by: Martin Steigerwald <Martin@lichtvoll.de>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=43511
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Message-ID: <201206192146.09327.Martin@lichtvoll.de>
Cc: <stable@vger.kernel.org> # 5.2
Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
Tested-by: Martin Steigerwald <Martin@lichtvoll.de>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20230620201725.7020-2-schmitzmic@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/partitions/amiga.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/partitions/amiga.c b/block/partitions/amiga.c
index 560936617d9c1..4a4160221183b 100644
--- a/block/partitions/amiga.c
+++ b/block/partitions/amiga.c
@@ -32,7 +32,8 @@ int amiga_partition(struct parsed_partitions *state)
 	unsigned char *data;
 	struct RigidDiskBlock *rdb;
 	struct PartitionBlock *pb;
-	int start_sect, nr_sects, blk, part, res = 0;
+	sector_t start_sect, nr_sects;
+	int blk, part, res = 0;
 	int blksize = 1;	/* Multiplier for disk block size */
 	int slot = 1;
 	char b[BDEVNAME_SIZE];
@@ -100,14 +101,14 @@ int amiga_partition(struct parsed_partitions *state)
 
 		/* Tell Kernel about it */
 
-		nr_sects = (be32_to_cpu(pb->pb_Environment[10]) + 1 -
-			    be32_to_cpu(pb->pb_Environment[9])) *
+		nr_sects = ((sector_t)be32_to_cpu(pb->pb_Environment[10]) + 1 -
+			   be32_to_cpu(pb->pb_Environment[9])) *
 			   be32_to_cpu(pb->pb_Environment[3]) *
 			   be32_to_cpu(pb->pb_Environment[5]) *
 			   blksize;
 		if (!nr_sects)
 			continue;
-		start_sect = be32_to_cpu(pb->pb_Environment[9]) *
+		start_sect = (sector_t)be32_to_cpu(pb->pb_Environment[9]) *
 			     be32_to_cpu(pb->pb_Environment[3]) *
 			     be32_to_cpu(pb->pb_Environment[5]) *
 			     blksize;
-- 
2.43.0


