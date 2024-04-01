Return-Path: <stable+bounces-35260-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A813894327
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 19:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6EDEB20A4C
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 17:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24100481C6;
	Mon,  1 Apr 2024 17:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dtbkHwUj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A7F47A5D;
	Mon,  1 Apr 2024 17:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990817; cv=none; b=UmpwskFzg2T5Efpnhk0B9diIQ47lkeJFV80ZmjJpGFA0LfE0gXfbQljFiLcAtryXA2tSuZD4ZTmSkPep/lVPBNsPkffLH28h1+mpDtoDpR8oQHbgI03Y31CVSaPq5CmItxT09twtVZ0sdhPGpZvi7Hi5EGAn0oNAsEtsKkQ2ZW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990817; c=relaxed/simple;
	bh=sAaxxolhrhIC0DIGWQCJonOeusPjphrCf1H0xoLHZWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZMSzg1aHtXe8FNDG+ELqQRAfm+u0m/wmZAifdPLHTx97JY4lV6wSo6nFH85F3yMgsXpBDyIdtE3MKfUae6Z0q5f8ydSOxmcGREx94ERXveCtFAKQ5GOTT++GyTXnw5IHIfa6r4s63jqhUZMXVRl20YrbTaUgdzdNqH/wry8qOnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dtbkHwUj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56857C433F1;
	Mon,  1 Apr 2024 17:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711990817;
	bh=sAaxxolhrhIC0DIGWQCJonOeusPjphrCf1H0xoLHZWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dtbkHwUj+2uyCXAOBUiFxiyz3pRq4aKG1GM+P+mqe3GTAbtWTFSiVozE7TG1f2BEV
	 zO3zuP/jdvJRW4IsJFVPcEGmIJtjjempRR/ajtelsAWCiglehKAGeAoaCNWFmrjVLM
	 JL5hg09Y3tq4cYkbgz7ARFFBqXSD1gCnshPGQYt8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jarred White <jarredwhite@linux.microsoft.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 075/272] ACPI: CPPC: Use access_width over bit_width for system memory accesses
Date: Mon,  1 Apr 2024 17:44:25 +0200
Message-ID: <20240401152532.908747742@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152530.237785232@linuxfoundation.org>
References: <20240401152530.237785232@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jarred White <jarredwhite@linux.microsoft.com>

[ Upstream commit 2f4a4d63a193be6fd530d180bb13c3592052904c ]

To align with ACPI 6.3+, since bit_width can be any 8-bit value, it
cannot be depended on to be always on a clean 8b boundary. This was
uncovered on the Cobalt 100 platform.

SError Interrupt on CPU26, code 0xbe000011 -- SError
 CPU: 26 PID: 1510 Comm: systemd-udevd Not tainted 5.15.2.1-13 #1
 Hardware name: MICROSOFT CORPORATION, BIOS MICROSOFT CORPORATION
 pstate: 62400009 (nZCv daif +PAN -UAO +TCO -DIT -SSBS BTYPE=--)
 pc : cppc_get_perf_caps+0xec/0x410
 lr : cppc_get_perf_caps+0xe8/0x410
 sp : ffff8000155ab730
 x29: ffff8000155ab730 x28: ffff0080139d0038 x27: ffff0080139d0078
 x26: 0000000000000000 x25: ffff0080139d0058 x24: 00000000ffffffff
 x23: ffff0080139d0298 x22: ffff0080139d0278 x21: 0000000000000000
 x20: ffff00802b251910 x19: ffff0080139d0000 x18: ffffffffffffffff
 x17: 0000000000000000 x16: ffffdc7e111bad04 x15: ffff00802b251008
 x14: ffffffffffffffff x13: ffff013f1fd63300 x12: 0000000000000006
 x11: ffffdc7e128f4420 x10: 0000000000000000 x9 : ffffdc7e111badec
 x8 : ffff00802b251980 x7 : 0000000000000000 x6 : ffff0080139d0028
 x5 : 0000000000000000 x4 : ffff0080139d0018 x3 : 00000000ffffffff
 x2 : 0000000000000008 x1 : ffff8000155ab7a0 x0 : 0000000000000000
 Kernel panic - not syncing: Asynchronous SError Interrupt
 CPU: 26 PID: 1510 Comm: systemd-udevd Not tainted
5.15.2.1-13 #1
 Hardware name: MICROSOFT CORPORATION, BIOS MICROSOFT CORPORATION
 Call trace:
  dump_backtrace+0x0/0x1e0
  show_stack+0x24/0x30
  dump_stack_lvl+0x8c/0xb8
  dump_stack+0x18/0x34
  panic+0x16c/0x384
  add_taint+0x0/0xc0
  arm64_serror_panic+0x7c/0x90
  arm64_is_fatal_ras_serror+0x34/0xa4
  do_serror+0x50/0x6c
  el1h_64_error_handler+0x40/0x74
  el1h_64_error+0x7c/0x80
  cppc_get_perf_caps+0xec/0x410
  cppc_cpufreq_cpu_init+0x74/0x400 [cppc_cpufreq]
  cpufreq_online+0x2dc/0xa30
  cpufreq_add_dev+0xc0/0xd4
  subsys_interface_register+0x134/0x14c
  cpufreq_register_driver+0x1b0/0x354
  cppc_cpufreq_init+0x1a8/0x1000 [cppc_cpufreq]
  do_one_initcall+0x50/0x250
  do_init_module+0x60/0x27c
  load_module+0x2300/0x2570
  __do_sys_finit_module+0xa8/0x114
  __arm64_sys_finit_module+0x2c/0x3c
  invoke_syscall+0x78/0x100
  el0_svc_common.constprop.0+0x180/0x1a0
  do_el0_svc+0x84/0xa0
  el0_svc+0x2c/0xc0
  el0t_64_sync_handler+0xa4/0x12c
  el0t_64_sync+0x1a4/0x1a8

Instead, use access_width to determine the size and use the offset and
width to shift and mask the bits to read/write out. Make sure to add a
check for system memory since pcc redefines the access_width to
subspace id.

If access_width is not set, then fall back to using bit_width.

Signed-off-by: Jarred White <jarredwhite@linux.microsoft.com>
Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: 5.15+ <stable@vger.kernel.org> # 5.15+
[ rjw: Subject and changelog edits, comment adjustments ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/cppc_acpi.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 093675b1a1ffb..c123fdbca693e 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -163,6 +163,13 @@ show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, nominal_freq);
 show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, reference_perf);
 show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, wraparound_time);
 
+/* Check for valid access_width, otherwise, fallback to using bit_width */
+#define GET_BIT_WIDTH(reg) ((reg)->access_width ? (8 << ((reg)->access_width - 1)) : (reg)->bit_width)
+
+/* Shift and apply the mask for CPC reads/writes */
+#define MASK_VAL(reg, val) ((val) >> ((reg)->bit_offset & 			\
+					GENMASK(((reg)->bit_width), 0)))
+
 static ssize_t show_feedback_ctrs(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
@@ -776,6 +783,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 			} else if (gas_t->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
 				if (gas_t->address) {
 					void __iomem *addr;
+					size_t access_width;
 
 					if (!osc_cpc_flexible_adr_space_confirmed) {
 						pr_debug("Flexible address space capability not supported\n");
@@ -783,7 +791,8 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 							goto out_free;
 					}
 
-					addr = ioremap(gas_t->address, gas_t->bit_width/8);
+					access_width = GET_BIT_WIDTH(gas_t) / 8;
+					addr = ioremap(gas_t->address, access_width);
 					if (!addr)
 						goto out_free;
 					cpc_ptr->cpc_regs[i-2].sys_mem_vaddr = addr;
@@ -979,6 +988,7 @@ int __weak cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
 static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 {
 	void __iomem *vaddr = NULL;
+	int size;
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
 	struct cpc_reg *reg = &reg_res->cpc_entry.reg;
 
@@ -990,7 +1000,7 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 	*val = 0;
 
 	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
-		u32 width = 8 << (reg->access_width - 1);
+		u32 width = GET_BIT_WIDTH(reg);
 		u32 val_u32;
 		acpi_status status;
 
@@ -1014,7 +1024,9 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 		return acpi_os_read_memory((acpi_physical_address)reg->address,
 				val, reg->bit_width);
 
-	switch (reg->bit_width) {
+	size = GET_BIT_WIDTH(reg);
+
+	switch (size) {
 	case 8:
 		*val = readb_relaxed(vaddr);
 		break;
@@ -1033,18 +1045,22 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 		return -EFAULT;
 	}
 
+	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
+		*val = MASK_VAL(reg, *val);
+
 	return 0;
 }
 
 static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 {
 	int ret_val = 0;
+	int size;
 	void __iomem *vaddr = NULL;
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
 	struct cpc_reg *reg = &reg_res->cpc_entry.reg;
 
 	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
-		u32 width = 8 << (reg->access_width - 1);
+		u32 width = GET_BIT_WIDTH(reg);
 		acpi_status status;
 
 		status = acpi_os_write_port((acpi_io_address)reg->address,
@@ -1066,7 +1082,12 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 		return acpi_os_write_memory((acpi_physical_address)reg->address,
 				val, reg->bit_width);
 
-	switch (reg->bit_width) {
+	size = GET_BIT_WIDTH(reg);
+
+	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
+		val = MASK_VAL(reg, val);
+
+	switch (size) {
 	case 8:
 		writeb_relaxed(val, vaddr);
 		break;
-- 
2.43.0




