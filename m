Return-Path: <stable+bounces-127798-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0ADAA7ABD4
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01FAE17E0D7
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D88265CDF;
	Thu,  3 Apr 2025 19:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQan5KBa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189F3265CD1;
	Thu,  3 Apr 2025 19:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707116; cv=none; b=D5ezBrbZivTKOrko0FnrhSB9g/4hiFlVBKTB29nUk+FB0nfdRdZmQWp6pLxTesAJShBSE6vOlsaDEvJm9SS5zdI0iHgYWRPgx8Gf3dD/3J/2/Pq1bRSkFtA8kq2W1BnrNLcXvNP0zBhrfiX9UtYRkfDRBa0pXjf+sakVa5QN+vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707116; c=relaxed/simple;
	bh=9k8vfr6NmemNcPHNm8o6NnVcW/uCzL3lFCSf5MFonuA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KWKjhHrBeD/Kto3Yw5Px4Wj9Yc4TuiRlV7esUEPQ1a6OtEDi1+WUt/sN094PXuozmMi4QDrXoMh68hjrXPqkLsBASeBV1REHw2VlPM9M0FwO6A96Y+lBnOm0exri4af+KN34ZFK4GzULCjSyZtmpSTWq2Na1CWlzzKiwjWbDmyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQan5KBa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2551EC4CEE8;
	Thu,  3 Apr 2025 19:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707115;
	bh=9k8vfr6NmemNcPHNm8o6NnVcW/uCzL3lFCSf5MFonuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JQan5KBawCXInKNDl0MDZ/bisGGoUQXF0/VH1pWxmOzc7Kq2DnCEgwPnw3d9ti5/6
	 Uq+QT7EpEbDpKNmTyCTE6LckfxZnMIQ4s2jmk8BjWOm4RjmB1iv3jslYiMSQujFp46
	 ZUIcfQc4DRrRXFmCyEDPWUm/wA+8QHchiuYfD4PzobSzWYnOPNJ4lcOKrEmkQeKJMX
	 +bu31KlbpsHfv+HCBI7uMR9g8mEtnKjz7zPqFfrLqyIe4ldBaZNFlFiuhY5+UH+s4B
	 cFMIdV+9AUZtCQC+PDLi0gdgraZ1IVqM2b35sxrEqbRBWiyduSMpTdnE0hP32prgm/
	 CPjmELmV7hblA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Kral <d.kral@proxmox.com>,
	Niklas Cassel <cassel@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dlemoal@kernel.org,
	linux-ide@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 29/49] ahci: add PCI ID for Marvell 88SE9215 SATA Controller
Date: Thu,  3 Apr 2025 15:03:48 -0400
Message-Id: <20250403190408.2676344-29-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190408.2676344-1-sashal@kernel.org>
References: <20250403190408.2676344-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
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
index 8d27c567be1c1..f4cc57d7a6a65 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -589,6 +589,8 @@ static const struct pci_device_id ahci_pci_tbl[] = {
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


