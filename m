Return-Path: <stable+bounces-43510-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9348C1595
	for <lists+stable@lfdr.de>; Thu,  9 May 2024 21:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C62E1C214E8
	for <lists+stable@lfdr.de>; Thu,  9 May 2024 19:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C1F7FBA3;
	Thu,  9 May 2024 19:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Xp8X22H9"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65792C2ED
	for <stable@vger.kernel.org>; Thu,  9 May 2024 19:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715283714; cv=none; b=XAt/ZUdLiO1BCgswe39Q2L8VTuTdF0f7htJ0gtSmt6CNFsRUL0wLV6ZZl/haDAKM8KV/4dO1MnBXgJV3PM57pvsYmU1yUlLqlH7iPJoc2LU7zbfFKWb7GARkGrOzNs0XYnBk4PWqRKwTQBXrcH878VSNnZbxRKczYYsC/5YCDVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715283714; c=relaxed/simple;
	bh=x6l7HrvIWTSHmpmOkyUQ3KFcPGHuzGdiqviBi8ggMxc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J8Tj5J8wmemmU5Cfbru0FLdaDa2Y2g59e4tf1ItzPDqLI2fN9fW7L1rixq4ckZCRgTV9XQPM9Ws9EnQsewXOg2pyBh1KCjE7ac0R33CF40uoMuCdwgSZ3+/tlGt1GWkcHYxIbqK98ph1O4CVXjLSPFPoevQTgQ2lTmGGm8zy5J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Xp8X22H9; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from rrs24-12-35.corp.microsoft.com (unknown [167.220.2.16])
	by linux.microsoft.com (Postfix) with ESMTPSA id F3B4920B2C89;
	Thu,  9 May 2024 12:41:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F3B4920B2C89
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1715283712;
	bh=7qjOD3/7vZxg+PVqJ/WzZvlMVV8y0ikwwd22MsKYlVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xp8X22H9OeO/1KiLA4huvUYDB6JCeHPbU+0KrQ+GUYefINzzEMispvEKJBk31wJR6
	 3yqMQaKaBrBX8Nh3GsW7cLcJuiQAz02LjUhrQ38kA9UTx43Ljex3CU+qiM4z9kK+av
	 N12Jabt9plcGmt2ZQyIQD6fNWD0Ez5IGEF9NNepU=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
To: stable@vger.kernel.org
Cc: Easwar Hariharan <eahariha@linux.microsoft.com>,
	Jarred White <jarredwhite@linux.microsoft.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH RESEND 5.15.y 1/3] Revert "Revert "ACPI: CPPC: Use access_width over bit_width for system memory accesses""
Date: Thu,  9 May 2024 19:41:24 +0000
Message-Id: <20240509194126.3020424-2-eahariha@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240509194126.3020424-1-eahariha@linux.microsoft.com>
References: <20240509194126.3020424-1-eahariha@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit b54c4632946ae42f2b39ed38abd909bbf78cbcc2 which was a
revert of a backport of commit 2f4a4d63a193be6fd530d180bb13c3592052904c
upstream to 5.15.y.

Cc: Jarred White <jarredwhite@linux.microsoft.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 drivers/acpi/cppc_acpi.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 7cc9183c8dc8e..408b1fda5702d 100644
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


