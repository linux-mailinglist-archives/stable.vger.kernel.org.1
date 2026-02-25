Return-Path: <stable+bounces-218226-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SO4pDkRSnmm3UgQAu9opvQ
	(envelope-from <stable+bounces-218226-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:37:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE6918F2C4
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E8F53177F38
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F7722579E;
	Wed, 25 Feb 2026 01:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Uy09GJVe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4562E1E2834;
	Wed, 25 Feb 2026 01:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983021; cv=none; b=UHrh7xUH0byBnsEF/iHJ62GeRYW2M8AJ5ikqs5wCfGjQ+4+7xHFGIEqwgX7Qd7R/llFKtBRAGfJZPQrlBMSIRMRGh6VrWTVmvVcYCuDUeXOXMRQPvqugRvzvDQKM/aMl7FeK21goCbbesuSHKjsTvROz0UM/YZ0VBZUts3zSVeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983021; c=relaxed/simple;
	bh=n3TH0KiCiEOzRbi8qtjvhc6kvfCuKfy4H70D/5dr368=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fyqGTwRoEaLJ79hasWnhEmLZAzl/Ejv4UeFToUGMD3Ekd8M3rtRooR7/jcPFi/wxJXAWQMGgG2v/lpaBre49h7vVyUDzjdbS6hf2FLnuP+rJ4iQZQi3j2sBDDb5sSXS5Mi+EzCT3M4ayWL9O+DXgwGGnBBOxcTbbCsYfT99WJHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Uy09GJVe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D0FC116D0;
	Wed, 25 Feb 2026 01:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983021;
	bh=n3TH0KiCiEOzRbi8qtjvhc6kvfCuKfy4H70D/5dr368=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uy09GJVeSGaW420/TmjWmONJu8Yasuqv0umuxQtM9CDu7mLgdqeF0Fz+fsENp5FIT
	 dcMHfYaYMA9EbgEz2+a1qAbGJ8WB5DMq1mEUZHFTq2CXMkXyTnHmRUvJW7cWd1Ugov
	 klAvbkd+C01VbLDZvvybNFf2BRnsWlMRY6eaHr+Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Neulight <Eric.Neulight@linuxdev.slmail.me>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Viacheslav Bocharov <v@baodeep.com>,
	Sasha Levin <sashal@kernel.org>,
	Ricardo Pardini <ricardo@pardini.net>
Subject: [PATCH 6.19 188/781] arm64: dts: amlogic: meson-sm1-odroid: Eliminate Odroid HC4 power glitches during boot.
Date: Tue, 24 Feb 2026 17:14:57 -0800
Message-ID: <20260225012404.258387934@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218226-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linaro.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,baodeep.com:email,pardini.net:email,slmail.me:email,msgid.link:url]
X-Rspamd-Queue-Id: BAE6918F2C4
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Neulight <Eric.Neulight@linuxdev.slmail.me>

[ Upstream commit 436418ef5baa024b7b15dd730c36d651c6aaaf47 ]

Fix issue with Odroid HC4 (and all meson-sm1-odroid) DTS that causes
regulator power to momentarily glitch OFF-ON during boot.  Add
regulator-boot-on to all regulator-fixed and regulator-gpio entries
that (1) define a gpio AND (2) define regulator-always-on.

U-boot powers on devices necessary for boot then hands off the DTB to
the kernel.  During probe, linux drivers/regulator/fixed.c and
gpio-regulator.c both first set the regulator control gpio (that U-boot
already turned ON) to default OFF before then setting it to the defined
(ON) state. This glitches the power to the affected devices, unless
regulator-boot-on is specified with it.  In fact, U-boot has the same
behavior.  So, during reboot, a power glitch can actually happen twice:
once when U-boot reads the DTB and probes the gpio and again when the
kernel reads the DTB and probes the gpio.

Problem this fixes: On the Odroid HC4, power to the SATA ports glitches
during boot and causes some HDDs to do emergency head retract, which
should be avoided.  On the HC4, power glitches to the SD card, USB,
SATA, and HDMI interfaces during boot.  These are all boot devices.
A power glitch can potentially cause a problem for any sensitive devices
during boot.

NOTE: This is not limited to just the HC4, likely an issue with ALL DTS
with regulator-fixed or regulator-gpio entries that (1) define a gpio
AND (2) define regulator-always-on.  All such entries should also
include regulator-boot-on in order to avoid potential power glitches.
At worst, adding regulator-boot-on in such cases is harmless because of
regulator-always-on, and, at best, it eliminates detrimental power
glitches during boot.  So, this is best-practice.

Fixes: 164147f094ec5d0fc2c2098a888f4b50cf3096a7 ("arm64: dts: meson-sm1-odroid-hc4: add regulators controlled by GPIOH_8")
Fixes: 45d736ab17b44257e15e75e0dba364139fdb0983 ("arm64: dts: meson-sm1-odroid: add 5v regulator gpio")
Fixes: 1f80a5cf74a60997b92d2cde772edec093bec4d9 ("arm64: dts: meson-sm1-odroid: add missing enable gpio and supply for tf_io regulator")
Fixes: 88d537bc92ca035e2a9920b0abc750dd62146520 ("arm64: dts: meson: convert meson-sm1-odroid-c4 to dtsi")

Signed-off-by: Eric Neulight <Eric.Neulight@linuxdev.slmail.me>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Acked-by: Viacheslav Bocharov <v@baodeep.com>
Tested-by: Ricardo Pardini <ricardo@pardini.net> # on Odroid-HC4 5V HDD
Link: https://patch.msgid.link/20260116-odroid-hc4-dts-v1-1-459b601cd5cf@linuxdev.slmail.me
[narmstrong: fixed subject prefix]
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts | 2 ++
 arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi    | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts
index 0170139b8d32f..3ece30a0a1fff 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts
@@ -52,6 +52,7 @@ p12v_0: regulator-p12v-0 {
 
 		gpio = <&gpio GPIOH_8 GPIO_OPEN_DRAIN>;
 		enable-active-high;
+		regulator-boot-on;
 		regulator-always-on;
 	};
 
@@ -65,6 +66,7 @@ p12v_1: regulator-p12v-1 {
 
 		gpio = <&gpio GPIOH_8 GPIO_OPEN_DRAIN>;
 		enable-active-high;
+		regulator-boot-on;
 		regulator-always-on;
 	};
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
index c4524eb4f0996..0bce4e8d965f2 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
@@ -37,6 +37,7 @@ tflash_vdd: regulator-tflash-vdd {
 
 		gpio = <&gpio_ao GPIOAO_3 GPIO_OPEN_DRAIN>;
 		enable-active-high;
+		regulator-boot-on;
 		regulator-always-on;
 	};
 
@@ -50,6 +51,7 @@ tf_io: gpio-regulator-tf-io {
 
 		enable-gpios = <&gpio_ao GPIOE_2 GPIO_OPEN_DRAIN>;
 		enable-active-high;
+		regulator-boot-on;
 		regulator-always-on;
 
 		gpios = <&gpio_ao GPIOAO_6 GPIO_OPEN_SOURCE>;
@@ -81,6 +83,7 @@ vcc_5v: regulator-vcc-5v {
 		regulator-name = "5V";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
+		regulator-boot-on;
 		regulator-always-on;
 		vin-supply = <&main_12v>;
 		gpio = <&gpio GPIOH_8 GPIO_OPEN_DRAIN>;
-- 
2.51.0




