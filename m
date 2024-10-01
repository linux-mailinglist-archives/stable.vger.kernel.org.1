Return-Path: <stable+bounces-78346-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8283E98B7A6
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 10:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4388B283E88
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 08:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D8019B5B8;
	Tue,  1 Oct 2024 08:55:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942F55589B;
	Tue,  1 Oct 2024 08:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727772940; cv=none; b=jm/OwrPVlrE8dLgh16eFVVJ4fGGWszzWA+Yv+ARLs/gbA0W+vbAhXJhS289uHTqohoRH/hVw85jBXr8ntiAF9FILIfa1zeTD2nS4WuCfRa9Mm1MTz/3m/MRMRaa7+mR/0x+PrJUP1Fb2NHUCxf5/T3064UcOMczWPzVfL+SvgWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727772940; c=relaxed/simple;
	bh=Q9IWqw0jPvOLwMDbSkL/6NzXAa1aunw7reKWoBqQDLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EHA0E90bUzV4T00+MQ9XrFRyLXcydKCZO6F/Wl9W8wR5lDvlo48CLk0f6HXl1DJXwdR8pzemdE+nHz9/EjKkYQO7KeRopsozxN9LO19hew6mK+aPGM1KMFmjCOqjm5oX6sNHJCxbsQzU3w6J6krSxJVKmk3NlTY5CLcWQb82Wdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C84C4CEC6;
	Tue,  1 Oct 2024 08:55:37 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: Bibo Mao <maobibo@loongson.cn>,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xuerui Wang <kernel@xen0n.name>,
	stable@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.10.y] Revert "LoongArch: KVM: Invalidate guest steal time address on vCPU reset"
Date: Tue,  1 Oct 2024 16:55:21 +0800
Message-ID: <20241001085521.102817-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <CAAhV-H4WLByJ53oqQgEnVjy4bT0pS77fT5BA4NaCp8AOn+cyJw@mail.gmail.com>
References: <CAAhV-H4WLByJ53oqQgEnVjy4bT0pS77fT5BA4NaCp8AOn+cyJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 05969a6944713f159e8f28be2388500174521818.

LoongArch's PV steal time support is add after 6.10, so 6.10.y doesn't
need this fix.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/kvm_vcpu.h | 1 +
 arch/loongarch/kvm/timer.c            | 7 +++++++
 arch/loongarch/kvm/vcpu.c             | 2 +-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/include/asm/kvm_vcpu.h b/arch/loongarch/include/asm/kvm_vcpu.h
index d7e8f7d50ee0..f468450b24ab 100644
--- a/arch/loongarch/include/asm/kvm_vcpu.h
+++ b/arch/loongarch/include/asm/kvm_vcpu.h
@@ -82,6 +82,7 @@ static inline int kvm_own_lbt(struct kvm_vcpu *vcpu) { return -EINVAL; }
 #endif
 
 void kvm_init_timer(struct kvm_vcpu *vcpu, unsigned long hz);
+void kvm_reset_timer(struct kvm_vcpu *vcpu);
 void kvm_save_timer(struct kvm_vcpu *vcpu);
 void kvm_restore_timer(struct kvm_vcpu *vcpu);
 
diff --git a/arch/loongarch/kvm/timer.c b/arch/loongarch/kvm/timer.c
index 74a4b5c272d6..bcc6b6d063d9 100644
--- a/arch/loongarch/kvm/timer.c
+++ b/arch/loongarch/kvm/timer.c
@@ -188,3 +188,10 @@ void kvm_save_timer(struct kvm_vcpu *vcpu)
 	kvm_save_hw_gcsr(csr, LOONGARCH_CSR_ESTAT);
 	preempt_enable();
 }
+
+void kvm_reset_timer(struct kvm_vcpu *vcpu)
+{
+	write_gcsr_timercfg(0);
+	kvm_write_sw_gcsr(vcpu->arch.csr, LOONGARCH_CSR_TCFG, 0);
+	hrtimer_cancel(&vcpu->arch.swtimer);
+}
diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index 0697b1064251..16ad19a09660 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -869,7 +869,7 @@ static int kvm_set_one_reg(struct kvm_vcpu *vcpu,
 				vcpu->kvm->arch.time_offset = (signed long)(v - drdtime());
 			break;
 		case KVM_REG_LOONGARCH_VCPU_RESET:
-			vcpu->arch.st.guest_addr = 0;
+			kvm_reset_timer(vcpu);
 			memset(&vcpu->arch.irq_pending, 0, sizeof(vcpu->arch.irq_pending));
 			memset(&vcpu->arch.irq_clear, 0, sizeof(vcpu->arch.irq_clear));
 			break;
-- 
2.43.5


