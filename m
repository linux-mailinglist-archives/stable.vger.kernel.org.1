Return-Path: <stable+bounces-247746-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6M/YAJMZB2rOrgIAu9opvQ
	(envelope-from <stable+bounces-247746-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:03:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 432BA5501B5
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 618E43083473
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC0C47DFAB;
	Fri, 15 May 2026 12:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sGFycZSK"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E94C3AE70F
	for <stable@vger.kernel.org>; Fri, 15 May 2026 12:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778848888; cv=none; b=Vwelza/SVM3KAH7mQp1l3ct5Saj7I2HBYyBjdILGwmg37FdMpNgNbaoGc+nHaDEpOf3kcgWwLatxJscPZU1lZypYFdjAi9+8CHEL7iC4OzdkWKWdaUAQRgz9+vra2Y9jr+GydksTGc9Ag8pDEl+DTeAJFh4XfyJpsWUpJ9Rgo8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778848888; c=relaxed/simple;
	bh=7TZ5vcA+GLdk6E7fGnm5v0lehUpocwQ4ZVzCnZFOHkU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mF++akdkh5lE3eEaYVIdelegG9OSzGCCB7ZDeQ52cJ8D9nP4VXBVfr8hlWyLWcStwALRdANpG0CwwqCxPGQeSr1962Oh+PnO7R+LgY7aBfvMuGNtmc4QQAdaMq/tGksWxGCZa3MwCvLVLqcyotppVZN3lnDtjXUEPrsVcREqR2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sGFycZSK; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48a7fe4f40bso104798415e9.0
        for <stable@vger.kernel.org>; Fri, 15 May 2026 05:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778848884; x=1779453684; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fFHLfFog5+tJEOD6z3uXuJEqumNcdwRPWU/fZudPyJE=;
        b=sGFycZSK/yj9Ii47pbKAxiJsXnlz0zISKj5li3Qr0KJnBPVc8qVGTcRmnms051ZMfL
         xQe0eIux31D5e4lPG/ab9DWOCTUutJud16sFMFeAw2FGAil8X5c1azQLaN3GEtqVtGEz
         mTYoZhnLbQ+fJHVb7SR1B4PgjJudK2JDVC5PVFOhP3vmXDrXOKhJpb1BwL9rZEXaBt3F
         gg98IIim+FHn8ZFNbFzaNK0co9KNvvsVWYBTAAQ8wMsUu/gDdcIwZnzynRnQyPEC6sPF
         Db7Wm7d3ZNuopSiPkcFHHYrRT/rPRrZZMakywjnnVbZTQWzSbfWO78zLb3WA5YVJXLpK
         8VqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778848884; x=1779453684;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fFHLfFog5+tJEOD6z3uXuJEqumNcdwRPWU/fZudPyJE=;
        b=nr3nbqVB1TMcocSSOiQVhhegflChy/wN9TsqIvlu2lXomwJnrcuoip2G+ojQpyNpyk
         vkrDdIhZDk6xfZg/JkDw8s266LzeVNErDQ1pk0ly6ECcyR0HraU2vi0Pg2JsgSQkOjeI
         NHuL8+TNa4wFD7TS99++Y+4RSg707QcEFvISWdEonQKDHFeD0pedks++RY8dq1CuJUoT
         Hl4hJZBeIBr02m3otERE6TdU2UCoQu1kvmKD+BxlrIbMBN3aaQxIeZHfGld5saKasLYy
         H68GI591VISheqT78U3lTDs+bA7kMV+olfPbWbSVtEbzn/tO7RV20GlkqGFqmMrCDxpN
         8OzA==
X-Forwarded-Encrypted: i=1; AFNElJ/m9sSvA87+0yVPJLSiY0kz8hU7hrRzxqD9CFLCRLB4eg6FmOcH8s5n+LzP/KvtxIkfl8V9+V0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWxMsfZlH3SBF64K3c2e5P8bPe3T/rrg2YD+vIj1eIrENa2NKH
	UlaC1csgVcO+F1H+5N03vuGGnHMEIaw6OVhmfPWRXU5OnD2wTuAUZIIoaYAmP61fmv0=
X-Gm-Gg: Acq92OGf1r1GlCb9g7FRTxc3Sjg0VkelmM79XREjCu6n4Kh0LyZljb+uUnVilezrLh9
	CPrqOA9t5aZ6YCdEKI7xSMlJmBo2UjvQUZk5H94RyNlYTWyTrdT/BldOfFwSVpA9U2HTsM8llnk
	Q/KoBy8B9kwJzwwXD0ro/RTNo1NJpYtQdCVFc028ibIGRBz6IoNDvWh8zL1xdDQK8cKmP06OJTL
	4Rd9pQyWqUkbw5avauX1wDAK8f/5mwUva386+7fx+BgcEbL+HxbVrZAX4//Tt4Ag5cJe4rd0ed7
	QbYEVOT/aoPbtG0WaUa/Xc0rWzXSxinASOmw1iuKlct6Si1EEwbvgi4JrUm6BdBDmVm54U0PPHD
	NmYJad2HsW7kU81ehPSIB12k/dd6i2Ij7KWMIAwm0FNXXFVpY56nUL+i9LTSXHIzytYsIYtyTwA
	zExwcJbe5svLVzCsc743lKrcM0nc7Au0nuSErZEJ5OujDpVTJg/Eu9QEKQxVRUwfs3akvcknC2H
	RqAV6ZFpdelHrPc5g==
X-Received: by 2002:a05:600c:a309:b0:486:fba7:b150 with SMTP id 5b1f17b1804b1-48fe61f20a7mr44622645e9.15.1778848883620;
        Fri, 15 May 2026 05:41:23 -0700 (PDT)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a5653sm15154969f8f.35.2026.05.15.05.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 05:41:23 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Fri, 15 May 2026 12:41:21 +0000
Subject: [PATCH] tty: serial: samsung: Remove redundant port lock
 acquisition in rx helpers
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-samsung-tty-flow-control-deadlock-v1-1-93255edbc9bc@linaro.org>
X-B4-Tracking: v=1; b=H4sIAHAUB2oC/x3NQQrCMBBA0auUWTvQCW0FryIuYjKpwZiRTKqW0
 rs3uHyb/zdQLpEVLt0GhT9Ro+QGOnXgHjbPjNE3g+nN1I80otqXLnnGWlcMSb7oJNciCT1bn8Q
 9kfxgJjrTPQwErfMuHOLv/7je9v0Am3DCl3MAAAA=
X-Change-ID: 20260515-samsung-tty-flow-control-deadlock-1d426171bf41
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Ben Dooks <ben-linux@fluff.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 john.ogness@linutronix.d, peter.griffin@linaro.org, 
 andre.draszik@linaro.org, jyescas@google.com, kernel-team@android.com, 
 stable@vger.kernel.org, John Ogness <john.ogness@linutronix.de>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778848883; l=2912;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=7TZ5vcA+GLdk6E7fGnm5v0lehUpocwQ4ZVzCnZFOHkU=;
 b=HSB610k4svdM7RKtaunGgLw3+2VSD01p4S4EygS9OUnKmnC03b2/KyWCaywVndUgAybnnLZpV
 Iy911zmNlEdB3AXvSJIjtzoXHQPpTK2gU4xSiY6C6ROJ3/zU5kryg5R
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=
X-Rspamd-Queue-Id: 432BA5501B5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	TAGGED_FROM(0.00)[bounces-247746-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tudor.ambarus@linaro.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Sashiko identified a deadlock when the console flow is engaged [1].

When console flow control is enabled (UPF_CONS_FLOW),
s3c24xx_serial_stop_tx() calls s3c24xx_serial_rx_enable() and
s3c24xx_serial_start_tx() calls s3c24xx_serial_rx_disable().

The serial core framework invokes the .stop_tx() and .start_tx()
callbacks with the port->lock spinlock already held. Furthermore, all
internal driver paths that invoke stop_tx (such as the DMA TX
completion handler s3c24xx_serial_tx_dma_complete() or the PIO TX IRQ
handler s3c24xx_serial_tx_irq()) also acquire port->lock prior to
calling it. (Note that s3c24xx_serial_start_tx() is only invoked by the
serial core).

However, s3c24xx_serial_rx_enable() and s3c24xx_serial_rx_disable()
unconditionally attempt to acquire port->lock again using
uart_port_lock_irqsave(). Since spinlocks are not recursive, this
causes a deadlock on the same CPU when console flow control is engaged.

Remove the redundant lock acquisition from both rx helper functions.

Cc: stable@vger.kernel.org
Fixes: b497549a035c ("[ARM] S3C24XX: Split serial driver into core and per-cpu drivers")
Reported-by: John Ogness <john.ogness@linutronix.de>
Closes: https://sashiko.dev/#/patchset/20260506121606.5805-1-john.ogness%40linutronix.de [1]
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/tty/serial/samsung_tty.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 2f94fc798cff..63d0232dffc2 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -245,12 +245,9 @@ static bool s3c24xx_serial_txempty_nofifo(const struct uart_port *port)
 static void s3c24xx_serial_rx_enable(struct uart_port *port)
 {
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
-	unsigned long flags;
 	int count = 10000;
 	u32 ucon, ufcon;
 
-	uart_port_lock_irqsave(port, &flags);
-
 	while (--count && !s3c24xx_serial_txempty_nofifo(port))
 		udelay(100);
 
@@ -263,23 +260,18 @@ static void s3c24xx_serial_rx_enable(struct uart_port *port)
 	wr_regl(port, S3C2410_UCON, ucon);
 
 	ourport->rx_enabled = 1;
-	uart_port_unlock_irqrestore(port, flags);
 }
 
 static void s3c24xx_serial_rx_disable(struct uart_port *port)
 {
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
-	unsigned long flags;
 	u32 ucon;
 
-	uart_port_lock_irqsave(port, &flags);
-
 	ucon = rd_regl(port, S3C2410_UCON);
 	ucon &= ~S3C2410_UCON_RXIRQMODE;
 	wr_regl(port, S3C2410_UCON, ucon);
 
 	ourport->rx_enabled = 0;
-	uart_port_unlock_irqrestore(port, flags);
 }
 
 static void s3c24xx_serial_stop_tx(struct uart_port *port)

---
base-commit: 16e95bfb79b5d9d01dc7651d98caf3c2ace331cd
change-id: 20260515-samsung-tty-flow-control-deadlock-1d426171bf41

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>


