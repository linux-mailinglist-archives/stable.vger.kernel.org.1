Return-Path: <stable+bounces-79405-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 333F798D816
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A99201F22D3A
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF751D07B7;
	Wed,  2 Oct 2024 13:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H9FLjdB0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BC61D079D;
	Wed,  2 Oct 2024 13:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877352; cv=none; b=CLPVj2Nyyf161sRr4AepBx4o9EL0+qdwEl7oYBeCIimab0PBOOArUaBUEBYawSltjj2tJIDS8Y+zwZq5Ert5y8QBFjbzHtskDUXlLhIfZEi/ayxnmZKSzdKspZj9rXKdjyTmx735veV3HaOUC6obgQsooK/XQzspDWm425oP0CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877352; c=relaxed/simple;
	bh=WjHqUKauRXIkQd41dlLIxELO7v+AZIETxJ0baV110ew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QpXJLEMgCvMSt4pqn4Xp0aI7TDB4a3aW4FqKfyki5UlEVLYEYbuugzT72/dZUlsdGMgxKpii8REuLvaJQMYScZle0YCAsL/spgxWPOukrwbRBTJV04ERqDgrIakFC4aSJb4oen/6eLsSUdxG2GHeQ6t9BZPBHIJwSmoEDiG7dak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H9FLjdB0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B35FC4AF09;
	Wed,  2 Oct 2024 13:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727877352;
	bh=WjHqUKauRXIkQd41dlLIxELO7v+AZIETxJ0baV110ew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H9FLjdB0JwukCtHXgjZUy99kQ46TtxWTLvanmFTiagz3UbE9whUZ6ERpHGHuMNFaD
	 iKJJkkaSdIGjUQ11uOHTvBUxVABbs0jtv+BZ00T/EMzJF655fnFMSyEIcTdFdSLAPI
	 NhREjSqGqm+4Ru2r4oqS3WPswCkhuvUJMA1H5ysw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 052/634] ACPI: CPPC: Fix MASK_VAL() usage
Date: Wed,  2 Oct 2024 14:52:32 +0200
Message-ID: <20241002125813.158611345@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125811.070689334@linuxfoundation.org>
References: <20241002125811.070689334@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Clément Léger <cleger@rivosinc.com>

[ Upstream commit 60949b7b805424f21326b450ca4f1806c06d982e ]

MASK_VAL() was added as a way to handle bit_offset and bit_width for
registers located in system memory address space. However, while suited
for reading, it does not work for writing and result in corrupted
registers when writing values with bit_offset > 0. Moreover, when a
register is collocated with another one at the same address but with a
different mask, the current code results in the other registers being
overwritten with 0s. The write procedure for SYSTEM_MEMORY registers
should actually read the value, mask it, update it and write it with the
updated value. Moreover, since registers can be located in the same
word, we must take care of locking the access before doing it. We should
potentially use a global lock since we don't know in if register
addresses aren't shared with another _CPC package but better not
encourage vendors to do so. Assume that registers can use the same word
inside a _CPC package and thus, use a per _CPC package lock.

Fixes: 2f4a4d63a193 ("ACPI: CPPC: Use access_width over bit_width for system memory accesses")
Signed-off-by: Clément Léger <cleger@rivosinc.com>
Link: https://patch.msgid.link/20240826101648.95654-1-cleger@rivosinc.com
[ rjw: Dropped redundant semicolon ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/cppc_acpi.c | 43 ++++++++++++++++++++++++++++++++++++----
 include/acpi/cppc_acpi.h |  2 ++
 2 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 1d857978f5f40..2a588e4ed4af4 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -170,8 +170,11 @@ show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, wraparound_time);
 #define GET_BIT_WIDTH(reg) ((reg)->access_width ? (8 << ((reg)->access_width - 1)) : (reg)->bit_width)
 
 /* Shift and apply the mask for CPC reads/writes */
-#define MASK_VAL(reg, val) (((val) >> (reg)->bit_offset) & 			\
+#define MASK_VAL_READ(reg, val) (((val) >> (reg)->bit_offset) &				\
 					GENMASK(((reg)->bit_width) - 1, 0))
+#define MASK_VAL_WRITE(reg, prev_val, val)						\
+	((((val) & GENMASK(((reg)->bit_width) - 1, 0)) << (reg)->bit_offset) |		\
+	((prev_val) & ~(GENMASK(((reg)->bit_width) - 1, 0) << (reg)->bit_offset)))	\
 
 static ssize_t show_feedback_ctrs(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
@@ -857,6 +860,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 
 	/* Store CPU Logical ID */
 	cpc_ptr->cpu_id = pr->id;
+	spin_lock_init(&cpc_ptr->rmw_lock);
 
 	/* Parse PSD data for this CPU */
 	ret = acpi_get_psd(cpc_ptr, handle);
@@ -1062,7 +1066,7 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 	}
 
 	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
-		*val = MASK_VAL(reg, *val);
+		*val = MASK_VAL_READ(reg, *val);
 
 	return 0;
 }
@@ -1071,9 +1075,11 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 {
 	int ret_val = 0;
 	int size;
+	u64 prev_val;
 	void __iomem *vaddr = NULL;
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
 	struct cpc_reg *reg = &reg_res->cpc_entry.reg;
+	struct cpc_desc *cpc_desc;
 
 	size = GET_BIT_WIDTH(reg);
 
@@ -1106,8 +1112,34 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 		return acpi_os_write_memory((acpi_physical_address)reg->address,
 				val, size);
 
-	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
-		val = MASK_VAL(reg, val);
+	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
+		cpc_desc = per_cpu(cpc_desc_ptr, cpu);
+		if (!cpc_desc) {
+			pr_debug("No CPC descriptor for CPU:%d\n", cpu);
+			return -ENODEV;
+		}
+
+		spin_lock(&cpc_desc->rmw_lock);
+		switch (size) {
+		case 8:
+			prev_val = readb_relaxed(vaddr);
+			break;
+		case 16:
+			prev_val = readw_relaxed(vaddr);
+			break;
+		case 32:
+			prev_val = readl_relaxed(vaddr);
+			break;
+		case 64:
+			prev_val = readq_relaxed(vaddr);
+			break;
+		default:
+			spin_unlock(&cpc_desc->rmw_lock);
+			return -EFAULT;
+		}
+		val = MASK_VAL_WRITE(reg, prev_val, val);
+		val |= prev_val;
+	}
 
 	switch (size) {
 	case 8:
@@ -1134,6 +1166,9 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 		break;
 	}
 
+	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
+		spin_unlock(&cpc_desc->rmw_lock);
+
 	return ret_val;
 }
 
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 930b6afba6f4d..e1720d9306669 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -64,6 +64,8 @@ struct cpc_desc {
 	int cpu_id;
 	int write_cmd_status;
 	int write_cmd_id;
+	/* Lock used for RMW operations in cpc_write() */
+	spinlock_t rmw_lock;
 	struct cpc_register_resource cpc_regs[MAX_CPC_REG_ENT];
 	struct acpi_psd_package domain_info;
 	struct kobject kobj;
-- 
2.43.0




