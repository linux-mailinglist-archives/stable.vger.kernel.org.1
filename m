Return-Path: <stable+bounces-188535-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 995EABF86D0
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 21:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 890CD5802D4
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 19:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D30274B30;
	Tue, 21 Oct 2025 19:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cEMnObTh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA878350A2A;
	Tue, 21 Oct 2025 19:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761076715; cv=none; b=m/LYmOPhf14Rr1o5CiHGC0RTbOaM6tCQ1kTeYAk50/39jFKzZimgXDaobVEKqqxDykIaDulYVXKraBfpUv8IV6yoWefodiBKW1PNjP5e9BEdK8lwJSeR53wce2InTFG400RG6scPLwGTfVzkpU7SX9XL5aX0x2jel+wa8Z9uUjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761076715; c=relaxed/simple;
	bh=HdyNQFjPSMQJco02pCif69zU5FJSCk/90MtXEqtpqpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g51zXjbHk+prndlGHzU83cIgX64RnCfPhq4FpPPFTV4LZGX/oTuSSAxDCPx6VbouzB3Aua33UZ/ZjsK81Kcc2DePjWvj3/Dr+QuE9zvzd2AT8AYLD+czFv2ro8g5xIfLLvAdRiyA2cSQF+uGjB/MLaZOE3okynADSecHiIYMumw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cEMnObTh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC78AC4CEF1;
	Tue, 21 Oct 2025 19:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761076715;
	bh=HdyNQFjPSMQJco02pCif69zU5FJSCk/90MtXEqtpqpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cEMnObTh43iJwV166tPvPNZnZX/7CQfRInQOjwjG+8cDBo9KruZueZ9LJC5U+CE5J
	 HMNjwZNHPNj3GjRjEegW/rMyuse9qllChfBABHovMlFKtqkUKviJBhDfue95dB1pbF
	 sVL9SNqufZ0Bll6ShDFZx28siCLApJhQ7vPaoC2M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Celeste Liu <uwu@coelacanthus.name>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.12 016/136] can: gs_usb: gs_make_candev(): populate net_device->dev_port
Date: Tue, 21 Oct 2025 21:50:04 +0200
Message-ID: <20251021195036.359872197@linuxfoundation.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251021195035.953989698@linuxfoundation.org>
References: <20251021195035.953989698@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Celeste Liu <uwu@coelacanthus.name>

commit a12f0bc764da3781da2019c60826f47a6d7ed64f upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/can/usb/gs_usb.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -1246,6 +1246,7 @@ static struct gs_can *gs_make_candev(uns
 
 	netdev->flags |= IFF_ECHO; /* we support full roundtrip echo */
 	netdev->dev_id = channel;
+	netdev->dev_port = channel;
 
 	/* dev setup */
 	strcpy(dev->bt_const.name, KBUILD_MODNAME);



