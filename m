Return-Path: <stable+bounces-225759-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AO1kCNkFuWmEnAEAu9opvQ
	(envelope-from <stable+bounces-225759-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 08:42:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F73F2A4FCE
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 08:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 002E3302E42D
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 07:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFDD392803;
	Tue, 17 Mar 2026 07:41:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [61.152.208.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706A039184A
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 07:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.152.208.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773733301; cv=none; b=aepGgSqaEU4K317wyt+fiFfZlniHMRRSLpifE8pBni3q21ACwTr5R9UPKxlC0evxOjh+wtqTDhKj2XBK5Ps9tPb/qfHA6TC2oIWK6E7mcPYXprD4CIw0JPj3DF9mVUBaqMHYv/SIH78Dvds2tYDyI2P/I7+kdnFlNkYtelmPS/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773733301; c=relaxed/simple;
	bh=dSuh0XGDD08NZescQpfCZLlePKs4U6tTx44DRNO9gMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GvcaC/h90Wx4HY7edjkYmqXhfoxT4qbOs1PuwX8o3kDHBKwO8d1/1hphIvhFYcwadiVWYmG/BbFsINqJRw8OLJDqg0uIgPUDRVYH8jTulfuFzJGjoaRO0vFWWcCNOd/InVQtEMFxgtH3DOPUh9l4CM7fVQBRV7PzgqPgi1KmJN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=61.152.208.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1773733285-1eb14e06eb19130001-OJig3u
Received: from zhaoxin.com (zxmail.zhaoxin.com [10.28.208.166]) by mx2.zhaoxin.com with ESMTP id 9X4X25efAB785esd; Tue, 17 Mar 2026 15:41:25 +0800 (CST)
X-Barracuda-Envelope-From: tonywwang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.208.166
Received: from [10.32.64.22] ([10.32.64.22] [10.32.64.22])
	by zhaoxin.com (f222c4) with ESMTP6c05a99c6414fc5606ccb28fbfcd5031
	Tue, 17 Mar 2026 15:41:24 +0800
X-Eyou-Smtpauth: tonywwangoc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.32.64.22
X-Eyou-EnvelopeSender: tonywwang-oc@zhaoxin.com
Message-ID: <08c3f1d4-326b-4a04-968c-23dd8ed14d0f@zhaoxin.com>
Date: Tue, 17 Mar 2026 15:41:21 +0800
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
Content-Language: en-US
From: Tony W Wang-oc <tonywwang-oc@zhaoxin.com>
In-Reply-To: <03a03ec8-4309-42ac-a13d-2fcc8396d547@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Eyou-Sender: <tonywwangoc@zhaoxin.com>
X-Vid: 1aec4b22d37663b9264c8e8fd355e1a900@zhaoxin.com
X-Barracuda-Connect: zxmail.zhaoxin.com[10.28.208.166]
X-Barracuda-Start-Time: 1773733285
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 5997
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.155970
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225759-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[zhaoxin.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tonywwang-oc@zhaoxin.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.947];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zhaoxin.com:email,zhaoxin.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7F73F2A4FCE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 2026/3/12 23:52, Dave Hansen wrote:
> On 3/11/26 19:14, Tony W Wang-oc wrote:
>>
>> +       if (c->x86 == 6 && c->x86_model == 15 && c->x86_stepping >= 14) {
>> +               native_rdmsr(0x1232, dummy, chip_pf);
>> +               chip_pf = (chip_pf >> 15) & 0x7;
>> +               c->microcode = intel_get_microcode_revision();
>> +
>> +               if ((chip_pf == 0 && c->microcode < 0x20e) ||
>> +                       (chip_pf == 1 && c->microcode < 0x208)) {
>> +                       pr_warn_once("CPU has broken FSGSBASE support;
>> clear FSGSBASE feature\n");
>> +                       setup_clear_cpu_cap(X86_FEATURE_FSGSBASE);
>> +               }
>> +       }
> So, I'm sorry but that's not really consistent how we're doing things
> these days.
>
> The model needs a symbolic name.
>
> The MSR you're reading is completely undocumented and unnamed.
Sorry, MSR 0x1232 is a Zhaoxin private MSR. Currently, this MSR is not 
documented in any public specification. It is used to store CPU 
manufacturing information.
>
> "chip_pf" is nonsensical and unexplained.
chip_pf retrieved from MSR 0x1232 represents the CPU product version.
>
> Code is duplicated across the centaur and zhaoxin files.
>
> Once you have all of that fixed, you should have a simple:
>
> #define CENTAUR_MODEL_FOO VFM_MAKE(X86_VENDOR_CENTAUR, 6, 15)
> #define ZHAOXIN_MODEL_BAR VFM_MAKE(X86_VENDOR_ZHAOXIN, 6, 25)
>
> in a central header, plus:
>
> struct x86_cpu_id *naughty_list[] = {
> 	X86_MATCH_VFM_STEPS(CENTAUR_MODEL_FOO,       14, MAX_STEP, 0),
> 	X86_MATCH_VFM_STEPS(ZHAOXIN_MODEL_BAR, MIN_STEP,        3, 0),
> 	{}
> };
>
> void check_fsgsbase_bugs()
> {
> 	u32 fixed_ucode;
>
> 	if (!cpu_feature_enabled(X86_FEATURE_FSGSBASE))
> 		return;
>
> 	c = x86_match_cpu(naughty_list);
> 	if (!c)
> 		return;
>
> 	chip_pf = ...
> 	if (chip_pf == 0)
> 		fixed_ucode = 0x20e;
> 	if (chip_pf == 1)
> 		fixed_ucode = 0x208;
>
> 	if (intel_get_microcode_revision() >= fixed_ucode)
> 		return;
>
> 	pr_warn_once("Broken FSGSBASE support, clearing feature\n");
> 	setup_clear_cpu_cap(X86_FEATURE_FSGSBASE);
> }
>
> Then check_fsgsbase_bugs() can pretty much be called anywhere. It can
> even be in generic code.
>
> We are also getting some new matching fields in 'x86_cpu_id'. I suspect
> 'chip_pf' can be stored in there where Intel has the platform_id right
> now. But you don't have to do that now.
>
> Could you please go this route rather than copy-and-pasted chunks of
> code sprinkled with a healthy dose of magic numbers?
Thank you for providing the example code.

Could you please take another look at the following patch to see if it's 
acceptable?

diff --git a/MAINTAINERS b/MAINTAINERS
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
index 000000000000..a3883bb149b4
--- /dev/null
+++ b/arch/x86/include/asm/zhaoxin.h
@@ -0,0 +1,48 @@
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
+struct x86_cpu_id naughty_list[] = {
+    X86_MATCH_VFM_STEPS(ZHAOXIN_MODEL_ZXC, 0, 3, 0),
+    X86_MATCH_VFM_STEPS(CENTAUR_MODEL_ZXC, 14, 15, 0),
+    {}
+};
+
+void check_fsgsbase_bugs(void);
+
+void check_fsgsbase_bugs(void)
+{
+
+    u32 chip_pf, dummy, fixed_ucode;
+
+    if (!cpu_feature_enabled(X86_FEATURE_FSGSBASE))
+        return;
+
+    if (!x86_match_cpu(naughty_list))
+        return;
+
+    native_rdmsr(MSR_ZHAOXIN_MFGID, dummy, chip_pf);
+
+    /* chip_pf represents product version flag */
+    chip_pf = (chip_pf >> 15) & 0x7;
+
+    if (chip_pf == 0)
+        fixed_ucode = 0x20e;
+    if (chip_pf == 1)
+        fixed_ucode = 0x208;
+
+    if (intel_get_microcode_revision() >= fixed_ucode)
+        return;
+
+    pr_warn_once("Broken FSGSBASE support, clearing feature\n");
+    setup_clear_cpu_cap(X86_FEATURE_FSGSBASE);
+}
+
+#endif
+
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 1c3261cae40c..fe24830a47aa 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -73,6 +73,7 @@
  #include <asm/tdx.h>
  #include <asm/posted_intr.h>
  #include <asm/runtime-const.h>
+#include <asm/zhaoxin.h>

  #include "cpu.h"

@@ -2047,6 +2048,8 @@ static void identify_cpu(struct cpuinfo_x86 *c)
      setup_umip(c);
      setup_lass(c);

+    check_fsgsbase_bugs();
+
      /* Enable FSGSBASE instructions if available. */
      if (cpu_has(c, X86_FEATURE_FSGSBASE)) {
          cr4_set_bits(X86_CR4_FSGSBASE);


