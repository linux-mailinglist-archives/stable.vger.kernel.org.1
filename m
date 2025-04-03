Return-Path: <stable+bounces-127918-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F534A7AD34
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D94E188573F
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC75429CB31;
	Thu,  3 Apr 2025 19:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DF1MJuQg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885E929CB2A;
	Thu,  3 Apr 2025 19:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707388; cv=none; b=tS+0Non6hYwhljM6uMc04kK4bMGC+Uy7cDdtCwPBca0Yjo9JevVvmuIPSmkazxzaxLzJh8AkFvTK8NMuIQNeK7/13E09/R7rrvJSnnhkWhbzXM4eV8jNGE0IKBS+gFSQ+Cwvf4DpyiD43zPWAgmCri0lZc5dfGqMRanxqCXNYps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707388; c=relaxed/simple;
	bh=DVDSYkX8QcK6aHQm4JKvNqMkTmiW1bPUhQeAxGQEbtE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tbh5jTpXj+NlMgmQmXCbRMlzdXBexGC7CaCw9tKgJFH3QNq/58NjdHLFCGcWA943nTwJSabR/whICXoPiXTjCCFE9+z4oCV6zY13cDxrnEtHEY4aBm7F9SG9TzBgPZCNbNxopbipodbYCjlUdyYs6+WViB0Nt4TcyWBdEHdx2Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DF1MJuQg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 367C8C4CEE3;
	Thu,  3 Apr 2025 19:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707388;
	bh=DVDSYkX8QcK6aHQm4JKvNqMkTmiW1bPUhQeAxGQEbtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DF1MJuQg6niBE0EywnPcKG0sMqOz2mUsUkWgtsURAhTLbq++3y/B7D/XmmHMywdgF
	 DQ63mekE8AcV50lWkj4SkmX2m1CnKX7GCKjvzTPl9eHBURvKH1tyfrmfZop1+0EIGY
	 oM1P71fcBfXec9HY6nBplK2F1llhx9TBIbprDGEasRyIHjfCRNgUwuHc33vPTf3OhR
	 zoYr9dG/cMOVvwhh84+swlbrtQ0lIU5H82JAPSlDj0XLxG18/of3Yx0S2r4XGlpYj4
	 m3KFEr9e3sXWW4dBNIF1bWVxFfbD3SYQWAbvmAG61WvJLnixUuyhj7z6rxjYELG0az
	 bwxBzGSYWcY5A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Kral <d.kral@proxmox.com>,
	Niklas Cassel <cassel@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dlemoal@kernel.org,
	linux-ide@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 09/16] ahci: add PCI ID for Marvell 88SE9215 SATA Controller
Date: Thu,  3 Apr 2025 15:09:17 -0400
Message-Id: <20250403190924.2678291-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190924.2678291-1-sashal@kernel.org>
References: <20250403190924.2678291-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.179
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
index ff5f83c5af00e..408a25956f6e0 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -595,6 +595,8 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	  .driver_data = board_ahci_yes_fbs },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x91a3),
 	  .driver_data = board_ahci_yes_fbs },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9215),
+	  .driver_data = board_ahci_yes_fbs },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9230),
 	  .driver_data = board_ahci_yes_fbs },
 	{ PCI_DEVICE(PCI_VENDOR_ID_TTI, 0x0642), /* highpoint rocketraid 642L */
-- 
2.39.5


