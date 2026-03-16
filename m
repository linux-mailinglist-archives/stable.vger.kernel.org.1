Return-Path: <stable+bounces-225637-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IH4nDac9uGmpagEAu9opvQ
	(envelope-from <stable+bounces-225637-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 18:28:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8F129E320
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 18:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 511A730AD668
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 17:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C04D3D1CBB;
	Mon, 16 Mar 2026 17:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lz8taum8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40F13CFF51
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 17:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681611; cv=none; b=d+kV5H+1sxTiuB8gfH/7FpkQhghVU4BdG/OJexz8ogWDt/pko0mMgZ2ndgCfNminmeZ4Pn6t36xEKptbFtn73Ar4KKYOatdnD+dMnTsLsG/hwE8PgioteticyvrIXUJkgPTICWTNw8QYiD0JH2aybHVEmOnVzmMvnTFAyseKwzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681611; c=relaxed/simple;
	bh=hdVX+nRaGK9tzO/7tGq1HC/QPqPg3gJp7cInmTy2zGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t7zTC3yzL6+x7XiMeEn4PIjc9kYeRo5KSYplYlmRGPEfjC0SbFnKUCNUibOgg+Ct49D/xosT7v1WZ3Hi2tdTDtTAnD6GOFaBlb1BEkv9H57D+fCeoWezBLfRGi0Q3rV72vSKs56huHxhR2Jggpy68dHedgnsN/fZUVDtRsc9bZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lz8taum8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F91C2BC87;
	Mon, 16 Mar 2026 17:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773681610;
	bh=hdVX+nRaGK9tzO/7tGq1HC/QPqPg3gJp7cInmTy2zGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lz8taum8JNgENwGgseWyjeJDBYFqmlLYtJdzD4I2zJFprq3zPdB39v//l6CWliCcg
	 2POdp3w8SvmmsSAxjxaJ9CTbbVFiM2sSnROWICIxKMNliQONffTXd8NVRS0bUifoAj
	 dbY6O+F/NB4zTV5hhR82CgwOjOQnzKlDpafppFhwtYxRK1hKuOcVJo5fAumljJWZaQ
	 cD55CPmLilQx93aTjedS4mGGTvMSLyObXmm9ZLdWrq40+LgoZb6+TPtTN1xp7kH0Cc
	 75Z75YY7Mdi5b9zoJ4YPxw/qF/lKfYh9ea82SPrae4/vzBfbjcmPjWxR8BJGgtx3Bv
	 gKGizbPLPI/IQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Gao <chao.gao@intel.com>,
	Mathias Krause <minipli@grsecurity.net>,
	John Allen <john.allen@amd.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 7/8] KVM: nVMX: Add consistency checks for CR0.WP and CR4.CET
Date: Mon, 16 Mar 2026 13:20:02 -0400
Message-ID: <20260316172003.1024253-7-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260316172003.1024253-1-sashal@kernel.org>
References: <2026031659-scroll-setting-4687@gregkh>
 <20260316172003.1024253-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225637-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CA8F129E320
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chao Gao <chao.gao@intel.com>

[ Upstream commit 8060b2bd2dd05a19ad7ec248489d374f2bd2b057 ]

Add consistency checks for CR4.CET and CR0.WP in guest-state or host-state
area in the VMCS12. This ensures that configurations with CR4.CET set and
CR0.WP not set result in VM-entry failure, aligning with architectural
behavior.

Tested-by: Mathias Krause <minipli@grsecurity.net>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Link: https://lore.kernel.org/r/20250919223258.1604852-33-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Stable-dep-of: e2ffe85b6d2b ("KVM: x86: Introduce KVM_X86_QUIRK_VMCS12_ALLOW_FREEZE_IN_SMM")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/vmx/nested.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 76f9624d49386..509f5c5e1f2b9 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3022,6 +3022,9 @@ static int nested_vmx_check_host_state(struct kvm_vcpu *vcpu,
 	    CC(!kvm_vcpu_is_legal_cr3(vcpu, vmcs12->host_cr3)))
 		return -EINVAL;
 
+	if (CC(vmcs12->host_cr4 & X86_CR4_CET && !(vmcs12->host_cr0 & X86_CR0_WP)))
+		return -EINVAL;
+
 	if (CC(is_noncanonical_msr_address(vmcs12->host_ia32_sysenter_esp, vcpu)) ||
 	    CC(is_noncanonical_msr_address(vmcs12->host_ia32_sysenter_eip, vcpu)))
 		return -EINVAL;
@@ -3136,6 +3139,9 @@ static int nested_vmx_check_guest_state(struct kvm_vcpu *vcpu,
 	    CC(!nested_guest_cr4_valid(vcpu, vmcs12->guest_cr4)))
 		return -EINVAL;
 
+	if (CC(vmcs12->guest_cr4 & X86_CR4_CET && !(vmcs12->guest_cr0 & X86_CR0_WP)))
+		return -EINVAL;
+
 	if ((vmcs12->vm_entry_controls & VM_ENTRY_LOAD_DEBUG_CONTROLS) &&
 	    (CC(!kvm_dr7_valid(vmcs12->guest_dr7)) ||
 	     CC(!vmx_is_valid_debugctl(vcpu, vmcs12->guest_ia32_debugctl, false))))
-- 
2.51.0


