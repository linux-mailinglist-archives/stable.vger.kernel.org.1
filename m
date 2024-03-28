Return-Path: <stable+bounces-26640-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A97A870F78
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 22:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C623C1F22D56
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 21:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E2C78B69;
	Mon,  4 Mar 2024 21:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="08khLDz+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6BB1C6AB;
	Mon,  4 Mar 2024 21:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709589296; cv=none; b=dbaF2VQBcB1rzz0FrXBDDqaMvrlkMZvO8IcZO7VGTKsa3HajDRtdzG5nsfxPtght4FZwMRUkOS58vaaXcD//Ao6DXbbqmr6NEwMluaBYoVzBB39birIfWVpEFxXTEpvl/QSAK670+0kb/Rv8wswZC4A0BjUOFooSP93eC64lrrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709589296; c=relaxed/simple;
	bh=lLTgMcG7ifXW5TB+BEkG/MEyCoZlZo5mnb3XitH4Zc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aSEM5siRNK0fdCx0/3xyi36PwgNQjjcraK5PXs4FDGZCwV5wI1lY31rrZfobJjKLl7OjWfW8iLvMWW60Op/W3r/G4KX2oaBMDfVQQ++kUa/mxF03F1GW5OtbCVso5AVRKIp2yHgj+FaoIQX2MKYlG9KluFir8eCq3qGaQEih/3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=08khLDz+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D1CC433F1;
	Mon,  4 Mar 2024 21:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709589295;
	bh=lLTgMcG7ifXW5TB+BEkG/MEyCoZlZo5mnb3XitH4Zc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=08khLDz+S99ybc5AUjiJDVhXFJeMWmsqOexO10/g7bt9GZyPDHGppP/MXjUGgW3jt
	 PTrghYT7aK+7uVa/P/GkUGDCUMOrHMoixHQ5h4eJ6nAidcw0H/uJH8gpVB8OaNAuw+
	 mDhwK8MM0cE6w/QYZexc+TJcIjznKtXPA3WNMgHk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ivan Semenov <ivan@semenov.dev>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.15 55/84] mmc: core: Fix eMMC initialization with 1-bit bus connection
Date: Mon,  4 Mar 2024 21:24:28 +0000
Message-ID: <20240304211544.206023113@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304211542.332206551@linuxfoundation.org>
References: <20240304211542.332206551@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ivan Semenov <ivan@semenov.dev>

commit ff3206d2186d84e4f77e1378ba1d225633f17b9b upstream.

Initializing an eMMC that's connected via a 1-bit bus is current failing,
if the HW (DT) informs that 4-bit bus is supported. In fact this is a
regression, as we were earlier capable of falling back to 1-bit mode, when
switching to 4/8-bit bus failed. Therefore, let's restore the behaviour.

Log for Samsung eMMC 5.1 chip connected via 1bit bus (only D0 pin)
Before patch:
[134509.044225] mmc0: switch to bus width 4 failed
[134509.044509] mmc0: new high speed MMC card at address 0001
[134509.054594] mmcblk0: mmc0:0001 BGUF4R 29.1 GiB
[134509.281602] mmc0: switch to bus width 4 failed
[134509.282638] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
[134509.282657] Buffer I/O error on dev mmcblk0, logical block 0, async page read
[134509.284598] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
[134509.284602] Buffer I/O error on dev mmcblk0, logical block 0, async page read
[134509.284609] ldm_validate_partition_table(): Disk read failed.
[134509.286495] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
[134509.286500] Buffer I/O error on dev mmcblk0, logical block 0, async page read
[134509.288303] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
[134509.288308] Buffer I/O error on dev mmcblk0, logical block 0, async page read
[134509.289540] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
[134509.289544] Buffer I/O error on dev mmcblk0, logical block 0, async page read
[134509.289553]  mmcblk0: unable to read partition table
[134509.289728] mmcblk0boot0: mmc0:0001 BGUF4R 31.9 MiB
[134509.290283] mmcblk0boot1: mmc0:0001 BGUF4R 31.9 MiB
[134509.294577] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 2
[134509.295835] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
[134509.295841] Buffer I/O error on dev mmcblk0, logical block 0, async page read

After patch:

[134551.089613] mmc0: switch to bus width 4 failed
[134551.090377] mmc0: new high speed MMC card at address 0001
[134551.102271] mmcblk0: mmc0:0001 BGUF4R 29.1 GiB
[134551.113365]  mmcblk0: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15 p16 p17 p18 p19 p20 p21
[134551.114262] mmcblk0boot0: mmc0:0001 BGUF4R 31.9 MiB
[134551.114925] mmcblk0boot1: mmc0:0001 BGUF4R 31.9 MiB

Fixes: 577fb13199b1 ("mmc: rework selection of bus speed mode")
Cc: stable@vger.kernel.org
Signed-off-by: Ivan Semenov <ivan@semenov.dev>
Link: https://lore.kernel.org/r/20240206172845.34316-1-ivan@semenov.dev
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/core/mmc.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1000,10 +1000,12 @@ static int mmc_select_bus_width(struct m
 	static unsigned ext_csd_bits[] = {
 		EXT_CSD_BUS_WIDTH_8,
 		EXT_CSD_BUS_WIDTH_4,
+		EXT_CSD_BUS_WIDTH_1,
 	};
 	static unsigned bus_widths[] = {
 		MMC_BUS_WIDTH_8,
 		MMC_BUS_WIDTH_4,
+		MMC_BUS_WIDTH_1,
 	};
 	struct mmc_host *host = card->host;
 	unsigned idx, bus_width = 0;



