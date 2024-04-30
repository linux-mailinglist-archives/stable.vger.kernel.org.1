Return-Path: <stable+bounces-42827-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6787C8B7F80
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 20:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 968041C22ED3
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 18:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B9B181CF6;
	Tue, 30 Apr 2024 18:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="l6b+DOed"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF52319DF53
	for <stable@vger.kernel.org>; Tue, 30 Apr 2024 18:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714500597; cv=none; b=WuB+jfzphTx+In75fub+apMcxfT+0EbuInvF4rhU6j6wMVTFojVKrMOQ75HoYtrIGsgxCukxDsK+yW9+P0XXZomzxUfO4iW60qhMsNvl8Si12sopl956sDlqwcfSGiGwnM/h4v/0nx1hyK3+orvJI4N4ORXt2doUvlEwJteB/Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714500597; c=relaxed/simple;
	bh=4sjk6mgI0gCOw3DUCHNMAdkwJtHwhsGRlysXBG5WNws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TRXbdlDiEnm/HaJN6TiyxxnIiRxp9pR/LYj/Qciz9W1k8ie1MB1F+QJHz2tKPOdlH4nl2ce2t2zzPBV3uHJ9JiDTbOdAbHwTICutCkPW3weEY+uLRluuc5xifKWGpExFsb6RRifLLe+/F7RFCLrCtNy3wyJ+WXmFGulEEJEIdjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=l6b+DOed; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from rrs24-12-35.corp.microsoft.com (unknown [167.220.2.144])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4534521112E0;
	Tue, 30 Apr 2024 11:09:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4534521112E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1714500596;
	bh=r/WYT/zLrRXk6O/IYpd2RarVALMqkgrZTYTTKhjXwhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l6b+DOedyuQg4a+2BWJ1xHEP3awf4xwl4QjNZCMD9CPbOqbeNy4vXxMXclSFnlqjH
	 3gDMkMjHuk20geQvKxYcAyH1F7QBZTJhqr+1pxqf5M4yhgIOZt2lUldRcupYJFF4q7
	 LxtGIiBTi4pBjreRywCnqT85kk+yG1J0xRvp4slg=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
To: stable@vger.kernel.org
Cc: Jarred White <jarredwhite@linux.microsoft.com>,
	Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>
Subject: [PATCH 5.15.y 2/3] ACPI: CPPC: Fix bit_offset shift in MASK_VAL() macro
Date: Tue, 30 Apr 2024 18:09:47 +0000
Message-Id: <20240430180948.1435834-2-eahariha@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430180948.1435834-1-eahariha@linux.microsoft.com>
References: <2024042905-puppy-heritage-e422@gregkh>
 <20240430180948.1435834-1-eahariha@linux.microsoft.com>
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
index 408b1fda5702..6aa456cda0ed 100644
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


