Return-Path: <stable+bounces-24475-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2378694A7
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68C6C2858E5
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B462813B2AC;
	Tue, 27 Feb 2024 13:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j9Nq6lp3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F18B13B791;
	Tue, 27 Feb 2024 13:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709042107; cv=none; b=SifiGM2fDF5zCIDwzgOQ3gdUjeRQtcLmMdyt1SnITi+OSCb8GzKlkaZQrjhoOjkZMpiDUuzTePx48R8IUBIb74kolpZ6Shvif0HInDddceNNknBdIEHPFvVKW/4uTR1Sw1qP9zQSa04XFH1GHA3cNfBqzgOm13yFw03G/DgXu8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709042107; c=relaxed/simple;
	bh=K7pTjnsbTuF0Yi54eWs9mWx7vG794G7/u9NZXGrPN7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sPVOZ3xqgONDWGoUjd8IlRK+/ye+j4rAmeTXO0mCyWVTR/6Df44m4V3hzqx5jUXH7jutloFr2LvQPgIvi2WoowlggW9TfDWXr1ZJuOMYOIgPPMKvf+RFY7IP8LFYC2Z2kPv50IF+BgQdYEjQgUCbCq1ueMSlpX7AM8UpiInW9mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j9Nq6lp3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F093AC433C7;
	Tue, 27 Feb 2024 13:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709042107;
	bh=K7pTjnsbTuF0Yi54eWs9mWx7vG794G7/u9NZXGrPN7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j9Nq6lp3CjgBmd8cN8l2Y2PYGapSHmhXwmTatWu8bynSvgYN+kzRIoJ07IX7sGGdN
	 mI7cjWmzdCdY4z83S0GBTq43SmQjRsG/iBf6OgsQ7z3ozLlwrFulJ+W0RNLbzd74Up
	 VsyNi+sP2cxHIA7BsCEXFBC2oEQynJRaJzOC8KWc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH 6.6 181/299] serial: stm32: do not always set SER_RS485_RX_DURING_TX if RS485 is enabled
Date: Tue, 27 Feb 2024 14:24:52 +0100
Message-ID: <20240227131631.668687822@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131625.847743063@linuxfoundation.org>
References: <20240227131625.847743063@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lino Sanfilippo <l.sanfilippo@kunbus.com>

commit f418ae73311deb901c0110b08d1bbafc20c1820e upstream.

Before commit 07c30ea5861f ("serial: Do not hold the port lock when setting
rx-during-tx GPIO") the SER_RS485_RX_DURING_TX flag was only set if the
rx-during-tx mode was not controlled by a GPIO. Now the flag is set
unconditionally when RS485 is enabled. This results in an incorrect setting
if the rx-during-tx GPIO is not asserted.

Fix this by setting the flag only if the rx-during-tx mode is not
controlled by a GPIO and thus restore the correct behaviour.

Cc: stable@vger.kernel.org # 6.6+
Fixes: 07c30ea5861f ("serial: Do not hold the port lock when setting rx-during-tx GPIO")
Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
Link: https://lore.kernel.org/r/20240216224709.9928-1-l.sanfilippo@kunbus.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/stm32-usart.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 794b77512740..693e932d6feb 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -251,7 +251,9 @@ static int stm32_usart_config_rs485(struct uart_port *port, struct ktermios *ter
 		writel_relaxed(cr3, port->membase + ofs->cr3);
 		writel_relaxed(cr1, port->membase + ofs->cr1);
 
-		rs485conf->flags |= SER_RS485_RX_DURING_TX;
+		if (!port->rs485_rx_during_tx_gpio)
+			rs485conf->flags |= SER_RS485_RX_DURING_TX;
+
 	} else {
 		stm32_usart_clr_bits(port, ofs->cr3,
 				     USART_CR3_DEM | USART_CR3_DEP);
-- 
2.44.0




