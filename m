Return-Path: <stable+bounces-107735-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A334A02E13
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 17:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 060B33A53F5
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695891DFE25;
	Mon,  6 Jan 2025 16:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtXwE3v4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6841DFE0F;
	Mon,  6 Jan 2025 16:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736181736; cv=none; b=BpHcca0V/Yj3hs/SP+sTbws3wyDO6Yr6kH7yiBo72u1jOEDFTSaAR5wOsMLBmIR3tzbBaOxjr/2jPYyi3lAS/BuMntkLsc92Ku1l//B4ZHemCZHOARPawWzcWJv3f9VpKqJuYf84DvxNIpngHtVERg89CqUabqbMQxQdjQY3BCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736181736; c=relaxed/simple;
	bh=FDFv5S+ZzONeY4VnWASKegBbzEBRGsdv1rRlgEW29Js=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oKDz+05degIXn6Ehjl6GWJSUekMrky/CFkTsS6oQ6CptLzOjouoZG2KGK/ecmpSmXU8RT+PPjFaiYXUvS9LqL2gDapc/mUCLd2q3MKmtClmexkFL+N/SdpdD/sm97khKAWBGN6Fzo6/lKPUrrSllBSAmW3MmV1ta1LncLT63pjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtXwE3v4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0619C4CED2;
	Mon,  6 Jan 2025 16:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736181735;
	bh=FDFv5S+ZzONeY4VnWASKegBbzEBRGsdv1rRlgEW29Js=;
	h=From:To:Cc:Subject:Date:From;
	b=PtXwE3v4TOTkBRgBupVbDx4H9CbEQEkv6UJ86TfhE9W6QWB2DO6+JblhhkEkqX0eo
	 TP+R4oth7qUjwEnk9e/3s+u2Rzo21s5d2PAVQHbL9+XP6P3l+j9rZIaup9UrGG8kxz
	 c5hWqQt1weZmJUIeaY3hnA35u/NNw65QeL5qcQu+Wvns/Vvtp8v8BhlqAPiNY+8j5u
	 PVZjTOh6eFBET5tNQdZAezGjdJ5dn8myjJ/NGVGI7IJR//7Z/3AbDI5gyT+ledaTRC
	 gpk6l9EwXLKTfNElOMx7WlvB2L8aqDJs/19DmnzesiNpWqluMkQ08RmkrR9yQFGcCa
	 Dor/qGGjFolDg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15] nvmet: propagate npwg topology
Date: Mon,  6 Jan 2025 11:42:13 -0500
Message-Id: <20250106164213.1122374-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.175
Content-Transfer-Encoding: 8bit

From: Luis Chamberlain <mcgrof@kernel.org>

[ Upstream commit b579d6fdc3a9149bb4d2b3133cc0767130ed13e6 ]

Ensure we propagate npwg to the target as well instead
of assuming its the same logical blocks per physical block.

This ensures devices with large IUs information properly
propagated on the target.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/io-cmd-bdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 0fc2781ab970..58da949696c2 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -36,7 +36,7 @@ void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
 	 */
 	id->nsfeat |= 1 << 4;
 	/* NPWG = Namespace Preferred Write Granularity. 0's based */
-	id->npwg = lpp0b;
+	id->npwg = to0based(bdev_io_min(bdev) / bdev_logical_block_size(bdev));
 	/* NPWA = Namespace Preferred Write Alignment. 0's based */
 	id->npwa = id->npwg;
 	/* NPDG = Namespace Preferred Deallocate Granularity. 0's based */
-- 
2.39.5


