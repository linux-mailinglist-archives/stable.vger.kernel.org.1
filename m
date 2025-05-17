Return-Path: <stable+bounces-144659-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0156ABA6E4
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 02:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 170F7A07873
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 00:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD651367;
	Sat, 17 May 2025 00:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GpEXrBQw"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443F710E0
	for <stable@vger.kernel.org>; Sat, 17 May 2025 00:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747440219; cv=none; b=bgjTVXM03Gwqa7HjLbwLryuuH3x6bvURiTpHOgPJxcCEHzRtBaLxdqN7YXJN3fSpeOi0fbEi4lDMiXM3dB4giUFtfNrlwsGyY4X2HAq8SPx6PAFedeJYHL69QlAtBGHdjGkWHFQiSxXHU3eSVl9coW1YddtWhGshIWuW5WrWYd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747440219; c=relaxed/simple;
	bh=jz6pH78//wvOxl5O7vwTQLZS+CoK1LHg01pBM9uf/Jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BqV0Fl19YSRePt9Wo1jvgUuv+21WHQ6yGfYoohHRtpGEapRM6m4cOdK0s4+edZ6GMqaOCM7PnVESvQ77JWc86eHrAtx6EQ+s7Oh8fVKGtIHfssCvy0tZYZfuZNmxKPHUgaLBMN/DYt7ombWgXk5LdEXpFVT3E3VPS5X3gLpc/vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GpEXrBQw; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747440218; x=1778976218;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=jz6pH78//wvOxl5O7vwTQLZS+CoK1LHg01pBM9uf/Jc=;
  b=GpEXrBQwaWTAF72AUH3t41JkKTAjuqF9bgCLESmfETWak7OMRU5iT8b6
   rZ2rbPGUdSjdBBBtK/TP7MHoiQu9bqIqlVaXuGclFfTXwqmE6AaUxoH/v
   yM1NZt4VJoSnV/NmSzDDHOd+rfbmI1i+8E2j9W31xsjqqnsrwqDHK8T7d
   F99P/Vv0Eu34qTfjdNwh1SJVSjst96vt1GPnJA7w7APlUQPO+GljR2w1X
   8DVXyi+N2Nhio9BgVzy4xbFsabzS2sGacRUM+1E4WkU5rv6LIhpqpLzWa
   sswQCd5QB7XkxoOMpS+xfv29Uop3kUVocFrr3gVLrOA46cCbnW+RFQOPn
   g==;
X-CSE-ConnectionGUID: Sn7KI/L+ROm8s595sQUKsA==
X-CSE-MsgGUID: e+ZEeFWeTuGujJyVdTtICw==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="37043761"
X-IronPort-AV: E=Sophos;i="6.15,295,1739865600"; 
   d="scan'208";a="37043761"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 17:03:38 -0700
X-CSE-ConnectionGUID: SNnuwYkgTf+cQ3HQJCV/OA==
X-CSE-MsgGUID: Gm9J2hGHSZ6kq9R1mBN/mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,295,1739865600"; 
   d="scan'208";a="138677982"
Received: from yzhou16-mobl1.amr.corp.intel.com (HELO desk) ([10.125.146.16])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 17:03:37 -0700
Date: Fri, 16 May 2025 17:03:37 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 5.15 v3 16/16] x86/its: FineIBT-paranoid vs ITS
Message-ID: <20250516-its-5-15-v3-16-16fcdaaea544@linux.intel.com>
X-Mailer: b4 0.14.2
References: <20250516-its-5-15-v3-0-16fcdaaea544@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250516-its-5-15-v3-0-16fcdaaea544@linux.intel.com>

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

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
[ Just a portion of the original commit, in order to fix a build issue
  in stable kernels due to backports ]
Tested-by: Holger Hoffstätte <holger@applied-asynchrony.com>
Link: https://lore.kernel.org/r/20250514113952.GB16434@noisy.programming.kicks-ass.net
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/alternative.h | 8 ++++++++
 arch/x86/kernel/alternative.c      | 8 ++++++++
 arch/x86/net/bpf_jit_comp.c        | 2 +-
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index aa7b155b617343b3a508eb0039c81562aba53dfd..1797f80c10de4e24e7af2a7ad325d54078a65053 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -5,6 +5,7 @@
 #include <linux/types.h>
 #include <linux/stringify.h>
 #include <asm/asm.h>
+#include <asm/bug.h>
 
 #define ALTINSTR_FLAG_INV	(1 << 15)
 #define ALT_NOT(feat)		((feat) | ALTINSTR_FLAG_INV)
@@ -84,10 +85,17 @@ struct module;
 extern void its_init_mod(struct module *mod);
 extern void its_fini_mod(struct module *mod);
 extern void its_free_mod(struct module *mod);
+extern u8 *its_static_thunk(int reg);
 #else /* CONFIG_MITIGATION_ITS */
 static inline void its_init_mod(struct module *mod) { }
 static inline void its_fini_mod(struct module *mod) { }
 static inline void its_free_mod(struct module *mod) { }
+static inline u8 *its_static_thunk(int reg)
+{
+	WARN_ONCE(1, "ITS not compiled in");
+
+	return NULL;
+}
 #endif
 
 #ifdef CONFIG_RETHUNK
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 3c08f0e25df7601d121c52310cb157e7bdcf7782..43ec73da66d8b8fb942218e3a68550fe51539d75 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -597,6 +597,14 @@ static bool cpu_wants_indirect_its_thunk_at(unsigned long addr, int reg)
 	/* Lower-half of the cacheline? */
 	return !(addr & 0x20);
 }
+
+u8 *its_static_thunk(int reg)
+{
+	u8 *thunk = __x86_indirect_its_thunk_array[reg];
+
+	return thunk;
+}
+
 #endif
 
 /*
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 8be74c2aa7b895604855b1d8e340eddc004694e3..37a005df0b9520aa9e99bca694a047dfb5f91792 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -449,7 +449,7 @@ static void emit_indirect_jump(u8 **pprog, int reg, u8 *ip)
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



