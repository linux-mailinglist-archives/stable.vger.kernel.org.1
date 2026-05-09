Return-Path: <stable+bounces-244883-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMJ2Mx6X/ml5tAAAu9opvQ
	(envelope-from <stable+bounces-244883-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 04:08:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D9A4FD895
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 04:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DA745300B1F2
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 02:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F04A283C89;
	Sat,  9 May 2026 02:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMLe8EDF"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE3822CBE6
	for <stable@vger.kernel.org>; Sat,  9 May 2026 02:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778292507; cv=none; b=tY5cdqnkW7G52MbfxaadUcY8TKSOp9vEN53Anm+wExf6ddsbEejHNpvthT5nHKwllDTNkeSe6wZM2IwAl5cPzJVvbq1L2n3gD3iwK0UvPDhHMWPOG/too0Mm6pshYrDwWH7DsiIhLAmY8IXtzh97UUUiQMuEOKDxyDeS9hTmT6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778292507; c=relaxed/simple;
	bh=SU+hHyKOv1UwoAy5W/MYlY8U0fwS9OgvizqU7s+S1vM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m8Sz0kd5nSbrjHrxvkOPGIN5wkW4zeqnl/b4midl5KeUE0RTDO9KnIlmBKVdWfSiBBPcgrFYpub9fN9FiBxmDD42B2seSmsRip4nNccYoCQNCAxNgmsiclMGTs+nke+5mksoQpN/D5UAItRdBgAZ/puCPCpObbOW/gi2JHhOUXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMLe8EDF; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2ecf9e398f4so6776899eec.1
        for <stable@vger.kernel.org>; Fri, 08 May 2026 19:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778292505; x=1778897305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+bFJzQA8V6grxSKW5mpCmQoAxXzJUQzk3wcMN3B8fCY=;
        b=HMLe8EDF6M6PXnLNN+GnJSMrPyi++6jeE9feeHByf1C6KK6iTGV8aW26booz70YwP8
         LQBWKEZRuGtbFVDtuiifqOg6rP6+S95KxPKW1kC3g7Vr+CTQ9z15cNme6BPxmGo94Jmd
         0Hbj+HF8vE7woEcxWraj0/LfATzoC8A6uWlpakT5fh39WFHizDeXMJS4jdFXz6gHqLZc
         lkfQpqbAW+Ent7pWlwcEGZfcWcSt3i4IJ8/TI5yJH+txv/gfiFgygnNErJUiFvxEgM8B
         KNtcbor5GUpIaJOYVh2DdMvR15YowKEAYRj7h1LD/jyjnXCNaeUF8GKRqia7pTI6jML1
         P3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778292505; x=1778897305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bFJzQA8V6grxSKW5mpCmQoAxXzJUQzk3wcMN3B8fCY=;
        b=h2U7CnPinaIf2bAbFSisYiZobV+FRvq71L2hAnSeHkB8ubIFTz1L9ekjtqdcsaVtaA
         6CjWOq8pptYHPR2ZYkYMxcWSUGNNLoMJkLYqKwOgFPtqpU29W2c3zAN1N3jRZOXrNSHK
         z++ykvG0G7UXbOGE53MmGZr8HP9Jnx3dFE7Q7yFFir8dal849eSaKjNyAvcxEMNNMoSN
         xOtpeyJvIjyybEbFdlId2Hgj2KdQJnSM9XbJIBbt4XfIAbdxp5VxniVzYONEu9+WynUd
         jZcCCBKjsBhYzTU3c+csJqYVzepA+P/YBS78eecUsBkafkDy8QD5x+EpjJj7h+19N4I2
         3SuQ==
X-Forwarded-Encrypted: i=1; AFNElJ+W+fk/aKbSGpR1vJkHdpg9BZM2q3golowx1/wuAYMf2VX7WefNOR/NJruzHgW+jLQ5L5rx82Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXOZ+UnixYxtbsefpRaiIpZkTH5Hy27qpse2akqqlosmW+hcfm
	t4Py0EVTryjJh+YyOhFE9x/fwVmWUT4RN2qOLhRb5fALA0q1X7alR95t
X-Gm-Gg: Acq92OElnVdiw/7TQVXfXKVBgxqLYsc2KgyCfH5EVcVakigvtn0ASWZ/5tO6rVuar14
	O94a2rygwslvdOBIN7Euui6YcnJ4bDK6Ar+hQYms4F4N5z05zQY+57Va+0TFCVId8p3KoDUmf6Y
	mXyiNRWWgeC3sOY4j1ou+FBqjMgM/m8q2eo9f/WVja0c0OFqjAHc2ky9RbirKSQgZX2jL3uk+of
	WyLayjGYVRgRbVAad2K8e+DR9Eq6+CqE91sT4wpY8bFJN1cPGd+F0vcKaviLuI967XSKIt784SL
	n+uJu1h3VvlDoi0swCPxozkft+ufOG/Z180OQliMnAe79tOy26gDi8YCKprhP6zga7LVMAKGu5k
	3EK5KbAS23BY0z6LPR8LOWh9VvvvHOAtAuyY7v3HsT1F2kd3pYn8mqtV+WSyCKbXtdYJudAPLtn
	x2pQKl/tEThoRnClLVCuKiB2S2TUDO/pS3gzyBjbFCd7IPeGSTY+QDzfFm1S0RBzjdrvN1LNKtD
	a4SJIvoJ6eM0F2GpGmHEnv1SbehLVtmTQ+5Fm6BLQ7OgZRr4uUVmkvZ6r0wFDDMsVZpqfNrPBlb
	RMeGFgWADKZY2OWBUQ==
X-Received: by 2002:a05:7301:e0b:b0:2e6:e504:5431 with SMTP id 5a478bee46e88-2f54cc681b9mr7932458eec.22.1778292505264;
        Fri, 08 May 2026 19:08:25 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f88847502fsm5423080eec.14.2026.05.08.19.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 19:08:24 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-sound@vger.kernel.org,
	linux-omap@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	stable@vger.kernel.org,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Jarkko Nikula <jarkko.nikula@bitmer.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Grazvydas Ignotas <notasas@gmail.com>,
	"H. Nikolaus Schaller" <hns@goldelico.com>,
	Tony Lindgren <tony@atomide.com>
Subject: [PATCH] sound: soc: ti: omap3pandora: fix stale ARM machine ID check to use DT
Date: Fri,  8 May 2026 19:08:08 -0700
Message-ID: <20260509020809.33060-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 73D9A4FD895
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,gmail.com,vger.kernel.org,bitmer.com,kernel.org,perex.cz,suse.com,goldelico.com,atomide.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-244883-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The omap3pandora driver contains a check for the ARM machine ID via the
machine_is_omap3_pandora() macro. This check is incorrect because the
machine concerned now supports only FDT booting, which does not use
machine IDs, and therefore it will always fail. The legacy board file
for this machine was removed in commit 7fcf7e061edd ("ARM: OMAP2+:
Remove legacy booting support for Pandora"). To resolve this issue, use
of_machine_is_compatible() instead.

Fixes: b715da74deaf ("ARM: dts: omap3-pandora: add OMAP3530 600 MHz version")
Fixes: 9ccd0106c9db ("ARM: dts: omap3-pandora: add DM3730 1 GHz version")
Cc: stable@vger.kernel.org
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 sound/soc/ti/omap3pandora.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/ti/omap3pandora.c b/sound/soc/ti/omap3pandora.c
index f11b1d8a1306..6c9c184cd9d6 100644
--- a/sound/soc/ti/omap3pandora.c
+++ b/sound/soc/ti/omap3pandora.c
@@ -11,12 +11,12 @@
 #include <linux/delay.h>
 #include <linux/regulator/consumer.h>
 #include <linux/module.h>
+#include <linux/of.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
 
-#include <asm/mach-types.h>
 #include <linux/platform_data/asoc-ti-mcbsp.h>
 
 #include "omap-mcbsp.h"
@@ -225,7 +225,8 @@ static int __init omap3pandora_soc_init(void)
 {
 	int ret;
 
-	if (!machine_is_omap3_pandora())
+	if (!of_machine_is_compatible("openpandora,omap3-pandora-600mhz") &&
+		!of_machine_is_compatible("openpandora,omap3-pandora-1ghz"))
 		return -ENODEV;
 
 	pr_info("OMAP3 Pandora SoC init\n");
-- 
2.43.0


