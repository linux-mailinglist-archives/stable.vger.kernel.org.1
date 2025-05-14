Return-Path: <stable+bounces-144452-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF75FAB78C4
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 00:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EC4F3B0F1D
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 22:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073E621CFEA;
	Wed, 14 May 2025 22:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="p/3RkAAq"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECEE21CC4F;
	Wed, 14 May 2025 22:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747260529; cv=none; b=arp26pNGAlOiUl+tueKsqb+DwinhxuKbTN4FV5nDwdwPh2ZN/JEclwSMRiSIuogvKLq4fbW/iKUnantGPbpzYPVqf+OhCOrUnAPr1Rs/eQB6n0HshPJAeJ5vZlln94bf5nAdJs6280lZLHgFy9QnxMyJiTLmZHkKxbzCyUZQgpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747260529; c=relaxed/simple;
	bh=PqR+YFPCjdSOfpt3pGwVS9M9+G+gMw3Y4JIfhH0kNb0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VKaYuRd5g0VgVI9IpyeFj8ZUoYznw8ykdB23pjN7CZdTKeez+B619D7q0UG1dvs5+N4RH9ztom7ykANqwUi11NHosEb4/6d7t3w48GgYC863Y00HsATLndhEyQvRebR5JQW9eo9zEGFqEVRrTyZWHDk3PRzQNwsMrLPmoZ/1bsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=p/3RkAAq; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747260528; x=1778796528;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UWTTV8zUM2ZlWkwuXOA/Fy/atT7Yt1mBWszhVvMkZvw=;
  b=p/3RkAAqilXXEAwy6x8xnUhDjouRusC1x/JDAS1idYsNKWSdYhUuOHm9
   qe9A6BmpdKR87H1VQAU2SI25SE8f8Xik28yJPl5mwfdC+J97oZ1Hiqs+M
   Y2bAb012/6MKRkXYtM2FxtED69nzNonL+WojyZBFwjvwLZyfmpWsQ9T4B
   Wjx1b3Z4OSHEPA5YACzmnrDwc4bcBt1hb+OsZicL4b71RiIbPIi+SE6HR
   oWcYfytEX7ti74ipvW66bkap5RKsaQEtNwe75VAm25XgHKR5WpY2MGuVY
   tWiFvzOI2G502sOduOmlawesIcOgywCKXagItKI1hmPDUfzkBaCCbs1dQ
   g==;
X-IronPort-AV: E=Sophos;i="6.15,289,1739836800"; 
   d="scan'208";a="722872834"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 22:08:46 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:21688]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.36.176:2525] with esmtp (Farcaster)
 id 1c774317-aed4-4f6a-b692-3e6abb695c92; Wed, 14 May 2025 22:08:45 +0000 (UTC)
X-Farcaster-Flow-ID: 1c774317-aed4-4f6a-b692-3e6abb695c92
Received: from EX19D015UWC003.ant.amazon.com (10.13.138.179) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 14 May 2025 22:08:45 +0000
Received: from u1e958862c3245e.ant.amazon.com (10.135.227.37) by
 EX19D015UWC003.ant.amazon.com (10.13.138.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 14 May 2025 22:08:45 +0000
From: Suraj Jitindar Singh <surajjs@amazon.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, "Suraj
 Jitindar Singh" <surajjs@amazon.com>, <stable@vger.kernel.org>
Subject: [PATCH] x86/bugs: Don't warn when overwriting retbleed_return_thunk with srso_return_thunk
Date: Wed, 14 May 2025 15:08:35 -0700
Message-ID: <20250514220835.370700-1-surajjs@amazon.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC002.ant.amazon.com (10.13.139.230) To
 EX19D015UWC003.ant.amazon.com (10.13.138.179)

A warning is emitted in set_return_thunk() when the return thunk is
overwritten since this is likely a bug and will result in mitigations not
functioning and the mitigation information displayed in sysfs being
incorrect.

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
 arch/x86/kernel/cpu/bugs.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 8596ce85026c..b7797636140f 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -69,7 +69,16 @@ void (*x86_return_thunk)(void) __ro_after_init = __x86_return_thunk;
 
 static void __init set_return_thunk(void *thunk)
 {
-	if (x86_return_thunk != __x86_return_thunk)
+	/*
+	 * There can only be one return thunk enabled at a time, so issue a
+	 * warning when overwriting it. retbleed_return_thunk is a special case
+	 * which is safe to be overwritten with srso_return_thunk since it
+	 * provides a superset of the functionality and is handled correctly in
+	 * entry_untrain_ret().
+	 */
+	if ((x86_return_thunk != __x86_return_thunk) &&
+	    (thunk != srso_return_thunk ||
+	     x86_return_thunk != retbleed_return_thunk))
 		pr_warn("x86/bugs: return thunk changed\n");
 
 	x86_return_thunk = thunk;
-- 
2.34.1


