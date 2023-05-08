Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CBB6FA6F5
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbjEHKZy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234439AbjEHKZZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:25:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2F2DDBB
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:25:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 852ED625C1
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:25:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A8AEC433D2;
        Mon,  8 May 2023 10:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541506;
        bh=V9sY2ibZItqmtWRe18oe+kXHRlL0Q8ZaUIDi32cyVzA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2B5tn5kN6cW/5jb7sS8J9Bhs52SKeOWgmII5iOV99UDlhC6GmjYokrjhrTOOQSIfa
         XCF+cL6LZrKusKsg5cu8q0B3DKc4hHk9Dq/LH0JyfySKXJqA14l+pT+12Jyuy5Yv/0
         nxALA4Jb/tFguEklYfhsEq/iSvavj2oja2MJPN+0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH 6.2 102/663] RISC-V: Align SBI probe implementation with spec
Date:   Mon,  8 May 2023 11:38:48 +0200
Message-Id: <20230508094431.772289390@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Andrew Jones <ajones@ventanamicro.com>

commit 41cad8284d5e6bf1d49d3c10a6b52ee1ae866a20 upstream.

sbi_probe_extension() is specified with "Returns 0 if the given SBI
extension ID (EID) is not available, or 1 if it is available unless
defined as any other non-zero value by the implementation."
Additionally, sbiret.value is a long. Fix the implementation to
ensure any nonzero long value is considered a success, rather
than only positive int values.

Fixes: b9dcd9e41587 ("RISC-V: Add basic support for SBI v0.2")
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230427163626.101042-1-ajones@ventanamicro.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/riscv/include/asm/sbi.h        |    2 +-
 arch/riscv/kernel/cpu_ops.c         |    2 +-
 arch/riscv/kernel/sbi.c             |   17 ++++++++---------
 arch/riscv/kvm/main.c               |    2 +-
 drivers/cpuidle/cpuidle-riscv-sbi.c |    2 +-
 drivers/perf/riscv_pmu_sbi.c        |    2 +-
 6 files changed, 13 insertions(+), 14 deletions(-)

--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -293,7 +293,7 @@ int sbi_remote_hfence_vvma_asid(const st
 				unsigned long start,
 				unsigned long size,
 				unsigned long asid);
-int sbi_probe_extension(int ext);
+long sbi_probe_extension(int ext);
 
 /* Check if current SBI specification version is 0.1 or not */
 static inline int sbi_spec_is_0_1(void)
--- a/arch/riscv/kernel/cpu_ops.c
+++ b/arch/riscv/kernel/cpu_ops.c
@@ -27,7 +27,7 @@ const struct cpu_operations cpu_ops_spin
 void __init cpu_set_ops(int cpuid)
 {
 #if IS_ENABLED(CONFIG_RISCV_SBI)
-	if (sbi_probe_extension(SBI_EXT_HSM) > 0) {
+	if (sbi_probe_extension(SBI_EXT_HSM)) {
 		if (!cpuid)
 			pr_info("SBI HSM extension detected\n");
 		cpu_ops[cpuid] = &cpu_ops_sbi;
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -581,19 +581,18 @@ static void sbi_srst_power_off(void)
  * sbi_probe_extension() - Check if an SBI extension ID is supported or not.
  * @extid: The extension ID to be probed.
  *
- * Return: Extension specific nonzero value f yes, -ENOTSUPP otherwise.
+ * Return: 1 or an extension specific nonzero value if yes, 0 otherwise.
  */
-int sbi_probe_extension(int extid)
+long sbi_probe_extension(int extid)
 {
 	struct sbiret ret;
 
 	ret = sbi_ecall(SBI_EXT_BASE, SBI_EXT_BASE_PROBE_EXT, extid,
 			0, 0, 0, 0, 0);
 	if (!ret.error)
-		if (ret.value)
-			return ret.value;
+		return ret.value;
 
-	return -ENOTSUPP;
+	return 0;
 }
 EXPORT_SYMBOL(sbi_probe_extension);
 
@@ -665,26 +664,26 @@ void __init sbi_init(void)
 	if (!sbi_spec_is_0_1()) {
 		pr_info("SBI implementation ID=0x%lx Version=0x%lx\n",
 			sbi_get_firmware_id(), sbi_get_firmware_version());
-		if (sbi_probe_extension(SBI_EXT_TIME) > 0) {
+		if (sbi_probe_extension(SBI_EXT_TIME)) {
 			__sbi_set_timer = __sbi_set_timer_v02;
 			pr_info("SBI TIME extension detected\n");
 		} else {
 			__sbi_set_timer = __sbi_set_timer_v01;
 		}
-		if (sbi_probe_extension(SBI_EXT_IPI) > 0) {
+		if (sbi_probe_extension(SBI_EXT_IPI)) {
 			__sbi_send_ipi	= __sbi_send_ipi_v02;
 			pr_info("SBI IPI extension detected\n");
 		} else {
 			__sbi_send_ipi	= __sbi_send_ipi_v01;
 		}
-		if (sbi_probe_extension(SBI_EXT_RFENCE) > 0) {
+		if (sbi_probe_extension(SBI_EXT_RFENCE)) {
 			__sbi_rfence	= __sbi_rfence_v02;
 			pr_info("SBI RFENCE extension detected\n");
 		} else {
 			__sbi_rfence	= __sbi_rfence_v01;
 		}
 		if ((sbi_spec_version >= sbi_mk_version(0, 3)) &&
-		    (sbi_probe_extension(SBI_EXT_SRST) > 0)) {
+		    sbi_probe_extension(SBI_EXT_SRST)) {
 			pr_info("SBI SRST extension detected\n");
 			pm_power_off = sbi_srst_power_off;
 			sbi_srst_reboot_nb.notifier_call = sbi_srst_reboot;
--- a/arch/riscv/kvm/main.c
+++ b/arch/riscv/kvm/main.c
@@ -84,7 +84,7 @@ int kvm_arch_init(void *opaque)
 		return -ENODEV;
 	}
 
-	if (sbi_probe_extension(SBI_EXT_RFENCE) <= 0) {
+	if (!sbi_probe_extension(SBI_EXT_RFENCE)) {
 		kvm_info("require SBI RFENCE extension\n");
 		return -ENODEV;
 	}
--- a/drivers/cpuidle/cpuidle-riscv-sbi.c
+++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
@@ -612,7 +612,7 @@ static int __init sbi_cpuidle_init(void)
 	 * 2) SBI HSM extension is available
 	 */
 	if ((sbi_spec_version < sbi_mk_version(0, 3)) ||
-	    sbi_probe_extension(SBI_EXT_HSM) <= 0) {
+	    !sbi_probe_extension(SBI_EXT_HSM)) {
 		pr_info("HSM suspend not available\n");
 		return 0;
 	}
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -883,7 +883,7 @@ static int __init pmu_sbi_devinit(void)
 	struct platform_device *pdev;
 
 	if (sbi_spec_version < sbi_mk_version(0, 3) ||
-	    sbi_probe_extension(SBI_EXT_PMU) <= 0) {
+	    !sbi_probe_extension(SBI_EXT_PMU)) {
 		return 0;
 	}
 


