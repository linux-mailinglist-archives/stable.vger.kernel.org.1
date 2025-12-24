Return-Path: <stable+bounces-203351-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF95CDAE2C
	for <lists+stable@lfdr.de>; Wed, 24 Dec 2025 01:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 574BF30358E7
	for <lists+stable@lfdr.de>; Wed, 24 Dec 2025 00:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296EA75809;
	Wed, 24 Dec 2025 00:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NMKS1vzf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jds33bok"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9066354774
	for <stable@vger.kernel.org>; Wed, 24 Dec 2025 00:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766535182; cv=none; b=aSLcWEZ61qaTsAsmvZzxQSQ28b+ogdRXDpzjGJptWhnOlEAKt8EFvdzcAc9LJvsWlbzos0t90lMDe7LPZHaG9HctNFEkrKT/JgkkSsJf9o8FaLfcLbUmgHUFFWd2zJ6AZt7Cg8tKLR1P9JGUpK2twFJbldBT/9HhAn7G/ZKlNpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766535182; c=relaxed/simple;
	bh=SUxMB9io5kUL3hiZuCM9QEc8yZLw0GrSlV7GpF2gspc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q9kRMUo8BEaD8G3OKkN9YhOrd792Kxp/vfVfmxidq9loWMLFrGIh9rthljzXG/GTGj498DTRgbCnYp0eg9QD8K3dbmsaodSZKkWy59ryy69ek0twHf6o6y4sMDTglU6akvjXgvyzQ1as2O8wQyqQssD2ERi206apd6VzugIq1Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NMKS1vzf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jds33bok; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766535179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cd2rAlHvk2Fc3rUlxPP7c9W8eyWSusr3FNKcOYNwGnk=;
	b=NMKS1vzfrtsh31CTW0ktQvl7KEif3n3aG51xi+JwWhDM8D2/TlZRyEA1okC/IeL9DPCE9b
	5lVqsfBAiPX27rOobDCOpBsZwikFWyq8U4+Yx65fKy//wT31Ch7WCQjGH9rkwv4wZY5Tc9
	IfHmxAwJhWUaYmpiubwSZwlJ4JksVNE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-_2lRjK9rPY6ZkRuW4qeU3g-1; Tue, 23 Dec 2025 19:12:58 -0500
X-MC-Unique: _2lRjK9rPY6ZkRuW4qeU3g-1
X-Mimecast-MFC-AGG-ID: _2lRjK9rPY6ZkRuW4qeU3g_1766535177
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-430fcb6b2ebso2977466f8f.2
        for <stable@vger.kernel.org>; Tue, 23 Dec 2025 16:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766535177; x=1767139977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cd2rAlHvk2Fc3rUlxPP7c9W8eyWSusr3FNKcOYNwGnk=;
        b=Jds33bok7nUlvbx3in6cNYI1t3Y/UP3b64r+trS8YhRuZTRPdxuDPvS3c+zTdlgoP/
         f06T9gAreEMqjiHvbJevRoUeFkyrDArh/7m8FN7m21myh01DTvO8jsXmj2GqQUies7gr
         hrIpcXJOF2U7ersStViJ2+WEJtsribg1dgDLKU+qRrin4XSUDutcyJLr177FXr8ULYhR
         0RaWgUmnQgN6T2uvihETJ/BEnG1wVM5fcEaTPxr0rqdxcwfXJraa9TVPnyvSDOcIJIFJ
         RF7gHBcwMvqWi5kbHo/ruItPqvDl2DGsleEtjNKXLatmzdD665M0MhKYyWcZBpbxc/l2
         1pNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766535177; x=1767139977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cd2rAlHvk2Fc3rUlxPP7c9W8eyWSusr3FNKcOYNwGnk=;
        b=L9fAagGl+7Nmlg/jzurEXYXNczCElceLAOjQD8zpgY1RRIsgZumsMcfKdLC9Cg+N0g
         cs2KggsSIJa2P8Qq+LMYXOWZqwiFdAq2NZc+Bv6Om+eMrCAP39G5dDXeCFpurldr6T3c
         HdMA2JTuKp6mLV0B5Y3SvF5jWFOpyTL3hVgKnvD4m9GPnX4NfalwTf+VfQI2FSfS3G2J
         8uye2gfIxnUUCspL3+pfI8B05sUEuzjxGPpOVmtm2t173aoiJiQ6aXjjf3yehhrqQ21z
         oOhQaaLvUGLu3E+Mx5fUFVpUUmnvgbhKGveq90rcKYMcBFMqgGTT9sJAkMQ1E8YYnR/r
         o+Sg==
X-Forwarded-Encrypted: i=1; AJvYcCWi/Bt7z2ofEZmHNmOlg6nDZqdKlEZmoOIBQLd6/X5qA1OwjAaEt8OB0uy4EhmwlsAZ1UeXMYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfpbCFXr2bN2U3sbXh+/BdFHW1HAFFLulhSTGt26Pc4LdbGDFd
	UPLp4b+Jy31FWHESWaOgZJzy3XSf4wr5bbzJFGmhCLfSG0AbhDuta3kbv6uOe4K+Kz/AKUmP8ov
	NAYWcLiUwNkXWNUqafzamYthNTefjilFDI2Muu7/w7X3cwMQLzhvQ0F1UFQ==
X-Gm-Gg: AY/fxX46nz/rq+zdz8NAruR6E9I9l95uFrDdf6LGhl+jom8oAWCzR3J2a0x/jVgKaxq
	kbSjSpKBhS0iOuPTwa5teEf0w2YkIENxTdsdYEqLba8rUkrcHRfetT2bUmjpfH0M0L8jY1nB3Vl
	hnPlVFtjB0zXIQehg2ybiFiTRlO+MUQVrTWlezgZM70/pznz9mYQqdRM5h09PhXKTa8jCengv2C
	ZGjJUW79r41j0hYxuHzOakemH7/AqcSSAlPj4pb45Gy8BrQOycdWRRNtUlI60EPR+gfwb+EbWGu
	kQw/zNNNzJqTEQA2b+yjptGSOkIz1V2XcsqRP9Jkdz+Gyljsr4gZsUnI47wwUBYjiBY1p9E7kIS
	+Hdmx1Y+mGnVOV2G+cgL1310kUr3aDXS23vQDFmxdRV3L521VbCq5QScLijSRaa/vfGVZbQ1EQ/
	6iS1p9zVNuJWN6Rq4=
X-Received: by 2002:a05:600c:628c:b0:47a:7fbf:d5c8 with SMTP id 5b1f17b1804b1-47d1958296bmr142012565e9.26.1766535176814;
        Tue, 23 Dec 2025 16:12:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7q/9gwLnCQEkdKpL0Em0GJ2ocZ6ifEAr9yGLRCJjag6irdREePfiliIJO9d7U2xigRdDUJA==
X-Received: by 2002:a05:600c:628c:b0:47a:7fbf:d5c8 with SMTP id 5b1f17b1804b1-47d1958296bmr142012415e9.26.1766535176377;
        Tue, 23 Dec 2025 16:12:56 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa0908sm30285139f8f.31.2025.12.23.16.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 16:12:54 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	x86@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/5] x86, fpu: separate fpstate->xfd and guest XFD
Date: Wed, 24 Dec 2025 01:12:46 +0100
Message-ID: <20251224001249.1041934-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224001249.1041934-1-pbonzini@redhat.com>
References: <20251224001249.1041934-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Until now, fpstate->xfd has acted as both the guest value and the value
that the host used when executing XSAVES and XRSTORS.  This is wrong: the
data in the guest's FPU might not be initialized even if a bit is
set in XFD and, when that happens, XRSTORing the guest FPU will fail
with a #NM exception *on the host*.

Instead, store the value of XFD together with XFD_ERR in struct
fpu_guest; it will still be synchronized in fpu_load_guest_fpstate(), but
the XRSTOR(S) operation will be able to load any valid state of the FPU
independent of the XFD value.

Cc: stable@vger.kernel.org
Fixes: 820a6ee944e7 ("kvm: x86: Add emulation for IA32_XFD", 2022-01-14)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/fpu/api.h   |  6 ++----
 arch/x86/include/asm/fpu/types.h |  7 +++++++
 arch/x86/kernel/fpu/core.c       | 19 ++++---------------
 arch/x86/kernel/fpu/xstate.h     | 18 ++++++++++--------
 arch/x86/kvm/x86.c               |  6 +++---
 5 files changed, 26 insertions(+), 30 deletions(-)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index 0820b2621416..ee9ba06b7dbe 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -152,11 +152,9 @@ extern int fpu_swap_kvm_fpstate(struct fpu_guest *gfpu, bool enter_guest);
 extern int fpu_enable_guest_xfd_features(struct fpu_guest *guest_fpu, u64 xfeatures);
 
 #ifdef CONFIG_X86_64
-extern void fpu_update_guest_xfd(struct fpu_guest *guest_fpu, u64 xfd);
-extern void fpu_sync_guest_vmexit_xfd_state(void);
+extern void fpu_sync_guest_vmexit_xfd_state(struct fpu_guest *gfpu);
 #else
-static inline void fpu_update_guest_xfd(struct fpu_guest *guest_fpu, u64 xfd) { }
-static inline void fpu_sync_guest_vmexit_xfd_state(void) { }
+static inline void fpu_sync_guest_vmexit_xfd_state(struct fpu_guest *gfpu) { }
 #endif
 
 extern void fpu_copy_guest_fpstate_to_uabi(struct fpu_guest *gfpu, void *buf,
diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index 93e99d2583d6..7abe231e2ffe 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -545,6 +545,13 @@ struct fpu_guest {
 	 */
 	u64				xfeatures;
 
+	/*
+	 * @xfd:			Save the guest value.  Note that this is
+	 *				*not* fpstate->xfd, which is the value
+	 *				the host uses when doing XSAVE/XRSTOR.
+	 */
+	u64				xfd;
+
 	/*
 	 * @xfd_err:			Save the guest value.
 	 */
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index a480fa8c65d5..ff17c96d290a 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -317,16 +317,6 @@ int fpu_enable_guest_xfd_features(struct fpu_guest *guest_fpu, u64 xfeatures)
 EXPORT_SYMBOL_FOR_KVM(fpu_enable_guest_xfd_features);
 
 #ifdef CONFIG_X86_64
-void fpu_update_guest_xfd(struct fpu_guest *guest_fpu, u64 xfd)
-{
-	fpregs_lock();
-	guest_fpu->fpstate->xfd = xfd;
-	if (guest_fpu->fpstate->in_use)
-		xfd_update_state(guest_fpu->fpstate);
-	fpregs_unlock();
-}
-EXPORT_SYMBOL_FOR_KVM(fpu_update_guest_xfd);
-
 /**
  * fpu_sync_guest_vmexit_xfd_state - Synchronize XFD MSR and software state
  *
@@ -339,14 +329,12 @@ EXPORT_SYMBOL_FOR_KVM(fpu_update_guest_xfd);
  * Note: It can be invoked unconditionally even when write emulation is
  * enabled for the price of a then pointless MSR read.
  */
-void fpu_sync_guest_vmexit_xfd_state(void)
+void fpu_sync_guest_vmexit_xfd_state(struct fpu_guest *gfpu)
 {
-	struct fpstate *fpstate = x86_task_fpu(current)->fpstate;
-
 	lockdep_assert_irqs_disabled();
 	if (fpu_state_size_dynamic()) {
-		rdmsrq(MSR_IA32_XFD, fpstate->xfd);
-		__this_cpu_write(xfd_state, fpstate->xfd);
+		rdmsrq(MSR_IA32_XFD, gfpu->xfd);
+		__this_cpu_write(xfd_state, gfpu->xfd);
 	}
 }
 EXPORT_SYMBOL_FOR_KVM(fpu_sync_guest_vmexit_xfd_state);
@@ -890,6 +878,7 @@ void fpu_load_guest_fpstate(struct fpu_guest *gfpu)
 		fpregs_restore_userregs();
 
 	fpregs_assert_state_consistent();
+	xfd_set_state(gfpu->xfd);
 	if (gfpu->xfd_err)
 		wrmsrq(MSR_IA32_XFD_ERR, gfpu->xfd_err);
 }
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 52ce19289989..c0ce05bee637 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -180,26 +180,28 @@ static inline void xfd_validate_state(struct fpstate *fpstate, u64 mask, bool rs
 #endif
 
 #ifdef CONFIG_X86_64
-static inline void xfd_set_state(u64 xfd)
+static inline void __xfd_set_state(u64 xfd)
 {
 	wrmsrq(MSR_IA32_XFD, xfd);
 	__this_cpu_write(xfd_state, xfd);
 }
 
+static inline void xfd_set_state(u64 xfd)
+{
+	if (__this_cpu_read(xfd_state) != xfd)
+		__xfd_set_state(xfd);
+}
+
 static inline void xfd_update_state(struct fpstate *fpstate)
 {
-	if (fpu_state_size_dynamic()) {
-		u64 xfd = fpstate->xfd;
-
-		if (__this_cpu_read(xfd_state) != xfd)
-			xfd_set_state(xfd);
-	}
+	if (fpu_state_size_dynamic())
+		xfd_set_state(fpstate->xfd);
 }
 
 extern int __xfd_enable_feature(u64 which, struct fpu_guest *guest_fpu);
 #else
 static inline void xfd_set_state(u64 xfd) { }
-
+static inline void __xfd_set_state(u64 xfd) { }
 static inline void xfd_update_state(struct fpstate *fpstate) { }
 
 static inline int __xfd_enable_feature(u64 which, struct fpu_guest *guest_fpu) {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 01d95192dfc5..56fd082859bc 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4261,7 +4261,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		if (data & ~kvm_guest_supported_xfd(vcpu))
 			return 1;
 
-		fpu_update_guest_xfd(&vcpu->arch.guest_fpu, data);
+		vcpu->arch.guest_fpu.xfd = data;
 		break;
 	case MSR_IA32_XFD_ERR:
 		if (!msr_info->host_initiated &&
@@ -4617,7 +4617,7 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		    !guest_cpu_cap_has(vcpu, X86_FEATURE_XFD))
 			return 1;
 
-		msr_info->data = vcpu->arch.guest_fpu.fpstate->xfd;
+		msr_info->data = vcpu->arch.guest_fpu.xfd;
 		break;
 	case MSR_IA32_XFD_ERR:
 		if (!msr_info->host_initiated &&
@@ -11405,7 +11405,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	 * in #NM irqoff handler).
 	 */
 	if (vcpu->arch.xfd_no_write_intercept)
-		fpu_sync_guest_vmexit_xfd_state();
+		fpu_sync_guest_vmexit_xfd_state(&vcpu->arch.guest_fpu);
 
 	kvm_x86_call(handle_exit_irqoff)(vcpu);
 
-- 
2.52.0


