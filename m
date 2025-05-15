Return-Path: <stable+bounces-144564-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE19AB92D4
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 01:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0C461BC127B
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 23:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3F3293740;
	Thu, 15 May 2025 23:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="HzPeEmnj"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD29F1DFDE;
	Thu, 15 May 2025 23:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747352102; cv=none; b=XmUyWN6mpbynzwy9qaFtJuDgru+gRjf8xUfDNb8ZYkDMUBktCRi4N9yb8CZXAxaQen57Ejk2SiBjnsWg33cdR5iBUd4CSIZGgWQ2pzRaZiMp9C8vThEgskhnH4QGZNF7Fd8WdmvWqHUsgN+ZsC8YzEgqXcaLoXaX+wCO58cc0yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747352102; c=relaxed/simple;
	bh=SCZMU4zGR+zPWmqB33oni9vcpbiZh+A6l2EqcnERrko=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MZCok4kLfuhsVTn/2PDn+C24NGdpND59hFBt4Zm7YhYpSzW6XIB3Zf2dICz/8foL30UT/Sqdjvo5UQsuExp7/j80Q+UToQSPAgpIxGZ86WMZa7eD320I3RHhczR3gc94BORoD4CKfGgGyrDZVr3ucKSoystTZxKkrxN41sASCJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=HzPeEmnj; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747352101; x=1778888101;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9D+YjB0LFxl94PLKEblZUvO0xUJSwuNQaeCeS2ABtQs=;
  b=HzPeEmnj3WW5hu8gP/FVjg8K4Zvs6+ZRCt9UkPD8fOcwl8j3qNYxNt3o
   vMiNrVU6WfARnAecaZMdA3KF4rLgdywHbGiWLC9b3jaBg1RmyAOms09w0
   yRyVuxiQe9V4twJO5ziqqpYWd7hEbPT0U9z24zAUCBALqV98eldRdi/Dr
   M0DdzyM7FVk8IKHD2CK7L+DL4AXqvpBr5vvKfSvRbG/4HSfXWfcPiNBpf
   rVjm9cIag3828I0oUExfgfMTy/OhM0eXlFslX2PQ+Gq/WETwVeT2Gx+wB
   Jq0MN7kt1kEEdSG3DRGj5l/XlCVMMMiyu/DaN4u0FTfAhY1A/UpGbm5KQ
   Q==;
X-IronPort-AV: E=Sophos;i="6.15,292,1739836800"; 
   d="scan'208";a="825215381"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 23:35:00 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:33380]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.141:2525] with esmtp (Farcaster)
 id 8250e7f5-681c-4ffe-b4f7-8c611add5154; Thu, 15 May 2025 23:34:59 +0000 (UTC)
X-Farcaster-Flow-ID: 8250e7f5-681c-4ffe-b4f7-8c611add5154
Received: from EX19D015UWC003.ant.amazon.com (10.13.138.179) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 15 May 2025 23:34:59 +0000
Received: from u1e958862c3245e.ant.amazon.com (10.135.218.11) by
 EX19D015UWC003.ant.amazon.com (10.13.138.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 15 May 2025 23:34:59 +0000
From: Suraj Jitindar Singh <surajjs@amazon.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, "Suraj
 Jitindar Singh" <surajjs@amazon.com>, <stable@vger.kernel.org>
Subject: [PATCH 2/2] x86/bugs: Don't WARN() when overwriting retbleed_return_thunk with srso_return_thunk
Date: Thu, 15 May 2025 16:34:33 -0700
Message-ID: <20250515233433.105054-2-surajjs@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250515233433.105054-1-surajjs@amazon.com>
References: <20250515173830.uulahmrm37vyjopx@desk>
 <20250515233433.105054-1-surajjs@amazon.com>
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

There is a special case when the return thunk is overwritten from
retbleed_return_thunk to srso_return_thunk since srso_return_thunk provides
a superset of the functionality of retbleed_return_thunk, and this is
handled correctly in entry_untrain_ret(). Avoid emitting the warning in
this scenario to clarify that this is not an issue.

This situation occurs on certain AMD processors (e.g. Zen2) which are
affected by both retbleed and srso.

Fixes: f4818881c47fd ("x86/its: Enable Indirect Target Selection mitigation")
Cc: stable@vger.kernel.org # 5.15.x-
Signed-off-by: Suraj Jitindar Singh <surajjs@amazon.com>
---
 arch/x86/kernel/cpu/bugs.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 9679fa30563c..840902cee670 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -73,9 +73,14 @@ static void __init set_return_thunk(void *thunk)
 	 * There can only be one return thunk enabled at a time, so issue a
 	 * warning when overwriting it as this is likely a bug which will
 	 * result in a mitigation getting disabled and a vulnerability being
-	 * incorrectly reported in sysfs.
+	 * incorrectly reported in sysfs. retbleed_return_thunk is a special
+	 * case which is safe to be overwritten with srso_return_thunk since it
+	 * provides a superset of the functionality and is handled correctly in
+	 * entry_untrain_ret().
 	 */
-	WARN(x86_return_thunk != __x86_return_thunk,
+	WARN((x86_return_thunk != __x86_return_thunk) &&
+	     (thunk != srso_return_thunk ||
+	      x86_return_thunk != retbleed_return_thunk),
 	     "x86/bugs: return thunk changed from %ps to %ps\n",
 	     x86_return_thunk, thunk);
 
-- 
2.34.1


