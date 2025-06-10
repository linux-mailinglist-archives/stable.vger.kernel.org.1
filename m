Return-Path: <stable+bounces-152340-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E47AD4320
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 21:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97126174249
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 19:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED146264630;
	Tue, 10 Jun 2025 19:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aeujFT0C"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1B7263F43
	for <stable@vger.kernel.org>; Tue, 10 Jun 2025 19:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749584785; cv=none; b=sAJN/nimpFjWUrCto5Jo7ZvxrTXoh6zN5TaKYTY16gvJ8bZiQF0cfTqcManiilEY0VuOAwRNjTTcIN4hx2DehvMuUEZNexY/iDsFJirhpTSUIcRXfbvI3vLRbxiIezan9xcBW2QAVdO2KeSn+ZHyh1NR14dWh73lIcixJ1UqoHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749584785; c=relaxed/simple;
	bh=zZQ9lCgndX9FcJfcAfHDrvcSYDNofhSxG+qod3RMCBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBIQv138iZe70yNg24Yfmi+fkAH0Shw/BLDcgscmpWfjTOv/sC2bbhjUrdNcx7gZkx9LvnRfutGxCNQRuokt0S0mprYOWeABOKwkiN1tHKnDJr7MESq0598F38TbHqzuGBWWOyZqbPyGAIRoWzRQK+INHh/xPaaTK4F8+ClwiCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aeujFT0C; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749584784; x=1781120784;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=zZQ9lCgndX9FcJfcAfHDrvcSYDNofhSxG+qod3RMCBQ=;
  b=aeujFT0C/7TReamFfJ4SW2+3Kn40iygKeGASqosrm273e6sB9lpp9v7N
   N6OXif0I8sQEPqY5Zi5oMpCf8f8cTal1uWcS4JzHiTy9yz1asBEiDbBdx
   RsNiHHbGMtuEMVbjHyeghaCxbXIPPBR8PFhofU8Zley97IA+WKYp97hnZ
   okr6TK3SUSzjYgmfykS9afpuNthRjELicE4c8byn3VWHDlK0S7Yl8V35v
   IF9eqHZnhUWt3u59PsqPdcnS2L37b4esS1YWN4bcXiE9woSWTAVS+JB4Z
   eAyA5LUIwUN+3F7xpWa1StEkzkW4vtIWWFQCzzv2GUrJEi/7qqyKfa1+C
   g==;
X-CSE-ConnectionGUID: FpkBZf1lSsq6pj4qqH7cag==
X-CSE-MsgGUID: 2LFgg1E5QGauoYwoPVUCWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="51799525"
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="51799525"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 12:46:23 -0700
X-CSE-ConnectionGUID: +XQHJs7xQe27WFJ/Toq1bQ==
X-CSE-MsgGUID: OiUjSIcKQmmJuFa4x3sMSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="147451393"
Received: from bdahal-mobl1.amr.corp.intel.com (HELO desk) ([10.125.146.44])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 12:46:23 -0700
Date: Tue, 10 Jun 2025 12:46:10 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	holger@applied-asynchrony.com
Subject: [RFC PATCH 5.10 16/16] x86/its: FineIBT-paranoid vs ITS
Message-ID: <20250610-its-5-10-v1-16-64f0ae98c98d@linux.intel.com>
X-Mailer: b4 0.14.2
References: <20250610-its-5-10-v1-0-64f0ae98c98d@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250610-its-5-10-v1-0-64f0ae98c98d@linux.intel.com>

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
	 kernel.h(asm-generic/bug.h) and asm/alternative.h which is neeed
	 for WARN_ONCE(). ]

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
[ Just a portion of the original commit, in order to fix a build issue
  in stable kernels due to backports ]
Tested-by: Holger Hoffstätte <holger@applied-asynchrony.com>
Link: https://lore.kernel.org/r/20250514113952.GB16434@noisy.programming.kicks-ass.net
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/include/asm/alternative.h |  2 ++
 arch/x86/kernel/alternative.c      | 19 ++++++++++++++++++-
 arch/x86/net/bpf_jit_comp.c        |  2 +-
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 4ab021fd3887211723e0bf0f68683e713f260f07..f2cce0cd87a65c4a9ad2d934cc8c8bb651971576 100644
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
index 923b4d1e98dbc378270e254960fcb7ce1bc3e665..30dc73210c2ea4c14de38810f47db1d5381ce378 100644
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
index c322702126407e4102cbd0a874264dd69b17b9fd..d3450088569ff3364f456dfa5f2e06ca90b80fe7 100644
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
2.34.1


