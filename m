Return-Path: <stable+bounces-4641-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80459804B9C
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 08:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AC8128172E
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 07:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C870E33063;
	Tue,  5 Dec 2023 07:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BmX1oDtp"
X-Original-To: stable@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A365C83
	for <stable@vger.kernel.org>; Mon,  4 Dec 2023 23:59:40 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9D827C0007;
	Tue,  5 Dec 2023 07:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701763179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IFopPnr2RTizq0lI60QxnaJpxZBJXLYBiZefDswc5eQ=;
	b=BmX1oDtpRse0RydZAJ5Kzrt2joXf8NkLmAJuOEBa380RYLPLyX8TWkp4SbY+8TnFbd+zZ4
	sit4S/Sjn0evzf/Vi4MLtOc54kiH1190m0/8837lYUa/41WTh0oT7TxNROsQlu/oR7g65T
	saNiq8KHF4kTqOw5XaF0SmnX3naBA65QRNbbp5k42cUYTOixxOQcwbroj2VkCBSZb0Zjsm
	g/s9+tUUR+2tE7f9zdcRSH8u4XBbfRWyBTO4cEDIOWe/Og6pFSsTUj8ngszIDjXfHMrhq/
	UDA1X34XoepOFJpnRIhTwCrXjIWPIoWHUYhO0PFJc4oHbId8SCfziJEzYwPrtA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <michael@walle.cc>,
	<linux-mtd@lists.infradead.org>
Cc: Tomas Winkler <tomas.winkler@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	kernel test robot <lkp@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] mtd: maps: vmu-flash: Fix the (mtd core) switch to ref counters
Date: Tue,  5 Dec 2023 08:59:36 +0100
Message-Id: <20231205075936.13831-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

While switching to ref counters for track mtd devices use, the vmu-flash
driver was forgotten. The reason for reading the ref counter seems
debatable, but let's just fix the build for now.

Fixes: 19bfa9ebebb5 ("mtd: use refcount to prevent corruption")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312022315.79twVRZw-lkp@intel.com/
Cc: stable@vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/maps/vmu-flash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/maps/vmu-flash.c b/drivers/mtd/maps/vmu-flash.c
index a7ec947a3ebb..53019d313db7 100644
--- a/drivers/mtd/maps/vmu-flash.c
+++ b/drivers/mtd/maps/vmu-flash.c
@@ -719,7 +719,7 @@ static int vmu_can_unload(struct maple_device *mdev)
 	card = maple_get_drvdata(mdev);
 	for (x = 0; x < card->partitions; x++) {
 		mtd = &((card->mtd)[x]);
-		if (mtd->usecount > 0)
+		if (kref_read(&mtd->refcnt))
 			return 0;
 	}
 	return 1;
-- 
2.34.1


