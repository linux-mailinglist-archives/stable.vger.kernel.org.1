Return-Path: <stable+bounces-224785-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OkbA80hsmnlIwAAu9opvQ
	(envelope-from <stable+bounces-224785-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 03:15:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DA226C211
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 03:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A6B830C7AA8
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 02:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992713242AC;
	Thu, 12 Mar 2026 02:15:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [61.152.208.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C45375F85
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 02:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.152.208.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773281704; cv=none; b=Gu3c+elVXhMqKyyNWIKfMmVHsetsvdEMSgStwXahOfIgq02gYqbXR1FpVIurv8hToflLPj7fOhMpha9JfdMB/2z6PR9XC/Pa3cNf/uO/y4JRQNxbVzMmDVEJSOZJVWfsh4wXfRbxCg7ioGeob2cZPhZBMFvXEPor7Gxoz8tRoVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773281704; c=relaxed/simple;
	bh=hWLE1foGDhPuL7SACKce2uJT/0S+Y+y3LVG4rH5Fd5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PvMJb1DjSbhkG6ifzrgiNDj16wGihHHtG+lD0zN2kVv42Q8hWypr3lnxMco7yc6AQbFpXZMZBhJ/93Sawa7TXyn4SALS7l1+StVJ8DNynQIv4gv2S19wLumbH9KyY+g67RaLz3BxDeeLrPLPSsdWY47zta2kR1sVyacW/8gm2MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=61.152.208.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1773281697-1eb14e06ea0c400001-OJig3u
Received: from zhaoxin.com (zxmail.zhaoxin.com [10.28.208.166]) by mx2.zhaoxin.com with ESMTP id FSQrvMgZXvjVPtK5; Thu, 12 Mar 2026 10:14:57 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.208.166
Received: from [10.32.64.22] ([10.32.64.22] [10.32.64.22])
	by zhaoxin.com (f222c4) with ESMTPc3cedf1044455b563afe98fbe008502c
	Thu, 12 Mar 2026 10:14:52 +0800
X-Eyou-Smtpauth: tonywwangoc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.32.64.22
X-Eyou-EnvelopeSender: TonyWWang-oc@zhaoxin.com
Message-ID: <b16bda4b-c7cb-4e7f-ac71-57c0032c6633@zhaoxin.com>
Date: Thu, 12 Mar 2026 10:14:27 +0800
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
Content-Language: en-US
From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
In-Reply-To: <7d312ba6-58a0-48cb-92fa-d8094ddef21f@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Eyou-Sender: <tonywwangoc@zhaoxin.com>
X-Vid: 59a046b3c32c34b50b4d5a27a426929600@zhaoxin.com
X-Barracuda-Connect: zxmail.zhaoxin.com[10.28.208.166]
X-Barracuda-Start-Time: 1773281697
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 5106
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.155726
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
	TAGGED_FROM(0.00)[bounces-224785-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[zhaoxin.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[TonyWWang-oc@zhaoxin.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.953];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 65DA226C211
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Dave/Andrew/David/Yaozi,

Sorry for the late reply.

First of all, this bug was present in certain early ucode patches for 
ZX-C/ZX-C+ series CPUs; however, it has since been resolved in 
subsequent updates to the ZX-C/ZX-C+ ucode patch.

According to available documentation, the VIA Eden platform supports 
FSGSBASE; however, this CPU is too old, and we haven't been able to 
locate actual hardware to test whether it was affected by this bug.

It is recommended that, in addition to the existing FMS-based detection, 
a supplementary check be implemented to identify the specific ucode 
patch revisions associated with ZX-C/ZX-C+ that are known to exhibit 
this bug.

Due to differences in ucode matching rules on Zhaoxin platforms, 
existing kernel function interfaces cannot be used, so the patch code 
has been placed in a vendor-specific file. The specific patching 
approach can be as follows:

--- a/arch/x86/kernel/cpu/centaur.c
+++ b/arch/x86/kernel/cpu/centaur.c
@@ -8,6 +8,7 @@
  #include <asm/e820/api.h>
  #include <asm/mtrr.h>
  #include <asm/msr.h>
+#include <asm/microcode.h>

  #include "cpu.h"

@@ -110,6 +111,8 @@ static void early_init_centaur(struct cpuinfo_x86 *c)

  static void init_centaur(struct cpuinfo_x86 *c)
  {
+       u32 chip_pf, dummy;
+
  #ifdef CONFIG_X86_32
         char *name;
         u32  fcr_set = 0;
@@ -201,6 +204,18 @@ static void init_centaur(struct cpuinfo_x86 *c)
         set_cpu_cap(c, X86_FEATURE_LFENCE_RDTSC);
  #endif

+       if (c->x86 == 6 && c->x86_model == 15 && c->x86_stepping >= 14) {
+               native_rdmsr(0x1232, dummy, chip_pf);
+               chip_pf = (chip_pf >> 15) & 0x7;
+               c->microcode = intel_get_microcode_revision();
+
+               if ((chip_pf == 0 && c->microcode < 0x20e) ||
+                       (chip_pf == 1 && c->microcode < 0x208)) {
+                       pr_warn_once("CPU has broken FSGSBASE support; 
clear FSGSBASE feature\n");
+                       setup_clear_cpu_cap(X86_FEATURE_FSGSBASE);
+               }
+       }
+
         init_ia32_feat_ctl(c);
  }

diff --git a/arch/x86/kernel/cpu/zhaoxin.c b/arch/x86/kernel/cpu/zhaoxin.c
index 031379b7d4fa..0a0525320502 100644
--- a/arch/x86/kernel/cpu/zhaoxin.c
+++ b/arch/x86/kernel/cpu/zhaoxin.c
@@ -5,6 +5,7 @@
  #include <asm/cpu.h>
  #include <asm/cpufeature.h>
  #include <asm/msr.h>
+#include <asm/microcode.h>

  #include "cpu.h"

@@ -68,6 +69,8 @@ static void early_init_zhaoxin(struct cpuinfo_x86 *c)

  static void init_zhaoxin(struct cpuinfo_x86 *c)
  {
+       u32 chip_pf, dummy;
+
         early_init_zhaoxin(c);
         init_intel_cacheinfo(c);

@@ -89,6 +92,18 @@ static void init_zhaoxin(struct cpuinfo_x86 *c)
         set_cpu_cap(c, X86_FEATURE_LFENCE_RDTSC);
  #endif

+       if (c->x86 == 6 && c->x86_model == 25 && c->x86_stepping <= 3) {
+               native_rdmsr(0x1232, dummy, chip_pf);
+               chip_pf = (chip_pf >> 15) & 0x7;
+               c->microcode = intel_get_microcode_revision();
+
+               if ((chip_pf == 0 && c->microcode < 0x20e) ||
+                       (chip_pf == 1 && c->microcode < 0x208)) {
+                       pr_warn_once("CPU has broken FSGSBASE support; 
clear FSGSBASE feature\n");
+                       setup_clear_cpu_cap(X86_FEATURE_FSGSBASE);
+               }
+       }
+
         init_ia32_feat_ctl(c);
  }


Sincerely!
TonyWWang-oc

On 2026/3/6 00:20, Dave Hansen wrote:
> 
> 
> [这封邮件来自外部发件人 谨防风险]
> 
> On 3/5/26 01:03, Tony W Wang-oc wrote:
>> --- a/arch/x86/kernel/cpu/zhaoxin.c
>> +++ b/arch/x86/kernel/cpu/zhaoxin.c
>> @@ -89,6 +89,11 @@ static void init_zhaoxin(struct cpuinfo_x86 *c)
>>          set_cpu_cap(c, X86_FEATURE_LFENCE_RDTSC);
>>   #endif
>>
>> +       if (c->x86 == 6 && c->x86_model == 25 && c->x86_stepping <= 3) {
>> +               pr_warn_once("CPU has broken FSGSBASE support; clear
>> FSGSBASE feature\n");
>> +               setup_clear_cpu_cap(X86_FEATURE_FSGSBASE);
>> +       }
>> +
> 
> Folks, we have vendor-generic infrastructure to handle these today. You
> don't need to hack copied and pasted code across vendor-specific files.
> You just need some "VFM" defines for the models:
> 
> #define Z_MODEL_HERE    VFM_MAKE(X86_VENDOR_ZHAOXIN, 6, 26)
> #define C_MODEL_HERE    VFM_MAKE(X86_VENDOR_ZHAOXIN, ...)
> 
> a table:
> 
> static const struct x86_cpu_id bum_fsgsbase[] __initconst = {
>          X86_MATCH_VFM_STEPS(Z_MODEL_HERE, X86_STEP_MIN, 0x3, 1),
>          X86_MATCH_VFM_STEPS(C_MODEL_HERE, ..., 1),
> };
> 
> and this code:
> 
>          if (x86_match_cpu(bum_fsgsbase))
>                  setup_clear_cpu_cap(X86_FEATURE_FSGSBASE);
> 
> That code happens _once_. You can even call it from vendor-independent code.
> 
> If you get fixed microcode that can also be extended to store a fixed
> microcode version (although we're moving away from doing this on Intel).
> 
> Just please give the models some semi-sane model name.

