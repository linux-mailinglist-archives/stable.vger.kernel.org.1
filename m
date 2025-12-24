Return-Path: <stable+bounces-203350-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADA6CDAE26
	for <lists+stable@lfdr.de>; Wed, 24 Dec 2025 01:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA6313045A43
	for <lists+stable@lfdr.de>; Wed, 24 Dec 2025 00:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B393D3B3;
	Wed, 24 Dec 2025 00:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DjXFD2Xi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mT79PEif"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA702126C03
	for <stable@vger.kernel.org>; Wed, 24 Dec 2025 00:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766535181; cv=none; b=jXJv7cdomys3/uA4wUYBe7v/xOHqOEPFTtptNHcYsmLRot+HKJBFnzepXgNbYoNlPzR2o59fpuGZNWztdTGg47t0VyDs7k0+ae2X/4x17zZu/qrturRNnOs6fElI1XhR2uFgNpK3PSTZANlrV7LSG3UJg3awSgx9v/IQSBbAS6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766535181; c=relaxed/simple;
	bh=hWlCqxxO4rNeS3u3z5E066XItSLKm9DA4Bx5w9CplKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FgPD6sPFWj08tlb2ZgwZ9w/noYn3eBqy8tGYKSxFosjxe/iNZIPlayz3LYZqNJ6luRv++PJKPSiOiDKnWwuS06xbWFpB+bNibuQzlEZxiYAsMKdii7r8KAl2Anw4X8U3HTp5WrvtscjsF0MrNposyCAdqFE1o9jhDPYLoZsPtPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DjXFD2Xi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mT79PEif; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766535177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wpa7TThaJI94/M4NKCUGmC4bcd1iUcwxLhMpe/Pmu+I=;
	b=DjXFD2XiDCi8PdwpIJykKnJjaav3BdgcAPU8mYtDTkE5mEXdX8hE1dkL7fZzp+ejz9SfW+
	GeruasQIPXa+SA3bdNoCCfxb8b8PsCDDl50xD/Z8MoeNc9ebFwwHmApjkEPbeQ/eiGyZhZ
	IyNvGLMgyLe7Va4bWKcgAxmhzb2tr38=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-tZ3yb3voPIC67d0yqeHM8Q-1; Tue, 23 Dec 2025 19:12:55 -0500
X-MC-Unique: tZ3yb3voPIC67d0yqeHM8Q-1
X-Mimecast-MFC-AGG-ID: tZ3yb3voPIC67d0yqeHM8Q_1766535174
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477b8a667bcso76760365e9.2
        for <stable@vger.kernel.org>; Tue, 23 Dec 2025 16:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766535174; x=1767139974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wpa7TThaJI94/M4NKCUGmC4bcd1iUcwxLhMpe/Pmu+I=;
        b=mT79PEifZOE7VN1nrXdpzsqaA4NEd1eDjFI5JrOBCzE8YsHk/JesPwSGBq1i07jdXq
         KQTx7dlYz7k9JElo+T8lgTqJT6z/KRJnCeQaAP9jfn/Pv44xM/sAnkJAVAcPiFbemt9q
         PgwYrwL5Oo5IZp7jM4oGsLUL3genNE85QtV7N6r4WFoVXaVUvbWzJcl1v5yIwYgS0ZaH
         Ob4HqMISAqGDkNx//JSNH6ogNo85gLlQSGruzbSc/nJO6IUXv7lkCCtp5MNtm/vqUd9K
         Tjxjy5Qho6QeyvKx9tQT8Jcg8fwTkvuHKdTRBAPjXSltSPj7HKy49RfhuBnw5AfEkv19
         UHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766535174; x=1767139974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wpa7TThaJI94/M4NKCUGmC4bcd1iUcwxLhMpe/Pmu+I=;
        b=og0QAT1rMgB5v+5ytYcmSpMPXKvxlE7TErgkynT3T0Y/09cXqjQrjbl/I8SH1SMfPj
         p/XNhEYp4d+nPHuJxd7hUdJdyGxcYTjdBMXObDwHHvuJBIgfDzyicJguyx/9Xht9Qs/u
         tbXKTNOp/ybBSaWPzn9FjRnSGf+C4esYY+cw2QWDB0ptR0ySQLKA+Q8+fVeMMT9hBRVP
         qdoYRKq18PA1NGpNfWp4DlVaEkJZyV5/w4OkJJzvh7THve0XQGTl1VgzGvqNtKwcvhum
         fRwWI9l9oROstRoE1wT6KDvtSHWDH3lISz68FBKnC01QqQOU6TiPwgQtKHtxK4gGGcGn
         TY+w==
X-Forwarded-Encrypted: i=1; AJvYcCWaIusKCqnvvcKE0g3oa+UsDgDkJ8wIMJ7E/27nMD/ljcuUEcj4ECrzvOKILQQUg0LE944tNQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBmACrRpjJqisoCA3Fh0SXvyDhjcH2+4aqTGdvtJk6Hz6jh1Nq
	zZPcD1AMWLHRdbKZALaAHalDgJfTUxlGjzsQtjnX3OfR3zfm/4j9Rz9Q1wOyfQ+ap8nqUMEhSFZ
	hJDbMtf/RVUkjLGwnh+XEZIEZ6qvao+olpKbmZsMiLkjkB9YcJnjThPvJAA==
X-Gm-Gg: AY/fxX5E5u91qi8Fs4fdRcZfpFqi3hvIOFtZeVFBiFJNjhvo1y0N4WZCd4zCLaJQIxg
	Q6YbKH8lzX3szE4qwz6WH2EGwojk91tFde1V7VOePSg6sTSeADowfawOV2JPPAa1S3fux08jDck
	68RHw3vPEghOc340GB59P7bX9PA9UJUvdBaz1KUc8CWCGytsiLh6wWs0UJZtaVtw23l5COPZJTx
	eQ0KDW3Cx0G3xLaGEGo6oulOUkpEdCGl2pOHdC9/nfhmRVPAnk1d5i8nRH6OrWDr45IwcryOAXU
	YvHt+4onrp00KeJ2smiaVRNF3H2pyCkDNs6tnUod1uiB7To8O/s4BelYo3a3nRL2X7fHQ51ZegN
	NtNipoJXq7wluGURa86QvhKy50I2Kdb2McqCaqLi/hM+8ZRWoppmsFWuqIbb1vn9TWh4w590ZkA
	dp6pz4WmJDxFn6LW8=
X-Received: by 2002:a05:600c:4709:b0:477:9aeb:6a8f with SMTP id 5b1f17b1804b1-47d220b7f4dmr127797215e9.9.1766535174410;
        Tue, 23 Dec 2025 16:12:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4shwSxKh09RXUVkp89RPVC5AHTfJRsb/m35JDsGHtZiPzxZLORNyA9500LRq6dFLONLymXg==
X-Received: by 2002:a05:600c:4709:b0:477:9aeb:6a8f with SMTP id 5b1f17b1804b1-47d220b7f4dmr127797055e9.9.1766535174069;
        Tue, 23 Dec 2025 16:12:54 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be279c5f8sm302090195e9.9.2025.12.23.16.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 16:12:52 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	x86@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/5] x86, fpu: introduce fpu_load_guest_fpstate()
Date: Wed, 24 Dec 2025 01:12:45 +0100
Message-ID: <20251224001249.1041934-2-pbonzini@redhat.com>
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

Create a variant of fpregs_lock_and_load() that KVM can use in its
vCPU entry code after preemption has been disabled.  While basing
it on the existing logic in vcpu_enter_guest(), ensure that
fpregs_assert_state_consistent() always runs and sprinkle a few
more assertions.

Cc: stable@vger.kernel.org
Fixes: 820a6ee944e7 ("kvm: x86: Add emulation for IA32_XFD", 2022-01-14)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/fpu/api.h |  1 +
 arch/x86/kernel/fpu/core.c     | 17 +++++++++++++++++
 arch/x86/kvm/x86.c             |  8 +-------
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index cd6f194a912b..0820b2621416 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -147,6 +147,7 @@ extern void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr);
 /* KVM specific functions */
 extern bool fpu_alloc_guest_fpstate(struct fpu_guest *gfpu);
 extern void fpu_free_guest_fpstate(struct fpu_guest *gfpu);
+extern void fpu_load_guest_fpstate(struct fpu_guest *gfpu);
 extern int fpu_swap_kvm_fpstate(struct fpu_guest *gfpu, bool enter_guest);
 extern int fpu_enable_guest_xfd_features(struct fpu_guest *guest_fpu, u64 xfeatures);
 
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 3ab27fb86618..a480fa8c65d5 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -878,6 +878,23 @@ void fpregs_lock_and_load(void)
 	fpregs_assert_state_consistent();
 }
 
+void fpu_load_guest_fpstate(struct fpu_guest *gfpu)
+{
+#ifdef CONFIG_X86_DEBUG_FPU
+	struct fpu *fpu = x86_task_fpu(current);
+	WARN_ON_ONCE(gfpu->fpstate != fpu->fpstate);
+#endif
+
+	lockdep_assert_preemption_disabled();
+	if (test_thread_flag(TIF_NEED_FPU_LOAD))
+		fpregs_restore_userregs();
+
+	fpregs_assert_state_consistent();
+	if (gfpu->xfd_err)
+		wrmsrq(MSR_IA32_XFD_ERR, gfpu->xfd_err);
+}
+EXPORT_SYMBOL_FOR_KVM(fpu_load_guest_fpstate);
+
 #ifdef CONFIG_X86_DEBUG_FPU
 /*
  * If current FPU state according to its tracking (loaded FPU context on this
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ff8812f3a129..01d95192dfc5 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11300,13 +11300,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		kvm_make_request(KVM_REQ_EVENT, vcpu);
 	}
 
-	fpregs_assert_state_consistent();
-	if (test_thread_flag(TIF_NEED_FPU_LOAD))
-		switch_fpu_return();
-
-	if (vcpu->arch.guest_fpu.xfd_err)
-		wrmsrq(MSR_IA32_XFD_ERR, vcpu->arch.guest_fpu.xfd_err);
-
+	fpu_load_guest_fpstate(&vcpu->arch.guest_fpu);
 	kvm_load_xfeatures(vcpu, true);
 
 	if (unlikely(vcpu->arch.switch_db_regs &&
-- 
2.52.0


