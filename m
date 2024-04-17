Return-Path: <stable+bounces-40086-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B819C8A7F19
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 11:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E93911C218F9
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 09:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F81C12EBDB;
	Wed, 17 Apr 2024 09:04:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C75212D759
	for <stable@vger.kernel.org>; Wed, 17 Apr 2024 09:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713344682; cv=none; b=I3wJhLpzksHqdLd488uKzAJam8W4rBR6Tv/YK632xoUHn1XDu1jegG1b9aQs+8UGhPoS6BkgPUop04hYsUUVqv9h+qcGq3KFS90ahSsuW5Nc/ggyHbgLIC2GRnSaKFYOS0a8Ay8cVoYGTROXvxI3suotVH7GFY27C7scJEuQQ8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713344682; c=relaxed/simple;
	bh=CFmHE1BzGVHwhk0poqXyOfp0UAIGCsaPeLG3rEUuFW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R+qfNx5yo0/mx7mckoqQ8Vv408TPtypaCu7KtwZ5sCWimMFSPsw7drOPLrrxtUhITNc3XiQ/UAcYxpxhUjJ5GNSJH/8ow77rwvWCuCwilq3HPuQ3OJoPV0R8b3xto6SgOrymsko3kG2WrYTUziZEvRFwAD2GlaH9aXhEYz3kBfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rx1DD-0004on-PA; Wed, 17 Apr 2024 11:04:15 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rx1DC-00ClGK-4Z; Wed, 17 Apr 2024 11:04:14 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rx1DC-002hM4-0A;
	Wed, 17 Apr 2024 11:04:14 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	kernel@pengutronix.de,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Valentin Caron <valentin.caron@foss.st.com>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Erwan Le Ray <erwan.leray@foss.st.com>,
	Peter Hurley <peter@hurleysoftware.com>,
	Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
	linux-serial@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] serial: stm32: Reset .throttled state in .startup()
Date: Wed, 17 Apr 2024 11:03:28 +0200
Message-ID:  <a784f80d3414f7db723b2ec66efc56e1ad666cbf.1713344161.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1713344161.git.u.kleine-koenig@pengutronix.de>
References: <cover.1713344161.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1049; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=CFmHE1BzGVHwhk0poqXyOfp0UAIGCsaPeLG3rEUuFW0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmH5BijoBEeBEBW6sX9z1WyExTH4i3AnV9yQT9Z lBMrOKfwXSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZh+QYgAKCRCPgPtYfRL+ Tql6B/9J22rBmAfTCxSYqK0kI0Av488jT1v/xAP7xF0yXbywi5OUJMKeUCyjk84D/DSBYn4Is+8 WcNweLId14pD66JBCLv9mogAIkXZdMP+M9VFoozWpa5wvbIwlCR+xtgkTrIhaPIV8e1X4SjxBwy vw7ra9YZ6zXmrnmSPiigEvbSOYFVq7JAYwva4BVC28eqHaDvV+uUbM8XYGcquxV64bgG+RUwoJF 5TbiWjJhY8aNnrBNtJigGB6QeZwtC/QK5q9D//p27xcE5wC6BXul465HCMg1ljMl6PJteONYP7S KT7DALY0S/Vq+nz+vB1s02g0Ph/a7mZaEWgGQandOBYwPi5S
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org

When an UART is opened that still has .throttled set from a previous
open, the RX interrupt is enabled but the irq handler doesn't consider
it. This easily results in a stuck irq with the effect to occupy the CPU
in a tight loop.

So reset the throttle state in .startup() to ensure that RX irqs are
handled.

Fixes: d1ec8a2eabe9 ("serial: stm32: update throttle and unthrottle ops for dma mode")
Cc: stable@vger.kernel.org
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/stm32-usart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 2bea1d7c9858..e1e7bc04c579 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -1080,6 +1080,7 @@ static int stm32_usart_startup(struct uart_port *port)
 		val |= USART_CR2_SWAP;
 		writel_relaxed(val, port->membase + ofs->cr2);
 	}
+	stm32_port->throttled = false;
 
 	/* RX FIFO Flush */
 	if (ofs->rqr != UNDEF_REG)
-- 
2.43.0


