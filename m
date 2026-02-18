Return-Path: <stable+bounces-217321-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEYNE5UjlmkXbAIAu9opvQ
	(envelope-from <stable+bounces-217321-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 21:39:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E917E1597CB
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 21:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CFD3302AD08
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 20:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B152C34889C;
	Wed, 18 Feb 2026 20:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="N4az98+k"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1B0309F1F
	for <stable@vger.kernel.org>; Wed, 18 Feb 2026 20:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771447182; cv=none; b=uR5l3acE2fFAN/MLqE9KRtYPhdxySjMoL6JEXHyEgsX/wnfAabDFKO7WcWC/DGY0XIyWdFrAHnZDx9cJX2jLeSBaCxrhaRAYrus4dUvZj/NpngQgXl248hZDBEGPYUaIznAGO5MVP3Xozw/mTKwzxeK0EqXIlgxpr5x1Z4ssoGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771447182; c=relaxed/simple;
	bh=IZOe9Agq5alFuZFtw7BiAeMypRr0qgvFrTQVAA2QJGg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YJhtLimDtgwg1ragUyQ4Uy3zqWEWCXGxy6Hcud0Hq/X/7yw8Ym7NdAwl51/GDpAOgxs3LVJiyvgkOQ0U0+0GB93hRlC6MLbrhlDwSeNF2ixMbdC9cfx7ttOCWDWb/BTzyIGiIwrbUUXZj8FnU+Bkd4et4pEr4T1ngO+qZaxy26U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=N4az98+k; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4376c0bffc1so195351f8f.0
        for <stable@vger.kernel.org>; Wed, 18 Feb 2026 12:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1771447179; x=1772051979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hLWHawfUnZuiQ3TDhSdC1bL32uOxcaH5z4XCL/rXWbU=;
        b=N4az98+kxrdCsihwFNEkhNcyK9Y2wCxB9Egd5mGJxyF5jkeLVx4ih4+WCjHGCQdtq7
         ElKWEZUJvbpTujjhESL3kmKryiWsFUGLv/4WUvWyF/gQlTfPsbanaJMttOMfXGNQIXTa
         85t4Z5uov6C3XeiLhkWADcMOwUdrFKkDXmAIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771447179; x=1772051979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLWHawfUnZuiQ3TDhSdC1bL32uOxcaH5z4XCL/rXWbU=;
        b=AK3jTgKkRwmDDu3VMcQig4+JZ1/M2abWVsJv6we0gTdsGkJGb6h3XL2lorVfNvoZ45
         Z2Folx7GDuMEjHB6yd7K919VKG30ylRmzqwYHlnmxTx1HjFPtZ7UwUJnEgtRBVUUSj5c
         6oz+85RKsj6xPw/CH35NMltS76ijUFq5WGotNjJ/S97GD4ayrROAuwNmPWU6j/4hFLoA
         IcMZipj+CRwf2pKl3gDxRkXixnoNvXiSwmWFbVWQLkVq5z4IeP5HZJw1KEfx0kxvcpx1
         AvCMyl3znZTGi116TVduEgsb8RRFwxDjW3t2M7Fy97SJ3qfsNu+hqFUyudyniPns6VjT
         FzDA==
X-Forwarded-Encrypted: i=1; AJvYcCUFjr1MVcFnHfnIxf6iAMZVTCSiMBq2RDGMLLosxasj05eDmX/OwOycPotw8fXy6BHcI8WOoBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/pOXLnJB0Tkh1ppxVSthEkpkvOWsUZYTYGIYjqf3K7FKLQ8Yb
	j0nItxmBF97eLnSzsqcvOTNuPpYiqsxq/MDCnx4N3XtRgX204bAZ1rK1t5F1rBxl/kM=
X-Gm-Gg: AZuq6aKRHKMqvJGR5Mw9r4WPk/+GvxIEpotGnj6yI9net5bNb6sTq34RXxFzM8fkcP3
	V/FKD90mK7dFH/dOTpvM5JcbhqSyrM3Z4LNi3FjkaiwU1yKFadx+aQBsTyKMFWXkrRhVHWvDNBH
	KE6ZbslCIByZmtfspAaXz2IltPezBCCA6J2kc65F3Xio7Ups2ONcvkhxC9wQM8TgQ6TSbv6KVcK
	dmz/Hsnr9VqW1ky2V/4qfAa9lRsewo49MKpuJKxm8salWNJ2lWxAXld8D+WcgHS+/kwovVlttk5
	wxlqxKn5jzVGyVZl7sZtPneIbzx57cl8Vbvlegb0ldP/tQFRG86cImmT3iqeXXU+L6pNwQFB4IT
	B4hyZkq5Hkt47d8AYnoSxAJQwOic1thJP+UqHEcL0xXbLtmMqDyUNcGAuD9gNlGGX26ZeuXcCFO
	SN24UjcoZlN9O2vW6MLqPR9ap9MzzVLwLc9x9nEz9rCEo0ncsf0EjOmdqwjmj/7rVJ1UyDmVwKI
	XcI40vXZTK5DEpH9gIJWV6is+zjd8Y1zGqT
X-Received: by 2002:a05:600c:6091:b0:477:df7:b020 with SMTP id 5b1f17b1804b1-4839e661d1bmr6597615e9.18.1771447179348;
        Wed, 18 Feb 2026 12:39:39 -0800 (PST)
Received: from P-NTS-Evian.home (2a01cb0594a2a2002ad9827a59cb148a.ipv6.abo.wanadoo.fr. [2a01:cb05:94a2:a200:2ad9:827a:59cb:148a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835dd0e327sm620432895e9.14.2026.02.18.12.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 12:39:38 -0800 (PST)
From: Romain Naour <romain.naour@smile.fr>
To: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-omap@vger.kernel.org
Cc: conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	kristo@kernel.org,
	vigneshr@ti.com,
	nm@ti.com,
	Romain Naour <romain.naour@smile.fr>,
	stable@vger.kernel.org
Subject: [PATCH] arm64: dts: ti: k3-j721e-main: Update delay select values for MMC1/2 subsystems
Date: Wed, 18 Feb 2026 21:38:23 +0100
Message-ID: <20260218203823.1825554-1-romain.naour@smile.fr>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[smile.fr,reject];
	R_DKIM_ALLOW(-0.20)[smile.fr:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[smile.fr:+];
	TAGGED_FROM(0.00)[bounces-217321-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[romain.naour@smile.fr,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,dt];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[4f98000:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,4fb0000:email,smile.fr:mid,smile.fr:dkim,smile.fr:email]
X-Rspamd-Queue-Id: E917E1597CB
X-Rspamd-Action: no action

The previous SPRSP36J datasheet recommends to set ti,otap-del-sel-sd-hs
value to 0 for MMC1 and MMC2 interfaces. These values were updated in
kernel 6.5. As a result we have some occasional regression with ultra
high speed DDR50 SDXC cards while mounting the rootfs:

  mmc1: error -110 whilst initialising SD card

A similar issue may occur with u-boot after a reboot while
initialising the SD card:

  mmc_init: -110, time 67

Update the delay values for legacy and high speed modes, based on
the latest revised datasheet SPRSP36K released in April 2024 [1].

  (MMC1/2 - SD/SDIO Interface): Updated/Changed the
  "OTAPDLYENA, DELAY ENABLE" and "OTAPDLYSEL, DELAY VALUE" for the
  Default Speed and High Speed modes from "0x0" to "0x1"

[1] Table 6-86. MMC1/2 DLL Delay Mapping for All Timing Modes, in
https://www.ti.com/lit/ds/symlink/tda4vm.pdf,
(SPRSP36K – SEPTEMBER 2021 – REVISED APRIL 2024)

Cc: stable@vger.kernel.org # 6.5+
Fixes: af398252d68e ("arm64: dts: ti: k3-j721e-main: Update delay select values for MMC subsystems")
Signed-off-by: Romain Naour <romain.naour@smile.fr>
---
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index d5fd30a01032..418e6010ef1f 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -1643,8 +1643,8 @@ main_sdhci1: mmc@4fb0000 {
 		clocks = <&k3_clks 92 5>, <&k3_clks 92 0>;
 		assigned-clocks = <&k3_clks 92 0>;
 		assigned-clock-parents = <&k3_clks 92 1>;
-		ti,otap-del-sel-legacy = <0x0>;
-		ti,otap-del-sel-sd-hs = <0x0>;
+		ti,otap-del-sel-legacy = <0x1>;
+		ti,otap-del-sel-sd-hs = <0x1>;
 		ti,otap-del-sel-sdr12 = <0xf>;
 		ti,otap-del-sel-sdr25 = <0xf>;
 		ti,otap-del-sel-sdr50 = <0xc>;
@@ -1671,8 +1671,8 @@ main_sdhci2: mmc@4f98000 {
 		clocks = <&k3_clks 93 5>, <&k3_clks 93 0>;
 		assigned-clocks = <&k3_clks 93 0>;
 		assigned-clock-parents = <&k3_clks 93 1>;
-		ti,otap-del-sel-legacy = <0x0>;
-		ti,otap-del-sel-sd-hs = <0x0>;
+		ti,otap-del-sel-legacy = <0x1>;
+		ti,otap-del-sel-sd-hs = <0x1>;
 		ti,otap-del-sel-sdr12 = <0xf>;
 		ti,otap-del-sel-sdr25 = <0xf>;
 		ti,otap-del-sel-sdr50 = <0xc>;
-- 
2.52.0


