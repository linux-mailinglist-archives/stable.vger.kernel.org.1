Return-Path: <stable+bounces-3973-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7AD803FFE
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 21:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C9421C20BF7
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 20:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED97C35EEE;
	Mon,  4 Dec 2023 20:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URXhzCAI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A4B35EF8
	for <stable@vger.kernel.org>; Mon,  4 Dec 2023 20:37:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB99C433C8;
	Mon,  4 Dec 2023 20:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701722239;
	bh=oUvZMfuvpl0PchWDdzWfTrAueZEia6/2lB6MnguuzqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=URXhzCAIm7nfCp4ivBMQ+JPw1KsYOyqo3wXBwmT1qW8V7cNU0orEJwIIXBOxGhdLh
	 flOtnJZHWlFkyoEseN+n7Qzkshdvpkz5lTjPM2mlpc7K4M7eB/qGPBMICZgUWD6ify
	 oB2A0CTND6cbiQRf2I29L86Jsd0t265S3dCCfM/nE7sIKIrMtxGLk7waKWPgiJzsXt
	 Ghj71G662QS1gAzL2bQUUmKpykRdmY5Vf9L+az4o+PzMyPmynNrxiCyP2ztds9oU7W
	 ciDUz4Qr581WvISX8Z3puTwnHqZ4PGhHpGMXkAjTErJgEO09tR1zux6FIlsoIiCecA
	 g0U7Wd0T3fMGA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 7/7] nvme-core: check for too small lba shift
Date: Mon,  4 Dec 2023 15:36:50 -0500
Message-ID: <20231204203656.2094777-7-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203656.2094777-1-sashal@kernel.org>
References: <20231204203656.2094777-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.202
Content-Transfer-Encoding: 8bit

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 74fbc88e161424b3b96a22b23a8e3e1edab9d05c ]

The block layer doesn't support logical block sizes smaller than 512
bytes. The nvme spec doesn't support that small either, but the driver
isn't checking to make sure the device responded with usable data.
Failing to catch this will result in a kernel bug, either from a
division by zero when stacking, or a zero length bio.

Reviewed-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 07c41a149328a..30a642c8f5374 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2071,9 +2071,10 @@ static void nvme_update_disk_info(struct gendisk *disk,
 
 	/*
 	 * The block layer can't support LBA sizes larger than the page size
-	 * yet, so catch this early and don't allow block I/O.
+	 * or smaller than a sector size yet, so catch this early and don't
+	 * allow block I/O.
 	 */
-	if (ns->lba_shift > PAGE_SHIFT) {
+	if (ns->lba_shift > PAGE_SHIFT || ns->lba_shift < SECTOR_SHIFT) {
 		capacity = 0;
 		bs = (1 << 9);
 	}
-- 
2.42.0


