Return-Path: <stable+bounces-199031-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAF0CA17D4
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 20:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 196F03068004
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 19:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFDE34B42F;
	Wed,  3 Dec 2025 16:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G/CBGI5y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F52734B417;
	Wed,  3 Dec 2025 16:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764778471; cv=none; b=nB0aVsM/r1XKioZyJvB/IxaWWrokDCWB0CLHhsfnzpOG+cyYeALjq9z5Tprg6/yXHPd8jAfXj64wqtRzJ44q0NjFwOWJlfvv/wioEkry28fLsDZy0XAVTjdXvKqW7KwykUAzP6CM1GpBrqPAom5VEbQGByAdNFG7U8FDDyoKQvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764778471; c=relaxed/simple;
	bh=TatD9wd6PESc8TWB/WEWGXyUfe01wOHqJDh0kcPzHVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qCYpuX+oIXrUgfEnYt06sNZwHjNX5Gq5wl1BTU96woQlu62MTDc8ds8iaV30WWf5K+l43JbizoO9B6j0FJWWiXya+hworDo2szc5nSIX+eHsWKpXTG3II/EdyJapiChUHajjOcfOo97fPOp/DeKLoJAHnlAAV9yQ9JnEjDctrUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G/CBGI5y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 447B4C4CEF5;
	Wed,  3 Dec 2025 16:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764778470;
	bh=TatD9wd6PESc8TWB/WEWGXyUfe01wOHqJDh0kcPzHVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G/CBGI5y+G2zvJiqy924uc0xgF1ud5X/+c+hRxbEKlxxlcvm4oHxWMtH+A76gqJbY
	 VpBGj7sXH6i9uO8rExGe+mMEqa55+ulpBKmlmAAuxyVL1l4WcfAF3MS+nvP49OThk/
	 9NHZcBmIHjKNSqrR9/ReIDlYXhENa0q/DlX2pflI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Thomas=20M=C3=BChlbacher?= <tmuehlbacher@posteo.net>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5.15 356/392] can: sja1000: fix max irq loop handling
Date: Wed,  3 Dec 2025 16:28:26 +0100
Message-ID: <20251203152427.266961110@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152414.082328008@linuxfoundation.org>
References: <20251203152414.082328008@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Mühlbacher <tmuehlbacher@posteo.net>

commit 30db4451c7f6aabcada029b15859a76962ec0cf8 upstream.

Reading the interrupt register `SJA1000_IR` causes all of its bits to be
reset. If we ever reach the condition of handling more than
`SJA1000_MAX_IRQ` IRQs, we will have read the register and reset all its
bits but without actually handling the interrupt inside of the loop
body.

This may, among other issues, cause us to never `netif_wake_queue()`
again after a transmission interrupt.

Fixes: 429da1cc841b ("can: Driver for the SJA1000 CAN controller")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Mühlbacher <tmuehlbacher@posteo.net>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20251115153437.11419-1-tmuehlbacher@posteo.net
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/can/sja1000/sja1000.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -508,8 +508,8 @@ irqreturn_t sja1000_interrupt(int irq, v
 	if (priv->read_reg(priv, SJA1000_IER) == IRQ_OFF)
 		goto out;
 
-	while ((isrc = priv->read_reg(priv, SJA1000_IR)) &&
-	       (n < SJA1000_MAX_IRQ)) {
+	while ((n < SJA1000_MAX_IRQ) &&
+	       (isrc = priv->read_reg(priv, SJA1000_IR))) {
 
 		status = priv->read_reg(priv, SJA1000_SR);
 		/* check for absent controller due to hw unplug */



