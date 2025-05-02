Return-Path: <stable+bounces-139496-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E52AA74A6
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 16:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AAC69E591E
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 14:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB682571D8;
	Fri,  2 May 2025 14:14:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F102571CD
	for <stable@vger.kernel.org>; Fri,  2 May 2025 14:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746195245; cv=none; b=KTt1azLf35M1igAhVtEy0YMIRtt8Kn11nD66ENhYjC+TG+8zWQWtBe3JmaxZIifCvk4N70CwIxC8EpZxQkMrjNE4ZrcvX2sgSmNCTziO/C/cglcMoZgadXtBSO9sgMQdJS2VKcn9LEJM+mCp5Og6hVl7Kjr7WTCaVICFU/j0vLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746195245; c=relaxed/simple;
	bh=wKNEquMMqRCDDxXwq44IRpJvSwnrG9pSA9GxTv2slhE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=W6K2NtbMF5MrmLsUu425LbfD84EZTRbp93CWFEyW3zX6kqLLCm0K6LJ0eOhMhFgjqyMWekRkUlKx2ikzyuTbStO1IHtZ/rfi/en4RkYvmxtqfunsVR1FY4Gi1DDVsOcbaKtYrUOWEdz8zNAUqNyhSL5nWsZPUj6+7tl66b1IENA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uAr9M-0000ve-HA
	for stable@vger.kernel.org; Fri, 02 May 2025 16:14:00 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uAr9L-000lQs-3A
	for stable@vger.kernel.org;
	Fri, 02 May 2025 16:14:00 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id A55AE4065CC
	for <stable@vger.kernel.org>; Fri, 02 May 2025 14:13:59 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 8CF8340659C;
	Fri, 02 May 2025 14:13:56 +0000 (UTC)
Received: from hardanger.blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 1e9aea9b;
	Fri, 2 May 2025 14:13:56 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 0/3] can: rx-offload: fix order of unregistration calls
Date: Fri, 02 May 2025 16:13:43 +0200
Message-Id: <20250502-can-rx-offload-del-v1-0-59a9b131589d@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABfTFGgC/x3MQQqAIBBA0avErBswJaSuEi2sGWtANBQiCO+et
 HyL/18onIULzN0LmW8pkmLD0Hewny4ejELNoJUe1ag07i5ifjB5H5IjJA7Im52MnawxRNDCK7O
 X558ua60fshOVEmQAAAA=
X-Change-ID: 20250502-can-rx-offload-del-eb79379733dd
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Thomas Kopp <thomas.kopp@microchip.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, kernel@pengutronix.de, 
 Heiko Stuebner <heiko@sntech.de>, 
 Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-048ad
X-Developer-Signature: v=1; a=openpgp-sha256; l=1661; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=wKNEquMMqRCDDxXwq44IRpJvSwnrG9pSA9GxTv2slhE=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBoFNMZ+DcELaBl0lz4gVEsR+oe731Z3vOvy7b2m
 b2FTbj9YuWJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaBTTGQAKCRAMdGXf+ZCR
 nMwvB/9BEUC1dtYbDGi5TQBbvaBKY6YrVwI3NEpZhtUZWIIHSiOte6QcTtsFg97q+xbvSge7DqT
 vE/jLpU74PHl1GpDIrvyuzUO2XEAywLHiPPudUsTmWYNuJtYvo3lvHzkbI/ejsCmUM/ZEjB2RpG
 i62671TdSBAp57MN4J2M2H5POJlTqd2uLAfdVliGnOX6O+VSBax0gdtA7QqB+PtL8Bk2coH+b8u
 hyx6ilTkOcCBa0p0GCY5Q/HkibJq8kStPIUnIDgj800Tb3BrmTNG3jDu/LZVBXzsmoqzqAmz62t
 GzmcfQ1ZGb7WR4PwhLiDmUDBG/pAQHSyVcwqpEBnpkzFFvj3
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org

If a driver is removed, the driver framework invokes the driver's
remove callback. A CAN driver's remove function calls
unregister_candev(), which calls net_device_ops::ndo_stop further down
in the call stack for interfaces which are in the "up" state.

With the mcp251xfd driver the removal of the module causes the
following warning:

| WARNING: CPU: 0 PID: 352 at net/core/dev.c:7342 __netif_napi_del_locked+0xc8/0xd8

as can_rx_offload_del() deletes the NAPI, while it is still active,
because the interface is still up.

To fix the warning, first unregister the network interface, which
calls net_device_ops::ndo_stop, which disables the NAPI, and then call
can_rx_offload_del().

All other driver using the rx-offload helper have been checked and the
same issue has been found in the rockchip and m_can driver. These have
been fixed, but only compile time tested. On the mcp251xfd the fix was
tested on hardware.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Marc Kleine-Budde (3):
      can: mcp251xfd: mcp251xfd_remove(): fix order of unregistration calls
      can: rockchip_canfd: m_can_class_unregister: fix order of unregistration calls
      can: mcan: m_can_class_unregister: fix order of unregistration calls

 drivers/net/can/m_can/m_can.c                  | 2 +-
 drivers/net/can/rockchip/rockchip_canfd-core.c | 2 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
---
base-commit: ebd297a2affadb6f6f4d2e5d975c1eda18ac762d
change-id: 20250502-can-rx-offload-del-eb79379733dd

Best regards,
-- 
Marc Kleine-Budde <mkl@pengutronix.de>



