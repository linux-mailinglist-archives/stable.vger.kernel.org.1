Return-Path: <stable+bounces-184104-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C66B9BD03D4
	for <lists+stable@lfdr.de>; Sun, 12 Oct 2025 16:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5088818962C2
	for <lists+stable@lfdr.de>; Sun, 12 Oct 2025 14:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9F4288C9D;
	Sun, 12 Oct 2025 14:28:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC86F28725C
	for <stable@vger.kernel.org>; Sun, 12 Oct 2025 14:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760279336; cv=none; b=t4O0CoHpjvzXlGzSxVU5oJsfCiKbX9AceVSz3wMH9UtZiIdXQ9tdN5v77xrZq5zeX9w8UcQPjnNklmEyWio13avBVtTUXe9R3WsEKH0QhX64HyRIw7aCgbleBad6dwnGyOg/2ldxDyvGRqE3PuyoBZ5FWFLYTPc2ivwERVbIE0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760279336; c=relaxed/simple;
	bh=V4741N7mWje9GwplW/wE4MaPFAZiPIK/txjYm32qFvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D0PXxpj7q/One9qQXVVN6KPi8Ln0cLtEfysg+GCbpziamOfNI0R2AEHWfOU0wXtscp18egQ0b3fuI6KEUroxU60WS54vhBUfkEPc3Ve3LuXJEpSr++RXDJfAgWSLhrAI3ApewRKUAQSXHOL0/575QsQoUXv3GGwYlNXTOm7wU4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v7x3w-00044j-8W; Sun, 12 Oct 2025 16:28:40 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v7x3v-003EUk-1Q;
	Sun, 12 Oct 2025 16:28:39 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1937848405F;
	Sun, 12 Oct 2025 14:28:39 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Celeste Liu <uwu@coelacanthus.name>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 2/9] can: gs_usb: gs_make_candev(): populate net_device->dev_port
Date: Sun, 12 Oct 2025 16:20:46 +0200
Message-ID: <20251012142836.285370-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251012142836.285370-1-mkl@pengutronix.de>
References: <20251012142836.285370-1-mkl@pengutronix.de>
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

From: Celeste Liu <uwu@coelacanthus.name>

The gs_usb driver supports USB devices with more than 1 CAN channel.
In old kernel before 3.15, it uses net_device->dev_id to distinguish
different channel in userspace, which was done in commit
acff76fa45b4 ("can: gs_usb: gs_make_candev(): set netdev->dev_id").
But since 3.15, the correct way is populating net_device->dev_port.
And according to documentation, if network device support multiple
interface, lack of net_device->dev_port SHALL be treated as a bug.

Fixes: acff76fa45b4 ("can: gs_usb: gs_make_candev(): set netdev->dev_id")
Cc: stable@vger.kernel.org
Signed-off-by: Celeste Liu <uwu@coelacanthus.name>
Link: https://patch.msgid.link/20250930-gs-usb-populate-net_device-dev_port-v1-1-68a065de6937@coelacanthus.name
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 9fb4cbbd6d6d..69b8d6da651b 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -1245,6 +1245,7 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 
 	netdev->flags |= IFF_ECHO; /* we support full roundtrip echo */
 	netdev->dev_id = channel;
+	netdev->dev_port = channel;
 
 	/* dev setup */
 	strcpy(dev->bt_const.name, KBUILD_MODNAME);
-- 
2.51.0


