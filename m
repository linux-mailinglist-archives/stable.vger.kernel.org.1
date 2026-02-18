Return-Path: <stable+bounces-217314-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJMWEKIJlmldYwIAu9opvQ
	(envelope-from <stable+bounces-217314-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 19:49:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5BA158D1D
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 19:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 788E53006517
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 18:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7F530AABC;
	Wed, 18 Feb 2026 18:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="qZLQBJP8"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309D03009DE
	for <stable@vger.kernel.org>; Wed, 18 Feb 2026 18:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771440543; cv=none; b=CzWAenc0496JypWJbtgLqkybwkp34niwFogXp4ETRE8IeUiVEv3qjzlqHzKMkqK0VBz2OD0B57Kh1dh8/6s658SKTgYH9F50bGK3sSDCNZiX30Hmvj/ODCpeqO44Sv62jPoroRPQ0ciLQufPXhagsmFVjRuOGlDkM+q2xD7ngVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771440543; c=relaxed/simple;
	bh=/OmUAOMm2RruQ//I9h7YKUR2mlj0bKXRP2jhCiV/aCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rg+yW9C2cum5gAr2tX+sZh6VhfrAQeaPwHYO8ElJsOiBtg+b+YmdhyILfpXAdh+2A36gyW6skQ6a1X3X6A9f52OIu6EmC77dadzETsfDdxpPaQ9luUPknii6OHHx0z7ApzD4JwH7uR5BQBNRjoBbB9fSanqDyPdFVcUOM5ixAG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=qZLQBJP8; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4837634de51so973645e9.1
        for <stable@vger.kernel.org>; Wed, 18 Feb 2026 10:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1771440540; x=1772045340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e/tSGlhALPRv5y9OhlctMouWTNEcTMRO046vLMzTknU=;
        b=qZLQBJP8l/9nGCNjwTKsiHvPOL6pK3aQiZhbB8Selx6X6zpKIb2KeNQAJG6RZDrCgX
         Vt42OMIRfQ1nkYoeolujbVDNr03vvZdOQ4NctSsajEa/hQ7sSsdgSAI9Gn++0NYN8MoK
         Vi4OnYG6zgmDFcLJdmQLouo506Cty3C6t1mgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771440540; x=1772045340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/tSGlhALPRv5y9OhlctMouWTNEcTMRO046vLMzTknU=;
        b=afXy//G9dTJudKof3tGjeT+P3Ikyhl0xcXHQ0Vnf/uZN6IJbyFfPj1EU4Y5XjZLHUH
         BBuXmYMqYworgMNaLwXCe3cgBxSNhrNPocLExJdQWAhNcFxJKwx4i++jfKRhEKAqiPGT
         A2d+u40mD1KOcyRsnO0x2MEQ2MM52vvL9QQod9b0ZNCk6QVu9djVbf2OQlfroPWQUO5O
         Mn3oPEd5oxTTBW2cywiLWMApE2pZ01gdWZL21xauyb+eLaHIzNygmjVToPZ6aOOU2lrW
         SL66mkOwYGRYLdweQULL9nvjMmcXTheJIcD84BiEtVO80p7XUIs2UOOesCHUERvYEZR5
         fttQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAuSUz3hv+Zxm0nMOqRFdkiRvmCM/cmVhNvCBlo9O19B27+nlqboKUKMgPj7BqtY7FqxZy53M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa68hvPRx6CyQOgGf7sLtZH29Rou1uHQ66LKm8vBaC0aCT/Foa
	Z5k0C8ra4oMiQkQhcWy92YAxst3+SXiurLF74SEv+s1YSvWRKUpxvC2JCvJ5EMfZ6h8=
X-Gm-Gg: AZuq6aJyzrv17f8odW6MbE1c8aSv6PC7t/FdmLwwD4QbmWXD93yeas/Wf57UKpn8gRP
	KsgdoXz46fbQNtB1yS4+9HKUm+FsNkM/CM2sG9Estb1Ue0LNifeBKoP8BtYgn0fsTy3MMSB+vIc
	M7bbhh0ppv2DMTVRpyBtunfT/r9l6zJeD2+u7LayfvLNNU7owwRW0WzcHGAJsnTQjwKLRFJ68zK
	W/kJmwS8u8WQyy3Nbk+fQPFgnrXRrnCF1d+hLHqOU7G3OEABu4fSpiNI/dlehW24ZGcojFUa8iX
	FEL+OQSVZNhK6jfNYlNXZS9GsZwl1nhnGdVoDR+D2QMvRiiqWJMD6F1Li0lqKM6c9D+8UZ65fpg
	5PhKc3qhfwSYW0CNGiDIrBQi7R5omEnfdzcnSFpMnv79CDdH1gBcvuV+zvrzhMiZfwfhciIjjZw
	hZiRwCZQGkrtyQ90v79PzP6IZSvNEAxOLlEnBhqwE9bi2jcufcY/6vB86NXct2EXpmwxpVGAF3u
	qUza6jNfSQax2msFV4nyoY7rw==
X-Received: by 2002:a05:600c:1547:b0:477:afc5:fb02 with SMTP id 5b1f17b1804b1-483710858c8mr336518255e9.21.1771440540396;
        Wed, 18 Feb 2026 10:49:00 -0800 (PST)
Received: from P-NTS-Evian.home (2a01cb0594a2a2002ad9827a59cb148a.ipv6.abo.wanadoo.fr. [2a01:cb05:94a2:a200:2ad9:827a:59cb:148a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835d92267bsm923113325e9.0.2026.02.18.10.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 10:49:00 -0800 (PST)
From: Romain Naour <romain.naour@smile.fr>
To: yoann.congal@smile.fr
Cc: Romain Naour <romain.naour@smile.fr>,
	stable@vger.kernel.org
Subject: [PATCH] arm64: dts: ti: k3-j721e-main: Update delay select values for MMC1/2 subsystems
Date: Wed, 18 Feb 2026 19:48:54 +0100
Message-ID: <20260218184854.1731826-1-romain.naour@smile.fr>
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
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[smile.fr,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[smile.fr:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[smile.fr:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217314-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[romain.naour@smile.fr,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ti.com:url,4fb0000:email]
X-Rspamd-Queue-Id: AA5BA158D1D
X-Rspamd-Action: no action

Update the delay values for legacy and high speed modes, based on
the latest revised datasheet SPRSP36K released in April 2024 [1].

  (MMC1/2 - SD/SDIO Interface): Updated/Changed the
  "OTAPDLYENA, DELAY ENABLE" and "OTAPDLYSEL, DELAY VALUE" for the
  Default Speed and High Speed modes from "0x0" to "0x1"

The previous SPRSP36J datasheet recommends to set ti,otap-del-sel-sd-hs
value to 0 for MMC1 and MMC2 interfaces. These values were updated in
kernel 6.5. As a result we have some occasional regression with ultra
high speed DDR50 SDXC cards while mounting the rootfs:

  mmc1: error -110 whilst initialising SD card

A similar issue may occur with u-boot after a reboot while
initialising the SD card:

  mmc_init: -110, time 67

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


