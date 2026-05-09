Return-Path: <stable+bounces-244879-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eH63FVWR/mlyswAAu9opvQ
	(envelope-from <stable+bounces-244879-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 03:43:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF84D4FD5D4
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 03:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 576D6300A310
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 01:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A6127F19F;
	Sat,  9 May 2026 01:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECVcODfp"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7B018A92F
	for <stable@vger.kernel.org>; Sat,  9 May 2026 01:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778291025; cv=none; b=YdusFJJz4ntmd62vNVrQMf5thl+LNclV5LvGrqNSPXYiOyMOVIgXXmfKLPBNiN9D58VOcpg9uGIQLBboi4dk3VHKb5/ulFLsbmgAwZxZGCQJlwYd4gYAP3DUtFzFPBnr+XFtbFW1dpurhieZjZ9JeKWLcsETKJ88kWh77vtrOeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778291025; c=relaxed/simple;
	bh=gZcvL712PtEp/DN5bfBX90/0l6jiDpx5pdukpqsGraw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XQtq0Ilz3Qqz8GO25OZQFMvVa+2fIswnVzm1LMqz1onDcimkZb4rNk26IVkhy8NseaBTK7sheFuUD0hEDRY0F0UVh0rAB9eo1ttxPDDLbYhWP8tn0nmffBQnB4SkGiwgDNzXvC6jfCNtnrFiUfGPepnMBqAMBWJ+0MuVDkV8az8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECVcODfp; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-2f3c623322bso4228143eec.0
        for <stable@vger.kernel.org>; Fri, 08 May 2026 18:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778291023; x=1778895823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zJhfFQR9+98S4XKgeWbqpNJRqJ3OzaJN3o2IixMMcYk=;
        b=ECVcODfpxEKhvYBej3QkODP+1HEuYZd8uWDtMX0SOolvoTKGLlBXBVVzPC2Fp+kuah
         u2G6sAMbKCKRP25KJqsJsCmdF7yDVGpmXXt94Mkmlx7aTwoDVldP5vOcNTAiuuZ/Zs6p
         ySlLsd4GAdBUwj5TVhYm0FbZT+8Xbhe23mdG4cMEMQr5X/nHUX3MWI9r9G3W/h8bRV67
         dOJ/zYnHA9nzOetwKf+57tU6+3fNONmrBUruxC3SZhufabUC58XIk9E/WkuLIAKJk1CA
         j0n8jUK2nHRnanDK/ge2qh39j1nvERtRjJEU/TWSSU8kMdUZ/EUFgGyQ+P2iCGQqcRrt
         bQiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778291023; x=1778895823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJhfFQR9+98S4XKgeWbqpNJRqJ3OzaJN3o2IixMMcYk=;
        b=Xt4iTrNGpkJhFrmvbukVbsQEAyb1iUNMKGrDvyAthSvKJ0epTx+zb0HpW2xY9Qgudv
         2+CrcLnt9r3FKzT/U212r5yrbRBc8caXtUME6RCTjW/jP5CyRF04q+FkpzGTgsLFRh3P
         b9u9gBl0U8oFS0fspGiIP8BZekbzakUk3uv3y7rqpoiNowEthPucqRiBibyzTLy90eef
         gQKh6KYMHCuANuy2SBQQewT36JY5BN8+VkIcmIMIoxtB/i4JYt2UDoHkIRGiFXl3Q7Ig
         aGZSIpNqCjqaZshlcHlkOsQGqtxPMmseXsNpvJ5HuDd6oRiXU1EZkvsDf9lUx5XeLIvH
         Gosw==
X-Forwarded-Encrypted: i=1; AFNElJ/QnQvxO1vdLKIO0nNSbqukGM0uWQS41M3BV4HHqdGWHf6sukC+oRSx9XtY/g3nIDcWWdpF3OA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvMLi2zsO0N8FQqrvxpnWF2bTTi/dXxgW3BGdl4WibffACLQTt
	nrHSLLROG7wKIB6ulm51qvIr/GcewMc1RbaWWs3jT28vaPxAqgdsjORo
X-Gm-Gg: Acq92OEgIB5RCHScnfFW/BYHqcKKhxflnzZRVMSkxWD+OBf9+suksM67x9Jt+NMTkS4
	FEsJlXfkxed855ILTDz4VIK0PKu8iPsp+3QsPIaRJjph+Qt9DLGf03oqe3iZPBZUcDNapnsIn7g
	32G9JTZodZQWwjtlJzzsCSGIPyXJXvfKQCLp3Q4r3F+DzJ7iqCqeCFc6DppMjI8/mV3Q+SZ2iIS
	5wS4W0b8k7EUiTdtRvhU1tzhzcBb3dTjfBmOQuIKmKcGHYMGYuYlC4+ePfvbrYyQPVaHlpampPS
	U6yi95Fw5mmE1CIf9lgXBJ5IvejnYYoesmAxNHw0ANBfw4Y89OqmBzwh9Y2JS+g9eGBwKCZxntT
	zJnFU270Qc396esbEx/u4F7jmhA/8Qt+85aPKUQVmQz+yR4Kkdi1sWqnmRrYDfcPz5f0ySrh8KV
	CyAwbCkzW0/s4FE+45h6feZngHe9ekF9QgfAdiwHHDFVAFsyiKWNf9/s2IQwqDCOHh2mdZ5gTfn
	b714xL+r2mm4EZ6OKqT0MCiivr4J3WsqWDrNhfllMn+nHx/g4fkPF0m+pV1Rta6i+qLx3VrdisE
	VNgDGNfklndsax5Y7g==
X-Received: by 2002:a05:7300:6da5:b0:2ed:e12:376e with SMTP id 5a478bee46e88-2f54d67a686mr7456372eec.30.1778291022819;
        Fri, 08 May 2026 18:43:42 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8893441absm5991640eec.31.2026.05.08.18.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 18:43:42 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-omap@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	stable@vger.kernel.org,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Lee Jones <lee@kernel.org>,
	Jon Hunter <jon-hunter@ti.com>,
	Benoit Cousson <benoit.cousson@linaro.org>
Subject: [PATCH] mfd: twl4030-power: fix stale ARM machine ID checks to use the DT
Date: Fri,  8 May 2026 18:42:46 -0700
Message-ID: <20260509014246.21649-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EF84D4FD5D4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[armlinux.org.uk,gmail.com,vger.kernel.org,iki.fi,kemnade.info,baylibre.com,kernel.org,atomide.com,ti.com,linaro.org];
	TAGGED_FROM(0.00)[bounces-244879-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The twl4030-power driver contains two checks for ARM machine IDs via
machine_is_*() macros. These checks are incorrect because the two
platforms concerned now support only FDT booting, which does not use
machine IDs, and therefore they will always fail. The legacy board
files for these machines were removed in commit 1b383f44aabc ("ARM:
OMAP2+: Drop board file for 3430sdp") and commit e92fc4f04a34 ("ARM:
OMAP2+: Drop legacy board file for LDP"). To resolve this issue, use
of_machine_is_compatible() instead.

Fixes: 678fac419382 ("ARM: dts: OMAP3: Add support for OMAP3430 SDP board")
Fixes: bd5fc6fa657c ("ARM: dts: Add basic support for omap3 LDP zoom1 labrador")
Cc: stable@vger.kernel.org
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/mfd/twl4030-power.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index 0bca948ab6ba..fc1cf316c236 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -30,8 +30,6 @@
 #include <linux/property.h>
 #include <linux/of.h>
 
-#include <asm/mach-types.h>
-
 static u8 twl4030_start_script_address = 0x2b;
 
 /* Register bits for P1, P2 and P3_SW_EVENTS */
@@ -294,8 +292,8 @@ twl4030_config_wakeup12_sequence(const struct twl4030_power_data *pdata,
 	if (err)
 		goto out;
 
-	if (pdata->ac_charger_quirk || machine_is_omap_3430sdp() ||
-	    machine_is_omap_ldp()) {
+	if (pdata->ac_charger_quirk || of_machine_is_compatible("ti,omap3430-sdp") ||
+	    of_machine_is_compatible("ti,omap3-ldp")) {
 		/* Disabling AC charger effect on sleep-active transitions */
 		err = twl_i2c_read_u8(TWL_MODULE_PM_MASTER, &data,
 				      R_CFG_P1_TRANSITION);
-- 
2.43.0


