Return-Path: <stable+bounces-226953-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDdeNbAfuml8RwIAu9opvQ
	(envelope-from <stable+bounces-226953-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 04:44:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5630E2B5909
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 04:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31DC13059354
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 03:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B4D33A70E;
	Wed, 18 Mar 2026 03:44:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [61.152.208.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF892E88AE
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 03:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.152.208.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773805479; cv=none; b=j0IswIVMLexTYhyOHWwMJkG7UDIkxvYfRBJT3bNPXHoXCGLyM27p2ve6Gky0ZmaETM2ZQ2yJO9xeKk246vcbTsM8g79OxJacdznMDHKCMKfwqb5CIsi/Q0Wes4fqSuORBbALOKGQyhYoq3dOQeBjNluudHEXBNvPXcT6R0fgcmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773805479; c=relaxed/simple;
	bh=ossGCI6TxrIvxOZAZ/5qBnZw5CrHH+ak7k9I2VPbEf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H171TVp69RXzbJpLU+2g4TkF8I4VCDjzBio5KbYt12md0YOMAm9PN44BD/fiZOYry0tPPVrBFCesZwIxfPy/bEHsCh80usm0CiSKBSYng9E3Fjk4GWbOlDAJFVx59HjXyRGVkdbEOTDLAavqquj2eCvxrJXMwWQkPHKYt2WOjvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=61.152.208.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1773805471-1eb14e06eb1bc20001-OJig3u
Received: from zhaoxin.com (zxmail.zhaoxin.com [10.28.208.166]) by mx2.zhaoxin.com with ESMTP id YHwQHDRin0e5h0T8; Wed, 18 Mar 2026 11:44:31 +0800 (CST)
X-Barracuda-Envelope-From: tonywwang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.208.166
Received: from [10.32.64.22] ([10.32.64.22] [10.32.64.22])
	by zhaoxin.com (f222c4) with ESMTP64f85180a3ce4fc07f68f3664c575032
	Wed, 18 Mar 2026 11:44:29 +0800
X-Eyou-Smtpauth: tonywwangoc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.32.64.22
X-Eyou-EnvelopeSender: tonywwang-oc@zhaoxin.com
Message-ID: <c1788d73-783c-42c3-9033-77abb903a404@zhaoxin.com>
Date: Wed, 18 Mar 2026 11:44:27 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/cpu/centaur: Disable X86_FEATURE_FSGSBASE on Zhaoxin
 C4600
To: Dave Hansen <dave.hansen@intel.com>, me@ziyao.cc
X-ASG-Orig-Subj: Re: [PATCH] x86/cpu/centaur: Disable X86_FEATURE_FSGSBASE on Zhaoxin
 C4600
Cc: andrew.cooper3@citrix.com, bp@alien8.de, dave.hansen@linux.intel.com,
 hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
 stable@vger.kernel.org, tglx@kernel.org, x86@kernel.org, lukelin@viacpu.com,
 "TimGuo@zhaoxin.com" <TimGuo@zhaoxin.com>, cooperyan@zhaoxin.com,
 benjaminpan@viatech.com, QiyuanWang@zhaoxin.com, HerryYang@zhaoxin.com,
 "CobeChen@zhaoxin.com" <CobeChen@zhaoxin.com>
References: <20260228173704.62460-1-me@ziyao.cc>
 <70139192-54e5-4a4b-bc96-1fe3ec4f7a0b@zhaoxin.com>
 <7d312ba6-58a0-48cb-92fa-d8094ddef21f@intel.com>
 <b16bda4b-c7cb-4e7f-ac71-57c0032c6633@zhaoxin.com>
 <03a03ec8-4309-42ac-a13d-2fcc8396d547@intel.com>
 <08c3f1d4-326b-4a04-968c-23dd8ed14d0f@zhaoxin.com>
 <c7498236-1e7c-4819-881f-42b9032778c7@intel.com>
Content-Language: en-US
From: Tony W Wang-oc <tonywwang-oc@zhaoxin.com>
In-Reply-To: <c7498236-1e7c-4819-881f-42b9032778c7@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Eyou-Sender: <tonywwangoc@zhaoxin.com>
X-Vid: 8a47b6998aa8f5a55f35a5eec2d2535200@zhaoxin.com
X-Barracuda-Connect: zxmail.zhaoxin.com[10.28.208.166]
X-Barracuda-Start-Time: 1773805471
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 6925
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.156008
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226953-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[zhaoxin.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tonywwang-oc@zhaoxin.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.948];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,zhaoxin.com:email,zhaoxin.com:mid]
X-Rspamd-Queue-Id: 5630E2B5909
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 2026/3/17 23:21, Dave Hansen wrote:
>> --- /dev/null
>> +++ b/arch/x86/include/asm/zhaoxin.h
>> @@ -0,0 +1,48 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _ASM_X86_ZHAOXIN_H
>> +#define _ASM_X86_ZHAOXIN_H
>> +
>> +#include <asm/cpu_device_id.h>
>> +#include <asm/microcode.h>
>> +
>> +#define    ZHAOXIN_MODEL_ZXC    VFM_MAKE(X86_VENDOR_ZHAOXIN, 6, 25)
>> +#define    CENTAUR_MODEL_ZXC    VFM_MAKE(X86_VENDOR_CENTAUR, 6, 15)
>> +
>> +struct x86_cpu_id naughty_list[] = {
>> +    X86_MATCH_VFM_STEPS(ZHAOXIN_MODEL_ZXC, 0, 3, 0),
>> +    X86_MATCH_VFM_STEPS(CENTAUR_MODEL_ZXC, 14, 15, 0),
>> +    {}
>> +};
> Hi Tony,
>
> This is headed in the right direction, in a way.
>
> However, I think you might have missed a few things. Did you notice that
> this structure is in a .h file? We generally don't define data
> structures and variables in header files. You might want to take a quick
> look around the tree.
>
> Then, go try and #include this header in two different places. See what
> happens.
>
>> +void check_fsgsbase_bugs(void);
>> +
>> +void check_fsgsbase_bugs(void)
>> +{
> Generally, compiler warnings are good things. They tell you that you've
> done something wrong. Simply throwing code in to silence them isn't a
> great practice.
>
> Remember the compiler warning you got without the function declaration?
> That was there to tell you that something is wrong. You placed
> definitions in a header, not declarations.
>
> But, adding a declaration before the definition made the compiler quiet.
>
>> +    u32 chip_pf, dummy, fixed_ucode;
> This is whitespace damaged, btw.
>
> I also prefer one variable per line
>
> 	u32 fixed_ucode;
> 	u32 chip_pf;
> 	u32 dummy;
>
>> +    if (!cpu_feature_enabled(X86_FEATURE_FSGSBASE))
>> +        return;
>> +
>> +    if (!x86_match_cpu(naughty_list))
>> +        return;
> Heh, also I was joking about 'naughty_list'. It would be best to give it
> a good symbolic, meaningful name.
>
>> +    native_rdmsr(MSR_ZHAOXIN_MFGID, dummy, chip_pf);
> This at least need commenting. What prevents this code from getting
> called on other vendors' CPUs? What about models of Zhaoxin CPUs that
> don't have this MSR?
>
>> +    /* chip_pf represents product version flag */
>> +    chip_pf = (chip_pf >> 15) & 0x7;
> Please use the GENMASK macros here.
>
>> +    if (chip_pf == 0)
>> +        fixed_ucode = 0x20e;
>> +    if (chip_pf == 1)
>> +        fixed_ucode = 0x208;
>> +
>> +    if (intel_get_microcode_revision() >= fixed_ucode)
>> +        return;
> It's probably worth commenting why this is calling an "intel"_ function.
>
>> +    pr_warn_once("Broken FSGSBASE support, clearing feature\n");
>> +    setup_clear_cpu_cap(X86_FEATURE_FSGSBASE);
>> +}
>> +
>> +#endif
>
Sorry, The previous patch didn't consider the generality of the newly 
added zhaoxin.h.  The intention was to minimize modifications to common.c.

The revised patch is provided below, please review it again. Thank you.

iff --git a/MAINTAINERS b/MAINTAINERS
index 364f0bec8748..42093a794056 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29168,6 +29168,7 @@ ZHAOXIN PROCESSOR SUPPORT
  M:    Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
  L:    linux-kernel@vger.kernel.org
  S:    Maintained
+F:    arch/x86/include/asm/zhaoxin.h
  F:    arch/x86/kernel/cpu/zhaoxin.c

  ZONED BLOCK DEVICE (BLOCK LAYER)
diff --git a/arch/x86/include/asm/msr-index.h 
b/arch/x86/include/asm/msr-index.h
index be3e3cc963b2..dc71a4adc776 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1306,5 +1306,7 @@
                          * disabling x2APIC will cause
                          * a #GP
                          */
+/* ZHAOXIN defined MSRs*/
+#define MSR_ZHAOXIN_MFGID        0x00001232

  #endif /* _ASM_X86_MSR_INDEX_H */
diff --git a/arch/x86/include/asm/zhaoxin.h b/arch/x86/include/asm/zhaoxin.h
new file mode 100644
index 000000000000..e7f380b678dc
--- /dev/null
+++ b/arch/x86/include/asm/zhaoxin.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_ZHAOXIN_H
+#define _ASM_X86_ZHAOXIN_H
+
+#include <asm/cpu_device_id.h>
+#include <asm/microcode.h>
+
+#define    ZHAOXIN_MODEL_ZXC    VFM_MAKE(X86_VENDOR_ZHAOXIN, 6, 25)
+#define    CENTAUR_MODEL_ZXC    VFM_MAKE(X86_VENDOR_CENTAUR, 6, 15)
+
+extern struct x86_cpu_id fsgsbase_bugs_list[];
+extern void check_fsgsbase_bugs(void);
+
+#endif
+
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 1c3261cae40c..49e58b55c414 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -73,6 +73,7 @@
  #include <asm/tdx.h>
  #include <asm/posted_intr.h>
  #include <asm/runtime-const.h>
+#include <asm/zhaoxin.h>

  #include "cpu.h"

@@ -1940,6 +1941,50 @@ void check_null_seg_clears_base(struct 
cpuinfo_x86 *c)
      set_cpu_bug(c, X86_BUG_NULL_SEG);
  }

+struct x86_cpu_id fsgsbase_bugs_list[] = {
+    X86_MATCH_VFM_STEPS(ZHAOXIN_MODEL_ZXC, 0, 3, 0),
+    X86_MATCH_VFM_STEPS(CENTAUR_MODEL_ZXC, 14, 15, 0),
+    {}
+};
+
+void check_fsgsbase_bugs(void)
+{
+    u32 chip_pf;
+    u32 dummy;
+    u32 fixed_ucode;
+
+    if (!cpu_feature_enabled(X86_FEATURE_FSGSBASE))
+        return;
+
+    if (!x86_match_cpu(fsgsbase_bugs_list))
+        return;
+
+    /*
+     * All Zhaoxin CPUs use MSR_ZHAOXIN_MFGID to represent
+     * manufacturing information. Please note that this MSR
+     * may have different meanings in other vendors' CPUs.
+     */
+    native_rdmsr(MSR_ZHAOXIN_MFGID, dummy, chip_pf);
+
+    /* chip_pf represents product version flag */
+    chip_pf = (chip_pf & GENMASK(17, 15)) >> 15;
+
+    if (chip_pf == 0)
+        fixed_ucode = 0x20e;
+    if (chip_pf == 1)
+        fixed_ucode = 0x208;
+
+    /*
+     * Zhaoxin ucode version retrieval method is compatible
+     * with Intel.
+     */
+    if (intel_get_microcode_revision() >= fixed_ucode)
+        return;
+
+    pr_warn_once("Broken FSGSBASE support, clearing feature\n");
+    setup_clear_cpu_cap(X86_FEATURE_FSGSBASE);
+}
+
  static void generic_identify(struct cpuinfo_x86 *c)
  {
      c->extended_cpuid_level = 0;
@@ -2047,6 +2092,8 @@ static void identify_cpu(struct cpuinfo_x86 *c)
      setup_umip(c);
      setup_lass(c);

+    check_fsgsbase_bugs();
+
      /* Enable FSGSBASE instructions if available. */
      if (cpu_has(c, X86_FEATURE_FSGSBASE)) {
          cr4_set_bits(X86_CR4_FSGSBASE);


