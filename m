Return-Path: <stable+bounces-177675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B283B42D06
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 00:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEEA65817B3
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 22:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7362EB853;
	Wed,  3 Sep 2025 22:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="E/770h1G"
X-Original-To: stable@vger.kernel.org
Received: from iad-out-013.esa.us-east-1.outbound.mail-perimeter.amazon.com (iad-out-013.esa.us-east-1.outbound.mail-perimeter.amazon.com [34.198.218.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9E82EAD0B
	for <stable@vger.kernel.org>; Wed,  3 Sep 2025 22:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.198.218.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756939948; cv=none; b=tk4LOUqwbsS7BVSyPlYnTsA7ALWbq/QFVK8pFSOADxhKsgX9sk1qDBA86B3GdodmHWFYBAAyXpnBOP3FN7K8hwZQhwpojATRYa1xTbn8uV+NtiyEvOH1mvjz+Nw4VgJnEswiykA96r8XTuca+iMO6N/rlVJE9u2nrRmfHsJaWfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756939948; c=relaxed/simple;
	bh=akS1zjBYLYUfc0LTnlD6nuC/2UgBMr0BLz/CyG+TeW8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lPZVnu7hImEQgA5K6BLnKmmlnYZ+WwkykxtcHI9fcm6CMWmpqjtSat5NsE2/OnMEzVu3FQTHFOpe2yoFDVJd2MGIsa6bIIP8WttyUXYfQveAffLcnDIa5QyUkdKN928huTCaq16okTNPQU6YPc9hk6t4GORCjmlZY797fn42TKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=E/770h1G; arc=none smtp.client-ip=34.198.218.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1756939946; x=1788475946;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+zB+W6oHlSgNu+MJ/40I5OvaOxF+kVG+nsth10hWX90=;
  b=E/770h1GsAOIrg/ZlQHh1ESNIl0995qrPs8x8VSIDpPHbbkC3Lch3jsL
   hmxs/Ip4J0jYrC2741sRwp2U989te5G42sa4AYUU6JLwogStQDhHxOOBy
   pFLsJ49pRJ6bRutaDQLAKDFQ22Ky3uzp7mrxWVpkHNNAbdTlC88KsYld8
   z0sKB0TQAGxXcXEOdWXDATM4ge0grABM6aPsgJizE0smLZoapglPBvuyJ
   NRLf5g12fXALiCL93x3N6LJI1k7YtJmEk7Bs5x68TtiLiTLVQGKq8/Xic
   u65H0N/PSZ8dkXTsURnmr+FxsDe8Q7BkVzu+koGkvRZT8xk2IOAENpFw9
   w==;
X-CSE-ConnectionGUID: IZcUKO46Ryq3EwYz6QlMSg==
X-CSE-MsgGUID: 92fWVd7iTRu1kBJO65yYXg==
X-IronPort-AV: E=Sophos;i="6.18,236,1751241600"; 
   d="scan'208";a="1373916"
Received: from ip-10-4-3-150.ec2.internal (HELO smtpout.naws.us-east-1.prod.farcaster.email.amazon.dev) ([10.4.3.150])
  by internal-iad-out-013.esa.us-east-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 22:52:25 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:58323]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.144:2525] with esmtp (Farcaster)
 id 22d1cd4e-2d4a-42d9-bc0e-1d07376b7d22; Wed, 3 Sep 2025 22:52:25 +0000 (UTC)
X-Farcaster-Flow-ID: 22d1cd4e-2d4a-42d9-bc0e-1d07376b7d22
Received: from EX19D015UWC003.ant.amazon.com (10.13.138.179) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 3 Sep 2025 22:51:09 +0000
Received: from u1e958862c3245e.ant.amazon.com (10.119.254.121) by
 EX19D015UWC003.ant.amazon.com (10.13.138.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 3 Sep 2025 22:50:31 +0000
From: Suraj Jitindar Singh <surajjs@amazon.com>
To: <stable@vger.kernel.org>
CC: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Suraj Jitindar Singh <surajjs@amazon.com>
Subject: [PATCH 5.10 2/4] x86/speculation: Simplify and make CALL_NOSPEC consistent
Date: Wed, 3 Sep 2025 15:50:01 -0700
Message-ID: <20250903225003.50346-3-surajjs@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250903225003.50346-1-surajjs@amazon.com>
References: <20250903225003.50346-1-surajjs@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA002.ant.amazon.com (10.13.139.10) To
 EX19D015UWC003.ant.amazon.com (10.13.138.179)

From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

commit cfceff8526a426948b53445c02bcb98453c7330d upstream.

CALL_NOSPEC macro is used to generate Spectre-v2 mitigation friendly
indirect branches. At compile time the macro defaults to indirect branch,
and at runtime those can be patched to thunk based mitigations.

This approach is opposite of what is done for the rest of the kernel, where
the compile time default is to replace indirect calls with retpoline thunk
calls.

Make CALL_NOSPEC consistent with the rest of the kernel, default to
retpoline thunk at compile time when CONFIG_MITIGATION_RETPOLINE is
enabled.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250228-call-nospec-v3-1-96599fed0f33@linux.intel.com
Signed-off-by: Suraj Jitindar Singh <surajjs@amazon.com>
Cc: <stable@vger.kernel.org> # 5.10.x
---
 arch/x86/include/asm/nospec-branch.h | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 3434e5ebd3c7..bb7dd09dc295 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -285,16 +285,11 @@ extern retpoline_thunk_t __x86_indirect_thunk_array[];
  * Inline asm uses the %V modifier which is only in newer GCC
  * which is ensured when CONFIG_RETPOLINE is defined.
  */
-# define CALL_NOSPEC						\
-	ALTERNATIVE_2(						\
-	ANNOTATE_RETPOLINE_SAFE					\
-	"call *%[thunk_target]\n",				\
-	"call __x86_indirect_thunk_%V[thunk_target]\n",		\
-	X86_FEATURE_RETPOLINE,					\
-	"lfence;\n"						\
-	ANNOTATE_RETPOLINE_SAFE					\
-	"call *%[thunk_target]\n",				\
-	X86_FEATURE_RETPOLINE_LFENCE)
+#ifdef CONFIG_RETPOLINE
+#define CALL_NOSPEC	"call __x86_indirect_thunk_%V[thunk_target]\n"
+#else
+#define CALL_NOSPEC	"call *%[thunk_target]\n"
+#endif
 
 # define THUNK_TARGET(addr) [thunk_target] "r" (addr)
 
-- 
2.34.1


