Return-Path: <stable+bounces-28431-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CBA88027C
	for <lists+stable@lfdr.de>; Tue, 19 Mar 2024 17:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B21551F24557
	for <lists+stable@lfdr.de>; Tue, 19 Mar 2024 16:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15289848D;
	Tue, 19 Mar 2024 16:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rhoCE2ye"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED808489
	for <stable@vger.kernel.org>; Tue, 19 Mar 2024 16:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710866291; cv=none; b=sR8/z7GLbhvN0VOeuV6qZiL+O3kDYAd4th76256rMDqdgwn9YkeYYDcq+e7LEcpwtq2m+V69b1Gi2jdaaoN6ByBLIWvsUE2wOyWxmjhuRh87MCMTFPMWFLCLKp69D939ZFaIFtw3xrvRoRj702z6S2LzTD+Snz2DvwRR32klRsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710866291; c=relaxed/simple;
	bh=qdxpb9s/3ZzmMPc5LWTU6SQvgxbUDwu27w9EKLDNpyQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=oL/E/kXzfz0iPOWAato7LvLiwqDDNmioidVm8GTk3aAKp31BSpMnGTt993fDcBDtI1bJFBaK1MpivIA1wfr1k8bUTNod+Ts5yyj/aqWglM0jN/1dVY95lrv8HLPzHt0fxjcOkMr/ACjE+UqGE58ikBY2g8AQ8EywovhRpodwYOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rhoCE2ye; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.128.218] (unknown [20.29.225.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5959320B74C0;
	Tue, 19 Mar 2024 09:38:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5959320B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1710866284;
	bh=uRrvj8CekPY9V0PfBwGgrmH2fJschcNm+3IJgC36OlU=;
	h=Date:To:Cc:From:Subject:From;
	b=rhoCE2ye1q7QBrK99E0LfmlkEOQhZg9z8hbueWWeWyC9FYxZBlJcl88cdd7XyS3KK
	 2pOGLl3EnQbIgRaFBxauOkgl5pNjTpkakzfkjI8/IUB6BOfGEkUVOVSxtBQiF/p0sM
	 iaEHxUTMAKPS94sUiRt5oBYvwps4W14DEQxTPuL0=
Message-ID: <6df99ad6-0402-4dcf-9a1c-7259436768dd@linux.microsoft.com>
Date: Tue, 19 Mar 2024 09:38:03 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-CA
To: gregkh@linuxfoundation.org, Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 Jarred White <jarredwhite@linux.microsoft.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Subject: [PATCH 5.15.y] ACPI: CPPC: Use access_width over bit_width for system
 memory accesses
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Greg, Sasha,

commit 2f4a4d63a193be6fd530d180bb13c3592052904c upstream is marked for 5.15+ with CC: stable@vger.kernel.org, but the
application will fail with a merge conflict due to missing intermediate feature patches. When you apply the patch to 5.15, 
could you take the backport below instead?

Thanks,
Easwar
PS: It will apply cleanly to the other stable branches.

----8x--------------------------

From ab7a492bcec34a3ad4ae4e2a6ad0e7e1c4fc783a Mon Sep 17 00:00:00 2001
From: Jarred White <jarredwhite@linux.microsoft.com>
Date: Fri, 1 Mar 2024 11:25:59 -0800
Subject: [PATCH 1/1] ACPI: CPPC: Use access_width over bit_width for system
 memory accesses

commit 2f4a4d63a193be6fd530d180bb13c3592052904c upstream

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
[ eahariha: Backport to v5.15 by dropping SystemIO bits as
  commit a2c8f92bea5f is not present ]
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 drivers/acpi/cppc_acpi.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 7cc9183c8dc8..408b1fda5702 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -161,6 +161,13 @@ show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, nominal_freq);
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
@@ -762,8 +769,10 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 			} else if (gas_t->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
 				if (gas_t->address) {
 					void __iomem *addr;
+					size_t access_width;
 
-					addr = ioremap(gas_t->address, gas_t->bit_width/8);
+					access_width = GET_BIT_WIDTH(gas_t) / 8;
+					addr = ioremap(gas_t->address, access_width);
 					if (!addr)
 						goto out_free;
 					cpc_ptr->cpc_regs[i-2].sys_mem_vaddr = addr;
@@ -936,6 +945,7 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 {
 	int ret_val = 0;
 	void __iomem *vaddr = NULL;
+	int size;
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
 	struct cpc_reg *reg = &reg_res->cpc_entry.reg;
 
@@ -955,7 +965,9 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 		return acpi_os_read_memory((acpi_physical_address)reg->address,
 				val, reg->bit_width);
 
-	switch (reg->bit_width) {
+	size = GET_BIT_WIDTH(reg);
+
+	switch (size) {
 	case 8:
 		*val = readb_relaxed(vaddr);
 		break;
@@ -974,12 +986,16 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 		ret_val = -EFAULT;
 	}
 
+	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
+		*val = MASK_VAL(reg, *val);
+
 	return ret_val;
 }
 
 static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 {
 	int ret_val = 0;
+	int size;
 	void __iomem *vaddr = NULL;
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
 	struct cpc_reg *reg = &reg_res->cpc_entry.reg;
@@ -994,7 +1010,12 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
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
2.34.1

-----------------------------------x8-------

