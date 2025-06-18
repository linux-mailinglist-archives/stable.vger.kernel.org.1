Return-Path: <stable+bounces-154704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C1DADF6E6
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 21:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2F1F7A4CD3
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 19:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE78020FA98;
	Wed, 18 Jun 2025 19:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dtP4CFfe"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760C73085A0;
	Wed, 18 Jun 2025 19:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750275210; cv=none; b=NodaMhs0QlgpLhasbF9iYxuXH2Yu8onYC8ZHdl+nitmuRsrbpa72LZSFp/yGZ5FqQeI3C6drm13GK+QBEaCbchZFwZtjYe/B/KzxPBcFIH5aOC9RnTr0lrLbIvqARy2ZANUoT4KzjoKHQ3vRsV3G8wxGyJKiHvsEeVhQKz30MOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750275210; c=relaxed/simple;
	bh=JmKJ/QgL8a4k1RMX1yEjIQA/+pS6gAZ3UQLcQ3I9m3k=;
	h=Subject:To:Cc:From:Date:Message-Id; b=TGSr3F0RrD3ZN1bcNm/c1ivYP8PVhvfnEScs/Kf5ox4aOmBk8HBHgAjY21fnmj59kVjI3vozqqszQNIkp+9tZdAcsV44WDOwfSSMWF9g4hP8UpT47Lo/Cwlp5HyZMAdA1kMlE2iXYlB9Nf+dfOMQ2Y7E2tJE9z9hGu9OwkxUk4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dtP4CFfe; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750275208; x=1781811208;
  h=subject:to:cc:from:date:message-id;
  bh=JmKJ/QgL8a4k1RMX1yEjIQA/+pS6gAZ3UQLcQ3I9m3k=;
  b=dtP4CFfeTfvSgMGytg733yit7TNyHA7J/hFo2+UczRX52ptyP291bDvM
   DmiCAU6Gpa/OPK7qJtS0t0kt0S3zEx68FfnXJ+uRXYTeEkP8EXAvgpds6
   FvQYlTriM2mDdqxcJ3b6u2NZmNoPizCB2Yr72+j7Hutz/bLD/zUSCZKbi
   tI4Jo3G6s/43jgjdqgGYAbO9JtDA88aEhukgdKpSB/NWpEPExrtF8Kvsg
   7F7gtYgfBvBy0yw1iJOLhVaGGO9KzV5Sv9blOkIVUHfAIRtY2gTc4OwCl
   obhFn055PmlxIWQ7T/6rYptKtQwUnfEO5vxWbkfpPpIuQIhr88e170DzG
   g==;
X-CSE-ConnectionGUID: mcCaEPH/QJCvssnFwy8CDA==
X-CSE-MsgGUID: 7q5t1y3jR2SdeTS1GN6l2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="63552223"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="63552223"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 12:33:18 -0700
X-CSE-ConnectionGUID: q0Sl5aV0T1iCvV/h0AomkA==
X-CSE-MsgGUID: T7T2gk+mQlKYtfu8fvQXTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="155851520"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa005.jf.intel.com with ESMTP; 18 Jun 2025 12:33:15 -0700
Subject: [PATCH] x86/fpu: Delay instruction pointer fixup until after after warning
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, tglx@linutronix.de, bp@alien8.de, mingo@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Chang S. Bae <chang.seok.bae@intel.com>, Eric Biggers <ebiggers@google.com>, Rik van Riel <riel@redhat.com>, stable@vger.kernel.org
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 18 Jun 2025 12:33:13 -0700
Message-Id: <20250618193313.17F0EF2E@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

Right now, if XRSTOR fails a console message like this is be printed:

	Bad FPU state detected at restore_fpregs_from_fpstate+0x9a/0x170, reinitializing FPU registers.

However, the text location (...+0x9a in this case) is the instruction
*AFTER* the XRSTOR. The highlighted instruction in the "Code:" dump
also points one instruction late.

The reason is that the "fixup" moves RIP up to pass the bad XRSTOR
and keep on running after returning from the #GP handler. But it
does this fixup before warning.

The resulting warning output is nonsensical because it looks like
e non-FPU-related instruction is #GP'ing.

Do not fix up RIP until after printing the warning.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Fixes: d5c8028b4788 ("x86/fpu: Reinitialize FPU registers if restoring FPU state fails")
Cc: stable@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>
Cc: Rik van Riel <riel@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Chang S. Bae <chang.seok.bae@intel.com>
---

 b/arch/x86/mm/extable.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -puN arch/x86/mm/extable.c~fixup-fpu-gp-ip-later arch/x86/mm/extable.c
--- a/arch/x86/mm/extable.c~fixup-fpu-gp-ip-later	2025-06-18 12:21:30.231719499 -0700
+++ b/arch/x86/mm/extable.c	2025-06-18 12:25:53.979954060 -0700
@@ -122,11 +122,11 @@ static bool ex_handler_sgx(const struct
 static bool ex_handler_fprestore(const struct exception_table_entry *fixup,
 				 struct pt_regs *regs)
 {
-	regs->ip = ex_fixup_addr(fixup);
-
 	WARN_ONCE(1, "Bad FPU state detected at %pB, reinitializing FPU registers.",
 		  (void *)instruction_pointer(regs));
 
+	regs->ip = ex_fixup_addr(fixup);
+
 	fpu_reset_from_exception_fixup();
 	return true;
 }
_

