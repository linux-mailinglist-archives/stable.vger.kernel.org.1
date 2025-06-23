Return-Path: <stable+bounces-156796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A70AE512C
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3604F1B6323A
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AA31EE7C6;
	Mon, 23 Jun 2025 21:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Rtm+JFy1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0E7C2E0;
	Mon, 23 Jun 2025 21:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750714287; cv=none; b=NzSGUDWxuRZSDUII6pTGL4BHE/whq2rU7F6QIgNpMdHg8j3UAjGTUn5eub7yaf+9p0U54mbGNJM+HumyuuQ29iIiOHKpJWpFFzCABe4Aq3eELgRgWeMvkfFN94yYX5mdNKMNYLoBP2fHxFpK7IuWW8t3abmsJ02qBBiVzWf3Ln8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750714287; c=relaxed/simple;
	bh=vxJ14pN7Rrtkp2WI0VIwPGqIwNQyEI7zAwExcPUOcfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dJJov9c7ntJEgyK6nlQ2VeeKVmj6E2wQI1NDLoFGfsTp+JEcBQPJ2wgyI020jfJ+CFUXKBlaIe/+NjbWYFxDoiKhFjROBNbkIJNSuY7rt4N4LfNFWSwVj/Lr+rs08O3TR1PwHmtaEjt2ytb42TrT+v0gRc+6C9hR7cvXDgJVd0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Rtm+JFy1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A21EC4CEEA;
	Mon, 23 Jun 2025 21:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750714286;
	bh=vxJ14pN7Rrtkp2WI0VIwPGqIwNQyEI7zAwExcPUOcfk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rtm+JFy1QTleMn1HUbYExqCihRw7M8gO6RRpaFE3wV9wKMnYKbjZYfY+cvEhpjza0
	 4TIVtwToyak3G3tRym8Nik98cjk9d8L7HxDHlkl8pjZmbzhg+NyL2u6FyZW2lCNFFn
	 fNGgMT1LPNzSZA7xaV3M4cgPX6MowjxGOkHolfJM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Scott Benesh <scott.benesh@microchip.com>,
	Scott Teel <scott.teel@microchip.com>,
	Mike McGowen <mike.mcgowen@microchip.com>,
	David Strahan <david.strahan@microchip.com>,
	Don Brace <don.brace@microchip.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 381/592] scsi: smartpqi: Add new PCI IDs
Date: Mon, 23 Jun 2025 15:05:39 +0200
Message-ID: <20250623130709.501941968@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130700.210182694@linuxfoundation.org>
References: <20250623130700.210182694@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Strahan <david.strahan@microchip.com>

[ Upstream commit 01b8bdddcfab035cf70fd9981cb20593564cd15d ]

Add in support for more PCI devices.

All PCI ID entries in Hex.

Add PCI IDs for Ramaxel controllers:
                                                  VID  / DID  / SVID / SDID
                                                  ----   ----   ----   ----
                      Ramaxel SmartHBA RX8238-16i 9005   028f   1018   8238
                      Ramaxel SSSRAID card        9005   028f   1f3f   0610

Add PCI ID for Alibaba controller:
                                                  VID  / DID  / SVID / SDID
                                                  ----   ----   ----   ----
                      HBA AS1340                  9005   028f   1ded   3301

Add PCI IDs for Inspur controller:
                                                  VID  / DID  / SVID / SDID
                                                  ----   ----   ----   ----
                      RT0800M6E2i                 9005   028f   1bd4   00a3

Add PCI IDs for Delta controllers:
                                                  VID  / DID  / SVID / SDID
                                                  ----   ----   ----   ----
ThinkSystem 4450-8i SAS/SATA/NVMe PCIe Gen4       9005   028f   1d49   0222
24Gb HBA
ThinkSystem 4450-16i SAS/SATA/NVMe PCIe Gen4      9005   028f   1d49   0223
24Gb HBA
ThinkSystem 4450-8e SAS/SATA PCIe Gen4            9005   028f   1d49   0224
24Gb HBA
ThinkSystem RAID 4450-16e PCIe Gen4 24Gb          9005   028f   1d49   0225
Adapter HBA
ThinkSystem RAID 5450-16i PCIe Gen4 24Gb Adapter  9005   028f   1d49   0521
ThinkSystem RAID 9450-8i 4GB Flash PCIe Gen4      9005   028f   1d49   0624
24Gb Adapter
ThinkSystem RAID 9450-16i 4GB Flash PCIe Gen4     9005   028f   1d49   0625
24Gb Adapter
ThinkSystem RAID 9450-16i 4GB Flash PCIe Gen4     9005   028f   1d49   0626
24Gb Adapter
ThinkSystem RAID 9450-32i 8GB Flash PCIe Gen4     9005   028f   1d49   0627
24Gb Adapter
ThinkSystem RAID 9450-16e 4GB Flash PCIe Gen4     9005   028f   1d49   0628
24Gb Adapter

Add PCI ID for Cloudnine Controller:
                                                  VID  / DID  / SVID / SDID
                                                  ----   ----   ----   ----
                      SmartHBA P6600-24i          9005   028f   1f51   100b

Add PCI IDs for Hurraydata Controllers:
                                                  VID  / DID  / SVID / SDID
                                                  ----   ----   ----   ----
                      HRDT TrustHBA H4100-8i      9005   028f   207d   4044
                      HRDT TrustHBA H4100-8e      9005   028f   207d   4054
                      HRDT TrustHBA H4100-16i     9005   028f   207d   4084
                      HRDT TrustHBA H4100-16e     9005   028f   207d   4094
                      HRDT TrustRAID D3152s-8i    9005   028f   207d   4140
                      HRDT TrustRAID D3154s-8i    9005   028f   207d   4240

Reviewed-by: Scott Benesh <scott.benesh@microchip.com>
Reviewed-by: Scott Teel <scott.teel@microchip.com>
Reviewed-by: Mike McGowen <mike.mcgowen@microchip.com>
Signed-off-by: David Strahan <david.strahan@microchip.com>
Signed-off-by: Don Brace <don.brace@microchip.com>
Link: https://lore.kernel.org/r/20250423183229.538572-3-don.brace@microchip.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/smartpqi/smartpqi_init.c | 84 +++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index 6c9dec7e3128f..66c9d1a2c94de 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -9709,6 +9709,10 @@ static const struct pci_device_id pqi_pci_id_table[] = {
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 			       0x1bd4, 0x0089)
 	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+				0x1bd4, 0x00a3)
+	},
 	{
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 			       0x1ff9, 0x00a1)
@@ -10045,6 +10049,30 @@ static const struct pci_device_id pqi_pci_id_table[] = {
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 			       PCI_VENDOR_ID_ADAPTEC2, 0x14f0)
 	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x207d, 0x4044)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x207d, 0x4054)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x207d, 0x4084)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x207d, 0x4094)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x207d, 0x4140)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x207d, 0x4240)
+	},
 	{
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 			       PCI_VENDOR_ID_ADVANTECH, 0x8312)
@@ -10261,6 +10289,14 @@ static const struct pci_device_id pqi_pci_id_table[] = {
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 			       0x1cc4, 0x0201)
 	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1018, 0x8238)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1f3f, 0x0610)
+	},
 	{
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 			       PCI_VENDOR_ID_LENOVO, 0x0220)
@@ -10269,10 +10305,30 @@ static const struct pci_device_id pqi_pci_id_table[] = {
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 			       PCI_VENDOR_ID_LENOVO, 0x0221)
 	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       PCI_VENDOR_ID_LENOVO, 0x0222)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       PCI_VENDOR_ID_LENOVO, 0x0223)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       PCI_VENDOR_ID_LENOVO, 0x0224)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       PCI_VENDOR_ID_LENOVO, 0x0225)
+	},
 	{
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 			       PCI_VENDOR_ID_LENOVO, 0x0520)
 	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       PCI_VENDOR_ID_LENOVO, 0x0521)
+	},
 	{
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 			       PCI_VENDOR_ID_LENOVO, 0x0522)
@@ -10293,6 +10349,26 @@ static const struct pci_device_id pqi_pci_id_table[] = {
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 			       PCI_VENDOR_ID_LENOVO, 0x0623)
 	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       PCI_VENDOR_ID_LENOVO, 0x0624)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       PCI_VENDOR_ID_LENOVO, 0x0625)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       PCI_VENDOR_ID_LENOVO, 0x0626)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       PCI_VENDOR_ID_LENOVO, 0x0627)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       PCI_VENDOR_ID_LENOVO, 0x0628)
+	},
 	{
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 				0x1014, 0x0718)
@@ -10321,6 +10397,10 @@ static const struct pci_device_id pqi_pci_id_table[] = {
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 			       0x1137, 0x0300)
 	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+				0x1ded, 0x3301)
+	},
 	{
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 			       0x1ff9, 0x0045)
@@ -10469,6 +10549,10 @@ static const struct pci_device_id pqi_pci_id_table[] = {
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 				0x1f51, 0x100a)
 	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+				0x1f51, 0x100b)
+	},
 	{
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 			       0x1f51, 0x100e)
-- 
2.39.5




