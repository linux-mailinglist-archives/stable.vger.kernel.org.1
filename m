Return-Path: <stable+bounces-198608-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08380CA1411
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 20:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A85A832FAB22
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 18:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C9D32FA0B;
	Wed,  3 Dec 2025 15:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jkOxLGNi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5315832FA06;
	Wed,  3 Dec 2025 15:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764777105; cv=none; b=FALanNxrcZKv0RiIYdArIhIEvDV5+SQuz6baqnYYuazEveISy9T1QkqwDr1nut2baaq6KrZTRjL/VTQU5SZtwLlExUUB1Z/ms22kICYMU6w46fY8fIbeacYeUePblOtNU0xtnR9gz8AbAVYKTGlk3WL+/StO9Bnk6ewnZJL8KfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764777105; c=relaxed/simple;
	bh=IwK+vcatgQxajwo+M73tKMMQAJrOKQz/FiQVH+bIBzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ciIbAzYhjRMAKCOtZjtHqjXfuZ4V4bgx35d6zPsUUC0pPf/6nOotUhhqcsuhxWTzRGnbf6Uspw56EAXFGqui55plQfRScOn8WXJ2Ib8Pe0+ABO5H2uCSINcT4NQV/yIfqiLufzRBQ7VNz/APEfkLMwQvPnw7yJm4QqK6K6t6dgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jkOxLGNi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD0A9C4CEF5;
	Wed,  3 Dec 2025 15:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764777105;
	bh=IwK+vcatgQxajwo+M73tKMMQAJrOKQz/FiQVH+bIBzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jkOxLGNifADxi+ql9Kc4Qt74G6Z7mH/TOOaeqTqiRpd771YCIzFFx3lK+hXViTBfN
	 ctrnq92r5EsOWijctxIcOk05i/J3JYjHdMjZiTXq0/RND3v4Up3e6H+7ZnuJbYlXVo
	 MQ8VOoLGSBhskLIre/9azblVEFr3OlKPG/HnaVdU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Thomas=20M=C3=BChlbacher?= <tmuehlbacher@posteo.net>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.17 084/146] can: sja1000: fix max irq loop handling
Date: Wed,  3 Dec 2025 16:27:42 +0100
Message-ID: <20251203152349.537143680@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152346.456176474@linuxfoundation.org>
References: <20251203152346.456176474@linuxfoundation.org>
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

6.17-stable review patch.  If anyone has any objections, please let me know.

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
@@ -548,8 +548,8 @@ irqreturn_t sja1000_interrupt(int irq, v
 	if (priv->read_reg(priv, SJA1000_IER) == IRQ_OFF)
 		goto out;
 
-	while ((isrc = priv->read_reg(priv, SJA1000_IR)) &&
-	       (n < SJA1000_MAX_IRQ)) {
+	while ((n < SJA1000_MAX_IRQ) &&
+	       (isrc = priv->read_reg(priv, SJA1000_IR))) {
 
 		status = priv->read_reg(priv, SJA1000_SR);
 		/* check for absent controller due to hw unplug */



