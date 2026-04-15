Return-Path: <stable+bounces-238184-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Q8KxABTb32mcZgAAu9opvQ
	(envelope-from <stable+bounces-238184-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 20:38:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F095407226
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 20:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E5003028F52
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 18:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA592381B14;
	Wed, 15 Apr 2026 18:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgMkqVhp"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728A3332906
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 18:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776278288; cv=none; b=Bs71K92umu/u/SDdWSRyPdYynHlk0z70HktNrgALgLeIZVvvZ3nOC+eFQbd+fY886kaCeOn+88xvkhmnpR618pYWV7bc1eZdTrdPLNrhSEuSw24SiHOtFGdcBqFgg5W/vXlFFBCfUAeVa1vgzbR9zrnd0XvJS4u653c1jFHiKOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776278288; c=relaxed/simple;
	bh=9RSII71/jNnvAOcFmcfnWZ0Y9rCchJepmkQZ7efG4JA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nMfFiiTGaC/uy54FRtQ9gKnS1kPa46zRfkEWMR6kBcTRnmh6+NJhsqDPMDoqs+nJ8a246rVaWySbxC+lKrOVeT2riN4Xa1koR1OIzPmOc3oqnKsXmBN//PLbB8KSipJKGDLfCWmVqiee6bgpH7eeOBD3kNCFX1e2Cgn9Po3eU7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JgMkqVhp; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82f37c09352so2701609b3a.0
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 11:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776278287; x=1776883087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4ZTI/wYqnqWn46+oi6fQh//I+QeN1uMmyxPHBv5EkQ=;
        b=JgMkqVhpgm3LLmArRPiCLbO6vyal9M0LC5x287tYgUigKrwzYQK3iItVFr1xHrf6nj
         6BqEQ4wlxRxdg5uqj1+4x4XeCwdqdOb8Cp252usHezcwIT7ZOKFa5lP051lZ5gOkFXhN
         o8KT1MHCNeJS7FzGGN9329bdJfeL3HiiDkyj1WCo1ds3lAM43E/a5o9kCgxtPOrztMyS
         do59b2j2W6HR/igAyp9nT5uRh7KcOhAIQxuVf9D44atThGH20yHU9+wxbKuhyPlLF0BI
         5N7EdCvFur+G4a8zJMawlw+0vtR+PkQsuE73UPUQA50QNbyTGOinkFOrX66vj7vYgxfL
         KweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776278287; x=1776883087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4ZTI/wYqnqWn46+oi6fQh//I+QeN1uMmyxPHBv5EkQ=;
        b=dK+wjh4Kcb86VIQxffI21oFDIxrWtqS4uwY54lhVS0Oh66qD/5pZ3M42jur2w9/or3
         j7u7tEf8tD04glMylTxA0O2H5RU7a7qJQbk1Fn2err4GS0QmwsENubfKPT3bYO1C6HnI
         ujWwnXK7b4DA7Mj15H/4Ivb3rXWx87Od52Idgqn6zLQB1HCOyi6tCXyEgoeiGsVPKchR
         XK/BBHNrEPnBugKLjRKZ9j8bZzdi3HqLrKwGFy99f8nmpfrjQqGN/NVLS21/whzNLaNp
         L7cAP+aHT3HOM0uaWHTCLUoXZrgITq1JYG4+LmzFCRJU9CzZmLIU0Zn6kyM1SZqGH4rV
         EQTQ==
X-Gm-Message-State: AOJu0YxfKGt65kH+/ZMRgPpPfp3Tt6C1uOzDIc29DCXv6RQpPvUGMsiO
	nQkQ2oAb5LmZdSINGC1oWNSDctxC+6rdWuip9F+Yt2OEEckKgk3+vR+9
X-Gm-Gg: AeBDietHTaMqvsfAoB5rgYdZUYaiESLIva3g0TnhmHBeoOZy/NuJwG4p98560VLouqf
	9QN6WTXW+86oddD0yYJql9ZjmMrtIXQB6Es2i40bqNj8dtdT/YZhB4PEt5bpzYitBdLlO5pfRO4
	6xIJZ3bDHROG02S/MzgNLEmZR6ArmA7q7BIpHyTX2M+RBq7blDt+H0VrbGPAAj0zF92ksFAvkLW
	lNiFYgAhRfpKHqCqHcrPOMlAJFr/mensVHSe1L/H7CwpZvM1Fbf9yPoexnuvHSp4ktr7sZD393A
	DC6fy80OCyhvXq1Gi3Eo/ymwcmyM6bt+a9cyn41nSCAAkvlZhs7SQaZszR9+PPSuqv220r9uxN4
	aMO2yHmoKplcRJkP3fcYRPM5GAij6azO9DOImtRaenVSy3RpVu8nAr5D+yRM69oJbD8RoZYNMqJ
	Yy+Q29mjH728EsYCnHKSGsYRQ4yuXYeyC6kxs=
X-Received: by 2002:a05:6a21:6da0:b0:39b:8e94:c4b2 with SMTP id adf61e73a8af0-3a06d17e69cmr551491637.12.1776278286823;
        Wed, 15 Apr 2026 11:38:06 -0700 (PDT)
Received: from lgs.. ([2409:893d:1171:10e2:93ee:194:b07d:a9b2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f6707b717sm2546151b3a.21.2026.04.15.11.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 11:38:06 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Russell King <rmk@dyn-67.arm.linux.org.uk>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] serial: 8250_boca: fix reference leak on failed device registration
Date: Thu, 16 Apr 2026 02:37:55 +0800
Message-ID: <20260415183756.3770073-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238184-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,gmail.com,dyn-67.arm.linux.org.uk,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 5F095407226
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When platform_device_register() fails in boca_init(), the embedded
struct device in boca_device has already been initialized by
device_initialize(), but the failure path returns the error without
dropping the device reference for the current platform device:

  boca_init()
    -> platform_device_register(&boca_device)
       -> device_initialize(&boca_device.dev)
       -> setup_pdev_dma_masks(&boca_device)
       -> platform_device_add(&boca_device)

This leads to a reference leak when platform_device_register() fails.
Fix this by calling platform_device_put() before returning the error.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: ec9f47cd6a14c ("[PATCH] Serial: Split 8250 port table")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/tty/serial/8250/8250_boca.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_boca.c b/drivers/tty/serial/8250/8250_boca.c
index a9b97c034653..70ea8e30ae80 100644
--- a/drivers/tty/serial/8250/8250_boca.c
+++ b/drivers/tty/serial/8250/8250_boca.c
@@ -39,7 +39,13 @@ static struct platform_device boca_device = {
 
 static int __init boca_init(void)
 {
-	return platform_device_register(&boca_device);
+	int ret;
+
+	ret = platform_device_register(&boca_device);
+	if (ret)
+		platform_device_put(&boca_device);
+
+	return ret;
 }
 
 module_init(boca_init);
-- 
2.43.0


