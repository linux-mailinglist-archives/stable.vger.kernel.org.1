Return-Path: <stable+bounces-41149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE578AFA7F
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 23:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D93D3288A2A
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 21:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D44149DF4;
	Tue, 23 Apr 2024 21:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tTw/98kj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585191420BE;
	Tue, 23 Apr 2024 21:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908711; cv=none; b=Xd1WfLoWTEUIfSYWJBJNaqobqwp9hxI+y5PPRJxbJbqzGQ3HhsQ694Q6/Os8zlUxGFJaQjWoaf2LcY9KeB+olt44YKyoHs/3+Q/vAmLNC5aJ9mj5YJMi059tFi1Mx6sf0qkj10BKxULy2IZ0N1ZN2Dl5p+1lc4ISZR8qBlCfMto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908711; c=relaxed/simple;
	bh=7K5JGgVmz37SZc3zBX2Y6RnF3bR5ssC/2JDX9G4/FX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qg2+fuPeNah5fyFvCRCnOeXw859rxez/JyXYhRE7rluJd/oDkJm4NZqNjdzI7OQOQvcgfTb3vOd6d2lx2nGerZUYIcAWAjOw260WsCSQZ84RX0K16g0Yjib/nG9/OPC60xTNfiYrrzD0nzd1M+3xPk5G2tkQmWXO9SntFTt9wtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tTw/98kj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD475C32782;
	Tue, 23 Apr 2024 21:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713908710;
	bh=7K5JGgVmz37SZc3zBX2Y6RnF3bR5ssC/2JDX9G4/FX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tTw/98kjsrR/iqu7chcWkQUiAYrhHxZPxBy7pogC0QuhQ3Xolt3qzSecE02TL2X2C
	 oFO/9LanosyuMK4Pzp3eI56MVs/hkfUFpBzzZmaf/hC2ZSVa097XOAG/TvQSEnUf8i
	 4ZUeJLdoPjYuuS38GU7r2bVejIFfv5eFzWKJ93kE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kelvin Cao <kelvin.cao@microchip.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 067/141] PCI: switchtec: Add support for PCIe Gen5 devices
Date: Tue, 23 Apr 2024 14:38:55 -0700
Message-ID: <20240423213855.409264809@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423213853.356988651@linuxfoundation.org>
References: <20240423213853.356988651@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kelvin Cao <kelvin.cao@microchip.com>

[ Upstream commit 0fb53e64705ae0fabd9593102e0f0e6812968802 ]

Advertise support of Gen5 devices in the driver's device ID table and
add the same IDs for the switchtec quirks. Also update driver code to
accommodate them.

Link: https://lore.kernel.org/r/20230624000003.2315364-3-kelvin.cao@microchip.com
Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/quirks.c           | 36 ++++++++++++++++++++++++++++
 drivers/pci/switch/switchtec.c | 44 ++++++++++++++++++++++++++++++----
 include/linux/switchtec.h      |  1 +
 3 files changed, 77 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 5aca621dd1c22..7e5b3186db78b 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5820,6 +5820,42 @@ SWITCHTEC_QUIRK(0x4428);  /* PSXA 28XG4 */
 SWITCHTEC_QUIRK(0x4552);  /* PAXA 52XG4 */
 SWITCHTEC_QUIRK(0x4536);  /* PAXA 36XG4 */
 SWITCHTEC_QUIRK(0x4528);  /* PAXA 28XG4 */
+SWITCHTEC_QUIRK(0x5000);  /* PFX 100XG5 */
+SWITCHTEC_QUIRK(0x5084);  /* PFX 84XG5 */
+SWITCHTEC_QUIRK(0x5068);  /* PFX 68XG5 */
+SWITCHTEC_QUIRK(0x5052);  /* PFX 52XG5 */
+SWITCHTEC_QUIRK(0x5036);  /* PFX 36XG5 */
+SWITCHTEC_QUIRK(0x5028);  /* PFX 28XG5 */
+SWITCHTEC_QUIRK(0x5100);  /* PSX 100XG5 */
+SWITCHTEC_QUIRK(0x5184);  /* PSX 84XG5 */
+SWITCHTEC_QUIRK(0x5168);  /* PSX 68XG5 */
+SWITCHTEC_QUIRK(0x5152);  /* PSX 52XG5 */
+SWITCHTEC_QUIRK(0x5136);  /* PSX 36XG5 */
+SWITCHTEC_QUIRK(0x5128);  /* PSX 28XG5 */
+SWITCHTEC_QUIRK(0x5200);  /* PAX 100XG5 */
+SWITCHTEC_QUIRK(0x5284);  /* PAX 84XG5 */
+SWITCHTEC_QUIRK(0x5268);  /* PAX 68XG5 */
+SWITCHTEC_QUIRK(0x5252);  /* PAX 52XG5 */
+SWITCHTEC_QUIRK(0x5236);  /* PAX 36XG5 */
+SWITCHTEC_QUIRK(0x5228);  /* PAX 28XG5 */
+SWITCHTEC_QUIRK(0x5300);  /* PFXA 100XG5 */
+SWITCHTEC_QUIRK(0x5384);  /* PFXA 84XG5 */
+SWITCHTEC_QUIRK(0x5368);  /* PFXA 68XG5 */
+SWITCHTEC_QUIRK(0x5352);  /* PFXA 52XG5 */
+SWITCHTEC_QUIRK(0x5336);  /* PFXA 36XG5 */
+SWITCHTEC_QUIRK(0x5328);  /* PFXA 28XG5 */
+SWITCHTEC_QUIRK(0x5400);  /* PSXA 100XG5 */
+SWITCHTEC_QUIRK(0x5484);  /* PSXA 84XG5 */
+SWITCHTEC_QUIRK(0x5468);  /* PSXA 68XG5 */
+SWITCHTEC_QUIRK(0x5452);  /* PSXA 52XG5 */
+SWITCHTEC_QUIRK(0x5436);  /* PSXA 36XG5 */
+SWITCHTEC_QUIRK(0x5428);  /* PSXA 28XG5 */
+SWITCHTEC_QUIRK(0x5500);  /* PAXA 100XG5 */
+SWITCHTEC_QUIRK(0x5584);  /* PAXA 84XG5 */
+SWITCHTEC_QUIRK(0x5568);  /* PAXA 68XG5 */
+SWITCHTEC_QUIRK(0x5552);  /* PAXA 52XG5 */
+SWITCHTEC_QUIRK(0x5536);  /* PAXA 36XG5 */
+SWITCHTEC_QUIRK(0x5528);  /* PAXA 28XG5 */
 
 /*
  * The PLX NTB uses devfn proxy IDs to move TLPs between NT endpoints.
diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index f0322e9dbee93..332af6938d7fd 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -372,7 +372,7 @@ static ssize_t field ## _show(struct device *dev, \
 	if (stdev->gen == SWITCHTEC_GEN3) \
 		return io_string_show(buf, &si->gen3.field, \
 				      sizeof(si->gen3.field)); \
-	else if (stdev->gen == SWITCHTEC_GEN4) \
+	else if (stdev->gen >= SWITCHTEC_GEN4) \
 		return io_string_show(buf, &si->gen4.field, \
 				      sizeof(si->gen4.field)); \
 	else \
@@ -663,7 +663,7 @@ static int ioctl_flash_info(struct switchtec_dev *stdev,
 	if (stdev->gen == SWITCHTEC_GEN3) {
 		info.flash_length = ioread32(&fi->gen3.flash_length);
 		info.num_partitions = SWITCHTEC_NUM_PARTITIONS_GEN3;
-	} else if (stdev->gen == SWITCHTEC_GEN4) {
+	} else if (stdev->gen >= SWITCHTEC_GEN4) {
 		info.flash_length = ioread32(&fi->gen4.flash_length);
 		info.num_partitions = SWITCHTEC_NUM_PARTITIONS_GEN4;
 	} else {
@@ -870,7 +870,7 @@ static int ioctl_flash_part_info(struct switchtec_dev *stdev,
 		ret = flash_part_info_gen3(stdev, &info);
 		if (ret)
 			return ret;
-	} else if (stdev->gen == SWITCHTEC_GEN4) {
+	} else if (stdev->gen >= SWITCHTEC_GEN4) {
 		ret = flash_part_info_gen4(stdev, &info);
 		if (ret)
 			return ret;
@@ -1606,7 +1606,7 @@ static int switchtec_init_pci(struct switchtec_dev *stdev,
 
 	if (stdev->gen == SWITCHTEC_GEN3)
 		part_id = &stdev->mmio_sys_info->gen3.partition_id;
-	else if (stdev->gen == SWITCHTEC_GEN4)
+	else if (stdev->gen >= SWITCHTEC_GEN4)
 		part_id = &stdev->mmio_sys_info->gen4.partition_id;
 	else
 		return -EOPNOTSUPP;
@@ -1797,6 +1797,42 @@ static const struct pci_device_id switchtec_pci_tbl[] = {
 	SWITCHTEC_PCI_DEVICE(0x4552, SWITCHTEC_GEN4),  /* PAXA 52XG4 */
 	SWITCHTEC_PCI_DEVICE(0x4536, SWITCHTEC_GEN4),  /* PAXA 36XG4 */
 	SWITCHTEC_PCI_DEVICE(0x4528, SWITCHTEC_GEN4),  /* PAXA 28XG4 */
+	SWITCHTEC_PCI_DEVICE(0x5000, SWITCHTEC_GEN5),  /* PFX 100XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5084, SWITCHTEC_GEN5),  /* PFX 84XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5068, SWITCHTEC_GEN5),  /* PFX 68XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5052, SWITCHTEC_GEN5),  /* PFX 52XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5036, SWITCHTEC_GEN5),  /* PFX 36XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5028, SWITCHTEC_GEN5),  /* PFX 28XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5100, SWITCHTEC_GEN5),  /* PSX 100XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5184, SWITCHTEC_GEN5),  /* PSX 84XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5168, SWITCHTEC_GEN5),  /* PSX 68XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5152, SWITCHTEC_GEN5),  /* PSX 52XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5136, SWITCHTEC_GEN5),  /* PSX 36XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5128, SWITCHTEC_GEN5),  /* PSX 28XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5200, SWITCHTEC_GEN5),  /* PAX 100XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5284, SWITCHTEC_GEN5),  /* PAX 84XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5268, SWITCHTEC_GEN5),  /* PAX 68XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5252, SWITCHTEC_GEN5),  /* PAX 52XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5236, SWITCHTEC_GEN5),  /* PAX 36XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5228, SWITCHTEC_GEN5),  /* PAX 28XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5300, SWITCHTEC_GEN5),  /* PFXA 100XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5384, SWITCHTEC_GEN5),  /* PFXA 84XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5368, SWITCHTEC_GEN5),  /* PFXA 68XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5352, SWITCHTEC_GEN5),  /* PFXA 52XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5336, SWITCHTEC_GEN5),  /* PFXA 36XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5328, SWITCHTEC_GEN5),  /* PFXA 28XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5400, SWITCHTEC_GEN5),  /* PSXA 100XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5484, SWITCHTEC_GEN5),  /* PSXA 84XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5468, SWITCHTEC_GEN5),  /* PSXA 68XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5452, SWITCHTEC_GEN5),  /* PSXA 52XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5436, SWITCHTEC_GEN5),  /* PSXA 36XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5428, SWITCHTEC_GEN5),  /* PSXA 28XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5500, SWITCHTEC_GEN5),  /* PAXA 100XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5584, SWITCHTEC_GEN5),  /* PAXA 84XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5568, SWITCHTEC_GEN5),  /* PAXA 68XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5552, SWITCHTEC_GEN5),  /* PAXA 52XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5536, SWITCHTEC_GEN5),  /* PAXA 36XG5 */
+	SWITCHTEC_PCI_DEVICE(0x5528, SWITCHTEC_GEN5),  /* PAXA 28XG5 */
 	{0}
 };
 MODULE_DEVICE_TABLE(pci, switchtec_pci_tbl);
diff --git a/include/linux/switchtec.h b/include/linux/switchtec.h
index 48fabe36509ee..8d8fac1626bd9 100644
--- a/include/linux/switchtec.h
+++ b/include/linux/switchtec.h
@@ -41,6 +41,7 @@ enum {
 enum switchtec_gen {
 	SWITCHTEC_GEN3,
 	SWITCHTEC_GEN4,
+	SWITCHTEC_GEN5,
 };
 
 struct mrpc_regs {
-- 
2.43.0




