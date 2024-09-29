Return-Path: <stable+bounces-78205-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8A1989347
	for <lists+stable@lfdr.de>; Sun, 29 Sep 2024 08:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B38B2858FB
	for <lists+stable@lfdr.de>; Sun, 29 Sep 2024 06:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053DC47F53;
	Sun, 29 Sep 2024 06:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RpY5iw3p"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42BCBE4E;
	Sun, 29 Sep 2024 06:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727591756; cv=none; b=m5tU4Jo2eVYnOAojmAGmdEsgRGEblNx/awR8PG6hPO1syoX2sTF1Gnm2moM34Cam5Nt4OTKzkaa1DMJa0j+20lAuhp5CS5yJ9/FF9nYW2rvEm0ztGCtMJx7wAL6QGamu9cFN3O5EjvKxu+1Az0do6KrCBGPR0Rar3cMqR+x6ZOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727591756; c=relaxed/simple;
	bh=Ma89Q2H0tI7KFvwHNDPTwSNUcp1Ny6G8lx3EUAWcb3s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bvVNLvi7z/GegKEQ74asveD+UU6MjzgY35MnpzRoccAhbFBDhx8bBsZaofCWBVWiAmPAiy5+mpQk4lTtOHONXu5cZr4mnepm8/8LO31PZPdlVdsFcsST3/1qhq9XcRq90e8DNNeC32F19qQ/BzOowATHd9yzjg/8gtL8ZCswd4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RpY5iw3p; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727591755; x=1759127755;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ma89Q2H0tI7KFvwHNDPTwSNUcp1Ny6G8lx3EUAWcb3s=;
  b=RpY5iw3pkInF6FlUnHInG7Ay+ytEy84fZ8ulftFq8TmbW3BjnKmakIKr
   uvPTfAgJOvjctaWej9o7CYq99ayTLJPOzV9Bdx+gV/0dciayCQ8JLNfVC
   cuVI7eqmvYUkbklt9qc3PpNSE/JRwOfdNnvDqHqcXGr39+FNIjkL2PVo5
   XeLMct2e3ZWGaZRAGd8GooLOvDPJ+nO33z2AV7KaRoObXFXu0y6FuXvp3
   HzZiMNkt2WYQ+Xcv55Y0gH1twuvOcSRZv3o43ESEUrqnrorzXoTq0oKpW
   cJiBEZcuxTyjRcdB5y46GHEb1CWetrp9frU+oK93omDFpOTgdHnW/dgrF
   w==;
X-CSE-ConnectionGUID: ACVPcpCBT1u1Sjb5X3vTUQ==
X-CSE-MsgGUID: /TNuEICZSZK2w9Qzv0igRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11209"; a="29573896"
X-IronPort-AV: E=Sophos;i="6.11,162,1725346800"; 
   d="scan'208";a="29573896"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2024 23:35:54 -0700
X-CSE-ConnectionGUID: bTLtPI9uQciFseVQJ+n2ww==
X-CSE-MsgGUID: zs6mJmtCQ8GlZfga3C8Nfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,162,1725346800"; 
   d="scan'208";a="73254057"
Received: from unknown (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.245.243.113])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2024 23:35:49 -0700
From: Zhang Rui <rui.zhang@intel.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org
Cc: hpa@zytor.com,
	peterz@infradead.org,
	thorsten.blum@toblux.com,
	yuntao.wang@linux.dev,
	tony.luck@intel.com,
	suresh.b.siddha@intel.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] x86/apic: Stop the TSC Deadline timer during lapic timer shutdown
Date: Sun, 29 Sep 2024 14:35:21 +0800
Message-Id: <20240929063521.17284-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to Intel SDM, for the local APIC timer,
1. "The initial-count register is a read-write register. A write of 0 to
   the initial-count register effectively stops the local APIC timer, in
   both one-shot and periodic mode."
2. "In TSC deadline mode, writes to the initial-count register are
   ignored; and current-count register always reads 0. Instead, timer
   behavior is controlled using the IA32_TSC_DEADLINE MSR."
   "In TSC-deadline mode, writing 0 to the IA32_TSC_DEADLINE MSR disarms
   the local-APIC timer."

Current code in lapic_timer_shutdown() writes 0 to the initial-count
register. This stops the local APIC timer for one-shot and periodic mode
only. In TSC deadline mode, the timer is not properly stopped.

Some CPUs are affected by this and they are woke up by the armed timer
in s2idle in TSC deadline mode.

Stop the TSC deadline timer in lapic_timer_shutdown() by writing 0 to
MSR_IA32_TSC_DEADLINE.

Cc: stable@vger.kernel.org
Fixes: 279f1461432c ("x86: apic: Use tsc deadline for oneshot when available")
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 arch/x86/kernel/apic/apic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 6513c53c9459..d1006531729a 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -441,6 +441,10 @@ static int lapic_timer_shutdown(struct clock_event_device *evt)
 	v |= (APIC_LVT_MASKED | LOCAL_TIMER_VECTOR);
 	apic_write(APIC_LVTT, v);
 	apic_write(APIC_TMICT, 0);
+
+	if (boot_cpu_has(X86_FEATURE_TSC_DEADLINE_TIMER))
+		wrmsrl(MSR_IA32_TSC_DEADLINE, 0);
+
 	return 0;
 }
 
-- 
2.34.1


