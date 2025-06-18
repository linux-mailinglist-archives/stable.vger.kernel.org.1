Return-Path: <stable+bounces-154617-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0857AADE039
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 02:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F48E17B7B4
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 00:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E624F22EE5;
	Wed, 18 Jun 2025 00:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ac9oFPYq"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB4E29A5
	for <stable@vger.kernel.org>; Wed, 18 Jun 2025 00:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750207694; cv=none; b=bdKbEiwjOKTVZsPBUD41xGsGRZHYHbPN5MpWYprveS3GcgLS2gukXidWVccwOgPt9BpCrP774xJIm/3K/SMGqrXqoYOWa2zxUJN7Sn5VI6wU4vPpSjHfxN4hETIWVbdcH0+LNCm7C2vxjazSSRLwpGbxG/VN7flq2DYw8ruqlNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750207694; c=relaxed/simple;
	bh=kT+UyqgDIoBdMMtO848TfQvmBhWR22JTZLlQ+6L121A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AdIGB4rjH7elp0+ODWxKNkzbTuAmOtCxe02XpVMy1XngB2LIOzWXV9kOwpEYCkpiXaFyWskvTtM1qi1mwzKg0g6yEv+XKUVTyuHmmdbitQ+425Q9Mo7+Nv0SLCu1Tup1nlCDD9D0Mt08PDtUr6EJrmvYhPvRSVGafL6HtjNDQ5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ac9oFPYq; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750207693; x=1781743693;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=kT+UyqgDIoBdMMtO848TfQvmBhWR22JTZLlQ+6L121A=;
  b=Ac9oFPYqVxXl9sjP7ZuhLtiiG9wO41YYynJdB0i+DZN3H/QD3eJXU1te
   eT2dMHQgtejEigZ6SXnLJ6aApoPBEVPmGIGhGTxjwSUCR/fCGntvjWZJ2
   5z5cSzOzW4cenfNHysxIGhTmlBKDcd40mBntPU4PltoFctbVjtjD+TBd1
   8UrHvZEnyzz/tB4ykg3n8upAxx9zES51CEtyFNZ0ql63qGYIoM/h9Y7Iz
   srE0/kBqt7XAic7F//Kd9lED2gee9nGx/7+2AI2DoRTU1l89MYBP5rLbt
   LYg7ph7DfoKAJv/mNrTekQwW6v1I1Ak0mlSJ2Pexryc3SbfbYYsWPAAIR
   g==;
X-CSE-ConnectionGUID: AyjyFfQxT66nDC8LtWaUMQ==
X-CSE-MsgGUID: KY+BJGDbTQmhIVJlE8fjhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="62685154"
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="62685154"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 17:48:13 -0700
X-CSE-ConnectionGUID: F0jctaZqQeGUl4CPERHh5w==
X-CSE-MsgGUID: rLLBWuiPTm6+EKPgO2/+pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="149002296"
Received: from guptapa-dev.ostc.intel.com (HELO desk) ([10.54.69.136])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 17:48:11 -0700
Date: Tue, 17 Jun 2025 17:48:11 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Salvatore Bonaccorso <carnil@debian.org>, Peter Zijlstra <peterz@infradead.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Alexandre Chartre <alexandre.chartre@oracle.com>, 
	holger@applied-asynchrony.com
Subject: [PATCH 5.10 v2 16/16] x86/its: FineIBT-paranoid vs ITS
Message-ID: <20250617-its-5-10-v2-16-3e925a1512a1@linux.intel.com>
X-Mailer: b4 0.15-dev-c81fc
References: <20250617-its-5-10-v2-0-3e925a1512a1@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250617-its-5-10-v2-0-3e925a1512a1@linux.intel.com>

From: Peter Zijlstra <peterz@infradead.org>

commit e52c1dc7455d32c8a55f9949d300e5e87d011fa6 upstream.

FineIBT-paranoid was using the retpoline bytes for the paranoid check,
disabling retpolines, because all parts that have IBT also have eIBRS
and thus don't need no stinking retpolines.

Except... ITS needs the retpolines for indirect calls must not be in
the first half of a cacheline :-/

So what was the paranoid call sequence:

  <fineibt_paranoid_start>:
   0:   41 ba 78 56 34 12       mov    $0x12345678, %r10d
   6:   45 3b 53 f7             cmp    -0x9(%r11), %r10d
   a:   4d 8d 5b <f0>           lea    -0x10(%r11), %r11
   e:   75 fd                   jne    d <fineibt_paranoid_start+0xd>
  10:   41 ff d3                call   *%r11
  13:   90                      nop

Now becomes:

  <fineibt_paranoid_start>:
   0:   41 ba 78 56 34 12       mov    $0x12345678, %r10d
   6:   45 3b 53 f7             cmp    -0x9(%r11), %r10d
   a:   4d 8d 5b f0             lea    -0x10(%r11), %r11
   e:   2e e8 XX XX XX XX	cs call __x86_indirect_paranoid_thunk_r11

  Where the paranoid_thunk looks like:

   1d:  <ea>                    (bad)
   __x86_indirect_paranoid_thunk_r11:
   1e:  75 fd                   jne 1d
   __x86_indirect_its_thunk_r11:
   20:  41 ff eb                jmp *%r11
   23:  cc                      int3

[ dhansen: remove initialization to false ]

[ pawan: move the its_static_thunk() definition to alternative.c. This is
	 done to avoid a build failure due to circular dependency between
	 kernel.h(asm-generic/bug.h) and asm/alternative.h which is
	 needed for WARN_ONCE(). ]

[ Just a portion of the original commit, in order to fix a build issue
  in stable kernels due to backports ]

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Tested-by: Holger Hoffstätte <holger@applied-asynchrony.com>
Link: https://lore.kernel.org/r/20250514113952.GB16434@noisy.programming.kicks-ass.net
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/include/asm/alternative.h |  2 ++
 arch/x86/kernel/alternative.c      | 19 ++++++++++++++++++-
 arch/x86/net/bpf_jit_comp.c        |  2 +-
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 4ab021fd3887..f2cce0cd87a6 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -80,6 +80,8 @@ extern void apply_returns(s32 *start, s32 *end);
 
 struct module;
 
+extern u8 *its_static_thunk(int reg);
+
 #ifdef CONFIG_MITIGATION_ITS
 extern void its_init_mod(struct module *mod);
 extern void its_fini_mod(struct module *mod);
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 923b4d1e98db..30dc73210c2e 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -752,7 +752,24 @@ static bool cpu_wants_indirect_its_thunk_at(unsigned long addr, int reg)
 	/* Lower-half of the cacheline? */
 	return !(addr & 0x20);
 }
-#endif
+
+u8 *its_static_thunk(int reg)
+{
+	u8 *thunk = __x86_indirect_its_thunk_array[reg];
+
+	return thunk;
+}
+
+#else /* CONFIG_MITIGATION_ITS */
+
+u8 *its_static_thunk(int reg)
+{
+	WARN_ONCE(1, "ITS not compiled in");
+
+	return NULL;
+}
+
+#endif /* CONFIG_MITIGATION_ITS */
 
 /*
  * Rewrite the compiler generated retpoline thunk calls.
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index c32270212640..d3450088569f 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -390,7 +390,7 @@ static void emit_indirect_jump(u8 **pprog, int reg, u8 *ip)
 	if (IS_ENABLED(CONFIG_MITIGATION_ITS) &&
 	    cpu_feature_enabled(X86_FEATURE_INDIRECT_THUNK_ITS)) {
 		OPTIMIZER_HIDE_VAR(reg);
-		emit_jump(&prog, &__x86_indirect_its_thunk_array[reg], ip);
+		emit_jump(&prog, its_static_thunk(reg), ip);
 	} else if (cpu_feature_enabled(X86_FEATURE_RETPOLINE_LFENCE)) {
 		EMIT_LFENCE();
 		EMIT2(0xFF, 0xE0 + reg);

-- 
2.43.0



