Return-Path: <stable+bounces-82294-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B23A9994C0E
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1F16B22C7E
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643061DE4CD;
	Tue,  8 Oct 2024 12:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eT27LJfY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240CC1DDC06;
	Tue,  8 Oct 2024 12:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728391782; cv=none; b=Ii6gIWk5DsCZSUXQSnj7cpiUzihDTD2YX7cxzVnA7XYcZhEF2nk7h7x0ZIt4fyTgUu1EGSC4BgvCboSwKq3K7OZq2gTmMSavWTiC2VXZSHObHPAEi5BxjRp79qunTmFvsW7zP8WWRkNUTFW+5D23iwwcXlduRQmWDqI/vDxqKaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728391782; c=relaxed/simple;
	bh=Yzgjj59ka3sl9yVB0vb6Jrp3oXjEw6PJLVa4LZmAsPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GiyNw2Hbfj1Fi9YqGJWDv0DJJ1MSmqFuXsrQ/RfGfWnaRlGH2Wl39Fa4UzlAv5ozffFthZEBbGrsqeLN9zIiwcW5xefqkz6+C6fyMg/5oqe/rNtrMcIEPIHYuNFMMf6jRYnyJbJAbliulG5/nO908YAjv4OqXaPcrORwuI/Pja8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eT27LJfY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D543C4CEC7;
	Tue,  8 Oct 2024 12:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728391782;
	bh=Yzgjj59ka3sl9yVB0vb6Jrp3oXjEw6PJLVa4LZmAsPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eT27LJfYNrPbAIBvhT8v5Ths6fTiSkqp+cyQAh8ghypywB9Nj4lPzlu+s21ocSEPB
	 4HdN8fJHpp0fXfm+kRMUFc2ROjzu9VDNnSN4vLdK2ynBtJDpobMs8CH6uKzZ1jArB7
	 Zx/4UHvJUGec0DtfYaSbvDtLRHx9Uq+EOBqP7KAc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Scott Benesh <scott.benesh@microchip.com>,
	Scott Teel <scott.teel@microchip.com>,
	Mike McGowen <mike.mcgowen@microchip.com>,
	David Strahan <David.Strahan@microchip.com>,
	Don Brace <don.brace@microchip.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 221/558] scsi: smartpqi: Add new controller PCI IDs
Date: Tue,  8 Oct 2024 14:04:11 +0200
Message-ID: <20241008115711.040035601@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115702.214071228@linuxfoundation.org>
References: <20241008115702.214071228@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Strahan <David.Strahan@microchip.com>

[ Upstream commit 0e21e73384d324f75ea16f3d622cfc433fa6209b ]

All PCI ID entries in hex.

Add new inagile PCI IDs:
                                             VID  / DID  / SVID / SDID
                                             ----   ----   ----   ----
            SMART-HBA 8242-24i               9005 / 028f / 1ff9 / 0045
            RAID 8236-16i                    9005 / 028f / 1ff9 / 0046
            RAID 8240-24i                    9005 / 028f / 1ff9 / 0047
            SMART-HBA 8238-16i               9005 / 028f / 1ff9 / 0048
            PM8222-SHBA                      9005 / 028f / 1ff9 / 004a
            RAID PM8204-2GB                  9005 / 028f / 1ff9 / 004b
            RAID PM8204-4GB                  9005 / 028f / 1ff9 / 004c
            PM8222-HBA                       9005 / 028f / 1ff9 / 004f
            MT0804M6R                        9005 / 028f / 1ff9 / 0051
            MT0801M6E                        9005 / 028f / 1ff9 / 0052
            MT0808M6R                        9005 / 028f / 1ff9 / 0053
            MT0800M6H                        9005 / 028f / 1ff9 / 0054
            RS0800M5H24i                     9005 / 028f / 1ff9 / 006b
            RS0800M5E8i                      9005 / 028f / 1ff9 / 006c
            RS0800M5H8i                      9005 / 028f / 1ff9 / 006d
            RS0804M5R16i                     9005 / 028f / 1ff9 / 006f
            RS0800M5E24i                     9005 / 028f / 1ff9 / 0070
            RS0800M5H16i                     9005 / 028f / 1ff9 / 0071
            RS0800M5E16i                     9005 / 028f / 1ff9 / 0072
            RT0800M7E                        9005 / 028f / 1ff9 / 0086
            RT0800M7H                        9005 / 028f / 1ff9 / 0087
            RT0804M7R                        9005 / 028f / 1ff9 / 0088
            RT0808M7R                        9005 / 028f / 1ff9 / 0089
            RT1608M6R16i                     9005 / 028f / 1ff9 / 00a1

Add new h3c pci_id:
                                             VID  / DID  / SVID / SDID
                                             ----   ----   ----   ----
            UN RAID P4408-Mr-2               9005 / 028f / 193d / 1110

Add new powerleader pci ids:
                                             VID  / DID  / SVID / SDID
                                             ----   ----   ----   ----
            PL SmartROC PM8204               9005 / 028f / 1f3a / 0104

Reviewed-by: Scott Benesh <scott.benesh@microchip.com>
Reviewed-by: Scott Teel <scott.teel@microchip.com>
Reviewed-by: Mike McGowen <mike.mcgowen@microchip.com>
Signed-off-by: David Strahan <David.Strahan@microchip.com>
Signed-off-by: Don Brace <don.brace@microchip.com>
Link: https://lore.kernel.org/r/20240711194704.982400-2-don.brace@microchip.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/smartpqi/smartpqi_init.c | 104 ++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index c1524fb334eb5..02d16fddd3123 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -9456,6 +9456,10 @@ static const struct pci_device_id pqi_pci_id_table[] = {
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 			       0x193d, 0x110b)
 	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x193d, 0x1110)
+	},
 	{
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 			       0x193d, 0x8460)
@@ -9572,6 +9576,14 @@ static const struct pci_device_id pqi_pci_id_table[] = {
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 			       0x1bd4, 0x0089)
 	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1ff9, 0x00a1)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1f3a, 0x0104)
+	},
 	{
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 			       0x19e5, 0xd227)
@@ -10164,6 +10176,98 @@ static const struct pci_device_id pqi_pci_id_table[] = {
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 			       0x1137, 0x02fa)
 	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1ff9, 0x0045)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1ff9, 0x0046)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1ff9, 0x0047)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1ff9, 0x0048)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1ff9, 0x004a)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1ff9, 0x004b)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1ff9, 0x004c)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1ff9, 0x004f)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1ff9, 0x0051)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1ff9, 0x0052)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1ff9, 0x0053)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1ff9, 0x0054)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1ff9, 0x006b)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1ff9, 0x006c)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1ff9, 0x006d)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1ff9, 0x006f)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1ff9, 0x0070)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1ff9, 0x0071)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1ff9, 0x0072)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1ff9, 0x0086)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1ff9, 0x0087)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1ff9, 0x0088)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1ff9, 0x0089)
+	},
 	{
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 				0x1e93, 0x1000)
-- 
2.43.0




