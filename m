Return-Path: <stable+bounces-197081-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BF0C8DBFB
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 11:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FC6D3AABA2
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 10:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0861F32C312;
	Thu, 27 Nov 2025 10:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="rSpNp9b1"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A6A32B9A3
	for <stable@vger.kernel.org>; Thu, 27 Nov 2025 10:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764239194; cv=none; b=dYbKndnpi+T8XQ5He8kdv8SHQwqQ6w870yu57Rt8R6tYt414V4pJN43fZyyC4GokPUao6mDvYSZuGemcUn5UQR3FkbkcI74287gxV673reGUP1kZSIWb97P/itDv578SHmRBafcXrJ8KjBSulyAfe49+Abad8A+nMb0Z32NHo5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764239194; c=relaxed/simple;
	bh=kUSasBOmdwFyT9fWFND+kLjGho8+xX6yoJjLmmVzJ1o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eylojKzC38NikegAa8q7JibGCZNUpwINHuEQyha1JajvsAGI8dgZS7GZuB4Ny8vx0CVQpuxceq9cUkm7t1FYDZufByxEXfofYnMnvuB9KCS2MTPTL2MOWrs6vYMESYfgl1y6v1J1yzzYbHSiZb/fV5hp+MtHAgV+CNBNrglcznU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=rSpNp9b1; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id E49EAC16A1B;
	Thu, 27 Nov 2025 10:26:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AE8666068C;
	Thu, 27 Nov 2025 10:26:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F2509102F08C5;
	Thu, 27 Nov 2025 11:26:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764239189; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=7l63rVxiRGiq7jCcyfTKLymE10grTK2AkGEoW3SZhHA=;
	b=rSpNp9b19kpjD7XE6qxhu1DWOp8N/32yB8SHXNyQAl6gZc/TuusDfoaZoU9z48ntFHryXV
	mYxnVm37fkMFQRz1BcyNBpRd2iGa+wdDKbKNJ2o++RJ080Qd9t8ZAW2sOQe0jIJZQNphV+
	i7+9WVvNROgbOEXrPhx+vl45lcoioyxwNIPiaGk/Q1Doztz7TpsYf/mAAmmuu8rY89LxYW
	KGaXfZ487B7fLe+tJuxHnXo009d+pXv8PutZ8FW7Dk1RhiMsqKV+5QzgDBN425vJCdb+BB
	OEtS9zaqrDQH7lgHSvZx9rON2oZuSbQycSuedMIKZ2faYOUCdTqpB3gwPtEJng==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH v2 0/2] phy: rockchip: inno-usb2: fix gadget mode
 disconnection after 6 seconds
Date: Thu, 27 Nov 2025 11:26:15 +0100
Message-Id: <20251127-rk3308-fix-usb-gadget-phy-disconnect-v2-0-dac8a02cd2ca@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEcnKGkC/43NTQ6CMBCG4auQrh3TDpKiK+9hWNA/mKgtaSuRE
 O5uJR7A5TvJfM/Kko1kE7tUK4t2pkTBl8BDxfTY+8ECmdIMOTZcihbiva55C47e8EoKht4MNsM
 0LmAo6eC91RmMNFYKp7BVJ1ampmjLw87cutIjpRzisquz+F5/AOJ/wCyAA9bnVqLjjRPyqkLID
 /JHHZ6s27btAwt0iRLaAAAA
X-Change-ID: 20250718-rk3308-fix-usb-gadget-phy-disconnect-d7de71fb28b4
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, William Wu <wulf@rock-chips.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, 
 Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>, 
 Alan Stern <stern@rowland.harvard.edu>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 =?utf-8?q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

The USB OTG port of the RK3308 exibits a bug when:

 - configured as peripheral, and
 - used in gadget mode, and
 - the USB cable is connected since before booting

The symptom is: about 6 seconds after configuring gadget mode the device is
disconnected and then re-enumerated. This happens only once per boot.

Investigation showed that in this configuration the charger detection code
turns off the PHY after 6 seconds. Patch 1 avoids this when a cable is
connected (VBUS present).

After patch 1 the connection is stable but communication stops after 6
seconds. this is addressed by patch 2.

The topic had been discussed in [0]. Thanks Alan and Minas for the
discussion and Louis for having found the 1st issue, leading to patch 1.

[0] https://lore.kernel.org/lkml/20250414185458.7767aabc@booty/

Luca

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Changes in v2:
- Patch 1: Fixed Co-developed-by: and SoB line order
- Added missing Cc: stable@vger.kernel.org
- Added Théo's Reviewed-by
- Improved commit message
- Patch 2: trimmed discussion about "there is no disconnection" from
  commit message to not distract from the actual issue (writes to
  chg_det.opmode)
- Link to v1: https://lore.kernel.org/r/20250722-rk3308-fix-usb-gadget-phy-disconnect-v1-0-239872f05f17@bootlin.com

---
Louis Chauvet (1):
      phy: rockchip: inno-usb2: fix disconnection in gadget mode

Luca Ceresoli (1):
      phy: rockchip: inno-usb2: fix communication disruption in gadget mode

 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)
---
base-commit: cabb748c4b98ef67bbb088be61a2e0c850ebf70d
change-id: 20250718-rk3308-fix-usb-gadget-phy-disconnect-d7de71fb28b4

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


