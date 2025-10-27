Return-Path: <stable+bounces-190450-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D89F6C10609
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 20:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 83A893486EB
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 19:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E7231B824;
	Mon, 27 Oct 2025 18:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qe1WCQy7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7FC320CA8;
	Mon, 27 Oct 2025 18:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761591323; cv=none; b=QnYTraz+TIDyi7//59+wQeYdgRmqVL2Ku/1xCI58aTaZkYqcS0fBFssL1z/Sxr0hq+IKt80YYr94Xj7TUlwKcgfMknYlzxiSGdWtGOxPfZJeTtb2NSLQJzpY23BCW++4PnloQ2wLdUjjJvmloblq/pvzsI4w7tRQPITzdx9Hy84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761591323; c=relaxed/simple;
	bh=gHPxN0TQvu+sPhRKTvLg0AvvNLgnZViglOz+I/gYfgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IEsm0+oJTM/rQzNEqCryMys1rzUOPhBpy7WskhUkn4CdhAyK5wGDe37QySXjCIJmipAQNlhft8izKqZzeEYCZnzEwFOEfS5kcAvlDN0kSEUFHZ3OR1hnkSsjBLOqwtWdT05xkjR7eKFTpYTcYo1gCxXBeVpO1fYJJ8xw8WwaMjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qe1WCQy7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19904C4CEF1;
	Mon, 27 Oct 2025 18:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761591322;
	bh=gHPxN0TQvu+sPhRKTvLg0AvvNLgnZViglOz+I/gYfgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qe1WCQy7lz5obWIu2bbeCxebPU7FFJCskmQ87IbQ/dkYkNCwrdqmutgaS7J+t8/Ez
	 /cMoh+gFEjgxZyIH0c5Ujnwtl7pjm/CNP8fgqZpmxSBGGsCyEuFJv6iljyOCrJtkI9
	 PCkjCWQ8D2P2kMgd7SE1RCGONNsigA0ohkeXkkDg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Linus Walleij <linus.walleij@linaro.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 5.10 151/332] mtd: rawnand: fsmc: Default to autodetect buswidth
Date: Mon, 27 Oct 2025 19:33:24 +0100
Message-ID: <20251027183528.620440636@linuxfoundation.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251027183524.611456697@linuxfoundation.org>
References: <20251027183524.611456697@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Walleij <linus.walleij@linaro.org>

commit b8df622cf7f6808c85764e681847150ed6d85f3d upstream.

If you don't specify buswidth 2 (16 bits) in the device
tree, FSMC doesn't even probe anymore:

fsmc-nand 10100000.flash: FSMC device partno 090,
  manufacturer 80, revision 00, config 00
nand: device found, Manufacturer ID: 0x20, Chip ID: 0xb1
nand: ST Micro 10100000.flash
nand: bus width 8 instead of 16 bits
nand: No NAND device found
fsmc-nand 10100000.flash: probe with driver fsmc-nand failed
  with error -22

With this patch to use autodetection unless buswidth is
specified, the device is properly detected again:

fsmc-nand 10100000.flash: FSMC device partno 090,
  manufacturer 80, revision 00, config 00
nand: device found, Manufacturer ID: 0x20, Chip ID: 0xb1
nand: ST Micro NAND 128MiB 1,8V 16-bit
nand: 128 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
fsmc-nand 10100000.flash: Using 1-bit HW ECC scheme
Scanning device for bad blocks

I don't know where or how this happened, I think some change
in the nand core.

Cc: stable@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/nand/raw/fsmc_nand.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/mtd/nand/raw/fsmc_nand.c
+++ b/drivers/mtd/nand/raw/fsmc_nand.c
@@ -865,10 +865,14 @@ static int fsmc_nand_probe_config_dt(str
 	if (!of_property_read_u32(np, "bank-width", &val)) {
 		if (val == 2) {
 			nand->options |= NAND_BUSWIDTH_16;
-		} else if (val != 1) {
+		} else if (val == 1) {
+			nand->options |= NAND_BUSWIDTH_AUTO;
+		} else {
 			dev_err(&pdev->dev, "invalid bank-width %u\n", val);
 			return -EINVAL;
 		}
+	} else {
+		nand->options |= NAND_BUSWIDTH_AUTO;
 	}
 
 	if (of_get_property(np, "nand-skip-bbtscan", NULL))



