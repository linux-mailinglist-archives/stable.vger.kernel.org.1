Return-Path: <stable+bounces-143050-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D51BEAB15CD
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 15:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1277C1760F2
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 13:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A126292901;
	Fri,  9 May 2025 13:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyYnLEP3"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C0A2918E3;
	Fri,  9 May 2025 13:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746798557; cv=none; b=itrH9FsuffDqadgydE/TZ1CUTH9vkRoiziLr7Nq7hlgXptjdEsL3eZ4WIHvoQ2/U8UJfv+pEbrD7G1/t2KQTYdJlUbNI7muifN+urymK2YBEncxrChz28EdvKgglXf1XmoFuV6TIB6t7P3CjwOJag6tKUQ1b6KUWY0P/rUCvDVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746798557; c=relaxed/simple;
	bh=xfeqIRASYBmtfmuj2tXMhHMsm7PZNBpKF2b/7lJ4fcs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bF3H2ff409noWZOfjTfRRTlR1H9UIbXjqZoRsfdLZ9KDKvt1rJM2qIwVb2SHVLYinvO27ROjpj2luyeMTFmiHUJwy8Xy924VOh8pXne7lu23+ImFH1wjzM1eh83nfExLDRCOyB/J1iSuOcNGjBXkZ3nCuFTUWsKiWkjPA+vdl2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lyYnLEP3; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ad221e3e5a2so96486866b.1;
        Fri, 09 May 2025 06:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746798553; x=1747403353; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=49BBpcmTylyp6P75ckv+hBDCrLqZhnavTvSWvBtKazo=;
        b=lyYnLEP3/F3wtjzyT3xju4Yb6fM4Wu7nH79d3JitJPkyQYt6jjfJodmUVbZcLJtSzr
         8sZXBYlxPmd/HFXZZjQlNM4ii3L3sTSMQOgrbfto5IO00rf5snJEFZgwXGeFGqNUbwgD
         4/HfKS74S//6hGx3o+5iKmb2MUg3dZINrVltAna5l+ONoFqpR5BEQHG5MqqcR0JYyhkd
         yo9ruWqG6DXzwtC1Sabfil5FC3CNTco2z1CpNQWYKxxh0Lh7sbB3/ELwkQxcnfpGfpSS
         yp9DHeKjl4BLwfQwO+e/cb6JgSJ1sVqh3NpMmTDHJ8f4MHNMd70onTV3+KwIsCbRf1dc
         JbyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746798553; x=1747403353;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=49BBpcmTylyp6P75ckv+hBDCrLqZhnavTvSWvBtKazo=;
        b=hLKPmdUdlMyLDVFxs/H/JO1OJGl73cDZkmugtHmQwn9Rss0Swg5Y6qVLtgmPDdXkrn
         EFChRPzu78Dg5NdY1LIKlWke/Sa8OkT8dH2tEntcN2lS5LGTJohh2cNPTh4kfrq/WrBi
         V7S5JohSBxrpmM0sAALuoRbWeSt4kjk6Hwf92RRWoBjyal4y/bEtwm2Kf0ClXLd6D9CW
         5m9tuwKd4ny11BxRZakrAwR5Gza1XbOXoeRXIhh+QD32+o/gf+xk9SULmQJgI0eEXF04
         K8ENgboOTr4Tsg+8Vnr7sJ3WYneYpKRpMtYLguqzC8axY8lRf3+3FoXwWAnQANDGsvp2
         rMag==
X-Forwarded-Encrypted: i=1; AJvYcCViHM/jTO+9JdvMbSg37afjwZyBp7nR/VxINSsrDzEDTWs5fU6d/HGUe1iXynmw4JLCPEPTDJe23s5t@vger.kernel.org, AJvYcCWMZatiLKFn+qyDKehfb57KWGr3GsLjAxsDyGuhtIasehKjas8orzfIBfkAA2S2GJjG2BeGt4kP@vger.kernel.org, AJvYcCXI+eLwqzeP9gP4kHWdRGtf+nDSllmAGxVQNyUgXtx/i79cD6gsH9nIg615iilImCsLTvF22eg42uSb1dtN@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf1e8Ruty/Qf5DlYHrRmNHnm/pfDqY/VxA+pCsXiOFidGkNy02
	7JD+ZWZY6wGb8bZ8qJpc+1s40Ic1O75OM152c7Emt1A6YJSTyDAK
X-Gm-Gg: ASbGncuj2o0SkYaHxHNzeF89ins1bpk9ZXeuJQkn1EvPG0PWDWwr+hVO5pnEUlThJ6Z
	p/FQdtoZtOjDeTU5u5kFqNVzuBRknaO4InBbxCMrTCBrNkJPxuaQmyZTZILeuzOG1C7CuqoUfnP
	gTsBgrT97ykoxXKafiDvc2aLhgUyFnUjpayPYk3dahlN3ATNKOUhq5lwDLVQ8JutthtFVJQnj8v
	+/2hrFB1gmYTtUI7b9WIeq1rDTkaMZXX+Icqnt5p2dEzhBtYoIyL5xnEA7Ye978644W6Opcx6lS
	ouIwvzO0Mz5jJ4tbcdnpJxFxHASKbKzwB14F6FLvAWrE4LWzvNOQCEqz3ipO9ZKcY//upg==
X-Google-Smtp-Source: AGHT+IHaZWCHw8xsDTdBKvhjLjajsoWqZ8PJ57hG4DRckRcOgU+5g1YHglpVlj4XEBe99tmHM/8k4A==
X-Received: by 2002:a17:907:1808:b0:ad2:2dc9:e3d3 with SMTP id a640c23a62f3a-ad22dc9e61cmr32726566b.57.1746798553081;
        Fri, 09 May 2025 06:49:13 -0700 (PDT)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ad2197bd219sm154111066b.141.2025.05.09.06.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 06:49:12 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Fri, 09 May 2025 15:48:52 +0200
Subject: [PATCH] arm64: dts: marvell: uDPU: define pinctrl state for alarm
 LEDs
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-udpu-alarm-led-fix-v1-1-4ede407714cc@gmail.com>
X-B4-Tracking: v=1; b=H4sIAMQHHmgC/x2MWwqAIBAAryL73YIK9rpK9GG51kIPUYwgunvS5
 wzMPJAoMiXoxQORLk58HgVUJWBe7bEQsisMWmojjewwu5DRbjbuuJFDzzfWutWtb0gpmqCEIVL
 R/3QY3/cDXUiOnWQAAAA=
X-Change-ID: 20250509-udpu-alarm-led-fix-62828f7e11eb
To: Robert Marko <robert.marko@sartura.hr>, Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vladimir Vid <vladimir.vid@sartura.hr>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Gabor Juhos <j4g8y7@gmail.com>, Imre Kaloz <kaloz@openwrt.org>
X-Mailer: b4 0.14.2

The two alarm LEDs of on the uDPU board are stopped working since
commit 78efa53e715e ("leds: Init leds class earlier").

The LEDs are driven by the GPIO{15,16} pins of the North Bridge
GPIO controller. These pins are part of the 'spi_quad' pin group
for which the 'spi' function is selected via the default pinctrl
state of the 'spi' node. This is wrong however, since in order to
allow controlling the LEDs, the pins should use the 'gpio' function.

Before the commit mentined above, the 'spi' function is selected
first by the pinctrl core before probing the spi driver, but then
it gets overridden to 'gpio' implicitly via the
devm_gpiod_get_index_optional() call from the 'leds-gpio' driver.

After the commit, the LED subsystem gets initialized before the
SPI subsystem, so the function of the pin group remains 'spi'
which in turn prevents controlling of the LEDs.

Despite the change of the initialization order, the root cause is
that the pinctrl state definition is wrong since its initial commit
0d45062cfc89 ("arm64: dts: marvell: Add device tree for uDPU board"),

To fix the problem, override the function in the 'spi_quad_pins'
node to 'gpio' and move the pinctrl state definition from the
'spi' node into the 'leds' node.

Cc: stable@vger.kernel.org # needs adjustment for < 6.1
Fixes: 0d45062cfc89 ("arm64: dts: marvell: Add device tree for uDPU board")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
---
Notes:

1. DTB check shows a bunch of warnings, but none of those are new:

    DTC [C] arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtb
  arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtb: /soc/bus@d0000000/watchdog@8300: failed to match any schema with compatible: ['marvell,armada-3700-wdt']
  arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtb: /soc/bus@d0000000/serial@12000: failed to match any schema with compatible: ['marvell,armada-3700-uart']
  arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtb: /soc/bus@d0000000/serial@12200: failed to match any schema with compatible: ['marvell,armada-3700-uart-ext']
  arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtb: /soc/bus@d0000000/nb-periph-clk@13000: failed to match any schema with compatible: ['marvell,armada-3700-periph-clock-nb', 'syscon']
  arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtb: /soc/bus@d0000000/sb-periph-clk@18000: failed to match any schema with compatible: ['marvell,armada-3700-periph-clock-sb']
  arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtb: /soc/bus@d0000000/tbg@13200: failed to match any schema with compatible: ['marvell,armada-3700-tbg-clock']
  <...>/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtb: pinctrl@13800: reg: [[79872, 256], [80896, 32]] is too long
  	from schema $id: http://devicetree.org/schemas/mfd/syscon-common.yaml#
  arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtb: /soc/bus@d0000000/pinctrl@13800: failed to match any schema with compatible: ['marvell,armada3710-nb-pinctrl', 'syscon', 'simple-mfd']
  arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtb: /soc/bus@d0000000/pinctrl@13800/xtal-clk: failed to match any schema with compatible: ['marvell,armada-3700-xtal-clock']
  arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtb: /soc/bus@d0000000/phy@18300: failed to match any schema with compatible: ['marvell,comphy-a3700']
  <...>/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtb: pinctrl@18800: reg: [[100352, 256], [101376, 32]] is too long
  	from schema $id: http://devicetree.org/schemas/mfd/syscon-common.yaml#
  arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtb: /soc/bus@d0000000/pinctrl@18800: failed to match any schema with compatible: ['marvell,armada3710-sb-pinctrl', 'syscon', 'simple-mfd']
  arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtb: /soc/bus@d0000000/ethernet@30000: failed to match any schema with compatible: ['marvell,armada-3700-neta']
  arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtb: /soc/bus@d0000000/ethernet@40000: failed to match any schema with compatible: ['marvell,armada-3700-neta']
  <...>/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtb: usb@58000: Unevaluated properties are not allowed ('marvell,usb-misc-reg' was unexpected)
  	from schema $id: http://devicetree.org/schemas/usb/generic-xhci.yaml#
  arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtb: /soc/bus@d0000000/system-controller@5d800: failed to match any schema with compatible: ['marvell,armada-3700-usb2-host-device-misc', 'syscon']
  <...>/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtb: usb@5e000: phy-names:0: 'usb' was expected
  	from schema $id: http://devicetree.org/schemas/usb/generic-ehci.yaml#
  arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtb: /soc/bus@d0000000/xor@60900: failed to match any schema with compatible: ['marvell,armada-3700-xor']
  arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtb: /soc/bus@d0000000/mailbox@b0000: failed to match any schema with compatible: ['marvell,armada-3700-rwtm-mailbox']
  arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtb: /soc/pcie@d0070000: failed to match any schema with compatible: ['marvell,armada-3700-pcie']
  arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtb: /firmware/armada-3700-rwtm: failed to match any schema with compatible: ['marvell,armada-3700-rwtm-firmware']

2. Just for the record, here is the bisect log:
  git bisect start
  # status: waiting for both good and bad commits
  # bad: [7cdabafc001202de9984f22c973305f424e0a8b7] Merge tag 'trace-v6.15-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace
  git bisect bad 7cdabafc001202de9984f22c973305f424e0a8b7
  # status: waiting for good commit(s), bad commit known
  # good: [0c3836482481200ead7b416ca80c68a29cfdaabd] Linux 6.10
  git bisect good 0c3836482481200ead7b416ca80c68a29cfdaabd
  # bad: [fcc79e1714e8c2b8e216dc3149812edd37884eef] Merge tag 'net-next-6.13' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
  git bisect bad fcc79e1714e8c2b8e216dc3149812edd37884eef
  # good: [26bb0d3f38a764b743a3ad5c8b6e5b5044d7ceb4] Merge tag 'for-6.12/block-20240913' of git://git.kernel.dk/linux
  git bisect good 26bb0d3f38a764b743a3ad5c8b6e5b5044d7ceb4
  # bad: [5e5466433d266046790c0af40a15af0a6be139a1] Merge tag 'char-misc-6.12-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc
  git bisect bad 5e5466433d266046790c0af40a15af0a6be139a1
  # good: [de848da12f752170c2ebe114804a985314fd5a6a] Merge tag 'drm-next-2024-09-19' of https://gitlab.freedesktop.org/drm/kernel
  git bisect good de848da12f752170c2ebe114804a985314fd5a6a
  # bad: [962ad08780a5bfb3240bc793e565181eacfceafb] Merge tag 'pinctrl-v6.12-1' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl
  git bisect bad 962ad08780a5bfb3240bc793e565181eacfceafb
  # good: [440b65232829fad69947b8de983c13a525cc8871] Merge tag 'bpf-next-6.12' of git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
  git bisect good 440b65232829fad69947b8de983c13a525cc8871
  # good: [f8ffbc365f703d74ecca8ca787318d05bbee2bf7] Merge tag 'pull-stable-struct_fd' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
  git bisect good f8ffbc365f703d74ecca8ca787318d05bbee2bf7
  # good: [18ba6034468e7949a9e2c2cf28e2e123b4fe7a50] Merge tag 'nfsd-6.12' of git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
  git bisect good 18ba6034468e7949a9e2c2cf28e2e123b4fe7a50
  # bad: [bb78146c18ac67f22cabb2448b501bcac30f8801] Merge branch 'pci/controller/xilinx'
  git bisect bad bb78146c18ac67f22cabb2448b501bcac30f8801
  # bad: [b893f8ea38c530c2c8a337c3429f9f37e6bf65e8] Merge branch 'pci/controller/brcmstb'
  git bisect bad b893f8ea38c530c2c8a337c3429f9f37e6bf65e8
  # bad: [207bcb73fb08841e242fa1d66e1d0381836da562] Merge branch 'pci/dt-bindings'
  git bisect bad 207bcb73fb08841e242fa1d66e1d0381836da562
  # good: [e642aa6b38762a2af3a7e0c5e6dac5841c15dea0] Merge branch 'pci/iommu'
  git bisect good e642aa6b38762a2af3a7e0c5e6dac5841c15dea0
  # good: [f500a2f1282750fb344ce535d78071cf1493efd1] dt-bindings: PCI: imx6q-pcie: Add reg-name "dbi2" and "atu" for i.MX8M PCIe Endpoint
  git bisect good f500a2f1282750fb344ce535d78071cf1493efd1
  # bad: [d774674f3492740503a3cd3f5da131d088202f1b] Merge branch 'pci/pwrctl'
  git bisect bad d774674f3492740503a3cd3f5da131d088202f1b
  # bad: [759ec28242894f2006a1606c1d6e9aca48cecfcf] PCI/NPEM: Add _DSM PCIe SSD status LED management
  git bisect bad 759ec28242894f2006a1606c1d6e9aca48cecfcf
  # bad: [4e893545ef8712d25f3176790ebb95beb073637e] PCI/NPEM: Add Native PCIe Enclosure Management support
  git bisect bad 4e893545ef8712d25f3176790ebb95beb073637e
  # bad: [78efa53e715e21a97c722dba20f8437a0860521e] leds: Init leds class earlier
  git bisect bad 78efa53e715e21a97c722dba20f8437a0860521e
  # first bad commit: [78efa53e715e21a97c722dba20f8437a0860521e] leds: Init leds class earlier
---
 arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtsi b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtsi
index 3a9b6907185d0363dff41178543a0210ce99dbf7..24282084570787630cb0beeab3997b943bdf45dc 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtsi
@@ -26,6 +26,8 @@ memory@0 {
 
 	leds {
 		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&spi_quad_pins>;
 
 		led-power1 {
 			label = "udpu:green:power";
@@ -82,8 +84,6 @@ &sdhci0 {
 
 &spi0 {
 	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&spi_quad_pins>;
 
 	flash@0 {
 		compatible = "jedec,spi-nor";
@@ -108,6 +108,10 @@ partition@180000 {
 	};
 };
 
+&spi_quad_pins {
+	function = "gpio";
+};
+
 &pinctrl_nb {
 	i2c2_recovery_pins: i2c2-recovery-pins {
 		groups = "i2c2";

---
base-commit: 92a09c47464d040866cf2b4cd052bc60555185fb
change-id: 20250509-udpu-alarm-led-fix-62828f7e11eb

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


