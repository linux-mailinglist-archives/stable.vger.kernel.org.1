Return-Path: <stable+bounces-137635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA14AA142C
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BC29164852
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F743248889;
	Tue, 29 Apr 2025 17:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R53t5lyX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46ACE24728A;
	Tue, 29 Apr 2025 17:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745946664; cv=none; b=mGNgrxAgkGYJ7E+SpVkw/yD0qWi638hS6BvwTaBLjLpqDRhBV7SHbkafj3K9HFY27Bt+rJ+YIMYa/RxLItdrlMx+UCxvhtpv3bzooLQNW1SEzTJdYGpSaIOcDanSesnj1lBfCoCHIZrbtbfHTd6yntpuy8seEJeKYM9EnckE1uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745946664; c=relaxed/simple;
	bh=zjbgyquNh/6HHLZN2UghOSiJiy0NAJDBcKD2ZaNASg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wp7sTNv5H2iBZxcltmaadYQp2RaEwOCuJYgwRmaZ6oxZinbDx9t+PX/U2pTcN4RNI+Hx7F5iPImTELyJ5vOlY0n/Z6Kw5CPgrHI1joui/Znpjuq6TB5J0nKhvfWYPAvsn20Ox6AxoOuM8C/Di63NkbmrgcY5N1rdQV5FvvChLIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R53t5lyX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E46C4CEE3;
	Tue, 29 Apr 2025 17:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745946664;
	bh=zjbgyquNh/6HHLZN2UghOSiJiy0NAJDBcKD2ZaNASg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R53t5lyXKVmwVj7AxIdIEdyoYIfmKHxLK5Kmpg3hVluMSipMgwXe3nQuxzbAEruIb
	 jTMKeuyvhHHwDvgUAeuVY/ZSqUZkcmtvWAV5sMSQ0sHJgkqe1nZDjKdVEnDpVBEtlR
	 8obaFsicX+gPlFKr6Wa+PN8RQVzZTQeOkalwY8nw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Kral <d.kral@proxmox.com>,
	Niklas Cassel <cassel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 028/286] ahci: add PCI ID for Marvell 88SE9215 SATA Controller
Date: Tue, 29 Apr 2025 18:38:52 +0200
Message-ID: <20250429161109.016377123@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161107.848008295@linuxfoundation.org>
References: <20250429161107.848008295@linuxfoundation.org>
User-Agent: quilt/0.68
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
index 04b53bb7a692d..2bb9555663e75 100644
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
 	{ PCI_DEVICE(PCI_VENDOR_ID_TTI, 0x0642), /* highpoint rocketraid 642L */
-- 
2.39.5




