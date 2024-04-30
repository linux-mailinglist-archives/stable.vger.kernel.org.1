Return-Path: <stable+bounces-42805-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 798718B7C79
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 18:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2677B2842D4
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 16:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D33E132C15;
	Tue, 30 Apr 2024 16:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GbDidP89"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8211527B1
	for <stable@vger.kernel.org>; Tue, 30 Apr 2024 16:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714493133; cv=none; b=gSkuHLGaIYd/0vOBNB1qKXJWTCeJNCrcMu2XjPrxD2/OBr0dm8U4dehECnlcD/wGqy07Co0MVPTZyGXYEGA4ZIAdu27E+4HQqvVm/G4eLRubJVtaIZTWhVxZY/luvSY6bJTPM76qN4M5CoY4nVqkF+mwjyRW9wWxwf7MHzDe2ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714493133; c=relaxed/simple;
	bh=lIEddZUcZaBOljTrJx8m0K3MclZOU/1/cmQlfdnOh7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Z691xtunFnZ3szPTt2IWg5TuXwdl2PCjbRp0tRhPmXK/tp2SsII7JQAMuMY320fL1bkyrriTQCVwHfsxj9sIqj2W8YyuAvkFqEJ0jqsMTqKW90LlSSLzOdvQUEEsLTtrHc0yptHFAeQ8tldnxxX52vZL95vvstqfzJ6qnk3UqXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GbDidP89; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.32.120] (unknown [20.236.11.29])
	by linux.microsoft.com (Postfix) with ESMTPSA id D2A09210FBD9;
	Tue, 30 Apr 2024 09:05:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D2A09210FBD9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1714493131;
	bh=ONUFyfDi5nlxIUE4KTnAh4qS2rc7xZgrzsgFW6I+XbM=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=GbDidP89KPQYA51Y6c+C6h61MSvITO+J0Qc41zOqTx2RsskiRBpcf+B1AGS5Ggm6m
	 3jrOj6CB7I64KN7NF2loAYrcOAjvm+NkYIah3KA+xl+vyslmLchLBl9aWynr3x4QI9
	 U4t6lkwwjkfl5DnF7y/4vTUPt0alveTO3QQc98g8=
Message-ID: <24df5fe0-9e1a-4929-b132-3654ec9d8bf3@linux.microsoft.com>
Date: Tue, 30 Apr 2024 09:05:28 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] ACPI: CPPC: Fix access width used for PCC
 registers" failed to apply to 5.15-stable tree
To: gregkh@linuxfoundation.org, vanshikonda@os.amperecomputing.com,
 jarredwhite@linux.microsoft.com, rafael.j.wysocki@intel.com,
 stable@vger.kernel.org
References: <2024042905-puppy-heritage-e422@gregkh>
Content-Language: en-CA
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <2024042905-puppy-heritage-e422@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/29/2024 4:53 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.15-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
> git checkout FETCH_HEAD
> git cherry-pick -x f489c948028b69cea235d9c0de1cc10eeb26a172
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042905-puppy-heritage-e422@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..
> 
> Possible dependencies:
> 
> f489c948028b ("ACPI: CPPC: Fix access width used for PCC registers")
> 2f4a4d63a193 ("ACPI: CPPC: Use access_width over bit_width for system memory accesses")
> 0651ab90e4ad ("ACPI: CPPC: Check _OSC for flexible address space")
> c42fa24b4475 ("ACPI: bus: Avoid using CPPC if not supported by firmware")
> 2ca8e6285250 ("Revert "ACPI: Pass the same capabilities to the _OSC regardless of the query flag"")
> f684b1075128 ("ACPI: CPPC: Drop redundant local variable from cpc_read()")
> 5f51c7ce1dc3 ("ACPI: CPPC: Fix up I/O port access in cpc_read()")
> a2c8f92bea5f ("ACPI: CPPC: Implement support for SystemIO registers")
> 
> thanks,
> 
> greg k-h
> 

Hi Greg,

Please fix this with the following set of changes in linux-5.15.y.

Revert b54c4632946ae42f2b39ed38abd909bbf78cbcc2 from linux-5.15.y
Cherry-pick 05d92ee782eeb7b939bdd0189e6efcab9195bf95 from upstream
Pick the following backport of f489c948028b69cea235d9c0de1cc10eeb26a172 from upstream


----------------------x8-------------------------------------------------
From d3260c1d3c9021d3f1b9aa4cf5c85e7501dacbdf Mon Sep 17 00:00:00 2001
From: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
Date: Thu, 11 Apr 2024 16:18:44 -0700
Subject: [PATCH] ACPI: CPPC: Fix access width used for PCC registers

commit f489c948028b69cea235d9c0de1cc10eeb26a172 upstream

commit 2f4a4d63a193 ("ACPI: CPPC: Use access_width over bit_width for system
memory accesses") modified cpc_read()/cpc_write() to use access_width to
read CPC registers.

However, for PCC registers the access width field in the ACPI register
macro specifies the PCC subspace ID.  For non-zero PCC subspace ID it is
incorrectly treated as access width. This causes errors when reading
from PCC registers in the CPPC driver.

For PCC registers, base the size of read/write on the bit width field.
The debug message in cpc_read()/cpc_write() is updated to print relevant
information for the address space type used to read the register.

Fixes: 2f4a4d63a193 ("ACPI: CPPC: Use access_width over bit_width for system memory accesses")
Signed-off-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
Tested-by: Jarred White <jarredwhite@linux.microsoft.com>
Reviewed-by: Jarred White <jarredwhite@linux.microsoft.com>
Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: 5.15+ <stable@vger.kernel.org> # 5.15+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 drivers/acpi/cppc_acpi.c | 48 ++++++++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 6aa456cda0ed..6dcce036adb9 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -955,17 +955,24 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 	}
 
 	*val = 0;
-	if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM && pcc_ss_id >= 0)
+	size = GET_BIT_WIDTH(reg);
+
+	if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM && pcc_ss_id >= 0) {
+		/*
+		 * For registers in PCC space, the register size is determined
+		 * by the bit width field; the access size is used to indicate
+		 * the PCC subspace id.
+		 */
+		size = reg->bit_width;
 		vaddr = GET_PCC_VADDR(reg->address, pcc_ss_id);
+	}
 	else if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
 		vaddr = reg_res->sys_mem_vaddr;
 	else if (reg->space_id == ACPI_ADR_SPACE_FIXED_HARDWARE)
 		return cpc_read_ffh(cpu, reg, val);
 	else
 		return acpi_os_read_memory((acpi_physical_address)reg->address,
-				val, reg->bit_width);
-
-	size = GET_BIT_WIDTH(reg);
+				val, size);
 
 	switch (size) {
 	case 8:
@@ -981,8 +988,13 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 		*val = readq_relaxed(vaddr);
 		break;
 	default:
-		pr_debug("Error: Cannot read %u bit width from PCC for ss: %d\n",
-			 reg->bit_width, pcc_ss_id);
+		if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
+			pr_debug("Error: Cannot read %u bit width from system memory: 0x%llx\n",
+				size, reg->address);
+		} else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM) {
+			pr_debug("Error: Cannot read %u bit width from PCC for ss: %d\n",
+				size, pcc_ss_id);
+		}
 		ret_val = -EFAULT;
 	}
 
@@ -1000,17 +1012,24 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
 	struct cpc_reg *reg = &reg_res->cpc_entry.reg;
 
-	if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM && pcc_ss_id >= 0)
+	size = GET_BIT_WIDTH(reg);
+
+	if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM && pcc_ss_id >= 0) {
+		/*
+		 * For registers in PCC space, the register size is determined
+		 * by the bit width field; the access size is used to indicate
+		 * the PCC subspace id.
+		 */
+		size = reg->bit_width;
 		vaddr = GET_PCC_VADDR(reg->address, pcc_ss_id);
+	}
 	else if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
 		vaddr = reg_res->sys_mem_vaddr;
 	else if (reg->space_id == ACPI_ADR_SPACE_FIXED_HARDWARE)
 		return cpc_write_ffh(cpu, reg, val);
 	else
 		return acpi_os_write_memory((acpi_physical_address)reg->address,
-				val, reg->bit_width);
-
-	size = GET_BIT_WIDTH(reg);
+				val, size);
 
 	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
 		val = MASK_VAL(reg, val);
@@ -1029,8 +1048,13 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 		writeq_relaxed(val, vaddr);
 		break;
 	default:
-		pr_debug("Error: Cannot write %u bit width to PCC for ss: %d\n",
-			 reg->bit_width, pcc_ss_id);
+		if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
+			pr_debug("Error: Cannot write %u bit width to system memory: 0x%llx\n",
+				size, reg->address);
+		} else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM) {
+			pr_debug("Error: Cannot write %u bit width to PCC for ss: %d\n",
+				size, pcc_ss_id);
+		}
 		ret_val = -EFAULT;
 		break;
 	}
-- 
2.34.1

----------------------8x-------------------------------------------------

Thanks,
Easwar


