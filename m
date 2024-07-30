Return-Path: <stable+bounces-63702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63414941A38
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8683D1C22F79
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345E418454A;
	Tue, 30 Jul 2024 16:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAwDcbhE"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB661A6192
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 16:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722357680; cv=none; b=Qu63s01DerA1WO8eh40PCiD4El3iJegHksHgwN2jcY9I9iWOBqsIvg0aKDPzO/tBZymlKUxjTBk+BQaA7zHGuiIVU2mwCVphyAfVdLtNfspNUvalxmnPU/sK+OeWf0SVDm91pS8F/iakqQQIFZXMCkFocGOyhdVfQdsKFdWhrz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722357680; c=relaxed/simple;
	bh=wWV6OVcVe10jstJ+qNJkO6ruxHHuc4u0/MpzIMVmfgg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=tgS7Nv/QL0SpJuHA0jxyglQL+h/8slPVwS9jQhMFgLDHvh3WRuLrD1gJXPHK2Rh7Yci89nVrJyrrkFRxKA4dCfrO2OV9OopOO/6wdrxm0L1+H9/e6hFeCUJKKfwiA0tvawTRvQpWH7aG5Ut5vE9uB0sKz1W9vll6w2GVBr+QSVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAwDcbhE; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52efe4c7c16so7060213e87.0
        for <stable@vger.kernel.org>; Tue, 30 Jul 2024 09:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722357676; x=1722962476; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXKV1G6Qjh92ziY7QtfKBV7evZIaDh5DHsUlmmYPSaw=;
        b=EAwDcbhE2+4nXEuikBS+y3Ppk3Ueto5fohRSFCiIvA+/KDuAulFkIpU4/yEYXIVaUh
         x5oMXxpb2wdqOu8v65pZhnqQMo8Ae5MrSPIfFFIMg5Fgj35K2VZIkLrWwiJW9hVx1d0K
         Q7ylVtXGprhg4G8lkup7Shc/tjsu2/+csuhdtYrh46DHnHU0md73zyri270tR8AOs1/K
         zPnLeJd/5nDcIY3oJBK5xji1j9Dqqv0AcSoPZsNssrUvD5C/Hp7b5FXfn1GFIbrvVuvk
         AGlfckd2XOJpFrv60Lf3eEsj2/58MB75l/xjgyBCfdEG1lnRya11m7KxUoMly77NdZb+
         3wqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722357676; x=1722962476;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BXKV1G6Qjh92ziY7QtfKBV7evZIaDh5DHsUlmmYPSaw=;
        b=vuiRMCnKHoU00piWPRZTinIbqcKRiufI5klA6MCZeJ/8B9AROyi1gk/8bU5SMSax56
         1jvC2PxOK408Gj+u6RoXbHfGp02XvEx/ytaN60+HBE4h8w7C1TG7CRykIGo+dddynmNs
         njhmPuFgs6Ac90X/Ns84jHCT0hawPVCkQVR79JLT1S51LWINAd9qRCcG3DdDEenbwHKJ
         LrdvmkfjxGk/urqw6tbeLPxaTXBZCwHc9xPtj4ZyWa3mvw7cPWh9k8MXeCuVW9ee2wyP
         5bJGPMN+TRuqb6wlqMlVeDtF62VVDgWRQdsneM8/+X0899SiVDJOogToJvABtBynFwdM
         CRZg==
X-Gm-Message-State: AOJu0Yx9K0u0jnqNz1ipOri+ItIWMNabM5qtXhaF1WEnMpjZS7SiNtnR
	I8lALYAgRpF7icquA+k+yBe9WF4aQukQ/eCipS8q8JHVfWyXts62
X-Google-Smtp-Source: AGHT+IHwUamOqGpDD7aAkFSLhLOzNqCYn+sRGvldbwNsG9lt4bVY3ptAO2wYzc1pJ596Kw1WNojKTg==
X-Received: by 2002:a05:6512:3196:b0:52e:ff2b:dfd8 with SMTP id 2adb3069b0e04-5309b2e0af1mr7772529e87.54.1722357675804;
        Tue, 30 Jul 2024 09:41:15 -0700 (PDT)
Received: from [84.217.175.36] (c-f6a4d954.51034-0-757473696b74.bbcust.telenor.se. [84.217.175.36])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadb82e7sm663784666b.208.2024.07.30.09.41.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 09:41:15 -0700 (PDT)
Message-ID: <eb709d67-2a8d-412f-905d-f3777d897bfa@gmail.com>
Date: Tue, 30 Jul 2024 18:41:14 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: tony.luck@intel.com
Cc: stable@vger.kernel.org
From: Thomas Lindroth <thomas.lindroth@gmail.com>
Subject: [STABLE REGRESSION] Possible missing backport of x86_match_cpu()
 change in v6.1.96
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I upgraded from kernel 6.1.94 to 6.1.99 on one of my machines and noticed that
the dmesg line "Incomplete global flushes, disabling PCID" had disappeared from
the log.

That message comes from commit c26b9e193172f48cd0ccc64285337106fb8aa804, which
disables PCID support on some broken hardware in arch/x86/mm/init.c:

#define INTEL_MATCH(_model) { .vendor  = X86_VENDOR_INTEL,     \
                              .family  = 6,                     \
                              .model = _model,                  \
                            }
/*
  * INVLPG may not properly flush Global entries
  * on these CPUs when PCIDs are enabled.
  */
static const struct x86_cpu_id invlpg_miss_ids[] = {
        INTEL_MATCH(INTEL_FAM6_ALDERLAKE   ),
        INTEL_MATCH(INTEL_FAM6_ALDERLAKE_L ),
        INTEL_MATCH(INTEL_FAM6_ALDERLAKE_N ),
        INTEL_MATCH(INTEL_FAM6_RAPTORLAKE  ),
        INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_P),
        INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_S),
        {}

...

if (x86_match_cpu(invlpg_miss_ids)) {
         pr_info("Incomplete global flushes, disabling PCID");
         setup_clear_cpu_cap(X86_FEATURE_PCID);
         return;
}

arch/x86/mm/init.c, which has that code, hasn't changed in 6.1.94 -> 6.1.99.
However I found a commit changing how x86_match_cpu() behaves in 6.1.96:

commit 8ab1361b2eae44077fef4adea16228d44ffb860c
Author: Tony Luck <tony.luck@intel.com>
Date:   Mon May 20 15:45:33 2024 -0700

     x86/cpu: Fix x86_match_cpu() to match just X86_VENDOR_INTEL

I suspect this broke the PCID disabling code in arch/x86/mm/init.c.
The commit message says:

"Add a new flags field to struct x86_cpu_id that has a bit set to indicate that
this entry in the array is valid. Update X86_MATCH*() macros to set that bit.
Change the end-marker check in x86_match_cpu() to just check the flags field
for this bit."

But the PCID disabling code in 6.1.99 does not make use of the
X86_MATCH*() macros; instead, it defines a new INTEL_MATCH() macro without the
X86_CPU_ID_FLAG_ENTRY_VALID flag.

I looked in upstream git and found an existing fix:
commit 2eda374e883ad297bd9fe575a16c1dc850346075
Author: Tony Luck <tony.luck@intel.com>
Date:   Wed Apr 24 11:15:18 2024 -0700

     x86/mm: Switch to new Intel CPU model defines

     New CPU #defines encode vendor and family as well as model.

     [ dhansen: vertically align 0's in invlpg_miss_ids[] ]

     Signed-off-by: Tony Luck <tony.luck@intel.com>
     Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
     Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
     Link: https://lore.kernel.org/all/20240424181518.41946-1-tony.luck%40intel.com

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 679893ea5e68..6b43b6480354 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -261,21 +261,17 @@ static void __init probe_page_size_mask(void)
         }
  }
  
-#define INTEL_MATCH(_model) { .vendor  = X86_VENDOR_INTEL,     \
-                             .family  = 6,                     \
-                             .model = _model,                  \
-                           }
  /*
   * INVLPG may not properly flush Global entries
   * on these CPUs when PCIDs are enabled.
   */
  static const struct x86_cpu_id invlpg_miss_ids[] = {
-       INTEL_MATCH(INTEL_FAM6_ALDERLAKE   ),
-       INTEL_MATCH(INTEL_FAM6_ALDERLAKE_L ),
-       INTEL_MATCH(INTEL_FAM6_ATOM_GRACEMONT ),
-       INTEL_MATCH(INTEL_FAM6_RAPTORLAKE  ),
-       INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_P),
-       INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_S),
+       X86_MATCH_VFM(INTEL_ALDERLAKE,      0),
+       X86_MATCH_VFM(INTEL_ALDERLAKE_L,    0),
+       X86_MATCH_VFM(INTEL_ATOM_GRACEMONT, 0),
+       X86_MATCH_VFM(INTEL_RAPTORLAKE,     0),
+       X86_MATCH_VFM(INTEL_RAPTORLAKE_P,   0),
+       X86_MATCH_VFM(INTEL_RAPTORLAKE_S,   0),
         {}
  };

The fix removed the custom INTEL_MATCH macro and uses the X86_MATCH*() macros
with X86_CPU_ID_FLAG_ENTRY_VALID. This fixed commit was never backported to 6.1,
so it looks like a stable series regression due to a missing backport.

If I apply the fix patch on 6.1.99, the PCID disabling code activates again.
I had to change all the INTEL_* definitions to the old definitions to make it
build:

  static const struct x86_cpu_id invlpg_miss_ids[] = {
-       INTEL_MATCH(INTEL_FAM6_ALDERLAKE   ),
-       INTEL_MATCH(INTEL_FAM6_ALDERLAKE_L ),
-       INTEL_MATCH(INTEL_FAM6_ALDERLAKE_N ),
-       INTEL_MATCH(INTEL_FAM6_RAPTORLAKE  ),
-       INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_P),
-       INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_S),
+       X86_MATCH_VFM(INTEL_FAM6_ALDERLAKE,    0),
+       X86_MATCH_VFM(INTEL_FAM6_ALDERLAKE_L,  0),
+       X86_MATCH_VFM(INTEL_FAM6_ALDERLAKE_N,  0),
+       X86_MATCH_VFM(INTEL_FAM6_RAPTORLAKE,   0),
+       X86_MATCH_VFM(INTEL_FAM6_RAPTORLAKE_P, 0),
+       X86_MATCH_VFM(INTEL_FAM6_RAPTORLAKE_S, 0),
         {}
  };

I only looked at the code in arch/x86/mm/init.c, so there may be other uses of
x86_match_cpu() in the kernel that are also broken in 6.1.99.
This email is meant as a bug report, not a pull request. Someone else should
confirm the problem and submit the appropriate fix.

