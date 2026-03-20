Return-Path: <stable+bounces-227448-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOjKFLr3vGlW5AIAu9opvQ
	(envelope-from <stable+bounces-227448-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 08:31:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC67E2D6A1B
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 08:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 46DA93012BE6
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 07:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3192E9729;
	Fri, 20 Mar 2026 07:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="SQUaOiMY"
X-Original-To: stable@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF3F2877FC;
	Fri, 20 Mar 2026 07:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773991861; cv=none; b=opsKTWnbD9UJPxi0yaUxPmoCgKnw/5/SYqKdxlr9eodemwCi5MxMOe4X1WdOCdU2BgxtQtkALTjZLbe9dAQxVfszUharpZOpiXcGsoWrQaDgWrEceFGKOp3D4A22PWHqVT7pSROVYhRXPausSvEFO0OxKBcuK8eEJvhB2KbvUlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773991861; c=relaxed/simple;
	bh=7ji0q7baxhgY9PE/uRK/LZAcCK4ctdgIZ/M8oQMSCPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hf4PkUxOLSu28tD7bh6kjdjwTGqCCTC0o6S5pjWtfewRfDKaPfFv1uKxnh+o5nqi5b+SLNUF/39YBFt1bnsLX0oBlASwFFyDWXwbR9URfAzOPnH8FHPa23VVNy8rEGWn8p4NOZZQzvkQG0aDi5hZkEvUV7LTcZVtryKun0Xqfsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=SQUaOiMY; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from localhost.localdomain (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 8381922AF7;
	Fri, 20 Mar 2026 08:30:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1773991835;
	bh=xH0VS+5oYrn3GEvrAN6xwuAQOL7d7XH5bGrr/ehw4bA=; h=From:To:Subject;
	b=SQUaOiMYYlx4nC7GBeForsimWHapq/xFJNRiTVN+d4rNv7E7bYLeNQ6J0AJnb3TYC
	 gqSCi8nVIkLAj7XjTzEmvXEj6EkeIal0KgAkUCcnvSCTGwS/Pdl8g+dlsRvQlarvoC
	 xDi7c1c7nP/yRskqIswJHpa/wTfKifi3S+plXjCwV8kvslxlU3Ej+/UOLOzw7T0yti
	 cSuum902jauynv82BVr6A1C//gKNalHncxi0P56OGrsdJwNjOnLEO8gMkUwemDqf0I
	 IyD2WyScAShMLOm7RqDBLixuyxxZIwekHpF6DrX68Ep1WnKwaBRT9iTm45WLiIcZSA
	 6a9JJG8b8uPmQ==
From: Francesco Dolcini <francesco@dolcini.it>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Judith Mendez <jm@ti.com>,
	stable@vger.kernel.org
Subject: [PATCH v1] arm64: dts: ti: am62-verdin: Enable pullup for eMMC data pins
Date: Fri, 20 Mar 2026 08:30:30 +0100
Message-ID: <20260320073032.10427-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[dolcini.it,none];
	R_DKIM_ALLOW(-0.20)[dolcini.it:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-227448-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[francesco@dolcini.it,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dolcini.it:+];
	NEURAL_HAM(-0.00)[-0.978];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dolcini.it:dkim,dolcini.it:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,toradex.com:email]
X-Rspamd-Queue-Id: EC67E2D6A1B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Verdin AM62 board does not have external pullups on eMMC DAT1-DAT7 pins.
Enable internal pullups on DAT1-DAT7 considering:

 - without a host-side pullup, these lines rely solely on the eMMC
   device's internal pullup (R_int, 10kohm-150kohm per JEDEC), which may
   exceed the recommended 50kohm max for 1.8V VCCQ
 - JEDEC JESD84-B51 Table 200 requires host-side pullups (R_DAT,
   10kohm-100kohm) on all data lines to prevent bus floating

Fixes: 316b80246b16 ("arm64: dts: ti: add verdin am62")
Cc: stable@vger.kernel.org
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
index 2a7242a2fef8..09840a3b9fe7 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
@@ -572,16 +572,16 @@ AM62X_IOPAD(0x15c, PIN_INPUT, 0)  /* (AB22) MDIO0_MDIO */ /* ETH_1_MDIO, SODIMM
 	/* On-module eMMC */
 	pinctrl_sdhci0: main-mmc0-default-pins {
 		pinctrl-single,pins = <
-			AM62X_IOPAD(0x220, PIN_INPUT, 0) /*  (Y3) MMC0_CMD  */
-			AM62X_IOPAD(0x218, PIN_INPUT, 0) /* (AB1) MMC0_CLK  */
-			AM62X_IOPAD(0x214, PIN_INPUT, 0) /* (AA2) MMC0_DAT0 */
-			AM62X_IOPAD(0x210, PIN_INPUT, 0) /* (AA1) MMC0_DAT1 */
-			AM62X_IOPAD(0x20c, PIN_INPUT, 0) /* (AA3) MMC0_DAT2 */
-			AM62X_IOPAD(0x208, PIN_INPUT, 0) /*  (Y4) MMC0_DAT3 */
-			AM62X_IOPAD(0x204, PIN_INPUT, 0) /* (AB2) MMC0_DAT4 */
-			AM62X_IOPAD(0x200, PIN_INPUT, 0) /* (AC1) MMC0_DAT5 */
-			AM62X_IOPAD(0x1fc, PIN_INPUT, 0) /* (AD2) MMC0_DAT6 */
-			AM62X_IOPAD(0x1f8, PIN_INPUT, 0) /* (AC2) MMC0_DAT7 */
+			AM62X_IOPAD(0x220, PIN_INPUT,        0) /*  (Y3) MMC0_CMD  */
+			AM62X_IOPAD(0x218, PIN_INPUT,        0) /* (AB1) MMC0_CLK  */
+			AM62X_IOPAD(0x214, PIN_INPUT,        0) /* (AA2) MMC0_DAT0 */
+			AM62X_IOPAD(0x210, PIN_INPUT_PULLUP, 0) /* (AA1) MMC0_DAT1 */
+			AM62X_IOPAD(0x20c, PIN_INPUT_PULLUP, 0) /* (AA3) MMC0_DAT2 */
+			AM62X_IOPAD(0x208, PIN_INPUT_PULLUP, 0) /*  (Y4) MMC0_DAT3 */
+			AM62X_IOPAD(0x204, PIN_INPUT_PULLUP, 0) /* (AB2) MMC0_DAT4 */
+			AM62X_IOPAD(0x200, PIN_INPUT_PULLUP, 0) /* (AC1) MMC0_DAT5 */
+			AM62X_IOPAD(0x1fc, PIN_INPUT_PULLUP, 0) /* (AD2) MMC0_DAT6 */
+			AM62X_IOPAD(0x1f8, PIN_INPUT_PULLUP, 0) /* (AC2) MMC0_DAT7 */
 		>;
 	};
 
-- 
2.47.3


