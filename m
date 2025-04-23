Return-Path: <stable+bounces-135241-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B90A97FF1
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 08:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1BEA177B50
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 06:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9238267721;
	Wed, 23 Apr 2025 06:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PId8dGmd"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115F1267705;
	Wed, 23 Apr 2025 06:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745391506; cv=none; b=q6SH/id36/u8FqLSG/imcbnqVGVBEhLVYxCBPms6l36GPfy8MTpPKUEnVYXgRr2dONwnRYfqc/5LIfgOv7KVWsEpmEaCI7LWcZK9Bj+uk+A5ZltP1mp5jXbrtlEECz9093j2IjfMEwhVTEGYSWt/Cbyc9IAP7mohvOfDyPjahss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745391506; c=relaxed/simple;
	bh=HMNJlmqQNyCKxS5iOuTUhx2tkjEmifC5MWeVDgopB0A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bROkyctZdGEc6lBRzJTGAynBNJVN5hPf1lfUkKj9TWx2eq+5L897km/3y0A6+OWKf3HUccf1nD5jsZpfJktLfUqJgNGnyepjHc21i/2+Kxccn7n58+O9wtjLDxrXMttN9lKUhPgiG0dqR34STrqLfzfT+VwRJVC6xmIJKoa0SLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PId8dGmd; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745391505; x=1776927505;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HMNJlmqQNyCKxS5iOuTUhx2tkjEmifC5MWeVDgopB0A=;
  b=PId8dGmdSe0Gqfzo0wJaVtpIVPTtsbYAO+VOGs1+2ZH3ISfW9GShgF0v
   s1nIqqzYEVOAt7P+tLxS1pS23chTIIqi/ntremYCnBQitUWXbEuSOnkq6
   QauX/u+z+nPWlSPh2pMnXKwyo2IkVG9DvJs+nF9mMs5mhQREf2VE32TGj
   6DkH9Uprt+qrF8tQD4GHC31HPK2Cp+JYGNELthru2VDWzbUwOpLXWUcwh
   njzRpLVK4wxyAZsgx7mVDqcL52iOwqJCRuN/FNtYGM6dYdQe7pgQmpLYH
   tSV7oGvvcQRzK3rr07rnZcRs+VBeiyHbmfJ8JasV9tRDFlEewhjaCUVvN
   w==;
X-CSE-ConnectionGUID: BLZXn2SLT72x0YKEJow2JQ==
X-CSE-MsgGUID: lpe0+uvSTJCXwYCP6hVUog==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="46206421"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="46206421"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 23:58:24 -0700
X-CSE-ConnectionGUID: oh9+vzQkSsywG6vIhzsntw==
X-CSE-MsgGUID: p8i5TqEIRGm4tjZzRQC9tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="163192890"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 22 Apr 2025 23:58:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 845EB1E5; Wed, 23 Apr 2025 09:58:20 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	stable@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH] x86/insn: Fix CTEST instruction decoding
Date: Wed, 23 Apr 2025 09:58:15 +0300
Message-ID: <20250423065815.2003231-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

insn_decoder_test found a problem with decoding APX CTEST instruction:

	Found an x86 instruction decoder bug, please report this.
	ffffffff810021df	62 54 94 05 85 ff    	ctestneq
	objdump says 6 bytes, but insn_get_length() says 5

It happens because x86-opcode-map.txt doesn't specify arguments for the
instruction and the decoder doesn't expect to see ModRM byte.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Fixes: 690ca3a3067f ("x86/insn: Add support for APX EVEX instructions to the opcode map")
Cc: stable@vger.kernel.org # v6.10+
Cc: Adrian Hunter <adrian.hunter@intel.com>
---
 arch/x86/lib/x86-opcode-map.txt       | 4 ++--
 tools/arch/x86/lib/x86-opcode-map.txt | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
index caedb3ef6688..f5dd84eb55dc 100644
--- a/arch/x86/lib/x86-opcode-map.txt
+++ b/arch/x86/lib/x86-opcode-map.txt
@@ -996,8 +996,8 @@ AVXcode: 4
 83: Grp1 Ev,Ib (1A),(es)
 # CTESTSCC instructions are: CTESTB, CTESTBE, CTESTF, CTESTL, CTESTLE, CTESTNB, CTESTNBE, CTESTNL,
 #			     CTESTNLE, CTESTNO, CTESTNS, CTESTNZ, CTESTO, CTESTS, CTESTT, CTESTZ
-84: CTESTSCC (ev)
-85: CTESTSCC (es) | CTESTSCC (66),(es)
+84: CTESTSCC Eb,Gb (ev)
+85: CTESTSCC Ev,Gv (es) | CTESTSCC Ev,Gv (66),(es)
 88: POPCNT Gv,Ev (es) | POPCNT Gv,Ev (66),(es)
 8f: POP2 Bq,Rq (000),(11B),(ev)
 a5: SHLD Ev,Gv,CL (es) | SHLD Ev,Gv,CL (66),(es)
diff --git a/tools/arch/x86/lib/x86-opcode-map.txt b/tools/arch/x86/lib/x86-opcode-map.txt
index caedb3ef6688..f5dd84eb55dc 100644
--- a/tools/arch/x86/lib/x86-opcode-map.txt
+++ b/tools/arch/x86/lib/x86-opcode-map.txt
@@ -996,8 +996,8 @@ AVXcode: 4
 83: Grp1 Ev,Ib (1A),(es)
 # CTESTSCC instructions are: CTESTB, CTESTBE, CTESTF, CTESTL, CTESTLE, CTESTNB, CTESTNBE, CTESTNL,
 #			     CTESTNLE, CTESTNO, CTESTNS, CTESTNZ, CTESTO, CTESTS, CTESTT, CTESTZ
-84: CTESTSCC (ev)
-85: CTESTSCC (es) | CTESTSCC (66),(es)
+84: CTESTSCC Eb,Gb (ev)
+85: CTESTSCC Ev,Gv (es) | CTESTSCC Ev,Gv (66),(es)
 88: POPCNT Gv,Ev (es) | POPCNT Gv,Ev (66),(es)
 8f: POP2 Bq,Rq (000),(11B),(ev)
 a5: SHLD Ev,Gv,CL (es) | SHLD Ev,Gv,CL (66),(es)
-- 
2.47.2


