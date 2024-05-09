Return-Path: <stable+bounces-43508-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7D28C1593
	for <lists+stable@lfdr.de>; Thu,  9 May 2024 21:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFB071C21F39
	for <lists+stable@lfdr.de>; Thu,  9 May 2024 19:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B877FBAE;
	Thu,  9 May 2024 19:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TDi/9/4e"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1057F7D3
	for <stable@vger.kernel.org>; Thu,  9 May 2024 19:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715283713; cv=none; b=c4MQnVkar4IbX67PXVcjDws8hZxZ06u/SQFNdG6BmaOwBBWRpBGZL7JDNG4GUCQ92a/9B/NBFG2B83/8zxrH2r/qXD67tzRqygc1Bbx9Tet+CyuWZxiQj6LIBo1/khffZlqH8Zn4RZDfkCKe2iR91pIGEFWWACrdE9Q5t4fKCA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715283713; c=relaxed/simple;
	bh=+vYrskgsBpRY+HrcD1V+wbV+I1/9szPdTnLm4sMGOB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H/vUdSf5Afma9iKfe9R6ZR+Ud2rxYR/BMdFg43+zX0vawI2Ubw+We2F1Q3h5LAtzrgbJKx8yzQUCA9Fixj6AzHc5dU7Y+e7EziEFaRqcX81bhOSh6iLapsQSom7gDHLNMRmh/+FP4mfTk481NkZzHgypoPl9Jt48WZQMT8KPYm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TDi/9/4e; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from rrs24-12-35.corp.microsoft.com (unknown [167.220.2.16])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2469120B2C8A;
	Thu,  9 May 2024 12:41:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2469120B2C8A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1715283712;
	bh=zANK+j4ValtmPuu9cty0yZOY76EfAKzLMaPvWYf/qZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TDi/9/4eOhSNOtRQh6g11oqQIXuQEgw7K6txCLTGSBDF62rd+eFl1XEKD4oSf26xT
	 hrUFNbT6G5XmSqWPkez7bDuMm2kXcJ4HZYiUoIlwW/HElatLuqrZa2nRZxxMgNP+iu
	 1GlkcRHY0Uvfv+Iyu75kgK/4UkQFCEH4YZT8N0nw=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
To: stable@vger.kernel.org
Cc: Jarred White <jarredwhite@linux.microsoft.com>,
	Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>
Subject: [PATCH RESEND 5.15.y 2/3] ACPI: CPPC: Fix bit_offset shift in MASK_VAL() macro
Date: Thu,  9 May 2024 19:41:25 +0000
Message-Id: <20240509194126.3020424-3-eahariha@linux.microsoft.com>
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

From: Jarred White <jarredwhite@linux.microsoft.com>

commit 05d92ee782eeb7b939bdd0189e6efcab9195bf95 upstream

Commit 2f4a4d63a193 ("ACPI: CPPC: Use access_width over bit_width for
system memory accesses") neglected to properly wrap the bit_offset shift
when it comes to applying the mask. This may cause incorrect values to be
read and may cause the cpufreq module not be loaded.

[   11.059751] cpu_capacity: CPU0 missing/invalid highest performance.
[   11.066005] cpu_capacity: partial information: fallback to 1024 for all CPUs

Also, corrected the bitmask generation in GENMASK (extra bit being added).

Fixes: 2f4a4d63a193 ("ACPI: CPPC: Use access_width over bit_width for system memory accesses")
Signed-off-by: Jarred White <jarredwhite@linux.microsoft.com>
Cc: 5.15+ <stable@vger.kernel.org> # 5.15+
Reviewed-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 drivers/acpi/cppc_acpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 408b1fda5702d..6aa456cda0ed9 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -165,8 +165,8 @@ show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, wraparound_time);
 #define GET_BIT_WIDTH(reg) ((reg)->access_width ? (8 << ((reg)->access_width - 1)) : (reg)->bit_width)
 
 /* Shift and apply the mask for CPC reads/writes */
-#define MASK_VAL(reg, val) ((val) >> ((reg)->bit_offset & 			\
-					GENMASK(((reg)->bit_width), 0)))
+#define MASK_VAL(reg, val) (((val) >> (reg)->bit_offset) & 			\
+					GENMASK(((reg)->bit_width) - 1, 0))
 
 static ssize_t show_feedback_ctrs(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
-- 
2.34.1


