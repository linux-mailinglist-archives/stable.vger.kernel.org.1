Return-Path: <stable+bounces-244888-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FepLsSZ/mn0tQAAu9opvQ
	(envelope-from <stable+bounces-244888-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 04:19:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FAD4FD984
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 04:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 58835300493B
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 02:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076722C0298;
	Sat,  9 May 2026 02:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyTRX4yI"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE3F2BE656
	for <stable@vger.kernel.org>; Sat,  9 May 2026 02:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778293185; cv=none; b=dUTX7zVkjAC7eKJrm53YcZJOPL83v5moMcUKv5+cTda73L0y+Os9ykXtH2cYeV2Nn6M0aqJWj4FDDDLCdy+2uLdPPMEqzH9uCGRQ+FhKQMcqiP4VHcttOno9Hlai464J0M7Yp+4UZNUlH3+NRzmil9HCIvcgtf+d0QJkgk6QC6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778293185; c=relaxed/simple;
	bh=kTfUgBhBHNuBtL9eJOgwzYGCFRBPPNjKq226/ZPUROE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fd1hsF0+Og9K06xwAjBBB9QSbZP8kxUbKBMiyzLgx1yudEgmj0X9NxcqumR2//PbyyQ3G1AfP1w/26GNdW6kavCHlYTuBtodhFrkHxLWM2oAp0vchqJ5xj9vCilDoGmJ+bnq8A4sqAc2HN59hSikWi7tE9UwC91NklN6dOVaYmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EyTRX4yI; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-2ef2a1cc06dso1812450eec.0
        for <stable@vger.kernel.org>; Fri, 08 May 2026 19:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778293183; x=1778897983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7rx5oAgzTfQrxNSItVjPyuKjULjUzEucljH1SJ8cUBc=;
        b=EyTRX4yIyXBdvHtGkI4sK/HhCikELmksbuPv/j9nXjrdy+Qy+aV2NcvJ5Fvq7a0rqw
         r/5H09wO3ofq4ozg95TRkLvNZkSUz5nnVhiBeOsU40DfAdkG92DMpg42kRkVm7/CYFTj
         9jQ4LhePHb94b8dgBtkx+nB1yM/7HgUkB9H/Q3Y6TUgc9lEMa4KgwzxptdcajcqhA54u
         engSjjGUPy+Se73DANH9yJWFHESt8BzkbQZu2aWHFBTuojWOYa1pgdrg1M3xVfhY794y
         5nvct9BN1W1uEYlEqElolVOAfF2CGoOt4w5FRw+AhWQ24reokF6l89awRz5t9/4XxSuX
         2Y3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778293183; x=1778897983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rx5oAgzTfQrxNSItVjPyuKjULjUzEucljH1SJ8cUBc=;
        b=nJiznXtewYLK0ASjp/IEL2HP+cWxPVhNwNieZi+GQKU5eRe1T9qty1IndzdroZeSpw
         495oQSMQg0hUd1Dlmeh15NNnG4YtS8KyRIPxZ7h+bcRjE3aagxjQiUv+15ukLPAgLl4l
         YBNJWAS0w09qG5nAabRYcRQpDbPvumTnQn+fx22JWApNPsLWWo3J9ZD9a3/oZ/99GATb
         FVXK5F5BFmASzBFgKS6f7Y7XKng85ElgxGJV0XR3TQ53p2LcRfPL9YOOenqVJtxEQaX2
         HH4AfpY5KA9OlW5dW93r0KyJf/2tj91HgkY4iE2N8YQ5svoNITj4wsTDA96N8fGeUgyR
         kJKQ==
X-Forwarded-Encrypted: i=1; AFNElJ82GL31KE+mZHvvRbMY4LeBtNlzclbhoip8rywNFxkqbxDuciXjc+EaPColcMy5itk/QlhEBpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfRCWnHozYToo4nCiKOkQycjUR9RmKnlIHmhZMmTx9jLyehxzQ
	6zmOs3MBXTNjH6Bn80PHvtwU60PCWIGfxGbmXf/JhBB300Zv+RXh+1MR
X-Gm-Gg: Acq92OFDHaloB9vMrzaAJtv6OssPn0AxEPTAqVI9Fmz8r8bHG2Y7p7nYCrQENaDmdn+
	DekGI1nlc3ksmA+vc1ymG7J30RKJQprZrHMz3woJ5j4Iap1JZnr0+QR6rWUu6dtx7490k3//V1+
	IsqSWiBQmWWErk5AJu1pwfasN1/QzdFL/cNV4dsIdzEeVbV7FBukDfoFzq4xk02B7QGqwrNe0z6
	Jpg2q/SFLoN/U+f0v91U9QauYH2bmtKMzkWd2IUKBFZ/J83HX0H10cP56WxtCZtpp8DMBJWy/CO
	zxIY0syGWshTHGBqtwtB1ELxRxZy2KdIWS7LCkoN5JYipXAGHBUEerZndKN8BoI0VYHVo/9roTx
	NZmtDvMu5e75ddxobKVtm/nmEXyvasg29Dj3bUWgFB1SUsMJPlNg9u8NkTYbNUKOLlU5D2zNsH0
	Wp49+vt8E9IJvshZOhJKu9D3woIs78qO710Daf5ntW/lCiFlqSfqVpkboVditeYM6JYs0Pe4OBd
	gZpXAhozJsSMUndcnk4RNle1ICUMNecyZhp+ieNMSyUOWSn6Q8ENp6JsMqT+t2Mdj7Q+13rwffH
	6EN64xFaGDCXf38vCw==
X-Received: by 2002:a05:693c:2c11:b0:2df:7b88:a1b0 with SMTP id 5a478bee46e88-2fb4bdffa79mr234663eec.27.1778293183198;
        Fri, 08 May 2026 19:19:43 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8860c7accsm4775298eec.8.2026.05.08.19.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 19:19:42 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	stable@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH] arm: orion5x: correct machine ID check in mss2_pci_init() to use DT
Date: Fri,  8 May 2026 19:19:34 -0700
Message-ID: <20260509021935.36898-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 57FAD4FD984
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,gmail.com,vger.kernel.org,lunn.ch,bootlin.com,free-electrons.com,lakedaemon.net];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244888-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The mss2_pci_init() function contains a check for the ARM machine ID
via the machine_is_mss2() macro. This check is incorrect because the
machine concerned now supports only FDT booting, which does not use
machine IDs, and therefore it will always fail. The machine was
converted to FDT booting in commit fbf04d814d0a ("ARM: orion5x: convert
Maxtor Shared Storage II to the Device Tree"). To resolve this issue,
use of_machine_is_compatible() instead.

Fixes: fbf04d814d0a ("ARM: orion5x: convert Maxtor Shared Storage II to the Device Tree")
Cc: stable@vger.kernel.org
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 arch/arm/mach-orion5x/board-mss2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-orion5x/board-mss2.c b/arch/arm/mach-orion5x/board-mss2.c
index 9e3d69891d2f..322ae29d05aa 100644
--- a/arch/arm/mach-orion5x/board-mss2.c
+++ b/arch/arm/mach-orion5x/board-mss2.c
@@ -10,7 +10,7 @@
 #include <linux/platform_device.h>
 #include <linux/pci.h>
 #include <linux/irq.h>
-#include <asm/mach-types.h>
+#include <linux/of.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
 #include "orion5x.h"
@@ -47,7 +47,7 @@ static struct hw_pci mss2_pci __initdata = {
 
 static int __init mss2_pci_init(void)
 {
-	if (machine_is_mss2())
+	if (of_machine_is_compatible("maxtor,shared-storage-2"))
 		pci_common_init(&mss2_pci);
 
 	return 0;
-- 
2.43.0


