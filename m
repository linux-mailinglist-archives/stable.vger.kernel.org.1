Return-Path: <stable+bounces-41677-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E668B5729
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 13:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DF8C1F22089
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 11:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6284D5AC;
	Mon, 29 Apr 2024 11:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uRLReDHJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E684611D
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 11:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714391595; cv=none; b=Qs9AxurtiKhL+dREv+nclL2Ka7SrgSp/U0NBxBUxAssC3RvC1Hzjk0+hzAGK+4baTsC2j/AEUxw0WxJBC8b15Jl8i7X88oUYj9wkrQhLKSFhjOXRcu+BElqGE7ZTqZ/kZC5JiIbi7iO6mUJ3C/54AqBwJHfiEYSooLb07q+5trE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714391595; c=relaxed/simple;
	bh=kLERLQm57qouNlRrEC5KDRt2HcVBrI7KoCJt/6SDqic=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hdgHMjUBT9uyqclnvp7vTTxYuK7o6X7YeeLgjmtUqeRVubQscFl29t8UEbFd5wOZVheyLzr6Y+iIy6kVPAYP7+1eeluye1OiSKQHigenbNqeUqMNl9JRmuKT/JZ6vFX76oX6HV48wWt2x+9XDX+61Mm+bb8LPZNVUpRSr3zEABA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uRLReDHJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B086C113CD;
	Mon, 29 Apr 2024 11:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714391594;
	bh=kLERLQm57qouNlRrEC5KDRt2HcVBrI7KoCJt/6SDqic=;
	h=Subject:To:Cc:From:Date:From;
	b=uRLReDHJUmZHiFMVPB8tdxIG+WDAzIAOxaHm3QLyCRWPmdhpeF5fGH/86HD5SHxG3
	 ifXaTW9CwZW8CIIsTQmNNT0/upI2hKkcmRhivcLTqnFxD42/2HFLpRr7C2aQRkh824
	 UvCEX3vX8M/LiWJ1B7pfcgTaR4cP7YBMMoG2Otgc=
Subject: FAILED: patch "[PATCH] ACPI: CPPC: Fix access width used for PCC registers" failed to apply to 5.15-stable tree
To: vanshikonda@os.amperecomputing.com,eahariha@linux.microsoft.com,jarredwhite@linux.microsoft.com,rafael.j.wysocki@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Apr 2024 13:53:06 +0200
Message-ID: <2024042905-puppy-heritage-e422@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x f489c948028b69cea235d9c0de1cc10eeb26a172
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042905-puppy-heritage-e422@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

f489c948028b ("ACPI: CPPC: Fix access width used for PCC registers")
2f4a4d63a193 ("ACPI: CPPC: Use access_width over bit_width for system memory accesses")
0651ab90e4ad ("ACPI: CPPC: Check _OSC for flexible address space")
c42fa24b4475 ("ACPI: bus: Avoid using CPPC if not supported by firmware")
2ca8e6285250 ("Revert "ACPI: Pass the same capabilities to the _OSC regardless of the query flag"")
f684b1075128 ("ACPI: CPPC: Drop redundant local variable from cpc_read()")
5f51c7ce1dc3 ("ACPI: CPPC: Fix up I/O port access in cpc_read()")
a2c8f92bea5f ("ACPI: CPPC: Implement support for SystemIO registers")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f489c948028b69cea235d9c0de1cc10eeb26a172 Mon Sep 17 00:00:00 2001
From: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
Date: Thu, 11 Apr 2024 16:18:44 -0700
Subject: [PATCH] ACPI: CPPC: Fix access width used for PCC registers

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

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 00a30ca35e78..a40b6f3946ef 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1002,14 +1002,14 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 	}
 
 	*val = 0;
+	size = GET_BIT_WIDTH(reg);
 
 	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
-		u32 width = GET_BIT_WIDTH(reg);
 		u32 val_u32;
 		acpi_status status;
 
 		status = acpi_os_read_port((acpi_io_address)reg->address,
-					   &val_u32, width);
+					   &val_u32, size);
 		if (ACPI_FAILURE(status)) {
 			pr_debug("Error: Failed to read SystemIO port %llx\n",
 				 reg->address);
@@ -1018,17 +1018,22 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 
 		*val = val_u32;
 		return 0;
-	} else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM && pcc_ss_id >= 0)
+	} else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM && pcc_ss_id >= 0) {
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
@@ -1044,8 +1049,13 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
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
 		return -EFAULT;
 	}
 
@@ -1063,12 +1073,13 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
 	struct cpc_reg *reg = &reg_res->cpc_entry.reg;
 
+	size = GET_BIT_WIDTH(reg);
+
 	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
-		u32 width = GET_BIT_WIDTH(reg);
 		acpi_status status;
 
 		status = acpi_os_write_port((acpi_io_address)reg->address,
-					    (u32)val, width);
+					    (u32)val, size);
 		if (ACPI_FAILURE(status)) {
 			pr_debug("Error: Failed to write SystemIO port %llx\n",
 				 reg->address);
@@ -1076,17 +1087,22 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 		}
 
 		return 0;
-	} else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM && pcc_ss_id >= 0)
+	} else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM && pcc_ss_id >= 0) {
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
@@ -1105,8 +1121,13 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
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


