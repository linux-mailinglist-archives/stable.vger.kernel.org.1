Return-Path: <stable+bounces-58117-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25309928304
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 09:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FB6BB2523A
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 07:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB9C144D2B;
	Fri,  5 Jul 2024 07:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hTVPCjHb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0825C14388D;
	Fri,  5 Jul 2024 07:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720165462; cv=none; b=U8KiDKqcoPzwnpZ0WpOzGdyBtqWWPBgMWdKK9HcGpQ+fhN+6tc+UlS0AvMZPf0ARGUY1lXOutfO6fMRtqNbeIRpcxthwuohXCb3MU/7AnX8cSmp0Q+Hj6VeKA6mOtNrFSJoufrl9+uwNL84YRc2ZCrGTa/unr87P7Da2qFQSEoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720165462; c=relaxed/simple;
	bh=M7F+B3mLrzh7aH7E3trM/kbbGYmtdNdBugP99etS4gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lgPMU5jfnX+u7ncAMuMjT+l6YLXoJhhKfEuedppXrIfb7P8c3NC6kKBH7bUIIvvZpKFXLvSbtDPbpNZZua9wI1FsknvScoccgs+bhBVemQ9ydeGxgibenxSedeRmZyGZyLad3Xkrr91QRltcJEL+IEwT4s0/ZIn3VetxhvO2bGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hTVPCjHb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC8FC116B1;
	Fri,  5 Jul 2024 07:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720165461;
	bh=M7F+B3mLrzh7aH7E3trM/kbbGYmtdNdBugP99etS4gs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hTVPCjHb2sk88wCDsqzXmH+4RtEEQvaNL2v42qhQZx74RfsjbF3wtkHGfCfbGJ0yw
	 bjtR8RRlYziaOxlm7mjRCwkIdwPMtFpHuqx7QzSaed5JdDQiuBh5XnGDgIqyJhT48j
	 sMj6apktcJNywmgjNvhwUjtUPcgBN5kqLtRH1Kgc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.97
Date: Fri,  5 Jul 2024 09:44:09 +0200
Message-ID: <2024070508-prologue-spray-9e62@gregkh>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024070508-uncivil-unviable-c930@gregkh>
References: <2024070508-uncivil-unviable-c930@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/devicetree/bindings/i2c/amlogic,meson6-i2c.yaml b/Documentation/devicetree/bindings/i2c/amlogic,meson6-i2c.yaml
index 199a354ccb97..26bed558c6b8 100644
--- a/Documentation/devicetree/bindings/i2c/amlogic,meson6-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/amlogic,meson6-i2c.yaml
@@ -2,8 +2,8 @@
 # Copyright 2019 BayLibre, SAS
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/i2c/amlogic,meson6-i2c.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/i2c/amlogic,meson6-i2c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Amlogic Meson I2C Controller
 
diff --git a/Documentation/devicetree/bindings/i2c/apple,i2c.yaml b/Documentation/devicetree/bindings/i2c/apple,i2c.yaml
index 4ac61fec90e2..243da7003cec 100644
--- a/Documentation/devicetree/bindings/i2c/apple,i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/apple,i2c.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/i2c/apple,i2c.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/i2c/apple,i2c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Apple/PASemi I2C controller
 
diff --git a/Documentation/devicetree/bindings/i2c/atmel,at91sam-i2c.yaml b/Documentation/devicetree/bindings/i2c/atmel,at91sam-i2c.yaml
index ea2303c0e143..c22e459c175a 100644
--- a/Documentation/devicetree/bindings/i2c/atmel,at91sam-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/atmel,at91sam-i2c.yaml
@@ -75,7 +75,7 @@ required:
   - clocks
 
 allOf:
-  - $ref: "i2c-controller.yaml"
+  - $ref: /schemas/i2c/i2c-controller.yaml#
   - if:
       properties:
         compatible:
diff --git a/Documentation/devicetree/bindings/i2c/cdns,i2c-r1p10.yaml b/Documentation/devicetree/bindings/i2c/cdns,i2c-r1p10.yaml
index 2e95cda7262a..7a675aa08c44 100644
--- a/Documentation/devicetree/bindings/i2c/cdns,i2c-r1p10.yaml
+++ b/Documentation/devicetree/bindings/i2c/cdns,i2c-r1p10.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/i2c/cdns,i2c-r1p10.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/i2c/cdns,i2c-r1p10.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Cadence I2C controller
 
diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-gpio.yaml b/Documentation/devicetree/bindings/i2c/i2c-mux-gpio.yaml
index 6e0a5686af04..f34cc7ad5a00 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mux-gpio.yaml
+++ b/Documentation/devicetree/bindings/i2c/i2c-mux-gpio.yaml
@@ -45,7 +45,7 @@ properties:
 
   i2c-parent:
     description: phandle of the I2C bus that this multiplexer's master-side port is connected to
-    $ref: "/schemas/types.yaml#/definitions/phandle"
+    $ref: /schemas/types.yaml#/definitions/phandle
 
   mux-gpios:
     description: list of GPIOs used to control the muxer
@@ -55,7 +55,7 @@ properties:
   idle-state:
     description: Value to set the muxer to when idle. When no value is given, it defaults to the
       last value used.
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: /schemas/types.yaml#/definitions/uint32
 
 allOf:
   - $ref: i2c-mux.yaml
diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
index 0e7ed00562e2..5a44fdcbdd59 100644
--- a/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
+++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/i2c/qcom,i2c-geni-qcom.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/i2c/qcom,i2c-geni-qcom.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Qualcomm Geni based QUP I2C Controller
 
diff --git a/Documentation/devicetree/bindings/i2c/st,stm32-i2c.yaml b/Documentation/devicetree/bindings/i2c/st,stm32-i2c.yaml
index bf396e9466aa..94b75d9f66cd 100644
--- a/Documentation/devicetree/bindings/i2c/st,stm32-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/st,stm32-i2c.yaml
@@ -90,7 +90,7 @@ properties:
   st,syscfg-fmp:
     description: Use to set Fast Mode Plus bit within SYSCFG when Fast Mode
       Plus speed is selected by slave.
-    $ref: "/schemas/types.yaml#/definitions/phandle-array"
+    $ref: /schemas/types.yaml#/definitions/phandle-array
     items:
       - items:
           - description: phandle to syscfg
diff --git a/Documentation/devicetree/bindings/i2c/xlnx,xps-iic-2.00.a.yaml b/Documentation/devicetree/bindings/i2c/xlnx,xps-iic-2.00.a.yaml
index 8d241a703d85..f3b53ecae562 100644
--- a/Documentation/devicetree/bindings/i2c/xlnx,xps-iic-2.00.a.yaml
+++ b/Documentation/devicetree/bindings/i2c/xlnx,xps-iic-2.00.a.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/i2c/xlnx,xps-iic-2.00.a.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/i2c/xlnx,xps-iic-2.00.a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Xilinx IIC controller
 
diff --git a/Makefile b/Makefile
index 83658d447564..c2148be2ba34 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 96
+SUBLEVEL = 97
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index de9915d946f7..b98d5e357baf 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -123,6 +123,7 @@ hdmi: hdmi@10116000 {
 		pinctrl-0 = <&hdmii2c_xfer>, <&hdmi_hpd>;
 		power-domains = <&power RK3066_PD_VIO>;
 		rockchip,grf = <&grf>;
+		#sound-dai-cells = <0>;
 		status = "disabled";
 
 		ports {
diff --git a/arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts b/arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts
index a71f249ed384..edc8d2e3980d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts
@@ -5,6 +5,8 @@
  */
 
 /dts-v1/;
+
+#include <dt-bindings/leds/common.h>
 #include "rk3308.dtsi"
 
 / {
@@ -24,17 +26,21 @@ chosen {
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
-		pinctrl-0 = <&green_led_gio>, <&heartbeat_led_gpio>;
+		pinctrl-0 = <&green_led>, <&heartbeat_led>;
 
 		green-led {
+			color = <LED_COLOR_ID_GREEN>;
 			default-state = "on";
+			function = LED_FUNCTION_POWER;
 			gpios = <&gpio0 RK_PA6 GPIO_ACTIVE_HIGH>;
 			label = "rockpis:green:power";
 			linux,default-trigger = "default-on";
 		};
 
 		blue-led {
+			color = <LED_COLOR_ID_BLUE>;
 			default-state = "on";
+			function = LED_FUNCTION_HEARTBEAT;
 			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_HIGH>;
 			label = "rockpis:blue:user";
 			linux,default-trigger = "heartbeat";
@@ -127,10 +133,12 @@ &cpu0 {
 };
 
 &emmc {
-	bus-width = <4>;
 	cap-mmc-highspeed;
-	mmc-hs200-1_8v;
+	cap-sd-highspeed;
+	no-sdio;
 	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd>;
 	vmmc-supply = <&vcc_io>;
 	status = "okay";
 };
@@ -153,11 +161,11 @@ &pinctrl {
 	pinctrl-0 = <&rtc_32k>;
 
 	leds {
-		green_led_gio: green-led-gpio {
+		green_led: green-led {
 			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 
-		heartbeat_led_gpio: heartbeat-led-gpio {
+		heartbeat_led: heartbeat-led {
 			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
index 018a3a5075c7..d9905a08c6ce 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
@@ -186,8 +186,8 @@ &i2c1 {
 	rk805: pmic@18 {
 		compatible = "rockchip,rk805";
 		reg = <0x18>;
-		interrupt-parent = <&gpio2>;
-		interrupts = <6 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
 		#clock-cells = <1>;
 		clock-output-names = "xin32k", "rk805-clkout2";
 		gpio-controller;
diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index a4c5aaf1f457..cac58ad951b2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -790,6 +790,7 @@ spdif: spdif@ff880000 {
 		dma-names = "tx";
 		pinctrl-names = "default";
 		pinctrl-0 = <&spdif_tx>;
+		#sound-dai-cells = <0>;
 		status = "disabled";
 	};
 
@@ -801,6 +802,7 @@ i2s_2ch: i2s-2ch@ff890000 {
 		clocks = <&cru SCLK_I2S_2CH>, <&cru HCLK_I2S_2CH>;
 		dmas = <&dmac_bus 6>, <&dmac_bus 7>;
 		dma-names = "tx", "rx";
+		#sound-dai-cells = <0>;
 		status = "disabled";
 	};
 
@@ -814,6 +816,7 @@ i2s_8ch: i2s-8ch@ff898000 {
 		dma-names = "tx", "rx";
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2s_8ch_bus>;
+		#sound-dai-cells = <0>;
 		status = "disabled";
 	};
 
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 604a2053d006..f464a2e0b488 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -840,7 +840,7 @@ __SYSCALL(__NR_pselect6_time64, compat_sys_pselect6_time64)
 #define __NR_ppoll_time64 414
 __SYSCALL(__NR_ppoll_time64, compat_sys_ppoll_time64)
 #define __NR_io_pgetevents_time64 416
-__SYSCALL(__NR_io_pgetevents_time64, sys_io_pgetevents)
+__SYSCALL(__NR_io_pgetevents_time64, compat_sys_io_pgetevents_time64)
 #define __NR_recvmmsg_time64 417
 __SYSCALL(__NR_recvmmsg_time64, compat_sys_recvmmsg_time64)
 #define __NR_mq_timedsend_time64 418
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index d72e8f23422d..c771e94568b9 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -57,17 +57,15 @@ static void invoke_syscall(struct pt_regs *regs, unsigned int scno,
 	syscall_set_return_value(current, regs, 0, ret);
 
 	/*
-	 * Ultimately, this value will get limited by KSTACK_OFFSET_MAX(),
-	 * but not enough for arm64 stack utilization comfort. To keep
-	 * reasonable stack head room, reduce the maximum offset to 9 bits.
+	 * This value will get limited by KSTACK_OFFSET_MAX(), which is 10
+	 * bits. The actual entropy will be further reduced by the compiler
+	 * when applying stack alignment constraints: the AAPCS mandates a
+	 * 16-byte aligned SP at function boundaries, which will remove the
+	 * 4 low bits from any entropy chosen here.
 	 *
-	 * The actual entropy will be further reduced by the compiler when
-	 * applying stack alignment constraints: the AAPCS mandates a
-	 * 16-byte (i.e. 4-bit) aligned SP at function boundaries.
-	 *
-	 * The resulting 5 bits of entropy is seen in SP[8:4].
+	 * The resulting 6 bits of entropy is seen in SP[9:4].
 	 */
-	choose_random_kstack_offset(get_random_u16() & 0x1FF);
+	choose_random_kstack_offset(get_random_u16());
 }
 
 static inline bool has_syscall_work(unsigned long flags)
diff --git a/arch/csky/include/uapi/asm/unistd.h b/arch/csky/include/uapi/asm/unistd.h
index 7ff6a2466af1..e0594b6370a6 100644
--- a/arch/csky/include/uapi/asm/unistd.h
+++ b/arch/csky/include/uapi/asm/unistd.h
@@ -6,6 +6,7 @@
 #define __ARCH_WANT_SYS_CLONE3
 #define __ARCH_WANT_SET_GET_RLIMIT
 #define __ARCH_WANT_TIME32_SYSCALLS
+#define __ARCH_WANT_SYNC_FILE_RANGE2
 #include <asm-generic/unistd.h>
 
 #define __NR_set_thread_area	(__NR_arch_specific_syscall + 0)
diff --git a/arch/hexagon/include/asm/syscalls.h b/arch/hexagon/include/asm/syscalls.h
new file mode 100644
index 000000000000..40f2d08bec92
--- /dev/null
+++ b/arch/hexagon/include/asm/syscalls.h
@@ -0,0 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <asm-generic/syscalls.h>
+
+asmlinkage long sys_hexagon_fadvise64_64(int fd, int advice,
+	                                  u32 a2, u32 a3, u32 a4, u32 a5);
diff --git a/arch/hexagon/include/uapi/asm/unistd.h b/arch/hexagon/include/uapi/asm/unistd.h
index 432c4db1b623..21ae22306b5d 100644
--- a/arch/hexagon/include/uapi/asm/unistd.h
+++ b/arch/hexagon/include/uapi/asm/unistd.h
@@ -36,5 +36,6 @@
 #define __ARCH_WANT_SYS_VFORK
 #define __ARCH_WANT_SYS_FORK
 #define __ARCH_WANT_TIME32_SYSCALLS
+#define __ARCH_WANT_SYNC_FILE_RANGE2
 
 #include <asm-generic/unistd.h>
diff --git a/arch/hexagon/kernel/syscalltab.c b/arch/hexagon/kernel/syscalltab.c
index 0fadd582cfc7..5d98bdc494ec 100644
--- a/arch/hexagon/kernel/syscalltab.c
+++ b/arch/hexagon/kernel/syscalltab.c
@@ -14,6 +14,13 @@
 #undef __SYSCALL
 #define __SYSCALL(nr, call) [nr] = (call),
 
+SYSCALL_DEFINE6(hexagon_fadvise64_64, int, fd, int, advice,
+		SC_ARG64(offset), SC_ARG64(len))
+{
+	return ksys_fadvise64_64(fd, SC_VAL64(loff_t, offset), SC_VAL64(loff_t, len), advice);
+}
+#define sys_fadvise64_64 sys_hexagon_fadvise64_64
+
 void *sys_call_table[__NR_syscalls] = {
 #include <asm/unistd.h>
 };
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 253ff994ed2e..5d952a57c0ee 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -354,7 +354,7 @@
 412	n32	utimensat_time64		sys_utimensat
 413	n32	pselect6_time64			compat_sys_pselect6_time64
 414	n32	ppoll_time64			compat_sys_ppoll_time64
-416	n32	io_pgetevents_time64		sys_io_pgetevents
+416	n32	io_pgetevents_time64		compat_sys_io_pgetevents_time64
 417	n32	recvmmsg_time64			compat_sys_recvmmsg_time64
 418	n32	mq_timedsend_time64		sys_mq_timedsend
 419	n32	mq_timedreceive_time64		sys_mq_timedreceive
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 8f243e35a7b2..7ab572040f53 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -403,7 +403,7 @@
 412	o32	utimensat_time64		sys_utimensat			sys_utimensat
 413	o32	pselect6_time64			sys_pselect6			compat_sys_pselect6_time64
 414	o32	ppoll_time64			sys_ppoll			compat_sys_ppoll_time64
-416	o32	io_pgetevents_time64		sys_io_pgetevents		sys_io_pgetevents
+416	o32	io_pgetevents_time64		sys_io_pgetevents		compat_sys_io_pgetevents_time64
 417	o32	recvmmsg_time64			sys_recvmmsg			compat_sys_recvmmsg_time64
 418	o32	mq_timedsend_time64		sys_mq_timedsend		sys_mq_timedsend
 419	o32	mq_timedreceive_time64		sys_mq_timedreceive		sys_mq_timedreceive
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index abf39ecda6fb..5762633ea95e 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -14,6 +14,7 @@ config PARISC
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_NO_SG_CHAIN
+	select ARCH_SPLIT_ARG64 if !64BIT
 	select ARCH_SUPPORTS_HUGETLBFS if PA20
 	select ARCH_SUPPORTS_MEMORY_FAILURE
 	select ARCH_STACKWALK
diff --git a/arch/parisc/kernel/sys_parisc32.c b/arch/parisc/kernel/sys_parisc32.c
index 2a12a547b447..826c8e51b585 100644
--- a/arch/parisc/kernel/sys_parisc32.c
+++ b/arch/parisc/kernel/sys_parisc32.c
@@ -23,12 +23,3 @@ asmlinkage long sys32_unimplemented(int r26, int r25, int r24, int r23,
     	current->comm, current->pid, r20);
     return -ENOSYS;
 }
-
-asmlinkage long sys32_fanotify_mark(compat_int_t fanotify_fd, compat_uint_t flags,
-	compat_uint_t mask0, compat_uint_t mask1, compat_int_t dfd,
-	const char  __user * pathname)
-{
-	return sys_fanotify_mark(fanotify_fd, flags,
-			((__u64)mask1 << 32) | mask0,
-			 dfd, pathname);
-}
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index 0e42fceb2d5e..42702f5d49f2 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -108,7 +108,7 @@
 95	common	fchown			sys_fchown
 96	common	getpriority		sys_getpriority
 97	common	setpriority		sys_setpriority
-98	common	recv			sys_recv
+98	common	recv			sys_recv			compat_sys_recv
 99	common	statfs			sys_statfs			compat_sys_statfs
 100	common	fstatfs			sys_fstatfs			compat_sys_fstatfs
 101	common	stat64			sys_stat64
@@ -135,7 +135,7 @@
 120	common	clone			sys_clone_wrapper
 121	common	setdomainname		sys_setdomainname
 122	common	sendfile		sys_sendfile			compat_sys_sendfile
-123	common	recvfrom		sys_recvfrom
+123	common	recvfrom		sys_recvfrom			compat_sys_recvfrom
 124	32	adjtimex		sys_adjtimex_time32
 124	64	adjtimex		sys_adjtimex
 125	common	mprotect		sys_mprotect
@@ -364,7 +364,7 @@
 320	common	accept4			sys_accept4
 321	common	prlimit64		sys_prlimit64
 322	common	fanotify_init		sys_fanotify_init
-323	common	fanotify_mark		sys_fanotify_mark		sys32_fanotify_mark
+323	common	fanotify_mark		sys_fanotify_mark		compat_sys_fanotify_mark
 324	32	clock_adjtime		sys_clock_adjtime32
 324	64	clock_adjtime		sys_clock_adjtime
 325	common	name_to_handle_at	sys_name_to_handle_at
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index a0be127475b1..1195f88199ca 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -230,8 +230,10 @@
 178	nospu 	rt_sigsuspend			sys_rt_sigsuspend		compat_sys_rt_sigsuspend
 179	32	pread64				sys_ppc_pread64			compat_sys_ppc_pread64
 179	64	pread64				sys_pread64
+179	spu	pread64				sys_pread64
 180	32	pwrite64			sys_ppc_pwrite64		compat_sys_ppc_pwrite64
 180	64	pwrite64			sys_pwrite64
+180	spu	pwrite64			sys_pwrite64
 181	common	chown				sys_chown
 182	common	getcwd				sys_getcwd
 183	common	capget				sys_capget
@@ -246,6 +248,7 @@
 190	common	ugetrlimit			sys_getrlimit			compat_sys_getrlimit
 191	32	readahead			sys_ppc_readahead		compat_sys_ppc_readahead
 191	64	readahead			sys_readahead
+191	spu	readahead			sys_readahead
 192	32	mmap2				sys_mmap2			compat_sys_mmap2
 193	32	truncate64			sys_ppc_truncate64		compat_sys_ppc_truncate64
 194	32	ftruncate64			sys_ppc_ftruncate64		compat_sys_ppc_ftruncate64
@@ -293,6 +296,7 @@
 232	nospu	set_tid_address			sys_set_tid_address
 233	32	fadvise64			sys_ppc32_fadvise64		compat_sys_ppc32_fadvise64
 233	64	fadvise64			sys_fadvise64
+233	spu	fadvise64			sys_fadvise64
 234	nospu	exit_group			sys_exit_group
 235	nospu	lookup_dcookie			sys_lookup_dcookie		compat_sys_lookup_dcookie
 236	common	epoll_create			sys_epoll_create
@@ -502,7 +506,7 @@
 412	32	utimensat_time64		sys_utimensat			sys_utimensat
 413	32	pselect6_time64			sys_pselect6			compat_sys_pselect6_time64
 414	32	ppoll_time64			sys_ppoll			compat_sys_ppoll_time64
-416	32	io_pgetevents_time64		sys_io_pgetevents		sys_io_pgetevents
+416	32	io_pgetevents_time64		sys_io_pgetevents		compat_sys_io_pgetevents_time64
 417	32	recvmmsg_time64			sys_recvmmsg			compat_sys_recvmmsg_time64
 418	32	mq_timedsend_time64		sys_mq_timedsend		sys_mq_timedsend
 419	32	mq_timedreceive_time64		sys_mq_timedreceive		sys_mq_timedreceive
diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index 528ec7cc9a62..0d3f00eb0bae 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -156,7 +156,7 @@ unsigned long __get_wchan(struct task_struct *task)
 	return pc;
 }
 
-noinline void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
+noinline noinstr void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
 		     struct task_struct *task, struct pt_regs *regs)
 {
 	walk_stackframe(task, regs, consume_entry, cookie);
diff --git a/arch/s390/include/asm/entry-common.h b/arch/s390/include/asm/entry-common.h
index 000de2b1e67a..74124092b1c7 100644
--- a/arch/s390/include/asm/entry-common.h
+++ b/arch/s390/include/asm/entry-common.h
@@ -55,7 +55,7 @@ static __always_inline void arch_exit_to_user_mode(void)
 static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
 						  unsigned long ti_work)
 {
-	choose_random_kstack_offset(get_tod_clock_fast() & 0xff);
+	choose_random_kstack_offset(get_tod_clock_fast());
 }
 
 #define arch_exit_to_user_mode_prepare arch_exit_to_user_mode_prepare
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 799147658dee..42acea15441d 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -418,7 +418,7 @@
 412	32	utimensat_time64	-				sys_utimensat
 413	32	pselect6_time64		-				compat_sys_pselect6_time64
 414	32	ppoll_time64		-				compat_sys_ppoll_time64
-416	32	io_pgetevents_time64	-				sys_io_pgetevents
+416	32	io_pgetevents_time64	-				compat_sys_io_pgetevents_time64
 417	32	recvmmsg_time64		-				compat_sys_recvmmsg_time64
 418	32	mq_timedsend_time64	-				sys_mq_timedsend
 419	32	mq_timedreceive_time64	-				sys_mq_timedreceive
diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
index a2b42a63a53b..04c19ab93a32 100644
--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -410,7 +410,7 @@ static void __init cpu_enable_directed_irq(void *unused)
 	union zpci_sic_iib iib = {{0}};
 	union zpci_sic_iib ziib = {{0}};
 
-	iib.cdiib.dibv_addr = (u64) zpci_ibv[smp_processor_id()]->vector;
+	iib.cdiib.dibv_addr = virt_to_phys(zpci_ibv[smp_processor_id()]->vector);
 
 	zpci_set_irq_ctrl(SIC_IRQ_MODE_SET_CPU, 0, &iib);
 	zpci_set_irq_ctrl(SIC_IRQ_MODE_D_SINGLE, PCI_ISC, &ziib);
diff --git a/arch/sh/kernel/sys_sh32.c b/arch/sh/kernel/sys_sh32.c
index 9dca568509a5..d6f4afcb0e87 100644
--- a/arch/sh/kernel/sys_sh32.c
+++ b/arch/sh/kernel/sys_sh32.c
@@ -59,3 +59,14 @@ asmlinkage int sys_fadvise64_64_wrapper(int fd, u32 offset0, u32 offset1,
 				 (u64)len0 << 32 | len1, advice);
 #endif
 }
+
+/*
+ * swap the arguments the way that libc wants them instead of
+ * moving flags ahead of the 64-bit nbytes argument
+ */
+SYSCALL_DEFINE6(sh_sync_file_range6, int, fd, SC_ARG64(offset),
+                SC_ARG64(nbytes), unsigned int, flags)
+{
+        return ksys_sync_file_range(fd, SC_VAL64(loff_t, offset),
+                                    SC_VAL64(loff_t, nbytes), flags);
+}
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index 2de85c977f54..4741e5c8ac61 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -321,7 +321,7 @@
 311	common	set_robust_list			sys_set_robust_list
 312	common	get_robust_list			sys_get_robust_list
 313	common	splice				sys_splice
-314	common	sync_file_range			sys_sync_file_range
+314	common	sync_file_range			sys_sh_sync_file_range6
 315	common	tee				sys_tee
 316	common	vmsplice			sys_vmsplice
 317	common	move_pages			sys_move_pages
@@ -395,6 +395,7 @@
 385	common	pkey_alloc			sys_pkey_alloc
 386	common	pkey_free			sys_pkey_free
 387	common	rseq				sys_rseq
+388	common	sync_file_range2		sys_sync_file_range2
 # room for arch specific syscalls
 393	common	semget				sys_semget
 394	common	semctl				sys_semctl
diff --git a/arch/sparc/kernel/sys32.S b/arch/sparc/kernel/sys32.S
index a45f0f31fe51..a3d308f2043e 100644
--- a/arch/sparc/kernel/sys32.S
+++ b/arch/sparc/kernel/sys32.S
@@ -18,224 +18,3 @@ sys32_mmap2:
 	sethi		%hi(sys_mmap), %g1
 	jmpl		%g1 + %lo(sys_mmap), %g0
 	 sllx		%o5, 12, %o5
-
-	.align		32
-	.globl		sys32_socketcall
-sys32_socketcall:	/* %o0=call, %o1=args */
-	cmp		%o0, 1
-	bl,pn		%xcc, do_einval
-	 cmp		%o0, 18
-	bg,pn		%xcc, do_einval
-	 sub		%o0, 1, %o0
-	sllx		%o0, 5, %o0
-	sethi		%hi(__socketcall_table_begin), %g2
-	or		%g2, %lo(__socketcall_table_begin), %g2
-	jmpl		%g2 + %o0, %g0
-	 nop
-do_einval:
-	retl
-	 mov		-EINVAL, %o0
-
-	.align		32
-__socketcall_table_begin:
-
-	/* Each entry is exactly 32 bytes. */
-do_sys_socket: /* sys_socket(int, int, int) */
-1:	ldswa		[%o1 + 0x0] %asi, %o0
-	sethi		%hi(sys_socket), %g1
-2:	ldswa		[%o1 + 0x8] %asi, %o2
-	jmpl		%g1 + %lo(sys_socket), %g0
-3:	 ldswa		[%o1 + 0x4] %asi, %o1
-	nop
-	nop
-	nop
-do_sys_bind: /* sys_bind(int fd, struct sockaddr *, int) */
-4:	ldswa		[%o1 + 0x0] %asi, %o0
-	sethi		%hi(sys_bind), %g1
-5:	ldswa		[%o1 + 0x8] %asi, %o2
-	jmpl		%g1 + %lo(sys_bind), %g0
-6:	 lduwa		[%o1 + 0x4] %asi, %o1
-	nop
-	nop
-	nop
-do_sys_connect: /* sys_connect(int, struct sockaddr *, int) */
-7:	ldswa		[%o1 + 0x0] %asi, %o0
-	sethi		%hi(sys_connect), %g1
-8:	ldswa		[%o1 + 0x8] %asi, %o2
-	jmpl		%g1 + %lo(sys_connect), %g0
-9:	 lduwa		[%o1 + 0x4] %asi, %o1
-	nop
-	nop
-	nop
-do_sys_listen: /* sys_listen(int, int) */
-10:	ldswa		[%o1 + 0x0] %asi, %o0
-	sethi		%hi(sys_listen), %g1
-	jmpl		%g1 + %lo(sys_listen), %g0
-11:	 ldswa		[%o1 + 0x4] %asi, %o1
-	nop
-	nop
-	nop
-	nop
-do_sys_accept: /* sys_accept(int, struct sockaddr *, int *) */
-12:	ldswa		[%o1 + 0x0] %asi, %o0
-	sethi		%hi(sys_accept), %g1
-13:	lduwa		[%o1 + 0x8] %asi, %o2
-	jmpl		%g1 + %lo(sys_accept), %g0
-14:	 lduwa		[%o1 + 0x4] %asi, %o1
-	nop
-	nop
-	nop
-do_sys_getsockname: /* sys_getsockname(int, struct sockaddr *, int *) */
-15:	ldswa		[%o1 + 0x0] %asi, %o0
-	sethi		%hi(sys_getsockname), %g1
-16:	lduwa		[%o1 + 0x8] %asi, %o2
-	jmpl		%g1 + %lo(sys_getsockname), %g0
-17:	 lduwa		[%o1 + 0x4] %asi, %o1
-	nop
-	nop
-	nop
-do_sys_getpeername: /* sys_getpeername(int, struct sockaddr *, int *) */
-18:	ldswa		[%o1 + 0x0] %asi, %o0
-	sethi		%hi(sys_getpeername), %g1
-19:	lduwa		[%o1 + 0x8] %asi, %o2
-	jmpl		%g1 + %lo(sys_getpeername), %g0
-20:	 lduwa		[%o1 + 0x4] %asi, %o1
-	nop
-	nop
-	nop
-do_sys_socketpair: /* sys_socketpair(int, int, int, int *) */
-21:	ldswa		[%o1 + 0x0] %asi, %o0
-	sethi		%hi(sys_socketpair), %g1
-22:	ldswa		[%o1 + 0x8] %asi, %o2
-23:	lduwa		[%o1 + 0xc] %asi, %o3
-	jmpl		%g1 + %lo(sys_socketpair), %g0
-24:	 ldswa		[%o1 + 0x4] %asi, %o1
-	nop
-	nop
-do_sys_send: /* sys_send(int, void *, size_t, unsigned int) */
-25:	ldswa		[%o1 + 0x0] %asi, %o0
-	sethi		%hi(sys_send), %g1
-26:	lduwa		[%o1 + 0x8] %asi, %o2
-27:	lduwa		[%o1 + 0xc] %asi, %o3
-	jmpl		%g1 + %lo(sys_send), %g0
-28:	 lduwa		[%o1 + 0x4] %asi, %o1
-	nop
-	nop
-do_sys_recv: /* sys_recv(int, void *, size_t, unsigned int) */
-29:	ldswa		[%o1 + 0x0] %asi, %o0
-	sethi		%hi(sys_recv), %g1
-30:	lduwa		[%o1 + 0x8] %asi, %o2
-31:	lduwa		[%o1 + 0xc] %asi, %o3
-	jmpl		%g1 + %lo(sys_recv), %g0
-32:	 lduwa		[%o1 + 0x4] %asi, %o1
-	nop
-	nop
-do_sys_sendto: /* sys_sendto(int, u32, compat_size_t, unsigned int, u32, int) */
-33:	ldswa		[%o1 + 0x0] %asi, %o0
-	sethi		%hi(sys_sendto), %g1
-34:	lduwa		[%o1 + 0x8] %asi, %o2
-35:	lduwa		[%o1 + 0xc] %asi, %o3
-36:	lduwa		[%o1 + 0x10] %asi, %o4
-37:	ldswa		[%o1 + 0x14] %asi, %o5
-	jmpl		%g1 + %lo(sys_sendto), %g0
-38:	 lduwa		[%o1 + 0x4] %asi, %o1
-do_sys_recvfrom: /* sys_recvfrom(int, u32, compat_size_t, unsigned int, u32, u32) */
-39:	ldswa		[%o1 + 0x0] %asi, %o0
-	sethi		%hi(sys_recvfrom), %g1
-40:	lduwa		[%o1 + 0x8] %asi, %o2
-41:	lduwa		[%o1 + 0xc] %asi, %o3
-42:	lduwa		[%o1 + 0x10] %asi, %o4
-43:	lduwa		[%o1 + 0x14] %asi, %o5
-	jmpl		%g1 + %lo(sys_recvfrom), %g0
-44:	 lduwa		[%o1 + 0x4] %asi, %o1
-do_sys_shutdown: /* sys_shutdown(int, int) */
-45:	ldswa		[%o1 + 0x0] %asi, %o0
-	sethi		%hi(sys_shutdown), %g1
-	jmpl		%g1 + %lo(sys_shutdown), %g0
-46:	 ldswa		[%o1 + 0x4] %asi, %o1
-	nop
-	nop
-	nop
-	nop
-do_sys_setsockopt: /* sys_setsockopt(int, int, int, char *, int) */
-47:	ldswa		[%o1 + 0x0] %asi, %o0
-	sethi		%hi(sys_setsockopt), %g1
-48:	ldswa		[%o1 + 0x8] %asi, %o2
-49:	lduwa		[%o1 + 0xc] %asi, %o3
-50:	ldswa		[%o1 + 0x10] %asi, %o4
-	jmpl		%g1 + %lo(sys_setsockopt), %g0
-51:	 ldswa		[%o1 + 0x4] %asi, %o1
-	nop
-do_sys_getsockopt: /* sys_getsockopt(int, int, int, u32, u32) */
-52:	ldswa		[%o1 + 0x0] %asi, %o0
-	sethi		%hi(sys_getsockopt), %g1
-53:	ldswa		[%o1 + 0x8] %asi, %o2
-54:	lduwa		[%o1 + 0xc] %asi, %o3
-55:	lduwa		[%o1 + 0x10] %asi, %o4
-	jmpl		%g1 + %lo(sys_getsockopt), %g0
-56:	 ldswa		[%o1 + 0x4] %asi, %o1
-	nop
-do_sys_sendmsg: /* compat_sys_sendmsg(int, struct compat_msghdr *, unsigned int) */
-57:	ldswa		[%o1 + 0x0] %asi, %o0
-	sethi		%hi(compat_sys_sendmsg), %g1
-58:	lduwa		[%o1 + 0x8] %asi, %o2
-	jmpl		%g1 + %lo(compat_sys_sendmsg), %g0
-59:	 lduwa		[%o1 + 0x4] %asi, %o1
-	nop
-	nop
-	nop
-do_sys_recvmsg: /* compat_sys_recvmsg(int, struct compat_msghdr *, unsigned int) */
-60:	ldswa		[%o1 + 0x0] %asi, %o0
-	sethi		%hi(compat_sys_recvmsg), %g1
-61:	lduwa		[%o1 + 0x8] %asi, %o2
-	jmpl		%g1 + %lo(compat_sys_recvmsg), %g0
-62:	 lduwa		[%o1 + 0x4] %asi, %o1
-	nop
-	nop
-	nop
-do_sys_accept4: /* sys_accept4(int, struct sockaddr *, int *, int) */
-63:	ldswa		[%o1 + 0x0] %asi, %o0
-	sethi		%hi(sys_accept4), %g1
-64:	lduwa		[%o1 + 0x8] %asi, %o2
-65:	ldswa		[%o1 + 0xc] %asi, %o3
-	jmpl		%g1 + %lo(sys_accept4), %g0
-66:	 lduwa		[%o1 + 0x4] %asi, %o1
-	nop
-	nop
-
-	.section	__ex_table,"a"
-	.align		4
-	.word		1b, __retl_efault, 2b, __retl_efault
-	.word		3b, __retl_efault, 4b, __retl_efault
-	.word		5b, __retl_efault, 6b, __retl_efault
-	.word		7b, __retl_efault, 8b, __retl_efault
-	.word		9b, __retl_efault, 10b, __retl_efault
-	.word		11b, __retl_efault, 12b, __retl_efault
-	.word		13b, __retl_efault, 14b, __retl_efault
-	.word		15b, __retl_efault, 16b, __retl_efault
-	.word		17b, __retl_efault, 18b, __retl_efault
-	.word		19b, __retl_efault, 20b, __retl_efault
-	.word		21b, __retl_efault, 22b, __retl_efault
-	.word		23b, __retl_efault, 24b, __retl_efault
-	.word		25b, __retl_efault, 26b, __retl_efault
-	.word		27b, __retl_efault, 28b, __retl_efault
-	.word		29b, __retl_efault, 30b, __retl_efault
-	.word		31b, __retl_efault, 32b, __retl_efault
-	.word		33b, __retl_efault, 34b, __retl_efault
-	.word		35b, __retl_efault, 36b, __retl_efault
-	.word		37b, __retl_efault, 38b, __retl_efault
-	.word		39b, __retl_efault, 40b, __retl_efault
-	.word		41b, __retl_efault, 42b, __retl_efault
-	.word		43b, __retl_efault, 44b, __retl_efault
-	.word		45b, __retl_efault, 46b, __retl_efault
-	.word		47b, __retl_efault, 48b, __retl_efault
-	.word		49b, __retl_efault, 50b, __retl_efault
-	.word		51b, __retl_efault, 52b, __retl_efault
-	.word		53b, __retl_efault, 54b, __retl_efault
-	.word		55b, __retl_efault, 56b, __retl_efault
-	.word		57b, __retl_efault, 58b, __retl_efault
-	.word		59b, __retl_efault, 60b, __retl_efault
-	.word		61b, __retl_efault, 62b, __retl_efault
-	.word		63b, __retl_efault, 64b, __retl_efault
-	.word		65b, __retl_efault, 66b, __retl_efault
-	.previous
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 4398cc6fb68d..0ddddd3e38c0 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -117,7 +117,7 @@
 90	common	dup2			sys_dup2
 91	32	setfsuid32		sys_setfsuid
 92	common	fcntl			sys_fcntl			compat_sys_fcntl
-93	common	select			sys_select
+93	common	select			sys_select			compat_sys_select
 94	32	setfsgid32		sys_setfsgid
 95	common	fsync			sys_fsync
 96	common	setpriority		sys_setpriority
@@ -155,7 +155,7 @@
 123	32	fchown			sys_fchown16
 123	64	fchown			sys_fchown
 124	common	fchmod			sys_fchmod
-125	common	recvfrom		sys_recvfrom
+125	common	recvfrom		sys_recvfrom			compat_sys_recvfrom
 126	32	setreuid		sys_setreuid16
 126	64	setreuid		sys_setreuid
 127	32	setregid		sys_setregid16
@@ -247,7 +247,7 @@
 204	32	readdir			sys_old_readdir			compat_sys_old_readdir
 204	64	readdir			sys_nis_syscall
 205	common	readahead		sys_readahead			compat_sys_readahead
-206	common	socketcall		sys_socketcall			sys32_socketcall
+206	common	socketcall		sys_socketcall			compat_sys_socketcall
 207	common	syslog			sys_syslog
 208	common	lookup_dcookie		sys_lookup_dcookie		compat_sys_lookup_dcookie
 209	common	fadvise64		sys_fadvise64			compat_sys_fadvise64
@@ -461,7 +461,7 @@
 412	32	utimensat_time64		sys_utimensat			sys_utimensat
 413	32	pselect6_time64			sys_pselect6			compat_sys_pselect6_time64
 414	32	ppoll_time64			sys_ppoll			compat_sys_ppoll_time64
-416	32	io_pgetevents_time64		sys_io_pgetevents		sys_io_pgetevents
+416	32	io_pgetevents_time64		sys_io_pgetevents		compat_sys_io_pgetevents_time64
 417	32	recvmmsg_time64			sys_recvmmsg			compat_sys_recvmmsg_time64
 418	32	mq_timedsend_time64		sys_mq_timedsend		sys_mq_timedsend
 419	32	mq_timedreceive_time64		sys_mq_timedreceive		sys_mq_timedreceive
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 320480a8db4f..81e60b37128f 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -420,7 +420,7 @@
 412	i386	utimensat_time64	sys_utimensat
 413	i386	pselect6_time64		sys_pselect6			compat_sys_pselect6_time64
 414	i386	ppoll_time64		sys_ppoll			compat_sys_ppoll_time64
-416	i386	io_pgetevents_time64	sys_io_pgetevents
+416	i386	io_pgetevents_time64	sys_io_pgetevents		compat_sys_io_pgetevents_time64
 417	i386	recvmmsg_time64		sys_recvmmsg			compat_sys_recvmmsg_time64
 418	i386	mq_timedsend_time64	sys_mq_timedsend
 419	i386	mq_timedreceive_time64	sys_mq_timedreceive
diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index e601264b1a24..5f1ff78cf5e3 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -416,6 +416,17 @@ static inline void efi_fake_memmap_early(void)
 }
 #endif
 
+extern int __init efi_memmap_alloc(unsigned int num_entries,
+				   struct efi_memory_map_data *data);
+extern void __efi_memmap_free(u64 phys, unsigned long size,
+			      unsigned long flags);
+
+extern int __init efi_memmap_install(struct efi_memory_map_data *data);
+extern int __init efi_memmap_split_count(efi_memory_desc_t *md,
+					 struct range *range);
+extern void __init efi_memmap_insert(struct efi_memory_map *old_memmap,
+				     void *buf, struct efi_mem_range *mem);
+
 #define arch_ima_efi_boot_mode	\
 	({ extern struct boot_params boot_params; boot_params.secure_boot; })
 
diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
index ffe72790ceaf..ebdf5c97f53a 100644
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -73,19 +73,16 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
 #endif
 
 	/*
-	 * Ultimately, this value will get limited by KSTACK_OFFSET_MAX(),
-	 * but not enough for x86 stack utilization comfort. To keep
-	 * reasonable stack head room, reduce the maximum offset to 8 bits.
-	 *
-	 * The actual entropy will be further reduced by the compiler when
-	 * applying stack alignment constraints (see cc_stack_align4/8 in
+	 * This value will get limited by KSTACK_OFFSET_MAX(), which is 10
+	 * bits. The actual entropy will be further reduced by the compiler
+	 * when applying stack alignment constraints (see cc_stack_align4/8 in
 	 * arch/x86/Makefile), which will remove the 3 (x86_64) or 2 (ia32)
 	 * low bits from any entropy chosen here.
 	 *
-	 * Therefore, final stack offset entropy will be 5 (x86_64) or
-	 * 6 (ia32) bits.
+	 * Therefore, final stack offset entropy will be 7 (x86_64) or
+	 * 8 (ia32) bits.
 	 */
-	choose_random_kstack_offset(rdtsc() & 0xFF);
+	choose_random_kstack_offset(rdtsc());
 }
 #define arch_exit_to_user_mode_prepare arch_exit_to_user_mode_prepare
 
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 1d190761d00f..f1446f532b17 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -145,8 +145,8 @@ void restore_fpregs_from_fpstate(struct fpstate *fpstate, u64 mask)
 		asm volatile(
 			"fnclex\n\t"
 			"emms\n\t"
-			"fildl %P[addr]"	/* set F?P to defined value */
-			: : [addr] "m" (fpstate));
+			"fildl %[addr]"	/* set F?P to defined value */
+			: : [addr] "m" (*fpstate));
 	}
 
 	if (use_xsave()) {
diff --git a/arch/x86/kernel/time.c b/arch/x86/kernel/time.c
index e42faa792c07..52e1f3f0b361 100644
--- a/arch/x86/kernel/time.c
+++ b/arch/x86/kernel/time.c
@@ -27,25 +27,7 @@
 
 unsigned long profile_pc(struct pt_regs *regs)
 {
-	unsigned long pc = instruction_pointer(regs);
-
-	if (!user_mode(regs) && in_lock_functions(pc)) {
-#ifdef CONFIG_FRAME_POINTER
-		return *(unsigned long *)(regs->bp + sizeof(long));
-#else
-		unsigned long *sp = (unsigned long *)regs->sp;
-		/*
-		 * Return address is either directly at stack pointer
-		 * or above a saved flags. Eflags has bits 22-31 zero,
-		 * kernel addresses don't.
-		 */
-		if (sp[0] >> 22)
-			return sp[0];
-		if (sp[1] >> 22)
-			return sp[1];
-#endif
-	}
-	return pc;
+	return instruction_pointer(regs);
 }
 EXPORT_SYMBOL(profile_pc);
 
diff --git a/arch/x86/platform/efi/Makefile b/arch/x86/platform/efi/Makefile
index a50245157685..4bd708c037e1 100644
--- a/arch/x86/platform/efi/Makefile
+++ b/arch/x86/platform/efi/Makefile
@@ -2,5 +2,6 @@
 KASAN_SANITIZE := n
 GCOV_PROFILE := n
 
-obj-$(CONFIG_EFI) 		+= quirks.o efi.o efi_$(BITS).o efi_stub_$(BITS).o
+obj-$(CONFIG_EFI) 		+= memmap.o quirks.o efi.o efi_$(BITS).o \
+				   efi_stub_$(BITS).o
 obj-$(CONFIG_EFI_MIXED)		+= efi_thunk_$(BITS).o
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index ebc98a68c400..7e51c14a1ef0 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -214,9 +214,11 @@ int __init efi_memblock_x86_reserve_range(void)
 	data.desc_size		= e->efi_memdesc_size;
 	data.desc_version	= e->efi_memdesc_version;
 
-	rv = efi_memmap_init_early(&data);
-	if (rv)
-		return rv;
+	if (!efi_enabled(EFI_PARAVIRT)) {
+		rv = efi_memmap_init_early(&data);
+		if (rv)
+			return rv;
+	}
 
 	if (add_efi_memmap || do_efi_soft_reserve())
 		do_add_efi_memmap();
diff --git a/arch/x86/platform/efi/memmap.c b/arch/x86/platform/efi/memmap.c
new file mode 100644
index 000000000000..93baffd443fe
--- /dev/null
+++ b/arch/x86/platform/efi/memmap.c
@@ -0,0 +1,249 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Common EFI memory map functions.
+ */
+
+#define pr_fmt(fmt) "efi: " fmt
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/efi.h>
+#include <linux/io.h>
+#include <asm/early_ioremap.h>
+#include <asm/efi.h>
+#include <linux/memblock.h>
+#include <linux/slab.h>
+
+static phys_addr_t __init __efi_memmap_alloc_early(unsigned long size)
+{
+	return memblock_phys_alloc(size, SMP_CACHE_BYTES);
+}
+
+static phys_addr_t __init __efi_memmap_alloc_late(unsigned long size)
+{
+	unsigned int order = get_order(size);
+	struct page *p = alloc_pages(GFP_KERNEL, order);
+
+	if (!p)
+		return 0;
+
+	return PFN_PHYS(page_to_pfn(p));
+}
+
+void __init __efi_memmap_free(u64 phys, unsigned long size, unsigned long flags)
+{
+	if (flags & EFI_MEMMAP_MEMBLOCK) {
+		if (slab_is_available())
+			memblock_free_late(phys, size);
+		else
+			memblock_phys_free(phys, size);
+	} else if (flags & EFI_MEMMAP_SLAB) {
+		struct page *p = pfn_to_page(PHYS_PFN(phys));
+		unsigned int order = get_order(size);
+
+		free_pages((unsigned long) page_address(p), order);
+	}
+}
+
+/**
+ * efi_memmap_alloc - Allocate memory for the EFI memory map
+ * @num_entries: Number of entries in the allocated map.
+ * @data: efi memmap installation parameters
+ *
+ * Depending on whether mm_init() has already been invoked or not,
+ * either memblock or "normal" page allocation is used.
+ *
+ * Returns zero on success, a negative error code on failure.
+ */
+int __init efi_memmap_alloc(unsigned int num_entries,
+		struct efi_memory_map_data *data)
+{
+	/* Expect allocation parameters are zero initialized */
+	WARN_ON(data->phys_map || data->size);
+
+	data->size = num_entries * efi.memmap.desc_size;
+	data->desc_version = efi.memmap.desc_version;
+	data->desc_size = efi.memmap.desc_size;
+	data->flags &= ~(EFI_MEMMAP_SLAB | EFI_MEMMAP_MEMBLOCK);
+	data->flags |= efi.memmap.flags & EFI_MEMMAP_LATE;
+
+	if (slab_is_available()) {
+		data->flags |= EFI_MEMMAP_SLAB;
+		data->phys_map = __efi_memmap_alloc_late(data->size);
+	} else {
+		data->flags |= EFI_MEMMAP_MEMBLOCK;
+		data->phys_map = __efi_memmap_alloc_early(data->size);
+	}
+
+	if (!data->phys_map)
+		return -ENOMEM;
+	return 0;
+}
+
+/**
+ * efi_memmap_install - Install a new EFI memory map in efi.memmap
+ * @ctx: map allocation parameters (address, size, flags)
+ *
+ * Unlike efi_memmap_init_*(), this function does not allow the caller
+ * to switch from early to late mappings. It simply uses the existing
+ * mapping function and installs the new memmap.
+ *
+ * Returns zero on success, a negative error code on failure.
+ */
+int __init efi_memmap_install(struct efi_memory_map_data *data)
+{
+	unsigned long size = efi.memmap.desc_size * efi.memmap.nr_map;
+	unsigned long flags = efi.memmap.flags;
+	u64 phys = efi.memmap.phys_map;
+	int ret;
+
+	efi_memmap_unmap();
+
+	if (efi_enabled(EFI_PARAVIRT))
+		return 0;
+
+	ret = __efi_memmap_init(data);
+	if (ret)
+		return ret;
+
+	__efi_memmap_free(phys, size, flags);
+	return 0;
+}
+
+/**
+ * efi_memmap_split_count - Count number of additional EFI memmap entries
+ * @md: EFI memory descriptor to split
+ * @range: Address range (start, end) to split around
+ *
+ * Returns the number of additional EFI memmap entries required to
+ * accommodate @range.
+ */
+int __init efi_memmap_split_count(efi_memory_desc_t *md, struct range *range)
+{
+	u64 m_start, m_end;
+	u64 start, end;
+	int count = 0;
+
+	start = md->phys_addr;
+	end = start + (md->num_pages << EFI_PAGE_SHIFT) - 1;
+
+	/* modifying range */
+	m_start = range->start;
+	m_end = range->end;
+
+	if (m_start <= start) {
+		/* split into 2 parts */
+		if (start < m_end && m_end < end)
+			count++;
+	}
+
+	if (start < m_start && m_start < end) {
+		/* split into 3 parts */
+		if (m_end < end)
+			count += 2;
+		/* split into 2 parts */
+		if (end <= m_end)
+			count++;
+	}
+
+	return count;
+}
+
+/**
+ * efi_memmap_insert - Insert a memory region in an EFI memmap
+ * @old_memmap: The existing EFI memory map structure
+ * @buf: Address of buffer to store new map
+ * @mem: Memory map entry to insert
+ *
+ * It is suggested that you call efi_memmap_split_count() first
+ * to see how large @buf needs to be.
+ */
+void __init efi_memmap_insert(struct efi_memory_map *old_memmap, void *buf,
+			      struct efi_mem_range *mem)
+{
+	u64 m_start, m_end, m_attr;
+	efi_memory_desc_t *md;
+	u64 start, end;
+	void *old, *new;
+
+	/* modifying range */
+	m_start = mem->range.start;
+	m_end = mem->range.end;
+	m_attr = mem->attribute;
+
+	/*
+	 * The EFI memory map deals with regions in EFI_PAGE_SIZE
+	 * units. Ensure that the region described by 'mem' is aligned
+	 * correctly.
+	 */
+	if (!IS_ALIGNED(m_start, EFI_PAGE_SIZE) ||
+	    !IS_ALIGNED(m_end + 1, EFI_PAGE_SIZE)) {
+		WARN_ON(1);
+		return;
+	}
+
+	for (old = old_memmap->map, new = buf;
+	     old < old_memmap->map_end;
+	     old += old_memmap->desc_size, new += old_memmap->desc_size) {
+
+		/* copy original EFI memory descriptor */
+		memcpy(new, old, old_memmap->desc_size);
+		md = new;
+		start = md->phys_addr;
+		end = md->phys_addr + (md->num_pages << EFI_PAGE_SHIFT) - 1;
+
+		if (m_start <= start && end <= m_end)
+			md->attribute |= m_attr;
+
+		if (m_start <= start &&
+		    (start < m_end && m_end < end)) {
+			/* first part */
+			md->attribute |= m_attr;
+			md->num_pages = (m_end - md->phys_addr + 1) >>
+				EFI_PAGE_SHIFT;
+			/* latter part */
+			new += old_memmap->desc_size;
+			memcpy(new, old, old_memmap->desc_size);
+			md = new;
+			md->phys_addr = m_end + 1;
+			md->num_pages = (end - md->phys_addr + 1) >>
+				EFI_PAGE_SHIFT;
+		}
+
+		if ((start < m_start && m_start < end) && m_end < end) {
+			/* first part */
+			md->num_pages = (m_start - md->phys_addr) >>
+				EFI_PAGE_SHIFT;
+			/* middle part */
+			new += old_memmap->desc_size;
+			memcpy(new, old, old_memmap->desc_size);
+			md = new;
+			md->attribute |= m_attr;
+			md->phys_addr = m_start;
+			md->num_pages = (m_end - m_start + 1) >>
+				EFI_PAGE_SHIFT;
+			/* last part */
+			new += old_memmap->desc_size;
+			memcpy(new, old, old_memmap->desc_size);
+			md = new;
+			md->phys_addr = m_end + 1;
+			md->num_pages = (end - m_end) >>
+				EFI_PAGE_SHIFT;
+		}
+
+		if ((start < m_start && m_start < end) &&
+		    (end <= m_end)) {
+			/* first part */
+			md->num_pages = (m_start - md->phys_addr) >>
+				EFI_PAGE_SHIFT;
+			/* latter part */
+			new += old_memmap->desc_size;
+			memcpy(new, old, old_memmap->desc_size);
+			md = new;
+			md->phys_addr = m_start;
+			md->num_pages = (end - md->phys_addr + 1) >>
+				EFI_PAGE_SHIFT;
+			md->attribute |= m_attr;
+		}
+	}
+}
diff --git a/crypto/ecdh.c b/crypto/ecdh.c
index 80afee3234fb..3049f147e011 100644
--- a/crypto/ecdh.c
+++ b/crypto/ecdh.c
@@ -33,6 +33,8 @@ static int ecdh_set_secret(struct crypto_kpp *tfm, const void *buf,
 	    params.key_size > sizeof(u64) * ctx->ndigits)
 		return -EINVAL;
 
+	memset(ctx->private_key, 0, sizeof(ctx->private_key));
+
 	if (!params.key || !params.key_size)
 		return ecc_gen_privkey(ctx->curve_id, ctx->ndigits,
 				       ctx->private_key);
diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index e45285d4e62a..d0257758cf98 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -188,16 +188,16 @@ bool acpi_device_override_status(struct acpi_device *adev, unsigned long long *s
 }
 
 /*
- * AMD systems from Renoir and Lucienne *require* that the NVME controller
+ * AMD systems from Renoir onwards *require* that the NVME controller
  * is put into D3 over a Modern Standby / suspend-to-idle cycle.
  *
  * This is "typically" accomplished using the `StorageD3Enable`
  * property in the _DSD that is checked via the `acpi_storage_d3` function
- * but this property was introduced after many of these systems launched
- * and most OEM systems don't have it in their BIOS.
+ * but some OEM systems still don't have it in their BIOS.
  *
  * The Microsoft documentation for StorageD3Enable mentioned that Windows has
- * a hardcoded allowlist for D3 support, which was used for these platforms.
+ * a hardcoded allowlist for D3 support as well as a registry key to override
+ * the BIOS, which has been used for these cases.
  *
  * This allows quirking on Linux in a similar fashion.
  *
@@ -210,18 +210,15 @@ bool acpi_device_override_status(struct acpi_device *adev, unsigned long long *s
  *    https://bugzilla.kernel.org/show_bug.cgi?id=216773
  *    https://bugzilla.kernel.org/show_bug.cgi?id=217003
  * 2) On at least one HP system StorageD3Enable is missing on the second NVME
-      disk in the system.
+ *    disk in the system.
+ * 3) On at least one HP Rembrandt system StorageD3Enable is missing on the only
+ *    NVME device.
  */
-static const struct x86_cpu_id storage_d3_cpu_ids[] = {
-	X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 96, NULL),	/* Renoir */
-	X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 104, NULL),	/* Lucienne */
-	X86_MATCH_VENDOR_FAM_MODEL(AMD, 25, 80, NULL),	/* Cezanne */
-	{}
-};
-
 bool force_storage_d3(void)
 {
-	return x86_match_cpu(storage_d3_cpu_ids);
+	if (!cpu_feature_enabled(X86_FEATURE_ZEN))
+		return false;
+	return acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0;
 }
 
 /*
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 17119e8dc8c3..20f53ae4d204 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1891,8 +1891,10 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	n_ports = max(ahci_nr_ports(hpriv->cap), fls(hpriv->port_map));
 
 	host = ata_host_alloc_pinfo(&pdev->dev, ppi, n_ports);
-	if (!host)
-		return -ENOMEM;
+	if (!host) {
+		rc = -ENOMEM;
+		goto err_rm_sysfs_file;
+	}
 	host->private_data = hpriv;
 
 	if (ahci_init_msi(pdev, n_ports, hpriv) < 0) {
@@ -1945,11 +1947,11 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* initialize adapter */
 	rc = ahci_configure_dma_masks(pdev, hpriv);
 	if (rc)
-		return rc;
+		goto err_rm_sysfs_file;
 
 	rc = ahci_pci_reset_controller(host);
 	if (rc)
-		return rc;
+		goto err_rm_sysfs_file;
 
 	ahci_pci_init_controller(host);
 	ahci_pci_print_info(host);
@@ -1958,10 +1960,15 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	rc = ahci_host_activate(host, &ahci_sht);
 	if (rc)
-		return rc;
+		goto err_rm_sysfs_file;
 
 	pm_runtime_put_noidle(&pdev->dev);
 	return 0;
+
+err_rm_sysfs_file:
+	sysfs_remove_file_from_group(&pdev->dev.kobj,
+				     &dev_attr_remapped_nvme.attr, NULL);
+	return rc;
 }
 
 static void ahci_shutdown_one(struct pci_dev *pdev)
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index f14e56a5cff6..5a13630034ef 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5523,8 +5523,10 @@ struct ata_host *ata_host_alloc(struct device *dev, int max_ports)
 	if (!host)
 		return NULL;
 
-	if (!devres_open_group(dev, NULL, GFP_KERNEL))
-		goto err_free;
+	if (!devres_open_group(dev, NULL, GFP_KERNEL)) {
+		kfree(host);
+		return NULL;
+	}
 
 	dr = devres_alloc(ata_devres_release, 0, GFP_KERNEL);
 	if (!dr)
@@ -5556,8 +5558,6 @@ struct ata_host *ata_host_alloc(struct device *dev, int max_ports)
 
  err_out:
 	devres_release_group(dev, NULL);
- err_free:
-	kfree(host);
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(ata_host_alloc);
diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
index b0f24cf3e891..4d3de4a35801 100644
--- a/drivers/counter/ti-eqep.c
+++ b/drivers/counter/ti-eqep.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/clk.h>
 #include <linux/counter.h>
 #include <linux/kernel.h>
 #include <linux/mod_devicetable.h>
@@ -376,6 +377,7 @@ static int ti_eqep_probe(struct platform_device *pdev)
 	struct counter_device *counter;
 	struct ti_eqep_cnt *priv;
 	void __iomem *base;
+	struct clk *clk;
 	int err;
 
 	counter = devm_counter_alloc(dev, sizeof(*priv));
@@ -415,6 +417,10 @@ static int ti_eqep_probe(struct platform_device *pdev)
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
 
+	clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "failed to enable clock\n");
+
 	err = counter_add(counter);
 	if (err < 0) {
 		pm_runtime_put_sync(dev);
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 9f147e9eafb6..90dcf26f0973 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -424,7 +424,7 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
 	if (state)
 		policy->cpuinfo.max_freq = cpudata->max_freq;
 	else
-		policy->cpuinfo.max_freq = cpudata->nominal_freq * 1000;
+		policy->cpuinfo.max_freq = cpudata->nominal_freq;
 
 	policy->max = policy->cpuinfo.max_freq;
 
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 5771f3fc6115..4abda800c632 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -348,15 +348,14 @@ static void intel_pstate_set_itmt_prio(int cpu)
 	int ret;
 
 	ret = cppc_get_perf_caps(cpu, &cppc_perf);
-	if (ret)
-		return;
-
 	/*
-	 * On some systems with overclocking enabled, CPPC.highest_perf is hardcoded to 0xff.
-	 * In this case we can't use CPPC.highest_perf to enable ITMT.
-	 * In this case we can look at MSR_HWP_CAPABILITIES bits [8:0] to decide.
+	 * If CPPC is not available, fall back to MSR_HWP_CAPABILITIES bits [8:0].
+	 *
+	 * Also, on some systems with overclocking enabled, CPPC.highest_perf is
+	 * hardcoded to 0xff, so CPPC.highest_perf cannot be used to enable ITMT.
+	 * Fall back to MSR_HWP_CAPABILITIES then too.
 	 */
-	if (cppc_perf.highest_perf == CPPC_MAX_PERF)
+	if (ret || cppc_perf.highest_perf == CPPC_MAX_PERF)
 		cppc_perf.highest_perf = HWP_HIGHEST_PERF(READ_ONCE(all_cpu_data[cpu]->hwp_cap_cached));
 
 	/*
diff --git a/drivers/firmware/efi/fdtparams.c b/drivers/firmware/efi/fdtparams.c
index e901f8564ca0..0ec83ba58097 100644
--- a/drivers/firmware/efi/fdtparams.c
+++ b/drivers/firmware/efi/fdtparams.c
@@ -30,11 +30,13 @@ static __initconst const char name[][22] = {
 
 static __initconst const struct {
 	const char	path[17];
+	u8		paravirt;
 	const char	params[PARAMCOUNT][26];
 } dt_params[] = {
 	{
 #ifdef CONFIG_XEN    //  <-------17------>
 		.path = "/hypervisor/uefi",
+		.paravirt = 1,
 		.params = {
 			[SYSTAB] = "xen,uefi-system-table",
 			[MMBASE] = "xen,uefi-mmap-start",
@@ -121,6 +123,8 @@ u64 __init efi_get_fdt_params(struct efi_memory_map_data *mm)
 			pr_err("Can't find property '%s' in DT!\n", pname);
 			return 0;
 		}
+		if (dt_params[i].paravirt)
+			set_bit(EFI_PARAVIRT, &efi.flags);
 		return systab;
 	}
 notfound:
diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
index 6ec7970dbd40..77dd20f9df31 100644
--- a/drivers/firmware/efi/memmap.c
+++ b/drivers/firmware/efi/memmap.c
@@ -9,82 +9,11 @@
 #include <linux/kernel.h>
 #include <linux/efi.h>
 #include <linux/io.h>
-#include <asm/early_ioremap.h>
 #include <linux/memblock.h>
 #include <linux/slab.h>
 
-static phys_addr_t __init __efi_memmap_alloc_early(unsigned long size)
-{
-	return memblock_phys_alloc(size, SMP_CACHE_BYTES);
-}
-
-static phys_addr_t __init __efi_memmap_alloc_late(unsigned long size)
-{
-	unsigned int order = get_order(size);
-	struct page *p = alloc_pages(GFP_KERNEL, order);
-
-	if (!p)
-		return 0;
-
-	return PFN_PHYS(page_to_pfn(p));
-}
-
-void __init __efi_memmap_free(u64 phys, unsigned long size, unsigned long flags)
-{
-	if (flags & EFI_MEMMAP_MEMBLOCK) {
-		if (slab_is_available())
-			memblock_free_late(phys, size);
-		else
-			memblock_phys_free(phys, size);
-	} else if (flags & EFI_MEMMAP_SLAB) {
-		struct page *p = pfn_to_page(PHYS_PFN(phys));
-		unsigned int order = get_order(size);
-
-		free_pages((unsigned long) page_address(p), order);
-	}
-}
-
-static void __init efi_memmap_free(void)
-{
-	__efi_memmap_free(efi.memmap.phys_map,
-			efi.memmap.desc_size * efi.memmap.nr_map,
-			efi.memmap.flags);
-}
-
-/**
- * efi_memmap_alloc - Allocate memory for the EFI memory map
- * @num_entries: Number of entries in the allocated map.
- * @data: efi memmap installation parameters
- *
- * Depending on whether mm_init() has already been invoked or not,
- * either memblock or "normal" page allocation is used.
- *
- * Returns zero on success, a negative error code on failure.
- */
-int __init efi_memmap_alloc(unsigned int num_entries,
-		struct efi_memory_map_data *data)
-{
-	/* Expect allocation parameters are zero initialized */
-	WARN_ON(data->phys_map || data->size);
-
-	data->size = num_entries * efi.memmap.desc_size;
-	data->desc_version = efi.memmap.desc_version;
-	data->desc_size = efi.memmap.desc_size;
-	data->flags &= ~(EFI_MEMMAP_SLAB | EFI_MEMMAP_MEMBLOCK);
-	data->flags |= efi.memmap.flags & EFI_MEMMAP_LATE;
-
-	if (slab_is_available()) {
-		data->flags |= EFI_MEMMAP_SLAB;
-		data->phys_map = __efi_memmap_alloc_late(data->size);
-	} else {
-		data->flags |= EFI_MEMMAP_MEMBLOCK;
-		data->phys_map = __efi_memmap_alloc_early(data->size);
-	}
-
-	if (!data->phys_map)
-		return -ENOMEM;
-	return 0;
-}
+#include <asm/early_ioremap.h>
+#include <asm/efi.h>
 
 /**
  * __efi_memmap_init - Common code for mapping the EFI memory map
@@ -101,14 +30,11 @@ int __init efi_memmap_alloc(unsigned int num_entries,
  *
  * Returns zero on success, a negative error code on failure.
  */
-static int __init __efi_memmap_init(struct efi_memory_map_data *data)
+int __init __efi_memmap_init(struct efi_memory_map_data *data)
 {
 	struct efi_memory_map map;
 	phys_addr_t phys_map;
 
-	if (efi_enabled(EFI_PARAVIRT))
-		return 0;
-
 	phys_map = data->phys_map;
 
 	if (data->flags & EFI_MEMMAP_LATE)
@@ -121,9 +47,6 @@ static int __init __efi_memmap_init(struct efi_memory_map_data *data)
 		return -ENOMEM;
 	}
 
-	/* NOP if data->flags & (EFI_MEMMAP_MEMBLOCK | EFI_MEMMAP_SLAB) == 0 */
-	efi_memmap_free();
-
 	map.phys_map = data->phys_map;
 	map.nr_map = data->size / data->desc_size;
 	map.map_end = map.map + data->size;
@@ -220,158 +143,3 @@ int __init efi_memmap_init_late(phys_addr_t addr, unsigned long size)
 
 	return __efi_memmap_init(&data);
 }
-
-/**
- * efi_memmap_install - Install a new EFI memory map in efi.memmap
- * @ctx: map allocation parameters (address, size, flags)
- *
- * Unlike efi_memmap_init_*(), this function does not allow the caller
- * to switch from early to late mappings. It simply uses the existing
- * mapping function and installs the new memmap.
- *
- * Returns zero on success, a negative error code on failure.
- */
-int __init efi_memmap_install(struct efi_memory_map_data *data)
-{
-	efi_memmap_unmap();
-
-	return __efi_memmap_init(data);
-}
-
-/**
- * efi_memmap_split_count - Count number of additional EFI memmap entries
- * @md: EFI memory descriptor to split
- * @range: Address range (start, end) to split around
- *
- * Returns the number of additional EFI memmap entries required to
- * accommodate @range.
- */
-int __init efi_memmap_split_count(efi_memory_desc_t *md, struct range *range)
-{
-	u64 m_start, m_end;
-	u64 start, end;
-	int count = 0;
-
-	start = md->phys_addr;
-	end = start + (md->num_pages << EFI_PAGE_SHIFT) - 1;
-
-	/* modifying range */
-	m_start = range->start;
-	m_end = range->end;
-
-	if (m_start <= start) {
-		/* split into 2 parts */
-		if (start < m_end && m_end < end)
-			count++;
-	}
-
-	if (start < m_start && m_start < end) {
-		/* split into 3 parts */
-		if (m_end < end)
-			count += 2;
-		/* split into 2 parts */
-		if (end <= m_end)
-			count++;
-	}
-
-	return count;
-}
-
-/**
- * efi_memmap_insert - Insert a memory region in an EFI memmap
- * @old_memmap: The existing EFI memory map structure
- * @buf: Address of buffer to store new map
- * @mem: Memory map entry to insert
- *
- * It is suggested that you call efi_memmap_split_count() first
- * to see how large @buf needs to be.
- */
-void __init efi_memmap_insert(struct efi_memory_map *old_memmap, void *buf,
-			      struct efi_mem_range *mem)
-{
-	u64 m_start, m_end, m_attr;
-	efi_memory_desc_t *md;
-	u64 start, end;
-	void *old, *new;
-
-	/* modifying range */
-	m_start = mem->range.start;
-	m_end = mem->range.end;
-	m_attr = mem->attribute;
-
-	/*
-	 * The EFI memory map deals with regions in EFI_PAGE_SIZE
-	 * units. Ensure that the region described by 'mem' is aligned
-	 * correctly.
-	 */
-	if (!IS_ALIGNED(m_start, EFI_PAGE_SIZE) ||
-	    !IS_ALIGNED(m_end + 1, EFI_PAGE_SIZE)) {
-		WARN_ON(1);
-		return;
-	}
-
-	for (old = old_memmap->map, new = buf;
-	     old < old_memmap->map_end;
-	     old += old_memmap->desc_size, new += old_memmap->desc_size) {
-
-		/* copy original EFI memory descriptor */
-		memcpy(new, old, old_memmap->desc_size);
-		md = new;
-		start = md->phys_addr;
-		end = md->phys_addr + (md->num_pages << EFI_PAGE_SHIFT) - 1;
-
-		if (m_start <= start && end <= m_end)
-			md->attribute |= m_attr;
-
-		if (m_start <= start &&
-		    (start < m_end && m_end < end)) {
-			/* first part */
-			md->attribute |= m_attr;
-			md->num_pages = (m_end - md->phys_addr + 1) >>
-				EFI_PAGE_SHIFT;
-			/* latter part */
-			new += old_memmap->desc_size;
-			memcpy(new, old, old_memmap->desc_size);
-			md = new;
-			md->phys_addr = m_end + 1;
-			md->num_pages = (end - md->phys_addr + 1) >>
-				EFI_PAGE_SHIFT;
-		}
-
-		if ((start < m_start && m_start < end) && m_end < end) {
-			/* first part */
-			md->num_pages = (m_start - md->phys_addr) >>
-				EFI_PAGE_SHIFT;
-			/* middle part */
-			new += old_memmap->desc_size;
-			memcpy(new, old, old_memmap->desc_size);
-			md = new;
-			md->attribute |= m_attr;
-			md->phys_addr = m_start;
-			md->num_pages = (m_end - m_start + 1) >>
-				EFI_PAGE_SHIFT;
-			/* last part */
-			new += old_memmap->desc_size;
-			memcpy(new, old, old_memmap->desc_size);
-			md = new;
-			md->phys_addr = m_end + 1;
-			md->num_pages = (end - m_end) >>
-				EFI_PAGE_SHIFT;
-		}
-
-		if ((start < m_start && m_start < end) &&
-		    (end <= m_end)) {
-			/* first part */
-			md->num_pages = (m_start - md->phys_addr) >>
-				EFI_PAGE_SHIFT;
-			/* latter part */
-			new += old_memmap->desc_size;
-			memcpy(new, old, old_memmap->desc_size);
-			md = new;
-			md->phys_addr = m_start;
-			md->num_pages = (end - md->phys_addr + 1) >>
-				EFI_PAGE_SHIFT;
-			md->attribute |= m_attr;
-		}
-	}
-}
diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index 69f3d864f69d..206829165fc5 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -230,6 +230,11 @@ static int davinci_gpio_probe(struct platform_device *pdev)
 	else
 		nirq = DIV_ROUND_UP(ngpio, 16);
 
+	if (nirq > MAX_INT_PER_BANK) {
+		dev_err(dev, "Too many IRQs!\n");
+		return -EINVAL;
+	}
+
 	chips = devm_kzalloc(dev, sizeof(*chips), GFP_KERNEL);
 	if (!chips)
 		return -ENOMEM;
diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 97e8335716b0..be51bd00d2fd 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -132,6 +132,10 @@ struct linehandle_state {
 	GPIOHANDLE_REQUEST_OPEN_DRAIN | \
 	GPIOHANDLE_REQUEST_OPEN_SOURCE)
 
+#define GPIOHANDLE_REQUEST_DIRECTION_FLAGS \
+	(GPIOHANDLE_REQUEST_INPUT | \
+	 GPIOHANDLE_REQUEST_OUTPUT)
+
 static int linehandle_validate_flags(u32 flags)
 {
 	/* Return an error if an unknown flag is set */
@@ -212,21 +216,21 @@ static long linehandle_set_config(struct linehandle_state *lh,
 	if (ret)
 		return ret;
 
+	/* Lines must be reconfigured explicitly as input or output. */
+	if (!(lflags & GPIOHANDLE_REQUEST_DIRECTION_FLAGS))
+		return -EINVAL;
+
 	for (i = 0; i < lh->num_descs; i++) {
 		desc = lh->descs[i];
-		linehandle_flags_to_desc_flags(gcnf.flags, &desc->flags);
+		linehandle_flags_to_desc_flags(lflags, &desc->flags);
 
-		/*
-		 * Lines have to be requested explicitly for input
-		 * or output, else the line will be treated "as is".
-		 */
 		if (lflags & GPIOHANDLE_REQUEST_OUTPUT) {
 			int val = !!gcnf.default_values[i];
 
 			ret = gpiod_direction_output(desc, val);
 			if (ret)
 				return ret;
-		} else if (lflags & GPIOHANDLE_REQUEST_INPUT) {
+		} else {
 			ret = gpiod_direction_input(desc);
 			if (ret)
 				return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index 0d017dc94f01..1e64720a70a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -387,7 +387,7 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
 					mem_channel_number = vram_info->v30.channel_num;
 					mem_channel_width = vram_info->v30.channel_width;
 					if (vram_width)
-						*vram_width = mem_channel_number * (1 << mem_channel_width);
+						*vram_width = mem_channel_number * 16;
 					break;
 				default:
 					return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b11690a816e7..157441dd0704 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -980,7 +980,7 @@ void amdgpu_device_program_register_sequence(struct amdgpu_device *adev,
 	if (array_size % 3)
 		return;
 
-	for (i = 0; i < array_size; i +=3) {
+	for (i = 0; i < array_size; i += 3) {
 		reg = registers[i + 0];
 		and_mask = registers[i + 1];
 		or_mask = registers[i + 2];
@@ -1552,7 +1552,7 @@ static int amdgpu_device_check_arguments(struct amdgpu_device *adev)
 		dev_warn(adev->dev, "sched jobs (%d) must be at least 4\n",
 			 amdgpu_sched_jobs);
 		amdgpu_sched_jobs = 4;
-	} else if (!is_power_of_2(amdgpu_sched_jobs)){
+	} else if (!is_power_of_2(amdgpu_sched_jobs)) {
 		dev_warn(adev->dev, "sched jobs (%d) must be a power of 2\n",
 			 amdgpu_sched_jobs);
 		amdgpu_sched_jobs = roundup_pow_of_two(amdgpu_sched_jobs);
@@ -2747,8 +2747,9 @@ static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)
 		DRM_ERROR("enable mgpu fan boost failed (%d).\n", r);
 
 	/* For passthrough configuration on arcturus and aldebaran, enable special handling SBR */
-	if (amdgpu_passthrough(adev) && ((adev->asic_type == CHIP_ARCTURUS && adev->gmc.xgmi.num_physical_nodes > 1)||
-			       adev->asic_type == CHIP_ALDEBARAN ))
+	if (amdgpu_passthrough(adev) &&
+	    ((adev->asic_type == CHIP_ARCTURUS && adev->gmc.xgmi.num_physical_nodes > 1) ||
+	     adev->asic_type == CHIP_ALDEBARAN))
 		amdgpu_dpm_handle_passthrough_sbr(adev, true);
 
 	if (adev->gmc.xgmi.num_physical_nodes > 1) {
@@ -3077,7 +3078,7 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
 		}
 		adev->ip_blocks[i].status.hw = false;
 		/* handle putting the SMC in the appropriate state */
-		if(!amdgpu_sriov_vf(adev)){
+		if (!amdgpu_sriov_vf(adev)) {
 			if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC) {
 				r = amdgpu_dpm_set_mp1_state(adev, adev->mp1_state);
 				if (r) {
@@ -4048,7 +4049,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 
 	/* disable all interrupts */
 	amdgpu_irq_disable_all(adev);
-	if (adev->mode_info.mode_config_initialized){
+	if (adev->mode_info.mode_config_initialized) {
 		if (!drm_drv_uses_atomic_modeset(adev_to_drm(adev)))
 			drm_helper_force_disable_all(adev_to_drm(adev));
 		else
@@ -4755,42 +4756,45 @@ bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev)
 
 int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
 {
-        u32 i;
-        int ret = 0;
+	u32 i;
+	int ret = 0;
 
-        amdgpu_atombios_scratch_regs_engine_hung(adev, true);
+	amdgpu_atombios_scratch_regs_engine_hung(adev, true);
 
-        dev_info(adev->dev, "GPU mode1 reset\n");
+	dev_info(adev->dev, "GPU mode1 reset\n");
 
-        /* disable BM */
-        pci_clear_master(adev->pdev);
+	/* Cache the state before bus master disable. The saved config space
+	 * values are used in other cases like restore after mode-2 reset.
+	 */
+	amdgpu_device_cache_pci_state(adev->pdev);
 
-        amdgpu_device_cache_pci_state(adev->pdev);
+	/* disable BM */
+	pci_clear_master(adev->pdev);
 
-        if (amdgpu_dpm_is_mode1_reset_supported(adev)) {
-                dev_info(adev->dev, "GPU smu mode1 reset\n");
-                ret = amdgpu_dpm_mode1_reset(adev);
-        } else {
-                dev_info(adev->dev, "GPU psp mode1 reset\n");
-                ret = psp_gpu_reset(adev);
-        }
+	if (amdgpu_dpm_is_mode1_reset_supported(adev)) {
+		dev_info(adev->dev, "GPU smu mode1 reset\n");
+		ret = amdgpu_dpm_mode1_reset(adev);
+	} else {
+		dev_info(adev->dev, "GPU psp mode1 reset\n");
+		ret = psp_gpu_reset(adev);
+	}
 
-        if (ret)
-                dev_err(adev->dev, "GPU mode1 reset failed\n");
+	if (ret)
+		dev_err(adev->dev, "GPU mode1 reset failed\n");
 
-        amdgpu_device_load_pci_state(adev->pdev);
+	amdgpu_device_load_pci_state(adev->pdev);
 
-        /* wait for asic to come out of reset */
-        for (i = 0; i < adev->usec_timeout; i++) {
-                u32 memsize = adev->nbio.funcs->get_memsize(adev);
+	/* wait for asic to come out of reset */
+	for (i = 0; i < adev->usec_timeout; i++) {
+		u32 memsize = adev->nbio.funcs->get_memsize(adev);
 
-                if (memsize != 0xffffffff)
-                        break;
-                udelay(1);
-        }
+		if (memsize != 0xffffffff)
+			break;
+		udelay(1);
+	}
 
-        amdgpu_atombios_scratch_regs_engine_hung(adev, false);
-        return ret;
+	amdgpu_atombios_scratch_regs_engine_hung(adev, false);
+	return ret;
 }
 
 int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 9a5416331f02..238c15c0c7e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1662,7 +1662,7 @@ static const u16 amdgpu_unsupported_pciidlist[] = {
 };
 
 static const struct pci_device_id pciidlist[] = {
-#ifdef  CONFIG_DRM_AMDGPU_SI
+#ifdef CONFIG_DRM_AMDGPU_SI
 	{0x1002, 0x6780, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TAHITI},
 	{0x1002, 0x6784, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TAHITI},
 	{0x1002, 0x6788, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TAHITI},
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index 06980b8527ff..76f23652cc14 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -2,6 +2,7 @@
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_simple_kms_helper.h>
+#include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_vblank.h>
 
 #include "amdgpu.h"
@@ -313,7 +314,13 @@ static int amdgpu_vkms_prepare_fb(struct drm_plane *plane,
 		return 0;
 	}
 	afb = to_amdgpu_framebuffer(new_state->fb);
-	obj = new_state->fb->obj[0];
+
+	obj = drm_gem_fb_get_obj(new_state->fb, 0);
+	if (!obj) {
+		DRM_ERROR("Failed to get obj from framebuffer\n");
+		return -EINVAL;
+	}
+
 	rbo = gem_to_amdgpu_bo(obj);
 	adev = amdgpu_ttm_adev(rbo->tbo.bdev);
 
@@ -367,12 +374,19 @@ static void amdgpu_vkms_cleanup_fb(struct drm_plane *plane,
 				   struct drm_plane_state *old_state)
 {
 	struct amdgpu_bo *rbo;
+	struct drm_gem_object *obj;
 	int r;
 
 	if (!old_state->fb)
 		return;
 
-	rbo = gem_to_amdgpu_bo(old_state->fb->obj[0]);
+	obj = drm_gem_fb_get_obj(old_state->fb, 0);
+	if (!obj) {
+		DRM_ERROR("Failed to get obj from framebuffer\n");
+		return;
+	}
+
+	rbo = gem_to_amdgpu_bo(obj);
 	r = amdgpu_bo_reserve(rbo, false);
 	if (unlikely(r)) {
 		DRM_ERROR("failed to reserve rbo before unpin\n");
diff --git a/drivers/gpu/drm/i915/gt/intel_ggtt_fencing.c b/drivers/gpu/drm/i915/gt/intel_ggtt_fencing.c
index ea775e601686..a9dbca9d9c0c 100644
--- a/drivers/gpu/drm/i915/gt/intel_ggtt_fencing.c
+++ b/drivers/gpu/drm/i915/gt/intel_ggtt_fencing.c
@@ -296,6 +296,7 @@ void i915_vma_revoke_fence(struct i915_vma *vma)
 		return;
 
 	GEM_BUG_ON(fence->vma != vma);
+	i915_active_wait(&fence->active);
 	GEM_BUG_ON(!i915_active_is_idle(&fence->active));
 	GEM_BUG_ON(atomic_read(&fence->pin_count));
 
diff --git a/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c b/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
index be28e7bd7490..1da9d1e89f91 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
@@ -208,6 +208,8 @@ static int nv17_tv_get_ld_modes(struct drm_encoder *encoder,
 		struct drm_display_mode *mode;
 
 		mode = drm_mode_duplicate(encoder->dev, tv_mode);
+		if (!mode)
+			continue;
 
 		mode->clock = tv_norm->tv_enc_mode.vrefresh *
 			mode->htotal / 1000 *
@@ -257,6 +259,8 @@ static int nv17_tv_get_hd_modes(struct drm_encoder *encoder,
 		if (modes[i].hdisplay == output_mode->hdisplay &&
 		    modes[i].vdisplay == output_mode->vdisplay) {
 			mode = drm_mode_duplicate(encoder->dev, output_mode);
+			if (!mode)
+				continue;
 			mode->type |= DRM_MODE_TYPE_PREFERRED;
 
 		} else {
@@ -264,6 +268,8 @@ static int nv17_tv_get_hd_modes(struct drm_encoder *encoder,
 					    modes[i].vdisplay, 60, false,
 					    (output_mode->flags &
 					     DRM_MODE_FLAG_INTERLACE), false);
+			if (!mode)
+				continue;
 		}
 
 		/* CVT modes are sometimes unsuitable... */
diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
index cbb68caa36f2..4014c537e397 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
@@ -716,10 +716,10 @@ static int ili9881c_prepare(struct drm_panel *panel)
 	msleep(5);
 
 	/* And reset it */
-	gpiod_set_value(ctx->reset, 1);
+	gpiod_set_value_cansleep(ctx->reset, 1);
 	msleep(20);
 
-	gpiod_set_value(ctx->reset, 0);
+	gpiod_set_value_cansleep(ctx->reset, 0);
 	msleep(20);
 
 	for (i = 0; i < ctx->desc->init_length; i++) {
@@ -774,7 +774,7 @@ static int ili9881c_unprepare(struct drm_panel *panel)
 
 	mipi_dsi_dcs_enter_sleep_mode(ctx->dsi);
 	regulator_disable(ctx->power);
-	gpiod_set_value(ctx->reset, 1);
+	gpiod_set_value_cansleep(ctx->reset, 1);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index acb7f5c206d1..b560d62b6e21 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2371,6 +2371,7 @@ static const struct display_timing koe_tx26d202vm0bwa_timing = {
 	.vfront_porch = { 3, 5, 10 },
 	.vback_porch = { 2, 5, 10 },
 	.vsync_len = { 5, 5, 5 },
+	.flags = DISPLAY_FLAGS_DE_HIGH,
 };
 
 static const struct panel_desc koe_tx26d202vm0bwa = {
diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/radeon.h
index 166c18d62f6d..ec86c04a0d98 100644
--- a/drivers/gpu/drm/radeon/radeon.h
+++ b/drivers/gpu/drm/radeon/radeon.h
@@ -131,7 +131,6 @@ extern int radeon_cik_support;
 /* RADEON_IB_POOL_SIZE must be a power of 2 */
 #define RADEON_IB_POOL_SIZE			16
 #define RADEON_DEBUGFS_MAX_COMPONENTS		32
-#define RADEONFB_CONN_LIMIT			4
 #define RADEON_BIOS_NUM_SCRATCH			8
 
 /* internal ring indices */
diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index 1814bb8e14f1..dbee301b3b2e 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -683,7 +683,7 @@ static void radeon_crtc_init(struct drm_device *dev, int index)
 	struct radeon_device *rdev = dev->dev_private;
 	struct radeon_crtc *radeon_crtc;
 
-	radeon_crtc = kzalloc(sizeof(struct radeon_crtc) + (RADEONFB_CONN_LIMIT * sizeof(struct drm_connector *)), GFP_KERNEL);
+	radeon_crtc = kzalloc(sizeof(*radeon_crtc), GFP_KERNEL);
 	if (radeon_crtc == NULL)
 		return;
 
@@ -709,12 +709,6 @@ static void radeon_crtc_init(struct drm_device *dev, int index)
 	dev->mode_config.cursor_width = radeon_crtc->max_cursor_width;
 	dev->mode_config.cursor_height = radeon_crtc->max_cursor_height;
 
-#if 0
-	radeon_crtc->mode_set.crtc = &radeon_crtc->base;
-	radeon_crtc->mode_set.connectors = (struct drm_connector **)(radeon_crtc + 1);
-	radeon_crtc->mode_set.num_connectors = 0;
-#endif
-
 	if (rdev->is_atom_bios && (ASIC_IS_AVIVO(rdev) || radeon_r4xx_atom))
 		radeon_atombios_init_crtc(dev, radeon_crtc);
 	else
diff --git a/drivers/i2c/i2c-slave-testunit.c b/drivers/i2c/i2c-slave-testunit.c
index 75ee7ebdb614..54c08f48a8b8 100644
--- a/drivers/i2c/i2c-slave-testunit.c
+++ b/drivers/i2c/i2c-slave-testunit.c
@@ -118,9 +118,12 @@ static int i2c_slave_testunit_slave_cb(struct i2c_client *client,
 			queue_delayed_work(system_long_wq, &tu->worker,
 					   msecs_to_jiffies(10 * tu->regs[TU_REG_DELAY]));
 		}
-		fallthrough;
+		break;
 
 	case I2C_SLAVE_WRITE_REQUESTED:
+		if (test_bit(TU_FLAG_IN_PROCESS, &tu->flags))
+			return -EBUSY;
+
 		memset(tu->regs, 0, TU_NUM_REGS);
 		tu->reg_idx = 0;
 		break;
diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 1f34747a68bf..7b55a4481545 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -325,6 +325,8 @@ config DMARD10
 config FXLS8962AF
 	tristate
 	depends on I2C || !I2C # cannot be built-in for modular I2C
+	select IIO_BUFFER
+	select IIO_KFIFO_BUF
 
 config FXLS8962AF_I2C
 	tristate "NXP FXLS8962AF/FXLS8964AF Accelerometer I2C Driver"
diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index 468c2656d2be..98648c679a55 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -157,6 +157,8 @@ static int ad7266_read_raw(struct iio_dev *indio_dev,
 		ret = ad7266_read_single(st, val, chan->address);
 		iio_device_release_direct_mode(indio_dev);
 
+		if (ret < 0)
+			return ret;
 		*val = (*val >> 2) & 0xfff;
 		if (chan->scan_type.sign == 's')
 			*val = sign_extend32(*val,
diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
index a507d2e17079..3db021b96ae9 100644
--- a/drivers/iio/adc/xilinx-ams.c
+++ b/drivers/iio/adc/xilinx-ams.c
@@ -414,8 +414,12 @@ static void ams_enable_channel_sequence(struct iio_dev *indio_dev)
 
 	/* Run calibration of PS & PL as part of the sequence */
 	scan_mask = BIT(0) | BIT(AMS_PS_SEQ_MAX);
-	for (i = 0; i < indio_dev->num_channels; i++)
-		scan_mask |= BIT_ULL(indio_dev->channels[i].scan_index);
+	for (i = 0; i < indio_dev->num_channels; i++) {
+		const struct iio_chan_spec *chan = &indio_dev->channels[i];
+
+		if (chan->scan_index < AMS_CTRL_SEQ_BASE)
+			scan_mask |= BIT_ULL(chan->scan_index);
+	}
 
 	if (ams->ps_base) {
 		/* put sysmon in a soft reset to change the sequence */
diff --git a/drivers/iio/chemical/bme680.h b/drivers/iio/chemical/bme680.h
index 4edc5d21cb9f..f959252a4fe6 100644
--- a/drivers/iio/chemical/bme680.h
+++ b/drivers/iio/chemical/bme680.h
@@ -54,7 +54,9 @@
 #define   BME680_NB_CONV_MASK			GENMASK(3, 0)
 
 #define BME680_REG_MEAS_STAT_0			0x1D
+#define   BME680_NEW_DATA_BIT			BIT(7)
 #define   BME680_GAS_MEAS_BIT			BIT(6)
+#define   BME680_MEAS_BIT			BIT(5)
 
 /* Calibration Parameters */
 #define BME680_T2_LSB_REG	0x8A
diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index ef5e0e46fd34..500f56834b01 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -10,6 +10,7 @@
  */
 #include <linux/acpi.h>
 #include <linux/bitfield.h>
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/log2.h>
@@ -38,7 +39,7 @@ struct bme680_calib {
 	s8  par_h3;
 	s8  par_h4;
 	s8  par_h5;
-	s8  par_h6;
+	u8  par_h6;
 	s8  par_h7;
 	s8  par_gh1;
 	s16 par_gh2;
@@ -342,10 +343,10 @@ static s16 bme680_compensate_temp(struct bme680_data *data,
 	if (!calib->par_t2)
 		bme680_read_calib(data, calib);
 
-	var1 = (adc_temp >> 3) - (calib->par_t1 << 1);
+	var1 = (adc_temp >> 3) - ((s32)calib->par_t1 << 1);
 	var2 = (var1 * calib->par_t2) >> 11;
 	var3 = ((var1 >> 1) * (var1 >> 1)) >> 12;
-	var3 = (var3 * (calib->par_t3 << 4)) >> 14;
+	var3 = (var3 * ((s32)calib->par_t3 << 4)) >> 14;
 	data->t_fine = var2 + var3;
 	calc_temp = (data->t_fine * 5 + 128) >> 8;
 
@@ -368,9 +369,9 @@ static u32 bme680_compensate_press(struct bme680_data *data,
 	var1 = (data->t_fine >> 1) - 64000;
 	var2 = ((((var1 >> 2) * (var1 >> 2)) >> 11) * calib->par_p6) >> 2;
 	var2 = var2 + (var1 * calib->par_p5 << 1);
-	var2 = (var2 >> 2) + (calib->par_p4 << 16);
+	var2 = (var2 >> 2) + ((s32)calib->par_p4 << 16);
 	var1 = (((((var1 >> 2) * (var1 >> 2)) >> 13) *
-			(calib->par_p3 << 5)) >> 3) +
+			((s32)calib->par_p3 << 5)) >> 3) +
 			((calib->par_p2 * var1) >> 1);
 	var1 = var1 >> 18;
 	var1 = ((32768 + var1) * calib->par_p1) >> 15;
@@ -388,7 +389,7 @@ static u32 bme680_compensate_press(struct bme680_data *data,
 	var3 = ((press_comp >> 8) * (press_comp >> 8) *
 			(press_comp >> 8) * calib->par_p10) >> 17;
 
-	press_comp += (var1 + var2 + var3 + (calib->par_p7 << 7)) >> 4;
+	press_comp += (var1 + var2 + var3 + ((s32)calib->par_p7 << 7)) >> 4;
 
 	return press_comp;
 }
@@ -414,7 +415,7 @@ static u32 bme680_compensate_humid(struct bme680_data *data,
 		 (((temp_scaled * ((temp_scaled * calib->par_h5) / 100))
 		   >> 6) / 100) + (1 << 14))) >> 10;
 	var3 = var1 * var2;
-	var4 = calib->par_h6 << 7;
+	var4 = (s32)calib->par_h6 << 7;
 	var4 = (var4 + ((temp_scaled * calib->par_h7) / 100)) >> 4;
 	var5 = ((var3 >> 14) * (var3 >> 14)) >> 10;
 	var6 = (var4 * var5) >> 1;
@@ -532,6 +533,43 @@ static u8 bme680_oversampling_to_reg(u8 val)
 	return ilog2(val) + 1;
 }
 
+/*
+ * Taken from Bosch BME680 API:
+ * https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/bme68x.c#L490
+ */
+static int bme680_wait_for_eoc(struct bme680_data *data)
+{
+	struct device *dev = regmap_get_device(data->regmap);
+	unsigned int check;
+	int ret;
+	/*
+	 * (Sum of oversampling ratios * time per oversampling) +
+	 * TPH measurement + gas measurement + wait transition from forced mode
+	 * + heater duration
+	 */
+	int wait_eoc_us = ((data->oversampling_temp + data->oversampling_press +
+			   data->oversampling_humid) * 1936) + (477 * 4) +
+			   (477 * 5) + 1000 + (data->heater_dur * 1000);
+
+	usleep_range(wait_eoc_us, wait_eoc_us + 100);
+
+	ret = regmap_read(data->regmap, BME680_REG_MEAS_STAT_0, &check);
+	if (ret) {
+		dev_err(dev, "failed to read measurement status register.\n");
+		return ret;
+	}
+	if (check & BME680_MEAS_BIT) {
+		dev_err(dev, "Device measurement cycle incomplete.\n");
+		return -EBUSY;
+	}
+	if (!(check & BME680_NEW_DATA_BIT)) {
+		dev_err(dev, "No new data available from the device.\n");
+		return -ENODATA;
+	}
+
+	return 0;
+}
+
 static int bme680_chip_config(struct bme680_data *data)
 {
 	struct device *dev = regmap_get_device(data->regmap);
@@ -622,6 +660,10 @@ static int bme680_read_temp(struct bme680_data *data, int *val)
 	if (ret < 0)
 		return ret;
 
+	ret = bme680_wait_for_eoc(data);
+	if (ret)
+		return ret;
+
 	ret = regmap_bulk_read(data->regmap, BME680_REG_TEMP_MSB,
 			       &tmp, 3);
 	if (ret < 0) {
@@ -678,7 +720,7 @@ static int bme680_read_press(struct bme680_data *data,
 	}
 
 	*val = bme680_compensate_press(data, adc_press);
-	*val2 = 100;
+	*val2 = 1000;
 	return IIO_VAL_FRACTIONAL;
 }
 
@@ -738,6 +780,10 @@ static int bme680_read_gas(struct bme680_data *data,
 	if (ret < 0)
 		return ret;
 
+	ret = bme680_wait_for_eoc(data);
+	if (ret)
+		return ret;
+
 	ret = regmap_read(data->regmap, BME680_REG_MEAS_STAT_0, &check);
 	if (check & BME680_GAS_MEAS_BIT) {
 		dev_err(dev, "gas measurement incomplete\n");
diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
index 01a499a8b88d..438ed3588175 100644
--- a/drivers/infiniband/core/restrack.c
+++ b/drivers/infiniband/core/restrack.c
@@ -37,22 +37,6 @@ int rdma_restrack_init(struct ib_device *dev)
 	return 0;
 }
 
-static const char *type2str(enum rdma_restrack_type type)
-{
-	static const char * const names[RDMA_RESTRACK_MAX] = {
-		[RDMA_RESTRACK_PD] = "PD",
-		[RDMA_RESTRACK_CQ] = "CQ",
-		[RDMA_RESTRACK_QP] = "QP",
-		[RDMA_RESTRACK_CM_ID] = "CM_ID",
-		[RDMA_RESTRACK_MR] = "MR",
-		[RDMA_RESTRACK_CTX] = "CTX",
-		[RDMA_RESTRACK_COUNTER] = "COUNTER",
-		[RDMA_RESTRACK_SRQ] = "SRQ",
-	};
-
-	return names[type];
-};
-
 /**
  * rdma_restrack_clean() - clean resource tracking
  * @dev:  IB device
@@ -60,47 +44,14 @@ static const char *type2str(enum rdma_restrack_type type)
 void rdma_restrack_clean(struct ib_device *dev)
 {
 	struct rdma_restrack_root *rt = dev->res;
-	struct rdma_restrack_entry *e;
-	char buf[TASK_COMM_LEN];
-	bool found = false;
-	const char *owner;
 	int i;
 
 	for (i = 0 ; i < RDMA_RESTRACK_MAX; i++) {
 		struct xarray *xa = &dev->res[i].xa;
 
-		if (!xa_empty(xa)) {
-			unsigned long index;
-
-			if (!found) {
-				pr_err("restrack: %s", CUT_HERE);
-				dev_err(&dev->dev, "BUG: RESTRACK detected leak of resources\n");
-			}
-			xa_for_each(xa, index, e) {
-				if (rdma_is_kernel_res(e)) {
-					owner = e->kern_name;
-				} else {
-					/*
-					 * There is no need to call get_task_struct here,
-					 * because we can be here only if there are more
-					 * get_task_struct() call than put_task_struct().
-					 */
-					get_task_comm(buf, e->task);
-					owner = buf;
-				}
-
-				pr_err("restrack: %s %s object allocated by %s is not freed\n",
-				       rdma_is_kernel_res(e) ? "Kernel" :
-							       "User",
-				       type2str(e->type), owner);
-			}
-			found = true;
-		}
+		WARN_ON(!xa_empty(xa));
 		xa_destroy(xa);
 	}
-	if (found)
-		pr_err("restrack: %s", CUT_HERE);
-
 	kfree(rt);
 }
 
diff --git a/drivers/input/touchscreen/ili210x.c b/drivers/input/touchscreen/ili210x.c
index e9bd36adbe47..e3a36cd3656c 100644
--- a/drivers/input/touchscreen/ili210x.c
+++ b/drivers/input/touchscreen/ili210x.c
@@ -261,8 +261,8 @@ static int ili251x_read_touch_data(struct i2c_client *client, u8 *data)
 	if (!error && data[0] == 2) {
 		error = i2c_master_recv(client, data + ILI251X_DATA_SIZE1,
 					ILI251X_DATA_SIZE2);
-		if (error >= 0 && error != ILI251X_DATA_SIZE2)
-			error = -EIO;
+		if (error >= 0)
+			error = error == ILI251X_DATA_SIZE2 ? 0 : -EIO;
 	}
 
 	return error;
diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
index c4584e2f0ad3..37b05567fb0e 100644
--- a/drivers/irqchip/irq-loongson-liointc.c
+++ b/drivers/irqchip/irq-loongson-liointc.c
@@ -28,7 +28,7 @@
 
 #define LIOINTC_INTC_CHIP_START	0x20
 
-#define LIOINTC_REG_INTC_STATUS	(LIOINTC_INTC_CHIP_START + 0x20)
+#define LIOINTC_REG_INTC_STATUS(core)	(LIOINTC_INTC_CHIP_START + 0x20 + (core) * 8)
 #define LIOINTC_REG_INTC_EN_STATUS	(LIOINTC_INTC_CHIP_START + 0x04)
 #define LIOINTC_REG_INTC_ENABLE	(LIOINTC_INTC_CHIP_START + 0x08)
 #define LIOINTC_REG_INTC_DISABLE	(LIOINTC_INTC_CHIP_START + 0x0c)
@@ -196,7 +196,7 @@ static int liointc_init(phys_addr_t addr, unsigned long size, int revision,
 		goto out_free_priv;
 
 	for (i = 0; i < LIOINTC_NUM_CORES; i++)
-		priv->core_isr[i] = base + LIOINTC_REG_INTC_STATUS;
+		priv->core_isr[i] = base + LIOINTC_REG_INTC_STATUS(i);
 
 	for (i = 0; i < LIOINTC_NUM_PARENT; i++)
 		priv->handler[i].parent_int_map = parent_int_map[i];
diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
index aefee2277254..04b7ce479fc3 100644
--- a/drivers/media/dvb-core/dvbdev.c
+++ b/drivers/media/dvb-core/dvbdev.c
@@ -964,7 +964,7 @@ int dvb_usercopy(struct file *file,
 		     int (*func)(struct file *file,
 		     unsigned int cmd, void *arg))
 {
-	char    sbuf[128];
+	char    sbuf[128] = {};
 	void    *mbuf = NULL;
 	void    *parg = NULL;
 	int     err  = -EINVAL;
diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index 55d8bd232695..5b650d5dd0ae 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -23,6 +23,7 @@
 #define BRCMSTB_MATCH_FLAGS_NO_64BIT		BIT(0)
 #define BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT	BIT(1)
 #define BRCMSTB_MATCH_FLAGS_HAS_CLOCK_GATE	BIT(2)
+#define BRCMSTB_MATCH_FLAGS_USE_CARD_BUSY	BIT(4)
 
 #define BRCMSTB_PRIV_FLAGS_HAS_CQE		BIT(0)
 #define BRCMSTB_PRIV_FLAGS_GATE_CLOCK		BIT(1)
@@ -335,6 +336,9 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 	if (match_priv->flags & BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT)
 		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
+	if (!(match_priv->flags & BRCMSTB_MATCH_FLAGS_USE_CARD_BUSY))
+		host->mmc_host_ops.card_busy = NULL;
+
 	/* Change the base clock frequency if the DT property exists */
 	if (device_property_read_u32(&pdev->dev, "clock-frequency",
 				     &priv->base_freq_hz) != 0)
diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 28dc65023fa9..bda9e10df250 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -1330,7 +1330,7 @@ static int jmicron_pmos(struct sdhci_pci_chip *chip, int on)
 
 	ret = pci_read_config_byte(chip->pdev, 0xAE, &scratch);
 	if (ret)
-		return ret;
+		goto fail;
 
 	/*
 	 * Turn PMOS on [bit 0], set over current detection to 2.4 V
@@ -1341,7 +1341,10 @@ static int jmicron_pmos(struct sdhci_pci_chip *chip, int on)
 	else
 		scratch &= ~0x47;
 
-	return pci_write_config_byte(chip->pdev, 0xAE, scratch);
+	ret = pci_write_config_byte(chip->pdev, 0xAE, scratch);
+
+fail:
+	return pcibios_err_to_errno(ret);
 }
 
 static int jmicron_probe(struct sdhci_pci_chip *chip)
@@ -2201,7 +2204,7 @@ static int sdhci_pci_probe(struct pci_dev *pdev,
 
 	ret = pci_read_config_byte(pdev, PCI_SLOT_INFO, &slots);
 	if (ret)
-		return ret;
+		return pcibios_err_to_errno(ret);
 
 	slots = PCI_SLOT_INFO_SLOTS(slots) + 1;
 	dev_dbg(&pdev->dev, "found %d slot(s)\n", slots);
@@ -2210,7 +2213,7 @@ static int sdhci_pci_probe(struct pci_dev *pdev,
 
 	ret = pci_read_config_byte(pdev, PCI_SLOT_INFO, &first_bar);
 	if (ret)
-		return ret;
+		return pcibios_err_to_errno(ret);
 
 	first_bar &= PCI_SLOT_INFO_FIRST_BAR_MASK;
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 111f7c677060..4237d8ae878c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2539,26 +2539,29 @@ EXPORT_SYMBOL_GPL(sdhci_get_cd_nogpio);
 
 static int sdhci_check_ro(struct sdhci_host *host)
 {
-	unsigned long flags;
+	bool allow_invert = false;
 	int is_readonly;
 
-	spin_lock_irqsave(&host->lock, flags);
-
-	if (host->flags & SDHCI_DEVICE_DEAD)
+	if (host->flags & SDHCI_DEVICE_DEAD) {
 		is_readonly = 0;
-	else if (host->ops->get_ro)
+	} else if (host->ops->get_ro) {
 		is_readonly = host->ops->get_ro(host);
-	else if (mmc_can_gpio_ro(host->mmc))
+	} else if (mmc_can_gpio_ro(host->mmc)) {
 		is_readonly = mmc_gpio_get_ro(host->mmc);
-	else
+		/* Do not invert twice */
+		allow_invert = !(host->mmc->caps2 & MMC_CAP2_RO_ACTIVE_HIGH);
+	} else {
 		is_readonly = !(sdhci_readl(host, SDHCI_PRESENT_STATE)
 				& SDHCI_WRITE_PROTECT);
+		allow_invert = true;
+	}
 
-	spin_unlock_irqrestore(&host->lock, flags);
+	if (is_readonly >= 0 &&
+	    allow_invert &&
+	    (host->quirks & SDHCI_QUIRK_INVERTED_WRITE_PROTECT))
+		is_readonly = !is_readonly;
 
-	/* This quirk needs to be replaced by a callback-function later */
-	return host->quirks & SDHCI_QUIRK_INVERTED_WRITE_PROTECT ?
-		!is_readonly : is_readonly;
+	return is_readonly;
 }
 
 #define SAMPLE_COUNT	5
diff --git a/drivers/mtd/parsers/redboot.c b/drivers/mtd/parsers/redboot.c
index a16b42a88581..3b55b676ca6b 100644
--- a/drivers/mtd/parsers/redboot.c
+++ b/drivers/mtd/parsers/redboot.c
@@ -102,7 +102,7 @@ static int parse_redboot_partitions(struct mtd_info *master,
 			offset -= master->erasesize;
 		}
 	} else {
-		offset = directory * master->erasesize;
+		offset = (unsigned long) directory * master->erasesize;
 		while (mtd_block_isbad(master, offset)) {
 			offset += master->erasesize;
 			if (offset == master->size)
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index eebf967f4711..1665f78abb5c 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -1618,11 +1618,20 @@ static int mcp251xfd_open(struct net_device *ndev)
 	clear_bit(MCP251XFD_FLAGS_DOWN, priv->flags);
 	can_rx_offload_enable(&priv->offload);
 
+	priv->wq = alloc_ordered_workqueue("%s-mcp251xfd_wq",
+					   WQ_FREEZABLE | WQ_MEM_RECLAIM,
+					   dev_name(&spi->dev));
+	if (!priv->wq) {
+		err = -ENOMEM;
+		goto out_can_rx_offload_disable;
+	}
+	INIT_WORK(&priv->tx_work, mcp251xfd_tx_obj_write_sync);
+
 	err = request_threaded_irq(spi->irq, NULL, mcp251xfd_irq,
 				   IRQF_SHARED | IRQF_ONESHOT,
 				   dev_name(&spi->dev), priv);
 	if (err)
-		goto out_can_rx_offload_disable;
+		goto out_destroy_workqueue;
 
 	err = mcp251xfd_chip_interrupts_enable(priv);
 	if (err)
@@ -1634,6 +1643,8 @@ static int mcp251xfd_open(struct net_device *ndev)
 
  out_free_irq:
 	free_irq(spi->irq, priv);
+ out_destroy_workqueue:
+	destroy_workqueue(priv->wq);
  out_can_rx_offload_disable:
 	can_rx_offload_disable(&priv->offload);
 	set_bit(MCP251XFD_FLAGS_DOWN, priv->flags);
@@ -1661,6 +1672,7 @@ static int mcp251xfd_stop(struct net_device *ndev)
 	hrtimer_cancel(&priv->tx_irq_timer);
 	mcp251xfd_chip_interrupts_disable(priv);
 	free_irq(ndev->irq, priv);
+	destroy_workqueue(priv->wq);
 	can_rx_offload_disable(&priv->offload);
 	mcp251xfd_timestamp_stop(priv);
 	mcp251xfd_chip_stop(priv, CAN_STATE_STOPPED);
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
index 160528d3cc26..b1de8052a45c 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
@@ -131,6 +131,39 @@ mcp251xfd_tx_obj_from_skb(const struct mcp251xfd_priv *priv,
 	tx_obj->xfer[0].len = len;
 }
 
+static void mcp251xfd_tx_failure_drop(const struct mcp251xfd_priv *priv,
+				      struct mcp251xfd_tx_ring *tx_ring,
+				      int err)
+{
+	struct net_device *ndev = priv->ndev;
+	struct net_device_stats *stats = &ndev->stats;
+	unsigned int frame_len = 0;
+	u8 tx_head;
+
+	tx_ring->head--;
+	stats->tx_dropped++;
+	tx_head = mcp251xfd_get_tx_head(tx_ring);
+	can_free_echo_skb(ndev, tx_head, &frame_len);
+	netdev_completed_queue(ndev, 1, frame_len);
+	netif_wake_queue(ndev);
+
+	if (net_ratelimit())
+		netdev_err(priv->ndev, "ERROR in %s: %d\n", __func__, err);
+}
+
+void mcp251xfd_tx_obj_write_sync(struct work_struct *work)
+{
+	struct mcp251xfd_priv *priv = container_of(work, struct mcp251xfd_priv,
+						   tx_work);
+	struct mcp251xfd_tx_obj *tx_obj = priv->tx_work_obj;
+	struct mcp251xfd_tx_ring *tx_ring = priv->tx;
+	int err;
+
+	err = spi_sync(priv->spi, &tx_obj->msg);
+	if (err)
+		mcp251xfd_tx_failure_drop(priv, tx_ring, err);
+}
+
 static int mcp251xfd_tx_obj_write(const struct mcp251xfd_priv *priv,
 				  struct mcp251xfd_tx_obj *tx_obj)
 {
@@ -162,6 +195,11 @@ static bool mcp251xfd_tx_busy(const struct mcp251xfd_priv *priv,
 	return false;
 }
 
+static bool mcp251xfd_work_busy(struct work_struct *work)
+{
+	return work_busy(work);
+}
+
 netdev_tx_t mcp251xfd_start_xmit(struct sk_buff *skb,
 				 struct net_device *ndev)
 {
@@ -175,7 +213,8 @@ netdev_tx_t mcp251xfd_start_xmit(struct sk_buff *skb,
 	if (can_dev_dropped_skb(ndev, skb))
 		return NETDEV_TX_OK;
 
-	if (mcp251xfd_tx_busy(priv, tx_ring))
+	if (mcp251xfd_tx_busy(priv, tx_ring) ||
+	    mcp251xfd_work_busy(&priv->tx_work))
 		return NETDEV_TX_BUSY;
 
 	tx_obj = mcp251xfd_get_tx_obj_next(tx_ring);
@@ -193,13 +232,13 @@ netdev_tx_t mcp251xfd_start_xmit(struct sk_buff *skb,
 		netdev_sent_queue(priv->ndev, frame_len);
 
 	err = mcp251xfd_tx_obj_write(priv, tx_obj);
-	if (err)
-		goto out_err;
-
-	return NETDEV_TX_OK;
-
- out_err:
-	netdev_err(priv->ndev, "ERROR in %s: %d\n", __func__, err);
+	if (err == -EBUSY) {
+		netif_stop_queue(ndev);
+		priv->tx_work_obj = tx_obj;
+		queue_work(priv->wq, &priv->tx_work);
+	} else if (err) {
+		mcp251xfd_tx_failure_drop(priv, tx_ring, err);
+	}
 
 	return NETDEV_TX_OK;
 }
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index ba0fd2b95a52..b98ded7098a5 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -628,6 +628,10 @@ struct mcp251xfd_priv {
 	struct mcp251xfd_rx_ring *rx[MCP251XFD_FIFO_RX_NUM];
 	struct mcp251xfd_tx_ring tx[MCP251XFD_FIFO_TX_NUM];
 
+	struct workqueue_struct *wq;
+	struct work_struct tx_work;
+	struct mcp251xfd_tx_obj *tx_work_obj;
+
 	DECLARE_BITMAP(flags, __MCP251XFD_FLAGS_SIZE__);
 
 	u8 rx_ring_num;
@@ -934,6 +938,7 @@ void mcp251xfd_skb_set_timestamp(const struct mcp251xfd_priv *priv,
 void mcp251xfd_timestamp_init(struct mcp251xfd_priv *priv);
 void mcp251xfd_timestamp_stop(struct mcp251xfd_priv *priv);
 
+void mcp251xfd_tx_obj_write_sync(struct work_struct *work);
 netdev_tx_t mcp251xfd_start_xmit(struct sk_buff *skb,
 				 struct net_device *ndev);
 
diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index a73697147053..e9fa92a83322 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -183,10 +183,8 @@ int ksz9477_reset_switch(struct ksz_device *dev)
 			   SPI_AUTO_EDGE_DETECTION, 0);
 
 	/* default configuration */
-	ksz_read8(dev, REG_SW_LUE_CTRL_1, &data8);
-	data8 = SW_AGING_ENABLE | SW_LINK_AUTO_AGING |
-	      SW_SRC_ADDR_FILTER | SW_FLUSH_STP_TABLE | SW_FLUSH_MSTP_TABLE;
-	ksz_write8(dev, REG_SW_LUE_CTRL_1, data8);
+	ksz_write8(dev, REG_SW_LUE_CTRL_1,
+		   SW_AGING_ENABLE | SW_LINK_AUTO_AGING | SW_SRC_ADDR_FILTER);
 
 	/* disable interrupts */
 	ksz_write32(dev, REG_SW_INT_MASK__4, SWITCH_INT_MASK);
@@ -1152,6 +1150,10 @@ int ksz9477_setup(struct dsa_switch *ds)
 	/* Enable REG_SW_MTU__2 reg by setting SW_JUMBO_PACKET */
 	ksz_cfg(dev, REG_SW_MAC_CTRL_1, SW_JUMBO_PACKET, true);
 
+	/* Use collision based back pressure mode. */
+	ksz_cfg(dev, REG_SW_MAC_CTRL_1, SW_BACK_PRESSURE,
+		SW_BACK_PRESSURE_COLLISION);
+
 	/* Now we can configure default MTU value */
 	ret = regmap_update_bits(dev->regmap[1], REG_SW_MTU__2, REG_SW_MTU_MASK,
 				 VLAN_ETH_FRAME_LEN + ETH_FCS_LEN);
diff --git a/drivers/net/dsa/microchip/ksz9477_reg.h b/drivers/net/dsa/microchip/ksz9477_reg.h
index 53c68d286dd3..04086e9ab0a0 100644
--- a/drivers/net/dsa/microchip/ksz9477_reg.h
+++ b/drivers/net/dsa/microchip/ksz9477_reg.h
@@ -267,6 +267,7 @@
 #define REG_SW_MAC_CTRL_1		0x0331
 
 #define SW_BACK_PRESSURE		BIT(5)
+#define SW_BACK_PRESSURE_COLLISION	0
 #define FAIR_FLOW_CTRL			BIT(4)
 #define NO_EXC_COLLISION_DROP		BIT(3)
 #define SW_JUMBO_PACKET			BIT(2)
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index f9f43897f86c..9dbe188f09c3 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -1790,7 +1790,7 @@ static void ksz_irq_bus_sync_unlock(struct irq_data *d)
 	struct ksz_device *dev = kirq->dev;
 	int ret;
 
-	ret = ksz_write32(dev, kirq->reg_mask, kirq->masked);
+	ret = ksz_write8(dev, kirq->reg_mask, kirq->masked);
 	if (ret)
 		dev_err(dev->dev, "failed to change IRQ mask\n");
 
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index de62eee58a00..bbbe7c5b5d35 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -2754,11 +2754,14 @@ static int dpaa2_eth_xdp_xmit(struct net_device *net_dev, int n,
 static int update_xps(struct dpaa2_eth_priv *priv)
 {
 	struct net_device *net_dev = priv->net_dev;
-	struct cpumask xps_mask;
-	struct dpaa2_eth_fq *fq;
 	int i, num_queues, netdev_queues;
+	struct dpaa2_eth_fq *fq;
+	cpumask_var_t xps_mask;
 	int err = 0;
 
+	if (!alloc_cpumask_var(&xps_mask, GFP_KERNEL))
+		return -ENOMEM;
+
 	num_queues = dpaa2_eth_queue_count(priv);
 	netdev_queues = (net_dev->num_tc ? : 1) * num_queues;
 
@@ -2768,16 +2771,17 @@ static int update_xps(struct dpaa2_eth_priv *priv)
 	for (i = 0; i < netdev_queues; i++) {
 		fq = &priv->fq[i % num_queues];
 
-		cpumask_clear(&xps_mask);
-		cpumask_set_cpu(fq->target_cpu, &xps_mask);
+		cpumask_clear(xps_mask);
+		cpumask_set_cpu(fq->target_cpu, xps_mask);
 
-		err = netif_set_xps_queue(net_dev, &xps_mask, i);
+		err = netif_set_xps_queue(net_dev, xps_mask, i);
 		if (err) {
 			netdev_warn_once(net_dev, "Error setting XPS queue\n");
 			break;
 		}
 	}
 
+	free_cpumask_var(xps_mask);
 	return err;
 }
 
diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 157be4e9be4b..8f377d0a80fe 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -3859,6 +3859,12 @@ static void release_sub_crqs(struct ibmvnic_adapter *adapter, bool do_h_free)
 		adapter->num_active_tx_scrqs = 0;
 	}
 
+	/* Clean any remaining outstanding SKBs
+	 * we freed the irq so we won't be hearing
+	 * from them
+	 */
+	clean_tx_pools(adapter);
+
 	if (adapter->rx_scrq) {
 		for (i = 0; i < adapter->num_active_rx_scrqs; i++) {
 			if (!adapter->rx_scrq[i])
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_buffers.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_buffers.c
index c9f1c79f3f9d..ba090262e27e 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_buffers.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_buffers.c
@@ -1607,8 +1607,8 @@ static void mlxsw_sp_sb_sr_occ_query_cb(struct mlxsw_core *mlxsw_core,
 int mlxsw_sp_sb_occ_snapshot(struct mlxsw_core *mlxsw_core,
 			     unsigned int sb_index)
 {
+	u16 local_port, local_port_1, first_local_port, last_local_port;
 	struct mlxsw_sp *mlxsw_sp = mlxsw_core_driver_priv(mlxsw_core);
-	u16 local_port, local_port_1, last_local_port;
 	struct mlxsw_sp_sb_sr_occ_query_cb_ctx cb_ctx;
 	u8 masked_count, current_page = 0;
 	unsigned long cb_priv = 0;
@@ -1628,6 +1628,7 @@ int mlxsw_sp_sb_occ_snapshot(struct mlxsw_core *mlxsw_core,
 	masked_count = 0;
 	mlxsw_reg_sbsr_pack(sbsr_pl, false);
 	mlxsw_reg_sbsr_port_page_set(sbsr_pl, current_page);
+	first_local_port = current_page * MLXSW_REG_SBSR_NUM_PORTS_IN_PAGE;
 	last_local_port = current_page * MLXSW_REG_SBSR_NUM_PORTS_IN_PAGE +
 			  MLXSW_REG_SBSR_NUM_PORTS_IN_PAGE - 1;
 
@@ -1645,9 +1646,12 @@ int mlxsw_sp_sb_occ_snapshot(struct mlxsw_core *mlxsw_core,
 		if (local_port != MLXSW_PORT_CPU_PORT) {
 			/* Ingress quotas are not supported for the CPU port */
 			mlxsw_reg_sbsr_ingress_port_mask_set(sbsr_pl,
-							     local_port, 1);
+							     local_port - first_local_port,
+							     1);
 		}
-		mlxsw_reg_sbsr_egress_port_mask_set(sbsr_pl, local_port, 1);
+		mlxsw_reg_sbsr_egress_port_mask_set(sbsr_pl,
+						    local_port - first_local_port,
+						    1);
 		for (i = 0; i < mlxsw_sp->sb_vals->pool_count; i++) {
 			err = mlxsw_sp_sb_pm_occ_query(mlxsw_sp, local_port, i,
 						       &bulk_list);
@@ -1684,7 +1688,7 @@ int mlxsw_sp_sb_occ_max_clear(struct mlxsw_core *mlxsw_core,
 			      unsigned int sb_index)
 {
 	struct mlxsw_sp *mlxsw_sp = mlxsw_core_driver_priv(mlxsw_core);
-	u16 local_port, last_local_port;
+	u16 local_port, first_local_port, last_local_port;
 	LIST_HEAD(bulk_list);
 	unsigned int masked_count;
 	u8 current_page = 0;
@@ -1702,6 +1706,7 @@ int mlxsw_sp_sb_occ_max_clear(struct mlxsw_core *mlxsw_core,
 	masked_count = 0;
 	mlxsw_reg_sbsr_pack(sbsr_pl, true);
 	mlxsw_reg_sbsr_port_page_set(sbsr_pl, current_page);
+	first_local_port = current_page * MLXSW_REG_SBSR_NUM_PORTS_IN_PAGE;
 	last_local_port = current_page * MLXSW_REG_SBSR_NUM_PORTS_IN_PAGE +
 			  MLXSW_REG_SBSR_NUM_PORTS_IN_PAGE - 1;
 
@@ -1719,9 +1724,12 @@ int mlxsw_sp_sb_occ_max_clear(struct mlxsw_core *mlxsw_core,
 		if (local_port != MLXSW_PORT_CPU_PORT) {
 			/* Ingress quotas are not supported for the CPU port */
 			mlxsw_reg_sbsr_ingress_port_mask_set(sbsr_pl,
-							     local_port, 1);
+							     local_port - first_local_port,
+							     1);
 		}
-		mlxsw_reg_sbsr_egress_port_mask_set(sbsr_pl, local_port, 1);
+		mlxsw_reg_sbsr_egress_port_mask_set(sbsr_pl,
+						    local_port - first_local_port,
+						    1);
 		for (i = 0; i < mlxsw_sp->sb_vals->pool_count; i++) {
 			err = mlxsw_sp_sb_pm_occ_clear(mlxsw_sp, local_port, i,
 						       &bulk_list);
diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 98c6d0caf8fa..90f3953cf906 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -3405,6 +3405,7 @@ static struct mdio_device_id __maybe_unused micrel_tbl[] = {
 	{ PHY_ID_KSZ8081, MICREL_PHY_ID_MASK },
 	{ PHY_ID_KSZ8873MLL, MICREL_PHY_ID_MASK },
 	{ PHY_ID_KSZ886X, MICREL_PHY_ID_MASK },
+	{ PHY_ID_KSZ9477, MICREL_PHY_ID_MASK },
 	{ PHY_ID_LAN8814, MICREL_PHY_ID_MASK },
 	{ PHY_ID_LAN8804, MICREL_PHY_ID_MASK },
 	{ }
diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 53f6efc22f5c..73de34179f35 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -326,7 +326,8 @@ static void ax88179_status(struct usbnet *dev, struct urb *urb)
 
 	if (netif_carrier_ok(dev->net) != link) {
 		usbnet_link_change(dev, link, 1);
-		netdev_info(dev->net, "ax88179 - Link status is: %d\n", link);
+		if (!link)
+			netdev_info(dev->net, "ax88179 - Link status is: 0\n");
 	}
 }
 
@@ -1540,6 +1541,7 @@ static int ax88179_link_reset(struct usbnet *dev)
 			 GMII_PHY_PHYSR, 2, &tmp16);
 
 	if (!(tmp16 & GMII_PHY_PHYSR_LINK)) {
+		netdev_info(dev->net, "ax88179 - Link status is: 0\n");
 		return 0;
 	} else if (GMII_PHY_PHYSR_GIGA == (tmp16 & GMII_PHY_PHYSR_SMASK)) {
 		mode |= AX_MEDIUM_GIGAMODE | AX_MEDIUM_EN_125MHZ;
@@ -1577,6 +1579,8 @@ static int ax88179_link_reset(struct usbnet *dev)
 
 	netif_carrier_on(dev->net);
 
+	netdev_info(dev->net, "ax88179 - Link status is: 1\n");
+
 	return 0;
 }
 
diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 223482584f54..db5fc55a5c96 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -1092,8 +1092,8 @@ static struct pinctrl *create_pinctrl(struct device *dev,
 		 * an -EPROBE_DEFER later, as that is the worst case.
 		 */
 		if (ret == -EPROBE_DEFER) {
-			pinctrl_free(p, false);
 			mutex_unlock(&pinctrl_maps_mutex);
+			pinctrl_free(p, false);
 			return ERR_PTR(ret);
 		}
 	}
diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 0276b52f3716..d26682f21ad1 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -635,23 +635,68 @@ static struct rockchip_mux_recalced_data rk3308_mux_recalced_data[] = {
 
 static struct rockchip_mux_recalced_data rk3328_mux_recalced_data[] = {
 	{
-		.num = 2,
-		.pin = 12,
-		.reg = 0x24,
-		.bit = 8,
-		.mask = 0x3
-	}, {
+		/* gpio2_b7_sel */
 		.num = 2,
 		.pin = 15,
 		.reg = 0x28,
 		.bit = 0,
 		.mask = 0x7
 	}, {
+		/* gpio2_c7_sel */
 		.num = 2,
 		.pin = 23,
 		.reg = 0x30,
 		.bit = 14,
 		.mask = 0x3
+	}, {
+		/* gpio3_b1_sel */
+		.num = 3,
+		.pin = 9,
+		.reg = 0x44,
+		.bit = 2,
+		.mask = 0x3
+	}, {
+		/* gpio3_b2_sel */
+		.num = 3,
+		.pin = 10,
+		.reg = 0x44,
+		.bit = 4,
+		.mask = 0x3
+	}, {
+		/* gpio3_b3_sel */
+		.num = 3,
+		.pin = 11,
+		.reg = 0x44,
+		.bit = 6,
+		.mask = 0x3
+	}, {
+		/* gpio3_b4_sel */
+		.num = 3,
+		.pin = 12,
+		.reg = 0x44,
+		.bit = 8,
+		.mask = 0x3
+	}, {
+		/* gpio3_b5_sel */
+		.num = 3,
+		.pin = 13,
+		.reg = 0x44,
+		.bit = 10,
+		.mask = 0x3
+	}, {
+		/* gpio3_b6_sel */
+		.num = 3,
+		.pin = 14,
+		.reg = 0x44,
+		.bit = 12,
+		.mask = 0x3
+	}, {
+		/* gpio3_b7_sel */
+		.num = 3,
+		.pin = 15,
+		.reg = 0x44,
+		.bit = 14,
+		.mask = 0x3
 	},
 };
 
@@ -2434,6 +2479,7 @@ static int rockchip_get_pull(struct rockchip_pin_bank *bank, int pin_num)
 	case RK3188:
 	case RK3288:
 	case RK3308:
+	case RK3328:
 	case RK3368:
 	case RK3399:
 	case RK3568:
@@ -2492,6 +2538,7 @@ static int rockchip_set_pull(struct rockchip_pin_bank *bank,
 	case RK3188:
 	case RK3288:
 	case RK3308:
+	case RK3328:
 	case RK3368:
 	case RK3399:
 	case RK3568:
@@ -2705,8 +2752,10 @@ static int rockchip_pmx_set(struct pinctrl_dev *pctldev, unsigned selector,
 
 	if (ret) {
 		/* revert the already done pin settings */
-		for (cnt--; cnt >= 0; cnt--)
+		for (cnt--; cnt >= 0; cnt--) {
+			bank = pin_to_bank(info, pins[cnt]);
 			rockchip_set_mux(bank, pins[cnt] - bank->pin_base, 0);
+		}
 
 		return ret;
 	}
@@ -2754,6 +2803,7 @@ static bool rockchip_pinconf_pull_valid(struct rockchip_pin_ctrl *ctrl,
 	case RK3188:
 	case RK3288:
 	case RK3308:
+	case RK3328:
 	case RK3368:
 	case RK3399:
 	case RK3568:
@@ -3766,7 +3816,7 @@ static struct rockchip_pin_bank rk3328_pin_banks[] = {
 	PIN_BANK_IOMUX_FLAGS(0, 32, "gpio0", 0, 0, 0, 0),
 	PIN_BANK_IOMUX_FLAGS(1, 32, "gpio1", 0, 0, 0, 0),
 	PIN_BANK_IOMUX_FLAGS(2, 32, "gpio2", 0,
-			     IOMUX_WIDTH_3BIT,
+			     0,
 			     IOMUX_WIDTH_3BIT,
 			     0),
 	PIN_BANK_IOMUX_FLAGS(3, 32, "gpio3",
@@ -3780,7 +3830,7 @@ static struct rockchip_pin_ctrl rk3328_pin_ctrl = {
 		.pin_banks		= rk3328_pin_banks,
 		.nr_banks		= ARRAY_SIZE(rk3328_pin_banks),
 		.label			= "RK3328-GPIO",
-		.type			= RK3288,
+		.type			= RK3328,
 		.grf_mux_offset		= 0x0,
 		.iomux_recalced		= rk3328_mux_recalced_data,
 		.niomux_recalced	= ARRAY_SIZE(rk3328_mux_recalced_data),
diff --git a/drivers/pinctrl/pinctrl-rockchip.h b/drivers/pinctrl/pinctrl-rockchip.h
index 4759f336941e..849266f8b191 100644
--- a/drivers/pinctrl/pinctrl-rockchip.h
+++ b/drivers/pinctrl/pinctrl-rockchip.h
@@ -193,6 +193,7 @@ enum rockchip_pinctrl_type {
 	RK3188,
 	RK3288,
 	RK3308,
+	RK3328,
 	RK3368,
 	RK3399,
 	RK3568,
diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
index 8c31a8f6b7e4..6d43c2123e69 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -1204,7 +1204,6 @@ static const struct of_device_id pmic_gpio_of_match[] = {
 	{ .compatible = "qcom,pm7250b-gpio", .data = (void *) 12 },
 	{ .compatible = "qcom,pm7325-gpio", .data = (void *) 10 },
 	{ .compatible = "qcom,pm8005-gpio", .data = (void *) 4 },
-	{ .compatible = "qcom,pm8008-gpio", .data = (void *) 2 },
 	{ .compatible = "qcom,pm8019-gpio", .data = (void *) 6 },
 	/* pm8150 has 10 GPIOs with holes on 2, 5, 7 and 8 */
 	{ .compatible = "qcom,pm8150-gpio", .data = (void *) 10 },
diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index bdcdb7f38312..c40a6548ce7d 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -340,6 +340,9 @@ static int stm32_pwm_config(struct stm32_pwm *priv, int ch,
 
 	prd = div;
 
+	if (!prd)
+		return -EINVAL;
+
 	if (prescaler > MAX_TIM_PSC)
 		return -EINVAL;
 
diff --git a/drivers/soc/ti/wkup_m3_ipc.c b/drivers/soc/ti/wkup_m3_ipc.c
index 343c58ed5896..103d793bae74 100644
--- a/drivers/soc/ti/wkup_m3_ipc.c
+++ b/drivers/soc/ti/wkup_m3_ipc.c
@@ -16,7 +16,6 @@
 #include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/omap-mailbox.h>
 #include <linux/platform_device.h>
 #include <linux/remoteproc.h>
 #include <linux/suspend.h>
@@ -314,7 +313,6 @@ static irqreturn_t wkup_m3_txev_handler(int irq, void *ipc_data)
 static int wkup_m3_ping(struct wkup_m3_ipc *m3_ipc)
 {
 	struct device *dev = m3_ipc->dev;
-	mbox_msg_t dummy_msg = 0;
 	int ret;
 
 	if (!m3_ipc->mbox) {
@@ -330,7 +328,7 @@ static int wkup_m3_ping(struct wkup_m3_ipc *m3_ipc)
 	 * the RX callback to avoid multiple interrupts being received
 	 * by the CM3.
 	 */
-	ret = mbox_send_message(m3_ipc->mbox, &dummy_msg);
+	ret = mbox_send_message(m3_ipc->mbox, NULL);
 	if (ret < 0) {
 		dev_err(dev, "%s: mbox_send_message() failed: %d\n",
 			__func__, ret);
@@ -352,7 +350,6 @@ static int wkup_m3_ping(struct wkup_m3_ipc *m3_ipc)
 static int wkup_m3_ping_noirq(struct wkup_m3_ipc *m3_ipc)
 {
 	struct device *dev = m3_ipc->dev;
-	mbox_msg_t dummy_msg = 0;
 	int ret;
 
 	if (!m3_ipc->mbox) {
@@ -361,7 +358,7 @@ static int wkup_m3_ping_noirq(struct wkup_m3_ipc *m3_ipc)
 		return -EIO;
 	}
 
-	ret = mbox_send_message(m3_ipc->mbox, &dummy_msg);
+	ret = mbox_send_message(m3_ipc->mbox, NULL);
 	if (ret < 0) {
 		dev_err(dev, "%s: mbox_send_message() failed: %d\n",
 			__func__, ret);
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 037d613006f5..a3eaf293f204 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -159,6 +159,10 @@ static u32 uart_read(struct omap8250_priv *priv, u32 reg)
 	return readl(priv->membase + (reg << OMAP_UART_REGSHIFT));
 }
 
+/* Timeout low and High */
+#define UART_OMAP_TO_L                 0x26
+#define UART_OMAP_TO_H                 0x27
+
 /*
  * Called on runtime PM resume path from omap8250_restore_regs(), and
  * omap8250_set_mctrl().
@@ -628,13 +632,25 @@ static irqreturn_t omap8250_irq(int irq, void *dev_id)
 
 	/*
 	 * On K3 SoCs, it is observed that RX TIMEOUT is signalled after
-	 * FIFO has been drained, in which case a dummy read of RX FIFO
-	 * is required to clear RX TIMEOUT condition.
+	 * FIFO has been drained or erroneously.
+	 * So apply solution of Errata i2310 as mentioned in
+	 * https://www.ti.com/lit/pdf/sprz536
 	 */
 	if (priv->habit & UART_RX_TIMEOUT_QUIRK &&
 	    (iir & UART_IIR_RX_TIMEOUT) == UART_IIR_RX_TIMEOUT &&
 	    serial_port_in(port, UART_OMAP_RX_LVL) == 0) {
-		serial_port_in(port, UART_RX);
+		unsigned char efr2, timeout_h, timeout_l;
+
+		efr2 = serial_in(up, UART_OMAP_EFR2);
+		timeout_h = serial_in(up, UART_OMAP_TO_H);
+		timeout_l = serial_in(up, UART_OMAP_TO_L);
+		serial_out(up, UART_OMAP_TO_H, 0xFF);
+		serial_out(up, UART_OMAP_TO_L, 0xFF);
+		serial_out(up, UART_OMAP_EFR2, UART_OMAP_EFR2_TIMEOUT_BEHAVE);
+		serial_in(up, UART_IIR);
+		serial_out(up, UART_OMAP_EFR2, efr2);
+		serial_out(up, UART_OMAP_TO_H, timeout_h);
+		serial_out(up, UART_OMAP_TO_L, timeout_l);
 	}
 
 	/* Stop processing interrupts on input overrun */
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index b20abaa9ef15..40e59e72d5e9 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -120,6 +120,7 @@
 #define UCR4_OREN	(1<<1)	/* Receiver overrun interrupt enable */
 #define UCR4_DREN	(1<<0)	/* Recv data ready interrupt enable */
 #define UFCR_RXTL_SHF	0	/* Receiver trigger level shift */
+#define UFCR_RXTL_MASK	0x3F	/* Receiver trigger 6 bits wide */
 #define UFCR_DCEDTE	(1<<6)	/* DCE/DTE mode select */
 #define UFCR_RFDIV	(7<<7)	/* Reference freq divider mask */
 #define UFCR_RFDIV_REG(x)	(((x) < 7 ? 6 - (x) : 6) << 7)
@@ -1959,7 +1960,7 @@ static int imx_uart_rs485_config(struct uart_port *port, struct ktermios *termio
 				 struct serial_rs485 *rs485conf)
 {
 	struct imx_port *sport = (struct imx_port *)port;
-	u32 ucr2;
+	u32 ucr2, ufcr;
 
 	if (rs485conf->flags & SER_RS485_ENABLED) {
 		/* Enable receiver if low-active RTS signal is requested */
@@ -1978,8 +1979,13 @@ static int imx_uart_rs485_config(struct uart_port *port, struct ktermios *termio
 
 	/* Make sure Rx is enabled in case Tx is active with Rx disabled */
 	if (!(rs485conf->flags & SER_RS485_ENABLED) ||
-	    rs485conf->flags & SER_RS485_RX_DURING_TX)
+	    rs485conf->flags & SER_RS485_RX_DURING_TX) {
+		/* If the receiver trigger is 0, set it to a default value */
+		ufcr = imx_uart_readl(sport, UFCR);
+		if ((ufcr & UFCR_RXTL_MASK) == 0)
+			imx_uart_setup_ufcr(sport, TXTL_DEFAULT, RXTL_DEFAULT);
 		imx_uart_start_rx(port);
+	}
 
 	return 0;
 }
diff --git a/drivers/tty/serial/mcf.c b/drivers/tty/serial/mcf.c
index b1cd9a76dd93..1374b4e82d75 100644
--- a/drivers/tty/serial/mcf.c
+++ b/drivers/tty/serial/mcf.c
@@ -480,7 +480,7 @@ static const struct uart_ops mcf_uart_ops = {
 	.verify_port	= mcf_verify_port,
 };
 
-static struct mcf_uart mcf_ports[4];
+static struct mcf_uart mcf_ports[10];
 
 #define	MCF_MAXPORTS	ARRAY_SIZE(mcf_ports)
 
diff --git a/drivers/usb/atm/cxacru.c b/drivers/usb/atm/cxacru.c
index 4ce7cba2b48a..8f3b9a0a38e1 100644
--- a/drivers/usb/atm/cxacru.c
+++ b/drivers/usb/atm/cxacru.c
@@ -1131,6 +1131,7 @@ static int cxacru_bind(struct usbatm_data *usbatm_instance,
 	struct cxacru_data *instance;
 	struct usb_device *usb_dev = interface_to_usbdev(intf);
 	struct usb_host_endpoint *cmd_ep = usb_dev->ep_in[CXACRU_EP_CMD];
+	struct usb_endpoint_descriptor *in, *out;
 	int ret;
 
 	/* instance init */
@@ -1177,6 +1178,19 @@ static int cxacru_bind(struct usbatm_data *usbatm_instance,
 		goto fail;
 	}
 
+	if (usb_endpoint_xfer_int(&cmd_ep->desc))
+		ret = usb_find_common_endpoints(intf->cur_altsetting,
+						NULL, NULL, &in, &out);
+	else
+		ret = usb_find_common_endpoints(intf->cur_altsetting,
+						&in, &out, NULL, NULL);
+
+	if (ret) {
+		usb_err(usbatm_instance, "cxacru_bind: interface has incorrect endpoints\n");
+		ret = -ENODEV;
+		goto fail;
+	}
+
 	if ((cmd_ep->desc.bmAttributes & USB_ENDPOINT_XFERTYPE_MASK)
 			== USB_ENDPOINT_XFER_INT) {
 		usb_fill_int_urb(instance->rcv_urb,
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 3b5482621e5e..94bc7786a3c4 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -2087,7 +2087,6 @@ static int dwc3_core_init_for_resume(struct dwc3 *dwc)
 
 static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 {
-	unsigned long	flags;
 	u32 reg;
 
 	switch (dwc->current_dr_role) {
@@ -2125,9 +2124,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 			break;
 
 		if (dwc->current_otg_role == DWC3_OTG_ROLE_DEVICE) {
-			spin_lock_irqsave(&dwc->lock, flags);
 			dwc3_gadget_suspend(dwc);
-			spin_unlock_irqrestore(&dwc->lock, flags);
 			synchronize_irq(dwc->irq_gadget);
 		}
 
@@ -2144,7 +2141,6 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 
 static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 {
-	unsigned long	flags;
 	int		ret;
 	u32		reg;
 
@@ -2193,9 +2189,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 		if (dwc->current_otg_role == DWC3_OTG_ROLE_HOST) {
 			dwc3_otg_host_init(dwc);
 		} else if (dwc->current_otg_role == DWC3_OTG_ROLE_DEVICE) {
-			spin_lock_irqsave(&dwc->lock, flags);
 			dwc3_gadget_resume(dwc);
-			spin_unlock_irqrestore(&dwc->lock, flags);
 		}
 
 		break;
diff --git a/drivers/usb/gadget/function/f_printer.c b/drivers/usb/gadget/function/f_printer.c
index 8545656419c7..65378266fd84 100644
--- a/drivers/usb/gadget/function/f_printer.c
+++ b/drivers/usb/gadget/function/f_printer.c
@@ -210,6 +210,7 @@ static inline struct usb_endpoint_descriptor *ep_desc(struct usb_gadget *gadget,
 					struct usb_endpoint_descriptor *ss)
 {
 	switch (gadget->speed) {
+	case USB_SPEED_SUPER_PLUS:
 	case USB_SPEED_SUPER:
 		return ss;
 	case USB_SPEED_HIGH:
@@ -447,11 +448,8 @@ printer_read(struct file *fd, char __user *buf, size_t len, loff_t *ptr)
 	mutex_lock(&dev->lock_printer_io);
 	spin_lock_irqsave(&dev->lock, flags);
 
-	if (dev->interface < 0) {
-		spin_unlock_irqrestore(&dev->lock, flags);
-		mutex_unlock(&dev->lock_printer_io);
-		return -ENODEV;
-	}
+	if (dev->interface < 0)
+		goto out_disabled;
 
 	/* We will use this flag later to check if a printer reset happened
 	 * after we turn interrupts back on.
@@ -459,6 +457,9 @@ printer_read(struct file *fd, char __user *buf, size_t len, loff_t *ptr)
 	dev->reset_printer = 0;
 
 	setup_rx_reqs(dev);
+	/* this dropped the lock - need to retest */
+	if (dev->interface < 0)
+		goto out_disabled;
 
 	bytes_copied = 0;
 	current_rx_req = dev->current_rx_req;
@@ -492,6 +493,8 @@ printer_read(struct file *fd, char __user *buf, size_t len, loff_t *ptr)
 		wait_event_interruptible(dev->rx_wait,
 				(likely(!list_empty(&dev->rx_buffers))));
 		spin_lock_irqsave(&dev->lock, flags);
+		if (dev->interface < 0)
+			goto out_disabled;
 	}
 
 	/* We have data to return then copy it to the caller's buffer.*/
@@ -535,6 +538,9 @@ printer_read(struct file *fd, char __user *buf, size_t len, loff_t *ptr)
 			return -EAGAIN;
 		}
 
+		if (dev->interface < 0)
+			goto out_disabled;
+
 		/* If we not returning all the data left in this RX request
 		 * buffer then adjust the amount of data left in the buffer.
 		 * Othewise if we are done with this RX request buffer then
@@ -564,6 +570,11 @@ printer_read(struct file *fd, char __user *buf, size_t len, loff_t *ptr)
 		return bytes_copied;
 	else
 		return -EAGAIN;
+
+out_disabled:
+	spin_unlock_irqrestore(&dev->lock, flags);
+	mutex_unlock(&dev->lock_printer_io);
+	return -ENODEV;
 }
 
 static ssize_t
@@ -584,11 +595,8 @@ printer_write(struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
 	mutex_lock(&dev->lock_printer_io);
 	spin_lock_irqsave(&dev->lock, flags);
 
-	if (dev->interface < 0) {
-		spin_unlock_irqrestore(&dev->lock, flags);
-		mutex_unlock(&dev->lock_printer_io);
-		return -ENODEV;
-	}
+	if (dev->interface < 0)
+		goto out_disabled;
 
 	/* Check if a printer reset happens while we have interrupts on */
 	dev->reset_printer = 0;
@@ -611,6 +619,8 @@ printer_write(struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
 		wait_event_interruptible(dev->tx_wait,
 				(likely(!list_empty(&dev->tx_reqs))));
 		spin_lock_irqsave(&dev->lock, flags);
+		if (dev->interface < 0)
+			goto out_disabled;
 	}
 
 	while (likely(!list_empty(&dev->tx_reqs)) && len) {
@@ -660,6 +670,9 @@ printer_write(struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
 			return -EAGAIN;
 		}
 
+		if (dev->interface < 0)
+			goto out_disabled;
+
 		list_add(&req->list, &dev->tx_reqs_active);
 
 		/* here, we unlock, and only unlock, to avoid deadlock. */
@@ -672,6 +685,8 @@ printer_write(struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
 			mutex_unlock(&dev->lock_printer_io);
 			return -EAGAIN;
 		}
+		if (dev->interface < 0)
+			goto out_disabled;
 	}
 
 	spin_unlock_irqrestore(&dev->lock, flags);
@@ -683,6 +698,11 @@ printer_write(struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
 		return bytes_copied;
 	else
 		return -EAGAIN;
+
+out_disabled:
+	spin_unlock_irqrestore(&dev->lock, flags);
+	mutex_unlock(&dev->lock_printer_io);
+	return -ENODEV;
 }
 
 static int
diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
index 01968e2167f9..cedf17e38245 100644
--- a/drivers/usb/gadget/udc/aspeed_udc.c
+++ b/drivers/usb/gadget/udc/aspeed_udc.c
@@ -66,8 +66,8 @@
 #define USB_UPSTREAM_EN			BIT(0)
 
 /* Main config reg */
-#define UDC_CFG_SET_ADDR(x)		((x) & 0x3f)
-#define UDC_CFG_ADDR_MASK		(0x3f)
+#define UDC_CFG_SET_ADDR(x)		((x) & UDC_CFG_ADDR_MASK)
+#define UDC_CFG_ADDR_MASK		GENMASK(6, 0)
 
 /* Interrupt ctrl & status reg */
 #define UDC_IRQ_EP_POOL_NAK		BIT(17)
diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
index a4e55b0c52cf..1aae58143464 100644
--- a/drivers/usb/musb/da8xx.c
+++ b/drivers/usb/musb/da8xx.c
@@ -553,7 +553,7 @@ static int da8xx_probe(struct platform_device *pdev)
 	ret = of_platform_populate(pdev->dev.of_node, NULL,
 				   da8xx_auxdata_lookup, &pdev->dev);
 	if (ret)
-		return ret;
+		goto err_unregister_phy;
 
 	pinfo = da8xx_dev_info;
 	pinfo.parent = &pdev->dev;
@@ -568,9 +568,13 @@ static int da8xx_probe(struct platform_device *pdev)
 	ret = PTR_ERR_OR_ZERO(glue->musb);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register musb device: %d\n", ret);
-		usb_phy_generic_unregister(glue->usb_phy);
+		goto err_unregister_phy;
 	}
 
+	return 0;
+
+err_unregister_phy:
+	usb_phy_generic_unregister(glue->usb_phy);
 	return ret;
 }
 
diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index a163218fdc74..1e4059521eb0 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -36,22 +36,16 @@
  */
 #define UCSI_SWAP_TIMEOUT_MS	5000
 
-static int ucsi_acknowledge_command(struct ucsi *ucsi)
+static int ucsi_acknowledge(struct ucsi *ucsi, bool conn_ack)
 {
 	u64 ctrl;
 
 	ctrl = UCSI_ACK_CC_CI;
 	ctrl |= UCSI_ACK_COMMAND_COMPLETE;
-
-	return ucsi->ops->sync_write(ucsi, UCSI_CONTROL, &ctrl, sizeof(ctrl));
-}
-
-static int ucsi_acknowledge_connector_change(struct ucsi *ucsi)
-{
-	u64 ctrl;
-
-	ctrl = UCSI_ACK_CC_CI;
-	ctrl |= UCSI_ACK_CONNECTOR_CHANGE;
+	if (conn_ack) {
+		clear_bit(EVENT_PENDING, &ucsi->flags);
+		ctrl |= UCSI_ACK_CONNECTOR_CHANGE;
+	}
 
 	return ucsi->ops->sync_write(ucsi, UCSI_CONTROL, &ctrl, sizeof(ctrl));
 }
@@ -64,7 +58,7 @@ static int ucsi_read_error(struct ucsi *ucsi)
 	int ret;
 
 	/* Acknowledge the command that failed */
-	ret = ucsi_acknowledge_command(ucsi);
+	ret = ucsi_acknowledge(ucsi, false);
 	if (ret)
 		return ret;
 
@@ -76,7 +70,7 @@ static int ucsi_read_error(struct ucsi *ucsi)
 	if (ret)
 		return ret;
 
-	ret = ucsi_acknowledge_command(ucsi);
+	ret = ucsi_acknowledge(ucsi, false);
 	if (ret)
 		return ret;
 
@@ -139,28 +133,33 @@ static int ucsi_exec_command(struct ucsi *ucsi, u64 cmd)
 		return -EIO;
 
 	if (cci & UCSI_CCI_NOT_SUPPORTED) {
-		if (ucsi_acknowledge_command(ucsi) < 0)
+		if (ucsi_acknowledge(ucsi, false) < 0)
 			dev_err(ucsi->dev,
 				"ACK of unsupported command failed\n");
 		return -EOPNOTSUPP;
 	}
 
 	if (cci & UCSI_CCI_ERROR) {
-		if (cmd == UCSI_GET_ERROR_STATUS)
+		if (cmd == UCSI_GET_ERROR_STATUS) {
+			ret = ucsi_acknowledge(ucsi, false);
+			if (ret)
+				return ret;
+
 			return -EIO;
+		}
 		return ucsi_read_error(ucsi);
 	}
 
 	if (cmd == UCSI_CANCEL && cci & UCSI_CCI_CANCEL_COMPLETE) {
-		ret = ucsi_acknowledge_command(ucsi);
+		ret = ucsi_acknowledge(ucsi, false);
 		return ret ? ret : -EBUSY;
 	}
 
 	return UCSI_CCI_LENGTH(cci);
 }
 
-int ucsi_send_command(struct ucsi *ucsi, u64 command,
-		      void *data, size_t size)
+static int ucsi_send_command_common(struct ucsi *ucsi, u64 command,
+				    void *data, size_t size, bool conn_ack)
 {
 	u8 length;
 	int ret;
@@ -179,7 +178,7 @@ int ucsi_send_command(struct ucsi *ucsi, u64 command,
 			goto out;
 	}
 
-	ret = ucsi_acknowledge_command(ucsi);
+	ret = ucsi_acknowledge(ucsi, conn_ack);
 	if (ret)
 		goto out;
 
@@ -188,6 +187,12 @@ int ucsi_send_command(struct ucsi *ucsi, u64 command,
 	mutex_unlock(&ucsi->ppm_lock);
 	return ret;
 }
+
+int ucsi_send_command(struct ucsi *ucsi, u64 command,
+		      void *data, size_t size)
+{
+	return ucsi_send_command_common(ucsi, command, data, size, false);
+}
 EXPORT_SYMBOL_GPL(ucsi_send_command);
 
 /* -------------------------------------------------------------------------- */
@@ -785,7 +790,9 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 	mutex_lock(&con->lock);
 
 	command = UCSI_GET_CONNECTOR_STATUS | UCSI_CONNECTOR_NUMBER(con->num);
-	ret = ucsi_send_command(ucsi, command, &con->status, sizeof(con->status));
+
+	ret = ucsi_send_command_common(ucsi, command, &con->status,
+				       sizeof(con->status), true);
 	if (ret < 0) {
 		dev_err(ucsi->dev, "%s: GET_CONNECTOR_STATUS failed (%d)\n",
 			__func__, ret);
@@ -833,14 +840,6 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 	if (con->status.change & UCSI_CONSTAT_CAM_CHANGE)
 		ucsi_partner_task(con, ucsi_check_altmodes, 1, 0);
 
-	mutex_lock(&ucsi->ppm_lock);
-	clear_bit(EVENT_PENDING, &con->ucsi->flags);
-	ret = ucsi_acknowledge_connector_change(ucsi);
-	mutex_unlock(&ucsi->ppm_lock);
-
-	if (ret)
-		dev_err(ucsi->dev, "%s: ACK failed (%d)", __func__, ret);
-
 out_unlock:
 	mutex_unlock(&con->lock);
 }
diff --git a/drivers/usb/typec/ucsi/ucsi_stm32g0.c b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
index 7b92f0c8de70..8c3b052f6208 100644
--- a/drivers/usb/typec/ucsi/ucsi_stm32g0.c
+++ b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
@@ -64,6 +64,7 @@ struct ucsi_stm32g0 {
 	struct completion complete;
 	struct device *dev;
 	unsigned long flags;
+#define ACK_PENDING	2
 	const char *fw_name;
 	struct ucsi *ucsi;
 	bool suspended;
@@ -395,9 +396,13 @@ static int ucsi_stm32g0_sync_write(struct ucsi *ucsi, unsigned int offset, const
 				   size_t len)
 {
 	struct ucsi_stm32g0 *g0 = ucsi_get_drvdata(ucsi);
+	bool ack = UCSI_COMMAND(*(u64 *)val) == UCSI_ACK_CC_CI;
 	int ret;
 
-	set_bit(COMMAND_PENDING, &g0->flags);
+	if (ack)
+		set_bit(ACK_PENDING, &g0->flags);
+	else
+		set_bit(COMMAND_PENDING, &g0->flags);
 
 	ret = ucsi_stm32g0_async_write(ucsi, offset, val, len);
 	if (ret)
@@ -405,9 +410,14 @@ static int ucsi_stm32g0_sync_write(struct ucsi *ucsi, unsigned int offset, const
 
 	if (!wait_for_completion_timeout(&g0->complete, msecs_to_jiffies(5000)))
 		ret = -ETIMEDOUT;
+	else
+		return 0;
 
 out_clear_bit:
-	clear_bit(COMMAND_PENDING, &g0->flags);
+	if (ack)
+		clear_bit(ACK_PENDING, &g0->flags);
+	else
+		clear_bit(COMMAND_PENDING, &g0->flags);
 
 	return ret;
 }
@@ -428,8 +438,9 @@ static irqreturn_t ucsi_stm32g0_irq_handler(int irq, void *data)
 	if (UCSI_CCI_CONNECTOR(cci))
 		ucsi_connector_change(g0->ucsi, UCSI_CCI_CONNECTOR(cci));
 
-	if (test_bit(COMMAND_PENDING, &g0->flags) &&
-	    cci & (UCSI_CCI_ACK_COMPLETE | UCSI_CCI_COMMAND_COMPLETE))
+	if (cci & UCSI_CCI_ACK_COMPLETE && test_and_clear_bit(ACK_PENDING, &g0->flags))
+		complete(&g0->complete);
+	if (cci & UCSI_CCI_COMMAND_COMPLETE && test_and_clear_bit(COMMAND_PENDING, &g0->flags))
 		complete(&g0->complete);
 
 	return IRQ_HANDLED;
diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index edcd74cc4c0f..0ccece3f4f7d 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -8,6 +8,7 @@
  *
  */
 
+#include "linux/virtio_net.h"
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/cdev.h>
@@ -28,6 +29,7 @@
 #include <uapi/linux/virtio_config.h>
 #include <uapi/linux/virtio_ids.h>
 #include <uapi/linux/virtio_blk.h>
+#include <uapi/linux/virtio_ring.h>
 #include <linux/mod_devicetable.h>
 
 #include "iova_domain.h"
@@ -1416,13 +1418,17 @@ static bool device_is_allowed(u32 device_id)
 	return false;
 }
 
-static bool features_is_valid(u64 features)
+static bool features_is_valid(struct vduse_dev_config *config)
 {
-	if (!(features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)))
+	if (!(config->features & BIT_ULL(VIRTIO_F_ACCESS_PLATFORM)))
 		return false;
 
 	/* Now we only support read-only configuration space */
-	if (features & (1ULL << VIRTIO_BLK_F_CONFIG_WCE))
+	if ((config->device_id == VIRTIO_ID_BLOCK) &&
+			(config->features & BIT_ULL(VIRTIO_BLK_F_CONFIG_WCE)))
+		return false;
+	else if ((config->device_id == VIRTIO_ID_NET) &&
+			(config->features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)))
 		return false;
 
 	return true;
@@ -1449,7 +1455,7 @@ static bool vduse_validate_config(struct vduse_dev_config *config)
 	if (!device_is_allowed(config->device_id))
 		return false;
 
-	if (!features_is_valid(config->features))
+	if (!features_is_valid(config))
 		return false;
 
 	return true;
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index b27795e13ff3..862a222caab3 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2676,7 +2676,7 @@ static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
 	u64 offset = bytenr - block_group->start;
 	u64 to_free, to_unusable;
 	int bg_reclaim_threshold = 0;
-	bool initial = (size == block_group->length);
+	bool initial = ((size == block_group->length) && (block_group->alloc_offset == 0));
 	u64 reclaimable_unusable;
 
 	WARN_ON(!initial && offset + size > block_group->zone_capacity);
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 302d1e43d701..6107cd680176 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -591,6 +591,8 @@ static void gfs2_put_super(struct super_block *sb)
 
 	if (!sb_rdonly(sb)) {
 		gfs2_make_fs_ro(sdp);
+	} else {
+		gfs2_quota_cleanup(sdp);
 	}
 	WARN_ON(gfs2_withdrawing(sdp));
 
diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index b555efca01d2..f16b13ba4204 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -131,8 +131,6 @@ int nfs_swap_rw(struct kiocb *iocb, struct iov_iter *iter)
 {
 	ssize_t ret;
 
-	VM_BUG_ON(iov_iter_count(iter) != PAGE_SIZE);
-
 	if (iov_iter_rw(iter) == READ)
 		ret = nfs_file_direct_read(iocb, iter, true);
 	else
diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index 0394505fdce3..e94a5a9fec01 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -2370,6 +2370,11 @@ static int ocfs2_dio_end_io_write(struct inode *inode,
 	}
 
 	list_for_each_entry(ue, &dwc->dw_zero_list, ue_node) {
+		ret = ocfs2_assure_trans_credits(handle, credits);
+		if (ret < 0) {
+			mlog_errno(ret);
+			break;
+		}
 		ret = ocfs2_mark_extent_written(inode, &et, handle,
 						ue->ue_cpos, 1,
 						ue->ue_phys,
diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index 3fb98b4569a2..7d6843d78c84 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -447,6 +447,23 @@ int ocfs2_extend_trans(handle_t *handle, int nblocks)
 	return status;
 }
 
+/*
+ * Make sure handle has at least 'nblocks' credits available. If it does not
+ * have that many credits available, we will try to extend the handle to have
+ * enough credits. If that fails, we will restart transaction to have enough
+ * credits. Similar notes regarding data consistency and locking implications
+ * as for ocfs2_extend_trans() apply here.
+ */
+int ocfs2_assure_trans_credits(handle_t *handle, int nblocks)
+{
+	int old_nblks = jbd2_handle_buffer_credits(handle);
+
+	trace_ocfs2_assure_trans_credits(old_nblks);
+	if (old_nblks >= nblocks)
+		return 0;
+	return ocfs2_extend_trans(handle, nblocks - old_nblks);
+}
+
 /*
  * If we have fewer than thresh credits, extend by OCFS2_MAX_TRANS_DATA.
  * If that fails, restart the transaction & regain write access for the
diff --git a/fs/ocfs2/journal.h b/fs/ocfs2/journal.h
index 41c382f68529..689c340c6363 100644
--- a/fs/ocfs2/journal.h
+++ b/fs/ocfs2/journal.h
@@ -243,6 +243,8 @@ handle_t		    *ocfs2_start_trans(struct ocfs2_super *osb,
 int			     ocfs2_commit_trans(struct ocfs2_super *osb,
 						handle_t *handle);
 int			     ocfs2_extend_trans(handle_t *handle, int nblocks);
+int			     ocfs2_assure_trans_credits(handle_t *handle,
+						int nblocks);
 int			     ocfs2_allocate_extend_trans(handle_t *handle,
 						int thresh);
 
diff --git a/fs/ocfs2/ocfs2_trace.h b/fs/ocfs2/ocfs2_trace.h
index dc4bce1649c1..7a9cfd61145a 100644
--- a/fs/ocfs2/ocfs2_trace.h
+++ b/fs/ocfs2/ocfs2_trace.h
@@ -2578,6 +2578,8 @@ DEFINE_OCFS2_ULL_UINT_EVENT(ocfs2_commit_cache_end);
 
 DEFINE_OCFS2_INT_INT_EVENT(ocfs2_extend_trans);
 
+DEFINE_OCFS2_INT_EVENT(ocfs2_assure_trans_credits);
+
 DEFINE_OCFS2_INT_EVENT(ocfs2_extend_trans_restart);
 
 DEFINE_OCFS2_INT_INT_EVENT(ocfs2_allocate_extend_trans);
diff --git a/fs/open.c b/fs/open.c
index 51dc46620d03..0d63c94e1c5e 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -199,13 +199,13 @@ long do_sys_ftruncate(unsigned int fd, loff_t length, int small)
 	return error;
 }
 
-SYSCALL_DEFINE2(ftruncate, unsigned int, fd, unsigned long, length)
+SYSCALL_DEFINE2(ftruncate, unsigned int, fd, off_t, length)
 {
 	return do_sys_ftruncate(fd, length, 1);
 }
 
 #ifdef CONFIG_COMPAT
-COMPAT_SYSCALL_DEFINE2(ftruncate, unsigned int, fd, compat_ulong_t, length)
+COMPAT_SYSCALL_DEFINE2(ftruncate, unsigned int, fd, compat_off_t, length)
 {
 	return do_sys_ftruncate(fd, length, 1);
 }
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 594357881b0b..77e84d17521e 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -621,7 +621,7 @@ asmlinkage long compat_sys_fstatfs(unsigned int fd,
 asmlinkage long compat_sys_fstatfs64(unsigned int fd, compat_size_t sz,
 				     struct compat_statfs64 __user *buf);
 asmlinkage long compat_sys_truncate(const char __user *, compat_off_t);
-asmlinkage long compat_sys_ftruncate(unsigned int, compat_ulong_t);
+asmlinkage long compat_sys_ftruncate(unsigned int, compat_off_t);
 /* No generic prototype for truncate64, ftruncate64, fallocate */
 asmlinkage long compat_sys_openat(int dfd, const char __user *filename,
 				  int flags, umode_t mode);
diff --git a/include/linux/efi.h b/include/linux/efi.h
index de6d6558a4d3..a849b533be5b 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -709,18 +709,10 @@ static inline efi_status_t efi_query_variable_store(u32 attributes,
 #endif
 extern void __iomem *efi_lookup_mapped_addr(u64 phys_addr);
 
-extern int __init efi_memmap_alloc(unsigned int num_entries,
-				   struct efi_memory_map_data *data);
-extern void __efi_memmap_free(u64 phys, unsigned long size,
-			      unsigned long flags);
+extern int __init __efi_memmap_init(struct efi_memory_map_data *data);
 extern int __init efi_memmap_init_early(struct efi_memory_map_data *data);
 extern int __init efi_memmap_init_late(phys_addr_t addr, unsigned long size);
 extern void __init efi_memmap_unmap(void);
-extern int __init efi_memmap_install(struct efi_memory_map_data *data);
-extern int __init efi_memmap_split_count(efi_memory_desc_t *md,
-					 struct range *range);
-extern void __init efi_memmap_insert(struct efi_memory_map *old_memmap,
-				     void *buf, struct efi_mem_range *mem);
 
 #ifdef CONFIG_EFI_ESRT
 extern void __init efi_esrt_init(void);
diff --git a/include/linux/filter.h b/include/linux/filter.h
index face590b24e1..01f97956572c 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -850,14 +850,15 @@ bpf_ctx_narrow_access_offset(u32 off, u32 size, u32 size_default)
 
 #define bpf_classic_proglen(fprog) (fprog->len * sizeof(fprog->filter[0]))
 
-static inline void bpf_prog_lock_ro(struct bpf_prog *fp)
+static inline int __must_check bpf_prog_lock_ro(struct bpf_prog *fp)
 {
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
 	if (!fp->jited) {
 		set_vm_flush_reset_perms(fp);
-		set_memory_ro((unsigned long)fp, fp->pages);
+		return set_memory_ro((unsigned long)fp, fp->pages);
 	}
 #endif
+	return 0;
 }
 
 static inline void bpf_jit_binary_lock_ro(struct bpf_binary_header *hdr)
diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index dce105f67b4d..160230bb1a9c 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -4608,7 +4608,7 @@ static inline bool ieee80211_mle_size_ok(const u8 *data, u8 len)
 	bool check_common_len = false;
 	u16 control;
 
-	if (len < fixed)
+	if (!data || len < fixed)
 		return false;
 
 	control = le16_to_cpu(mle->control);
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 3b9f4d7c40c3..93d200309122 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -552,13 +552,12 @@ enum zone_watermarks {
 };
 
 /*
- * One per migratetype for each PAGE_ALLOC_COSTLY_ORDER. One additional list
- * for THP which will usually be GFP_MOVABLE. Even if it is another type,
- * it should not contribute to serious fragmentation causing THP allocation
- * failures.
+ * One per migratetype for each PAGE_ALLOC_COSTLY_ORDER. Two additional lists
+ * are added for THP. One PCP list is used by GPF_MOVABLE, and the other PCP list
+ * is used by GFP_UNMOVABLE and GFP_RECLAIMABLE.
  */
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-#define NR_PCP_THP 1
+#define NR_PCP_THP 2
 #else
 #define NR_PCP_THP 0
 #endif
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index e6fb36b71b59..15086715632e 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -90,8 +90,8 @@ enum {
 	NVMF_RDMA_QPTYPE_DATAGRAM	= 2, /* Reliable Datagram */
 };
 
-/* RDMA QP Service Type codes for Discovery Log Page entry TSAS
- * RDMA_QPTYPE field
+/* RDMA Provider Type codes for Discovery Log Page entry TSAS
+ * RDMA_PRTYPE field
  */
 enum {
 	NVMF_RDMA_PRTYPE_NOT_SPECIFIED	= 1, /* No Provider Specified */
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 27a6ba1c0ec4..dcce762b48fa 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -450,7 +450,7 @@ asmlinkage long sys_fstatfs(unsigned int fd, struct statfs __user *buf);
 asmlinkage long sys_fstatfs64(unsigned int fd, size_t sz,
 				struct statfs64 __user *buf);
 asmlinkage long sys_truncate(const char __user *path, long length);
-asmlinkage long sys_ftruncate(unsigned int fd, unsigned long length);
+asmlinkage long sys_ftruncate(unsigned int fd, off_t length);
 #if BITS_PER_LONG == 32
 asmlinkage long sys_truncate64(const char __user *path, loff_t length);
 asmlinkage long sys_ftruncate64(unsigned int fd, loff_t length);
@@ -960,9 +960,15 @@ asmlinkage long sys_prlimit64(pid_t pid, unsigned int resource,
 				const struct rlimit64 __user *new_rlim,
 				struct rlimit64 __user *old_rlim);
 asmlinkage long sys_fanotify_init(unsigned int flags, unsigned int event_f_flags);
+#if defined(CONFIG_ARCH_SPLIT_ARG64)
+asmlinkage long sys_fanotify_mark(int fanotify_fd, unsigned int flags,
+                                unsigned int mask_1, unsigned int mask_2,
+				int dfd, const char  __user * pathname);
+#else
 asmlinkage long sys_fanotify_mark(int fanotify_fd, unsigned int flags,
 				  u64 mask, int fd,
 				  const char  __user *pathname);
+#endif
 asmlinkage long sys_name_to_handle_at(int dfd, const char __user *name,
 				      struct file_handle __user *handle,
 				      int __user *mnt_id, int flag);
diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index 8132f330306d..4242f863f560 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -263,7 +263,7 @@ struct dst_entry *inet_csk_route_child_sock(const struct sock *sk,
 struct sock *inet_csk_reqsk_queue_add(struct sock *sk,
 				      struct request_sock *req,
 				      struct sock *child);
-void inet_csk_reqsk_queue_hash_add(struct sock *sk, struct request_sock *req,
+bool inet_csk_reqsk_queue_hash_add(struct sock *sk, struct request_sock *req,
 				   unsigned long timeout);
 struct sock *inet_csk_complete_hashdance(struct sock *sk, struct sock *child,
 					 struct request_sock *req,
diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 2fa344cb66f6..9a80d0251d8f 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -582,6 +582,11 @@ static inline void *nft_set_priv(const struct nft_set *set)
 	return (void *)set->data;
 }
 
+static inline enum nft_data_types nft_set_datatype(const struct nft_set *set)
+{
+	return set->dtype == NFT_DATA_VERDICT ? NFT_DATA_VERDICT : NFT_DATA_VALUE;
+}
+
 static inline bool nft_set_gc_is_pending(const struct nft_set *s)
 {
 	return refcount_read(&s->refs) != 1;
@@ -784,10 +789,16 @@ static inline struct nft_set_elem_expr *nft_set_ext_expr(const struct nft_set_ex
 	return nft_set_ext(ext, NFT_SET_EXT_EXPRESSIONS);
 }
 
-static inline bool nft_set_elem_expired(const struct nft_set_ext *ext)
+static inline bool __nft_set_elem_expired(const struct nft_set_ext *ext,
+					  u64 tstamp)
 {
 	return nft_set_ext_exists(ext, NFT_SET_EXT_EXPIRATION) &&
-	       time_is_before_eq_jiffies64(*nft_set_ext_expiration(ext));
+	       time_after_eq64(tstamp, *nft_set_ext_expiration(ext));
+}
+
+static inline bool nft_set_elem_expired(const struct nft_set_ext *ext)
+{
+	return __nft_set_elem_expired(ext, get_jiffies_64());
 }
 
 static inline struct nft_set_ext *nft_set_elem_ext(const struct nft_set *set,
@@ -1711,6 +1722,7 @@ struct nftables_pernet {
 	struct list_head	notify_list;
 	struct mutex		commit_mutex;
 	u64			table_handle;
+	u64			tstamp;
 	unsigned int		base_seq;
 	u8			validate_state;
 	unsigned int		gc_seq;
@@ -1723,6 +1735,11 @@ static inline struct nftables_pernet *nft_pernet(const struct net *net)
 	return net_generic(net, nf_tables_net_id);
 }
 
+static inline u64 nft_net_tstamp(const struct net *net)
+{
+	return nft_pernet(net)->tstamp;
+}
+
 #define __NFT_REDUCE_READONLY	1UL
 #define NFT_REDUCE_READONLY	(void *)__NFT_REDUCE_READONLY
 
diff --git a/include/trace/events/qdisc.h b/include/trace/events/qdisc.h
index 1f4258308b96..061fd4960303 100644
--- a/include/trace/events/qdisc.h
+++ b/include/trace/events/qdisc.h
@@ -81,14 +81,14 @@ TRACE_EVENT(qdisc_reset,
 	TP_ARGS(q),
 
 	TP_STRUCT__entry(
-		__string(	dev,		qdisc_dev(q)->name	)
+		__string(	dev,		qdisc_dev(q) ? qdisc_dev(q)->name : "(null)"	)
 		__string(	kind,		q->ops->id		)
 		__field(	u32,		parent			)
 		__field(	u32,		handle			)
 	),
 
 	TP_fast_assign(
-		__assign_str(dev, qdisc_dev(q)->name);
+		__assign_str(dev, qdisc_dev(q) ? qdisc_dev(q)->name : "(null)");
 		__assign_str(kind, q->ops->id);
 		__entry->parent = q->parent;
 		__entry->handle = q->handle;
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 45fa180cc56a..28973a89cdc7 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -805,7 +805,7 @@ __SC_COMP(__NR_pselect6_time64, sys_pselect6, compat_sys_pselect6_time64)
 #define __NR_ppoll_time64 414
 __SC_COMP(__NR_ppoll_time64, sys_ppoll, compat_sys_ppoll_time64)
 #define __NR_io_pgetevents_time64 416
-__SYSCALL(__NR_io_pgetevents_time64, sys_io_pgetevents)
+__SC_COMP(__NR_io_pgetevents_time64, sys_io_pgetevents, compat_sys_io_pgetevents_time64)
 #define __NR_recvmmsg_time64 417
 __SC_COMP(__NR_recvmmsg_time64, sys_recvmmsg, compat_sys_recvmmsg_time64)
 #define __NR_mq_timedsend_time64 418
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 44abf88e1bb0..0ea0d50a7c16 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2034,6 +2034,7 @@ static unsigned int PROG_NAME(stack_size)(const void *ctx, const struct bpf_insn
 	u64 stack[stack_size / sizeof(u64)]; \
 	u64 regs[MAX_BPF_EXT_REG] = {}; \
 \
+	kmsan_unpoison_memory(stack, sizeof(stack)); \
 	FP = (u64) (unsigned long) &stack[ARRAY_SIZE(stack)]; \
 	ARG1 = (u64) (unsigned long) ctx; \
 	return ___bpf_prog_run(regs, insn); \
@@ -2047,6 +2048,7 @@ static u64 PROG_NAME_ARGS(stack_size)(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5, \
 	u64 stack[stack_size / sizeof(u64)]; \
 	u64 regs[MAX_BPF_EXT_REG]; \
 \
+	kmsan_unpoison_memory(stack, sizeof(stack)); \
 	FP = (u64) (unsigned long) &stack[ARRAY_SIZE(stack)]; \
 	BPF_R1 = r1; \
 	BPF_R2 = r2; \
@@ -2223,7 +2225,9 @@ struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
 	}
 
 finalize:
-	bpf_prog_lock_ro(fp);
+	*err = bpf_prog_lock_ro(fp);
+	if (*err)
+		return fp;
 
 	/* The tail call compatibility check can only be done at
 	 * this late stage as we need to determine, if we deal
diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 9e832acf4692..a1911391a864 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -59,7 +59,8 @@ struct bpf_ringbuf {
 	 * This prevents a user-space application from modifying the
 	 * position and ruining in-kernel tracking. The permissions of the
 	 * pages depend on who is producing samples: user-space or the
-	 * kernel.
+	 * kernel. Note that the pending counter is placed in the same
+	 * page as the producer, so that it shares the same cache line.
 	 *
 	 * Kernel-producer
 	 * ---------------
@@ -78,6 +79,7 @@ struct bpf_ringbuf {
 	 */
 	unsigned long consumer_pos __aligned(PAGE_SIZE);
 	unsigned long producer_pos __aligned(PAGE_SIZE);
+	unsigned long pending_pos;
 	char data[] __aligned(PAGE_SIZE);
 };
 
@@ -176,6 +178,7 @@ static struct bpf_ringbuf *bpf_ringbuf_alloc(size_t data_sz, int numa_node)
 	rb->mask = data_sz - 1;
 	rb->consumer_pos = 0;
 	rb->producer_pos = 0;
+	rb->pending_pos = 0;
 
 	return rb;
 }
@@ -390,9 +393,9 @@ bpf_ringbuf_restore_from_rec(struct bpf_ringbuf_hdr *hdr)
 
 static void *__bpf_ringbuf_reserve(struct bpf_ringbuf *rb, u64 size)
 {
-	unsigned long cons_pos, prod_pos, new_prod_pos, flags;
-	u32 len, pg_off;
+	unsigned long cons_pos, prod_pos, new_prod_pos, pend_pos, flags;
 	struct bpf_ringbuf_hdr *hdr;
+	u32 len, pg_off, tmp_size, hdr_len;
 
 	if (unlikely(size > RINGBUF_MAX_RECORD_SZ))
 		return NULL;
@@ -410,13 +413,29 @@ static void *__bpf_ringbuf_reserve(struct bpf_ringbuf *rb, u64 size)
 		spin_lock_irqsave(&rb->spinlock, flags);
 	}
 
+	pend_pos = rb->pending_pos;
 	prod_pos = rb->producer_pos;
 	new_prod_pos = prod_pos + len;
 
-	/* check for out of ringbuf space by ensuring producer position
-	 * doesn't advance more than (ringbuf_size - 1) ahead
+	while (pend_pos < prod_pos) {
+		hdr = (void *)rb->data + (pend_pos & rb->mask);
+		hdr_len = READ_ONCE(hdr->len);
+		if (hdr_len & BPF_RINGBUF_BUSY_BIT)
+			break;
+		tmp_size = hdr_len & ~BPF_RINGBUF_DISCARD_BIT;
+		tmp_size = round_up(tmp_size + BPF_RINGBUF_HDR_SZ, 8);
+		pend_pos += tmp_size;
+	}
+	rb->pending_pos = pend_pos;
+
+	/* check for out of ringbuf space:
+	 * - by ensuring producer position doesn't advance more than
+	 *   (ringbuf_size - 1) ahead
+	 * - by ensuring oldest not yet committed record until newest
+	 *   record does not span more than (ringbuf_size - 1)
 	 */
-	if (new_prod_pos - cons_pos > rb->mask) {
+	if (new_prod_pos - cons_pos > rb->mask ||
+	    new_prod_pos - pend_pos > rb->mask) {
 		spin_unlock_irqrestore(&rb->spinlock, flags);
 		return NULL;
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1d851e2f4859..56a5c8beb553 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14113,10 +14113,14 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 	 * bpf_prog_load will add the kallsyms for the main program.
 	 */
 	for (i = 1; i < env->subprog_cnt; i++) {
-		bpf_prog_lock_ro(func[i]);
-		bpf_prog_kallsyms_add(func[i]);
+		err = bpf_prog_lock_ro(func[i]);
+		if (err)
+			goto out_free;
 	}
 
+	for (i = 1; i < env->subprog_cnt; i++)
+		bpf_prog_kallsyms_add(func[i]);
+
 	/* Last step: make now unused interpreter insns from main
 	 * prog consistent for later dump requests, so they can
 	 * later look the same as if they were interpreted only.
diff --git a/kernel/cpu.c b/kernel/cpu.c
index e0e09b700b43..4044e4d80cbb 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2116,7 +2116,7 @@ EXPORT_SYMBOL_GPL(__cpuhp_state_add_instance);
  * The caller needs to hold cpus read locked while calling this function.
  * Return:
  *   On success:
- *      Positive state number if @state is CPUHP_AP_ONLINE_DYN;
+ *      Positive state number if @state is CPUHP_AP_ONLINE_DYN or CPUHP_BP_PREPARE_DYN;
  *      0 for all other states
  *   On failure: proper (negative) error code
  */
@@ -2139,7 +2139,7 @@ int __cpuhp_setup_state_cpuslocked(enum cpuhp_state state,
 	ret = cpuhp_store_callbacks(state, name, startup, teardown,
 				    multi_instance);
 
-	dynstate = state == CPUHP_AP_ONLINE_DYN;
+	dynstate = state == CPUHP_AP_ONLINE_DYN || state == CPUHP_BP_PREPARE_DYN;
 	if (ret > 0 && dynstate) {
 		state = ret;
 		ret = 0;
@@ -2170,8 +2170,8 @@ int __cpuhp_setup_state_cpuslocked(enum cpuhp_state state,
 out:
 	mutex_unlock(&cpuhp_state_mutex);
 	/*
-	 * If the requested state is CPUHP_AP_ONLINE_DYN, return the
-	 * dynamically allocated state in case of success.
+	 * If the requested state is CPUHP_AP_ONLINE_DYN or CPUHP_BP_PREPARE_DYN,
+	 * return the dynamically allocated state in case of success.
 	 */
 	if (!ret && dynstate)
 		return state;
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 860b2dcf3ac4..f4922c60a615 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -46,8 +46,8 @@ COND_SYSCALL(io_getevents_time32);
 COND_SYSCALL(io_getevents);
 COND_SYSCALL(io_pgetevents_time32);
 COND_SYSCALL(io_pgetevents);
-COND_SYSCALL_COMPAT(io_pgetevents_time32);
 COND_SYSCALL_COMPAT(io_pgetevents);
+COND_SYSCALL_COMPAT(io_pgetevents_time64);
 COND_SYSCALL(io_uring_setup);
 COND_SYSCALL(io_uring_enter);
 COND_SYSCALL(io_uring_register);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a7537da43bd4..12412263d131 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -705,12 +705,16 @@ static void bad_page(struct page *page, const char *reason)
 
 static inline unsigned int order_to_pindex(int migratetype, int order)
 {
+	bool __maybe_unused movable;
 	int base = order;
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	if (order > PAGE_ALLOC_COSTLY_ORDER) {
 		VM_BUG_ON(order != pageblock_order);
-		return NR_LOWORDER_PCP_LISTS;
+
+		movable = migratetype == MIGRATE_MOVABLE;
+
+		return NR_LOWORDER_PCP_LISTS + movable;
 	}
 #else
 	VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);
@@ -724,7 +728,7 @@ static inline int pindex_to_order(unsigned int pindex)
 	int order = pindex / MIGRATE_PCPTYPES;
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	if (pindex == NR_LOWORDER_PCP_LISTS)
+	if (pindex >= NR_LOWORDER_PCP_LISTS)
 		order = pageblock_order;
 #else
 	VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index dafef3a78ad5..7388d2ad7b5d 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -12,6 +12,7 @@
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
 #include <linux/gfp.h>
+#include <linux/if_vlan.h>
 #include <linux/jiffies.h>
 #include <linux/kref.h>
 #include <linux/list.h>
@@ -131,6 +132,29 @@ batadv_orig_node_vlan_get(struct batadv_orig_node *orig_node,
 	return vlan;
 }
 
+/**
+ * batadv_vlan_id_valid() - check if vlan id is in valid batman-adv encoding
+ * @vid: the VLAN identifier
+ *
+ * Return: true when either no vlan is set or if VLAN is in correct range,
+ *  false otherwise
+ */
+static bool batadv_vlan_id_valid(unsigned short vid)
+{
+	unsigned short non_vlan = vid & ~(BATADV_VLAN_HAS_TAG | VLAN_VID_MASK);
+
+	if (vid == 0)
+		return true;
+
+	if (!(vid & BATADV_VLAN_HAS_TAG))
+		return false;
+
+	if (non_vlan)
+		return false;
+
+	return true;
+}
+
 /**
  * batadv_orig_node_vlan_new() - search and possibly create an orig_node_vlan
  *  object
@@ -149,6 +173,9 @@ batadv_orig_node_vlan_new(struct batadv_orig_node *orig_node,
 {
 	struct batadv_orig_node_vlan *vlan;
 
+	if (!batadv_vlan_id_valid(vid))
+		return NULL;
+
 	spin_lock_bh(&orig_node->vlan_list_lock);
 
 	/* first look if an object for this vid already exists */
diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index a6fb89fa6278..7e8a20f2fc42 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -30,10 +30,6 @@ MODULE_ALIAS("can-proto-" __stringify(CAN_J1939));
 /* CAN_HDR: #bytes before can_frame data part */
 #define J1939_CAN_HDR (offsetof(struct can_frame, data))
 
-/* CAN_FTR: #bytes beyond data part */
-#define J1939_CAN_FTR (sizeof(struct can_frame) - J1939_CAN_HDR - \
-		 sizeof(((struct can_frame *)0)->data))
-
 /* lowest layer */
 static void j1939_can_recv(struct sk_buff *iskb, void *data)
 {
@@ -342,7 +338,7 @@ int j1939_send_one(struct j1939_priv *priv, struct sk_buff *skb)
 	memset(cf, 0, J1939_CAN_HDR);
 
 	/* make it a full can frame again */
-	skb_put(skb, J1939_CAN_FTR + (8 - dlc));
+	skb_put_zero(skb, 8 - dlc);
 
 	canid = CAN_EFF_FLAG |
 		(skcb->priority << 26) |
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index bd8ec2433832..25e733983467 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1593,8 +1593,8 @@ j1939_session *j1939_xtp_rx_rts_session_new(struct j1939_priv *priv,
 	struct j1939_sk_buff_cb skcb = *j1939_skb_to_cb(skb);
 	struct j1939_session *session;
 	const u8 *dat;
+	int len, ret;
 	pgn_t pgn;
-	int len;
 
 	netdev_dbg(priv->ndev, "%s\n", __func__);
 
@@ -1653,7 +1653,22 @@ j1939_session *j1939_xtp_rx_rts_session_new(struct j1939_priv *priv,
 	session->tskey = priv->rx_tskey++;
 	j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_RTS);
 
-	WARN_ON_ONCE(j1939_session_activate(session));
+	ret = j1939_session_activate(session);
+	if (ret) {
+		/* Entering this scope indicates an issue with the J1939 bus.
+		 * Possible scenarios include:
+		 * - A time lapse occurred, and a new session was initiated
+		 *   due to another packet being sent correctly. This could
+		 *   have been caused by too long interrupt, debugger, or being
+		 *   out-scheduled by another task.
+		 * - The bus is receiving numerous erroneous packets, either
+		 *   from a malfunctioning device or during a test scenario.
+		 */
+		netdev_alert(priv->ndev, "%s: 0x%p: concurrent session with same addr (%02x %02x) is already active.\n",
+			     __func__, session, skcb.addr.sa, skcb.addr.da);
+		j1939_session_put(session);
+		return NULL;
+	}
 
 	return session;
 }
@@ -1681,6 +1696,8 @@ static int j1939_xtp_rx_rts_session_active(struct j1939_session *session,
 
 		j1939_session_timers_cancel(session);
 		j1939_session_cancel(session, J1939_XTP_ABORT_BUSY);
+		if (session->transmission)
+			j1939_session_deactivate_activate_next(session);
 
 		return -EBUSY;
 	}
diff --git a/net/core/filter.c b/net/core/filter.c
index 7a0741391353..dc89c3424718 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -82,6 +82,9 @@
 #include <net/mptcp.h>
 #include <net/netfilter/nf_conntrack_bpf.h>
 
+/* Keep the struct bpf_fib_lookup small so that it fits into a cacheline */
+static_assert(sizeof(struct bpf_fib_lookup) == 64, "struct bpf_fib_lookup size check");
+
 static const struct bpf_func_proto *
 bpf_sk_base_func_proto(enum bpf_func_id func_id);
 
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 844c9d99dc0e..c3f6653b4274 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -292,10 +292,8 @@ static struct xdp_mem_allocator *__xdp_reg_mem_model(struct xdp_mem_info *mem,
 		mutex_lock(&mem_id_lock);
 		ret = __mem_id_init_hash_table();
 		mutex_unlock(&mem_id_lock);
-		if (ret < 0) {
-			WARN_ON(1);
+		if (ret < 0)
 			return ERR_PTR(ret);
-		}
 	}
 
 	xdp_alloc = kzalloc(sizeof(*xdp_alloc), gfp);
diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c
index 9fe6d9679716..f4a2dce3e104 100644
--- a/net/dccp/ipv4.c
+++ b/net/dccp/ipv4.c
@@ -654,8 +654,11 @@ int dccp_v4_conn_request(struct sock *sk, struct sk_buff *skb)
 	if (dccp_v4_send_response(sk, req))
 		goto drop_and_free;
 
-	inet_csk_reqsk_queue_hash_add(sk, req, DCCP_TIMEOUT_INIT);
-	reqsk_put(req);
+	if (unlikely(!inet_csk_reqsk_queue_hash_add(sk, req, DCCP_TIMEOUT_INIT)))
+		reqsk_free(req);
+	else
+		reqsk_put(req);
+
 	return 0;
 
 drop_and_free:
diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
index e0b0bf75a46c..016af0301366 100644
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -397,8 +397,11 @@ static int dccp_v6_conn_request(struct sock *sk, struct sk_buff *skb)
 	if (dccp_v6_send_response(sk, req))
 		goto drop_and_free;
 
-	inet_csk_reqsk_queue_hash_add(sk, req, DCCP_TIMEOUT_INIT);
-	reqsk_put(req);
+	if (unlikely(!inet_csk_reqsk_queue_hash_add(sk, req, DCCP_TIMEOUT_INIT)))
+		reqsk_free(req);
+	else
+		reqsk_put(req);
+
 	return 0;
 
 drop_and_free:
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 8407098a5939..c267c5e066e9 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1113,25 +1113,34 @@ static void reqsk_timer_handler(struct timer_list *t)
 	inet_csk_reqsk_queue_drop_and_put(oreq->rsk_listener, oreq);
 }
 
-static void reqsk_queue_hash_req(struct request_sock *req,
+static bool reqsk_queue_hash_req(struct request_sock *req,
 				 unsigned long timeout)
 {
+	bool found_dup_sk = false;
+
+	if (!inet_ehash_insert(req_to_sk(req), NULL, &found_dup_sk))
+		return false;
+
+	/* The timer needs to be setup after a successful insertion. */
 	timer_setup(&req->rsk_timer, reqsk_timer_handler, TIMER_PINNED);
 	mod_timer(&req->rsk_timer, jiffies + timeout);
 
-	inet_ehash_insert(req_to_sk(req), NULL, NULL);
 	/* before letting lookups find us, make sure all req fields
 	 * are committed to memory and refcnt initialized.
 	 */
 	smp_wmb();
 	refcount_set(&req->rsk_refcnt, 2 + 1);
+	return true;
 }
 
-void inet_csk_reqsk_queue_hash_add(struct sock *sk, struct request_sock *req,
+bool inet_csk_reqsk_queue_hash_add(struct sock *sk, struct request_sock *req,
 				   unsigned long timeout)
 {
-	reqsk_queue_hash_req(req, timeout);
+	if (!reqsk_queue_hash_req(req, timeout))
+		return false;
+
 	inet_csk_reqsk_queue_added(sk);
+	return true;
 }
 EXPORT_SYMBOL_GPL(inet_csk_reqsk_queue_hash_add);
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index d85dd394d5b4..2146299016ed 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -2754,13 +2754,37 @@ static void tcp_mtup_probe_success(struct sock *sk)
 	NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMTUPSUCCESS);
 }
 
+/* Sometimes we deduce that packets have been dropped due to reasons other than
+ * congestion, like path MTU reductions or failed client TFO attempts. In these
+ * cases we call this function to retransmit as many packets as cwnd allows,
+ * without reducing cwnd. Given that retransmits will set retrans_stamp to a
+ * non-zero value (and may do so in a later calling context due to TSQ), we
+ * also enter CA_Loss so that we track when all retransmitted packets are ACKed
+ * and clear retrans_stamp when that happens (to ensure later recurring RTOs
+ * are using the correct retrans_stamp and don't declare ETIMEDOUT
+ * prematurely).
+ */
+static void tcp_non_congestion_loss_retransmit(struct sock *sk)
+{
+	const struct inet_connection_sock *icsk = inet_csk(sk);
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	if (icsk->icsk_ca_state != TCP_CA_Loss) {
+		tp->high_seq = tp->snd_nxt;
+		tp->snd_ssthresh = tcp_current_ssthresh(sk);
+		tp->prior_ssthresh = 0;
+		tp->undo_marker = 0;
+		tcp_set_ca_state(sk, TCP_CA_Loss);
+	}
+	tcp_xmit_retransmit_queue(sk);
+}
+
 /* Do a simple retransmit without using the backoff mechanisms in
  * tcp_timer. This is used for path mtu discovery.
  * The socket is already locked here.
  */
 void tcp_simple_retransmit(struct sock *sk)
 {
-	const struct inet_connection_sock *icsk = inet_csk(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct sk_buff *skb;
 	int mss;
@@ -2800,14 +2824,7 @@ void tcp_simple_retransmit(struct sock *sk)
 	 * in network, but units changed and effective
 	 * cwnd/ssthresh really reduced now.
 	 */
-	if (icsk->icsk_ca_state != TCP_CA_Loss) {
-		tp->high_seq = tp->snd_nxt;
-		tp->snd_ssthresh = tcp_current_ssthresh(sk);
-		tp->prior_ssthresh = 0;
-		tp->undo_marker = 0;
-		tcp_set_ca_state(sk, TCP_CA_Loss);
-	}
-	tcp_xmit_retransmit_queue(sk);
+	tcp_non_congestion_loss_retransmit(sk);
 }
 EXPORT_SYMBOL(tcp_simple_retransmit);
 
@@ -6145,8 +6162,7 @@ static bool tcp_rcv_fastopen_synack(struct sock *sk, struct sk_buff *synack,
 			tp->fastopen_client_fail = TFO_DATA_NOT_ACKED;
 		skb_rbtree_walk_from(data)
 			 tcp_mark_skb_lost(sk, data);
-		tcp_xmit_retransmit_queue(sk);
-		tp->retrans_stamp = 0;
+		tcp_non_congestion_loss_retransmit(sk);
 		NET_INC_STATS(sock_net(sk),
 				LINUX_MIB_TCPFASTOPENACTIVEFAIL);
 		return true;
@@ -7053,7 +7069,12 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 		tcp_rsk(req)->tfo_listener = false;
 		if (!want_cookie) {
 			req->timeout = tcp_timeout_init((struct sock *)req);
-			inet_csk_reqsk_queue_hash_add(sk, req, req->timeout);
+			if (unlikely(!inet_csk_reqsk_queue_hash_add(sk, req,
+								    req->timeout))) {
+				reqsk_free(req);
+				return 0;
+			}
+
 		}
 		af_ops->send_synack(sk, dst, &fl, req, &foc,
 				    !want_cookie ? TCP_SYNACK_NORMAL :
diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
index f66b5f74cd83..db41eb2d977f 100644
--- a/net/iucv/iucv.c
+++ b/net/iucv/iucv.c
@@ -519,7 +519,7 @@ static void iucv_setmask_mp(void)
  */
 static void iucv_setmask_up(void)
 {
-	cpumask_t cpumask;
+	static cpumask_t cpumask;
 	int cpu;
 
 	/* Disable all cpu but the first in cpu_irq_cpumask. */
@@ -627,23 +627,33 @@ static int iucv_cpu_online(unsigned int cpu)
 
 static int iucv_cpu_down_prep(unsigned int cpu)
 {
-	cpumask_t cpumask;
+	cpumask_var_t cpumask;
+	int ret = 0;
 
 	if (!iucv_path_table)
 		return 0;
 
-	cpumask_copy(&cpumask, &iucv_buffer_cpumask);
-	cpumask_clear_cpu(cpu, &cpumask);
-	if (cpumask_empty(&cpumask))
+	if (!alloc_cpumask_var(&cpumask, GFP_KERNEL))
+		return -ENOMEM;
+
+	cpumask_copy(cpumask, &iucv_buffer_cpumask);
+	cpumask_clear_cpu(cpu, cpumask);
+	if (cpumask_empty(cpumask)) {
 		/* Can't offline last IUCV enabled cpu. */
-		return -EINVAL;
+		ret = -EINVAL;
+		goto __free_cpumask;
+	}
 
 	iucv_retrieve_cpu(NULL);
 	if (!cpumask_empty(&iucv_irq_cpumask))
-		return 0;
+		goto __free_cpumask;
+
 	smp_call_function_single(cpumask_first(&iucv_buffer_cpumask),
 				 iucv_allow_cpu, NULL, 1);
-	return 0;
+
+__free_cpumask:
+	free_cpumask_var(cpumask);
+	return ret;
 }
 
 /**
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 1c4b7a8ec2cc..97ea72d31bd3 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -5398,8 +5398,7 @@ static int nf_tables_fill_setelem(struct sk_buff *skb,
 
 	if (nft_set_ext_exists(ext, NFT_SET_EXT_DATA) &&
 	    nft_data_dump(skb, NFTA_SET_ELEM_DATA, nft_set_ext_data(ext),
-			  set->dtype == NFT_DATA_VERDICT ? NFT_DATA_VERDICT : NFT_DATA_VALUE,
-			  set->dlen) < 0)
+			  nft_set_datatype(set), set->dlen) < 0)
 		goto nla_put_failure;
 
 	if (nft_set_ext_exists(ext, NFT_SET_EXT_EXPRESSIONS) &&
@@ -9377,6 +9376,7 @@ struct nft_trans_gc *nft_trans_gc_catchall_async(struct nft_trans_gc *gc,
 struct nft_trans_gc *nft_trans_gc_catchall_sync(struct nft_trans_gc *gc)
 {
 	struct nft_set_elem_catchall *catchall, *next;
+	u64 tstamp = nft_net_tstamp(gc->net);
 	const struct nft_set *set = gc->set;
 	struct nft_set_elem elem;
 	struct nft_set_ext *ext;
@@ -9386,7 +9386,7 @@ struct nft_trans_gc *nft_trans_gc_catchall_sync(struct nft_trans_gc *gc)
 	list_for_each_entry_safe(catchall, next, &set->catchall_list, list) {
 		ext = nft_set_elem_ext(set, catchall->elem);
 
-		if (!nft_set_elem_expired(ext))
+		if (!__nft_set_elem_expired(ext, tstamp))
 			continue;
 
 		gc = nft_trans_gc_queue_sync(gc, GFP_KERNEL);
@@ -10138,6 +10138,7 @@ static bool nf_tables_valid_genid(struct net *net, u32 genid)
 	bool genid_ok;
 
 	mutex_lock(&nft_net->commit_mutex);
+	nft_net->tstamp = get_jiffies_64();
 
 	genid_ok = genid == 0 || nft_net->base_seq == genid;
 	if (!genid_ok)
@@ -10446,6 +10447,9 @@ static int nft_validate_register_store(const struct nft_ctx *ctx,
 
 		return 0;
 	default:
+		if (type != NFT_DATA_VALUE)
+			return -EINVAL;
+
 		if (reg < NFT_REG_1 * NFT_REG_SIZE / NFT_REG32_SIZE)
 			return -EINVAL;
 		if (len == 0)
@@ -10454,8 +10458,6 @@ static int nft_validate_register_store(const struct nft_ctx *ctx,
 		    sizeof_field(struct nft_regs, data))
 			return -ERANGE;
 
-		if (data != NULL && type != NFT_DATA_VALUE)
-			return -EINVAL;
 		return 0;
 	}
 }
diff --git a/net/netfilter/nft_lookup.c b/net/netfilter/nft_lookup.c
index 68a5dea80548..33daee2e54c5 100644
--- a/net/netfilter/nft_lookup.c
+++ b/net/netfilter/nft_lookup.c
@@ -136,7 +136,8 @@ static int nft_lookup_init(const struct nft_ctx *ctx,
 			return -EINVAL;
 
 		err = nft_parse_register_store(ctx, tb[NFTA_LOOKUP_DREG],
-					       &priv->dreg, NULL, set->dtype,
+					       &priv->dreg, NULL,
+					       nft_set_datatype(set),
 					       set->dlen);
 		if (err < 0)
 			return err;
diff --git a/net/netfilter/nft_set_hash.c b/net/netfilter/nft_set_hash.c
index 2013de934cef..1fd3b413350d 100644
--- a/net/netfilter/nft_set_hash.c
+++ b/net/netfilter/nft_set_hash.c
@@ -35,6 +35,7 @@ struct nft_rhash_cmp_arg {
 	const struct nft_set		*set;
 	const u32			*key;
 	u8				genmask;
+	u64				tstamp;
 };
 
 static inline u32 nft_rhash_key(const void *data, u32 len, u32 seed)
@@ -61,7 +62,7 @@ static inline int nft_rhash_cmp(struct rhashtable_compare_arg *arg,
 		return 1;
 	if (nft_set_elem_is_dead(&he->ext))
 		return 1;
-	if (nft_set_elem_expired(&he->ext))
+	if (__nft_set_elem_expired(&he->ext, x->tstamp))
 		return 1;
 	if (!nft_set_elem_active(&he->ext, x->genmask))
 		return 1;
@@ -86,6 +87,7 @@ bool nft_rhash_lookup(const struct net *net, const struct nft_set *set,
 		.genmask = nft_genmask_cur(net),
 		.set	 = set,
 		.key	 = key,
+		.tstamp  = get_jiffies_64(),
 	};
 
 	he = rhashtable_lookup(&priv->ht, &arg, nft_rhash_params);
@@ -104,6 +106,7 @@ static void *nft_rhash_get(const struct net *net, const struct nft_set *set,
 		.genmask = nft_genmask_cur(net),
 		.set	 = set,
 		.key	 = elem->key.val.data,
+		.tstamp  = get_jiffies_64(),
 	};
 
 	he = rhashtable_lookup(&priv->ht, &arg, nft_rhash_params);
@@ -127,6 +130,7 @@ static bool nft_rhash_update(struct nft_set *set, const u32 *key,
 		.genmask = NFT_GENMASK_ANY,
 		.set	 = set,
 		.key	 = key,
+		.tstamp  = get_jiffies_64(),
 	};
 
 	he = rhashtable_lookup(&priv->ht, &arg, nft_rhash_params);
@@ -170,6 +174,7 @@ static int nft_rhash_insert(const struct net *net, const struct nft_set *set,
 		.genmask = nft_genmask_next(net),
 		.set	 = set,
 		.key	 = elem->key.val.data,
+		.tstamp	 = nft_net_tstamp(net),
 	};
 	struct nft_rhash_elem *prev;
 
@@ -212,6 +217,7 @@ static void *nft_rhash_deactivate(const struct net *net,
 		.genmask = nft_genmask_next(net),
 		.set	 = set,
 		.key	 = elem->key.val.data,
+		.tstamp	 = nft_net_tstamp(net),
 	};
 
 	rcu_read_lock();
diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 2299ced939c4..a56ed216c223 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -504,6 +504,7 @@ bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
  * @set:	nftables API set representation
  * @data:	Key data to be matched against existing elements
  * @genmask:	If set, check that element is active in given genmask
+ * @tstamp:	timestamp to check for expired elements
  *
  * This is essentially the same as the lookup function, except that it matches
  * key data against the uncommitted copy and doesn't use preallocated maps for
@@ -513,7 +514,8 @@ bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
  */
 static struct nft_pipapo_elem *pipapo_get(const struct net *net,
 					  const struct nft_set *set,
-					  const u8 *data, u8 genmask)
+					  const u8 *data, u8 genmask,
+					  u64 tstamp)
 {
 	struct nft_pipapo_elem *ret = ERR_PTR(-ENOENT);
 	struct nft_pipapo *priv = nft_set_priv(set);
@@ -566,7 +568,7 @@ static struct nft_pipapo_elem *pipapo_get(const struct net *net,
 			goto out;
 
 		if (last) {
-			if (nft_set_elem_expired(&f->mt[b].e->ext))
+			if (__nft_set_elem_expired(&f->mt[b].e->ext, tstamp))
 				goto next_match;
 			if ((genmask &&
 			     !nft_set_elem_active(&f->mt[b].e->ext, genmask)))
@@ -603,7 +605,7 @@ static void *nft_pipapo_get(const struct net *net, const struct nft_set *set,
 			    const struct nft_set_elem *elem, unsigned int flags)
 {
 	return pipapo_get(net, set, (const u8 *)elem->key.val.data,
-			 nft_genmask_cur(net));
+			 nft_genmask_cur(net), get_jiffies_64());
 }
 
 /**
@@ -1197,6 +1199,7 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 	struct nft_pipapo *priv = nft_set_priv(set);
 	struct nft_pipapo_match *m = priv->clone;
 	u8 genmask = nft_genmask_next(net);
+	u64 tstamp = nft_net_tstamp(net);
 	struct nft_pipapo_field *f;
 	const u8 *start_p, *end_p;
 	int i, bsize_max, err = 0;
@@ -1206,7 +1209,7 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 	else
 		end = start;
 
-	dup = pipapo_get(net, set, start, genmask);
+	dup = pipapo_get(net, set, start, genmask, tstamp);
 	if (!IS_ERR(dup)) {
 		/* Check if we already have the same exact entry */
 		const struct nft_data *dup_key, *dup_end;
@@ -1228,7 +1231,7 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 
 	if (PTR_ERR(dup) == -ENOENT) {
 		/* Look for partially overlapping entries */
-		dup = pipapo_get(net, set, end, nft_genmask_next(net));
+		dup = pipapo_get(net, set, end, nft_genmask_next(net), tstamp);
 	}
 
 	if (PTR_ERR(dup) != -ENOENT) {
@@ -1581,6 +1584,7 @@ static void pipapo_gc(const struct nft_set *_set, struct nft_pipapo_match *m)
 	struct nft_set *set = (struct nft_set *) _set;
 	struct nft_pipapo *priv = nft_set_priv(set);
 	struct net *net = read_pnet(&set->net);
+	u64 tstamp = nft_net_tstamp(net);
 	int rules_f0, first_rule = 0;
 	struct nft_pipapo_elem *e;
 	struct nft_trans_gc *gc;
@@ -1615,7 +1619,7 @@ static void pipapo_gc(const struct nft_set *_set, struct nft_pipapo_match *m)
 		/* synchronous gc never fails, there is no need to set on
 		 * NFT_SET_ELEM_DEAD_BIT.
 		 */
-		if (nft_set_elem_expired(&e->ext)) {
+		if (__nft_set_elem_expired(&e->ext, tstamp)) {
 			priv->dirty = true;
 
 			gc = nft_trans_gc_queue_sync(gc, GFP_ATOMIC);
@@ -1786,7 +1790,7 @@ static void *pipapo_deactivate(const struct net *net, const struct nft_set *set,
 {
 	struct nft_pipapo_elem *e;
 
-	e = pipapo_get(net, set, data, nft_genmask_next(net));
+	e = pipapo_get(net, set, data, nft_genmask_next(net), nft_net_tstamp(net));
 	if (IS_ERR(e))
 		return NULL;
 
diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index 5bf5572e945c..021d9e76129a 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -314,6 +314,7 @@ static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 	struct nft_rbtree *priv = nft_set_priv(set);
 	u8 cur_genmask = nft_genmask_cur(net);
 	u8 genmask = nft_genmask_next(net);
+	u64 tstamp = nft_net_tstamp(net);
 	int d;
 
 	/* Descend the tree to search for an existing element greater than the
@@ -361,7 +362,7 @@ static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 		/* perform garbage collection to avoid bogus overlap reports
 		 * but skip new elements in this transaction.
 		 */
-		if (nft_set_elem_expired(&rbe->ext) &&
+		if (__nft_set_elem_expired(&rbe->ext, tstamp) &&
 		    nft_set_elem_active(&rbe->ext, cur_genmask)) {
 			const struct nft_rbtree_elem *removed_end;
 
@@ -548,6 +549,7 @@ static void *nft_rbtree_deactivate(const struct net *net,
 	const struct rb_node *parent = priv->root.rb_node;
 	struct nft_rbtree_elem *rbe, *this = elem->priv;
 	u8 genmask = nft_genmask_next(net);
+	u64 tstamp = nft_net_tstamp(net);
 	int d;
 
 	while (parent != NULL) {
@@ -568,7 +570,7 @@ static void *nft_rbtree_deactivate(const struct net *net,
 				   nft_rbtree_interval_end(this)) {
 				parent = parent->rb_right;
 				continue;
-			} else if (nft_set_elem_expired(&rbe->ext)) {
+			} else if (__nft_set_elem_expired(&rbe->ext, tstamp)) {
 				break;
 			} else if (!nft_set_elem_active(&rbe->ext, genmask)) {
 				parent = parent->rb_left;
diff --git a/scripts/Makefile.dtbinst b/scripts/Makefile.dtbinst
index 190d781e84f4..3668259ddb65 100644
--- a/scripts/Makefile.dtbinst
+++ b/scripts/Makefile.dtbinst
@@ -24,7 +24,7 @@ __dtbs_install: $(dtbs) $(subdirs)
 	@:
 
 quiet_cmd_dtb_install = INSTALL $@
-      cmd_dtb_install = install -D $< $@
+      cmd_dtb_install = install -D -m 0644 $< $@
 
 $(dst)/%.dtb: $(obj)/%.dtb
 	$(call cmd,dtb_install)
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 026c8c9db992..fed2b0b6b9ec 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -244,8 +244,8 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 	const char *audit_cause = "failed";
 	struct inode *inode = file_inode(file);
 	struct inode *real_inode = d_real_inode(file_dentry(file));
-	const char *filename = file->f_path.dentry->d_name.name;
 	struct ima_max_digest_data hash;
+	struct name_snapshot filename;
 	int result = 0;
 	int length;
 	void *tmpbuf;
@@ -319,9 +319,13 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 		if (file->f_flags & O_DIRECT)
 			audit_cause = "failed(directio)";
 
+		take_dentry_name_snapshot(&filename, file->f_path.dentry);
+
 		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode,
-				    filename, "collect_data", audit_cause,
-				    result, 0);
+				    filename.name.name, "collect_data",
+				    audit_cause, result, 0);
+
+		release_dentry_name_snapshot(&filename);
 	}
 	return result;
 }
@@ -434,6 +438,7 @@ void ima_audit_measurement(struct integrity_iint_cache *iint,
  */
 const char *ima_d_path(const struct path *path, char **pathbuf, char *namebuf)
 {
+	struct name_snapshot filename;
 	char *pathname = NULL;
 
 	*pathbuf = __getname();
@@ -447,7 +452,10 @@ const char *ima_d_path(const struct path *path, char **pathbuf, char *namebuf)
 	}
 
 	if (!pathname) {
-		strscpy(namebuf, path->dentry->d_name.name, NAME_MAX);
+		take_dentry_name_snapshot(&filename, path->dentry);
+		strscpy(namebuf, filename.name.name, NAME_MAX);
+		release_dentry_name_snapshot(&filename);
+
 		pathname = namebuf;
 	}
 
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index 7bf9b1507220..41ec31debe87 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -483,7 +483,10 @@ static int ima_eventname_init_common(struct ima_event_data *event_data,
 				     bool size_limit)
 {
 	const char *cur_filename = NULL;
+	struct name_snapshot filename;
 	u32 cur_filename_len = 0;
+	bool snapshot = false;
+	int ret;
 
 	BUG_ON(event_data->filename == NULL && event_data->file == NULL);
 
@@ -496,7 +499,10 @@ static int ima_eventname_init_common(struct ima_event_data *event_data,
 	}
 
 	if (event_data->file) {
-		cur_filename = event_data->file->f_path.dentry->d_name.name;
+		take_dentry_name_snapshot(&filename,
+					  event_data->file->f_path.dentry);
+		snapshot = true;
+		cur_filename = filename.name.name;
 		cur_filename_len = strlen(cur_filename);
 	} else
 		/*
@@ -505,8 +511,13 @@ static int ima_eventname_init_common(struct ima_event_data *event_data,
 		 */
 		cur_filename_len = IMA_EVENT_NAME_LEN_MAX;
 out:
-	return ima_write_template_field_data(cur_filename, cur_filename_len,
-					     DATA_FMT_STRING, field_data);
+	ret = ima_write_template_field_data(cur_filename, cur_filename_len,
+					    DATA_FMT_STRING, field_data);
+
+	if (snapshot)
+		release_dentry_name_snapshot(&filename);
+
+	return ret;
 }
 
 /*
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 60866e8e1d96..11ec5783a2f1 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9807,6 +9807,9 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8c7c, "HP ProBook 445 G11", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8c7d, "HP ProBook 465 G11", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8c7e, "HP ProBook 465 G11", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
+	SND_PCI_QUIRK(0x103c, 0x8c7f, "HP EliteBook 645 G11", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
+	SND_PCI_QUIRK(0x103c, 0x8c80, "HP EliteBook 645 G11", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
+	SND_PCI_QUIRK(0x103c, 0x8c81, "HP EliteBook 665 G11", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8c89, "HP ProBook 460 G11", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c8a, "HP EliteBook 630", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c8c, "HP EliteBook 660", ALC236_FIXUP_HP_GPIO_LED),
diff --git a/sound/soc/amd/acp/acp-i2s.c b/sound/soc/amd/acp/acp-i2s.c
index ac416572db0d..3c78207f9ad9 100644
--- a/sound/soc/amd/acp/acp-i2s.c
+++ b/sound/soc/amd/acp/acp-i2s.c
@@ -537,20 +537,12 @@ int asoc_acp_i2s_probe(struct snd_soc_dai *dai)
 {
 	struct device *dev = dai->component->dev;
 	struct acp_dev_data *adata = dev_get_drvdata(dev);
-	struct acp_resource *rsrc = adata->rsrc;
-	unsigned int val;
 
 	if (!adata->acp_base) {
 		dev_err(dev, "I2S base is NULL\n");
 		return -EINVAL;
 	}
 
-	val = readl(adata->acp_base + rsrc->i2s_pin_cfg_offset);
-	if (val != rsrc->i2s_mode) {
-		dev_err(dev, "I2S Mode not supported val %x\n", val);
-		return -EINVAL;
-	}
-
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(asoc_acp_i2s_probe, SND_SOC_ACP_COMMON);
diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 8d14b5593658..8b29099975c9 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -545,6 +545,8 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
+	priv->pdev = pdev;
+
 	cpu_np = of_parse_phandle(np, "audio-cpu", 0);
 	/* Give a chance to old DT binding */
 	if (!cpu_np)
@@ -754,7 +756,6 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 	}
 
 	/* Initialize sound card */
-	priv->pdev = pdev;
 	priv->card.dev = &pdev->dev;
 	priv->card.owner = THIS_MODULE;
 	ret = snd_soc_of_parse_card_name(&priv->card, "model");
diff --git a/sound/soc/rockchip/rockchip_i2s_tdm.c b/sound/soc/rockchip/rockchip_i2s_tdm.c
index 2e36a97077b9..bcea52fa45a5 100644
--- a/sound/soc/rockchip/rockchip_i2s_tdm.c
+++ b/sound/soc/rockchip/rockchip_i2s_tdm.c
@@ -651,8 +651,17 @@ static int rockchip_i2s_tdm_hw_params(struct snd_pcm_substream *substream,
 	int err;
 
 	if (i2s_tdm->is_master_mode) {
-		struct clk *mclk = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
-			i2s_tdm->mclk_tx : i2s_tdm->mclk_rx;
+		struct clk *mclk;
+
+		if (i2s_tdm->clk_trcm == TRCM_TX) {
+			mclk = i2s_tdm->mclk_tx;
+		} else if (i2s_tdm->clk_trcm == TRCM_RX) {
+			mclk = i2s_tdm->mclk_rx;
+		} else if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+			mclk = i2s_tdm->mclk_tx;
+		} else {
+			mclk = i2s_tdm->mclk_rx;
+		}
 
 		err = clk_set_rate(mclk, DEFAULT_MCLK_FS * params_rate(params));
 		if (err)
diff --git a/sound/synth/emux/soundfont.c b/sound/synth/emux/soundfont.c
index 16f00097cb95..eed47e483024 100644
--- a/sound/synth/emux/soundfont.c
+++ b/sound/synth/emux/soundfont.c
@@ -701,7 +701,6 @@ load_data(struct snd_sf_list *sflist, const void __user *data, long count)
 	struct snd_soundfont *sf;
 	struct soundfont_sample_info sample_info;
 	struct snd_sf_sample *sp;
-	long off;
 
 	/* patch must be opened */
 	sf = sflist->currsf;
@@ -711,12 +710,16 @@ load_data(struct snd_sf_list *sflist, const void __user *data, long count)
 	if (is_special_type(sf->type))
 		return -EINVAL;
 
+	if (count < (long)sizeof(sample_info)) {
+		return -EINVAL;
+	}
 	if (copy_from_user(&sample_info, data, sizeof(sample_info)))
 		return -EFAULT;
+	data += sizeof(sample_info);
+	count -= sizeof(sample_info);
 
-	off = sizeof(sample_info);
-
-	if (sample_info.size != (count-off)/2)
+	// SoundFont uses S16LE samples.
+	if (sample_info.size * 2 != count)
 		return -EINVAL;
 
 	/* Check for dup */
@@ -744,7 +747,7 @@ load_data(struct snd_sf_list *sflist, const void __user *data, long count)
 		int  rc;
 		rc = sflist->callback.sample_new
 			(sflist->callback.private_data, sp, sflist->memhdr,
-			 data + off, count - off);
+			 data, count);
 		if (rc < 0) {
 			sf_sample_delete(sflist, sf, sp);
 			return rc;
@@ -957,10 +960,12 @@ load_guspatch(struct snd_sf_list *sflist, const char __user *data,
 	}
 	if (copy_from_user(&patch, data, sizeof(patch)))
 		return -EFAULT;
-	
 	count -= sizeof(patch);
 	data += sizeof(patch);
 
+	if ((patch.len << (patch.mode & WAVE_16_BITS ? 1 : 0)) != count)
+		return -EINVAL;
+
 	sf = newsf(sflist, SNDRV_SFNT_PAT_TYPE_GUS|SNDRV_SFNT_PAT_SHARED, NULL);
 	if (sf == NULL)
 		return -ENOMEM;

