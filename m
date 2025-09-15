Return-Path: <stable+bounces-179626-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD48B57D84
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 15:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9781D16996D
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 13:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE663191D0;
	Mon, 15 Sep 2025 13:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="AsSGvqyl"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F959312830
	for <stable@vger.kernel.org>; Mon, 15 Sep 2025 13:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757943490; cv=none; b=bkBqTCYXI5nFF7AzLeNkGJVIhkMyL6zrBsEziHWn3FcovjFRg6ZJypVP1H8TTZ4NLo2ML1RTHHKA2bYOye6ExZCCk7hXO6T2N7y62DUMJafxdr+/Eigexi9NJ7VOC9l+o2AKAt8E4lCQ7InW3F+YGcGHigvf4Tas/D+PxOxBMl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757943490; c=relaxed/simple;
	bh=BPfPr/EhqGdOAgcaYSl7ChPAovmIh95NjGuHNfkPd7o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TMak85L+6BR4Xo0kiiRGxHwuDYtdkqP1qOI+Ny1XqdfhO+3g/Vvn+qwAj2nBRe4eoO0Sph3GMjr64U7hsBlbGBk/F8wtCMD7DESpXsR9mC6OoSQJqfSpEsehyXyo6vD02nxvAHcqLdvf8IGM9kcJeBf20w3QoK1J9fo581fcGuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=AsSGvqyl; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 35FCFA0ACA;
	Mon, 15 Sep 2025 15:38:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=CqevzXuJmSFLDexdsImo2Fo4EnZ+d/W8X7whgyP3mJo=; b=
	AsSGvqylvkAIvGpYYxPn2ODpLQ5w5/Ev+MiIUuml9bR87M/laS+PCEqaDmqiv5Vc
	/iE+i3dCSmnmVflVrhFuOYH5844GgnMLmN3FLdSKGAeAGwWzOS3Bbko65wFaLr+W
	BVSW0sZQk0FeuACWnAs+ZfYqQfLxMQGnNxaHOatIww0AylItCPQgCBLgBEwnUlP4
	JSSnusTkhUVWiXQVL01oXoEKJawcju5H2aL+dESWoMhU4OXtFGOtoOaG/ld3iAwD
	GxbNT245fXzRI/RVuAs+jmxkFzx+LoNloYqpVWNzmGO+DPETRuFdIqdnVHmXKA/y
	VeoLMGTtf4xJferg93VwNJsN8cTdj5D4y1jWDTfXugMN0ivK/j3xAbT5zaMTdUuE
	yO8frzprZSdUHxxTzw3SiIDqFTfoxRoeOPQLKV3dShExyraYGszr1THtiDJ392bB
	3hgi/egVkPYTFAXbagjYyS5g4VAV8YT0Dxv1TNBnkf+8WHEHTsFvZQsqMBdwXLxE
	oTabL4U/eQOKvFENv7/AI29vF30AMDinveLt5VwR+R1NpVyFUIVegYHAccJD6BwM
	oTV9MWIjTsklNw+Xelj0N0bFZkTiqsPzsg2I7MytjF8FFFxpMAr93Ea1g3cOvtU5
	S8nSxfaKy0Zivl9u6sRpaEUXvQzvPS3lKiZerbaCBE8=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: <stable@vger.kernel.org>
CC: Buday Csaba <buday.csaba@prolan.hu>, Andrew Lunn <andrew@lunn.ch>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>, Paolo Abeni
	<pabeni@redhat.com>
Subject: [PATCH 6.12] net: mdiobus: release reset_gpio in mdiobus_unregister_device()
Date: Mon, 15 Sep 2025 15:35:40 +0200
Message-ID: <20250915133540.824705-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1757943482;VERSION=7998;MC=2068852340;ID=57108;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155E62726A

From: Buday Csaba <buday.csaba@prolan.hu>

reset_gpio is claimed in mdiobus_register_device(), but it is not
released in mdiobus_unregister_device(). It is instead only
released when the whole MDIO bus is unregistered.
When a device uses the reset_gpio property, it becomes impossible
to unregister it and register it again, because the GPIO remains
claimed.
This patch resolves that issue.

Fixes: bafbdd527d56 ("phylib: Add device reset GPIO support") # see notes
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Cc: Csókás Bence <csokas.bence@prolan.hu>
[ csokas.bence: Resolve rebase conflict and clarify msg ]
Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
Link: https://patch.msgid.link/20250807135449.254254-2-csokas.bence@prolan.hu
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ Upstream commit 8ea25274ebaf2f6be8be374633b2ed8348ec0e70 ]
[ csokas.bence: Use the v1 patch on top of 6.12, as specified in notes ]
Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---
 drivers/net/phy/mdio_bus.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 591e8fd33d8e..a508cd81cd4e 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -97,6 +97,7 @@ int mdiobus_unregister_device(struct mdio_device *mdiodev)
 	if (mdiodev->bus->mdio_map[mdiodev->addr] != mdiodev)
 		return -EINVAL;
 
+	gpiod_put(mdiodev->reset_gpio);
 	reset_control_put(mdiodev->reset_ctrl);
 
 	mdiodev->bus->mdio_map[mdiodev->addr] = NULL;
@@ -814,9 +815,6 @@ void mdiobus_unregister(struct mii_bus *bus)
 		if (!mdiodev)
 			continue;
 
-		if (mdiodev->reset_gpio)
-			gpiod_put(mdiodev->reset_gpio);
-
 		mdiodev->device_remove(mdiodev);
 		mdiodev->device_free(mdiodev);
 	}
-- 
2.43.0



