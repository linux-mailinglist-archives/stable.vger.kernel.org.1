Return-Path: <stable+bounces-238172-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBFbKbzM32lwZAAAu9opvQ
	(envelope-from <stable+bounces-238172-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 19:37:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 12230406D81
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 19:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94EDB30263E5
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 17:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD533E3D9A;
	Wed, 15 Apr 2026 17:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vjx5rT3R"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A72637268D
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 17:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776274617; cv=none; b=ojtJnrVHnGh346hQi1WOYrk3CRpzPzxhXNya+bt4tYPnypKzUyrI4kPMhPdSdUFPyhVSZcNq8SiI1Q5vZyGhI1eU6aJbnmnFatbnccNP5/qb4ylAlykq5nUTgGDchbjvwkB66WMuCIuilBCiF2uTOaRAvSWyPbfxCMil5N6U+yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776274617; c=relaxed/simple;
	bh=bA0YOmRdTf8lHrEqsCcgLCiC6Qt/bbKa5pnwwqjZpqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ixiotwqg2Q7eVIFGcCuDJ+xi8mLjHS14rwKi168Py2Qbv0+9UUENybHelHkh391lN7XoiP0ZSaEx8oLfI3lMGgTOOj1mqPYnD/qXPP5GxY0dMfntAYZo59BK9sTmDVWeF08RecpPXT7RqvSPZcPVy8niGS3H0pS94XqyeTVCV30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vjx5rT3R; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82f1f6103afso2250796b3a.1
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 10:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776274614; x=1776879414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H/+TVnN1GkzXWBQnr1PT9tBUGuFu3f8nhPggRnsX4wE=;
        b=Vjx5rT3Rcl7o62BI1MYke7TIn6RnkyEJPSkdvv4lD94IjTGJfYV5hJeRK+V2lGXi83
         7GaR9vhglsUWWr3hABBQChM+DHh0B+u/9IP5OWgQoUPRIgxgDi7xPRjKYVOu6fgdpcc5
         JIub/MjkA4mky32jHZG++doLfRyP5hPTX/oBTmZbCUzxWE2rYxhFPe1vT/LKMZWeJc1B
         BlE4HkXSJXyoa/5VdI+wwIR4G47bmGgHC0vGdoigmSBmdgA6XVsSEiLWTxTMMREhzZzJ
         XMfGaD6nKrrWgdiLydgwYaqwq4dCt1kpTo9G4xvcpy/G3WmV+zw9ilK2fR2kYrxESUii
         w0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776274614; x=1776879414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/+TVnN1GkzXWBQnr1PT9tBUGuFu3f8nhPggRnsX4wE=;
        b=Spx1YtpLux95cT9C5YZ64v0TePMZL41vM4u5B2riC5npc/sL6hqjMcGxrA/EYy7MDu
         3iorN+kHWFaPIC28STJUB1P2sAk+lZi9lf27elVP5f4Lr9G7S4d7xWjGqY2WO2mZvAFm
         uW/eTwXn/FIAHPz5eTm27s11pibdPxTm28CsM/20At4p8u5EUENlPjen2wLozCahX70M
         fY7qll3GaN7HoV+m8xVrx5+mj25vBRTvnpx1WRTAKTYvwdzhMgogmRnNYxaO5t+/69vR
         KiS+O4RmpL3XTe/QEMvhgWQNOr0gxSMry+GJwlS6NfDZNczFWgaS/5SUMWqozo8fB5ig
         9dKQ==
X-Gm-Message-State: AOJu0Yywm40hVzSPBSOO5V/t764hjha/8UiRA+F3xsE0j1GMwBWTGMan
	N8ZlVlgL+NXp+rJ6FrtNns6+le4uXDedSJyDXGwsbKZjYzb0EW8bpSRu
X-Gm-Gg: AeBDietZwfdez95S3UuIu8JX873NbPRu/Ge2trXOhC+bJ2mDdgOrmmrqxDP7NPTM51k
	IF6KsHfGxFaAwn4a+N5JmdsX4FNn43NnwTDp3yo5LFB5F3QieAvUaNgm2GMUM2eiV1otkI5vTUH
	xCJvAarHHNIPDk5ekMy0k4cDDdSnkdEO4s/IVTHOllBEaozskMIT0Ai93nMbnFEIzLOAXVOBSBR
	nPGdzP2Cm836vCgws+o8qnYM4Awhi7J9GqMWD4b05mr0CT8oW+PRceCVbAVUJWA1o6nnIIrY6Uc
	moZK2+nyzoQp9tnswx2Pedkiy4FpNViJEkfwv2z3J91l3wX3pTUlITNaF/B9XuiggisYw8CPRgK
	CLZkYcuh/FgTcNvVeerBKlNQzJddWcy8zXI+V7hMEAtyhhxM2dFEH7pBkqKDNt+dkEEABG1RZ69
	zKg62NKZ9NhL3uWqCf9b3YSiHGAIizLrGZZnPQ
X-Received: by 2002:a05:6a00:10d1:b0:829:8cfb:df45 with SMTP id d2e1a72fcca58-82f0c29ed5dmr20427786b3a.15.1776274614586;
        Wed, 15 Apr 2026 10:36:54 -0700 (PDT)
Received: from lgs.. ([2409:893d:1171:10e2:48dd:8f21:beaa:cec8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f6703631dsm2739863b3a.3.2026.04.15.10.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 10:36:54 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] pcmcia: tcic: fix init_tcic() error handling
Date: Thu, 16 Apr 2026 01:36:42 +0800
Message-ID: <20260415173642.3619223-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238172-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[dominikbrodowski.net,gmail.com,vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 12230406D81
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When platform_device_register() fails in init_tcic(), the embedded
struct device in tcic_device has already been initialized by
device_initialize(), but the failure path does not drop the device
reference for the current platform device:

  init_tcic()
    -> platform_device_register(&tcic_device)
       -> device_initialize(&tcic_device.dev)
       -> setup_pdev_dma_masks(&tcic_device)
       -> platform_device_add(&tcic_device)

This leads to a reference leak when platform_device_register() fails.

The reference leak was identified by a static analysis tool I developed
and confirmed by manual review. While reviewing the code, I also found
that init_tcic() continues to use tcic_device.dev as the parent for
registered sockets even if platform device registration fails, and that
the pcmcia_register_socket() failure path only unregisters the first
socket instead of rolling back all previously registered sockets.

Fix all of these issues by checking the return value from
platform_device_register(), calling platform_device_put() on failure,
stopping the initialization immediately, and properly unwinding already
registered sockets and other resources on later failures.

Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/pcmcia/tcic.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/pcmcia/tcic.c b/drivers/pcmcia/tcic.c
index 060aed0edc65..43bda9930645 100644
--- a/drivers/pcmcia/tcic.c
+++ b/drivers/pcmcia/tcic.c
@@ -362,6 +362,7 @@ static int __init init_tcic(void)
 {
     int i, sock, ret = 0;
     u_int mask, scan;
+	bool irq_registered = false;
 
     if (platform_driver_register(&tcic_driver))
 	return -1;
@@ -464,8 +465,10 @@ static int __init init_tcic(void)
 	for (i = 15; i > 0; i--)
 	    if ((cs_mask & (1 << i)) &&
 		(request_irq(i, tcic_interrupt, 0, "tcic",
-			     tcic_interrupt) == 0))
+				tcic_interrupt) == 0)) {
+		irq_registered = true;
 		break;
+		}
 	cs_irq = i;
 	if (cs_irq == 0) poll_interval = HZ;
     }
@@ -486,20 +489,33 @@ static int __init init_tcic(void)
     /* jump start interrupt handler, if needed */
     tcic_interrupt(0, NULL);
 
-    platform_device_register(&tcic_device);
+	ret = platform_device_register(&tcic_device);
+	if (ret) {
+		platform_device_put(&tcic_device);
+		goto out_cleanup;
+	}
 
     for (i = 0; i < sockets; i++) {
 	    socket_table[i].socket.ops = &tcic_operations;
 	    socket_table[i].socket.resource_ops = &pccard_nonstatic_ops;
 	    socket_table[i].socket.dev.parent = &tcic_device.dev;
 	    ret = pcmcia_register_socket(&socket_table[i].socket);
-	    if (ret && i)
-		    pcmcia_unregister_socket(&socket_table[0].socket);
+		if (ret)
+			goto out_unregister_sockets;
     }
     
     return ret;
 
-    return 0;
+out_unregister_sockets:
+	while (i--)
+		pcmcia_unregister_socket(&socket_table[i].socket);
+	platform_device_unregister(&tcic_device);
+out_cleanup:
+	if (irq_registered)
+		free_irq(cs_irq, tcic_interrupt);
+	release_region(tcic_base, 16);
+	platform_driver_unregister(&tcic_driver);
+	return ret;
     
 } /* init_tcic */
 
-- 
2.43.0


