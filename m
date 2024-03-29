Return-Path: <stable+bounces-33749-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C70CA892339
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 19:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20AA3B22070
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 18:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753F0126F3C;
	Fri, 29 Mar 2024 18:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p4Pyf6no"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD0B85C7D
	for <stable@vger.kernel.org>; Fri, 29 Mar 2024 18:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711736316; cv=none; b=nWZ0Mb3neVQPQVbsghJfKhslWmqjCOBlArGhA5FeI5KSfKN00p4/TVXppXzC9CthIIWMlP6SpLlNrebsbtmyFeopRBf7b7teYT8h9t7/ZqbbXALSIB5yH/lFtgAuE++QfxH58Ku068SWmjcIL4fZ2spS79H/iFYI5ml/eAdxn5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711736316; c=relaxed/simple;
	bh=S988U3jhn+WOq4/32DrhZyrpO5Ul3zhLrNHmWZgU5dk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XX33+I3Ip/jWpui4Xe5Y9OZXXiyOZNPaZxaGueTqGVtZXKsg+kajfZggbZ1T9i1oDudZJkXwAeWmVo/ldvV+ai6032D0a0zutw2t+f/WA6mP0lXYb52bTrmsdL6ZHTdiUCoOjHdIOwyhUXunkykXiYSfseuHsfkURv+jOC51mpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p4Pyf6no; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-33ed489edcaso1236050f8f.3
        for <stable@vger.kernel.org>; Fri, 29 Mar 2024 11:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711736313; x=1712341113; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Eor+T9njRjVKclE5pljvAT6vtT8ahHxXKarZKUPtBGY=;
        b=p4Pyf6no75AIEALIBgVoedRcw2eDRr/OVDsynDl8Z845Ezhf9dRP1J5l1Dc2m8bm27
         13p9UxAGdncYrzc+rGJMuaqr7IYfnLr5QYMYHzeZY17TslySHxx6Grutkfk1QQ9uVit6
         TjiiK988ms5l6dotqV2HGjXWnpQpOPbVxo6wgI9eZ9ltHNQnkU91sHyv0Ju694G4TXxG
         4d9IFsPvFWXWUGa1RZSjczZmmDA8Bu7+gSgYkJIx4Ou1MyvtunMzZAGQodcYqP+cOtVt
         fnUI5wkd+KEKnKwA7+Co5uJLLfiFFclsYjfiaBJWflr65oPdjVRKEQQjafXP0mymIKWf
         Yz9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711736313; x=1712341113;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eor+T9njRjVKclE5pljvAT6vtT8ahHxXKarZKUPtBGY=;
        b=HhogQk0Y0I3wDy9xtLDkdABvLjT6OZHzUkeTYQvKxGYMf78jh4JJpAsEQuxe/s9le2
         fE9Ao3o1myAt+pbAbDCsD/K1n50XShwWHulquGet/RVtjMuhWQjnVKqWJwHnERIiYF1Y
         u3JmOzQls/dB+gAYb07zvzMNtiA5XHSxLX9hetxQTmxrZwBsN/vvX9qHI1OGkG5vo3VH
         qP2L1ptDvCw1Ue6kh+8HRj4Ks7d6evYIUFihTn98robkKZ1k1YJoZ3367rTAvmI+G98h
         3cGD0Bu4VEMNcSQ86IcNWLTotgZQXRw82pH8n+peKEwG4icCCa+5gjzDEZpOAxCVrehG
         qcvw==
X-Gm-Message-State: AOJu0YxmfnOQwu18YSGVZ5WbNFWcUbEZyUxaQhpaYIb4lIPY2PH8YgXg
	ilw84lo8fWpY9Eo84v271a1F8TZTIcHYegaq5+Jpsuwb0y8E796THb04Ge8vi6sFWvPU3vj8g9N
	bead4gPuQqo9FWJ1GwlPdPLxrwJjWtPeKqSJNHnqmlVYr5PHSnr1cxYCCvQyxOA9ZD1+g6/d5lg
	mgPMif0RmIhE7yoYAdRajR2w==
X-Google-Smtp-Source: AGHT+IF9wiCdRINNoSzLJVNbDBQ94LvATtLR8e+/o8nePdeO2BmH+ZC2QE4YeWJCbxmZ9LJJ0vB7vrV5
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a5d:55c4:0:b0:341:6723:41fe with SMTP id
 i4-20020a5d55c4000000b00341672341femr7555wrw.8.1711736312657; Fri, 29 Mar
 2024 11:18:32 -0700 (PDT)
Date: Fri, 29 Mar 2024 19:18:02 +0100
In-Reply-To: <20240329181800.619169-5-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329181800.619169-5-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3305; i=ardb@kernel.org;
 h=from:subject; bh=K9hlIoXDTCt9isUSyEkcoKhmPdH7iyqiOCZG5m2Uwzs=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIY2d9ZaC4/KAjxOCF+fd9d9r1us51ehWSfv0ypOFb7Uc5
 7yKminQUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACai/Zbhf0z89t6rXVdtGKPn
 vJ8sve0dD6fPvI/v+a7H2NZd1Q+J7mX4Z5N86u6SvzXbvgU9vqF92HCC1rsVS9Y2N/pX+n+xWVI pzAcA
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329181800.619169-6-ardb+git@google.com>
Subject: [PATCH -stable-6.1 resend 2/4] x86/coco: Get rid of accessor functions
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: "Borislav Petkov (AMD)" <bp@alien8.de>

[ Commit da86eb9611840772a459693832e54c63cbcc040a upstream ]

cc_vendor is __ro_after_init and thus can be used directly.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230508121957.32341-1-bp@alien8.de
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/coco/core.c               |  2 +-
 arch/x86/coco/tdx/tdx.c            |  2 +-
 arch/x86/include/asm/coco.h        | 19 +------------------
 arch/x86/kernel/cpu/mshyperv.c     |  2 +-
 arch/x86/mm/mem_encrypt_identity.c |  2 +-
 5 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index 684f0a910475..1e73254336a6 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -13,7 +13,7 @@
 #include <asm/coco.h>
 #include <asm/processor.h>
 
-enum cc_vendor cc_vendor __ro_after_init;
+enum cc_vendor cc_vendor __ro_after_init = CC_VENDOR_NONE;
 static u64 cc_mask __ro_after_init;
 
 static bool intel_cc_platform_has(enum cc_attr attr)
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index d0565a9e7d8c..4692450aeb4d 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -793,7 +793,7 @@ void __init tdx_early_init(void)
 
 	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
 
-	cc_set_vendor(CC_VENDOR_INTEL);
+	cc_vendor = CC_VENDOR_INTEL;
 	tdx_parse_tdinfo(&cc_mask);
 	cc_set_mask(cc_mask);
 
diff --git a/arch/x86/include/asm/coco.h b/arch/x86/include/asm/coco.h
index 91b9448ffe76..75a0d7b1a906 100644
--- a/arch/x86/include/asm/coco.h
+++ b/arch/x86/include/asm/coco.h
@@ -11,30 +11,13 @@ enum cc_vendor {
 	CC_VENDOR_INTEL,
 };
 
-#ifdef CONFIG_ARCH_HAS_CC_PLATFORM
 extern enum cc_vendor cc_vendor;
 
-static inline enum cc_vendor cc_get_vendor(void)
-{
-	return cc_vendor;
-}
-
-static inline void cc_set_vendor(enum cc_vendor vendor)
-{
-	cc_vendor = vendor;
-}
-
+#ifdef CONFIG_ARCH_HAS_CC_PLATFORM
 void cc_set_mask(u64 mask);
 u64 cc_mkenc(u64 val);
 u64 cc_mkdec(u64 val);
 #else
-static inline enum cc_vendor cc_get_vendor(void)
-{
-	return CC_VENDOR_NONE;
-}
-
-static inline void cc_set_vendor(enum cc_vendor vendor) { }
-
 static inline u64 cc_mkenc(u64 val)
 {
 	return val;
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 34d9e899e471..9b039e9635e4 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -344,7 +344,7 @@ static void __init ms_hyperv_init_platform(void)
 		/* Isolation VMs are unenlightened SEV-based VMs, thus this check: */
 		if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
 			if (hv_get_isolation_type() != HV_ISOLATION_TYPE_NONE)
-				cc_set_vendor(CC_VENDOR_HYPERV);
+				cc_vendor = CC_VENDOR_HYPERV;
 		}
 	}
 
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index a11a6ebbf5ec..4daeefa011ed 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -608,7 +608,7 @@ void __init sme_enable(struct boot_params *bp)
 out:
 	if (sme_me_mask) {
 		physical_mask &= ~sme_me_mask;
-		cc_set_vendor(CC_VENDOR_AMD);
+		cc_vendor = CC_VENDOR_AMD;
 		cc_set_mask(sme_me_mask);
 	}
 }
-- 
2.44.0.478.gd926399ef9-goog


