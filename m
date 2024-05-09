Return-Path: <stable+bounces-43509-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEBC8C1594
	for <lists+stable@lfdr.de>; Thu,  9 May 2024 21:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F28D01F22399
	for <lists+stable@lfdr.de>; Thu,  9 May 2024 19:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400C97F7CA;
	Thu,  9 May 2024 19:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="V6PfO++/"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A79C7F7FD
	for <stable@vger.kernel.org>; Thu,  9 May 2024 19:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715283714; cv=none; b=RNdPezWJNaxL5Ts9+Z+jRd0EuAOUkrTiY3XyZoJOUCjSrNuNa8G2GbXoCnLYiv3suHC5I7CUmc9UUKDqwX1z8Ku6jKkOMRWrH+22ljbYH7X971WZ7ers2myvb0OS6rxslyIuZI3ZGjPs89AFJ5w9pVhI+WZpGueQv0nolA4Wu+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715283714; c=relaxed/simple;
	bh=lNp+95mly2eKv4VwNlVNd1q/vAfj3GphXlx6stO5Hfk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oMXOJChceI0/98TT+w5S+6pLymeQtQ1zWN74Mlgz8JYsZb7JoXtIBFajmgI/ZEGO1kEOsQpwsN0FtJvmvtcABi0QvfQuddF6l7wECwa6NlHeDdjiU8hgt3kOeB9bWcp9Nhth428QGmq1NE70dksimCp9qxt23JXYzOib+9EkWoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=V6PfO++/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from rrs24-12-35.corp.microsoft.com (unknown [167.220.2.16])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4816D20B2C8C;
	Thu,  9 May 2024 12:41:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4816D20B2C8C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1715283712;
	bh=IvNq9w749KY0YOSjNLxdO3HqEYq36wTwF5VzhdqlNm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V6PfO++/N3bfqJ3eMCL4FB6IaGmos7daGLAHGyCPpHhFX8/Vhn2vbKb8p2j+O7FgS
	 1U9/WP6n28nph+lghPZKEJDoGb2J/K3wmpNVZ05rKLDtzsYoMpX6u5kvNu7r4wONTw
	 I6J9f3IN58lzzvctOESLMi3/Wh4wwRiVm8b7nGmw=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
To: stable@vger.kernel.org
Cc: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
	Jarred White <jarredwhite@linux.microsoft.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH RESEND 5.15.y 3/3] ACPI: CPPC: Fix access width used for PCC registers
Date: Thu,  9 May 2024 19:41:26 +0000
Message-Id: <20240509194126.3020424-4-eahariha@linux.microsoft.com>
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

From: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>

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
[ eahariha: Backport to v5.15 by dropping SystemIO bits as commit
  a2c8f92bea5f is not present ]
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 drivers/acpi/cppc_acpi.c | 48 ++++++++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 6aa456cda0ed9..6dcce036adb9c 100644
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


