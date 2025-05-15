Return-Path: <stable+bounces-144563-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED801AB92D2
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 01:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ADBE1BC0EE3
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 23:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F9228032E;
	Thu, 15 May 2025 23:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="pR2Mqmrs"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FAD1DFDE;
	Thu, 15 May 2025 23:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747352096; cv=none; b=hJ0EpgkRfk8Hzg/EdYn6QaZ06aSUrwKEHAZw4XaJ6SCibx2k7ZJi1SF/OGfDk9Q3I/blpIjjeSA/XkQnQXqURaeOpGycrTEsDUsSa/JXK0NG/bDUnnTYP0IBW5GN65pueIylN4i5g8SkXEYW3yEJ216AnVM0l8B5ZwJKyS+pZm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747352096; c=relaxed/simple;
	bh=qAiMXidI6WPFEDkri4iRFbQ/gwt7bWy7ygBdaUzaEY4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tXufh2CEJDQQF3SOw3UdzUQe9NiLADfGPus00B+Vy0zbKf1mYXfJzwAWG/JBn4Tn+D0dPM0cKXhIQ+/SHn01oe1XCpQVMQHSxUsuitytIY+QW/1SVUmL+KmBlWnb3IzMEubVCX8rJ/NdWKU82AsTlyOGTiP8G4JvUHobWHHT5q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=pR2Mqmrs; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747352095; x=1778888095;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3SHHqO+V1Yak6BtbjBKjRCDuYvk+8JklC6/Wvsvs7ug=;
  b=pR2Mqmrsgy+GdXZtqDt/gn8DJ96fLYih6aTdYEm5Rjo9547MhN7akoyZ
   vdqKMNPzgG2myLIoOEOSbF5LhLw4hYyak0JEv/WMfF+S++afPZ8+SnpoV
   5pj593EFkhNpo32t2rVMfXD277PCI9xthfKp7cWoc64lZbHH3K+v4NXnC
   Ndy3wbkk+3uctU3s1LqV3KrnCV1itNRTSHsqzHPGrKxpe4NR1XoXKr/kF
   ALDCJhcBw9uZjMN0EGaCUZfy8ZrbJv3vt3bY/Ufg/f0KmT+lHRkNA1F9/
   Z4FkS7GEMpKYO8sUfcOBrI9nU32nxd3YNFvD33UWc11fKFg/N1nDkL4yp
   Q==;
X-IronPort-AV: E=Sophos;i="6.15,292,1739836800"; 
   d="scan'208";a="20254192"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 23:34:55 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:4832]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.47:2525] with esmtp (Farcaster)
 id 84fb90dd-8cc2-4ae1-a59b-986dd30662d6; Thu, 15 May 2025 23:34:53 +0000 (UTC)
X-Farcaster-Flow-ID: 84fb90dd-8cc2-4ae1-a59b-986dd30662d6
Received: from EX19D015UWC003.ant.amazon.com (10.13.138.179) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 15 May 2025 23:34:53 +0000
Received: from u1e958862c3245e.ant.amazon.com (10.135.218.11) by
 EX19D015UWC003.ant.amazon.com (10.13.138.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 15 May 2025 23:34:53 +0000
From: Suraj Jitindar Singh <surajjs@amazon.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, "Suraj
 Jitindar Singh" <surajjs@amazon.com>, <stable@vger.kernel.org>
Subject: [PATCH 1/2] x86/bugs: WARN() when overwriting x86_return_thunk
Date: Thu, 15 May 2025 16:34:32 -0700
Message-ID: <20250515233433.105054-1-surajjs@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250515173830.uulahmrm37vyjopx@desk>
References: <20250515173830.uulahmrm37vyjopx@desk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB003.ant.amazon.com (10.13.139.157) To
 EX19D015UWC003.ant.amazon.com (10.13.138.179)

A warning message is emitted in set_return_thunk() when the return thunk is
overwritten since this is likely a bug and will result in a mitigation not
functioning and the mitigation information displayed in sysfs being
incorrect.

Make this louder by using a WARN().

Cc: stable@vger.kernel.org # 5.15.x-
Signed-off-by: Suraj Jitindar Singh <surajjs@amazon.com>
---
 arch/x86/kernel/cpu/bugs.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 8596ce85026c..9679fa30563c 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -69,8 +69,15 @@ void (*x86_return_thunk)(void) __ro_after_init = __x86_return_thunk;
 
 static void __init set_return_thunk(void *thunk)
 {
-	if (x86_return_thunk != __x86_return_thunk)
-		pr_warn("x86/bugs: return thunk changed\n");
+	/*
+	 * There can only be one return thunk enabled at a time, so issue a
+	 * warning when overwriting it as this is likely a bug which will
+	 * result in a mitigation getting disabled and a vulnerability being
+	 * incorrectly reported in sysfs.
+	 */
+	WARN(x86_return_thunk != __x86_return_thunk,
+	     "x86/bugs: return thunk changed from %ps to %ps\n",
+	     x86_return_thunk, thunk);
 
 	x86_return_thunk = thunk;
 }
-- 
2.34.1


