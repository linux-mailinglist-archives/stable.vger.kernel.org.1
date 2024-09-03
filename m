Return-Path: <stable+bounces-72851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 968B496A76B
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 21:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FD2328623E
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 19:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334FC18E752;
	Tue,  3 Sep 2024 19:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ariadne.space header.i=@ariadne.space header.b="Hy1C+/ef"
X-Original-To: stable@vger.kernel.org
Received: from mr85p00im-zteg06022001.me.com (mr85p00im-zteg06022001.me.com [17.58.23.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9691D7E3C
	for <stable@vger.kernel.org>; Tue,  3 Sep 2024 19:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725392178; cv=none; b=mmzMDD9cduVxnczZnGKnOXsej89zzBQI0F7iVki/7D6yrVCN7+9MbITil3yv73RjaTPrpEBBLS8zB7RZQ1gjNjCXuDDjhUttCTVM24a0F3BucA2CuJNSIm+zqg8GUX4vDJFOCMziOwn+9YFetmF1ubpZI72hXa3BnCgqftKLv3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725392178; c=relaxed/simple;
	bh=JXct41mpC46zMfR0VjYHFnnyn1bKwli6r6H3TbpWtBE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Sj6nNlEzKL49BAx7u8aEJ2EmgCDmBlblp3VlHQcZYgq4BGkNqv6hqZso4wgIPSJgJQHGWrhtY/gIYEJaolmu9O9vp5Wwpvb4m1Glkc+YmwAquMi09L12uknHs6X9R8xqsZ8djZyLH34RC0UP02LntK8sktjtoZJZARG8hkAlgtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ariadne.space; spf=pass smtp.mailfrom=ariadne.space; dkim=pass (2048-bit key) header.d=ariadne.space header.i=@ariadne.space header.b=Hy1C+/ef; arc=none smtp.client-ip=17.58.23.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ariadne.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ariadne.space
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ariadne.space;
	s=sig1; t=1725392174;
	bh=a0kDGr9W1Gp83n1nFqoIN2Hws0xuwD700h4sXyr7P18=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Hy1C+/efSahVGtDwX3hmIa3AudkL97YZ/Hl12PRJhSGYYwfMlCVgjzrSfILDT7ztR
	 YrFjQDzzI9iDnqz74efwDRhPV/fRTu3oWqCNdAj3LC2l04f2+aZ2oMh3CnEPsCq2+q
	 2ARAaJDyvvTDw4VZGFdtdHlNyho0lJTEiuPTMeQ8czCyzbovAG3URsTc59+ZRjqxTt
	 ttfKG21MaiwlOBy9aZrmna+MHlpPdL5L/p8XX/dMC+lTZ9WvcDVdrMSJSeNzNq7b4q
	 ekYcZ56mr4szEkTSRsppxZ3LTC8fhYX63kYq/AbK2Zc4+USzTj2NgiV0POTc1ceBPL
	 eQ4bmHFbRVHHw==
Received: from penelo.taild41b8.ts.net (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-zteg06022001.me.com (Postfix) with ESMTPSA id 39F63800278;
	Tue,  3 Sep 2024 19:36:14 +0000 (UTC)
From: Ariadne Conill <ariadne@ariadne.space>
To: linux-kernel@vger.kernel.org
Cc: Ariadne Conill <ariadne@ariadne.space>,
	x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	stable@vger.kernel.org
Subject: [PATCH] x86/topology: Tolerate lack of APIC when booting as Xen domU
Date: Tue,  3 Sep 2024 12:36:06 -0700
Message-Id: <20240903193606.49830-1-ariadne@ariadne.space>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: _1ZogPDegP1EUKEJJK9J6YwT300GH_Eo
X-Proofpoint-GUID: _1ZogPDegP1EUKEJJK9J6YwT300GH_Eo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-03_07,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 spamscore=0
 mlxlogscore=481 phishscore=0 mlxscore=0 adultscore=0 clxscore=1030
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409030157

Xen domU instances do not boot on x86 with ACPI enabled, so the entire
ACPI subsystem is ultimately disabled.  This causes acpi_mps_check()
to trigger a warning that the ACPI MPS table is not present, which then
disables APIC support on domU, breaking the CPU topology detection for
all vCPUs other than the boot vCPU.

Fixes: 7c0edad3643f ("x86/cpu/topology: Rework possible CPU management")
Signed-off-by: Ariadne Conill <ariadne@ariadne.space>
Cc: x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
---
 arch/x86/kernel/cpu/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 621a151ccf7d..38fa5ed816d6 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -429,7 +429,7 @@ void __init topology_apply_cmdline_limits_early(void)
 	unsigned int possible = nr_cpu_ids;
 
 	/* 'maxcpus=0' 'nosmp' 'nolapic' 'disableapic' 'noapic' */
-	if (!setup_max_cpus || ioapic_is_disabled || apic_is_disabled)
+	if (!setup_max_cpus || ioapic_is_disabled || (apic_is_disabled && !xen_pv_domain()))
 		possible = 1;
 
 	/* 'possible_cpus=N' */
-- 
2.39.2


