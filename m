Return-Path: <stable+bounces-204592-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F26CF28D3
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 09:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A61F73009942
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 08:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC12325725;
	Mon,  5 Jan 2026 08:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="nLobJJOP"
X-Original-To: stable@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A0731ED72;
	Mon,  5 Jan 2026 08:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767603499; cv=none; b=jeWqj89YuZCgL1bEoJGvRpkBosxE/SoH3DxJJkhH2Xt3/fOUuDb5wXltvs1dx2WsIhxVK3Xw2IdjmnQLUX1v3X+xXXCE3iUedSpLFmjp8mb1lxYWnyeEv2zeMiNnzO8pZxU6EdYQUvplSFBAbMT3sygd4NW8EQ5bPRg9ctlCh+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767603499; c=relaxed/simple;
	bh=Y37QqX1z5ND57dXhUkEl4k4NLtL9Lq7cfe1c4EYWGJc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AuWiadvVKtA4ukE7Xc9fY99pAufQN4fagAR+0JKSKo2i6XMJcx1j/Xdyi+TI+wSRGa0nOgtO0NKi7W4qb9CyEsnfZ1yf9ePLw+su/DK5sNkPXOsvObbPpNCAypLztR7xK/gEpZPsyGN4HwLNxESEaVvTilZtH8Vbh+hhQ6vhAz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=nLobJJOP; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from mail.ideasonboard.com (unknown [223.190.87.50])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2E8E1103D;
	Mon,  5 Jan 2026 09:57:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1767603474;
	bh=Y37QqX1z5ND57dXhUkEl4k4NLtL9Lq7cfe1c4EYWGJc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nLobJJOPZkHbrnv46JSAQRLKUWJYORpaJ7L5DDXtC8VrVkHNNuBb0mmN0Wv6jhwaU
	 HNYB0XMmNqd1NF1wbfm7N0DNFvUr+umfOBSF9WQ+TRXJcFjZB4Gp+Ww5DeoHKGTiOE
	 s33gnr9y5DKOKg+oSJWaWrXjw7F1t964YCX4EIRo=
From: Jai Luthra <jai.luthra@ideasonboard.com>
Date: Mon, 05 Jan 2026 14:26:47 +0530
Subject: [PATCH v2 1/6] platform/raspberrypi: vchiq-mmal: Reset
 buffers_with_vpu on port_enable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-b4-vc-sm-cma-v2-1-4daea749ced9@ideasonboard.com>
References: <20260105-b4-vc-sm-cma-v2-0-4daea749ced9@ideasonboard.com>
In-Reply-To: <20260105-b4-vc-sm-cma-v2-0-4daea749ced9@ideasonboard.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 bcm-kernel-feedback-list@broadcom.com, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Phil Elwell <phil@raspberrypi.com>, Stefan Wahren <wahrenst@gmx.net>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-rpi-kernel@lists.infradead.org, 
 Jai Luthra <jai.luthra@ideasonboard.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1302;
 i=jai.luthra@ideasonboard.com; h=from:subject:message-id;
 bh=JSgZMYealuIOds6HnKWiS/7lNVz/h69ewVfRbYUXbFE=;
 b=owEBbQKS/ZANAwAKAUPekfkkmnFFAcsmYgBpW3z5GpoW5BzlikLwvbXckRSzs6+GF/mA06/Xa
 Wsnj2/3hNeJAjMEAAEKAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCaVt8+QAKCRBD3pH5JJpx
 RSOmEACCIQy+1kWfGHlfjnX6xuXtGaquCw0u35BY55qUwUq+ptoWF4h/jMIk86igSlucEXlA9Qh
 mAEuhKTIaI49agEDsJKmmTtBMe0UP9ckmig44prPwRmknT7WqfLwFx5IEhFcqf6oMcD3qSwYtvC
 oTExTLI+a15jWq9xdZwh7DOQ1Ppz1M+eKMNnE9u/8jdAvk7WRbG/E/qWvKmOPJthjfNHQy4c3sW
 WYL/9nq5iciVf1Z8xgHDWRZUdDVwyNzzLNBILP+9Xwxmjrj4voBiibxlH61qkzI6YS0AiodxPrJ
 5l/p0LfJkW0oess+AiUiETktSChi1Q56i1saVbmbaRXX4X2/sbo9CkSc2lkMUJbFpJuV/ACyHp6
 CrP0jLHIVmJyW/Dfk8Y2/hypt2qMkrr9N2V2HeaKHcdabb27qRT5i1XBSs6VEb6RNwHi7dOEgup
 mweLinLJlAMPSjzsNzLoaioNp8MuPsuMwntbB3z8sBefoJZvrLn1usZZzciv6DxCO0o0AAeWDOq
 ehMtm16b0Uu/GNt/fT/VULzedgRkjEuaF/hIvNeamcxEyv6PgtE+92D+2yPwNAMyd6NXCoiWbhy
 fVwYw/LScJuOp6WCo1hzL8bsnjLUJqwOMBL4WQZLDwJhqsCnNev1duswio6RLSwjUHyr+Db7MyY
 XiemDOqq2HzT3wA==
X-Developer-Key: i=jai.luthra@ideasonboard.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

Should we go through the timeout failure case with port_disable
not returning all buffers for whatever reason, the
buffers_with_vpu counter gets left at a non-zero value, which
will cause reference counting issues should the instance be
reused.

Reset the count when the port is enabled again, but before
any buffers have been sent to the VPU.

Fixes: 70ec64ccdaac ("staging: bcm2835-camera: Ensure all buffers are returned on disable")
Cc: stable@vger.kernel.org
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
---
 drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c b/drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c
index cd073ed3ea2dd9c45b137f1a32e236e520b7b320..e76551948bd9c4f60bef1138280fe8dd9d32477b 100644
--- a/drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c
@@ -1364,6 +1364,8 @@ static int port_enable(struct vchiq_mmal_instance *instance,
 
 	port->enabled = true;
 
+	atomic_set(&port->buffers_with_vpu, 0);
+
 	if (port->buffer_cb) {
 		/* send buffer headers to videocore */
 		hdr_count = 1;

-- 
2.52.0


