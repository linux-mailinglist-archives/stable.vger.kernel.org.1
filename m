Return-Path: <stable+bounces-42826-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BD88B7F7F
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 20:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 276EA1C22614
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 18:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17245180A85;
	Tue, 30 Apr 2024 18:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Eto3Mt4l"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B4519DF51
	for <stable@vger.kernel.org>; Tue, 30 Apr 2024 18:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714500597; cv=none; b=S4MEslNfVlkSNX/46yyglen9T2Hj5RfF1UkTpKIWN13S1Bm4X2vq8jIYTmY7As2GtSAN4Nlq2MoUZ3dUv97jaigi/6BxMcAam95ck4kz3StEvLdxm/7c/fAmSx/HnSUX6hh0E50b+QmyMslcm0yQcI2qL6+vONtJQdc75wwbStk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714500597; c=relaxed/simple;
	bh=GQPFv/Ah8qRWX1KCc2Dt5i6p5aH0SUdx9uMMOus84rI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mOVGS9TVhQ6EfWvpFCJVPbZCCe0B3H1RatnB06UTEO/4gm58kpRl7ab6qiFG94kunuS2cwkpRh4LjLsJ0VWzf6ApSwizVctMVpcsLCJ95T/1eOXJ8fkXzmszBK1caAmwqWmzFmwdIGhsN4vdm/y0tjRno7z6EOlk/AclmCOJUcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Eto3Mt4l; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from rrs24-12-35.corp.microsoft.com (unknown [167.220.2.144])
	by linux.microsoft.com (Postfix) with ESMTPSA id 218C4210FBDF;
	Tue, 30 Apr 2024 11:09:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 218C4210FBDF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1714500596;
	bh=b19LMpTh3WUNSVVQSRlitWFJo22xnjW+aQwr7P24p4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Eto3Mt4lWyTo7oe1lRRwzwBwqLUwt3OTtJhYcpkQ4J2ISesPAT5zqs5KUKhRC+y2J
	 MPjkNFgO59/xp9MFCjafG9rxI7TQjcHcUW8q/7kOg80XHt1hXaEyMx6eVD5IhnNCEs
	 /XWBIGK03SDmF8na25+JmQT8H6ZUckV9E3Zjh30w=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
To: stable@vger.kernel.org
Cc: Easwar Hariharan <eahariha@linux.microsoft.com>,
	Jarred White <jarredwhite@linux.microsoft.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.15.y 1/3] Revert "Revert "ACPI: CPPC: Use access_width over bit_width for system memory accesses""
Date: Tue, 30 Apr 2024 18:09:46 +0000
Message-Id: <20240430180948.1435834-1-eahariha@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2024042905-puppy-heritage-e422@gregkh>
References: <2024042905-puppy-heritage-e422@gregkh>
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

The original commit[1] fixed a kernel panic on boot on the Microsoft
Azure Cobalt 100 platform, but as reported by Vanshidhar Konda [2],
caused a regression in AmpereOne systems. While testing [2], there was
an additional bug found in [1] which resulted in [3]

[1] commit 2f4a4d63a193 ("ACPI: CPPC: Use access_width over bit_width for system memory accesses")
[2] commit f489c948028b ("ACPI: CPPC: Fix access width used for PCC registers")
[3] commit 05d92ee782ee ("ACPI: CPPC: Fix bit_offset shift in MASK_VAL() macro").

Cc: Jarred White <jarredwhite@linux.microsoft.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

base-commit: b925f60c6ee7ec871d2d48575d0fde3872129c20
-- 
2.34.1


