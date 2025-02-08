Return-Path: <stable+bounces-114389-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75976A2D5EF
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 12:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A807B3A89A8
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 11:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9019E2475F4;
	Sat,  8 Feb 2025 11:51:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A192475C4
	for <stable@vger.kernel.org>; Sat,  8 Feb 2025 11:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739015498; cv=none; b=CCeOc8mPvsQxNpupuFTb7voVgZIJTEz7cM/uqATUv2A6qDQf5+iRdpfCKoxRpXK+8OIcbCiiDGrdtxgBlLuVoy0ELcv3xXS3vcXFP1tjGmTk+iz85y6x/dhab3B1fNwhd5TEAiASgB/jad3cjv9WxtsVXRs1GhkXukBwwwHDYNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739015498; c=relaxed/simple;
	bh=vtliXAiHFXkEjUILnKHk3H7Y5//9aPJ75qyLWYexEGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bt6/1tjETPilrluTADdDm/78UYTYIrNXcrWNKi3zBLaYKE8KkiPxx0eRgU9iyNtoQ5GJRsU6iwywe30QQ7xXdaCnzESlz3eOLHezwv/y1VcYRDOIm68i7ucaC7lBHFZZ7L59xXYdixOGef2/6mNdxP2fd1h/pyQQ0Y36mxVeQEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tgjN1-0006sD-24
	for stable@vger.kernel.org; Sat, 08 Feb 2025 12:51:35 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tgjN0-0048Nj-1s
	for stable@vger.kernel.org;
	Sat, 08 Feb 2025 12:51:34 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 4A5033BCCF8
	for <stable@vger.kernel.org>; Sat, 08 Feb 2025 11:51:34 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 47BD73BCCD4;
	Sat, 08 Feb 2025 11:51:31 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 0675521c;
	Sat, 8 Feb 2025 11:51:22 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Robin van der Gracht <robin@protonic.nl>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 6/6] can: rockchip: rkcanfd_handle_rx_fifo_overflow_int(): bail out if skb cannot be allocated
Date: Sat,  8 Feb 2025 12:45:19 +0100
Message-ID: <20250208115120.237274-7-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250208115120.237274-1-mkl@pengutronix.de>
References: <20250208115120.237274-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org

From: Robin van der Gracht <robin@protonic.nl>

Fix NULL pointer check in rkcanfd_handle_rx_fifo_overflow_int() to
bail out if skb cannot be allocated.

Fixes: ff60bfbaf67f ("can: rockchip_canfd: add driver for Rockchip CAN-FD controller")
Cc: stable@vger.kernel.org
Signed-off-by: Robin van der Gracht <robin@protonic.nl>
Link: https://patch.msgid.link/20250208-fix-rockchip-canfd-v1-1-ec533c8a9895@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rockchip/rockchip_canfd-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index df18c85fc078..d9a937ba126c 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -622,7 +622,7 @@ rkcanfd_handle_rx_fifo_overflow_int(struct rkcanfd_priv *priv)
 	netdev_dbg(priv->ndev, "RX-FIFO overflow\n");
 
 	skb = rkcanfd_alloc_can_err_skb(priv, &cf, &timestamp);
-	if (skb)
+	if (!skb)
 		return 0;
 
 	rkcanfd_get_berr_counter_corrected(priv, &bec);
-- 
2.47.2



