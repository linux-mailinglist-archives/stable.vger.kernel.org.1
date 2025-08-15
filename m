Return-Path: <stable+bounces-169641-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D326B27362
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 02:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ED631CC78C3
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 00:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBCA15B135;
	Fri, 15 Aug 2025 00:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cu8upKj5"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077E872627
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 00:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755216741; cv=none; b=twtcE602NX/CT+Kbt7cTKEaIfxcfZjEY24gPiCmIWgzcd58okckQlq9A8agciqP0r1O0TTGtAVo5Inja6IDqpPFGG5bov6YHNwZX3TO3FGNvsgn+MrHgt64Rzxyc+7PCqc4zuOLFrypJyapwe8sMMYNVPszzUAENfE0iu41nAZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755216741; c=relaxed/simple;
	bh=wXaM5AxQLRyXz5bcyjoW0XMTnldHJbjQsY/Zd0euGkE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TbGpZpp5UjYZ8d7WJyFZn8TLNfyVg23xyrXIjcS8lo5cQhclevcOKhhyQrRIlC7qVERNw/SFs9oLIhJUc2xj2cxWhbJOlO2rFwhFHAUrvIlDJ3Xxt8Bb1k7bIJ6Vj5etN5eS12WU4xKcXbJVY/jOcHNFMEF4t9UgEBRvondHLDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cu8upKj5; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32326bf571bso2617124a91.2
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 17:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755216739; x=1755821539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Fqu7wrx+Ay2x6fvOSsf35l8fx+Qfz/0UwNU0RPDTSM=;
        b=cu8upKj5/ryc6b/BhlHtU3pp7awy1mYIjuHAMNp1DoiF82zbGej51LshRMaU3CQOFC
         qAAqixmYvX+cBkSuDi1165ZpcwV9Evva3zmTasW0K4nNF7XkMxxJjCeR8mUmcS3eAvMI
         KrgjmpW9pBaVI3TGfU8nU8/GNdD/OxonwLxqpErttQKCjFzNZlCj8OAFCRikEyNFynTM
         ebZG3rdhX7al798sQ85HQOy1kKtUa5MSWyCSlGucGmhLnwRejSSTLWr0FEnQKqWht/x3
         L70O8c8+gzlVTI9IRh6tjv6LcYB77125aGfxFehR4AnhGjrUJ170o6Zha2H8Zaq3d27K
         keiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755216739; x=1755821539;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+Fqu7wrx+Ay2x6fvOSsf35l8fx+Qfz/0UwNU0RPDTSM=;
        b=fKu4VQL6Kl0vVc1IZN58UYvt2BvW6TnjY2h2wkoZxqmSC2rCqA5g7/SU6aaDSmoPw6
         JYk4rZmB8qNhRo10BWYawFQoOGnWDDk402q6f9XLGSo9t2xNfkB/mxKLwgZ8skpX5Trh
         Ti0piFPytvjZxF1vyCVpjRsnqQ7lmuEOg0xDKd+5IOAS3YRw4S058oaKLbRQZwV1aXVc
         mszQ03bN6qkW4LvAEvN8hvNT5emSWziGw3waODOqcdS2ABl12F1YJlXTLmWsg6Q0hL59
         a7YYeZD0v8AT+/+BdbVTjtADGnp86dtwVBOf5G1LVLeQKm7MCbCLWkO3OUD3N04e0kCr
         9FWQ==
X-Gm-Message-State: AOJu0Yz58ViOkdUSCgTJa4VnqvWEl/1cRnaPur7XIyAKKzLFrwB3rE9w
	5JGNEZBTfVmfGhu7MUrTdnPStdRNMJlJmSewlmA+Py5kTIqjaJ+vr8XFPxdfQg060XnLFJozzrc
	5WpQ2pSmMIf3PWxvB/ztwyC0M3Y8jwQk0jT7vCYKYfvToJuD7kqCavm+JYKx4WoLst/KRrn60ia
	/Gfa4hbNV9QVSdPZVf363jPUtfKiwaaBOjJKBu
X-Google-Smtp-Source: AGHT+IHdvPjO+PSktSEguZkgDKjA9pak/bEJv7YrtAW2Eb4NHFPHoTx4HeFa5dmZWDF+LEswbee2ZeWv+GA=
X-Received: from pjff7.prod.google.com ([2002:a17:90b:5627:b0:321:abeb:1d8a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3fcf:b0:31e:998f:7b75
 with SMTP id 98e67ed59e1d1-32341e0d69cmr359045a91.9.1755216739296; Thu, 14
 Aug 2025 17:12:19 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 Aug 2025 17:11:48 -0700
In-Reply-To: <20250815001205.2370711-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815001205.2370711-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815001205.2370711-5-seanjc@google.com>
Subject: [PATCH 6.1.y 04/21] KVM: nVMX: Defer SVI update to vmcs01 on EOI when
 L2 is active w/o VID
From: Sean Christopherson <seanjc@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Chao Gao <chao.gao@intel.com>

[ Upstream commit 04bc93cf49d16d01753b95ddb5d4f230b809a991 ]

If KVM emulates an EOI for L1's virtual APIC while L2 is active, defer
updating GUEST_INTERUPT_STATUS.SVI, i.e. the VMCS's cache of the highest
in-service IRQ, until L1 is active, as vmcs01, not vmcs02, needs to track
vISR.  The missed SVI update for vmcs01 can result in L1 interrupts being
incorrectly blocked, e.g. if there is a pending interrupt with lower
priority than the interrupt that was EOI'd.

This bug only affects use cases where L1's vAPIC is effectively passed
through to L2, e.g. in a pKVM scenario where L2 is L1's depriveleged host,
as KVM will only emulate an EOI for L1's vAPIC if Virtual Interrupt
Delivery (VID) is disabled in vmc12, and L1 isn't intercepting L2 accesses
to its (virtual) APIC page (or if x2APIC is enabled, the EOI MSR).

WARN() if KVM updates L1's ISR while L2 is active with VID enabled, as an
EOI from L2 is supposed to affect L2's vAPIC, but still defer the update,
to try to keep L1 alive.  Specifically, KVM forwards all APICv-related
VM-Exits to L1 via nested_vmx_l1_wants_exit():

	case EXIT_REASON_APIC_ACCESS:
	case EXIT_REASON_APIC_WRITE:
	case EXIT_REASON_EOI_INDUCED:
		/*
		 * The controls for "virtualize APIC accesses," "APIC-
		 * register virtualization," and "virtual-interrupt
		 * delivery" only come from vmcs12.
		 */
		return true;

Fixes: c7c9c56ca26f ("x86, apicv: add virtual interrupt delivery support")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/kvm/20230312180048.1778187-1-jason.cj.chen@in=
tel.com
Reported-by: Markku Ahvenj=C3=A4rvi <mankku@gmail.com>
Closes: https://lore.kernel.org/all/20240920080012.74405-1-mankku@gmail.com
Cc: Janne Karhunen <janne.karhunen@gmail.com>
Signed-off-by: Chao Gao <chao.gao@intel.com>
[sean: drop request, handle in VMX, write changelog]
Tested-by: Chao Gao <chao.gao@intel.com>
Link: https://lore.kernel.org/r/20241128000010.4051275-3-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
[sean: resolve minor syntactic conflict in lapic.h, account for lack of
       kvm_x86_call(), drop sanity check due to lack of wants_to_run]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c      | 11 +++++++++++
 arch/x86/kvm/lapic.h      |  1 +
 arch/x86/kvm/vmx/nested.c |  5 +++++
 arch/x86/kvm/vmx/vmx.c    | 16 ++++++++++++++++
 arch/x86/kvm/vmx/vmx.h    |  1 +
 5 files changed, 34 insertions(+)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 3d65d6a023c9..9aae76b74417 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -640,6 +640,17 @@ static inline void apic_clear_isr(int vec, struct kvm_=
lapic *apic)
 	}
 }
=20
+void kvm_apic_update_hwapic_isr(struct kvm_vcpu *vcpu)
+{
+	struct kvm_lapic *apic =3D vcpu->arch.apic;
+
+	if (WARN_ON_ONCE(!lapic_in_kernel(vcpu)) || !apic->apicv_active)
+		return;
+
+	static_call(kvm_x86_hwapic_isr_update)(vcpu, apic_find_highest_isr(apic))=
;
+}
+EXPORT_SYMBOL_GPL(kvm_apic_update_hwapic_isr);
+
 int kvm_lapic_find_highest_irr(struct kvm_vcpu *vcpu)
 {
 	/* This may race with setting of irr in __apic_accept_irq() and
diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
index a5ac4a5a5179..e5d2dc58fcf8 100644
--- a/arch/x86/kvm/lapic.h
+++ b/arch/x86/kvm/lapic.h
@@ -122,6 +122,7 @@ int kvm_set_apic_base(struct kvm_vcpu *vcpu, struct msr=
_data *msr_info);
 int kvm_apic_get_state(struct kvm_vcpu *vcpu, struct kvm_lapic_state *s);
 int kvm_apic_set_state(struct kvm_vcpu *vcpu, struct kvm_lapic_state *s);
 enum lapic_mode kvm_get_apic_mode(struct kvm_vcpu *vcpu);
+void kvm_apic_update_hwapic_isr(struct kvm_vcpu *vcpu);
 int kvm_lapic_find_highest_irr(struct kvm_vcpu *vcpu);
=20
 u64 kvm_get_lapic_tscdeadline_msr(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 8052f8b7d8e1..d55f7edc0860 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -4839,6 +4839,11 @@ void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm=
_exit_reason,
 		kvm_make_request(KVM_REQ_APICV_UPDATE, vcpu);
 	}
=20
+	if (vmx->nested.update_vmcs01_hwapic_isr) {
+		vmx->nested.update_vmcs01_hwapic_isr =3D false;
+		kvm_apic_update_hwapic_isr(vcpu);
+	}
+
 	if ((vm_exit_reason !=3D -1) &&
 	    (enable_shadow_vmcs || evmptr_is_valid(vmx->nested.hv_evmcs_vmptr)))
 		vmx->nested.need_vmcs12_to_shadow_sync =3D true;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 721ba6ddb121..7b87fbc69b21 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6713,6 +6713,22 @@ static void vmx_hwapic_isr_update(struct kvm_vcpu *v=
cpu, int max_isr)
 	u16 status;
 	u8 old;
=20
+	/*
+	 * If L2 is active, defer the SVI update until vmcs01 is loaded, as SVI
+	 * is only relevant for if and only if Virtual Interrupt Delivery is
+	 * enabled in vmcs12, and if VID is enabled then L2 EOIs affect L2's
+	 * vAPIC, not L1's vAPIC.  KVM must update vmcs01 on the next nested
+	 * VM-Exit, otherwise L1 with run with a stale SVI.
+	 */
+	if (is_guest_mode(vcpu)) {
+		/*
+		 * KVM is supposed to forward intercepted L2 EOIs to L1 if VID
+		 * is enabled in vmcs12; as above, the EOIs affect L2's vAPIC.
+		 */
+		to_vmx(vcpu)->nested.update_vmcs01_hwapic_isr =3D true;
+		return;
+	}
+
 	if (max_isr =3D=3D -1)
 		max_isr =3D 0;
=20
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 9e0bb98b116d..8b4b149bd9c1 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -189,6 +189,7 @@ struct nested_vmx {
 	bool reload_vmcs01_apic_access_page;
 	bool update_vmcs01_cpu_dirty_logging;
 	bool update_vmcs01_apicv_status;
+	bool update_vmcs01_hwapic_isr;
=20
 	/*
 	 * Enlightened VMCS has been enabled. It does not mean that L1 has to
--=20
2.51.0.rc1.163.g2494970778-goog


