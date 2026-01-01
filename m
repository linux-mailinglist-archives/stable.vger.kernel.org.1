Return-Path: <stable+bounces-204412-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1802CECEA9
	for <lists+stable@lfdr.de>; Thu, 01 Jan 2026 10:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B2D03007C4D
	for <lists+stable@lfdr.de>; Thu,  1 Jan 2026 09:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4812BDC0A;
	Thu,  1 Jan 2026 09:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IvltGpdH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RYpnwz5A"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B7128B4E2
	for <stable@vger.kernel.org>; Thu,  1 Jan 2026 09:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767258328; cv=none; b=NPP2wDwcd39CrIJlgqRnYWF2vrvmnJCkL4bTos3rA94vyhqM05oF3SpiDNtWSZ+feqaoSz9I9CxM9eqasrgErYC3vp86TqgS7gNxA3Yu2CGS4mh4QpdyW/fXTNgtCCj/Z0V/U6hPcmQXNK9g+0C5/y9LwQYUSkOWfn6i9AUTUVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767258328; c=relaxed/simple;
	bh=uJUoC1fqh3nasXV2hJWPwZ4FEafFTmiIA/eN62LUbns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EyLsLoQ/EU9Ohy9rIl7YxgHQPygbhioXqSfWPW29HH0hEbnT4lbmij06drv8zid3aFgBfxBJpNpyILw92rKW3H/BBrfOG4/wM/BcbVcIChoE70+3+Hl6crzjvrRGbbfv82C7QIsD9NIkuCkJPDtWRIKAhN+NtBp9uoS2/QLSKrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IvltGpdH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RYpnwz5A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767258325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iWm1grx6lrYHMd/frQidl905aBaP2UUBVSwZpsXb4ss=;
	b=IvltGpdHwbvYOY+R8DkS+F5JWzq+Ysfad4yOcYVQVUPSbpFfryhhXQCq555IEhIg/FJ7Qx
	ZBgqBrIG/fuDqPLvW8c3LS2AKf/HcMaUGVcfgEUw2PEzQj1zOVbi6nuppUqLMtdKg8qsbG
	PFxm0KbuQovuNW7I/9eP0oU7WnTw0JU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-0yJSybpEOZ2dHEf6t71-0Q-1; Thu, 01 Jan 2026 04:05:24 -0500
X-MC-Unique: 0yJSybpEOZ2dHEf6t71-0Q-1
X-Mimecast-MFC-AGG-ID: 0yJSybpEOZ2dHEf6t71-0Q_1767258323
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-430fd96b440so5891329f8f.1
        for <stable@vger.kernel.org>; Thu, 01 Jan 2026 01:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767258323; x=1767863123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWm1grx6lrYHMd/frQidl905aBaP2UUBVSwZpsXb4ss=;
        b=RYpnwz5AULkgSPrLEeCB0esRGcFu6fJQ0Dq6zfGHuAXnE6m4ZfssIAGsPZmaRF+WNw
         Kn8ag18bZmtCTjQAqyZH6M2YPS2W1qkRXA7ZGrT1cvqX98l5yNEUr8MzfHD4dp67Lln2
         A/jo+BSK+NpcExDmGNFIhrl0mNwxP76XVEMmzh0+wyrZk9uKNwD5V5KvxdLPaT1p1026
         +FIk3+BI/iVdxZB0z9gGtJCL7DCFDrBEZSFxxC1PEXRX96SMq7OSJYHlnijy5/oPB/Yv
         SZSyjvCD7EiXyBsiPf/vSA2mVGDqK7eCKa+jNFOLSdzR9UwVXdisD6RBsuaCSdEg2csp
         Zkgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767258323; x=1767863123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iWm1grx6lrYHMd/frQidl905aBaP2UUBVSwZpsXb4ss=;
        b=g6tFdLRvlFcNL6DTWSafHaKtI0Jz5wrJUcWyR4LHf6lUZtDRAUKD7HE31lqSeKubfn
         hUfFnRHUiZYL4683CNIXhC9YyWaGPPFnTDUXaCygTnH3VQYoGFRzoV9XeERn58x24oGT
         gqCmZ+mhkCdqMAd4NcUymafL4b64a5Zxa48WwfPUJJupfhNsn3TFEHA/BINaMShVrIkP
         Lo4813+NBGmLWw/8fHcEj7G8dHrOp3bk8bAe0SLkcaOReVzUBV1pn1bB+E0ug3NnFeHv
         go2ZLdq/++PivJqlFoekt+cDKhQfmklBZ+BFTG8hWIXbVhO2AvjZMtyieJWgGN5Piemd
         k/FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMM77X51lKPnCEiwgG7YkqiZfoUyftAjxB5XUYiPtEtZ0rRkf+TFwKnI0rThGjcmmD35rxZa4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6zSO3UgjikehLLlb5gZaDyHiSchjs3kyd09+RqHB/rlh8RzkN
	ElRZlPGeS0w5BqkMB2hRqVPUyIdXSWyCHMwbp6cPQZFrbMiWgKNC3moDXVs6OW7wJNyaI9r1/vr
	Ud/K3o3ilj5AbOmrT7mESd70Ch44l6lLy4ty3hdQEfYVJKbZHXVeXyI1Awg==
X-Gm-Gg: AY/fxX4KJo4WKDp6pygyHI4dyKM1Dh/oFfakF66sSJP2x9x2lPNI1f9eFEO+JwHTcC8
	7C7F1LIiEWBdiOI2eeJvbG68Lcu9BWCmlOE86Ng1+Uy0TxGgY/VIlLq5ny7qN7m8AEdo24y2pU7
	T/6SEWzbCmosNExbGtxEjiwfoIrev1ynatwvOQLjPqEwohaiwq+RmUhzqzlxsXcQNlyzqh48lym
	uct7Jsf1rgZsPys44NjwU/lI4OXbC8y8roQybHAvDO9Yuzh3WF1pLdNqjAQLoqofpFvIlg+n4hZ
	Bz+TZrxDdiL0wdaWcFBKOIxkKigCFolPcb0rQEGupE19c2kz8DkDE9NtWwA8qC+niGdTu0g02dB
	h7PB/HkQ9CDp7smXJbNZpMhHlt85Vqzog2nhxKtDZsdeW2n4jMVK6DOY9f8bxohXi2ljeWytU4g
	Mbzz5yGMVTMNx+qw==
X-Received: by 2002:a05:6000:22c3:b0:431:488:b9a8 with SMTP id ffacd0b85a97d-4324e4faa8fmr52012237f8f.33.1767258322732;
        Thu, 01 Jan 2026 01:05:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHK4rSinXKO0GzMCec4k1MO9LSkvX69N11QioqyctAOPuoTwcgEc6vYyjGquBJKrJl4vCa5KA==
X-Received: by 2002:a05:6000:22c3:b0:431:488:b9a8 with SMTP id ffacd0b85a97d-4324e4faa8fmr52012206f8f.33.1767258322288;
        Thu, 01 Jan 2026 01:05:22 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eab2ebfsm77898315f8f.40.2026.01.01.01.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 01:05:21 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	x86@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/4] selftests: kvm: replace numbered sync points with actions
Date: Thu,  1 Jan 2026 10:05:14 +0100
Message-ID: <20260101090516.316883-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260101090516.316883-1-pbonzini@redhat.com>
References: <20260101090516.316883-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rework the guest=>host syncs in the AMX test to use named actions instead
of arbitrary, incrementing numbers.  The "stage" of the test has no real
meaning, what matters is what action the test wants the host to perform.
The incrementing numbers are somewhat helpful for triaging failures, but
fully debugging failures almost always requires a much deeper dive into
the test (and KVM).

Using named actions not only makes it easier to extend the test without
having to shift all sync point numbers, it makes the code easier to read.

[Commit message by Sean Christopherson]

Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
	I wrote this before seeing your patch... It's obviously
	similar but different enough that I kept my version. :)
	Thanks anyway for including it, your commit message was
	better so I used it.

 tools/testing/selftests/kvm/x86/amx_test.c | 88 +++++++++++-----------
 1 file changed, 43 insertions(+), 45 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/amx_test.c b/tools/testing/selftests/kvm/x86/amx_test.c
index f4ce5a185a7d..4ac41c1a7255 100644
--- a/tools/testing/selftests/kvm/x86/amx_test.c
+++ b/tools/testing/selftests/kvm/x86/amx_test.c
@@ -124,6 +124,14 @@ static void set_tilecfg(struct tile_config *cfg)
 	}
 }
 
+enum {
+	/* Check TMM0 against tiledata */
+	TEST_COMPARE_TILEDATA = 1,
+
+	/* Full VM save/restore */
+	TEST_SAVE_RESTORE = 2,
+};
+
 static void __attribute__((__flatten__)) guest_code(struct tile_config *amx_cfg,
 						    struct tile_data *tiledata,
 						    struct xstate *xstate)
@@ -131,20 +139,20 @@ static void __attribute__((__flatten__)) guest_code(struct tile_config *amx_cfg,
 	GUEST_ASSERT(this_cpu_has(X86_FEATURE_XSAVE) &&
 		     this_cpu_has(X86_FEATURE_OSXSAVE));
 	check_xtile_info();
-	GUEST_SYNC(1);
+	GUEST_SYNC(TEST_SAVE_RESTORE);
 
 	/* xfd=0, enable amx */
 	wrmsr(MSR_IA32_XFD, 0);
-	GUEST_SYNC(2);
+	GUEST_SYNC(TEST_SAVE_RESTORE);
 	GUEST_ASSERT(rdmsr(MSR_IA32_XFD) == 0);
 	set_tilecfg(amx_cfg);
 	__ldtilecfg(amx_cfg);
-	GUEST_SYNC(3);
+	GUEST_SYNC(TEST_SAVE_RESTORE);
 	/* Check save/restore when trap to userspace */
 	__tileloadd(tiledata);
-	GUEST_SYNC(4);
+	GUEST_SYNC(TEST_COMPARE_TILEDATA | TEST_SAVE_RESTORE);
 	__tilerelease();
-	GUEST_SYNC(5);
+	GUEST_SYNC(TEST_SAVE_RESTORE);
 	/*
 	 * After XSAVEC, XTILEDATA is cleared in the xstate_bv but is set in
 	 * the xcomp_bv.
@@ -154,6 +162,8 @@ static void __attribute__((__flatten__)) guest_code(struct tile_config *amx_cfg,
 	GUEST_ASSERT(!(xstate->header.xstate_bv & XFEATURE_MASK_XTILE_DATA));
 	GUEST_ASSERT(xstate->header.xcomp_bv & XFEATURE_MASK_XTILE_DATA);
 
+	/* #NM test */
+
 	/* xfd=0x40000, disable amx tiledata */
 	wrmsr(MSR_IA32_XFD, XFEATURE_MASK_XTILE_DATA);
 
@@ -166,13 +176,13 @@ static void __attribute__((__flatten__)) guest_code(struct tile_config *amx_cfg,
 	GUEST_ASSERT(!(xstate->header.xstate_bv & XFEATURE_MASK_XTILE_DATA));
 	GUEST_ASSERT((xstate->header.xcomp_bv & XFEATURE_MASK_XTILE_DATA));
 
-	GUEST_SYNC(6);
+	GUEST_SYNC(TEST_SAVE_RESTORE);
 	GUEST_ASSERT(rdmsr(MSR_IA32_XFD) == XFEATURE_MASK_XTILE_DATA);
 	set_tilecfg(amx_cfg);
 	__ldtilecfg(amx_cfg);
 	/* Trigger #NM exception */
 	__tileloadd(tiledata);
-	GUEST_SYNC(10);
+	GUEST_SYNC(TEST_COMPARE_TILEDATA | TEST_SAVE_RESTORE);
 
 	GUEST_DONE();
 }
@@ -180,18 +190,18 @@ static void __attribute__((__flatten__)) guest_code(struct tile_config *amx_cfg,
 void guest_nm_handler(struct ex_regs *regs)
 {
 	/* Check if #NM is triggered by XFEATURE_MASK_XTILE_DATA */
-	GUEST_SYNC(7);
+	GUEST_SYNC(TEST_SAVE_RESTORE);
 	GUEST_ASSERT(!(get_cr0() & X86_CR0_TS));
 	GUEST_ASSERT(rdmsr(MSR_IA32_XFD_ERR) == XFEATURE_MASK_XTILE_DATA);
 	GUEST_ASSERT(rdmsr(MSR_IA32_XFD) == XFEATURE_MASK_XTILE_DATA);
-	GUEST_SYNC(8);
+	GUEST_SYNC(TEST_SAVE_RESTORE);
 	GUEST_ASSERT(rdmsr(MSR_IA32_XFD_ERR) == XFEATURE_MASK_XTILE_DATA);
 	GUEST_ASSERT(rdmsr(MSR_IA32_XFD) == XFEATURE_MASK_XTILE_DATA);
 	/* Clear xfd_err */
 	wrmsr(MSR_IA32_XFD_ERR, 0);
 	/* xfd=0, enable amx */
 	wrmsr(MSR_IA32_XFD, 0);
-	GUEST_SYNC(9);
+	GUEST_SYNC(TEST_SAVE_RESTORE);
 }
 
 int main(int argc, char *argv[])
@@ -244,6 +254,7 @@ int main(int argc, char *argv[])
 	memset(addr_gva2hva(vm, xstate), 0, PAGE_SIZE * DIV_ROUND_UP(XSAVE_SIZE, PAGE_SIZE));
 	vcpu_args_set(vcpu, 3, amx_cfg, tiledata, xstate);
 
+	int iter = 0;
 	for (;;) {
 		vcpu_run(vcpu);
 		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
@@ -253,20 +264,9 @@ int main(int argc, char *argv[])
 			REPORT_GUEST_ASSERT(uc);
 			/* NOT REACHED */
 		case UCALL_SYNC:
-			switch (uc.args[1]) {
-			case 1:
-			case 2:
-			case 3:
-			case 5:
-			case 6:
-			case 7:
-			case 8:
-				fprintf(stderr, "GUEST_SYNC(%ld)\n", uc.args[1]);
-				break;
-			case 4:
-			case 10:
-				fprintf(stderr,
-				"GUEST_SYNC(%ld), check save/restore status\n", uc.args[1]);
+			++iter;
+			if (uc.args[1] & TEST_COMPARE_TILEDATA) {
+				fprintf(stderr, "GUEST_SYNC #%d, check TMM0 contents\n", iter);
 
 				/* Compacted mode, get amx offset by xsave area
 				 * size subtract 8K amx size.
@@ -279,11 +279,25 @@ int main(int argc, char *argv[])
 				ret = memcmp(amx_start, tiles_data, TILE_SIZE);
 				TEST_ASSERT(ret == 0, "memcmp failed, ret=%d", ret);
 				kvm_x86_state_cleanup(state);
-				break;
-			case 9:
-				fprintf(stderr,
-				"GUEST_SYNC(%ld), #NM exception and enable amx\n", uc.args[1]);
-				break;
+			}
+			if (uc.args[1] & TEST_SAVE_RESTORE) {
+				fprintf(stderr, "GUEST_SYNC #%d, save/restore VM state\n", iter);
+				state = vcpu_save_state(vcpu);
+				memset(&regs1, 0, sizeof(regs1));
+				vcpu_regs_get(vcpu, &regs1);
+
+				kvm_vm_release(vm);
+
+				/* Restore state in a new VM.  */
+				vcpu = vm_recreate_with_one_vcpu(vm);
+				vcpu_load_state(vcpu, state);
+				kvm_x86_state_cleanup(state);
+
+				memset(&regs2, 0, sizeof(regs2));
+				vcpu_regs_get(vcpu, &regs2);
+				TEST_ASSERT(!memcmp(&regs1, &regs2, sizeof(regs2)),
+					    "Unexpected register values after vcpu_load_state; rdi: %lx rsi: %lx",
+					    (ulong) regs2.rdi, (ulong) regs2.rsi);
 			}
 			break;
 		case UCALL_DONE:
@@ -293,22 +307,6 @@ int main(int argc, char *argv[])
 			TEST_FAIL("Unknown ucall %lu", uc.cmd);
 		}
 
-		state = vcpu_save_state(vcpu);
-		memset(&regs1, 0, sizeof(regs1));
-		vcpu_regs_get(vcpu, &regs1);
-
-		kvm_vm_release(vm);
-
-		/* Restore state in a new VM.  */
-		vcpu = vm_recreate_with_one_vcpu(vm);
-		vcpu_load_state(vcpu, state);
-		kvm_x86_state_cleanup(state);
-
-		memset(&regs2, 0, sizeof(regs2));
-		vcpu_regs_get(vcpu, &regs2);
-		TEST_ASSERT(!memcmp(&regs1, &regs2, sizeof(regs2)),
-			    "Unexpected register values after vcpu_load_state; rdi: %lx rsi: %lx",
-			    (ulong) regs2.rdi, (ulong) regs2.rsi);
 	}
 done:
 	kvm_vm_free(vm);
-- 
2.52.0


