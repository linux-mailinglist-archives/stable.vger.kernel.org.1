Return-Path: <stable+bounces-179627-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B7DB57DB3
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 15:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B1FB1621B4
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 13:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B8B31C572;
	Mon, 15 Sep 2025 13:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="qEReZr0s"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C6E23504B
	for <stable@vger.kernel.org>; Mon, 15 Sep 2025 13:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757943693; cv=none; b=S1Fv19jpI+J73diEPM2LaRTLm7n+OnBoM6pbgUHmKboDaLU/i+hKHSfo32AUS4U/9JhTwkP2+Qsoej2VyycenFzsc/69il3GvvvGtx3hVbmHXOrY2/i2WM3CJ2GijyP6hv/5TWC5Bl0fSzBN9Z1ZXnkuL6ndkCFoJdLaEkp8fzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757943693; c=relaxed/simple;
	bh=VRixG2PnyBmzJPUPEkbO9Njz1vMyXo97a4/SqxFkweA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mYyEgA+MxBf5pNkNqRzekxaYYo2DnKnz0fSMrVacUhZxD6uDjNjvx8v2RvPN8XODSIpgkquFWjfV3yHkihlOIsJh0Izhu+gb53xTJFJEl93co5dj5Dlyj01F063O76S13VqSssO3KxdvE5aCA2cwQBmf0Fj2LB6pgq1pTm2Zbn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=qEReZr0s; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id EB50EA0ACA;
	Mon, 15 Sep 2025 15:41:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=KMyHL4fLBiP2t5uRL7gJxuEONYW7xwg05bZKJ3T6Bkg=; b=
	qEReZr0sQT0L/Lh0RsIVpVzE3zUhGN7vdlztlFFHNLNS+OtNd7t/PGvwX4vqc7oq
	2copIKWLJwOa+qhNXt4PTsOhbQ5BKXhM3Wxml0yqy+Jg8k+LK3cyHpnjK1zrgF99
	ugMzhup2yIkOAXOKiQ5GhJBh8JAo7lN76HJCMLIr1tySCrVjI6vX/vxZrzv1l5QJ
	AtK5o6tihRNu89Qx0MRqhCZn32+pWvMBvzplqaH2Ng7g+RpHr2iCEgjjEAmG0NVH
	+ZqoW6TMJSrVXX8BQh28nb0DUOQv7mllYdXrREit2k+1MdOWRdRJHrlCEypZ1XzH
	03wZLqMPH/hese/IE52xgPiNqJZoZKmX8VgZuZnAiB7KECz7lV4HQNiJcf3kWlr8
	Tz4zGKHTUPoZNJglsImWs4BRtnqLegjpidAN6drS9Us9ihlYST2f5NJDtgAXhKl0
	Phcve4wCZrZgC2/FnEWlGGv3ykyHRB21I/6rLAY7ilPP7uesdAgmw03HIZIpu5JC
	OwdNzZpfqC5zwqp1eXCMcZ8RSkkkHslp7blQDN/lbi4qUOb2DfzIHAjaoV4/mHco
	DkqaKvtjOG76ZqANraP4asbZ1qM4fekcwlxJ4vgJipD9niEYRXL+rywPOkEWiZdj
	D/xxB9uc7lsCmhWDh+19wcjkoj+sUBK7JyyetdiUjMk=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: <stable@vger.kernel.org>
CC: Buday Csaba <buday.csaba@prolan.hu>, Andrew Lunn <andrew@lunn.ch>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>, Paolo Abeni
	<pabeni@redhat.com>
Subject: [PATCH 6.6] net: mdiobus: release reset_gpio in mdiobus_unregister_device()
Date: Mon, 15 Sep 2025 15:41:18 +0200
Message-ID: <20250915134117.825479-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1757943687;VERSION=7998;MC=1005751731;ID=41667;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2998FD515E62726A

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
[ csokas.bence: Use the v1 patch on top of 6.6, as specified in notes ]
Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---
 drivers/net/phy/mdio_bus.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 25dcaa49ab8b..e8fadd7a14fe 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -99,6 +99,7 @@ int mdiobus_unregister_device(struct mdio_device *mdiodev)
 	if (mdiodev->bus->mdio_map[mdiodev->addr] != mdiodev)
 		return -EINVAL;
 
+	gpiod_put(mdiodev->reset_gpio);
 	reset_control_put(mdiodev->reset_ctrl);
 
 	mdiodev->bus->mdio_map[mdiodev->addr] = NULL;
@@ -775,9 +776,6 @@ void mdiobus_unregister(struct mii_bus *bus)
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



