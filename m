Return-Path: <stable+bounces-127881-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A06A7ACC2
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6333B189DB45
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E116128151F;
	Thu,  3 Apr 2025 19:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFnTviiQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9973C28136C;
	Thu,  3 Apr 2025 19:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707302; cv=none; b=gPxVqgiyege/vRA5VH4KDZNoilmk439zGQd03TIqKcRwudP/I3ut3tbzuwRqDMo7EP2hv9VwcYJRXb7I7jJJ16npRkzvz26ldKZPpxlqkqmBXgerUMf/XgmZTayE7JHtkcf5GPP2R8BDiTAA9mUSwDDQkA1jvBKrsUvXXRjGZaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707302; c=relaxed/simple;
	bh=LULJsvR3DNjAfkqsMqTroQWaBYJWcsCdkxB5BToOd1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XBiPbr+ALGl4av1P6SZQa/IBKLbAvcv8HUwpJUwCeT9L9+E6pELZRmiUAv6al70m4DTGhKvjBzTsUTGwk1ana7nohwfx97cG3PDjp2nT09/6vZEEAUjewggFLCW/kf1CoBRurrpIeSPvSIk585TUe1brrSf2VinOGNgEYPBHPGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFnTviiQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3700C4CEE3;
	Thu,  3 Apr 2025 19:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707302;
	bh=LULJsvR3DNjAfkqsMqTroQWaBYJWcsCdkxB5BToOd1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YFnTviiQAp7fTfmD2vZMwTtyZYsfzUGJGrvex8jaSFzfirqEVNkE79nIyrVNFguie
	 tginN3XgK8jMocm1UtROVSPqDcT1pjlCiz2cj4BX1SAR2EnwzjvZLk/SC3Thbj663f
	 YeR6o9dG6YSloKO1aTfcimzF4iAlJxOMKXIahiqnLbgXh809uZoMnBUpY7oEc/ifMF
	 fo254FdIfO6E/bg7c83qrAQ7C6lCyxEbTXkj60kCbwL07i8nZMYlXynjRqbc/9gdPn
	 +FKVa0CIQHZ2DDwqnf5QpEfg+cgGz9n5YIQT2S/Yx4KQHjJqc5W3NBsO0NezR2+kAy
	 og1aA5znz6ovA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Kral <d.kral@proxmox.com>,
	Niklas Cassel <cassel@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dlemoal@kernel.org,
	linux-ide@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 16/26] ahci: add PCI ID for Marvell 88SE9215 SATA Controller
Date: Thu,  3 Apr 2025 15:07:35 -0400
Message-Id: <20250403190745.2677620-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190745.2677620-1-sashal@kernel.org>
References: <20250403190745.2677620-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.85
Content-Transfer-Encoding: 8bit

From: Daniel Kral <d.kral@proxmox.com>

[ Upstream commit 885251dc35767b1c992f6909532ca366c830814a ]

Add support for Marvell Technology Group Ltd. 88SE9215 SATA 6 Gb/s
controller, which is e.g. used in the DAWICONTROL DC-614e RAID bus
controller and was not automatically recognized before.

Tested with a DAWICONTROL DC-614e RAID bus controller.

Signed-off-by: Daniel Kral <d.kral@proxmox.com>
Link: https://lore.kernel.org/r/20250304092030.37108-1-d.kral@proxmox.com
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/ahci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 6e76780fb4308..98104d0b842bd 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -591,6 +591,8 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	  .driver_data = board_ahci_yes_fbs },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x91a3),
 	  .driver_data = board_ahci_yes_fbs },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9215),
+	  .driver_data = board_ahci_yes_fbs },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9230),
 	  .driver_data = board_ahci_yes_fbs },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9235),
-- 
2.39.5


