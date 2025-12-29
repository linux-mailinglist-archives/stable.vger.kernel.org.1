Return-Path: <stable+bounces-203851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA6ACE774D
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 17:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A069230B79B5
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 16:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714E4252917;
	Mon, 29 Dec 2025 16:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CLjLWiaf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4DC9460;
	Mon, 29 Dec 2025 16:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767025347; cv=none; b=H1geRqYmF2U4UiASoNh0Y4FoW/RmqnFYFUA45K3T7j+gduEq2ljn+MGguop0qACOqWY4qx6i4uxiZFX/R/oMKOeqf2J1Xbj7j54LScHT090SEzrZDH5HCs6eYpZHKGWrq1yGofNCaxaJfPNcXh2VtFkHthwZkbuROlhGIdw/Br4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767025347; c=relaxed/simple;
	bh=eIuo+ZlZHCXiOr229MchNZHJCtAjnk29JyM0UxegFcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SfwDBBzoI1b7PzWYP/FfhA3vGl9Q2u26HO9QSpNkTQw/6I5EJIc2Sf+xqYniMqqA0AqQ0Zki1nhxP/3Zk8U+Dw+K15KifcVEMsdteUFfJIwrNRAM9AJUk6Qg2JRX1YnVn7x+jPiBwYpsv7TurwqMwOCT1Wt9EWQzhVaedcrbUwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CLjLWiaf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B632C4CEF7;
	Mon, 29 Dec 2025 16:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767025346;
	bh=eIuo+ZlZHCXiOr229MchNZHJCtAjnk29JyM0UxegFcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CLjLWiafVHwJDO7EtfRqUZ49tpQivkkZ5VtjFUJ3pyG+3qVU/US9nL85F3KUlwlDz
	 jIvGCzbxse69rig3xoRyK1FgEFt05pOfKCxKbbzwEiF2whjtx90Jaynu0yBlZDj3Ni
	 wly6BY1iuZ6gML47iDRM4ROhzrLR9NAF4oi+KPHA=
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
Subject: [PATCH 6.18 182/430] scsi: smartpqi: Add support for Hurray Data new controller PCI device
Date: Mon, 29 Dec 2025 17:09:44 +0100
Message-ID: <20251229160731.056187193@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251229160724.139406961@linuxfoundation.org>
References: <20251229160724.139406961@linuxfoundation.org>
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

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Strahan <David.Strahan@microchip.com>

[ Upstream commit 48e6b7e708029cea451e53a8c16fc8c16039ecdc ]

Add support for new Hurray Data controller.

All entries are in HEX.

Add PCI IDs for Hurray Data controllers:
                                         VID  / DID  / SVID / SDID
                                         ----   ----   ----   ----
                                         9005   028f   207d   4840

Reviewed-by: Scott Benesh <scott.benesh@microchip.com>
Reviewed-by: Scott Teel <scott.teel@microchip.com>
Reviewed-by: Mike McGowen <mike.mcgowen@microchip.com>
Signed-off-by: David Strahan <David.Strahan@microchip.com>
Signed-off-by: Don Brace <don.brace@microchip.com>
Link: https://patch.msgid.link/20251106163823.786828-4-don.brace@microchip.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/smartpqi/smartpqi_init.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index fdc856845a05..98e93900254c 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -10127,6 +10127,10 @@ static const struct pci_device_id pqi_pci_id_table[] = {
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 			       0x207d, 0x4240)
 	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x207d, 0x4840)
+	},
 	{
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 			       PCI_VENDOR_ID_ADVANTECH, 0x8312)
-- 
2.51.0




