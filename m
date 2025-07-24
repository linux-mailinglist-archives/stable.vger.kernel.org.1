Return-Path: <stable+bounces-164569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 750FBB10170
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 09:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BB0D1CC6839
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 07:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DF7238C36;
	Thu, 24 Jul 2025 07:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KtNT76MZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B022397BF;
	Thu, 24 Jul 2025 07:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753341315; cv=none; b=p63nCBewyptCAwB92Z47SbXbI0K1yhQPP4lYacpfBZAaV5ARQYOgCbIh1yOrKHh1oNf8V39NCCoy2o8hB4sbj8CTaaF3ToB4fKjTnMKafTeCYRYiTLV7Yq2veclaI4xXvSE9GY/R1bS4HyUYV2QocnNBdYhkYy7l+6952nlX/SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753341315; c=relaxed/simple;
	bh=73f7Mayopvb3QOLHDu0ioXgbk8B9k8q/AoHxgnbs8nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qSYaIrFD2uoej599qAAVV1og/PStjV30SR4kmQvGR/H4coo/SedES9s4kgoos9mMEciWhR9CYSYSs+muoDaVJfaBqpicJJONqKF2pqBN6g6WOFOSKJ6DN2DPMn7pVEzhmLCOaAvYUAlK23Vv00rAGnpSjGp/9uF1QiQcAqKHwwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KtNT76MZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD1BC4CEF7;
	Thu, 24 Jul 2025 07:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753341314;
	bh=73f7Mayopvb3QOLHDu0ioXgbk8B9k8q/AoHxgnbs8nk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KtNT76MZR13GhuLfjFStYxz/RGdqvb8TzHW+Qcoo5qe2VSaGqVHcaA4QuBhoyn+aT
	 JjMpo4JwI0xdIMd8YIIdf9GXvw/DV2jU0DiyY4rmBkNZ1yZfS8964CDaI8Zkp9BswL
	 5ENP8USXGPQCySR2+5HFz8gltxCG2aHF5ZtynCoE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.12.40
Date: Thu, 24 Jul 2025 09:15:05 +0200
Message-ID: <2025072405-prancing-collision-b747@gregkh>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025072405-trophy-ladies-1d12@gregkh>
References: <2025072405-trophy-ladies-1d12@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index ba6054d96398..c891f51637d5 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 12
-SUBLEVEL = 39
+SUBLEVEL = 40
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 0baf256b4400..983b2f0e8797 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -687,11 +687,12 @@ lpuart5: serial@29a0000 {
 		};
 
 		wdog0: watchdog@2ad0000 {
-			compatible = "fsl,imx21-wdt";
+			compatible = "fsl,ls1046a-wdt", "fsl,imx21-wdt";
 			reg = <0x0 0x2ad0000 0x0 0x10000>;
 			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(2)>;
+			big-endian;
 		};
 
 		edma0: dma-controller@2c00000 {
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
index d9b13c87f93b..c579a45273f0 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
@@ -484,6 +484,7 @@ reg_vdd_phy: LDO4 {
 			};
 
 			reg_nvcc_sd: LDO5 {
+				regulator-always-on;
 				regulator-max-microvolt = <3300000>;
 				regulator-min-microvolt = <1800000>;
 				regulator-name = "On-module +V3.3_1.8_SD (LDO5)";
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw71xx.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw71xx.dtsi
index 2f740d74707b..4bf818873fe3 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw71xx.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw71xx.dtsi
@@ -70,7 +70,7 @@ &ecspi2 {
 	tpm@1 {
 		compatible = "atmel,attpm20p", "tcg,tpm_tis-spi";
 		reg = <0x1>;
-		spi-max-frequency = <36000000>;
+		spi-max-frequency = <25000000>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw72xx.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw72xx.dtsi
index 5ab3ffe9931d..cf747ec6fa16 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw72xx.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw72xx.dtsi
@@ -110,7 +110,7 @@ &ecspi2 {
 	tpm@1 {
 		compatible = "atmel,attpm20p", "tcg,tpm_tis-spi";
 		reg = <0x1>;
-		spi-max-frequency = <36000000>;
+		spi-max-frequency = <25000000>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw73xx.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw73xx.dtsi
index e2b5e7ac3e46..5eb114d2360a 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw73xx.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw73xx.dtsi
@@ -122,7 +122,7 @@ &ecspi2 {
 	tpm@1 {
 		compatible = "atmel,attpm20p", "tcg,tpm_tis-spi";
 		reg = <0x1>;
-		spi-max-frequency = <36000000>;
+		spi-max-frequency = <25000000>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
index d765b7972841..c3647a059d1f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
@@ -199,7 +199,7 @@ &ecspi1 {
 	tpm@0 {
 		compatible = "atmel,attpm20p", "tcg,tpm_tis-spi";
 		reg = <0x0>;
-		spi-max-frequency = <36000000>;
+		spi-max-frequency = <25000000>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index f904d6b1c84b..7365d6538a73 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -1523,7 +1523,7 @@ pcie0_ep: pcie-ep@4c300000 {
 			      <0x9 0 1 0>;
 			reg-names = "dbi","atu", "dbi2", "app", "dma", "addr_space";
 			num-lanes = <1>;
-			interrupts = <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "dma";
 			clocks = <&scmi_clk IMX95_CLK_HSIO>,
 				 <&scmi_clk IMX95_CLK_HSIOPLL>,
diff --git a/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi b/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
index f743aaf78359..c17c2f40194f 100644
--- a/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
@@ -344,6 +344,18 @@ pmic_int: pmic-int {
 				<0 RK_PA7 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
 	};
+
+	spi1 {
+		spi1_csn0_gpio_pin: spi1-csn0-gpio-pin {
+			rockchip,pins =
+				<3 RK_PB1 RK_FUNC_GPIO &pcfg_pull_up_4ma>;
+		};
+
+		spi1_csn1_gpio_pin: spi1-csn1-gpio-pin {
+			rockchip,pins =
+				<3 RK_PB2 RK_FUNC_GPIO &pcfg_pull_up_4ma>;
+		};
+	};
 };
 
 &pmu_io_domains {
@@ -361,6 +373,17 @@ &sdmmc {
 	vqmmc-supply = <&vccio_sd>;
 };
 
+&spi1 {
+	/*
+	 * Hardware CS has a very slow rise time of about 6us,
+	 * causing transmission errors.
+	 * With cs-gpios we have a rise time of about 20ns.
+	 */
+	cs-gpios = <&gpio3 RK_PB1 GPIO_ACTIVE_LOW>, <&gpio3 RK_PB2 GPIO_ACTIVE_LOW>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi1_clk &spi1_csn0_gpio_pin &spi1_csn1_gpio_pin &spi1_miso &spi1_mosi>;
+};
+
 &tsadc {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi
index fde8b228f2c7..5825141d2007 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi
@@ -317,6 +317,7 @@ &sdmmc {
 	bus-width = <4>;
 	cap-mmc-highspeed;
 	cap-sd-highspeed;
+	cd-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
 	disable-wp;
 	max-frequency = <150000000>;
 	no-sdio;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts b/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
index 074c316a9a69..9713f05f92e9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
@@ -438,6 +438,7 @@ &sdmmc {
 	bus-width = <4>;
 	cap-mmc-highspeed;
 	cap-sd-highspeed;
+	cd-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
 	disable-wp;
 	max-frequency = <150000000>;
 	no-sdio;
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 9c83848797a7..80230de167de 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -6,6 +6,7 @@
 #include <linux/cpu.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/irqflags.h>
 #include <linux/randomize_kstack.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
@@ -151,7 +152,9 @@ asmlinkage __visible __trap_section void name(struct pt_regs *regs)		\
 {										\
 	if (user_mode(regs)) {							\
 		irqentry_enter_from_user_mode(regs);				\
+		local_irq_enable();						\
 		do_trap_error(regs, signo, code, regs->epc, "Oops - " str);	\
+		local_irq_disable();						\
 		irqentry_exit_to_user_mode(regs);				\
 	} else {								\
 		irqentry_state_t state = irqentry_nmi_enter(regs);		\
@@ -173,17 +176,14 @@ asmlinkage __visible __trap_section void do_trap_insn_illegal(struct pt_regs *re
 
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
-
 		local_irq_enable();
 
 		handled = riscv_v_first_use_handler(regs);
-
-		local_irq_disable();
-
 		if (!handled)
 			do_trap_error(regs, SIGILL, ILL_ILLOPC, regs->epc,
 				      "Oops - illegal instruction");
 
+		local_irq_disable();
 		irqentry_exit_to_user_mode(regs);
 	} else {
 		irqentry_state_t state = irqentry_nmi_enter(regs);
@@ -308,9 +308,11 @@ asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
 {
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
+		local_irq_enable();
 
 		handle_break(regs);
 
+		local_irq_disable();
 		irqentry_exit_to_user_mode(regs);
 	} else {
 		irqentry_state_t state = irqentry_nmi_enter(regs);
diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index d14bfc23e315..4128aa5e0c76 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -436,7 +436,7 @@ int handle_misaligned_load(struct pt_regs *regs)
 	}
 
 	if (!fp)
-		SET_RD(insn, regs, val.data_ulong << shift >> shift);
+		SET_RD(insn, regs, (long)(val.data_ulong << shift) >> shift);
 	else if (len == 8)
 		set_f64_rd(insn, regs, val.data_u64);
 	else
diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 64bb8b71013a..ead8d9ba9032 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -544,7 +544,15 @@ static void bpf_jit_plt(struct bpf_plt *plt, void *ret, void *target)
 {
 	memcpy(plt, &bpf_plt, sizeof(*plt));
 	plt->ret = ret;
-	plt->target = target;
+	/*
+	 * (target == NULL) implies that the branch to this PLT entry was
+	 * patched and became a no-op. However, some CPU could have jumped
+	 * to this PLT entry before patching and may be still executing it.
+	 *
+	 * Since the intention in this case is to make the PLT entry a no-op,
+	 * make the target point to the return label instead of NULL.
+	 */
+	plt->target = target ?: ret;
 }
 
 /*
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 759cc3e9c0fa..1fc2035df404 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1472,7 +1472,7 @@ static bool kvm_xen_schedop_poll(struct kvm_vcpu *vcpu, bool longmode,
 	if (kvm_read_guest_virt(vcpu, (gva_t)sched_poll.ports, ports,
 				sched_poll.nr_ports * sizeof(*ports), &e)) {
 		*r = -EFAULT;
-		return true;
+		goto out;
 	}
 
 	for (i = 0; i < sched_poll.nr_ports; i++) {
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 0e2520d929e1..6a38f312e385 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -868,4 +868,5 @@ void blk_unregister_queue(struct gendisk *disk)
 	mutex_unlock(&q->sysfs_dir_lock);
 
 	blk_debugfs_remove(disk);
+	kobject_put(&disk->queue_kobj);
 }
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index e9a197474b9d..2f42d1644618 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -323,14 +323,13 @@ static void lo_complete_rq(struct request *rq)
 static void lo_rw_aio_do_completion(struct loop_cmd *cmd)
 {
 	struct request *rq = blk_mq_rq_from_pdu(cmd);
-	struct loop_device *lo = rq->q->queuedata;
 
 	if (!atomic_dec_and_test(&cmd->ref))
 		return;
 	kfree(cmd->bvec);
 	cmd->bvec = NULL;
 	if (req_op(rq) == REQ_OP_WRITE)
-		file_end_write(lo->lo_backing_file);
+		kiocb_end_write(&cmd->iocb);
 	if (likely(!blk_should_fake_timeout(rq->q)))
 		blk_mq_complete_request(rq);
 }
@@ -406,7 +405,7 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	}
 
 	if (rw == ITER_SOURCE) {
-		file_start_write(lo->lo_backing_file);
+		kiocb_start_write(&cmd->iocb);
 		ret = file->f_op->write_iter(&cmd->iocb, &iter);
 	} else
 		ret = file->f_op->read_iter(&cmd->iocb, &iter);
diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 51d6d91ed404..85df941afb6c 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2656,7 +2656,7 @@ static u8 btintel_classify_pkt_type(struct hci_dev *hdev, struct sk_buff *skb)
 	 * Distinguish ISO data packets form ACL data packets
 	 * based on their connection handle value range.
 	 */
-	if (hci_skb_pkt_type(skb) == HCI_ACLDATA_PKT) {
+	if (iso_capable(hdev) && hci_skb_pkt_type(skb) == HCI_ACLDATA_PKT) {
 		__u16 handle = __le16_to_cpu(hci_acl_hdr(skb)->handle);
 
 		if (hci_handle(handle) >= BTINTEL_ISODATA_HANDLE_BASE)
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index aa6385206050..72b529757373 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3194,6 +3194,32 @@ static const struct qca_device_info qca_devices_table[] = {
 	{ 0x00190200, 40, 4, 16 }, /* WCN785x 2.0 */
 };
 
+static u16 qca_extract_board_id(const struct qca_version *ver)
+{
+	u16 flag = le16_to_cpu(ver->flag);
+	u16 board_id = 0;
+
+	if (((flag >> 8) & 0xff) == QCA_FLAG_MULTI_NVM) {
+		/* The board_id should be split into two bytes
+		 * The 1st byte is chip ID, and the 2nd byte is platform ID
+		 * For example, board ID 0x010A, 0x01 is platform ID. 0x0A is chip ID
+		 * we have several platforms, and platform IDs are continuously added
+		 * Platform ID:
+		 * 0x00 is for Mobile
+		 * 0x01 is for X86
+		 * 0x02 is for Automotive
+		 * 0x03 is for Consumer electronic
+		 */
+		board_id = (ver->chip_id << 8) + ver->platform_id;
+	}
+
+	/* Take 0xffff as invalid board ID */
+	if (board_id == 0xffff)
+		board_id = 0;
+
+	return board_id;
+}
+
 static int btusb_qca_send_vendor_req(struct usb_device *udev, u8 request,
 				     void *data, u16 size)
 {
@@ -3350,44 +3376,28 @@ static void btusb_generate_qca_nvm_name(char *fwname, size_t max_size,
 					const struct qca_version *ver)
 {
 	u32 rom_version = le32_to_cpu(ver->rom_version);
-	u16 flag = le16_to_cpu(ver->flag);
+	const char *variant;
+	int len;
+	u16 board_id;
 
-	if (((flag >> 8) & 0xff) == QCA_FLAG_MULTI_NVM) {
-		/* The board_id should be split into two bytes
-		 * The 1st byte is chip ID, and the 2nd byte is platform ID
-		 * For example, board ID 0x010A, 0x01 is platform ID. 0x0A is chip ID
-		 * we have several platforms, and platform IDs are continuously added
-		 * Platform ID:
-		 * 0x00 is for Mobile
-		 * 0x01 is for X86
-		 * 0x02 is for Automotive
-		 * 0x03 is for Consumer electronic
-		 */
-		u16 board_id = (ver->chip_id << 8) + ver->platform_id;
-		const char *variant;
+	board_id = qca_extract_board_id(ver);
 
-		switch (le32_to_cpu(ver->ram_version)) {
-		case WCN6855_2_0_RAM_VERSION_GF:
-		case WCN6855_2_1_RAM_VERSION_GF:
-			variant = "_gf";
-			break;
-		default:
-			variant = "";
-			break;
-		}
-
-		if (board_id == 0) {
-			snprintf(fwname, max_size, "qca/nvm_usb_%08x%s.bin",
-				rom_version, variant);
-		} else {
-			snprintf(fwname, max_size, "qca/nvm_usb_%08x%s_%04x.bin",
-				rom_version, variant, board_id);
-		}
-	} else {
-		snprintf(fwname, max_size, "qca/nvm_usb_%08x.bin",
-			rom_version);
+	switch (le32_to_cpu(ver->ram_version)) {
+	case WCN6855_2_0_RAM_VERSION_GF:
+	case WCN6855_2_1_RAM_VERSION_GF:
+		variant = "_gf";
+		break;
+	default:
+		variant = NULL;
+		break;
 	}
 
+	len = snprintf(fwname, max_size, "qca/nvm_usb_%08x", rom_version);
+	if (variant)
+		len += snprintf(fwname + len, max_size - len, "%s", variant);
+	if (board_id)
+		len += snprintf(fwname + len, max_size - len, "_%04x", board_id);
+	len += snprintf(fwname + len, max_size - len, ".bin");
 }
 
 static int btusb_setup_qca_load_nvm(struct hci_dev *hdev,
diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
index b9df9b19d4bd..07bc81a706b4 100644
--- a/drivers/comedi/comedi_fops.c
+++ b/drivers/comedi/comedi_fops.c
@@ -1556,21 +1556,27 @@ static int do_insnlist_ioctl(struct comedi_device *dev,
 	}
 
 	for (i = 0; i < n_insns; ++i) {
+		unsigned int n = insns[i].n;
+
 		if (insns[i].insn & INSN_MASK_WRITE) {
 			if (copy_from_user(data, insns[i].data,
-					   insns[i].n * sizeof(unsigned int))) {
+					   n * sizeof(unsigned int))) {
 				dev_dbg(dev->class_dev,
 					"copy_from_user failed\n");
 				ret = -EFAULT;
 				goto error;
 			}
+			if (n < MIN_SAMPLES) {
+				memset(&data[n], 0, (MIN_SAMPLES - n) *
+						    sizeof(unsigned int));
+			}
 		}
 		ret = parse_insn(dev, insns + i, data, file);
 		if (ret < 0)
 			goto error;
 		if (insns[i].insn & INSN_MASK_READ) {
 			if (copy_to_user(insns[i].data, data,
-					 insns[i].n * sizeof(unsigned int))) {
+					 n * sizeof(unsigned int))) {
 				dev_dbg(dev->class_dev,
 					"copy_to_user failed\n");
 				ret = -EFAULT;
@@ -1589,6 +1595,16 @@ static int do_insnlist_ioctl(struct comedi_device *dev,
 	return i;
 }
 
+#define MAX_INSNS   MAX_SAMPLES
+static int check_insnlist_len(struct comedi_device *dev, unsigned int n_insns)
+{
+	if (n_insns > MAX_INSNS) {
+		dev_dbg(dev->class_dev, "insnlist length too large\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
 /*
  * COMEDI_INSN ioctl
  * synchronous instruction
@@ -1633,6 +1649,10 @@ static int do_insn_ioctl(struct comedi_device *dev,
 			ret = -EFAULT;
 			goto error;
 		}
+		if (insn->n < MIN_SAMPLES) {
+			memset(&data[insn->n], 0,
+			       (MIN_SAMPLES - insn->n) * sizeof(unsigned int));
+		}
 	}
 	ret = parse_insn(dev, insn, data, file);
 	if (ret < 0)
@@ -2239,6 +2259,9 @@ static long comedi_unlocked_ioctl(struct file *file, unsigned int cmd,
 			rc = -EFAULT;
 			break;
 		}
+		rc = check_insnlist_len(dev, insnlist.n_insns);
+		if (rc)
+			break;
 		insns = kcalloc(insnlist.n_insns, sizeof(*insns), GFP_KERNEL);
 		if (!insns) {
 			rc = -ENOMEM;
@@ -3090,6 +3113,9 @@ static int compat_insnlist(struct file *file, unsigned long arg)
 	if (copy_from_user(&insnlist32, compat_ptr(arg), sizeof(insnlist32)))
 		return -EFAULT;
 
+	rc = check_insnlist_len(dev, insnlist32.n_insns);
+	if (rc)
+		return rc;
 	insns = kcalloc(insnlist32.n_insns, sizeof(*insns), GFP_KERNEL);
 	if (!insns)
 		return -ENOMEM;
diff --git a/drivers/comedi/drivers.c b/drivers/comedi/drivers.c
index 376130bfba8a..9e4b7c840a8f 100644
--- a/drivers/comedi/drivers.c
+++ b/drivers/comedi/drivers.c
@@ -339,10 +339,10 @@ int comedi_dio_insn_config(struct comedi_device *dev,
 			   unsigned int *data,
 			   unsigned int mask)
 {
-	unsigned int chan_mask = 1 << CR_CHAN(insn->chanspec);
+	unsigned int chan = CR_CHAN(insn->chanspec);
 
-	if (!mask)
-		mask = chan_mask;
+	if (!mask && chan < 32)
+		mask = 1U << chan;
 
 	switch (data[0]) {
 	case INSN_CONFIG_DIO_INPUT:
@@ -382,7 +382,7 @@ EXPORT_SYMBOL_GPL(comedi_dio_insn_config);
 unsigned int comedi_dio_update_state(struct comedi_subdevice *s,
 				     unsigned int *data)
 {
-	unsigned int chanmask = (s->n_chan < 32) ? ((1 << s->n_chan) - 1)
+	unsigned int chanmask = (s->n_chan < 32) ? ((1U << s->n_chan) - 1)
 						 : 0xffffffff;
 	unsigned int mask = data[0] & chanmask;
 	unsigned int bits = data[1];
@@ -615,6 +615,9 @@ static int insn_rw_emulate_bits(struct comedi_device *dev,
 	unsigned int _data[2];
 	int ret;
 
+	if (insn->n == 0)
+		return 0;
+
 	memset(_data, 0, sizeof(_data));
 	memset(&_insn, 0, sizeof(_insn));
 	_insn.insn = INSN_BITS;
@@ -625,8 +628,8 @@ static int insn_rw_emulate_bits(struct comedi_device *dev,
 	if (insn->insn == INSN_WRITE) {
 		if (!(s->subdev_flags & SDF_WRITABLE))
 			return -EINVAL;
-		_data[0] = 1 << (chan - base_chan);		    /* mask */
-		_data[1] = data[0] ? (1 << (chan - base_chan)) : 0; /* bits */
+		_data[0] = 1U << (chan - base_chan);		     /* mask */
+		_data[1] = data[0] ? (1U << (chan - base_chan)) : 0; /* bits */
 	}
 
 	ret = s->insn_bits(dev, s, &_insn, _data);
@@ -709,7 +712,7 @@ static int __comedi_device_postconfig(struct comedi_device *dev)
 
 		if (s->type == COMEDI_SUBD_DO) {
 			if (s->n_chan < 32)
-				s->io_bits = (1 << s->n_chan) - 1;
+				s->io_bits = (1U << s->n_chan) - 1;
 			else
 				s->io_bits = 0xffffffff;
 		}
diff --git a/drivers/comedi/drivers/aio_iiro_16.c b/drivers/comedi/drivers/aio_iiro_16.c
index b00fab0b89d4..739cc4db52ac 100644
--- a/drivers/comedi/drivers/aio_iiro_16.c
+++ b/drivers/comedi/drivers/aio_iiro_16.c
@@ -177,7 +177,8 @@ static int aio_iiro_16_attach(struct comedi_device *dev,
 	 * Digital input change of state interrupts are optionally supported
 	 * using IRQ 2-7, 10-12, 14, or 15.
 	 */
-	if ((1 << it->options[1]) & 0xdcfc) {
+	if (it->options[1] > 0 && it->options[1] < 16 &&
+	    (1 << it->options[1]) & 0xdcfc) {
 		ret = request_irq(it->options[1], aio_iiro_16_cos, 0,
 				  dev->board_name, dev);
 		if (ret == 0)
diff --git a/drivers/comedi/drivers/das16m1.c b/drivers/comedi/drivers/das16m1.c
index b8ea737ad3d1..1b638f5b5a4f 100644
--- a/drivers/comedi/drivers/das16m1.c
+++ b/drivers/comedi/drivers/das16m1.c
@@ -522,7 +522,8 @@ static int das16m1_attach(struct comedi_device *dev,
 	devpriv->extra_iobase = dev->iobase + DAS16M1_8255_IOBASE;
 
 	/* only irqs 2, 3, 4, 5, 6, 7, 10, 11, 12, 14, and 15 are valid */
-	if ((1 << it->options[1]) & 0xdcfc) {
+	if (it->options[1] >= 2 && it->options[1] <= 15 &&
+	    (1 << it->options[1]) & 0xdcfc) {
 		ret = request_irq(it->options[1], das16m1_interrupt, 0,
 				  dev->board_name, dev);
 		if (ret == 0)
diff --git a/drivers/comedi/drivers/das6402.c b/drivers/comedi/drivers/das6402.c
index 68f95330de45..7660487e563c 100644
--- a/drivers/comedi/drivers/das6402.c
+++ b/drivers/comedi/drivers/das6402.c
@@ -567,7 +567,8 @@ static int das6402_attach(struct comedi_device *dev,
 	das6402_reset(dev);
 
 	/* IRQs 2,3,5,6,7, 10,11,15 are valid for "enhanced" mode */
-	if ((1 << it->options[1]) & 0x8cec) {
+	if (it->options[1] > 0 && it->options[1] < 16 &&
+	    (1 << it->options[1]) & 0x8cec) {
 		ret = request_irq(it->options[1], das6402_interrupt, 0,
 				  dev->board_name, dev);
 		if (ret == 0) {
diff --git a/drivers/comedi/drivers/pcl812.c b/drivers/comedi/drivers/pcl812.c
index 0df639c6a595..abca61a72cf7 100644
--- a/drivers/comedi/drivers/pcl812.c
+++ b/drivers/comedi/drivers/pcl812.c
@@ -1149,7 +1149,8 @@ static int pcl812_attach(struct comedi_device *dev, struct comedi_devconfig *it)
 		if (IS_ERR(dev->pacer))
 			return PTR_ERR(dev->pacer);
 
-		if ((1 << it->options[1]) & board->irq_bits) {
+		if (it->options[1] > 0 && it->options[1] < 16 &&
+		    (1 << it->options[1]) & board->irq_bits) {
 			ret = request_irq(it->options[1], pcl812_interrupt, 0,
 					  dev->board_name, dev);
 			if (ret == 0)
diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index 2562dc001fc1..f3c30037dc8e 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -38,7 +38,6 @@ struct psci_cpuidle_data {
 static DEFINE_PER_CPU_READ_MOSTLY(struct psci_cpuidle_data, psci_cpuidle_data);
 static DEFINE_PER_CPU(u32, domain_state);
 static bool psci_cpuidle_use_syscore;
-static bool psci_cpuidle_use_cpuhp;
 
 void psci_set_domain_state(u32 state)
 {
@@ -105,8 +104,12 @@ static int psci_idle_cpuhp_up(unsigned int cpu)
 {
 	struct device *pd_dev = __this_cpu_read(psci_cpuidle_data.dev);
 
-	if (pd_dev)
-		pm_runtime_get_sync(pd_dev);
+	if (pd_dev) {
+		if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+			pm_runtime_get_sync(pd_dev);
+		else
+			dev_pm_genpd_resume(pd_dev);
+	}
 
 	return 0;
 }
@@ -116,7 +119,11 @@ static int psci_idle_cpuhp_down(unsigned int cpu)
 	struct device *pd_dev = __this_cpu_read(psci_cpuidle_data.dev);
 
 	if (pd_dev) {
-		pm_runtime_put_sync(pd_dev);
+		if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+			pm_runtime_put_sync(pd_dev);
+		else
+			dev_pm_genpd_suspend(pd_dev);
+
 		/* Clear domain state to start fresh at next online. */
 		psci_set_domain_state(0);
 	}
@@ -177,9 +184,6 @@ static void psci_idle_init_cpuhp(void)
 {
 	int err;
 
-	if (!psci_cpuidle_use_cpuhp)
-		return;
-
 	err = cpuhp_setup_state_nocalls(CPUHP_AP_CPU_PM_STARTING,
 					"cpuidle/psci:online",
 					psci_idle_cpuhp_up,
@@ -240,10 +244,8 @@ static int psci_dt_cpu_init_topology(struct cpuidle_driver *drv,
 	 * s2ram and s2idle.
 	 */
 	drv->states[state_count - 1].enter_s2idle = psci_enter_s2idle_domain_idle_state;
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		drv->states[state_count - 1].enter = psci_enter_domain_idle_state;
-		psci_cpuidle_use_cpuhp = true;
-	}
 
 	return 0;
 }
@@ -320,7 +322,6 @@ static void psci_cpu_deinit_idle(int cpu)
 
 	dt_idle_detach_cpu(data->dev);
 	psci_cpuidle_use_syscore = false;
-	psci_cpuidle_use_cpuhp = false;
 }
 
 static int psci_idle_init_cpu(struct device *dev, int cpu)
diff --git a/drivers/dma/nbpfaxi.c b/drivers/dma/nbpfaxi.c
index 3b011a91d48e..5f5d6242427e 100644
--- a/drivers/dma/nbpfaxi.c
+++ b/drivers/dma/nbpfaxi.c
@@ -1351,7 +1351,7 @@ static int nbpf_probe(struct platform_device *pdev)
 	if (irqs == 1) {
 		eirq = irqbuf[0];
 
-		for (i = 0; i <= num_channels; i++)
+		for (i = 0; i < num_channels; i++)
 			nbpf->chan[i].irq = irqbuf[0];
 	} else {
 		eirq = platform_get_irq_byname(pdev, "error");
@@ -1361,16 +1361,15 @@ static int nbpf_probe(struct platform_device *pdev)
 		if (irqs == num_channels + 1) {
 			struct nbpf_channel *chan;
 
-			for (i = 0, chan = nbpf->chan; i <= num_channels;
+			for (i = 0, chan = nbpf->chan; i < num_channels;
 			     i++, chan++) {
 				/* Skip the error IRQ */
 				if (irqbuf[i] == eirq)
 					i++;
+				if (i >= ARRAY_SIZE(irqbuf))
+					return -EINVAL;
 				chan->irq = irqbuf[i];
 			}
-
-			if (chan != nbpf->chan + num_channels)
-				return -EINVAL;
 		} else {
 			/* 2 IRQs and more than one channel */
 			if (irqbuf[0] == eirq)
@@ -1378,7 +1377,7 @@ static int nbpf_probe(struct platform_device *pdev)
 			else
 				irq = irqbuf[0];
 
-			for (i = 0; i <= num_channels; i++)
+			for (i = 0; i < num_channels; i++)
 				nbpf->chan[i].irq = irq;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 690976665cf6..10da6e550d76 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -439,6 +439,7 @@ bool amdgpu_ring_soft_recovery(struct amdgpu_ring *ring, unsigned int vmid,
 {
 	unsigned long flags;
 	ktime_t deadline;
+	bool ret;
 
 	if (unlikely(ring->adev->debug_disable_soft_recovery))
 		return false;
@@ -453,12 +454,16 @@ bool amdgpu_ring_soft_recovery(struct amdgpu_ring *ring, unsigned int vmid,
 		dma_fence_set_error(fence, -ENODATA);
 	spin_unlock_irqrestore(fence->lock, flags);
 
-	atomic_inc(&ring->adev->gpu_reset_counter);
 	while (!dma_fence_is_signaled(fence) &&
 	       ktime_to_ns(ktime_sub(deadline, ktime_get())) > 0)
 		ring->funcs->soft_recovery(ring, vmid);
 
-	return dma_fence_is_signaled(fence);
+	ret = dma_fence_is_signaled(fence);
+	/* increment the counter only if soft reset worked */
+	if (ret)
+		atomic_inc(&ring->adev->gpu_reset_counter);
+
+	return ret;
 }
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 9d741695ca07..1f675d67a1a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -4652,6 +4652,7 @@ static int gfx_v8_0_kcq_init_queue(struct amdgpu_ring *ring)
 			memcpy(mqd, adev->gfx.mec.mqd_backup[mqd_idx], sizeof(struct vi_mqd_allocation));
 		/* reset ring buffer */
 		ring->wptr = 0;
+		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);
 		amdgpu_ring_clear_ring(ring);
 	}
 	return 0;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 2ac56e79df05..9a31e5da3687 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -731,7 +731,16 @@ int amdgpu_dm_crtc_init(struct amdgpu_display_manager *dm,
 	 * support programmable degamma anywhere.
 	 */
 	is_dcn = dm->adev->dm.dc->caps.color.dpp.dcn_arch;
-	drm_crtc_enable_color_mgmt(&acrtc->base, is_dcn ? MAX_COLOR_LUT_ENTRIES : 0,
+	/* Dont't enable DRM CRTC degamma property for DCN401 since the
+	 * pre-blending degamma LUT doesn't apply to cursor, and therefore
+	 * can't work similar to a post-blending degamma LUT as in other hw
+	 * versions.
+	 * TODO: revisit it once KMS plane color API is merged.
+	 */
+	drm_crtc_enable_color_mgmt(&acrtc->base,
+				   (is_dcn &&
+				    dm->adev->dm.dc->ctx->dce_version != DCN_VERSION_4_01) ?
+				     MAX_COLOR_LUT_ENTRIES : 0,
 				   true, MAX_COLOR_LUT_ENTRIES);
 
 	drm_mode_crtc_set_gamma_size(&acrtc->base, MAX_COLOR_LEGACY_LUT_ENTRIES);
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
index 313e52997596..2ee034879f9f 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
@@ -1700,7 +1700,7 @@ struct clk_mgr_internal *dcn401_clk_mgr_construct(
 	clk_mgr->base.bw_params = kzalloc(sizeof(*clk_mgr->base.bw_params), GFP_KERNEL);
 	if (!clk_mgr->base.bw_params) {
 		BREAK_TO_DEBUGGER();
-		kfree(clk_mgr);
+		kfree(clk_mgr401);
 		return NULL;
 	}
 
@@ -1711,6 +1711,7 @@ struct clk_mgr_internal *dcn401_clk_mgr_construct(
 	if (!clk_mgr->wm_range_table) {
 		BREAK_TO_DEBUGGER();
 		kfree(clk_mgr->base.bw_params);
+		kfree(clk_mgr401);
 		return NULL;
 	}
 
diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.c b/drivers/gpu/drm/mediatek/mtk_crtc.c
index 8f6fba4217ec..bc7527542fdc 100644
--- a/drivers/gpu/drm/mediatek/mtk_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_crtc.c
@@ -719,6 +719,39 @@ int mtk_crtc_plane_check(struct drm_crtc *crtc, struct drm_plane *plane,
 	return 0;
 }
 
+void mtk_crtc_plane_disable(struct drm_crtc *crtc, struct drm_plane *plane)
+{
+#if IS_REACHABLE(CONFIG_MTK_CMDQ)
+	struct mtk_crtc *mtk_crtc = to_mtk_crtc(crtc);
+	struct mtk_plane_state *plane_state = to_mtk_plane_state(plane->state);
+	int i;
+
+	/* no need to wait for disabling the plane by CPU */
+	if (!mtk_crtc->cmdq_client.chan)
+		return;
+
+	if (!mtk_crtc->enabled)
+		return;
+
+	/* set pending plane state to disabled */
+	for (i = 0; i < mtk_crtc->layer_nr; i++) {
+		struct drm_plane *mtk_plane = &mtk_crtc->planes[i];
+		struct mtk_plane_state *mtk_plane_state = to_mtk_plane_state(mtk_plane->state);
+
+		if (mtk_plane->index == plane->index) {
+			memcpy(mtk_plane_state, plane_state, sizeof(*plane_state));
+			break;
+		}
+	}
+	mtk_crtc_update_config(mtk_crtc, false);
+
+	/* wait for planes to be disabled by CMDQ */
+	wait_event_timeout(mtk_crtc->cb_blocking_queue,
+			   mtk_crtc->cmdq_vblank_cnt == 0,
+			   msecs_to_jiffies(500));
+#endif
+}
+
 void mtk_crtc_async_update(struct drm_crtc *crtc, struct drm_plane *plane,
 			   struct drm_atomic_state *state)
 {
@@ -930,7 +963,8 @@ static int mtk_crtc_init_comp_planes(struct drm_device *drm_dev,
 				mtk_ddp_comp_supported_rotations(comp),
 				mtk_ddp_comp_get_blend_modes(comp),
 				mtk_ddp_comp_get_formats(comp),
-				mtk_ddp_comp_get_num_formats(comp), i);
+				mtk_ddp_comp_get_num_formats(comp),
+				mtk_ddp_comp_is_afbc_supported(comp), i);
 		if (ret)
 			return ret;
 
diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.h b/drivers/gpu/drm/mediatek/mtk_crtc.h
index 388e900b6f4d..828f109b83e7 100644
--- a/drivers/gpu/drm/mediatek/mtk_crtc.h
+++ b/drivers/gpu/drm/mediatek/mtk_crtc.h
@@ -21,6 +21,7 @@ int mtk_crtc_create(struct drm_device *drm_dev, const unsigned int *path,
 		    unsigned int num_conn_routes);
 int mtk_crtc_plane_check(struct drm_crtc *crtc, struct drm_plane *plane,
 			 struct mtk_plane_state *state);
+void mtk_crtc_plane_disable(struct drm_crtc *crtc, struct drm_plane *plane);
 void mtk_crtc_async_update(struct drm_crtc *crtc, struct drm_plane *plane,
 			   struct drm_atomic_state *plane_state);
 struct device *mtk_crtc_dma_dev_get(struct drm_crtc *crtc);
diff --git a/drivers/gpu/drm/mediatek/mtk_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
index edc6417639e6..ac6620e10262 100644
--- a/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
@@ -366,6 +366,7 @@ static const struct mtk_ddp_comp_funcs ddp_ovl = {
 	.get_blend_modes = mtk_ovl_get_blend_modes,
 	.get_formats = mtk_ovl_get_formats,
 	.get_num_formats = mtk_ovl_get_num_formats,
+	.is_afbc_supported = mtk_ovl_is_afbc_supported,
 };
 
 static const struct mtk_ddp_comp_funcs ddp_postmask = {
diff --git a/drivers/gpu/drm/mediatek/mtk_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_ddp_comp.h
index 39720b27f4e9..7289b3dcf22f 100644
--- a/drivers/gpu/drm/mediatek/mtk_ddp_comp.h
+++ b/drivers/gpu/drm/mediatek/mtk_ddp_comp.h
@@ -83,6 +83,7 @@ struct mtk_ddp_comp_funcs {
 	u32 (*get_blend_modes)(struct device *dev);
 	const u32 *(*get_formats)(struct device *dev);
 	size_t (*get_num_formats)(struct device *dev);
+	bool (*is_afbc_supported)(struct device *dev);
 	void (*connect)(struct device *dev, struct device *mmsys_dev, unsigned int next);
 	void (*disconnect)(struct device *dev, struct device *mmsys_dev, unsigned int next);
 	void (*add)(struct device *dev, struct mtk_mutex *mutex);
@@ -294,6 +295,14 @@ size_t mtk_ddp_comp_get_num_formats(struct mtk_ddp_comp *comp)
 	return 0;
 }
 
+static inline bool mtk_ddp_comp_is_afbc_supported(struct mtk_ddp_comp *comp)
+{
+	if (comp->funcs && comp->funcs->is_afbc_supported)
+		return comp->funcs->is_afbc_supported(comp->dev);
+
+	return false;
+}
+
 static inline bool mtk_ddp_comp_add(struct mtk_ddp_comp *comp, struct mtk_mutex *mutex)
 {
 	if (comp->funcs && comp->funcs->add) {
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_drv.h b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
index 04154db9085c..c0f7f77e0574 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_drv.h
+++ b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
@@ -106,6 +106,7 @@ void mtk_ovl_disable_vblank(struct device *dev);
 u32 mtk_ovl_get_blend_modes(struct device *dev);
 const u32 *mtk_ovl_get_formats(struct device *dev);
 size_t mtk_ovl_get_num_formats(struct device *dev);
+bool mtk_ovl_is_afbc_supported(struct device *dev);
 
 void mtk_ovl_adaptor_add_comp(struct device *dev, struct mtk_mutex *mutex);
 void mtk_ovl_adaptor_remove_comp(struct device *dev, struct mtk_mutex *mutex);
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index 19b0d5083981..ca4a9a60b890 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -236,6 +236,13 @@ size_t mtk_ovl_get_num_formats(struct device *dev)
 	return ovl->data->num_formats;
 }
 
+bool mtk_ovl_is_afbc_supported(struct device *dev)
+{
+	struct mtk_disp_ovl *ovl = dev_get_drvdata(dev);
+
+	return ovl->data->supports_afbc;
+}
+
 int mtk_ovl_clk_enable(struct device *dev)
 {
 	struct mtk_disp_ovl *ovl = dev_get_drvdata(dev);
diff --git a/drivers/gpu/drm/mediatek/mtk_plane.c b/drivers/gpu/drm/mediatek/mtk_plane.c
index 8a48b3b0a956..74c2704efb66 100644
--- a/drivers/gpu/drm/mediatek/mtk_plane.c
+++ b/drivers/gpu/drm/mediatek/mtk_plane.c
@@ -285,9 +285,14 @@ static void mtk_plane_atomic_disable(struct drm_plane *plane,
 	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
 									   plane);
 	struct mtk_plane_state *mtk_plane_state = to_mtk_plane_state(new_state);
+	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state,
+									   plane);
+
 	mtk_plane_state->pending.enable = false;
 	wmb(); /* Make sure the above parameter is set before update */
 	mtk_plane_state->pending.dirty = true;
+
+	mtk_crtc_plane_disable(old_state->crtc, plane);
 }
 
 static void mtk_plane_atomic_update(struct drm_plane *plane,
@@ -321,7 +326,8 @@ static const struct drm_plane_helper_funcs mtk_plane_helper_funcs = {
 int mtk_plane_init(struct drm_device *dev, struct drm_plane *plane,
 		   unsigned long possible_crtcs, enum drm_plane_type type,
 		   unsigned int supported_rotations, const u32 blend_modes,
-		   const u32 *formats, size_t num_formats, unsigned int plane_idx)
+		   const u32 *formats, size_t num_formats,
+		   bool supports_afbc, unsigned int plane_idx)
 {
 	int err;
 
@@ -332,7 +338,9 @@ int mtk_plane_init(struct drm_device *dev, struct drm_plane *plane,
 
 	err = drm_universal_plane_init(dev, plane, possible_crtcs,
 				       &mtk_plane_funcs, formats,
-				       num_formats, modifiers, type, NULL);
+				       num_formats,
+				       supports_afbc ? modifiers : NULL,
+				       type, NULL);
 	if (err) {
 		DRM_ERROR("failed to initialize plane\n");
 		return err;
diff --git a/drivers/gpu/drm/mediatek/mtk_plane.h b/drivers/gpu/drm/mediatek/mtk_plane.h
index 3b13b89989c7..95c5fa5295d8 100644
--- a/drivers/gpu/drm/mediatek/mtk_plane.h
+++ b/drivers/gpu/drm/mediatek/mtk_plane.h
@@ -49,5 +49,6 @@ to_mtk_plane_state(struct drm_plane_state *state)
 int mtk_plane_init(struct drm_device *dev, struct drm_plane *plane,
 		   unsigned long possible_crtcs, enum drm_plane_type type,
 		   unsigned int supported_rotations, const u32 blend_modes,
-		   const u32 *formats, size_t num_formats, unsigned int plane_idx);
+		   const u32 *formats, size_t num_formats,
+		   bool supports_afbc, unsigned int plane_idx);
 #endif
diff --git a/drivers/gpu/drm/xe/xe_gt.c b/drivers/gpu/drm/xe/xe_gt.c
index 231ed53cf907..30ec13cb5b6d 100644
--- a/drivers/gpu/drm/xe/xe_gt.c
+++ b/drivers/gpu/drm/xe/xe_gt.c
@@ -389,6 +389,8 @@ int xe_gt_init_early(struct xe_gt *gt)
 	if (err)
 		return err;
 
+	xe_mocs_init_early(gt);
+
 	return 0;
 }
 
@@ -592,17 +594,15 @@ int xe_gt_init(struct xe_gt *gt)
 		xe_hw_fence_irq_init(&gt->fence_irq[i]);
 	}
 
-	err = xe_gt_pagefault_init(gt);
+	err = xe_gt_sysfs_init(gt);
 	if (err)
 		return err;
 
-	xe_mocs_init_early(gt);
-
-	err = xe_gt_sysfs_init(gt);
+	err = gt_fw_domain_init(gt);
 	if (err)
 		return err;
 
-	err = gt_fw_domain_init(gt);
+	err = xe_gt_pagefault_init(gt);
 	if (err)
 		return err;
 
@@ -773,6 +773,9 @@ static int gt_reset(struct xe_gt *gt)
 		goto err_out;
 	}
 
+	if (IS_SRIOV_PF(gt_to_xe(gt)))
+		xe_gt_sriov_pf_stop_prepare(gt);
+
 	xe_uc_gucrc_disable(&gt->uc);
 	xe_uc_stop_prepare(&gt->uc);
 	xe_gt_pagefault_reset(gt);
diff --git a/drivers/gpu/drm/xe/xe_gt_sriov_pf.c b/drivers/gpu/drm/xe/xe_gt_sriov_pf.c
index 905f409db74b..57e9eddc092e 100644
--- a/drivers/gpu/drm/xe/xe_gt_sriov_pf.c
+++ b/drivers/gpu/drm/xe/xe_gt_sriov_pf.c
@@ -5,14 +5,20 @@
 
 #include <drm/drm_managed.h>
 
+#include "regs/xe_guc_regs.h"
 #include "regs/xe_regs.h"
 
+#include "xe_gt.h"
 #include "xe_gt_sriov_pf.h"
 #include "xe_gt_sriov_pf_config.h"
 #include "xe_gt_sriov_pf_control.h"
 #include "xe_gt_sriov_pf_helpers.h"
 #include "xe_gt_sriov_pf_service.h"
+#include "xe_gt_sriov_printk.h"
 #include "xe_mmio.h"
+#include "xe_pm.h"
+
+static void pf_worker_restart_func(struct work_struct *w);
 
 /*
  * VF's metadata is maintained in the flexible array where:
@@ -38,6 +44,11 @@ static int pf_alloc_metadata(struct xe_gt *gt)
 	return 0;
 }
 
+static void pf_init_workers(struct xe_gt *gt)
+{
+	INIT_WORK(&gt->sriov.pf.workers.restart, pf_worker_restart_func);
+}
+
 /**
  * xe_gt_sriov_pf_init_early - Prepare SR-IOV PF data structures on PF.
  * @gt: the &xe_gt to initialize
@@ -62,6 +73,8 @@ int xe_gt_sriov_pf_init_early(struct xe_gt *gt)
 	if (err)
 		return err;
 
+	pf_init_workers(gt);
+
 	return 0;
 }
 
@@ -89,14 +102,111 @@ void xe_gt_sriov_pf_init_hw(struct xe_gt *gt)
 	xe_gt_sriov_pf_service_update(gt);
 }
 
+static u32 pf_get_vf_regs_stride(struct xe_device *xe)
+{
+	return GRAPHICS_VERx100(xe) > 1200 ? 0x400 : 0x1000;
+}
+
+static struct xe_reg xe_reg_vf_to_pf(struct xe_reg vf_reg, unsigned int vfid, u32 stride)
+{
+	struct xe_reg pf_reg = vf_reg;
+
+	pf_reg.vf = 0;
+	pf_reg.addr += stride * vfid;
+
+	return pf_reg;
+}
+
+static void pf_clear_vf_scratch_regs(struct xe_gt *gt, unsigned int vfid)
+{
+	u32 stride = pf_get_vf_regs_stride(gt_to_xe(gt));
+	struct xe_reg scratch;
+	int n, count;
+
+	if (xe_gt_is_media_type(gt)) {
+		count = MED_VF_SW_FLAG_COUNT;
+		for (n = 0; n < count; n++) {
+			scratch = xe_reg_vf_to_pf(MED_VF_SW_FLAG(n), vfid, stride);
+			xe_mmio_write32(gt, scratch, 0);
+		}
+	} else {
+		count = VF_SW_FLAG_COUNT;
+		for (n = 0; n < count; n++) {
+			scratch = xe_reg_vf_to_pf(VF_SW_FLAG(n), vfid, stride);
+			xe_mmio_write32(gt, scratch, 0);
+		}
+	}
+}
+
 /**
- * xe_gt_sriov_pf_restart - Restart SR-IOV support after a GT reset.
+ * xe_gt_sriov_pf_sanitize_hw() - Reset hardware state related to a VF.
  * @gt: the &xe_gt
+ * @vfid: the VF identifier
  *
  * This function can only be called on PF.
  */
-void xe_gt_sriov_pf_restart(struct xe_gt *gt)
+void xe_gt_sriov_pf_sanitize_hw(struct xe_gt *gt, unsigned int vfid)
+{
+	xe_gt_assert(gt, IS_SRIOV_PF(gt_to_xe(gt)));
+
+	pf_clear_vf_scratch_regs(gt, vfid);
+}
+
+static void pf_cancel_restart(struct xe_gt *gt)
+{
+	xe_gt_assert(gt, IS_SRIOV_PF(gt_to_xe(gt)));
+
+	if (cancel_work_sync(&gt->sriov.pf.workers.restart))
+		xe_gt_sriov_dbg_verbose(gt, "pending restart canceled!\n");
+}
+
+/**
+ * xe_gt_sriov_pf_stop_prepare() - Prepare to stop SR-IOV support.
+ * @gt: the &xe_gt
+ *
+ * This function can only be called on the PF.
+ */
+void xe_gt_sriov_pf_stop_prepare(struct xe_gt *gt)
 {
+	pf_cancel_restart(gt);
+}
+
+static void pf_restart(struct xe_gt *gt)
+{
+	struct xe_device *xe = gt_to_xe(gt);
+
+	xe_pm_runtime_get(xe);
 	xe_gt_sriov_pf_config_restart(gt);
 	xe_gt_sriov_pf_control_restart(gt);
+	xe_pm_runtime_put(xe);
+
+	xe_gt_sriov_dbg(gt, "restart completed\n");
+}
+
+static void pf_worker_restart_func(struct work_struct *w)
+{
+	struct xe_gt *gt = container_of(w, typeof(*gt), sriov.pf.workers.restart);
+
+	pf_restart(gt);
+}
+
+static void pf_queue_restart(struct xe_gt *gt)
+{
+	struct xe_device *xe = gt_to_xe(gt);
+
+	xe_gt_assert(gt, IS_SRIOV_PF(xe));
+
+	if (!queue_work(xe->sriov.wq, &gt->sriov.pf.workers.restart))
+		xe_gt_sriov_dbg(gt, "restart already in queue!\n");
+}
+
+/**
+ * xe_gt_sriov_pf_restart - Restart SR-IOV support after a GT reset.
+ * @gt: the &xe_gt
+ *
+ * This function can only be called on PF.
+ */
+void xe_gt_sriov_pf_restart(struct xe_gt *gt)
+{
+	pf_queue_restart(gt);
 }
diff --git a/drivers/gpu/drm/xe/xe_gt_sriov_pf.h b/drivers/gpu/drm/xe/xe_gt_sriov_pf.h
index f0cb726a6919..165ba31d0391 100644
--- a/drivers/gpu/drm/xe/xe_gt_sriov_pf.h
+++ b/drivers/gpu/drm/xe/xe_gt_sriov_pf.h
@@ -11,6 +11,8 @@ struct xe_gt;
 #ifdef CONFIG_PCI_IOV
 int xe_gt_sriov_pf_init_early(struct xe_gt *gt);
 void xe_gt_sriov_pf_init_hw(struct xe_gt *gt);
+void xe_gt_sriov_pf_sanitize_hw(struct xe_gt *gt, unsigned int vfid);
+void xe_gt_sriov_pf_stop_prepare(struct xe_gt *gt);
 void xe_gt_sriov_pf_restart(struct xe_gt *gt);
 #else
 static inline int xe_gt_sriov_pf_init_early(struct xe_gt *gt)
@@ -22,6 +24,10 @@ static inline void xe_gt_sriov_pf_init_hw(struct xe_gt *gt)
 {
 }
 
+static inline void xe_gt_sriov_pf_stop_prepare(struct xe_gt *gt)
+{
+}
+
 static inline void xe_gt_sriov_pf_restart(struct xe_gt *gt)
 {
 }
diff --git a/drivers/gpu/drm/xe/xe_gt_sriov_pf_control.c b/drivers/gpu/drm/xe/xe_gt_sriov_pf_control.c
index 02f7328bd6ce..b4fd5a81aff1 100644
--- a/drivers/gpu/drm/xe/xe_gt_sriov_pf_control.c
+++ b/drivers/gpu/drm/xe/xe_gt_sriov_pf_control.c
@@ -9,6 +9,7 @@
 
 #include "xe_device.h"
 #include "xe_gt.h"
+#include "xe_gt_sriov_pf.h"
 #include "xe_gt_sriov_pf_config.h"
 #include "xe_gt_sriov_pf_control.h"
 #include "xe_gt_sriov_pf_helpers.h"
@@ -1008,7 +1009,7 @@ static bool pf_exit_vf_flr_reset_mmio(struct xe_gt *gt, unsigned int vfid)
 	if (!pf_exit_vf_state(gt, vfid, XE_GT_SRIOV_STATE_FLR_RESET_MMIO))
 		return false;
 
-	/* XXX: placeholder */
+	xe_gt_sriov_pf_sanitize_hw(gt, vfid);
 
 	pf_enter_vf_flr_send_finish(gt, vfid);
 	return true;
diff --git a/drivers/gpu/drm/xe/xe_gt_sriov_pf_types.h b/drivers/gpu/drm/xe/xe_gt_sriov_pf_types.h
index 28e1b130bf87..a69d128c4f45 100644
--- a/drivers/gpu/drm/xe/xe_gt_sriov_pf_types.h
+++ b/drivers/gpu/drm/xe/xe_gt_sriov_pf_types.h
@@ -31,8 +31,17 @@ struct xe_gt_sriov_metadata {
 	struct xe_gt_sriov_pf_service_version version;
 };
 
+/**
+ * struct xe_gt_sriov_pf_workers - GT level workers used by the PF.
+ */
+struct xe_gt_sriov_pf_workers {
+	/** @restart: worker that executes actions post GT reset */
+	struct work_struct restart;
+};
+
 /**
  * struct xe_gt_sriov_pf - GT level PF virtualization data.
+ * @workers: workers data.
  * @service: service data.
  * @control: control data.
  * @policy: policy data.
@@ -40,6 +49,7 @@ struct xe_gt_sriov_metadata {
  * @vfs: metadata for all VFs.
  */
 struct xe_gt_sriov_pf {
+	struct xe_gt_sriov_pf_workers workers;
 	struct xe_gt_sriov_pf_service service;
 	struct xe_gt_sriov_pf_control control;
 	struct xe_gt_sriov_pf_policy policy;
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 155deef867ac..c2783d04c6e0 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1873,9 +1873,12 @@ u8 *hid_alloc_report_buf(struct hid_report *report, gfp_t flags)
 	/*
 	 * 7 extra bytes are necessary to achieve proper functionality
 	 * of implement() working on 8 byte chunks
+	 * 1 extra byte for the report ID if it is null (not used) so
+	 * we can reserve that extra byte in the first position of the buffer
+	 * when sending it to .raw_request()
 	 */
 
-	u32 len = hid_report_len(report) + 7;
+	u32 len = hid_report_len(report) + 7 + (report->id == 0);
 
 	return kzalloc(len, flags);
 }
@@ -1963,7 +1966,7 @@ static struct hid_report *hid_get_report(struct hid_report_enum *report_enum,
 int __hid_request(struct hid_device *hid, struct hid_report *report,
 		enum hid_class_request reqtype)
 {
-	char *buf;
+	char *buf, *data_buf;
 	int ret;
 	u32 len;
 
@@ -1971,13 +1974,19 @@ int __hid_request(struct hid_device *hid, struct hid_report *report,
 	if (!buf)
 		return -ENOMEM;
 
+	data_buf = buf;
 	len = hid_report_len(report);
 
+	if (report->id == 0) {
+		/* reserve the first byte for the report ID */
+		data_buf++;
+		len++;
+	}
+
 	if (reqtype == HID_REQ_SET_REPORT)
-		hid_output_report(report, buf);
+		hid_output_report(report, data_buf);
 
-	ret = hid->ll_driver->raw_request(hid, report->id, buf, len,
-					  report->type, reqtype);
+	ret = hid_hw_raw_request(hid, report->id, buf, len, report->type, reqtype);
 	if (ret < 0) {
 		dbg_hid("unable to complete request: %d\n", ret);
 		goto out;
diff --git a/drivers/hwmon/corsair-cpro.c b/drivers/hwmon/corsair-cpro.c
index e1a7f7aa7f80..b7b911f8359c 100644
--- a/drivers/hwmon/corsair-cpro.c
+++ b/drivers/hwmon/corsair-cpro.c
@@ -89,6 +89,7 @@ struct ccp_device {
 	struct mutex mutex; /* whenever buffer is used, lock before send_usb_cmd */
 	u8 *cmd_buffer;
 	u8 *buffer;
+	int buffer_recv_size; /* number of received bytes in buffer */
 	int target[6];
 	DECLARE_BITMAP(temp_cnct, NUM_TEMP_SENSORS);
 	DECLARE_BITMAP(fan_cnct, NUM_FANS);
@@ -146,6 +147,9 @@ static int send_usb_cmd(struct ccp_device *ccp, u8 command, u8 byte1, u8 byte2,
 	if (!t)
 		return -ETIMEDOUT;
 
+	if (ccp->buffer_recv_size != IN_BUFFER_SIZE)
+		return -EPROTO;
+
 	return ccp_get_errno(ccp);
 }
 
@@ -157,6 +161,7 @@ static int ccp_raw_event(struct hid_device *hdev, struct hid_report *report, u8
 	spin_lock(&ccp->wait_input_report_lock);
 	if (!completion_done(&ccp->wait_input_report)) {
 		memcpy(ccp->buffer, data, min(IN_BUFFER_SIZE, size));
+		ccp->buffer_recv_size = size;
 		complete_all(&ccp->wait_input_report);
 	}
 	spin_unlock(&ccp->wait_input_report_lock);
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 2254abda5c46..0e679cc50148 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -937,6 +937,7 @@ config I2C_OMAP
 	tristate "OMAP I2C adapter"
 	depends on ARCH_OMAP || ARCH_K3 || COMPILE_TEST
 	default MACH_OMAP_OSK
+	select MULTIPLEXER
 	help
 	  If you say yes to this option, support will be included for the
 	  I2C interface on the Texas Instruments OMAP1/2 family of processors.
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 8c9cf08ad45e..0bdee43dc134 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -24,6 +24,7 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/mux/consumer.h>
 #include <linux/of.h>
 #include <linux/slab.h>
 #include <linux/platform_data/i2c-omap.h>
@@ -211,6 +212,7 @@ struct omap_i2c_dev {
 	u16			syscstate;
 	u16			westate;
 	u16			errata;
+	struct mux_state	*mux_state;
 };
 
 static const u8 reg_map_ip_v1[] = {
@@ -1452,8 +1454,27 @@ omap_i2c_probe(struct platform_device *pdev)
 				       (1000 * omap->speed / 8);
 	}
 
+	if (of_property_present(node, "mux-states")) {
+		struct mux_state *mux_state;
+
+		mux_state = devm_mux_state_get(&pdev->dev, NULL);
+		if (IS_ERR(mux_state)) {
+			r = PTR_ERR(mux_state);
+			dev_dbg(&pdev->dev, "failed to get I2C mux: %d\n", r);
+			goto err_put_pm;
+		}
+		omap->mux_state = mux_state;
+		r = mux_state_select(omap->mux_state);
+		if (r) {
+			dev_err(&pdev->dev, "failed to select I2C mux: %d\n", r);
+			goto err_put_pm;
+		}
+	}
+
 	/* reset ASAP, clearing any IRQs */
-	omap_i2c_init(omap);
+	r = omap_i2c_init(omap);
+	if (r)
+		goto err_mux_state_deselect;
 
 	if (omap->rev < OMAP_I2C_OMAP1_REV_2)
 		r = devm_request_irq(&pdev->dev, omap->irq, omap_i2c_omap1_isr,
@@ -1496,6 +1517,10 @@ omap_i2c_probe(struct platform_device *pdev)
 
 err_unuse_clocks:
 	omap_i2c_write_reg(omap, OMAP_I2C_CON_REG, 0);
+err_mux_state_deselect:
+	if (omap->mux_state)
+		mux_state_deselect(omap->mux_state);
+err_put_pm:
 	pm_runtime_dont_use_autosuspend(omap->dev);
 	pm_runtime_put_sync(omap->dev);
 err_disable_pm:
@@ -1511,6 +1536,9 @@ static void omap_i2c_remove(struct platform_device *pdev)
 
 	i2c_del_adapter(&omap->adapter);
 
+	if (omap->mux_state)
+		mux_state_deselect(omap->mux_state);
+
 	ret = pm_runtime_get_sync(&pdev->dev);
 	if (ret < 0)
 		dev_err(omap->dev, "Failed to resume hardware, skip disable\n");
diff --git a/drivers/i2c/busses/i2c-stm32.c b/drivers/i2c/busses/i2c-stm32.c
index 157c64e27d0b..f84ec056e36d 100644
--- a/drivers/i2c/busses/i2c-stm32.c
+++ b/drivers/i2c/busses/i2c-stm32.c
@@ -102,7 +102,6 @@ int stm32_i2c_prep_dma_xfer(struct device *dev, struct stm32_i2c_dma *dma,
 			    void *dma_async_param)
 {
 	struct dma_async_tx_descriptor *txdesc;
-	struct device *chan_dev;
 	int ret;
 
 	if (rd_wr) {
@@ -116,11 +115,10 @@ int stm32_i2c_prep_dma_xfer(struct device *dev, struct stm32_i2c_dma *dma,
 	}
 
 	dma->dma_len = len;
-	chan_dev = dma->chan_using->device->dev;
 
-	dma->dma_buf = dma_map_single(chan_dev, buf, dma->dma_len,
+	dma->dma_buf = dma_map_single(dev, buf, dma->dma_len,
 				      dma->dma_data_dir);
-	if (dma_mapping_error(chan_dev, dma->dma_buf)) {
+	if (dma_mapping_error(dev, dma->dma_buf)) {
 		dev_err(dev, "DMA mapping failed\n");
 		return -EINVAL;
 	}
@@ -150,7 +148,7 @@ int stm32_i2c_prep_dma_xfer(struct device *dev, struct stm32_i2c_dma *dma,
 	return 0;
 
 err:
-	dma_unmap_single(chan_dev, dma->dma_buf, dma->dma_len,
+	dma_unmap_single(dev, dma->dma_buf, dma->dma_len,
 			 dma->dma_data_dir);
 	return ret;
 }
diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index 0174ead99de6..a4587f281216 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -739,12 +739,13 @@ static void stm32f7_i2c_disable_dma_req(struct stm32f7_i2c_dev *i2c_dev)
 
 static void stm32f7_i2c_dma_callback(void *arg)
 {
-	struct stm32f7_i2c_dev *i2c_dev = (struct stm32f7_i2c_dev *)arg;
+	struct stm32f7_i2c_dev *i2c_dev = arg;
 	struct stm32_i2c_dma *dma = i2c_dev->dma;
-	struct device *dev = dma->chan_using->device->dev;
 
 	stm32f7_i2c_disable_dma_req(i2c_dev);
-	dma_unmap_single(dev, dma->dma_buf, dma->dma_len, dma->dma_data_dir);
+	dmaengine_terminate_async(dma->chan_using);
+	dma_unmap_single(i2c_dev->dev, dma->dma_buf, dma->dma_len,
+			 dma->dma_data_dir);
 	complete(&dma->dma_complete);
 }
 
@@ -1510,7 +1511,6 @@ static irqreturn_t stm32f7_i2c_handle_isr_errs(struct stm32f7_i2c_dev *i2c_dev,
 	u16 addr = f7_msg->addr;
 	void __iomem *base = i2c_dev->base;
 	struct device *dev = i2c_dev->dev;
-	struct stm32_i2c_dma *dma = i2c_dev->dma;
 
 	/* Bus error */
 	if (status & STM32F7_I2C_ISR_BERR) {
@@ -1551,10 +1551,8 @@ static irqreturn_t stm32f7_i2c_handle_isr_errs(struct stm32f7_i2c_dev *i2c_dev,
 	}
 
 	/* Disable dma */
-	if (i2c_dev->use_dma) {
-		stm32f7_i2c_disable_dma_req(i2c_dev);
-		dmaengine_terminate_async(dma->chan_using);
-	}
+	if (i2c_dev->use_dma)
+		stm32f7_i2c_dma_callback(i2c_dev);
 
 	i2c_dev->master_mode = false;
 	complete(&i2c_dev->complete);
@@ -1600,7 +1598,6 @@ static irqreturn_t stm32f7_i2c_isr_event_thread(int irq, void *data)
 {
 	struct stm32f7_i2c_dev *i2c_dev = data;
 	struct stm32f7_i2c_msg *f7_msg = &i2c_dev->f7_msg;
-	struct stm32_i2c_dma *dma = i2c_dev->dma;
 	void __iomem *base = i2c_dev->base;
 	u32 status, mask;
 	int ret;
@@ -1619,10 +1616,8 @@ static irqreturn_t stm32f7_i2c_isr_event_thread(int irq, void *data)
 		dev_dbg(i2c_dev->dev, "<%s>: Receive NACK (addr %x)\n",
 			__func__, f7_msg->addr);
 		writel_relaxed(STM32F7_I2C_ICR_NACKCF, base + STM32F7_I2C_ICR);
-		if (i2c_dev->use_dma) {
-			stm32f7_i2c_disable_dma_req(i2c_dev);
-			dmaengine_terminate_async(dma->chan_using);
-		}
+		if (i2c_dev->use_dma)
+			stm32f7_i2c_dma_callback(i2c_dev);
 		f7_msg->result = -ENXIO;
 	}
 
@@ -1640,8 +1635,7 @@ static irqreturn_t stm32f7_i2c_isr_event_thread(int irq, void *data)
 			ret = wait_for_completion_timeout(&i2c_dev->dma->dma_complete, HZ);
 			if (!ret) {
 				dev_dbg(i2c_dev->dev, "<%s>: Timed out\n", __func__);
-				stm32f7_i2c_disable_dma_req(i2c_dev);
-				dmaengine_terminate_async(dma->chan_using);
+				stm32f7_i2c_dma_callback(i2c_dev);
 				f7_msg->result = -ETIMEDOUT;
 			}
 		}
diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index 5e17c1e6d2c7..a4e4e7964a1a 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -865,6 +865,8 @@ static int fxls8962af_buffer_predisable(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
+	synchronize_irq(data->irq);
+
 	ret = __fxls8962af_fifo_set_mode(data, false);
 
 	if (data->enable_event)
diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 0e371efbda70..7394ea72948b 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -1353,6 +1353,7 @@ static int apply_acpi_orientation(struct iio_dev *indio_dev)
 	union acpi_object *ont;
 	union acpi_object *elements;
 	acpi_status status;
+	struct device *parent = indio_dev->dev.parent;
 	int ret = -EINVAL;
 	unsigned int val;
 	int i, j;
@@ -1371,7 +1372,7 @@ static int apply_acpi_orientation(struct iio_dev *indio_dev)
 	};
 
 
-	adev = ACPI_COMPANION(indio_dev->dev.parent);
+	adev = ACPI_COMPANION(parent);
 	if (!adev)
 		return -ENXIO;
 
@@ -1380,8 +1381,7 @@ static int apply_acpi_orientation(struct iio_dev *indio_dev)
 	if (status == AE_NOT_FOUND) {
 		return -ENXIO;
 	} else if (ACPI_FAILURE(status)) {
-		dev_warn(&indio_dev->dev, "failed to execute _ONT: %d\n",
-			 status);
+		dev_warn(parent, "failed to execute _ONT: %d\n", status);
 		return status;
 	}
 
@@ -1457,12 +1457,12 @@ static int apply_acpi_orientation(struct iio_dev *indio_dev)
 	}
 
 	ret = 0;
-	dev_info(&indio_dev->dev, "computed mount matrix from ACPI\n");
+	dev_info(parent, "computed mount matrix from ACPI\n");
 
 out:
 	kfree(buffer.pointer);
 	if (ret)
-		dev_dbg(&indio_dev->dev,
+		dev_dbg(parent,
 			"failed to apply ACPI orientation data: %d\n", ret);
 
 	return ret;
diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
index 6c1a5d1b0a83..0226dfbcf4ae 100644
--- a/drivers/iio/adc/axp20x_adc.c
+++ b/drivers/iio/adc/axp20x_adc.c
@@ -217,6 +217,7 @@ static struct iio_map axp717_maps[] = {
 		.consumer_channel = "batt_chrg_i",
 		.adc_channel_label = "batt_chrg_i",
 	},
+	{ }
 };
 
 /*
diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index d0c6e94f7204..c9d531f233eb 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -504,10 +504,10 @@ static const struct iio_event_spec max1363_events[] = {
 	MAX1363_CHAN_U(1, _s1, 1, bits, ev_spec, num_ev_spec),		\
 	MAX1363_CHAN_U(2, _s2, 2, bits, ev_spec, num_ev_spec),		\
 	MAX1363_CHAN_U(3, _s3, 3, bits, ev_spec, num_ev_spec),		\
-	MAX1363_CHAN_B(0, 1, d0m1, 4, bits, ev_spec, num_ev_spec),	\
-	MAX1363_CHAN_B(2, 3, d2m3, 5, bits, ev_spec, num_ev_spec),	\
-	MAX1363_CHAN_B(1, 0, d1m0, 6, bits, ev_spec, num_ev_spec),	\
-	MAX1363_CHAN_B(3, 2, d3m2, 7, bits, ev_spec, num_ev_spec),	\
+	MAX1363_CHAN_B(0, 1, d0m1, 12, bits, ev_spec, num_ev_spec),	\
+	MAX1363_CHAN_B(2, 3, d2m3, 13, bits, ev_spec, num_ev_spec),	\
+	MAX1363_CHAN_B(1, 0, d1m0, 18, bits, ev_spec, num_ev_spec),	\
+	MAX1363_CHAN_B(3, 2, d3m2, 19, bits, ev_spec, num_ev_spec),	\
 	IIO_CHAN_SOFT_TIMESTAMP(8)					\
 	}
 
@@ -525,23 +525,23 @@ static const struct iio_chan_spec max1363_channels[] =
 /* Applies to max1236, max1237 */
 static const enum max1363_modes max1236_mode_list[] = {
 	_s0, _s1, _s2, _s3,
-	s0to1, s0to2, s0to3,
+	s0to1, s0to2, s2to3, s0to3,
 	d0m1, d2m3, d1m0, d3m2,
 	d0m1to2m3, d1m0to3m2,
-	s2to3,
 };
 
 /* Applies to max1238, max1239 */
 static const enum max1363_modes max1238_mode_list[] = {
 	_s0, _s1, _s2, _s3, _s4, _s5, _s6, _s7, _s8, _s9, _s10, _s11,
 	s0to1, s0to2, s0to3, s0to4, s0to5, s0to6,
+	s6to7, s6to8, s6to9, s6to10, s6to11,
 	s0to7, s0to8, s0to9, s0to10, s0to11,
 	d0m1, d2m3, d4m5, d6m7, d8m9, d10m11,
 	d1m0, d3m2, d5m4, d7m6, d9m8, d11m10,
-	d0m1to2m3, d0m1to4m5, d0m1to6m7, d0m1to8m9, d0m1to10m11,
-	d1m0to3m2, d1m0to5m4, d1m0to7m6, d1m0to9m8, d1m0to11m10,
-	s6to7, s6to8, s6to9, s6to10, s6to11,
-	d6m7to8m9, d6m7to10m11, d7m6to9m8, d7m6to11m10,
+	d0m1to2m3, d0m1to4m5, d0m1to6m7, d6m7to8m9,
+	d0m1to8m9, d6m7to10m11, d0m1to10m11, d1m0to3m2,
+	d1m0to5m4, d1m0to7m6, d7m6to9m8, d1m0to9m8,
+	d7m6to11m10, d1m0to11m10,
 };
 
 #define MAX1363_12X_CHANS(bits) {				\
@@ -577,16 +577,15 @@ static const struct iio_chan_spec max1238_channels[] = MAX1363_12X_CHANS(12);
 
 static const enum max1363_modes max11607_mode_list[] = {
 	_s0, _s1, _s2, _s3,
-	s0to1, s0to2, s0to3,
-	s2to3,
+	s0to1, s0to2, s2to3,
+	s0to3,
 	d0m1, d2m3, d1m0, d3m2,
 	d0m1to2m3, d1m0to3m2,
 };
 
 static const enum max1363_modes max11608_mode_list[] = {
 	_s0, _s1, _s2, _s3, _s4, _s5, _s6, _s7,
-	s0to1, s0to2, s0to3, s0to4, s0to5, s0to6, s0to7,
-	s6to7,
+	s0to1, s0to2, s0to3, s0to4, s0to5, s0to6, s6to7, s0to7,
 	d0m1, d2m3, d4m5, d6m7,
 	d1m0, d3m2, d5m4, d7m6,
 	d0m1to2m3, d0m1to4m5, d0m1to6m7,
@@ -602,14 +601,14 @@ static const enum max1363_modes max11608_mode_list[] = {
 	MAX1363_CHAN_U(5, _s5, 5, bits, NULL, 0),	\
 	MAX1363_CHAN_U(6, _s6, 6, bits, NULL, 0),	\
 	MAX1363_CHAN_U(7, _s7, 7, bits, NULL, 0),	\
-	MAX1363_CHAN_B(0, 1, d0m1, 8, bits, NULL, 0),	\
-	MAX1363_CHAN_B(2, 3, d2m3, 9, bits, NULL, 0),	\
-	MAX1363_CHAN_B(4, 5, d4m5, 10, bits, NULL, 0),	\
-	MAX1363_CHAN_B(6, 7, d6m7, 11, bits, NULL, 0),	\
-	MAX1363_CHAN_B(1, 0, d1m0, 12, bits, NULL, 0),	\
-	MAX1363_CHAN_B(3, 2, d3m2, 13, bits, NULL, 0),	\
-	MAX1363_CHAN_B(5, 4, d5m4, 14, bits, NULL, 0),	\
-	MAX1363_CHAN_B(7, 6, d7m6, 15, bits, NULL, 0),	\
+	MAX1363_CHAN_B(0, 1, d0m1, 12, bits, NULL, 0),	\
+	MAX1363_CHAN_B(2, 3, d2m3, 13, bits, NULL, 0),	\
+	MAX1363_CHAN_B(4, 5, d4m5, 14, bits, NULL, 0),	\
+	MAX1363_CHAN_B(6, 7, d6m7, 15, bits, NULL, 0),	\
+	MAX1363_CHAN_B(1, 0, d1m0, 18, bits, NULL, 0),	\
+	MAX1363_CHAN_B(3, 2, d3m2, 19, bits, NULL, 0),	\
+	MAX1363_CHAN_B(5, 4, d5m4, 20, bits, NULL, 0),	\
+	MAX1363_CHAN_B(7, 6, d7m6, 21, bits, NULL, 0),	\
 	IIO_CHAN_SOFT_TIMESTAMP(16)			\
 }
 static const struct iio_chan_spec max11602_channels[] = MAX1363_8X_CHANS(8);
diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index 616dd729666a..97ea15cba9f7 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -429,10 +429,9 @@ static int stm32_adc_irq_probe(struct platform_device *pdev,
 		return -ENOMEM;
 	}
 
-	for (i = 0; i < priv->cfg->num_irqs; i++) {
-		irq_set_chained_handler(priv->irq[i], stm32_adc_irq_handler);
-		irq_set_handler_data(priv->irq[i], priv);
-	}
+	for (i = 0; i < priv->cfg->num_irqs; i++)
+		irq_set_chained_handler_and_data(priv->irq[i],
+						 stm32_adc_irq_handler, priv);
 
 	return 0;
 }
diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index 1b4287991d00..48a194b8e060 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -154,7 +154,7 @@ static int st_sensors_set_fullscale(struct iio_dev *indio_dev, unsigned int fs)
 	return err;
 
 st_accel_set_fullscale_error:
-	dev_err(&indio_dev->dev, "failed to set new fullscale.\n");
+	dev_err(indio_dev->dev.parent, "failed to set new fullscale.\n");
 	return err;
 }
 
@@ -231,8 +231,7 @@ int st_sensors_power_enable(struct iio_dev *indio_dev)
 					     ARRAY_SIZE(regulator_names),
 					     regulator_names);
 	if (err)
-		return dev_err_probe(&indio_dev->dev, err,
-				     "unable to enable supplies\n");
+		return dev_err_probe(parent, err, "unable to enable supplies\n");
 
 	return 0;
 }
@@ -241,13 +240,14 @@ EXPORT_SYMBOL_NS(st_sensors_power_enable, IIO_ST_SENSORS);
 static int st_sensors_set_drdy_int_pin(struct iio_dev *indio_dev,
 					struct st_sensors_platform_data *pdata)
 {
+	struct device *parent = indio_dev->dev.parent;
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
 
 	/* Sensor does not support interrupts */
 	if (!sdata->sensor_settings->drdy_irq.int1.addr &&
 	    !sdata->sensor_settings->drdy_irq.int2.addr) {
 		if (pdata->drdy_int_pin)
-			dev_info(&indio_dev->dev,
+			dev_info(parent,
 				 "DRDY on pin INT%d specified, but sensor does not support interrupts\n",
 				 pdata->drdy_int_pin);
 		return 0;
@@ -256,29 +256,27 @@ static int st_sensors_set_drdy_int_pin(struct iio_dev *indio_dev,
 	switch (pdata->drdy_int_pin) {
 	case 1:
 		if (!sdata->sensor_settings->drdy_irq.int1.mask) {
-			dev_err(&indio_dev->dev,
-					"DRDY on INT1 not available.\n");
+			dev_err(parent, "DRDY on INT1 not available.\n");
 			return -EINVAL;
 		}
 		sdata->drdy_int_pin = 1;
 		break;
 	case 2:
 		if (!sdata->sensor_settings->drdy_irq.int2.mask) {
-			dev_err(&indio_dev->dev,
-					"DRDY on INT2 not available.\n");
+			dev_err(parent, "DRDY on INT2 not available.\n");
 			return -EINVAL;
 		}
 		sdata->drdy_int_pin = 2;
 		break;
 	default:
-		dev_err(&indio_dev->dev, "DRDY on pdata not valid.\n");
+		dev_err(parent, "DRDY on pdata not valid.\n");
 		return -EINVAL;
 	}
 
 	if (pdata->open_drain) {
 		if (!sdata->sensor_settings->drdy_irq.int1.addr_od &&
 		    !sdata->sensor_settings->drdy_irq.int2.addr_od)
-			dev_err(&indio_dev->dev,
+			dev_err(parent,
 				"open drain requested but unsupported.\n");
 		else
 			sdata->int_pin_open_drain = true;
@@ -336,6 +334,7 @@ EXPORT_SYMBOL_NS(st_sensors_dev_name_probe, IIO_ST_SENSORS);
 int st_sensors_init_sensor(struct iio_dev *indio_dev,
 					struct st_sensors_platform_data *pdata)
 {
+	struct device *parent = indio_dev->dev.parent;
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
 	struct st_sensors_platform_data *of_pdata;
 	int err = 0;
@@ -343,7 +342,7 @@ int st_sensors_init_sensor(struct iio_dev *indio_dev,
 	mutex_init(&sdata->odr_lock);
 
 	/* If OF/DT pdata exists, it will take precedence of anything else */
-	of_pdata = st_sensors_dev_probe(indio_dev->dev.parent, pdata);
+	of_pdata = st_sensors_dev_probe(parent, pdata);
 	if (IS_ERR(of_pdata))
 		return PTR_ERR(of_pdata);
 	if (of_pdata)
@@ -370,7 +369,7 @@ int st_sensors_init_sensor(struct iio_dev *indio_dev,
 		if (err < 0)
 			return err;
 	} else
-		dev_info(&indio_dev->dev, "Full-scale not possible\n");
+		dev_info(parent, "Full-scale not possible\n");
 
 	err = st_sensors_set_odr(indio_dev, sdata->odr);
 	if (err < 0)
@@ -405,7 +404,7 @@ int st_sensors_init_sensor(struct iio_dev *indio_dev,
 			mask = sdata->sensor_settings->drdy_irq.int2.mask_od;
 		}
 
-		dev_info(&indio_dev->dev,
+		dev_info(parent,
 			 "set interrupt line to open drain mode on pin %d\n",
 			 sdata->drdy_int_pin);
 		err = st_sensors_write_data_with_mask(indio_dev, addr,
@@ -594,21 +593,20 @@ EXPORT_SYMBOL_NS(st_sensors_get_settings_index, IIO_ST_SENSORS);
 int st_sensors_verify_id(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
+	struct device *parent = indio_dev->dev.parent;
 	int wai, err;
 
 	if (sdata->sensor_settings->wai_addr) {
 		err = regmap_read(sdata->regmap,
 				  sdata->sensor_settings->wai_addr, &wai);
 		if (err < 0) {
-			dev_err(&indio_dev->dev,
-				"failed to read Who-Am-I register.\n");
-			return err;
+			return dev_err_probe(parent, err,
+					     "failed to read Who-Am-I register.\n");
 		}
 
 		if (sdata->sensor_settings->wai != wai) {
-			dev_warn(&indio_dev->dev,
-				"%s: WhoAmI mismatch (0x%x).\n",
-				indio_dev->name, wai);
+			dev_warn(parent, "%s: WhoAmI mismatch (0x%x).\n",
+				 indio_dev->name, wai);
 		}
 	}
 
diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
index a0df9250a69f..b900acd471bd 100644
--- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
+++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
@@ -127,7 +127,7 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
 	sdata->trig = devm_iio_trigger_alloc(parent, "%s-trigger",
 					     indio_dev->name);
 	if (sdata->trig == NULL) {
-		dev_err(&indio_dev->dev, "failed to allocate iio trigger.\n");
+		dev_err(parent, "failed to allocate iio trigger.\n");
 		return -ENOMEM;
 	}
 
@@ -143,7 +143,7 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
 	case IRQF_TRIGGER_FALLING:
 	case IRQF_TRIGGER_LOW:
 		if (!sdata->sensor_settings->drdy_irq.addr_ihl) {
-			dev_err(&indio_dev->dev,
+			dev_err(parent,
 				"falling/low specified for IRQ but hardware supports only rising/high: will request rising/high\n");
 			if (irq_trig == IRQF_TRIGGER_FALLING)
 				irq_trig = IRQF_TRIGGER_RISING;
@@ -156,21 +156,19 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
 				sdata->sensor_settings->drdy_irq.mask_ihl, 1);
 			if (err < 0)
 				return err;
-			dev_info(&indio_dev->dev,
+			dev_info(parent,
 				 "interrupts on the falling edge or active low level\n");
 		}
 		break;
 	case IRQF_TRIGGER_RISING:
-		dev_info(&indio_dev->dev,
-			 "interrupts on the rising edge\n");
+		dev_info(parent, "interrupts on the rising edge\n");
 		break;
 	case IRQF_TRIGGER_HIGH:
-		dev_info(&indio_dev->dev,
-			 "interrupts active high level\n");
+		dev_info(parent, "interrupts active high level\n");
 		break;
 	default:
 		/* This is the most preferred mode, if possible */
-		dev_err(&indio_dev->dev,
+		dev_err(parent,
 			"unsupported IRQ trigger specified (%lx), enforce rising edge\n", irq_trig);
 		irq_trig = IRQF_TRIGGER_RISING;
 	}
@@ -179,7 +177,7 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
 	if (irq_trig == IRQF_TRIGGER_FALLING ||
 	    irq_trig == IRQF_TRIGGER_RISING) {
 		if (!sdata->sensor_settings->drdy_irq.stat_drdy.addr) {
-			dev_err(&indio_dev->dev,
+			dev_err(parent,
 				"edge IRQ not supported w/o stat register.\n");
 			return -EOPNOTSUPP;
 		}
@@ -214,13 +212,13 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
 					sdata->trig->name,
 					sdata->trig);
 	if (err) {
-		dev_err(&indio_dev->dev, "failed to request trigger IRQ.\n");
+		dev_err(parent, "failed to request trigger IRQ.\n");
 		return err;
 	}
 
 	err = devm_iio_trigger_register(parent, sdata->trig);
 	if (err < 0) {
-		dev_err(&indio_dev->dev, "failed to register iio trigger.\n");
+		dev_err(parent, "failed to register iio trigger.\n");
 		return err;
 	}
 	indio_dev->trig = iio_trigger_get(sdata->trig);
diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 42e0ee683ef6..a3abcdeb6281 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -155,11 +155,14 @@ static ssize_t iio_backend_debugfs_write_reg(struct file *file,
 	ssize_t rc;
 	int ret;
 
+	if (count >= sizeof(buf))
+		return -ENOSPC;
+
 	rc = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf, count);
 	if (rc < 0)
 		return rc;
 
-	buf[count] = '\0';
+	buf[rc] = '\0';
 
 	ret = sscanf(buf, "%i %i", &back->cached_reg_addr, &val);
 
diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 6d679e235af6..f0cab6870404 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -169,12 +169,12 @@ static const struct xpad_device {
 	{ 0x046d, 0xca88, "Logitech Compact Controller for Xbox", 0, XTYPE_XBOX },
 	{ 0x046d, 0xca8a, "Logitech Precision Vibration Feedback Wheel", 0, XTYPE_XBOX },
 	{ 0x046d, 0xcaa3, "Logitech DriveFx Racing Wheel", 0, XTYPE_XBOX360 },
+	{ 0x0502, 0x1305, "Acer NGR200", 0, XTYPE_XBOX360 },
 	{ 0x056e, 0x2004, "Elecom JC-U3613M", 0, XTYPE_XBOX360 },
 	{ 0x05fd, 0x1007, "Mad Catz Controller (unverified)", 0, XTYPE_XBOX },
 	{ 0x05fd, 0x107a, "InterAct 'PowerPad Pro' X-Box pad (Germany)", 0, XTYPE_XBOX },
 	{ 0x05fe, 0x3030, "Chic Controller", 0, XTYPE_XBOX },
 	{ 0x05fe, 0x3031, "Chic Controller", 0, XTYPE_XBOX },
-	{ 0x0502, 0x1305, "Acer NGR200", 0, XTYPE_XBOX },
 	{ 0x062a, 0x0020, "Logic3 Xbox GamePad", 0, XTYPE_XBOX },
 	{ 0x062a, 0x0033, "Competition Pro Steering Wheel", 0, XTYPE_XBOX },
 	{ 0x06a3, 0x0200, "Saitek Racing Wheel", 0, XTYPE_XBOX },
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 56e9f125cda9..af4e6c1e55db 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4414,9 +4414,6 @@ static int device_set_dirty_tracking(struct list_head *devices, bool enable)
 			break;
 	}
 
-	if (!ret)
-		info->domain_attached = true;
-
 	return ret;
 }
 
@@ -4600,6 +4597,9 @@ static int identity_domain_attach_dev(struct iommu_domain *domain, struct device
 		ret = device_setup_pass_through(dev);
 	}
 
+	if (!ret)
+		info->domain_attached = true;
+
 	return ret;
 }
 
diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index ca60ef209df8..aaa21fe295f2 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -2741,7 +2741,11 @@ static unsigned long __evict_many(struct dm_bufio_client *c,
 		__make_buffer_clean(b);
 		__free_buffer_wake(b);
 
-		cond_resched();
+		if (need_resched()) {
+			dm_bufio_unlock(c);
+			cond_resched();
+			dm_bufio_lock(c);
+		}
 	}
 
 	return count;
diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
index 9a3a784054cc..e6801ad14318 100644
--- a/drivers/memstick/core/memstick.c
+++ b/drivers/memstick/core/memstick.c
@@ -322,7 +322,7 @@ EXPORT_SYMBOL(memstick_init_req);
 static int h_memstick_read_dev_id(struct memstick_dev *card,
 				  struct memstick_request **mrq)
 {
-	struct ms_id_register id_reg;
+	struct ms_id_register id_reg = {};
 
 	if (!(*mrq)) {
 		memstick_init_req(&card->current_mrq, MS_TPC_READ_REG, &id_reg,
diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index 35d8fdea668b..f923447ed2ce 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -502,7 +502,8 @@ void bcm2835_prepare_dma(struct bcm2835_host *host, struct mmc_data *data)
 				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 
 	if (!desc) {
-		dma_unmap_sg(dma_chan->device->dev, data->sg, sg_len, dir_data);
+		dma_unmap_sg(dma_chan->device->dev, data->sg, data->sg_len,
+			     dir_data);
 		return;
 	}
 
diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index b0b1d403f352..76ea0e892d4e 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -912,7 +912,8 @@ static bool glk_broken_cqhci(struct sdhci_pci_slot *slot)
 {
 	return slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_GLK_EMMC &&
 	       (dmi_match(DMI_BIOS_VENDOR, "LENOVO") ||
-		dmi_match(DMI_SYS_VENDOR, "IRBIS"));
+		dmi_match(DMI_SYS_VENDOR, "IRBIS") ||
+		dmi_match(DMI_SYS_VENDOR, "Positivo Tecnologia SA"));
 }
 
 static bool jsl_broken_hs400es(struct sdhci_pci_slot *slot)
diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 0aa3c40ea6ed..8e0eb0acf442 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -588,7 +588,8 @@ static const struct sdhci_ops sdhci_am654_ops = {
 static const struct sdhci_pltfm_data sdhci_am654_pdata = {
 	.ops = &sdhci_am654_ops,
 	.quirks = SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+		   SDHCI_QUIRK2_DISABLE_HW_TIMEOUT,
 };
 
 static const struct sdhci_am654_driver_data sdhci_am654_sr1_drvdata = {
@@ -618,7 +619,8 @@ static const struct sdhci_ops sdhci_j721e_8bit_ops = {
 static const struct sdhci_pltfm_data sdhci_j721e_8bit_pdata = {
 	.ops = &sdhci_j721e_8bit_ops,
 	.quirks = SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+		   SDHCI_QUIRK2_DISABLE_HW_TIMEOUT,
 };
 
 static const struct sdhci_am654_driver_data sdhci_j721e_8bit_drvdata = {
@@ -642,7 +644,8 @@ static const struct sdhci_ops sdhci_j721e_4bit_ops = {
 static const struct sdhci_pltfm_data sdhci_j721e_4bit_pdata = {
 	.ops = &sdhci_j721e_4bit_ops,
 	.quirks = SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+		   SDHCI_QUIRK2_DISABLE_HW_TIMEOUT,
 };
 
 static const struct sdhci_am654_driver_data sdhci_j721e_4bit_drvdata = {
diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index b6c5c8bab739..e8995738cf99 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -92,6 +92,8 @@
 #define TCAN4X5X_MODE_STANDBY BIT(6)
 #define TCAN4X5X_MODE_NORMAL BIT(7)
 
+#define TCAN4X5X_NWKRQ_VOLTAGE_VIO BIT(19)
+
 #define TCAN4X5X_DISABLE_WAKE_MSK	(BIT(31) | BIT(30))
 #define TCAN4X5X_DISABLE_INH_MSK	BIT(9)
 
@@ -267,6 +269,13 @@ static int tcan4x5x_init(struct m_can_classdev *cdev)
 	if (ret)
 		return ret;
 
+	if (tcan4x5x->nwkrq_voltage_vio) {
+		ret = regmap_set_bits(tcan4x5x->regmap, TCAN4X5X_CONFIG,
+				      TCAN4X5X_NWKRQ_VOLTAGE_VIO);
+		if (ret)
+			return ret;
+	}
+
 	return ret;
 }
 
@@ -318,21 +327,27 @@ static const struct tcan4x5x_version_info
 	return &tcan4x5x_versions[TCAN4X5X];
 }
 
-static int tcan4x5x_get_gpios(struct m_can_classdev *cdev,
-			      const struct tcan4x5x_version_info *version_info)
+static void tcan4x5x_get_dt_data(struct m_can_classdev *cdev)
+{
+	struct tcan4x5x_priv *tcan4x5x = cdev_to_priv(cdev);
+
+	tcan4x5x->nwkrq_voltage_vio =
+		of_property_read_bool(cdev->dev->of_node, "ti,nwkrq-voltage-vio");
+}
+
+static int tcan4x5x_get_gpios(struct m_can_classdev *cdev)
 {
 	struct tcan4x5x_priv *tcan4x5x = cdev_to_priv(cdev);
 	int ret;
 
-	if (version_info->has_wake_pin) {
-		tcan4x5x->device_wake_gpio = devm_gpiod_get(cdev->dev, "device-wake",
-							    GPIOD_OUT_HIGH);
-		if (IS_ERR(tcan4x5x->device_wake_gpio)) {
-			if (PTR_ERR(tcan4x5x->device_wake_gpio) == -EPROBE_DEFER)
-				return -EPROBE_DEFER;
+	tcan4x5x->device_wake_gpio = devm_gpiod_get_optional(cdev->dev,
+							     "device-wake",
+							     GPIOD_OUT_HIGH);
+	if (IS_ERR(tcan4x5x->device_wake_gpio)) {
+		if (PTR_ERR(tcan4x5x->device_wake_gpio) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
 
-			tcan4x5x_disable_wake(cdev);
-		}
+		tcan4x5x->device_wake_gpio = NULL;
 	}
 
 	tcan4x5x->reset_gpio = devm_gpiod_get_optional(cdev->dev, "reset",
@@ -344,14 +359,31 @@ static int tcan4x5x_get_gpios(struct m_can_classdev *cdev,
 	if (ret)
 		return ret;
 
-	if (version_info->has_state_pin) {
-		tcan4x5x->device_state_gpio = devm_gpiod_get_optional(cdev->dev,
-								      "device-state",
-								      GPIOD_IN);
-		if (IS_ERR(tcan4x5x->device_state_gpio)) {
-			tcan4x5x->device_state_gpio = NULL;
-			tcan4x5x_disable_state(cdev);
-		}
+	tcan4x5x->device_state_gpio = devm_gpiod_get_optional(cdev->dev,
+							      "device-state",
+							      GPIOD_IN);
+	if (IS_ERR(tcan4x5x->device_state_gpio))
+		tcan4x5x->device_state_gpio = NULL;
+
+	return 0;
+}
+
+static int tcan4x5x_check_gpios(struct m_can_classdev *cdev,
+				const struct tcan4x5x_version_info *version_info)
+{
+	struct tcan4x5x_priv *tcan4x5x = cdev_to_priv(cdev);
+	int ret;
+
+	if (version_info->has_wake_pin && !tcan4x5x->device_wake_gpio) {
+		ret = tcan4x5x_disable_wake(cdev);
+		if (ret)
+			return ret;
+	}
+
+	if (version_info->has_state_pin && !tcan4x5x->device_state_gpio) {
+		ret = tcan4x5x_disable_state(cdev);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
@@ -442,18 +474,26 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 		goto out_m_can_class_free_dev;
 	}
 
+	ret = tcan4x5x_get_gpios(mcan_class);
+	if (ret) {
+		dev_err(&spi->dev, "Getting gpios failed %pe\n", ERR_PTR(ret));
+		goto out_power;
+	}
+
 	version_info = tcan4x5x_find_version(priv);
 	if (IS_ERR(version_info)) {
 		ret = PTR_ERR(version_info);
 		goto out_power;
 	}
 
-	ret = tcan4x5x_get_gpios(mcan_class, version_info);
+	ret = tcan4x5x_check_gpios(mcan_class, version_info);
 	if (ret) {
-		dev_err(&spi->dev, "Getting gpios failed %pe\n", ERR_PTR(ret));
+		dev_err(&spi->dev, "Checking gpios failed %pe\n", ERR_PTR(ret));
 		goto out_power;
 	}
 
+	tcan4x5x_get_dt_data(mcan_class);
+
 	tcan4x5x_check_wake(priv);
 
 	ret = tcan4x5x_write_tcan_reg(mcan_class, TCAN4X5X_INT_EN, 0);
diff --git a/drivers/net/can/m_can/tcan4x5x.h b/drivers/net/can/m_can/tcan4x5x.h
index e62c030d3e1e..203399d5e8cc 100644
--- a/drivers/net/can/m_can/tcan4x5x.h
+++ b/drivers/net/can/m_can/tcan4x5x.h
@@ -42,6 +42,8 @@ struct tcan4x5x_priv {
 
 	struct tcan4x5x_map_buf map_buf_rx;
 	struct tcan4x5x_map_buf map_buf_tx;
+
+	bool nwkrq_voltage_vio;
 };
 
 static inline void
diff --git a/drivers/net/ethernet/intel/ice/ice_debugfs.c b/drivers/net/ethernet/intel/ice/ice_debugfs.c
index 9fc0fd95a13d..cb71eca6a85b 100644
--- a/drivers/net/ethernet/intel/ice/ice_debugfs.c
+++ b/drivers/net/ethernet/intel/ice/ice_debugfs.c
@@ -606,7 +606,7 @@ void ice_debugfs_fwlog_init(struct ice_pf *pf)
 
 	pf->ice_debugfs_pf_fwlog = debugfs_create_dir("fwlog",
 						      pf->ice_debugfs_pf);
-	if (IS_ERR(pf->ice_debugfs_pf))
+	if (IS_ERR(pf->ice_debugfs_pf_fwlog))
 		goto err_create_module_files;
 
 	fw_modules_dir = debugfs_create_dir("modules",
diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index 2410aee59fb2..d132eb477551 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.c
+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
@@ -2226,7 +2226,8 @@ bool ice_lag_is_switchdev_running(struct ice_pf *pf)
 	struct ice_lag *lag = pf->lag;
 	struct net_device *tmp_nd;
 
-	if (!ice_is_feature_supported(pf, ICE_F_SRIOV_LAG) || !lag)
+	if (!ice_is_feature_supported(pf, ICE_F_SRIOV_LAG) ||
+	    !lag || !lag->upper_netdev)
 		return false;
 
 	rcu_read_lock();
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 8e24ba96c779..8ed47e7a7515 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1156,8 +1156,9 @@ static void mlx5e_lro_update_tcp_hdr(struct mlx5_cqe64 *cqe, struct tcphdr *tcp)
 	}
 }
 
-static void mlx5e_lro_update_hdr(struct sk_buff *skb, struct mlx5_cqe64 *cqe,
-				 u32 cqe_bcnt)
+static unsigned int mlx5e_lro_update_hdr(struct sk_buff *skb,
+					 struct mlx5_cqe64 *cqe,
+					 u32 cqe_bcnt)
 {
 	struct ethhdr	*eth = (struct ethhdr *)(skb->data);
 	struct tcphdr	*tcp;
@@ -1207,6 +1208,8 @@ static void mlx5e_lro_update_hdr(struct sk_buff *skb, struct mlx5_cqe64 *cqe,
 		tcp->check = tcp_v6_check(payload_len, &ipv6->saddr,
 					  &ipv6->daddr, check);
 	}
+
+	return (unsigned int)((unsigned char *)tcp + tcp->doff * 4 - skb->data);
 }
 
 static void *mlx5e_shampo_get_packet_hd(struct mlx5e_rq *rq, u16 header_index)
@@ -1563,8 +1566,9 @@ static inline void mlx5e_build_rx_skb(struct mlx5_cqe64 *cqe,
 		mlx5e_macsec_offload_handle_rx_skb(netdev, skb, cqe);
 
 	if (lro_num_seg > 1) {
-		mlx5e_lro_update_hdr(skb, cqe, cqe_bcnt);
-		skb_shinfo(skb)->gso_size = DIV_ROUND_UP(cqe_bcnt, lro_num_seg);
+		unsigned int hdrlen = mlx5e_lro_update_hdr(skb, cqe, cqe_bcnt);
+
+		skb_shinfo(skb)->gso_size = DIV_ROUND_UP(cqe_bcnt - hdrlen, lro_num_seg);
 		/* Subtract one since we already counted this as one
 		 * "regular" packet in mlx5e_complete_rx_cqe()
 		 */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 220a9ac75c8b..5bc947f703b5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -2241,6 +2241,7 @@ static const struct pci_device_id mlx5_core_pci_table[] = {
 	{ PCI_VDEVICE(MELLANOX, 0x1021) },			/* ConnectX-7 */
 	{ PCI_VDEVICE(MELLANOX, 0x1023) },			/* ConnectX-8 */
 	{ PCI_VDEVICE(MELLANOX, 0x1025) },			/* ConnectX-9 */
+	{ PCI_VDEVICE(MELLANOX, 0x1027) },			/* ConnectX-10 */
 	{ PCI_VDEVICE(MELLANOX, 0xa2d2) },			/* BlueField integrated ConnectX-5 network controller */
 	{ PCI_VDEVICE(MELLANOX, 0xa2d3), MLX5_PCI_DEV_IS_VF},	/* BlueField integrated ConnectX-5 network controller VF */
 	{ PCI_VDEVICE(MELLANOX, 0xa2d6) },			/* BlueField-2 integrated ConnectX-6 Dx network controller */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index 83ad7c7935e3..23d9ece46d9c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -379,6 +379,12 @@ static int intel_crosststamp(ktime_t *device,
 		return -ETIMEDOUT;
 	}
 
+	*system = (struct system_counterval_t) {
+		.cycles = 0,
+		.cs_id = CSID_X86_ART,
+		.use_nsecs = false,
+	};
+
 	num_snapshot = (readl(ioaddr + GMAC_TIMESTAMP_STATUS) &
 			GMAC_TIMESTAMP_ATSNS_MASK) >>
 			GMAC_TIMESTAMP_ATSNS_SHIFT;
@@ -394,7 +400,7 @@ static int intel_crosststamp(ktime_t *device,
 	}
 
 	system->cycles *= intel_priv->crossts_adj;
-	system->cs_id = CSID_X86_ART;
+
 	priv->plat->flags &= ~STMMAC_FLAG_INT_SNAPSHOT_EN;
 
 	return 0;
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index deaf670c160e..e79220cb725b 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -1531,7 +1531,6 @@ static void wx_configure_rx_ring(struct wx *wx,
 				 struct wx_ring *ring)
 {
 	u16 reg_idx = ring->reg_idx;
-	union wx_rx_desc *rx_desc;
 	u64 rdba = ring->dma;
 	u32 rxdctl;
 
@@ -1561,9 +1560,9 @@ static void wx_configure_rx_ring(struct wx *wx,
 	memset(ring->rx_buffer_info, 0,
 	       sizeof(struct wx_rx_buffer) * ring->count);
 
-	/* initialize Rx descriptor 0 */
-	rx_desc = WX_RX_DESC(ring, 0);
-	rx_desc->wb.upper.length = 0;
+	/* reset ntu and ntc to place SW in sync with hardware */
+	ring->next_to_clean = 0;
+	ring->next_to_use = 0;
 
 	/* enable receive descriptor ring */
 	wr32m(wx, WX_PX_RR_CFG(reg_idx),
@@ -2356,6 +2355,8 @@ void wx_update_stats(struct wx *wx)
 		hwstats->fdirmiss += rd32(wx, WX_RDB_FDIR_MISS);
 	}
 
+	/* qmprc is not cleared on read, manual reset it */
+	hwstats->qmprc = 0;
 	for (i = 0; i < wx->mac.max_rx_queues; i++)
 		hwstats->qmprc += rd32(wx, WX_PX_MPRC(i));
 }
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index e711797a3a8c..4c203f4afd68 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -172,10 +172,6 @@ static void wx_dma_sync_frag(struct wx_ring *rx_ring,
 				      skb_frag_off(frag),
 				      skb_frag_size(frag),
 				      DMA_FROM_DEVICE);
-
-	/* If the page was released, just unmap it. */
-	if (unlikely(WX_CB(skb)->page_released))
-		page_pool_put_full_page(rx_ring->page_pool, rx_buffer->page, false);
 }
 
 static struct wx_rx_buffer *wx_get_rx_buffer(struct wx_ring *rx_ring,
@@ -225,10 +221,6 @@ static void wx_put_rx_buffer(struct wx_ring *rx_ring,
 			     struct sk_buff *skb,
 			     int rx_buffer_pgcnt)
 {
-	if (!IS_ERR(skb) && WX_CB(skb)->dma == rx_buffer->dma)
-		/* the page has been released from the ring */
-		WX_CB(skb)->page_released = true;
-
 	/* clear contents of rx_buffer */
 	rx_buffer->page = NULL;
 	rx_buffer->skb = NULL;
@@ -313,7 +305,7 @@ static bool wx_alloc_mapped_page(struct wx_ring *rx_ring,
 		return false;
 	dma = page_pool_get_dma_addr(page);
 
-	bi->page_dma = dma;
+	bi->dma = dma;
 	bi->page = page;
 	bi->page_offset = 0;
 
@@ -350,7 +342,7 @@ void wx_alloc_rx_buffers(struct wx_ring *rx_ring, u16 cleaned_count)
 						 DMA_FROM_DEVICE);
 
 		rx_desc->read.pkt_addr =
-			cpu_to_le64(bi->page_dma + bi->page_offset);
+			cpu_to_le64(bi->dma + bi->page_offset);
 
 		rx_desc++;
 		bi++;
@@ -363,6 +355,8 @@ void wx_alloc_rx_buffers(struct wx_ring *rx_ring, u16 cleaned_count)
 
 		/* clear the status bits for the next_to_use descriptor */
 		rx_desc->wb.upper.status_error = 0;
+		/* clear the length for the next_to_use descriptor */
+		rx_desc->wb.upper.length = 0;
 
 		cleaned_count--;
 	} while (cleaned_count);
@@ -2219,9 +2213,6 @@ static void wx_clean_rx_ring(struct wx_ring *rx_ring)
 		if (rx_buffer->skb) {
 			struct sk_buff *skb = rx_buffer->skb;
 
-			if (WX_CB(skb)->page_released)
-				page_pool_put_full_page(rx_ring->page_pool, rx_buffer->page, false);
-
 			dev_kfree_skb(skb);
 		}
 
@@ -2245,6 +2236,9 @@ static void wx_clean_rx_ring(struct wx_ring *rx_ring)
 		}
 	}
 
+	/* Zero out the descriptor ring */
+	memset(rx_ring->desc, 0, rx_ring->size);
+
 	rx_ring->next_to_alloc = 0;
 	rx_ring->next_to_clean = 0;
 	rx_ring->next_to_use = 0;
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index dbac133eacfc..950cacaf095a 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -787,7 +787,6 @@ enum wx_reset_type {
 struct wx_cb {
 	dma_addr_t dma;
 	u16     append_cnt;      /* number of skb's appended */
-	bool    page_released;
 	bool    dma_released;
 };
 
@@ -875,7 +874,6 @@ struct wx_tx_buffer {
 struct wx_rx_buffer {
 	struct sk_buff *skb;
 	dma_addr_t dma;
-	dma_addr_t page_dma;
 	struct page *page;
 	unsigned int page_offset;
 };
diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index 940452d0a4d2..258096543b08 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -285,7 +285,7 @@ static void xemaclite_aligned_read(u32 *src_ptr, u8 *dest_ptr,
 
 		/* Read the remaining data */
 		for (; length > 0; length--)
-			*to_u8_ptr = *from_u8_ptr;
+			*to_u8_ptr++ = *from_u8_ptr++;
 	}
 }
 
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 8ec497023224..4376e116eb9f 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2316,8 +2316,11 @@ static int netvsc_prepare_bonding(struct net_device *vf_netdev)
 	if (!ndev)
 		return NOTIFY_DONE;
 
-	/* set slave flag before open to prevent IPv6 addrconf */
+	/* Set slave flag and no addrconf flag before open
+	 * to prevent IPv6 addrconf.
+	 */
 	vf_netdev->flags |= IFF_SLAVE;
+	vf_netdev->priv_flags |= IFF_NO_ADDRCONF;
 	return NOTIFY_DONE;
 }
 
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 13dea33d86ff..834624a61060 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3663,7 +3663,8 @@ static int phy_probe(struct device *dev)
 	/* Get the LEDs from the device tree, and instantiate standard
 	 * LEDs for them.
 	 */
-	if (IS_ENABLED(CONFIG_PHYLIB_LEDS))
+	if (IS_ENABLED(CONFIG_PHYLIB_LEDS) && !phy_driver_is_genphy(phydev) &&
+	    !phy_driver_is_genphy_10g(phydev))
 		err = of_phy_leds(phydev);
 
 out:
@@ -3680,7 +3681,8 @@ static int phy_remove(struct device *dev)
 
 	cancel_delayed_work_sync(&phydev->state_queue);
 
-	if (IS_ENABLED(CONFIG_PHYLIB_LEDS))
+	if (IS_ENABLED(CONFIG_PHYLIB_LEDS) && !phy_driver_is_genphy(phydev) &&
+	    !phy_driver_is_genphy_10g(phydev))
 		phy_leds_unregister(phydev);
 
 	phydev->state = PHY_DOWN;
diff --git a/drivers/net/usb/sierra_net.c b/drivers/net/usb/sierra_net.c
index 3d239b8d1a1b..52e9fd8116f9 100644
--- a/drivers/net/usb/sierra_net.c
+++ b/drivers/net/usb/sierra_net.c
@@ -689,6 +689,10 @@ static int sierra_net_bind(struct usbnet *dev, struct usb_interface *intf)
 			status);
 		return -ENODEV;
 	}
+	if (!dev->status) {
+		dev_err(&dev->udev->dev, "No status endpoint found");
+		return -ENODEV;
+	}
 	/* Initialize sierra private data */
 	priv = kzalloc(sizeof *priv, GFP_KERNEL);
 	if (!priv)
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 54c5d9a14c67..0408c21bb122 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6802,7 +6802,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 	   otherwise get link status from config. */
 	netif_carrier_off(dev);
 	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
-		virtnet_config_changed_work(&vi->config_work);
+		virtio_config_changed(vi->vdev);
 	} else {
 		vi->status = VIRTIO_NET_S_LINK_UP;
 		virtnet_update_settings(vi);
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index abd42598fc78..9e223574db7f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -375,12 +375,12 @@ static void nvme_log_err_passthru(struct request *req)
 		nr->status & NVME_SC_MASK,	/* Status Code */
 		nr->status & NVME_STATUS_MORE ? "MORE " : "",
 		nr->status & NVME_STATUS_DNR  ? "DNR "  : "",
-		nr->cmd->common.cdw10,
-		nr->cmd->common.cdw11,
-		nr->cmd->common.cdw12,
-		nr->cmd->common.cdw13,
-		nr->cmd->common.cdw14,
-		nr->cmd->common.cdw15);
+		le32_to_cpu(nr->cmd->common.cdw10),
+		le32_to_cpu(nr->cmd->common.cdw11),
+		le32_to_cpu(nr->cmd->common.cdw12),
+		le32_to_cpu(nr->cmd->common.cdw13),
+		le32_to_cpu(nr->cmd->common.cdw14),
+		le32_to_cpu(nr->cmd->common.cdw15));
 }
 
 enum nvme_disposition {
@@ -757,6 +757,10 @@ blk_status_t nvme_fail_nonready_command(struct nvme_ctrl *ctrl,
 	    !test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags) &&
 	    !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
 		return BLK_STS_RESOURCE;
+
+	if (!(rq->rq_flags & RQF_DONTPREP))
+		nvme_clear_nvme_request(rq);
+
 	return nvme_host_path_error(rq);
 }
 EXPORT_SYMBOL_GPL(nvme_fail_nonready_command);
@@ -3854,7 +3858,7 @@ static void nvme_ns_add_to_ctrl_list(struct nvme_ns *ns)
 			return;
 		}
 	}
-	list_add(&ns->list, &ns->ctrl->namespaces);
+	list_add_rcu(&ns->list, &ns->ctrl->namespaces);
 }
 
 static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 259ad77c03c5..6268b18d2456 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1941,10 +1941,10 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 		struct sock *sk = queue->sock->sk;
 
 		/* Restore the default callbacks before starting upcall */
-		read_lock_bh(&sk->sk_callback_lock);
+		write_lock_bh(&sk->sk_callback_lock);
 		sk->sk_user_data = NULL;
 		sk->sk_data_ready = port->data_ready;
-		read_unlock_bh(&sk->sk_callback_lock);
+		write_unlock_bh(&sk->sk_callback_lock);
 		if (!nvmet_tcp_try_peek_pdu(queue)) {
 			if (!nvmet_tcp_tls_handshake(queue))
 				return;
diff --git a/drivers/nvmem/imx-ocotp-ele.c b/drivers/nvmem/imx-ocotp-ele.c
index ca6dd71d8a2e..7807ec0e2d18 100644
--- a/drivers/nvmem/imx-ocotp-ele.c
+++ b/drivers/nvmem/imx-ocotp-ele.c
@@ -12,6 +12,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/if_ether.h>	/* ETH_ALEN */
 
 enum fuse_type {
 	FUSE_FSB = BIT(0),
@@ -118,9 +119,11 @@ static int imx_ocotp_cell_pp(void *context, const char *id, int index,
 	int i;
 
 	/* Deal with some post processing of nvmem cell data */
-	if (id && !strcmp(id, "mac-address"))
+	if (id && !strcmp(id, "mac-address")) {
+		bytes = min(bytes, ETH_ALEN);
 		for (i = 0; i < bytes / 2; i++)
 			swap(buf[i], buf[bytes - i - 1]);
+	}
 
 	return 0;
 }
diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index 79dd4fda0329..7bf7656d4f96 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -23,6 +23,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/if_ether.h>	/* ETH_ALEN */
 
 #define IMX_OCOTP_OFFSET_B0W0		0x400 /* Offset from base address of the
 					       * OTP Bank0 Word0
@@ -227,9 +228,11 @@ static int imx_ocotp_cell_pp(void *context, const char *id, int index,
 	int i;
 
 	/* Deal with some post processing of nvmem cell data */
-	if (id && !strcmp(id, "mac-address"))
+	if (id && !strcmp(id, "mac-address")) {
+		bytes = min(bytes, ETH_ALEN);
 		for (i = 0; i < bytes / 2; i++)
 			swap(buf[i], buf[bytes - i - 1]);
+	}
 
 	return 0;
 }
diff --git a/drivers/nvmem/layouts/u-boot-env.c b/drivers/nvmem/layouts/u-boot-env.c
index 731e6f4f12b2..21f6dcf905dd 100644
--- a/drivers/nvmem/layouts/u-boot-env.c
+++ b/drivers/nvmem/layouts/u-boot-env.c
@@ -92,7 +92,7 @@ int u_boot_env_parse(struct device *dev, struct nvmem_device *nvmem,
 	size_t crc32_data_offset;
 	size_t crc32_data_len;
 	size_t crc32_offset;
-	__le32 *crc32_addr;
+	uint32_t *crc32_addr;
 	size_t data_offset;
 	size_t data_len;
 	size_t dev_size;
@@ -143,8 +143,8 @@ int u_boot_env_parse(struct device *dev, struct nvmem_device *nvmem,
 		goto err_kfree;
 	}
 
-	crc32_addr = (__le32 *)(buf + crc32_offset);
-	crc32 = le32_to_cpu(*crc32_addr);
+	crc32_addr = (uint32_t *)(buf + crc32_offset);
+	crc32 = *crc32_addr;
 	crc32_data_len = dev_size - crc32_data_offset;
 	data_len = dev_size - data_offset;
 
diff --git a/drivers/phy/tegra/xusb-tegra186.c b/drivers/phy/tegra/xusb-tegra186.c
index 23a23f2d64e5..e818f6c3980e 100644
--- a/drivers/phy/tegra/xusb-tegra186.c
+++ b/drivers/phy/tegra/xusb-tegra186.c
@@ -648,14 +648,15 @@ static void tegra186_utmi_bias_pad_power_on(struct tegra_xusb_padctl *padctl)
 		udelay(100);
 	}
 
-	if (padctl->soc->trk_hw_mode) {
-		value = padctl_readl(padctl, XUSB_PADCTL_USB2_BIAS_PAD_CTL2);
-		value |= USB2_TRK_HW_MODE;
+	value = padctl_readl(padctl, XUSB_PADCTL_USB2_BIAS_PAD_CTL2);
+	if (padctl->soc->trk_update_on_idle)
 		value &= ~CYA_TRK_CODE_UPDATE_ON_IDLE;
-		padctl_writel(padctl, value, XUSB_PADCTL_USB2_BIAS_PAD_CTL2);
-	} else {
+	if (padctl->soc->trk_hw_mode)
+		value |= USB2_TRK_HW_MODE;
+	padctl_writel(padctl, value, XUSB_PADCTL_USB2_BIAS_PAD_CTL2);
+
+	if (!padctl->soc->trk_hw_mode)
 		clk_disable_unprepare(priv->usb2_trk_clk);
-	}
 }
 
 static void tegra186_utmi_bias_pad_power_off(struct tegra_xusb_padctl *padctl)
@@ -782,13 +783,15 @@ static int tegra186_xusb_padctl_vbus_override(struct tegra_xusb_padctl *padctl,
 }
 
 static int tegra186_xusb_padctl_id_override(struct tegra_xusb_padctl *padctl,
-					    bool status)
+					    struct tegra_xusb_usb2_port *port, bool status)
 {
-	u32 value;
+	u32 value, id_override;
+	int err = 0;
 
 	dev_dbg(padctl->dev, "%s id override\n", status ? "set" : "clear");
 
 	value = padctl_readl(padctl, USB2_VBUS_ID);
+	id_override = value & ID_OVERRIDE(~0);
 
 	if (status) {
 		if (value & VBUS_OVERRIDE) {
@@ -799,15 +802,35 @@ static int tegra186_xusb_padctl_id_override(struct tegra_xusb_padctl *padctl,
 			value = padctl_readl(padctl, USB2_VBUS_ID);
 		}
 
-		value &= ~ID_OVERRIDE(~0);
-		value |= ID_OVERRIDE_GROUNDED;
+		if (id_override != ID_OVERRIDE_GROUNDED) {
+			value &= ~ID_OVERRIDE(~0);
+			value |= ID_OVERRIDE_GROUNDED;
+			padctl_writel(padctl, value, USB2_VBUS_ID);
+
+			err = regulator_enable(port->supply);
+			if (err) {
+				dev_err(padctl->dev, "Failed to enable regulator: %d\n", err);
+				return err;
+			}
+		}
 	} else {
-		value &= ~ID_OVERRIDE(~0);
-		value |= ID_OVERRIDE_FLOATING;
+		if (id_override == ID_OVERRIDE_GROUNDED) {
+			/*
+			 * The regulator is disabled only when the role transitions
+			 * from USB_ROLE_HOST to USB_ROLE_NONE.
+			 */
+			err = regulator_disable(port->supply);
+			if (err) {
+				dev_err(padctl->dev, "Failed to disable regulator: %d\n", err);
+				return err;
+			}
+
+			value &= ~ID_OVERRIDE(~0);
+			value |= ID_OVERRIDE_FLOATING;
+			padctl_writel(padctl, value, USB2_VBUS_ID);
+		}
 	}
 
-	padctl_writel(padctl, value, USB2_VBUS_ID);
-
 	return 0;
 }
 
@@ -826,27 +849,20 @@ static int tegra186_utmi_phy_set_mode(struct phy *phy, enum phy_mode mode,
 
 	if (mode == PHY_MODE_USB_OTG) {
 		if (submode == USB_ROLE_HOST) {
-			tegra186_xusb_padctl_id_override(padctl, true);
-
-			err = regulator_enable(port->supply);
+			err = tegra186_xusb_padctl_id_override(padctl, port, true);
+			if (err)
+				goto out;
 		} else if (submode == USB_ROLE_DEVICE) {
 			tegra186_xusb_padctl_vbus_override(padctl, true);
 		} else if (submode == USB_ROLE_NONE) {
-			/*
-			 * When port is peripheral only or role transitions to
-			 * USB_ROLE_NONE from USB_ROLE_DEVICE, regulator is not
-			 * enabled.
-			 */
-			if (regulator_is_enabled(port->supply))
-				regulator_disable(port->supply);
-
-			tegra186_xusb_padctl_id_override(padctl, false);
+			err = tegra186_xusb_padctl_id_override(padctl, port, false);
+			if (err)
+				goto out;
 			tegra186_xusb_padctl_vbus_override(padctl, false);
 		}
 	}
-
+out:
 	mutex_unlock(&padctl->lock);
-
 	return err;
 }
 
@@ -1710,7 +1726,8 @@ const struct tegra_xusb_padctl_soc tegra234_xusb_padctl_soc = {
 	.num_supplies = ARRAY_SIZE(tegra194_xusb_padctl_supply_names),
 	.supports_gen2 = true,
 	.poll_trk_completed = true,
-	.trk_hw_mode = true,
+	.trk_hw_mode = false,
+	.trk_update_on_idle = true,
 	.supports_lp_cfg_en = true,
 };
 EXPORT_SYMBOL_GPL(tegra234_xusb_padctl_soc);
diff --git a/drivers/phy/tegra/xusb.h b/drivers/phy/tegra/xusb.h
index 6e45d194c689..d2b5f9565132 100644
--- a/drivers/phy/tegra/xusb.h
+++ b/drivers/phy/tegra/xusb.h
@@ -434,6 +434,7 @@ struct tegra_xusb_padctl_soc {
 	bool need_fake_usb3_port;
 	bool poll_trk_completed;
 	bool trk_hw_mode;
+	bool trk_update_on_idle;
 	bool supports_lp_cfg_en;
 };
 
diff --git a/drivers/pmdomain/governor.c b/drivers/pmdomain/governor.c
index d1a10eeebd16..600592f19669 100644
--- a/drivers/pmdomain/governor.c
+++ b/drivers/pmdomain/governor.c
@@ -8,6 +8,7 @@
 #include <linux/pm_domain.h>
 #include <linux/pm_qos.h>
 #include <linux/hrtimer.h>
+#include <linux/cpu.h>
 #include <linux/cpuidle.h>
 #include <linux/cpumask.h>
 #include <linux/ktime.h>
@@ -349,6 +350,8 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
 	struct cpuidle_device *dev;
 	ktime_t domain_wakeup, next_hrtimer;
 	ktime_t now = ktime_get();
+	struct device *cpu_dev;
+	s64 cpu_constraint, global_constraint;
 	s64 idle_duration_ns;
 	int cpu, i;
 
@@ -359,6 +362,7 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
 	if (!(genpd->flags & GENPD_FLAG_CPU_DOMAIN))
 		return true;
 
+	global_constraint = cpu_latency_qos_limit();
 	/*
 	 * Find the next wakeup for any of the online CPUs within the PM domain
 	 * and its subdomains. Note, we only need the genpd->cpus, as it already
@@ -372,8 +376,16 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
 			if (ktime_before(next_hrtimer, domain_wakeup))
 				domain_wakeup = next_hrtimer;
 		}
+
+		cpu_dev = get_cpu_device(cpu);
+		if (cpu_dev) {
+			cpu_constraint = dev_pm_qos_raw_resume_latency(cpu_dev);
+			if (cpu_constraint < global_constraint)
+				global_constraint = cpu_constraint;
+		}
 	}
 
+	global_constraint *= NSEC_PER_USEC;
 	/* The minimum idle duration is from now - until the next wakeup. */
 	idle_duration_ns = ktime_to_ns(ktime_sub(domain_wakeup, now));
 	if (idle_duration_ns <= 0)
@@ -389,8 +401,10 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
 	 */
 	i = genpd->state_idx;
 	do {
-		if (idle_duration_ns >= (genpd->states[i].residency_ns +
-		    genpd->states[i].power_off_latency_ns)) {
+		if ((idle_duration_ns >= (genpd->states[i].residency_ns +
+		    genpd->states[i].power_off_latency_ns)) &&
+		    (global_constraint >= (genpd->states[i].power_on_latency_ns +
+		    genpd->states[i].power_off_latency_ns))) {
 			genpd->state_idx = i;
 			return true;
 		}
diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index d2e63277f0aa..54db2abc2e2a 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -58,6 +58,7 @@ struct aspeed_lpc_snoop_model_data {
 };
 
 struct aspeed_lpc_snoop_channel {
+	bool enabled;
 	struct kfifo		fifo;
 	wait_queue_head_t	wq;
 	struct miscdevice	miscdev;
@@ -190,6 +191,9 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 	const struct aspeed_lpc_snoop_model_data *model_data =
 		of_device_get_match_data(dev);
 
+	if (WARN_ON(lpc_snoop->chan[channel].enabled))
+		return -EBUSY;
+
 	init_waitqueue_head(&lpc_snoop->chan[channel].wq);
 	/* Create FIFO datastructure */
 	rc = kfifo_alloc(&lpc_snoop->chan[channel].fifo,
@@ -236,6 +240,8 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 		regmap_update_bits(lpc_snoop->regmap, HICRB,
 				hicrb_en, hicrb_en);
 
+	lpc_snoop->chan[channel].enabled = true;
+
 	return 0;
 
 err_misc_deregister:
@@ -248,6 +254,9 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 static void aspeed_lpc_disable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 				     int channel)
 {
+	if (!lpc_snoop->chan[channel].enabled)
+		return;
+
 	switch (channel) {
 	case 0:
 		regmap_update_bits(lpc_snoop->regmap, HICR5,
@@ -263,8 +272,10 @@ static void aspeed_lpc_disable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 		return;
 	}
 
-	kfifo_free(&lpc_snoop->chan[channel].fifo);
+	lpc_snoop->chan[channel].enabled = false;
+	/* Consider improving safety wrt concurrent reader(s) */
 	misc_deregister(&lpc_snoop->chan[channel].miscdev);
+	kfifo_free(&lpc_snoop->chan[channel].fifo);
 }
 
 static int aspeed_lpc_snoop_probe(struct platform_device *pdev)
diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index e3d5e6c1d582..1895fba5e70b 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -187,7 +187,7 @@ static u64 amd_sdw_send_cmd_get_resp(struct amd_sdw_manager *amd_manager, u32 lo
 
 	if (sts & AMD_SDW_IMM_RES_VALID) {
 		dev_err(amd_manager->dev, "SDW%x manager is in bad state\n", amd_manager->instance);
-		writel(0x00, amd_manager->mmio + ACP_SW_IMM_CMD_STS);
+		writel(AMD_SDW_IMM_RES_VALID, amd_manager->mmio + ACP_SW_IMM_CMD_STS);
 	}
 	writel(upper_data, amd_manager->mmio + ACP_SW_IMM_CMD_UPPER_WORD);
 	writel(lower_data, amd_manager->mmio + ACP_SW_IMM_CMD_LOWER_QWORD);
@@ -1107,9 +1107,11 @@ static int __maybe_unused amd_suspend(struct device *dev)
 	}
 
 	if (amd_manager->power_mode_mask & AMD_SDW_CLK_STOP_MODE) {
+		cancel_work_sync(&amd_manager->amd_sdw_work);
 		amd_sdw_wake_enable(amd_manager, false);
 		return amd_sdw_clock_stop(amd_manager);
 	} else if (amd_manager->power_mode_mask & AMD_SDW_POWER_OFF_MODE) {
+		cancel_work_sync(&amd_manager->amd_sdw_work);
 		amd_sdw_wake_enable(amd_manager, false);
 		/*
 		 * As per hardware programming sequence on AMD platforms,
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 0f3e6e2c2474..8d6341b0d866 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -4141,10 +4141,13 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 				xfer->tx_nbits != SPI_NBITS_OCTAL)
 				return -EINVAL;
 			if ((xfer->tx_nbits == SPI_NBITS_DUAL) &&
-				!(spi->mode & (SPI_TX_DUAL | SPI_TX_QUAD)))
+				!(spi->mode & (SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL)))
 				return -EINVAL;
 			if ((xfer->tx_nbits == SPI_NBITS_QUAD) &&
-				!(spi->mode & SPI_TX_QUAD))
+				!(spi->mode & (SPI_TX_QUAD | SPI_TX_OCTAL)))
+				return -EINVAL;
+			if ((xfer->tx_nbits == SPI_NBITS_OCTAL) &&
+				!(spi->mode & SPI_TX_OCTAL))
 				return -EINVAL;
 		}
 		/* Check transfer rx_nbits */
@@ -4157,10 +4160,13 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 				xfer->rx_nbits != SPI_NBITS_OCTAL)
 				return -EINVAL;
 			if ((xfer->rx_nbits == SPI_NBITS_DUAL) &&
-				!(spi->mode & (SPI_RX_DUAL | SPI_RX_QUAD)))
+				!(spi->mode & (SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL)))
 				return -EINVAL;
 			if ((xfer->rx_nbits == SPI_NBITS_QUAD) &&
-				!(spi->mode & SPI_RX_QUAD))
+				!(spi->mode & (SPI_RX_QUAD | SPI_RX_OCTAL)))
+				return -EINVAL;
+			if ((xfer->rx_nbits == SPI_NBITS_OCTAL) &&
+				!(spi->mode & SPI_RX_OCTAL))
 				return -EINVAL;
 		}
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 1a9432646b70..97787002080a 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -588,6 +588,29 @@ static int vchiq_platform_init(struct platform_device *pdev, struct vchiq_state
 	return 0;
 }
 
+int
+vchiq_platform_init_state(struct vchiq_state *state)
+{
+	struct vchiq_arm_state *platform_state;
+
+	platform_state = devm_kzalloc(state->dev, sizeof(*platform_state), GFP_KERNEL);
+	if (!platform_state)
+		return -ENOMEM;
+
+	rwlock_init(&platform_state->susp_res_lock);
+
+	init_completion(&platform_state->ka_evt);
+	atomic_set(&platform_state->ka_use_count, 0);
+	atomic_set(&platform_state->ka_use_ack_count, 0);
+	atomic_set(&platform_state->ka_release_count, 0);
+
+	platform_state->state = state;
+
+	state->platform_state = (struct opaque_platform_state *)platform_state;
+
+	return 0;
+}
+
 static struct vchiq_arm_state *vchiq_platform_get_arm_state(struct vchiq_state *state)
 {
 	return (struct vchiq_arm_state *)state->platform_state;
@@ -1335,39 +1358,6 @@ vchiq_keepalive_thread_func(void *v)
 	return 0;
 }
 
-int
-vchiq_platform_init_state(struct vchiq_state *state)
-{
-	struct vchiq_arm_state *platform_state;
-	char threadname[16];
-
-	platform_state = devm_kzalloc(state->dev, sizeof(*platform_state), GFP_KERNEL);
-	if (!platform_state)
-		return -ENOMEM;
-
-	snprintf(threadname, sizeof(threadname), "vchiq-keep/%d",
-		 state->id);
-	platform_state->ka_thread = kthread_create(&vchiq_keepalive_thread_func,
-						   (void *)state, threadname);
-	if (IS_ERR(platform_state->ka_thread)) {
-		dev_err(state->dev, "couldn't create thread %s\n", threadname);
-		return PTR_ERR(platform_state->ka_thread);
-	}
-
-	rwlock_init(&platform_state->susp_res_lock);
-
-	init_completion(&platform_state->ka_evt);
-	atomic_set(&platform_state->ka_use_count, 0);
-	atomic_set(&platform_state->ka_use_ack_count, 0);
-	atomic_set(&platform_state->ka_release_count, 0);
-
-	platform_state->state = state;
-
-	state->platform_state = (struct opaque_platform_state *)platform_state;
-
-	return 0;
-}
-
 int
 vchiq_use_internal(struct vchiq_state *state, struct vchiq_service *service,
 		   enum USE_TYPE_E use_type)
@@ -1688,6 +1678,7 @@ void vchiq_platform_conn_state_changed(struct vchiq_state *state,
 				       enum vchiq_connstate newstate)
 {
 	struct vchiq_arm_state *arm_state = vchiq_platform_get_arm_state(state);
+	char threadname[16];
 
 	dev_dbg(state->dev, "suspend: %d: %s->%s\n",
 		state->id, get_conn_state_name(oldstate), get_conn_state_name(newstate));
@@ -1702,7 +1693,17 @@ void vchiq_platform_conn_state_changed(struct vchiq_state *state,
 
 	arm_state->first_connect = 1;
 	write_unlock_bh(&arm_state->susp_res_lock);
-	wake_up_process(arm_state->ka_thread);
+	snprintf(threadname, sizeof(threadname), "vchiq-keep/%d",
+		 state->id);
+	arm_state->ka_thread = kthread_create(&vchiq_keepalive_thread_func,
+					      (void *)state,
+					      threadname);
+	if (IS_ERR(arm_state->ka_thread)) {
+		dev_err(state->dev, "suspend: Couldn't create thread %s\n",
+			threadname);
+	} else {
+		wake_up_process(arm_state->ka_thread);
+	}
 }
 
 static const struct of_device_id vchiq_of_match[] = {
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 6a2116cbb06f..60818c1bec48 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -1450,7 +1450,7 @@ int tb_dp_port_set_hops(struct tb_port *port, unsigned int video,
 		return ret;
 
 	data[0] &= ~ADP_DP_CS_0_VIDEO_HOPID_MASK;
-	data[1] &= ~ADP_DP_CS_1_AUX_RX_HOPID_MASK;
+	data[1] &= ~ADP_DP_CS_1_AUX_TX_HOPID_MASK;
 	data[1] &= ~ADP_DP_CS_1_AUX_RX_HOPID_MASK;
 
 	data[0] |= (video << ADP_DP_CS_0_VIDEO_HOPID_SHIFT) &
@@ -3437,7 +3437,7 @@ void tb_sw_set_unplugged(struct tb_switch *sw)
 	}
 }
 
-static int tb_switch_set_wake(struct tb_switch *sw, unsigned int flags)
+static int tb_switch_set_wake(struct tb_switch *sw, unsigned int flags, bool runtime)
 {
 	if (flags)
 		tb_sw_dbg(sw, "enabling wakeup: %#x\n", flags);
@@ -3445,7 +3445,7 @@ static int tb_switch_set_wake(struct tb_switch *sw, unsigned int flags)
 		tb_sw_dbg(sw, "disabling wakeup\n");
 
 	if (tb_switch_is_usb4(sw))
-		return usb4_switch_set_wake(sw, flags);
+		return usb4_switch_set_wake(sw, flags, runtime);
 	return tb_lc_set_wake(sw, flags);
 }
 
@@ -3521,7 +3521,7 @@ int tb_switch_resume(struct tb_switch *sw, bool runtime)
 		tb_switch_check_wakes(sw);
 
 	/* Disable wakes */
-	tb_switch_set_wake(sw, 0);
+	tb_switch_set_wake(sw, 0, true);
 
 	err = tb_switch_tmu_init(sw);
 	if (err)
@@ -3602,7 +3602,7 @@ void tb_switch_suspend(struct tb_switch *sw, bool runtime)
 		flags |= TB_WAKE_ON_USB4 | TB_WAKE_ON_USB3 | TB_WAKE_ON_PCIE;
 	}
 
-	tb_switch_set_wake(sw, flags);
+	tb_switch_set_wake(sw, flags, runtime);
 
 	if (tb_switch_is_usb4(sw))
 		usb4_switch_set_sleep(sw);
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 6737188f2581..2a701f94af12 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -1299,7 +1299,7 @@ int usb4_switch_read_uid(struct tb_switch *sw, u64 *uid);
 int usb4_switch_drom_read(struct tb_switch *sw, unsigned int address, void *buf,
 			  size_t size);
 bool usb4_switch_lane_bonding_possible(struct tb_switch *sw);
-int usb4_switch_set_wake(struct tb_switch *sw, unsigned int flags);
+int usb4_switch_set_wake(struct tb_switch *sw, unsigned int flags, bool runtime);
 int usb4_switch_set_sleep(struct tb_switch *sw);
 int usb4_switch_nvm_sector_size(struct tb_switch *sw);
 int usb4_switch_nvm_read(struct tb_switch *sw, unsigned int address, void *buf,
diff --git a/drivers/thunderbolt/usb4.c b/drivers/thunderbolt/usb4.c
index 57821b6f4e46..9eacde552f81 100644
--- a/drivers/thunderbolt/usb4.c
+++ b/drivers/thunderbolt/usb4.c
@@ -403,12 +403,12 @@ bool usb4_switch_lane_bonding_possible(struct tb_switch *sw)
  * usb4_switch_set_wake() - Enabled/disable wake
  * @sw: USB4 router
  * @flags: Wakeup flags (%0 to disable)
+ * @runtime: Wake is being programmed during system runtime
  *
  * Enables/disables router to wake up from sleep.
  */
-int usb4_switch_set_wake(struct tb_switch *sw, unsigned int flags)
+int usb4_switch_set_wake(struct tb_switch *sw, unsigned int flags, bool runtime)
 {
-	struct usb4_port *usb4;
 	struct tb_port *port;
 	u64 route = tb_route(sw);
 	u32 val;
@@ -438,13 +438,11 @@ int usb4_switch_set_wake(struct tb_switch *sw, unsigned int flags)
 			val |= PORT_CS_19_WOU4;
 		} else {
 			bool configured = val & PORT_CS_19_PC;
-			usb4 = port->usb4;
+			bool wakeup = runtime || device_may_wakeup(&port->usb4->dev);
 
-			if (((flags & TB_WAKE_ON_CONNECT) &&
-			      device_may_wakeup(&usb4->dev)) && !configured)
+			if ((flags & TB_WAKE_ON_CONNECT) && wakeup && !configured)
 				val |= PORT_CS_19_WOC;
-			if (((flags & TB_WAKE_ON_DISCONNECT) &&
-			      device_may_wakeup(&usb4->dev)) && configured)
+			if ((flags & TB_WAKE_ON_DISCONNECT) && wakeup && configured)
 				val |= PORT_CS_19_WOD;
 			if ((flags & TB_WAKE_ON_USB4) && configured)
 				val |= PORT_CS_19_WOU4;
diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index c7cee5fee603..70676e3247ab 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -954,7 +954,7 @@ static unsigned int dma_handle_tx(struct eg20t_port *priv)
 			__func__);
 		return 0;
 	}
-	dma_sync_sg_for_device(port->dev, priv->sg_tx_p, nent, DMA_TO_DEVICE);
+	dma_sync_sg_for_device(port->dev, priv->sg_tx_p, num, DMA_TO_DEVICE);
 	priv->desc_tx = desc;
 	desc->callback = pch_dma_tx_complete;
 	desc->callback_param = priv;
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index da6da5ec4237..090b3a757112 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -67,6 +67,12 @@
  */
 #define USB_SHORT_SET_ADDRESS_REQ_TIMEOUT	500  /* ms */
 
+/*
+ * Give SS hubs 200ms time after wake to train downstream links before
+ * assuming no port activity and allowing hub to runtime suspend back.
+ */
+#define USB_SS_PORT_U0_WAKE_TIME	200  /* ms */
+
 /* Protect struct usb_device->state and ->children members
  * Note: Both are also protected by ->dev.sem, except that ->state can
  * change to USB_STATE_NOTATTACHED even when the semaphore isn't held. */
@@ -1094,6 +1100,7 @@ static void hub_activate(struct usb_hub *hub, enum hub_activation_type type)
 			goto init2;
 		goto init3;
 	}
+
 	hub_get(hub);
 
 	/* The superspeed hub except for root hub has to use Hub Depth
@@ -1342,6 +1349,17 @@ static void hub_activate(struct usb_hub *hub, enum hub_activation_type type)
 		device_unlock(&hdev->dev);
 	}
 
+	if (type == HUB_RESUME && hub_is_superspeed(hub->hdev)) {
+		/* give usb3 downstream links training time after hub resume */
+		usb_autopm_get_interface_no_resume(
+			to_usb_interface(hub->intfdev));
+
+		queue_delayed_work(system_power_efficient_wq,
+				   &hub->post_resume_work,
+				   msecs_to_jiffies(USB_SS_PORT_U0_WAKE_TIME));
+		return;
+	}
+
 	hub_put(hub);
 }
 
@@ -1360,6 +1378,14 @@ static void hub_init_func3(struct work_struct *ws)
 	hub_activate(hub, HUB_INIT3);
 }
 
+static void hub_post_resume(struct work_struct *ws)
+{
+	struct usb_hub *hub = container_of(ws, struct usb_hub, post_resume_work.work);
+
+	usb_autopm_put_interface_async(to_usb_interface(hub->intfdev));
+	hub_put(hub);
+}
+
 enum hub_quiescing_type {
 	HUB_DISCONNECT, HUB_PRE_RESET, HUB_SUSPEND
 };
@@ -1385,6 +1411,7 @@ static void hub_quiesce(struct usb_hub *hub, enum hub_quiescing_type type)
 
 	/* Stop hub_wq and related activity */
 	del_timer_sync(&hub->irq_urb_retry);
+	flush_delayed_work(&hub->post_resume_work);
 	usb_kill_urb(hub->urb);
 	if (hub->has_indicators)
 		cancel_delayed_work_sync(&hub->leds);
@@ -1943,6 +1970,7 @@ static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	hub->hdev = hdev;
 	INIT_DELAYED_WORK(&hub->leds, led_work);
 	INIT_DELAYED_WORK(&hub->init_work, NULL);
+	INIT_DELAYED_WORK(&hub->post_resume_work, hub_post_resume);
 	INIT_WORK(&hub->events, hub_event);
 	INIT_LIST_HEAD(&hub->onboard_devs);
 	spin_lock_init(&hub->irq_urb_lock);
@@ -5721,6 +5749,7 @@ static void port_event(struct usb_hub *hub, int port1)
 	struct usb_device *hdev = hub->hdev;
 	u16 portstatus, portchange;
 	int i = 0;
+	int err;
 
 	connect_change = test_bit(port1, hub->change_bits);
 	clear_bit(port1, hub->event_bits);
@@ -5817,8 +5846,11 @@ static void port_event(struct usb_hub *hub, int port1)
 		} else if (!udev || !(portstatus & USB_PORT_STAT_CONNECTION)
 				|| udev->state == USB_STATE_NOTATTACHED) {
 			dev_dbg(&port_dev->dev, "do warm reset, port only\n");
-			if (hub_port_reset(hub, port1, NULL,
-					HUB_BH_RESET_TIME, true) < 0)
+			err = hub_port_reset(hub, port1, NULL,
+					     HUB_BH_RESET_TIME, true);
+			if (!udev && err == -ENOTCONN)
+				connect_change = 0;
+			else if (err < 0)
 				hub_port_disable(hub, port1, 1);
 		} else {
 			dev_dbg(&port_dev->dev, "do warm reset, full device\n");
diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
index e6ae73f8a95d..9ebc5ef54a32 100644
--- a/drivers/usb/core/hub.h
+++ b/drivers/usb/core/hub.h
@@ -70,6 +70,7 @@ struct usb_hub {
 	u8			indicator[USB_MAXCHILDREN];
 	struct delayed_work	leds;
 	struct delayed_work	init_work;
+	struct delayed_work	post_resume_work;
 	struct work_struct      events;
 	spinlock_t		irq_urb_lock;
 	struct timer_list	irq_urb_retry;
diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index d3d0d75ab1f5..834fc02610a2 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -5352,20 +5352,34 @@ int dwc2_gadget_enter_hibernation(struct dwc2_hsotg *hsotg)
 	if (gusbcfg & GUSBCFG_ULPI_UTMI_SEL) {
 		/* ULPI interface */
 		gpwrdn |= GPWRDN_ULPI_LATCH_EN_DURING_HIB_ENTRY;
-	}
-	dwc2_writel(hsotg, gpwrdn, GPWRDN);
-	udelay(10);
+		dwc2_writel(hsotg, gpwrdn, GPWRDN);
+		udelay(10);
 
-	/* Suspend the Phy Clock */
-	pcgcctl = dwc2_readl(hsotg, PCGCTL);
-	pcgcctl |= PCGCTL_STOPPCLK;
-	dwc2_writel(hsotg, pcgcctl, PCGCTL);
-	udelay(10);
+		/* Suspend the Phy Clock */
+		pcgcctl = dwc2_readl(hsotg, PCGCTL);
+		pcgcctl |= PCGCTL_STOPPCLK;
+		dwc2_writel(hsotg, pcgcctl, PCGCTL);
+		udelay(10);
 
-	gpwrdn = dwc2_readl(hsotg, GPWRDN);
-	gpwrdn |= GPWRDN_PMUACTV;
-	dwc2_writel(hsotg, gpwrdn, GPWRDN);
-	udelay(10);
+		gpwrdn = dwc2_readl(hsotg, GPWRDN);
+		gpwrdn |= GPWRDN_PMUACTV;
+		dwc2_writel(hsotg, gpwrdn, GPWRDN);
+		udelay(10);
+	} else {
+		/* UTMI+ Interface */
+		dwc2_writel(hsotg, gpwrdn, GPWRDN);
+		udelay(10);
+
+		gpwrdn = dwc2_readl(hsotg, GPWRDN);
+		gpwrdn |= GPWRDN_PMUACTV;
+		dwc2_writel(hsotg, gpwrdn, GPWRDN);
+		udelay(10);
+
+		pcgcctl = dwc2_readl(hsotg, PCGCTL);
+		pcgcctl |= PCGCTL_STOPPCLK;
+		dwc2_writel(hsotg, pcgcctl, PCGCTL);
+		udelay(10);
+	}
 
 	/* Set flag to indicate that we are in hibernation */
 	hsotg->hibernated = 1;
diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index c1d4b52f25b0..6c79303891d1 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -763,13 +763,13 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 	ret = reset_control_deassert(qcom->resets);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to deassert resets, err=%d\n", ret);
-		goto reset_assert;
+		return ret;
 	}
 
 	ret = dwc3_qcom_clk_init(qcom, of_clk_get_parent_count(np));
 	if (ret) {
 		dev_err_probe(dev, ret, "failed to get clocks\n");
-		goto reset_assert;
+		return ret;
 	}
 
 	qcom->qscratch_base = devm_platform_ioremap_resource(pdev, 0);
@@ -835,8 +835,6 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 		clk_disable_unprepare(qcom->clks[i]);
 		clk_put(qcom->clks[i]);
 	}
-reset_assert:
-	reset_control_assert(qcom->resets);
 
 	return ret;
 }
@@ -857,8 +855,6 @@ static void dwc3_qcom_remove(struct platform_device *pdev)
 	qcom->num_clocks = 0;
 
 	dwc3_qcom_interconnect_exit(qcom);
-	reset_control_assert(qcom->resets);
-
 	pm_runtime_allow(dev);
 	pm_runtime_disable(dev);
 }
diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
index 29390d573e23..1b4d0056f1d0 100644
--- a/drivers/usb/gadget/configfs.c
+++ b/drivers/usb/gadget/configfs.c
@@ -1065,6 +1065,8 @@ static ssize_t webusb_landingPage_store(struct config_item *item, const char *pa
 	unsigned int bytes_to_strip = 0;
 	int l = len;
 
+	if (!len)
+		return len;
 	if (page[l - 1] == '\n') {
 		--l;
 		++bytes_to_strip;
@@ -1188,6 +1190,8 @@ static ssize_t os_desc_qw_sign_store(struct config_item *item, const char *page,
 	struct gadget_info *gi = os_desc_item_to_gadget_info(item);
 	int res, l;
 
+	if (!len)
+		return len;
 	l = min((int)len, OS_STRING_QW_SIGN_LEN >> 1);
 	if (page[l - 1] == '\n')
 		--l;
diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index c6076df0d50c..da2b864fdadf 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1912,6 +1912,7 @@ static int musb_gadget_stop(struct usb_gadget *g)
 	 * gadget driver here and have everything work;
 	 * that currently misbehaves.
 	 */
+	usb_gadget_set_state(g, USB_STATE_NOTATTACHED);
 
 	/* Force check of devctl register for PM runtime */
 	pm_runtime_mark_last_busy(musb->controller);
@@ -2018,6 +2019,7 @@ void musb_g_disconnect(struct musb *musb)
 	case OTG_STATE_B_PERIPHERAL:
 	case OTG_STATE_B_IDLE:
 		musb_set_state(musb, OTG_STATE_B_IDLE);
+		usb_gadget_set_state(&musb->g, USB_STATE_NOTATTACHED);
 		break;
 	case OTG_STATE_B_SRP_INIT:
 		break;
diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index eef614be7db5..4f21d75f5877 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -803,6 +803,8 @@ static const struct usb_device_id id_table_combined[] = {
 		.driver_info = (kernel_ulong_t)&ftdi_NDI_device_quirk },
 	{ USB_DEVICE(FTDI_VID, FTDI_NDI_AURORA_SCU_PID),
 		.driver_info = (kernel_ulong_t)&ftdi_NDI_device_quirk },
+	{ USB_DEVICE(FTDI_NDI_VID, FTDI_NDI_EMGUIDE_GEMINI_PID),
+		.driver_info = (kernel_ulong_t)&ftdi_NDI_device_quirk },
 	{ USB_DEVICE(TELLDUS_VID, TELLDUS_TELLSTICK_PID) },
 	{ USB_DEVICE(NOVITUS_VID, NOVITUS_BONO_E_PID) },
 	{ USB_DEVICE(FTDI_VID, RTSYSTEMS_USB_VX8_PID) },
diff --git a/drivers/usb/serial/ftdi_sio_ids.h b/drivers/usb/serial/ftdi_sio_ids.h
index 9acb6f837327..4cc1fae8acb9 100644
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -204,6 +204,9 @@
 #define FTDI_NDI_FUTURE_3_PID		0xDA73	/* NDI future device #3 */
 #define FTDI_NDI_AURORA_SCU_PID		0xDA74	/* NDI Aurora SCU */
 
+#define FTDI_NDI_VID			0x23F2
+#define FTDI_NDI_EMGUIDE_GEMINI_PID	0x0003	/* NDI Emguide Gemini */
+
 /*
  * ChamSys Limited (www.chamsys.co.uk) USB wing/interface product IDs
  */
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 27879cc57536..147ca50c94be 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1415,6 +1415,9 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = NCTRL(5) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10d0, 0xff, 0xff, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10d0, 0xff, 0xff, 0x60) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10c7, 0xff, 0xff, 0x30),	/* Telit FE910C04 (ECM) */
+	  .driver_info = NCTRL(4) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10c7, 0xff, 0xff, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10d1, 0xff, 0xff, 0x30),	/* Telit FN990B (MBIM) */
 	  .driver_info = NCTRL(6) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10d1, 0xff, 0xff, 0x40) },
@@ -2343,6 +2346,8 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x0489, 0xe145, 0xff),			/* Foxconn T99W651 RNDIS */
 	  .driver_info = RSVD(5) | RSVD(6) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x0489, 0xe167, 0xff),                     /* Foxconn T99W640 MBIM */
+	  .driver_info = RSVD(3) },
 	{ USB_DEVICE(0x1508, 0x1001),						/* Fibocom NL668 (IOT version) */
 	  .driver_info = RSVD(4) | RSVD(5) | RSVD(6) },
 	{ USB_DEVICE(0x1782, 0x4d10) },						/* Fibocom L610 (AT mode) */
diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index aa8656c8b7e7..dd35e29d8082 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2780,8 +2780,11 @@ void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans)
 		/* Already aborted the transaction if it failed. */
 next:
 		btrfs_dec_delayed_refs_rsv_bg_inserts(fs_info);
+
+		spin_lock(&fs_info->unused_bgs_lock);
 		list_del_init(&block_group->bg_list);
 		clear_bit(BLOCK_GROUP_FLAG_NEW, &block_group->runtime_flags);
+		spin_unlock(&fs_info->unused_bgs_lock);
 
 		/*
 		 * If the block group is still unused, add it to the list of
diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 6a821a959b59..6c378b230de2 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -346,8 +346,6 @@ int __cachefiles_write(struct cachefiles_object *object,
 	default:
 		ki->was_async = false;
 		cachefiles_write_complete(&ki->iocb, ret);
-		if (ret > 0)
-			ret = 0;
 		break;
 	}
 
diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index fe3de9ad57bf..00e1f2471b9e 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -83,10 +83,8 @@ static ssize_t cachefiles_ondemand_fd_write_iter(struct kiocb *kiocb,
 
 	trace_cachefiles_ondemand_fd_write(object, file_inode(file), pos, len);
 	ret = __cachefiles_write(object, file, pos, iter, NULL, NULL);
-	if (!ret) {
-		ret = len;
+	if (ret > 0)
 		kiocb->ki_pos += ret;
-	}
 
 out:
 	fput(file);
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index beba15673be8..11ebddc57bc7 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -354,10 +354,16 @@ static int efivarfs_reconfigure(struct fs_context *fc)
 	return 0;
 }
 
+static void efivarfs_free(struct fs_context *fc)
+{
+	kfree(fc->s_fs_info);
+}
+
 static const struct fs_context_operations efivarfs_context_ops = {
 	.get_tree	= efivarfs_get_tree,
 	.parse_param	= efivarfs_parse_param,
 	.reconfigure	= efivarfs_reconfigure,
+	.free		= efivarfs_free,
 };
 
 static int efivarfs_init_fs_context(struct fs_context *fc)
diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index d5da9817df9b..33e6a620c103 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -1440,9 +1440,16 @@ static int isofs_read_inode(struct inode *inode, int relocated)
 		inode->i_op = &page_symlink_inode_operations;
 		inode_nohighmem(inode);
 		inode->i_data.a_ops = &isofs_symlink_aops;
-	} else
+	} else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
+		   S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
 		/* XXX - parse_rock_ridge_inode() had already set i_rdev. */
 		init_special_inode(inode, inode->i_mode, inode->i_rdev);
+	} else {
+		printk(KERN_DEBUG "ISOFS: Invalid file type 0%04o for inode %lu.\n",
+			inode->i_mode, inode->i_ino);
+		ret = -EIO;
+		goto fail;
+	}
 
 	ret = 0;
 out:
diff --git a/fs/namespace.c b/fs/namespace.c
index b5c5cf01d0c4..bb1560b0d25c 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2263,6 +2263,11 @@ struct vfsmount *clone_private_mount(const struct path *path)
 	if (!check_mnt(old_mnt))
 		goto invalid;
 
+	if (!ns_capable(old_mnt->mnt_ns->user_ns, CAP_SYS_ADMIN)) {
+		up_read(&namespace_sem);
+		return ERR_PTR(-EPERM);
+	}
+
 	if (has_locked_children(old_mnt, path->dentry))
 		goto invalid;
 
diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
index d5dbef7f5c95..0539c2a328c7 100644
--- a/fs/notify/dnotify/dnotify.c
+++ b/fs/notify/dnotify/dnotify.c
@@ -309,6 +309,10 @@ int fcntl_dirnotify(int fd, struct file *filp, unsigned int arg)
 		goto out_err;
 	}
 
+	error = file_f_owner_allocate(filp);
+	if (error)
+		goto out_err;
+
 	/* new fsnotify mark, we expect most fcntl calls to add a new mark */
 	new_dn_mark = kmem_cache_alloc(dnotify_mark_cache, GFP_KERNEL);
 	if (!new_dn_mark) {
@@ -316,10 +320,6 @@ int fcntl_dirnotify(int fd, struct file *filp, unsigned int arg)
 		goto out_err;
 	}
 
-	error = file_f_owner_allocate(filp);
-	if (error)
-		goto out_err;
-
 	/* set up the new_fsn_mark and new_dn_mark */
 	new_fsn_mark = &new_dn_mark->fsn_mark;
 	fsnotify_init_mark(new_fsn_mark, dnotify_group);
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 0f6fec042f6a..166dc8fd06c0 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -3076,7 +3076,8 @@ void cifs_oplock_break(struct work_struct *work)
 	struct cifsFileInfo *cfile = container_of(work, struct cifsFileInfo,
 						  oplock_break);
 	struct inode *inode = d_inode(cfile->dentry);
-	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
+	struct super_block *sb = inode->i_sb;
+	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
 	struct cifsInodeInfo *cinode = CIFS_I(inode);
 	struct cifs_tcon *tcon;
 	struct TCP_Server_Info *server;
@@ -3086,6 +3087,12 @@ void cifs_oplock_break(struct work_struct *work)
 	__u64 persistent_fid, volatile_fid;
 	__u16 net_fid;
 
+	/*
+	 * Hold a reference to the superblock to prevent it and its inodes from
+	 * being freed while we are accessing cinode. Otherwise, _cifsFileInfo_put()
+	 * may release the last reference to the sb and trigger inode eviction.
+	 */
+	cifs_sb_active(sb);
 	wait_on_bit(&cinode->flags, CIFS_INODE_PENDING_WRITERS,
 			TASK_UNINTERRUPTIBLE);
 
@@ -3158,6 +3165,7 @@ void cifs_oplock_break(struct work_struct *work)
 	cifs_put_tlink(tlink);
 out:
 	cifs_done_oplock_break(cinode);
+	cifs_sb_deactive(sb);
 }
 
 static int cifs_swap_activate(struct swap_info_struct *sis,
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index e596bc4837b6..78a546ef69e8 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -4342,6 +4342,7 @@ crypt_message(struct TCP_Server_Info *server, int num_rqst,
 	u8 key[SMB3_ENC_DEC_KEY_SIZE];
 	struct aead_request *req;
 	u8 *iv;
+	DECLARE_CRYPTO_WAIT(wait);
 	unsigned int crypt_len = le32_to_cpu(tr_hdr->OriginalMessageSize);
 	void *creq;
 	size_t sensitive_size;
@@ -4392,7 +4393,11 @@ crypt_message(struct TCP_Server_Info *server, int num_rqst,
 	aead_request_set_crypt(req, sg, sg, crypt_len, iv);
 	aead_request_set_ad(req, assoc_data_len);
 
-	rc = enc ? crypto_aead_encrypt(req) : crypto_aead_decrypt(req);
+	aead_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
+				  crypto_req_done, &wait);
+
+	rc = crypto_wait_req(enc ? crypto_aead_encrypt(req)
+				: crypto_aead_decrypt(req), &wait);
 
 	if (!rc && enc)
 		memcpy(&tr_hdr->Signature, sign, SMB2_SIGNATURE_SIZE);
diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
index ac06f2617f34..754e94a0e07f 100644
--- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -907,8 +907,10 @@ static int smbd_post_send_iter(struct smbd_connection *info,
 			.local_dma_lkey	= sc->ib.pd->local_dma_lkey,
 			.direction	= DMA_TO_DEVICE,
 		};
+		size_t payload_len = umin(*_remaining_data_length,
+					  sp->max_send_size - sizeof(*packet));
 
-		rc = smb_extract_iter_to_rdma(iter, *_remaining_data_length,
+		rc = smb_extract_iter_to_rdma(iter, payload_len,
 					      &extract);
 		if (rc < 0)
 			goto err_dma;
@@ -1013,6 +1015,27 @@ static int smbd_post_send_empty(struct smbd_connection *info)
 	return smbd_post_send_iter(info, NULL, &remaining_data_length);
 }
 
+static int smbd_post_send_full_iter(struct smbd_connection *info,
+				    struct iov_iter *iter,
+				    int *_remaining_data_length)
+{
+	int rc = 0;
+
+	/*
+	 * smbd_post_send_iter() respects the
+	 * negotiated max_send_size, so we need to
+	 * loop until the full iter is posted
+	 */
+
+	while (iov_iter_count(iter) > 0) {
+		rc = smbd_post_send_iter(info, iter, _remaining_data_length);
+		if (rc < 0)
+			break;
+	}
+
+	return rc;
+}
+
 /*
  * Post a receive request to the transport
  * The remote peer can only send data when a receive request is posted
@@ -1962,14 +1985,14 @@ int smbd_send(struct TCP_Server_Info *server,
 			klen += rqst->rq_iov[i].iov_len;
 		iov_iter_kvec(&iter, ITER_SOURCE, rqst->rq_iov, rqst->rq_nvec, klen);
 
-		rc = smbd_post_send_iter(info, &iter, &remaining_data_length);
+		rc = smbd_post_send_full_iter(info, &iter, &remaining_data_length);
 		if (rc < 0)
 			break;
 
 		if (iov_iter_count(&rqst->rq_iter) > 0) {
 			/* And then the data pages if there are any */
-			rc = smbd_post_send_iter(info, &rqst->rq_iter,
-						 &remaining_data_length);
+			rc = smbd_post_send_full_iter(info, &rqst->rq_iter,
+						      &remaining_data_length);
 			if (rc < 0)
 				break;
 		}
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 730aa0245aef..3d1d7296aed9 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -817,20 +817,20 @@ extern struct mutex hci_cb_list_lock;
 #define hci_dev_test_and_clear_flag(hdev, nr)  test_and_clear_bit((nr), (hdev)->dev_flags)
 #define hci_dev_test_and_change_flag(hdev, nr) test_and_change_bit((nr), (hdev)->dev_flags)
 
-#define hci_dev_clear_volatile_flags(hdev)			\
-	do {							\
-		hci_dev_clear_flag(hdev, HCI_LE_SCAN);		\
-		hci_dev_clear_flag(hdev, HCI_LE_ADV);		\
-		hci_dev_clear_flag(hdev, HCI_LL_RPA_RESOLUTION);\
-		hci_dev_clear_flag(hdev, HCI_PERIODIC_INQ);	\
-		hci_dev_clear_flag(hdev, HCI_QUALITY_REPORT);	\
+#define hci_dev_clear_volatile_flags(hdev)				\
+	do {								\
+		hci_dev_clear_flag((hdev), HCI_LE_SCAN);		\
+		hci_dev_clear_flag((hdev), HCI_LE_ADV);			\
+		hci_dev_clear_flag((hdev), HCI_LL_RPA_RESOLUTION);	\
+		hci_dev_clear_flag((hdev), HCI_PERIODIC_INQ);		\
+		hci_dev_clear_flag((hdev), HCI_QUALITY_REPORT);		\
 	} while (0)
 
 #define hci_dev_le_state_simultaneous(hdev) \
-	(!test_bit(HCI_QUIRK_BROKEN_LE_STATES, &hdev->quirks) && \
-	 (hdev->le_states[4] & 0x08) &&	/* Central */ \
-	 (hdev->le_states[4] & 0x40) &&	/* Peripheral */ \
-	 (hdev->le_states[3] & 0x10))	/* Simultaneous */
+	(!test_bit(HCI_QUIRK_BROKEN_LE_STATES, &(hdev)->quirks) && \
+	 ((hdev)->le_states[4] & 0x08) &&	/* Central */ \
+	 ((hdev)->le_states[4] & 0x40) &&	/* Peripheral */ \
+	 ((hdev)->le_states[3] & 0x10))		/* Simultaneous */
 
 /* ----- HCI interface to upper protocols ----- */
 int l2cap_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr);
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 8a712ca73f2b..bb1862536f9c 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2710,7 +2710,7 @@ struct cfg80211_scan_request {
 	s8 tsf_report_link_id;
 
 	/* keep last */
-	struct ieee80211_channel *channels[] __counted_by(n_channels);
+	struct ieee80211_channel *channels[];
 };
 
 static inline void get_random_mask_addr(u8 *buf, const u8 *addr, const u8 *mask)
diff --git a/include/net/netfilter/nf_conntrack.h b/include/net/netfilter/nf_conntrack.h
index cba3ccf03fcc..8cb70e7485e2 100644
--- a/include/net/netfilter/nf_conntrack.h
+++ b/include/net/netfilter/nf_conntrack.h
@@ -308,8 +308,19 @@ static inline bool nf_ct_is_expired(const struct nf_conn *ct)
 /* use after obtaining a reference count */
 static inline bool nf_ct_should_gc(const struct nf_conn *ct)
 {
-	return nf_ct_is_expired(ct) && nf_ct_is_confirmed(ct) &&
-	       !nf_ct_is_dying(ct);
+	if (!nf_ct_is_confirmed(ct))
+		return false;
+
+	/* load ct->timeout after is_confirmed() test.
+	 * Pairs with __nf_conntrack_confirm() which:
+	 * 1. Increases ct->timeout value
+	 * 2. Inserts ct into rcu hlist
+	 * 3. Sets the confirmed bit
+	 * 4. Unlocks the hlist lock
+	 */
+	smp_acquire__after_ctrl_dep();
+
+	return nf_ct_is_expired(ct) && !nf_ct_is_dying(ct);
 }
 
 #define	NF_CT_DAY	(86400 * HZ)
diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index e1a37e9c2d42..eea3769765ac 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -282,12 +282,15 @@
 	EM(rxrpc_call_put_userid,		"PUT user-id ") \
 	EM(rxrpc_call_see_accept,		"SEE accept  ") \
 	EM(rxrpc_call_see_activate_client,	"SEE act-clnt") \
+	EM(rxrpc_call_see_already_released,	"SEE alrdy-rl") \
 	EM(rxrpc_call_see_connect_failed,	"SEE con-fail") \
 	EM(rxrpc_call_see_connected,		"SEE connect ") \
 	EM(rxrpc_call_see_conn_abort,		"SEE conn-abt") \
+	EM(rxrpc_call_see_discard,		"SEE discard ") \
 	EM(rxrpc_call_see_disconnected,		"SEE disconn ") \
 	EM(rxrpc_call_see_distribute_error,	"SEE dist-err") \
 	EM(rxrpc_call_see_input,		"SEE input   ") \
+	EM(rxrpc_call_see_recvmsg,		"SEE recvmsg ") \
 	EM(rxrpc_call_see_release,		"SEE release ") \
 	EM(rxrpc_call_see_userid_exists,	"SEE u-exists") \
 	EM(rxrpc_call_see_waiting_call,		"SEE q-conn  ") \
diff --git a/io_uring/net.c b/io_uring/net.c
index 0116cfaec848..356f95c33aa2 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -1735,9 +1735,11 @@ int io_connect(struct io_kiocb *req, unsigned int issue_flags)
 	int ret;
 	bool force_nonblock = issue_flags & IO_URING_F_NONBLOCK;
 
-	if (unlikely(req->flags & REQ_F_FAIL)) {
-		ret = -ECONNRESET;
-		goto out;
+	if (connect->in_progress) {
+		struct poll_table_struct pt = { ._key = EPOLLERR };
+
+		if (vfs_poll(req->file, &pt) & EPOLLERR)
+			goto get_sock_err;
 	}
 
 	file_flags = force_nonblock ? O_NONBLOCK : 0;
@@ -1762,8 +1764,10 @@ int io_connect(struct io_kiocb *req, unsigned int issue_flags)
 		 * which means the previous result is good. For both of these,
 		 * grab the sock_error() and use that for the completion.
 		 */
-		if (ret == -EBADFD || ret == -EISCONN)
+		if (ret == -EBADFD || ret == -EISCONN) {
+get_sock_err:
 			ret = sock_error(sock_from_file(req->file)->sk);
+		}
 	}
 	if (ret == -ERESTARTSYS)
 		ret = -EINTR;
diff --git a/io_uring/poll.c b/io_uring/poll.c
index b93e9ebdd87c..17dea8aa09c9 100644
--- a/io_uring/poll.c
+++ b/io_uring/poll.c
@@ -315,8 +315,6 @@ static int io_poll_check_events(struct io_kiocb *req, struct io_tw_state *ts)
 				return IOU_POLL_REISSUE;
 			}
 		}
-		if (unlikely(req->cqe.res & EPOLLERR))
-			req_set_fail(req);
 		if (req->apoll_events & EPOLLONESHOT)
 			return IOU_POLL_DONE;
 
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 9173d107758d..6cf165c55bda 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -883,6 +883,13 @@ int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
 		if (fmt[i] == 'p') {
 			sizeof_cur_arg = sizeof(long);
 
+			if (fmt[i + 1] == 0 || isspace(fmt[i + 1]) ||
+			    ispunct(fmt[i + 1])) {
+				if (tmp_buf)
+					cur_arg = raw_args[num_spec];
+				goto nocopy_fmt;
+			}
+
 			if ((fmt[i + 1] == 'k' || fmt[i + 1] == 'u') &&
 			    fmt[i + 2] == 's') {
 				fmt_ptype = fmt[i + 1];
@@ -890,11 +897,9 @@ int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
 				goto fmt_str;
 			}
 
-			if (fmt[i + 1] == 0 || isspace(fmt[i + 1]) ||
-			    ispunct(fmt[i + 1]) || fmt[i + 1] == 'K' ||
+			if (fmt[i + 1] == 'K' ||
 			    fmt[i + 1] == 'x' || fmt[i + 1] == 's' ||
 			    fmt[i + 1] == 'S') {
-				/* just kernel pointers */
 				if (tmp_buf)
 					cur_arg = raw_args[num_spec];
 				i++;
diff --git a/kernel/cgroup/legacy_freezer.c b/kernel/cgroup/legacy_freezer.c
index 01c02d116e8e..c37888b7d25a 100644
--- a/kernel/cgroup/legacy_freezer.c
+++ b/kernel/cgroup/legacy_freezer.c
@@ -66,15 +66,9 @@ static struct freezer *parent_freezer(struct freezer *freezer)
 bool cgroup_freezing(struct task_struct *task)
 {
 	bool ret;
-	unsigned int state;
 
 	rcu_read_lock();
-	/* Check if the cgroup is still FREEZING, but not FROZEN. The extra
-	 * !FROZEN check is required, because the FREEZING bit is not cleared
-	 * when the state FROZEN is reached.
-	 */
-	state = task_freezer(task)->state;
-	ret = (state & CGROUP_FREEZING) && !(state & CGROUP_FROZEN);
+	ret = task_freezer(task)->state & CGROUP_FREEZING;
 	rcu_read_unlock();
 
 	return ret;
diff --git a/kernel/freezer.c b/kernel/freezer.c
index 8d530d0949ff..6a96149aede9 100644
--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -201,18 +201,9 @@ static int __restore_freezer_state(struct task_struct *p, void *arg)
 
 void __thaw_task(struct task_struct *p)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&freezer_lock, flags);
-	if (WARN_ON_ONCE(freezing(p)))
-		goto unlock;
-
-	if (!frozen(p) || task_call_func(p, __restore_freezer_state, NULL))
-		goto unlock;
-
-	wake_up_state(p, TASK_FROZEN);
-unlock:
-	spin_unlock_irqrestore(&freezer_lock, flags);
+	guard(spinlock_irqsave)(&freezer_lock);
+	if (frozen(p) && !task_call_func(p, __restore_freezer_state, NULL))
+		wake_up_state(p, TASK_FROZEN);
 }
 
 /**
diff --git a/kernel/sched/loadavg.c b/kernel/sched/loadavg.c
index c48900b856a2..52ca8e268cfc 100644
--- a/kernel/sched/loadavg.c
+++ b/kernel/sched/loadavg.c
@@ -80,7 +80,7 @@ long calc_load_fold_active(struct rq *this_rq, long adjust)
 	long nr_active, delta = 0;
 
 	nr_active = this_rq->nr_running - adjust;
-	nr_active += (int)this_rq->nr_uninterruptible;
+	nr_active += (long)this_rq->nr_uninterruptible;
 
 	if (nr_active != this_rq->calc_load_active) {
 		delta = nr_active - this_rq->calc_load_active;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e7f5ab21221c..a441990fe808 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1156,7 +1156,7 @@ struct rq {
 	 * one CPU and if it got migrated afterwards it may decrease
 	 * it on another CPU. Always updated under the runqueue lock:
 	 */
-	unsigned int		nr_uninterruptible;
+	unsigned long 		nr_uninterruptible;
 
 	struct task_struct __rcu	*curr;
 	struct sched_dl_entity	*dl_server;
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 15fb255733fb..dbea76058863 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2879,7 +2879,10 @@ __register_event(struct trace_event_call *call, struct module *mod)
 	if (ret < 0)
 		return ret;
 
+	down_write(&trace_event_sem);
 	list_add(&call->list, &ftrace_events);
+	up_write(&trace_event_sem);
+
 	if (call->flags & TRACE_EVENT_FL_DYNAMIC)
 		atomic_set(&call->refcnt, 0);
 	else
@@ -3471,6 +3474,8 @@ __trace_add_event_dirs(struct trace_array *tr)
 	struct trace_event_call *call;
 	int ret;
 
+	lockdep_assert_held(&trace_event_sem);
+
 	list_for_each_entry(call, &ftrace_events, list) {
 		ret = __trace_add_new_event(call, tr);
 		if (ret < 0)
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index a94790f5cda7..216247913980 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -665,8 +665,8 @@ __timerlat_dump_stack(struct trace_buffer *buffer, struct trace_stack *fstack, u
 
 	entry = ring_buffer_event_data(event);
 
-	memcpy(&entry->caller, fstack->calls, size);
 	entry->size = fstack->nr_entries;
+	memcpy(&entry->caller, fstack->calls, size);
 
 	if (!call_filter_check_discard(call, entry, buffer, event))
 		trace_buffer_unlock_commit_nostack(buffer, event);
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index ae20ad7f7461..055f5164bd96 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -657,7 +657,7 @@ static int parse_btf_arg(char *varname,
 		ret = query_btf_context(ctx);
 		if (ret < 0 || ctx->nr_params == 0) {
 			trace_probe_log_err(ctx->offset, NO_BTF_ENTRY);
-			return PTR_ERR(params);
+			return -ENOENT;
 		}
 	}
 	params = ctx->params;
diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
index 41be38264493..49a6d49c23dc 100644
--- a/net/8021q/vlan.c
+++ b/net/8021q/vlan.c
@@ -358,6 +358,35 @@ static int __vlan_device_event(struct net_device *dev, unsigned long event)
 	return err;
 }
 
+static void vlan_vid0_add(struct net_device *dev)
+{
+	struct vlan_info *vlan_info;
+	int err;
+
+	if (!(dev->features & NETIF_F_HW_VLAN_CTAG_FILTER))
+		return;
+
+	pr_info("adding VLAN 0 to HW filter on device %s\n", dev->name);
+
+	err = vlan_vid_add(dev, htons(ETH_P_8021Q), 0);
+	if (err)
+		return;
+
+	vlan_info = rtnl_dereference(dev->vlan_info);
+	vlan_info->auto_vid0 = true;
+}
+
+static void vlan_vid0_del(struct net_device *dev)
+{
+	struct vlan_info *vlan_info = rtnl_dereference(dev->vlan_info);
+
+	if (!vlan_info || !vlan_info->auto_vid0)
+		return;
+
+	vlan_info->auto_vid0 = false;
+	vlan_vid_del(dev, htons(ETH_P_8021Q), 0);
+}
+
 static int vlan_device_event(struct notifier_block *unused, unsigned long event,
 			     void *ptr)
 {
@@ -379,15 +408,10 @@ static int vlan_device_event(struct notifier_block *unused, unsigned long event,
 			return notifier_from_errno(err);
 	}
 
-	if ((event == NETDEV_UP) &&
-	    (dev->features & NETIF_F_HW_VLAN_CTAG_FILTER)) {
-		pr_info("adding VLAN 0 to HW filter on device %s\n",
-			dev->name);
-		vlan_vid_add(dev, htons(ETH_P_8021Q), 0);
-	}
-	if (event == NETDEV_DOWN &&
-	    (dev->features & NETIF_F_HW_VLAN_CTAG_FILTER))
-		vlan_vid_del(dev, htons(ETH_P_8021Q), 0);
+	if (event == NETDEV_UP)
+		vlan_vid0_add(dev);
+	else if (event == NETDEV_DOWN)
+		vlan_vid0_del(dev);
 
 	vlan_info = rtnl_dereference(dev->vlan_info);
 	if (!vlan_info)
diff --git a/net/8021q/vlan.h b/net/8021q/vlan.h
index 5eaf38875554..c7ffe591d593 100644
--- a/net/8021q/vlan.h
+++ b/net/8021q/vlan.h
@@ -33,6 +33,7 @@ struct vlan_info {
 	struct vlan_group	grp;
 	struct list_head	vid_list;
 	unsigned int		nr_vids;
+	bool			auto_vid0;
 	struct rcu_head		rcu;
 };
 
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index bc01135e43f3..bbd809414b2f 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6789,8 +6789,8 @@ int hci_get_random_address(struct hci_dev *hdev, bool require_privacy,
 		return 0;
 	}
 
-	/* No privacy so use a public address. */
-	*own_addr_type = ADDR_LE_DEV_PUBLIC;
+	/* No privacy, use the current address */
+	hci_copy_identity_address(hdev, rand_addr, own_addr_type);
 
 	return 0;
 }
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 0628fedc0e29..7dafc3e0a15a 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3485,12 +3485,28 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
 		/* Configure output options and let the other side know
 		 * which ones we don't like. */
 
-		/* If MTU is not provided in configure request, use the most recently
-		 * explicitly or implicitly accepted value for the other direction,
-		 * or the default value.
+		/* If MTU is not provided in configure request, try adjusting it
+		 * to the current output MTU if it has been set
+		 *
+		 * Bluetooth Core 6.1, Vol 3, Part A, Section 4.5
+		 *
+		 * Each configuration parameter value (if any is present) in an
+		 * L2CAP_CONFIGURATION_RSP packet reflects an ‘adjustment’ to a
+		 * configuration parameter value that has been sent (or, in case
+		 * of default values, implied) in the corresponding
+		 * L2CAP_CONFIGURATION_REQ packet.
 		 */
-		if (mtu == 0)
-			mtu = chan->imtu ? chan->imtu : L2CAP_DEFAULT_MTU;
+		if (!mtu) {
+			/* Only adjust for ERTM channels as for older modes the
+			 * remote stack may not be able to detect that the
+			 * adjustment causing it to silently drop packets.
+			 */
+			if (chan->mode == L2CAP_MODE_ERTM &&
+			    chan->omtu && chan->omtu != L2CAP_DEFAULT_MTU)
+				mtu = chan->omtu;
+			else
+				mtu = L2CAP_DEFAULT_MTU;
+		}
 
 		if (mtu < L2CAP_DEFAULT_MIN_MTU)
 			result = L2CAP_CONF_UNACCEPT;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index acd11b268b98..615c18e290ab 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1690,6 +1690,9 @@ static void l2cap_sock_resume_cb(struct l2cap_chan *chan)
 {
 	struct sock *sk = chan->data;
 
+	if (!sk)
+		return;
+
 	if (test_and_clear_bit(FLAG_PENDING_SECURITY, &chan->flags)) {
 		sk->sk_state = BT_CONNECTED;
 		chan->state = BT_CONNECTED;
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 8b9724fd752a..a31971fe2fd7 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1379,7 +1379,7 @@ static void smp_timeout(struct work_struct *work)
 
 	bt_dev_dbg(conn->hcon->hdev, "conn %p", conn);
 
-	hci_disconnect(conn->hcon, HCI_ERROR_REMOTE_USER_TERM);
+	hci_disconnect(conn->hcon, HCI_ERROR_AUTH_FAILURE);
 }
 
 static struct smp_chan *smp_chan_create(struct l2cap_conn *conn)
@@ -2977,8 +2977,25 @@ static int smp_sig_channel(struct l2cap_chan *chan, struct sk_buff *skb)
 	if (code > SMP_CMD_MAX)
 		goto drop;
 
-	if (smp && !test_and_clear_bit(code, &smp->allow_cmd))
+	if (smp && !test_and_clear_bit(code, &smp->allow_cmd)) {
+		/* If there is a context and the command is not allowed consider
+		 * it a failure so the session is cleanup properly.
+		 */
+		switch (code) {
+		case SMP_CMD_IDENT_INFO:
+		case SMP_CMD_IDENT_ADDR_INFO:
+		case SMP_CMD_SIGN_INFO:
+			/* 3.6.1. Key distribution and generation
+			 *
+			 * A device may reject a distributed key by sending the
+			 * Pairing Failed command with the reason set to
+			 * "Key Rejected".
+			 */
+			smp_failure(conn, SMP_KEY_REJECTED);
+			break;
+		}
 		goto drop;
+	}
 
 	/* If we don't have a context the only allowed commands are
 	 * pairing request and security request.
diff --git a/net/bluetooth/smp.h b/net/bluetooth/smp.h
index 87a59ec2c9f0..c5da53dfab04 100644
--- a/net/bluetooth/smp.h
+++ b/net/bluetooth/smp.h
@@ -138,6 +138,7 @@ struct smp_cmd_keypress_notify {
 #define SMP_NUMERIC_COMP_FAILED		0x0c
 #define SMP_BREDR_PAIRING_IN_PROGRESS	0x0d
 #define SMP_CROSS_TRANSP_NOT_ALLOWED	0x0e
+#define SMP_KEY_REJECTED		0x0f
 
 #define SMP_MIN_ENC_KEY_SIZE		7
 #define SMP_MAX_ENC_KEY_SIZE		16
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index 7b41ee8740cb..f10bd6a233dc 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -17,6 +17,9 @@ static bool nbp_switchdev_can_offload_tx_fwd(const struct net_bridge_port *p,
 	if (!static_branch_unlikely(&br_switchdev_tx_fwd_offload))
 		return false;
 
+	if (br_multicast_igmp_type(skb))
+		return false;
+
 	return (p->flags & BR_TX_FWD_OFFLOAD) &&
 	       (p->hwdom != BR_INPUT_SKB_CB(skb)->src_hwdom);
 }
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index e04ebe651c33..3a9c5c14c310 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -355,6 +355,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb,
 		flush |= skb->ip_summed != p->ip_summed;
 		flush |= skb->csum_level != p->csum_level;
 		flush |= NAPI_GRO_CB(p)->count >= 64;
+		skb_set_network_header(skb, skb_gro_receive_network_offset(skb));
 
 		if (flush || skb_gro_receive_list(p, skb))
 			mss = 1;
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 845730184c5d..5de47dd5e909 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -604,6 +604,7 @@ static struct sk_buff *udp_gro_receive_segment(struct list_head *head,
 					NAPI_GRO_CB(skb)->flush = 1;
 					return NULL;
 				}
+				skb_set_network_header(skb, skb_gro_receive_network_offset(skb));
 				ret = skb_gro_receive_list(p, skb);
 			} else {
 				skb_gro_postpull_rcsum(skb, uh,
diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index b7b62e5a562e..9949554e3211 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -804,8 +804,8 @@ static void mld_del_delrec(struct inet6_dev *idev, struct ifmcaddr6 *im)
 		} else {
 			im->mca_crcount = idev->mc_qrv;
 		}
-		in6_dev_put(pmc->idev);
 		ip6_mc_clear_src(pmc);
+		in6_dev_put(pmc->idev);
 		kfree_rcu(pmc, rcu);
 	}
 }
diff --git a/net/ipv6/rpl_iptunnel.c b/net/ipv6/rpl_iptunnel.c
index 7c05ac846646..eccfa4203e96 100644
--- a/net/ipv6/rpl_iptunnel.c
+++ b/net/ipv6/rpl_iptunnel.c
@@ -129,13 +129,13 @@ static int rpl_do_srh_inline(struct sk_buff *skb, const struct rpl_lwt *rlwt,
 			     struct dst_entry *cache_dst)
 {
 	struct ipv6_rpl_sr_hdr *isrh, *csrh;
-	const struct ipv6hdr *oldhdr;
+	struct ipv6hdr oldhdr;
 	struct ipv6hdr *hdr;
 	unsigned char *buf;
 	size_t hdrlen;
 	int err;
 
-	oldhdr = ipv6_hdr(skb);
+	memcpy(&oldhdr, ipv6_hdr(skb), sizeof(oldhdr));
 
 	buf = kcalloc(struct_size(srh, segments.addr, srh->segments_left), 2, GFP_ATOMIC);
 	if (!buf)
@@ -147,7 +147,7 @@ static int rpl_do_srh_inline(struct sk_buff *skb, const struct rpl_lwt *rlwt,
 	memcpy(isrh, srh, sizeof(*isrh));
 	memcpy(isrh->rpl_segaddr, &srh->rpl_segaddr[1],
 	       (srh->segments_left - 1) * 16);
-	isrh->rpl_segaddr[srh->segments_left - 1] = oldhdr->daddr;
+	isrh->rpl_segaddr[srh->segments_left - 1] = oldhdr.daddr;
 
 	ipv6_rpl_srh_compress(csrh, isrh, &srh->rpl_segaddr[0],
 			      isrh->segments_left - 1);
@@ -169,7 +169,7 @@ static int rpl_do_srh_inline(struct sk_buff *skb, const struct rpl_lwt *rlwt,
 	skb_mac_header_rebuild(skb);
 
 	hdr = ipv6_hdr(skb);
-	memmove(hdr, oldhdr, sizeof(*hdr));
+	memmove(hdr, &oldhdr, sizeof(*hdr));
 	isrh = (void *)hdr + sizeof(*hdr);
 	memcpy(isrh, csrh, hdrlen);
 
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 23949ae2a3a8..a97505b78671 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -979,8 +979,9 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 		if (subflow->mp_join)
 			goto reset;
 		subflow->mp_capable = 0;
+		if (!mptcp_try_fallback(ssk))
+			goto reset;
 		pr_fallback(msk);
-		mptcp_do_fallback(ssk);
 		return false;
 	}
 
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 620264c75dc2..2c8815daf5b0 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -303,8 +303,14 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
 
 	pr_debug("fail_seq=%llu\n", fail_seq);
 
-	if (!READ_ONCE(msk->allow_infinite_fallback))
+	/* After accepting the fail, we can't create any other subflows */
+	spin_lock_bh(&msk->fallback_lock);
+	if (!msk->allow_infinite_fallback) {
+		spin_unlock_bh(&msk->fallback_lock);
 		return;
+	}
+	msk->allow_subflows = false;
+	spin_unlock_bh(&msk->fallback_lock);
 
 	if (!subflow->fail_tout) {
 		pr_debug("send MP_FAIL response and infinite map\n");
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 42b239d9b2b3..d865d08a0c5e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -623,10 +623,9 @@ static bool mptcp_check_data_fin(struct sock *sk)
 
 static void mptcp_dss_corruption(struct mptcp_sock *msk, struct sock *ssk)
 {
-	if (READ_ONCE(msk->allow_infinite_fallback)) {
+	if (mptcp_try_fallback(ssk)) {
 		MPTCP_INC_STATS(sock_net(ssk),
 				MPTCP_MIB_DSSCORRUPTIONFALLBACK);
-		mptcp_do_fallback(ssk);
 	} else {
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSCORRUPTIONRESET);
 		mptcp_subflow_reset(ssk);
@@ -878,7 +877,7 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 static void mptcp_subflow_joined(struct mptcp_sock *msk, struct sock *ssk)
 {
 	mptcp_subflow_ctx(ssk)->map_seq = READ_ONCE(msk->ack_seq);
-	WRITE_ONCE(msk->allow_infinite_fallback, false);
+	msk->allow_infinite_fallback = false;
 	mptcp_event(MPTCP_EVENT_SUB_ESTABLISHED, msk, ssk, GFP_ATOMIC);
 }
 
@@ -889,6 +888,14 @@ static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
 	if (sk->sk_state != TCP_ESTABLISHED)
 		return false;
 
+	spin_lock_bh(&msk->fallback_lock);
+	if (!msk->allow_subflows) {
+		spin_unlock_bh(&msk->fallback_lock);
+		return false;
+	}
+	mptcp_subflow_joined(msk, ssk);
+	spin_unlock_bh(&msk->fallback_lock);
+
 	/* attach to msk socket only after we are sure we will deal with it
 	 * at close time
 	 */
@@ -897,7 +904,6 @@ static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
 
 	mptcp_subflow_ctx(ssk)->subflow_id = msk->subflow_id++;
 	mptcp_sockopt_sync_locked(msk, ssk);
-	mptcp_subflow_joined(msk, ssk);
 	mptcp_stop_tout_timer(sk);
 	__mptcp_propagate_sndbuf(sk, ssk);
 	return true;
@@ -1236,10 +1242,14 @@ static void mptcp_update_infinite_map(struct mptcp_sock *msk,
 	mpext->infinite_map = 1;
 	mpext->data_len = 0;
 
+	if (!mptcp_try_fallback(ssk)) {
+		mptcp_subflow_reset(ssk);
+		return;
+	}
+
 	MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPTX);
 	mptcp_subflow_ctx(ssk)->send_infinite_map = 0;
 	pr_fallback(msk);
-	mptcp_do_fallback(ssk);
 }
 
 #define MPTCP_MAX_GSO_SIZE (GSO_LEGACY_MAX_SIZE - (MAX_TCP_HEADER + 1))
@@ -2643,9 +2653,9 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
 
 static void __mptcp_retrans(struct sock *sk)
 {
+	struct mptcp_sendmsg_info info = { .data_lock_held = true, };
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_subflow_context *subflow;
-	struct mptcp_sendmsg_info info = {};
 	struct mptcp_data_frag *dfrag;
 	struct sock *ssk;
 	int ret, err;
@@ -2690,6 +2700,18 @@ static void __mptcp_retrans(struct sock *sk)
 			info.sent = 0;
 			info.limit = READ_ONCE(msk->csum_enabled) ? dfrag->data_len :
 								    dfrag->already_sent;
+
+			/*
+			 * make the whole retrans decision, xmit, disallow
+			 * fallback atomic
+			 */
+			spin_lock_bh(&msk->fallback_lock);
+			if (__mptcp_check_fallback(msk)) {
+				spin_unlock_bh(&msk->fallback_lock);
+				release_sock(ssk);
+				return;
+			}
+
 			while (info.sent < info.limit) {
 				ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
 				if (ret <= 0)
@@ -2703,8 +2725,9 @@ static void __mptcp_retrans(struct sock *sk)
 				len = max(copied, len);
 				tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
 					 info.size_goal);
-				WRITE_ONCE(msk->allow_infinite_fallback, false);
+				msk->allow_infinite_fallback = false;
 			}
+			spin_unlock_bh(&msk->fallback_lock);
 
 			release_sock(ssk);
 		}
@@ -2833,7 +2856,8 @@ static void __mptcp_init_sock(struct sock *sk)
 	WRITE_ONCE(msk->first, NULL);
 	inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;
 	WRITE_ONCE(msk->csum_enabled, mptcp_is_checksum_enabled(sock_net(sk)));
-	WRITE_ONCE(msk->allow_infinite_fallback, true);
+	msk->allow_infinite_fallback = true;
+	msk->allow_subflows = true;
 	msk->recovery = false;
 	msk->subflow_id = 1;
 	msk->last_data_sent = tcp_jiffies32;
@@ -2841,6 +2865,7 @@ static void __mptcp_init_sock(struct sock *sk)
 	msk->last_ack_recv = tcp_jiffies32;
 
 	mptcp_pm_data_init(msk);
+	spin_lock_init(&msk->fallback_lock);
 
 	/* re-use the csk retrans timer for MPTCP-level retrans */
 	timer_setup(&msk->sk.icsk_retransmit_timer, mptcp_retransmit_timer, 0);
@@ -3224,7 +3249,16 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	 * subflow
 	 */
 	mptcp_destroy_common(msk, MPTCP_CF_FASTCLOSE);
+
+	/* The first subflow is already in TCP_CLOSE status, the following
+	 * can't overlap with a fallback anymore
+	 */
+	spin_lock_bh(&msk->fallback_lock);
+	msk->allow_subflows = true;
+	msk->allow_infinite_fallback = true;
 	WRITE_ONCE(msk->flags, 0);
+	spin_unlock_bh(&msk->fallback_lock);
+
 	msk->cb_flags = 0;
 	msk->recovery = false;
 	WRITE_ONCE(msk->can_ack, false);
@@ -3637,7 +3671,13 @@ bool mptcp_finish_join(struct sock *ssk)
 
 	/* active subflow, already present inside the conn_list */
 	if (!list_empty(&subflow->node)) {
+		spin_lock_bh(&msk->fallback_lock);
+		if (!msk->allow_subflows) {
+			spin_unlock_bh(&msk->fallback_lock);
+			return false;
+		}
 		mptcp_subflow_joined(msk, ssk);
+		spin_unlock_bh(&msk->fallback_lock);
 		mptcp_propagate_sndbuf(parent, ssk);
 		return true;
 	}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7e2f70f22b05..6f191b125978 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -342,10 +342,16 @@ struct mptcp_sock {
 		u64	rtt_us; /* last maximum rtt of subflows */
 	} rcvq_space;
 	u8		scaling_ratio;
+	bool		allow_subflows;
 
 	u32		subflow_id;
 	u32		setsockopt_seq;
 	char		ca_name[TCP_CA_NAME_MAX];
+
+	spinlock_t	fallback_lock;	/* protects fallback,
+					 * allow_infinite_fallback and
+					 * allow_join
+					 */
 };
 
 #define mptcp_data_lock(sk) spin_lock_bh(&(sk)->sk_lock.slock)
@@ -1188,15 +1194,22 @@ static inline bool mptcp_check_fallback(const struct sock *sk)
 	return __mptcp_check_fallback(msk);
 }
 
-static inline void __mptcp_do_fallback(struct mptcp_sock *msk)
+static inline bool __mptcp_try_fallback(struct mptcp_sock *msk)
 {
 	if (__mptcp_check_fallback(msk)) {
 		pr_debug("TCP fallback already done (msk=%p)\n", msk);
-		return;
+		return true;
 	}
-	if (WARN_ON_ONCE(!READ_ONCE(msk->allow_infinite_fallback)))
-		return;
+	spin_lock_bh(&msk->fallback_lock);
+	if (!msk->allow_infinite_fallback) {
+		spin_unlock_bh(&msk->fallback_lock);
+		return false;
+	}
+
+	msk->allow_subflows = false;
 	set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
+	spin_unlock_bh(&msk->fallback_lock);
+	return true;
 }
 
 static inline bool __mptcp_has_initial_subflow(const struct mptcp_sock *msk)
@@ -1208,14 +1221,15 @@ static inline bool __mptcp_has_initial_subflow(const struct mptcp_sock *msk)
 			TCPF_SYN_RECV | TCPF_LISTEN));
 }
 
-static inline void mptcp_do_fallback(struct sock *ssk)
+static inline bool mptcp_try_fallback(struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	struct sock *sk = subflow->conn;
 	struct mptcp_sock *msk;
 
 	msk = mptcp_sk(sk);
-	__mptcp_do_fallback(msk);
+	if (!__mptcp_try_fallback(msk))
+		return false;
 	if (READ_ONCE(msk->snd_data_fin_enable) && !(ssk->sk_shutdown & SEND_SHUTDOWN)) {
 		gfp_t saved_allocation = ssk->sk_allocation;
 
@@ -1227,6 +1241,7 @@ static inline void mptcp_do_fallback(struct sock *ssk)
 		tcp_shutdown(ssk, SEND_SHUTDOWN);
 		ssk->sk_allocation = saved_allocation;
 	}
+	return true;
 }
 
 #define pr_fallback(a) pr_debug("%s:fallback to TCP (msk=%p)\n", __func__, a)
@@ -1236,7 +1251,7 @@ static inline void mptcp_subflow_early_fallback(struct mptcp_sock *msk,
 {
 	pr_fallback(msk);
 	subflow->request_mptcp = 0;
-	__mptcp_do_fallback(msk);
+	WARN_ON_ONCE(!__mptcp_try_fallback(msk));
 }
 
 static inline bool mptcp_check_infinite_map(struct sk_buff *skb)
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 4c2aa45c466d..0253a863a621 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -543,9 +543,11 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 	mptcp_get_options(skb, &mp_opt);
 	if (subflow->request_mptcp) {
 		if (!(mp_opt.suboptions & OPTION_MPTCP_MPC_SYNACK)) {
+			if (!mptcp_try_fallback(sk))
+				goto do_reset;
+
 			MPTCP_INC_STATS(sock_net(sk),
 					MPTCP_MIB_MPCAPABLEACTIVEFALLBACK);
-			mptcp_do_fallback(sk);
 			pr_fallback(msk);
 			goto fallback;
 		}
@@ -1288,20 +1290,29 @@ static void subflow_sched_work_if_closed(struct mptcp_sock *msk, struct sock *ss
 		mptcp_schedule_work(sk);
 }
 
-static void mptcp_subflow_fail(struct mptcp_sock *msk, struct sock *ssk)
+static bool mptcp_subflow_fail(struct mptcp_sock *msk, struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	unsigned long fail_tout;
 
+	/* we are really failing, prevent any later subflow join */
+	spin_lock_bh(&msk->fallback_lock);
+	if (!msk->allow_infinite_fallback) {
+		spin_unlock_bh(&msk->fallback_lock);
+		return false;
+	}
+	msk->allow_subflows = false;
+	spin_unlock_bh(&msk->fallback_lock);
+
 	/* graceful failure can happen only on the MPC subflow */
 	if (WARN_ON_ONCE(ssk != READ_ONCE(msk->first)))
-		return;
+		return false;
 
 	/* since the close timeout take precedence on the fail one,
 	 * no need to start the latter when the first is already set
 	 */
 	if (sock_flag((struct sock *)msk, SOCK_DEAD))
-		return;
+		return true;
 
 	/* we don't need extreme accuracy here, use a zero fail_tout as special
 	 * value meaning no fail timeout at all;
@@ -1313,6 +1324,7 @@ static void mptcp_subflow_fail(struct mptcp_sock *msk, struct sock *ssk)
 	tcp_send_ack(ssk);
 
 	mptcp_reset_tout_timer(msk, subflow->fail_tout);
+	return true;
 }
 
 static bool subflow_check_data_avail(struct sock *ssk)
@@ -1373,17 +1385,16 @@ static bool subflow_check_data_avail(struct sock *ssk)
 		    (subflow->mp_join || subflow->valid_csum_seen)) {
 			subflow->send_mp_fail = 1;
 
-			if (!READ_ONCE(msk->allow_infinite_fallback)) {
+			if (!mptcp_subflow_fail(msk, ssk)) {
 				subflow->reset_transient = 0;
 				subflow->reset_reason = MPTCP_RST_EMIDDLEBOX;
 				goto reset;
 			}
-			mptcp_subflow_fail(msk, ssk);
 			WRITE_ONCE(subflow->data_avail, true);
 			return true;
 		}
 
-		if (!READ_ONCE(msk->allow_infinite_fallback)) {
+		if (!mptcp_try_fallback(ssk)) {
 			/* fatal protocol error, close the socket.
 			 * subflow_error_report() will introduce the appropriate barriers
 			 */
@@ -1399,8 +1410,6 @@ static bool subflow_check_data_avail(struct sock *ssk)
 			WRITE_ONCE(subflow->data_avail, false);
 			return false;
 		}
-
-		mptcp_do_fallback(ssk);
 	}
 
 	skb = skb_peek(&ssk->sk_receive_queue);
@@ -1665,7 +1674,6 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_local *local,
 	/* discard the subflow socket */
 	mptcp_sock_graft(ssk, sk->sk_socket);
 	iput(SOCK_INODE(sf));
-	WRITE_ONCE(msk->allow_infinite_fallback, false);
 	mptcp_stop_tout_timer(sk);
 	return 0;
 
@@ -1845,7 +1853,7 @@ static void subflow_state_change(struct sock *sk)
 
 	msk = mptcp_sk(parent);
 	if (subflow_simultaneous_connect(sk)) {
-		mptcp_do_fallback(sk);
+		WARN_ON_ONCE(!mptcp_try_fallback(sk));
 		pr_fallback(msk);
 		subflow->conn_finished = 1;
 		mptcp_propagate_state(parent, sk, subflow, NULL);
diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index 456446d7af20..f5bde4f13958 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -1121,6 +1121,12 @@ static int nf_ct_resolve_clash_harder(struct sk_buff *skb, u32 repl_idx)
 
 	hlist_nulls_add_head_rcu(&loser_ct->tuplehash[IP_CT_DIR_REPLY].hnnode,
 				 &nf_conntrack_hash[repl_idx]);
+	/* confirmed bit must be set after hlist add, not before:
+	 * loser_ct can still be visible to other cpu due to
+	 * SLAB_TYPESAFE_BY_RCU.
+	 */
+	smp_mb__before_atomic();
+	set_bit(IPS_CONFIRMED_BIT, &loser_ct->status);
 
 	NF_CT_STAT_INC(net, clash_resolve);
 	return NF_ACCEPT;
@@ -1257,8 +1263,6 @@ __nf_conntrack_confirm(struct sk_buff *skb)
 	 * user context, else we insert an already 'dead' hash, blocking
 	 * further use of that particular connection -JM.
 	 */
-	ct->status |= IPS_CONFIRMED;
-
 	if (unlikely(nf_ct_is_dying(ct))) {
 		NF_CT_STAT_INC(net, insert_failed);
 		goto dying;
@@ -1290,7 +1294,7 @@ __nf_conntrack_confirm(struct sk_buff *skb)
 		}
 	}
 
-	/* Timer relative to confirmation time, not original
+	/* Timeout is relative to confirmation time, not original
 	   setting time, otherwise we'd get timer wrap in
 	   weird delay cases. */
 	ct->timeout += nfct_time_stamp;
@@ -1298,11 +1302,21 @@ __nf_conntrack_confirm(struct sk_buff *skb)
 	__nf_conntrack_insert_prepare(ct);
 
 	/* Since the lookup is lockless, hash insertion must be done after
-	 * starting the timer and setting the CONFIRMED bit. The RCU barriers
-	 * guarantee that no other CPU can find the conntrack before the above
-	 * stores are visible.
+	 * setting ct->timeout. The RCU barriers guarantee that no other CPU
+	 * can find the conntrack before the above stores are visible.
 	 */
 	__nf_conntrack_hash_insert(ct, hash, reply_hash);
+
+	/* IPS_CONFIRMED unset means 'ct not (yet) in hash', conntrack lookups
+	 * skip entries that lack this bit.  This happens when a CPU is looking
+	 * at a stale entry that is being recycled due to SLAB_TYPESAFE_BY_RCU
+	 * or when another CPU encounters this entry right after the insertion
+	 * but before the set-confirm-bit below.  This bit must not be set until
+	 * after __nf_conntrack_hash_insert().
+	 */
+	smp_mb__before_atomic();
+	set_bit(IPS_CONFIRMED_BIT, &ct->status);
+
 	nf_conntrack_double_unlock(hash, reply_hash);
 	local_bh_enable();
 
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index f3cecb3e4bcb..19c4c1f27e58 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2784,7 +2784,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 	int len_sum = 0;
 	int status = TP_STATUS_AVAILABLE;
 	int hlen, tlen, copylen = 0;
-	long timeo = 0;
+	long timeo;
 
 	mutex_lock(&po->pg_vec_lock);
 
@@ -2838,22 +2838,28 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 	if ((size_max > dev->mtu + reserve + VLAN_HLEN) && !vnet_hdr_sz)
 		size_max = dev->mtu + reserve + VLAN_HLEN;
 
+	timeo = sock_sndtimeo(&po->sk, msg->msg_flags & MSG_DONTWAIT);
 	reinit_completion(&po->skb_completion);
 
 	do {
 		ph = packet_current_frame(po, &po->tx_ring,
 					  TP_STATUS_SEND_REQUEST);
 		if (unlikely(ph == NULL)) {
-			if (need_wait && skb) {
-				timeo = sock_sndtimeo(&po->sk, msg->msg_flags & MSG_DONTWAIT);
+			/* Note: packet_read_pending() might be slow if we
+			 * have to call it as it's per_cpu variable, but in
+			 * fast-path we don't have to call it, only when ph
+			 * is NULL, we need to check the pending_refcnt.
+			 */
+			if (need_wait && packet_read_pending(&po->tx_ring)) {
 				timeo = wait_for_completion_interruptible_timeout(&po->skb_completion, timeo);
 				if (timeo <= 0) {
 					err = !timeo ? -ETIMEDOUT : -ERESTARTSYS;
 					goto out_put;
 				}
-			}
-			/* check for additional frames */
-			continue;
+				/* check for additional frames */
+				continue;
+			} else
+				break;
 		}
 
 		skb = NULL;
@@ -2942,14 +2948,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 		}
 		packet_increment_head(&po->tx_ring);
 		len_sum += tp_len;
-	} while (likely((ph != NULL) ||
-		/* Note: packet_read_pending() might be slow if we have
-		 * to call it as it's per_cpu variable, but in fast-path
-		 * we already short-circuit the loop with the first
-		 * condition, and luckily don't have to go that path
-		 * anyway.
-		 */
-		 (need_wait && packet_read_pending(&po->tx_ring))));
+	} while (1);
 
 	err = len_sum;
 	goto out_put;
diff --git a/net/phonet/pep.c b/net/phonet/pep.c
index 53a858478e22..62527e1ebb88 100644
--- a/net/phonet/pep.c
+++ b/net/phonet/pep.c
@@ -826,6 +826,7 @@ static struct sock *pep_sock_accept(struct sock *sk,
 	}
 
 	/* Check for duplicate pipe handle */
+	pn_skb_get_dst_sockaddr(skb, &dst);
 	newsk = pep_find_pipe(&pn->hlist, &dst, pipe_handle);
 	if (unlikely(newsk)) {
 		__sock_put(newsk);
@@ -850,7 +851,6 @@ static struct sock *pep_sock_accept(struct sock *sk,
 	newsk->sk_destruct = pipe_destruct;
 
 	newpn = pep_sk(newsk);
-	pn_skb_get_dst_sockaddr(skb, &dst);
 	pn_skb_get_src_sockaddr(skb, &src);
 	newpn->pn_sk.sobject = pn_sockaddr_get_object(&dst);
 	newpn->pn_sk.dobject = pn_sockaddr_get_object(&src);
diff --git a/net/rxrpc/call_accept.c b/net/rxrpc/call_accept.c
index 773bdb2e37da..37ac8a665678 100644
--- a/net/rxrpc/call_accept.c
+++ b/net/rxrpc/call_accept.c
@@ -219,6 +219,7 @@ void rxrpc_discard_prealloc(struct rxrpc_sock *rx)
 	tail = b->call_backlog_tail;
 	while (CIRC_CNT(head, tail, size) > 0) {
 		struct rxrpc_call *call = b->call_backlog[tail];
+		rxrpc_see_call(call, rxrpc_call_see_discard);
 		rcu_assign_pointer(call->socket, rx);
 		if (rx->discard_new_call) {
 			_debug("discard %lx", call->user_call_ID);
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index 5ea9601efd05..ccfae607c9bb 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -590,6 +590,9 @@ void rxrpc_reject_packet(struct rxrpc_local *local, struct sk_buff *skb)
 	__be32 code;
 	int ret, ioc;
 
+	if (sp->hdr.type == RXRPC_PACKET_TYPE_ABORT)
+		return; /* Never abort an abort. */
+
 	rxrpc_see_skb(skb, rxrpc_skb_see_reject);
 
 	iov[0].iov_base = &whdr;
diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
index a482f88c5fc5..e24a44bae9a3 100644
--- a/net/rxrpc/recvmsg.c
+++ b/net/rxrpc/recvmsg.c
@@ -351,6 +351,16 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		goto try_again;
 	}
 
+	rxrpc_see_call(call, rxrpc_call_see_recvmsg);
+	if (test_bit(RXRPC_CALL_RELEASED, &call->flags)) {
+		rxrpc_see_call(call, rxrpc_call_see_already_released);
+		list_del_init(&call->recvmsg_link);
+		spin_unlock_irq(&rx->recvmsg_lock);
+		release_sock(&rx->sk);
+		trace_rxrpc_recvmsg(call->debug_id, rxrpc_recvmsg_unqueue, 0);
+		rxrpc_put_call(call, rxrpc_call_put_recvmsg);
+		goto try_again;
+	}
 	if (!(flags & MSG_PEEK))
 		list_del_init(&call->recvmsg_link);
 	else
@@ -374,8 +384,13 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 
 	release_sock(&rx->sk);
 
-	if (test_bit(RXRPC_CALL_RELEASED, &call->flags))
-		BUG();
+	if (test_bit(RXRPC_CALL_RELEASED, &call->flags)) {
+		rxrpc_see_call(call, rxrpc_call_see_already_released);
+		mutex_unlock(&call->user_mutex);
+		if (!(flags & MSG_PEEK))
+			rxrpc_put_call(call, rxrpc_call_put_recvmsg);
+		goto try_again;
+	}
 
 	if (test_bit(RXRPC_CALL_HAS_USERID, &call->flags)) {
 		if (flags & MSG_CMSG_COMPAT) {
diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index b2494d24a542..1021681a5718 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -821,7 +821,9 @@ static struct htb_class *htb_lookup_leaf(struct htb_prio *hprio, const int prio)
 		u32 *pid;
 	} stk[TC_HTB_MAXDEPTH], *sp = stk;
 
-	BUG_ON(!hprio->row.rb_node);
+	if (unlikely(!hprio->row.rb_node))
+		return NULL;
+
 	sp->root = hprio->row.rb_node;
 	sp->pptr = &hprio->ptr;
 	sp->pid = &hprio->last_ptr_id;
diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index aa4fbd2fae29..8e60fb5a7083 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -412,7 +412,7 @@ static int qfq_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 	bool existing = false;
 	struct nlattr *tb[TCA_QFQ_MAX + 1];
 	struct qfq_aggregate *new_agg = NULL;
-	u32 weight, lmax, inv_w;
+	u32 weight, lmax, inv_w, old_weight, old_lmax;
 	int err;
 	int delta_w;
 
@@ -446,12 +446,16 @@ static int qfq_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 	inv_w = ONE_FP / weight;
 	weight = ONE_FP / inv_w;
 
-	if (cl != NULL &&
-	    lmax == cl->agg->lmax &&
-	    weight == cl->agg->class_weight)
-		return 0; /* nothing to change */
+	if (cl != NULL) {
+		sch_tree_lock(sch);
+		old_weight = cl->agg->class_weight;
+		old_lmax   = cl->agg->lmax;
+		sch_tree_unlock(sch);
+		if (lmax == old_lmax && weight == old_weight)
+			return 0; /* nothing to change */
+	}
 
-	delta_w = weight - (cl ? cl->agg->class_weight : 0);
+	delta_w = weight - (cl ? old_weight : 0);
 
 	if (q->wsum + delta_w > QFQ_MAX_WSUM) {
 		NL_SET_ERR_MSG_FMT_MOD(extack,
@@ -558,10 +562,10 @@ static int qfq_delete_class(struct Qdisc *sch, unsigned long arg,
 
 	qdisc_purge_queue(cl->qdisc);
 	qdisc_class_hash_remove(&q->clhash, &cl->common);
+	qfq_destroy_class(sch, cl);
 
 	sch_tree_unlock(sch);
 
-	qfq_destroy_class(sch, cl);
 	return 0;
 }
 
@@ -628,6 +632,7 @@ static int qfq_dump_class(struct Qdisc *sch, unsigned long arg,
 {
 	struct qfq_class *cl = (struct qfq_class *)arg;
 	struct nlattr *nest;
+	u32 class_weight, lmax;
 
 	tcm->tcm_parent	= TC_H_ROOT;
 	tcm->tcm_handle	= cl->common.classid;
@@ -636,8 +641,13 @@ static int qfq_dump_class(struct Qdisc *sch, unsigned long arg,
 	nest = nla_nest_start_noflag(skb, TCA_OPTIONS);
 	if (nest == NULL)
 		goto nla_put_failure;
-	if (nla_put_u32(skb, TCA_QFQ_WEIGHT, cl->agg->class_weight) ||
-	    nla_put_u32(skb, TCA_QFQ_LMAX, cl->agg->lmax))
+
+	sch_tree_lock(sch);
+	class_weight	= cl->agg->class_weight;
+	lmax		= cl->agg->lmax;
+	sch_tree_unlock(sch);
+	if (nla_put_u32(skb, TCA_QFQ_WEIGHT, class_weight) ||
+	    nla_put_u32(skb, TCA_QFQ_LMAX, lmax))
 		goto nla_put_failure;
 	return nla_nest_end(skb, nest);
 
@@ -654,8 +664,10 @@ static int qfq_dump_class_stats(struct Qdisc *sch, unsigned long arg,
 
 	memset(&xstats, 0, sizeof(xstats));
 
+	sch_tree_lock(sch);
 	xstats.weight = cl->agg->class_weight;
 	xstats.lmax = cl->agg->lmax;
+	sch_tree_unlock(sch);
 
 	if (gnet_stats_copy_basic(d, NULL, &cl->bstats, true) < 0 ||
 	    gnet_stats_copy_rate_est(d, &cl->rate_est) < 0 ||
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 78b0e6dba0a2..3c43239f09d3 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -30,6 +30,10 @@
 #include <linux/splice.h>
 
 #include <net/sock.h>
+#include <net/inet_common.h>
+#if IS_ENABLED(CONFIG_IPV6)
+#include <net/ipv6.h>
+#endif
 #include <net/tcp.h>
 #include <net/smc.h>
 #include <asm/ioctls.h>
@@ -360,6 +364,16 @@ static void smc_destruct(struct sock *sk)
 		return;
 	if (!sock_flag(sk, SOCK_DEAD))
 		return;
+	switch (sk->sk_family) {
+	case AF_INET:
+		inet_sock_destruct(sk);
+		break;
+#if IS_ENABLED(CONFIG_IPV6)
+	case AF_INET6:
+		inet6_sock_destruct(sk);
+		break;
+#endif
+	}
 }
 
 static struct lock_class_key smc_key;
diff --git a/net/smc/smc.h b/net/smc/smc.h
index ad77d6b6b8d3..7579f9622e01 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -283,10 +283,10 @@ struct smc_connection {
 };
 
 struct smc_sock {				/* smc sock container */
-	struct sock		sk;
-#if IS_ENABLED(CONFIG_IPV6)
-	struct ipv6_pinfo	*pinet6;
-#endif
+	union {
+		struct sock		sk;
+		struct inet_sock	icsk_inet;
+	};
 	struct socket		*clcsock;	/* internal tcp socket */
 	void			(*clcsk_state_change)(struct sock *sk);
 						/* original stat_change fct. */
diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index 65b0da6fdf6a..095cf31bae0b 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -512,9 +512,8 @@ static int tls_strp_read_sock(struct tls_strparser *strp)
 	if (inq < strp->stm.full_len)
 		return tls_strp_read_copy(strp, true);
 
+	tls_strp_load_anchor_with_queue(strp, inq);
 	if (!strp->stm.full_len) {
-		tls_strp_load_anchor_with_queue(strp, inq);
-
 		sz = tls_rx_msg_size(strp, strp->anchor);
 		if (sz < 0) {
 			tls_strp_abort_strp(strp, sz);
diff --git a/rust/Makefile b/rust/Makefile
index b8b7f817c48e..17491d8229a4 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -157,6 +157,7 @@ quiet_cmd_rustdoc_test = RUSTDOC T $<
       cmd_rustdoc_test = \
 	OBJTREE=$(abspath $(objtree)) \
 	$(RUSTDOC) --test $(rust_common_flags) \
+		-Zcrate-attr='feature(used_with_arg)' \
 		@$(objtree)/include/generated/rustc_cfg \
 		$(rustc_target_flags) $(rustdoc_test_target_flags) \
 		$(rustdoc_test_quiet) \
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 904d241604db..889ddcb1a2dd 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -18,6 +18,7 @@
 #![feature(inline_const)]
 #![feature(lint_reasons)]
 #![feature(unsize)]
+#![feature(used_with_arg)]
 
 // Ensure conditional compilation based on the kernel configuration works;
 // otherwise we may silently break things like initcall handling.
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index a5ea5850e307..edb23b28f446 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -57,7 +57,7 @@ fn emit_base(&mut self, field: &str, content: &str, builtin: bool) {
                 {cfg}
                 #[doc(hidden)]
                 #[link_section = \".modinfo\"]
-                #[used]
+                #[used(compiler)]
                 pub static __{module}_{counter}: [u8; {length}] = *{string};
             ",
             cfg = if builtin {
@@ -230,7 +230,7 @@ mod __module_init {{
                     // key or a new section. For the moment, keep it simple.
                     #[cfg(MODULE)]
                     #[doc(hidden)]
-                    #[used]
+                    #[used(compiler)]
                     static __IS_RUST_MODULE: () = ();
 
                     static mut __MOD: Option<{type_}> = None;
@@ -253,7 +253,7 @@ mod __module_init {{
 
                     #[cfg(MODULE)]
                     #[doc(hidden)]
-                    #[used]
+                    #[used(compiler)]
                     #[link_section = \".init.data\"]
                     static __UNIQUE_ID___addressable_init_module: unsafe extern \"C\" fn() -> i32 = init_module;
 
@@ -273,7 +273,7 @@ mod __module_init {{
 
                     #[cfg(MODULE)]
                     #[doc(hidden)]
-                    #[used]
+                    #[used(compiler)]
                     #[link_section = \".exit.data\"]
                     static __UNIQUE_ID___addressable_cleanup_module: extern \"C\" fn() = cleanup_module;
 
@@ -283,7 +283,7 @@ mod __module_init {{
                     #[cfg(not(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS))]
                     #[doc(hidden)]
                     #[link_section = \"{initcall_section}\"]
-                    #[used]
+                    #[used(compiler)]
                     pub static __{name}_initcall: extern \"C\" fn() -> kernel::ffi::c_int = __{name}_init;
 
                     #[cfg(not(MODULE))]
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 2bba59e790b8..2c5c1a214f3b 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -248,7 +248,7 @@ $(obj)/%.lst: $(obj)/%.c FORCE
 # Compile Rust sources (.rs)
 # ---------------------------------------------------------------------------
 
-rust_allowed_features := arbitrary_self_types,lint_reasons
+rust_allowed_features := arbitrary_self_types,lint_reasons,used_with_arg
 
 # `--out-dir` is required to avoid temporaries being created by `rustc` in the
 # current working directory, which may be not accessible in the out-of-tree
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index e98823bd3634..f033214bf77f 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10731,6 +10731,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8b97, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8bb3, "HP Slim OMEN", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8bb4, "HP Slim OMEN", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8bbe, "HP Victus 16-r0xxx (MB 8BBE)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8bc8, "HP Victus 15-fa1xxx", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8bcd, "HP Omen 16-xd0xxx", ALC245_FIXUP_HP_MUTE_LED_V1_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8bdd, "HP Envy 17", ALC287_FIXUP_CS35L41_I2C_2),
@@ -10912,6 +10913,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1a13, "Asus G73Jw", ALC269_FIXUP_ASUS_G73JW),
 	SND_PCI_QUIRK(0x1043, 0x1a63, "ASUS UX3405MA", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1a83, "ASUS UM5302LA", ALC294_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x1043, 0x1a8e, "ASUS G712LWS", ALC294_FIXUP_LENOVO_MIC_LOCATION),
 	SND_PCI_QUIRK(0x1043, 0x1a8f, "ASUS UX582ZS", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1b11, "ASUS UX431DA", ALC294_FIXUP_ASUS_COEF_1B),
 	SND_PCI_QUIRK(0x1043, 0x1b13, "ASUS U41SV/GA403U", ALC285_FIXUP_ASUS_GA403U_HEADSET_MIC),
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 36e341b4b77b..747cef47e685 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -726,7 +726,7 @@ struct bpf_object {
 
 	struct usdt_manager *usdt_man;
 
-	struct bpf_map *arena_map;
+	int arena_map_idx;
 	void *arena_data;
 	size_t arena_data_sz;
 
@@ -1494,6 +1494,7 @@ static struct bpf_object *bpf_object__new(const char *path,
 	obj->efile.obj_buf_sz = obj_buf_sz;
 	obj->efile.btf_maps_shndx = -1;
 	obj->kconfig_map_idx = -1;
+	obj->arena_map_idx = -1;
 
 	obj->kern_version = get_kernel_version();
 	obj->loaded = false;
@@ -2935,7 +2936,7 @@ static int init_arena_map_data(struct bpf_object *obj, struct bpf_map *map,
 	const long page_sz = sysconf(_SC_PAGE_SIZE);
 	size_t mmap_sz;
 
-	mmap_sz = bpf_map_mmap_sz(obj->arena_map);
+	mmap_sz = bpf_map_mmap_sz(map);
 	if (roundup(data_sz, page_sz) > mmap_sz) {
 		pr_warn("elf: sec '%s': declared ARENA map size (%zu) is too small to hold global __arena variables of size %zu\n",
 			sec_name, mmap_sz, data_sz);
@@ -3009,12 +3010,12 @@ static int bpf_object__init_user_btf_maps(struct bpf_object *obj, bool strict,
 		if (map->def.type != BPF_MAP_TYPE_ARENA)
 			continue;
 
-		if (obj->arena_map) {
+		if (obj->arena_map_idx >= 0) {
 			pr_warn("map '%s': only single ARENA map is supported (map '%s' is also ARENA)\n",
-				map->name, obj->arena_map->name);
+				map->name, obj->maps[obj->arena_map_idx].name);
 			return -EINVAL;
 		}
-		obj->arena_map = map;
+		obj->arena_map_idx = i;
 
 		if (obj->efile.arena_data) {
 			err = init_arena_map_data(obj, map, ARENA_SEC, obj->efile.arena_data_shndx,
@@ -3024,7 +3025,7 @@ static int bpf_object__init_user_btf_maps(struct bpf_object *obj, bool strict,
 				return err;
 		}
 	}
-	if (obj->efile.arena_data && !obj->arena_map) {
+	if (obj->efile.arena_data && obj->arena_map_idx < 0) {
 		pr_warn("elf: sec '%s': to use global __arena variables the ARENA map should be explicitly declared in SEC(\".maps\")\n",
 			ARENA_SEC);
 		return -ENOENT;
@@ -4547,8 +4548,13 @@ static int bpf_program__record_reloc(struct bpf_program *prog,
 	if (shdr_idx == obj->efile.arena_data_shndx) {
 		reloc_desc->type = RELO_DATA;
 		reloc_desc->insn_idx = insn_idx;
-		reloc_desc->map_idx = obj->arena_map - obj->maps;
+		reloc_desc->map_idx = obj->arena_map_idx;
 		reloc_desc->sym_off = sym->st_value;
+
+		map = &obj->maps[obj->arena_map_idx];
+		pr_debug("prog '%s': found arena map %d (%s, sec %d, off %zu) for insn %u\n",
+			 prog->name, obj->arena_map_idx, map->name, map->sec_idx,
+			 map->sec_offset, insn_idx);
 		return 0;
 	}
 
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index a737286de759..d4d82bb9b551 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -216,6 +216,7 @@ static bool is_rust_noreturn(const struct symbol *func)
 	       str_ends_with(func->name, "_4core9panicking14panic_explicit")				||
 	       str_ends_with(func->name, "_4core9panicking14panic_nounwind")				||
 	       str_ends_with(func->name, "_4core9panicking18panic_bounds_check")			||
+	       str_ends_with(func->name, "_4core9panicking18panic_nounwind_fmt")			||
 	       str_ends_with(func->name, "_4core9panicking19assert_failed_inner")			||
 	       str_ends_with(func->name, "_4core9panicking30panic_null_pointer_dereference")		||
 	       str_ends_with(func->name, "_4core9panicking36panic_misaligned_pointer_dereference")	||
diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testing/selftests/bpf/prog_tests/token.c
index fe86e4fdb89c..c3ab9b6fb069 100644
--- a/tools/testing/selftests/bpf/prog_tests/token.c
+++ b/tools/testing/selftests/bpf/prog_tests/token.c
@@ -828,8 +828,12 @@ static int userns_obj_priv_btf_success(int mnt_fd, struct token_lsm *lsm_skel)
 	return validate_struct_ops_load(mnt_fd, true /* should succeed */);
 }
 
+static const char *token_bpffs_custom_dir()
+{
+	return getenv("BPF_SELFTESTS_BPF_TOKEN_DIR") ?: "/tmp/bpf-token-fs";
+}
+
 #define TOKEN_ENVVAR "LIBBPF_BPF_TOKEN_PATH"
-#define TOKEN_BPFFS_CUSTOM "/bpf-token-fs"
 
 static int userns_obj_priv_implicit_token(int mnt_fd, struct token_lsm *lsm_skel)
 {
@@ -892,6 +896,7 @@ static int userns_obj_priv_implicit_token(int mnt_fd, struct token_lsm *lsm_skel
 
 static int userns_obj_priv_implicit_token_envvar(int mnt_fd, struct token_lsm *lsm_skel)
 {
+	const char *custom_dir = token_bpffs_custom_dir();
 	LIBBPF_OPTS(bpf_object_open_opts, opts);
 	struct dummy_st_ops_success *skel;
 	int err;
@@ -909,10 +914,10 @@ static int userns_obj_priv_implicit_token_envvar(int mnt_fd, struct token_lsm *l
 	 * BPF token implicitly, unless pointed to it through
 	 * LIBBPF_BPF_TOKEN_PATH envvar
 	 */
-	rmdir(TOKEN_BPFFS_CUSTOM);
-	if (!ASSERT_OK(mkdir(TOKEN_BPFFS_CUSTOM, 0777), "mkdir_bpffs_custom"))
+	rmdir(custom_dir);
+	if (!ASSERT_OK(mkdir(custom_dir, 0777), "mkdir_bpffs_custom"))
 		goto err_out;
-	err = sys_move_mount(mnt_fd, "", AT_FDCWD, TOKEN_BPFFS_CUSTOM, MOVE_MOUNT_F_EMPTY_PATH);
+	err = sys_move_mount(mnt_fd, "", AT_FDCWD, custom_dir, MOVE_MOUNT_F_EMPTY_PATH);
 	if (!ASSERT_OK(err, "move_mount_bpffs"))
 		goto err_out;
 
@@ -925,7 +930,7 @@ static int userns_obj_priv_implicit_token_envvar(int mnt_fd, struct token_lsm *l
 		goto err_out;
 	}
 
-	err = setenv(TOKEN_ENVVAR, TOKEN_BPFFS_CUSTOM, 1 /*overwrite*/);
+	err = setenv(TOKEN_ENVVAR, custom_dir, 1 /*overwrite*/);
 	if (!ASSERT_OK(err, "setenv_token_path"))
 		goto err_out;
 
@@ -951,11 +956,11 @@ static int userns_obj_priv_implicit_token_envvar(int mnt_fd, struct token_lsm *l
 	if (!ASSERT_ERR(err, "obj_empty_token_path_load"))
 		goto err_out;
 
-	rmdir(TOKEN_BPFFS_CUSTOM);
+	rmdir(custom_dir);
 	unsetenv(TOKEN_ENVVAR);
 	return 0;
 err_out:
-	rmdir(TOKEN_BPFFS_CUSTOM);
+	rmdir(custom_dir);
 	unsetenv(TOKEN_ENVVAR);
 	return -EINVAL;
 }
diff --git a/tools/testing/selftests/net/udpgro.sh b/tools/testing/selftests/net/udpgro.sh
index d5ffd8c9172e..799dbc2b4b01 100755
--- a/tools/testing/selftests/net/udpgro.sh
+++ b/tools/testing/selftests/net/udpgro.sh
@@ -48,7 +48,7 @@ run_one() {
 
 	cfg_veth
 
-	ip netns exec "${PEER_NS}" ./udpgso_bench_rx -C 1000 -R 10 ${rx_args} &
+	ip netns exec "${PEER_NS}" ./udpgso_bench_rx -C 1000 -R 100 ${rx_args} &
 	local PID1=$!
 
 	wait_local_port_listen ${PEER_NS} 8000 udp
@@ -95,7 +95,7 @@ run_one_nat() {
 	# will land on the 'plain' one
 	ip netns exec "${PEER_NS}" ./udpgso_bench_rx -G ${family} -b ${addr1} -n 0 &
 	local PID1=$!
-	ip netns exec "${PEER_NS}" ./udpgso_bench_rx -C 1000 -R 10 ${family} -b ${addr2%/*} ${rx_args} &
+	ip netns exec "${PEER_NS}" ./udpgso_bench_rx -C 1000 -R 100 ${family} -b ${addr2%/*} ${rx_args} &
 	local PID2=$!
 
 	wait_local_port_listen "${PEER_NS}" 8000 udp
@@ -117,9 +117,9 @@ run_one_2sock() {
 
 	cfg_veth
 
-	ip netns exec "${PEER_NS}" ./udpgso_bench_rx -C 1000 -R 10 ${rx_args} -p 12345 &
+	ip netns exec "${PEER_NS}" ./udpgso_bench_rx -C 1000 -R 100 ${rx_args} -p 12345 &
 	local PID1=$!
-	ip netns exec "${PEER_NS}" ./udpgso_bench_rx -C 2000 -R 10 ${rx_args} &
+	ip netns exec "${PEER_NS}" ./udpgso_bench_rx -C 2000 -R 100 ${rx_args} &
 	local PID2=$!
 
 	wait_local_port_listen "${PEER_NS}" 12345 udp
diff --git a/tools/testing/selftests/sched_ext/exit.c b/tools/testing/selftests/sched_ext/exit.c
index 31bcd06e21cd..2c084ded2968 100644
--- a/tools/testing/selftests/sched_ext/exit.c
+++ b/tools/testing/selftests/sched_ext/exit.c
@@ -22,6 +22,14 @@ static enum scx_test_status run(void *ctx)
 		struct bpf_link *link;
 		char buf[16];
 
+		/*
+		 * On single-CPU systems, ops.select_cpu() is never
+		 * invoked, so skip this test to avoid getting stuck
+		 * indefinitely.
+		 */
+		if (tc == EXIT_SELECT_CPU && libbpf_num_possible_cpus() == 1)
+			continue;
+
 		skel = exit__open();
 		skel->rodata->exit_point = tc;
 		exit__load(skel);

