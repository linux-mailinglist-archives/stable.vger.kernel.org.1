Return-Path: <stable+bounces-228947-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2G1JFu5qwWnVSwQAu9opvQ
	(envelope-from <stable+bounces-228947-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:31:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCBC2F83F8
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FEF3316F187
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BAA3AC0C2;
	Mon, 23 Mar 2026 14:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iPtFghfb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254B023B62C;
	Mon, 23 Mar 2026 14:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277574; cv=none; b=aqeOLMhk6n+Sy1YCZtmUmmW7p9XwHN5x+KHO1+JZucVZmOFHxsmX1Ivv9gca1GprImdpmRxxUdiUvqE1K98GE+YvPFdEYl/ZhS+W1F8Iaoqbs/nQTroWZHAg6LKkNG4L9ORD/C4yP2DxmP7L4USbLIeuEkTX9MKUst5NIvwUOIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277574; c=relaxed/simple;
	bh=xG+M9370iMoJaPchwIp5fr/K3gYiML3+Akzd14ecvqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UctmRRDBW8DTdU5zuiyzTuMxFw4S9hH6zhVoozkKqPlU22TAZN+1ytL2cnt5O9pKcLWNcqZ7TFGaI0vDZTp7ZQMnY6xKNqzQUbGHNKlwFByZycBNy5IsPBXGR7eSvUXsmRlgdZtXOrEItioRMb8sKP6s5eNHXbt9YVQT+S6NyBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iPtFghfb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61389C2BC9E;
	Mon, 23 Mar 2026 14:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774277573;
	bh=xG+M9370iMoJaPchwIp5fr/K3gYiML3+Akzd14ecvqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iPtFghfbkYvXWVGxUg6S0mSnWswCXlMSmDKiQnWWjtwP/Rx3awsche9mfaPV7FuiZ
	 +OZwnl1hT1gZEKnN6FBhuh1j1l8TrND1L+UoMkn6Yo1LJaZnK8LPUY4mtOGLDobmxa
	 +JoXKvb7vBUGLahG2V9fWbRRteuyc5+w54VfKk/U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jim Mattson <jmattson@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 036/567] KVM: x86: Return "unsupported" instead of "invalid" on access to unsupported PV MSR
Date: Mon, 23 Mar 2026 14:39:16 +0100
Message-ID: <20260323134534.686027412@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-228947-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: ADCBC2F83F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 5bb9ac1865123356337a389af935d3913ee917ed ]

Return KVM_MSR_RET_UNSUPPORTED instead of '1' (which for all intents and
purposes means "invalid") when rejecting accesses to KVM PV MSRs to adhere
to KVM's ABI of allowing host reads and writes of '0' to MSRs that are
advertised to userspace via KVM_GET_MSR_INDEX_LIST, even if the vCPU model
doesn't support the MSR.

E.g. running a QEMU VM with

  -cpu host,-kvmclock,kvm-pv-enforce-cpuid

yields:

  qemu: error: failed to set MSR 0x12 to 0x0
  qemu: target/i386/kvm/kvm.c:3301: kvm_buf_set_msrs:
        Assertion `ret == cpu->kvm_msr_buf->nmsrs' failed.

Fixes: 66570e966dd9 ("kvm: x86: only provide PV features if enabled in guest's CPUID")
Cc: stable@vger.kernel.org
Reviewed-by: Jim Mattson <jmattson@google.com>
Link: https://patch.msgid.link/20251230205948.4094097-1-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/x86.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 3e16513a4d9fd..19cae03e423b1 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3812,47 +3812,47 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		break;
 	case MSR_KVM_WALL_CLOCK_NEW:
 		if (!guest_pv_has(vcpu, KVM_FEATURE_CLOCKSOURCE2))
-			return 1;
+			return KVM_MSR_RET_UNSUPPORTED;
 
 		vcpu->kvm->arch.wall_clock = data;
 		kvm_write_wall_clock(vcpu->kvm, data, 0);
 		break;
 	case MSR_KVM_WALL_CLOCK:
 		if (!guest_pv_has(vcpu, KVM_FEATURE_CLOCKSOURCE))
-			return 1;
+			return KVM_MSR_RET_UNSUPPORTED;
 
 		vcpu->kvm->arch.wall_clock = data;
 		kvm_write_wall_clock(vcpu->kvm, data, 0);
 		break;
 	case MSR_KVM_SYSTEM_TIME_NEW:
 		if (!guest_pv_has(vcpu, KVM_FEATURE_CLOCKSOURCE2))
-			return 1;
+			return KVM_MSR_RET_UNSUPPORTED;
 
 		kvm_write_system_time(vcpu, data, false, msr_info->host_initiated);
 		break;
 	case MSR_KVM_SYSTEM_TIME:
 		if (!guest_pv_has(vcpu, KVM_FEATURE_CLOCKSOURCE))
-			return 1;
+			return KVM_MSR_RET_UNSUPPORTED;
 
 		kvm_write_system_time(vcpu, data, true,  msr_info->host_initiated);
 		break;
 	case MSR_KVM_ASYNC_PF_EN:
 		if (!guest_pv_has(vcpu, KVM_FEATURE_ASYNC_PF))
-			return 1;
+			return KVM_MSR_RET_UNSUPPORTED;
 
 		if (kvm_pv_enable_async_pf(vcpu, data))
 			return 1;
 		break;
 	case MSR_KVM_ASYNC_PF_INT:
 		if (!guest_pv_has(vcpu, KVM_FEATURE_ASYNC_PF_INT))
-			return 1;
+			return KVM_MSR_RET_UNSUPPORTED;
 
 		if (kvm_pv_enable_async_pf_int(vcpu, data))
 			return 1;
 		break;
 	case MSR_KVM_ASYNC_PF_ACK:
 		if (!guest_pv_has(vcpu, KVM_FEATURE_ASYNC_PF_INT))
-			return 1;
+			return KVM_MSR_RET_UNSUPPORTED;
 		if (data & 0x1) {
 			vcpu->arch.apf.pageready_pending = false;
 			kvm_check_async_pf_completion(vcpu);
@@ -3860,7 +3860,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		break;
 	case MSR_KVM_STEAL_TIME:
 		if (!guest_pv_has(vcpu, KVM_FEATURE_STEAL_TIME))
-			return 1;
+			return KVM_MSR_RET_UNSUPPORTED;
 
 		if (unlikely(!sched_info_on()))
 			return 1;
@@ -3878,7 +3878,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		break;
 	case MSR_KVM_PV_EOI_EN:
 		if (!guest_pv_has(vcpu, KVM_FEATURE_PV_EOI))
-			return 1;
+			return KVM_MSR_RET_UNSUPPORTED;
 
 		if (kvm_lapic_set_pv_eoi(vcpu, data, sizeof(u8)))
 			return 1;
@@ -3886,7 +3886,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 
 	case MSR_KVM_POLL_CONTROL:
 		if (!guest_pv_has(vcpu, KVM_FEATURE_POLL_CONTROL))
-			return 1;
+			return KVM_MSR_RET_UNSUPPORTED;
 
 		/* only enable bit supported */
 		if (data & (-1ULL << 1))
@@ -4193,61 +4193,61 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		break;
 	case MSR_KVM_WALL_CLOCK:
 		if (!guest_pv_has(vcpu, KVM_FEATURE_CLOCKSOURCE))
-			return 1;
+			return KVM_MSR_RET_UNSUPPORTED;
 
 		msr_info->data = vcpu->kvm->arch.wall_clock;
 		break;
 	case MSR_KVM_WALL_CLOCK_NEW:
 		if (!guest_pv_has(vcpu, KVM_FEATURE_CLOCKSOURCE2))
-			return 1;
+			return KVM_MSR_RET_UNSUPPORTED;
 
 		msr_info->data = vcpu->kvm->arch.wall_clock;
 		break;
 	case MSR_KVM_SYSTEM_TIME:
 		if (!guest_pv_has(vcpu, KVM_FEATURE_CLOCKSOURCE))
-			return 1;
+			return KVM_MSR_RET_UNSUPPORTED;
 
 		msr_info->data = vcpu->arch.time;
 		break;
 	case MSR_KVM_SYSTEM_TIME_NEW:
 		if (!guest_pv_has(vcpu, KVM_FEATURE_CLOCKSOURCE2))
-			return 1;
+			return KVM_MSR_RET_UNSUPPORTED;
 
 		msr_info->data = vcpu->arch.time;
 		break;
 	case MSR_KVM_ASYNC_PF_EN:
 		if (!guest_pv_has(vcpu, KVM_FEATURE_ASYNC_PF))
-			return 1;
+			return KVM_MSR_RET_UNSUPPORTED;
 
 		msr_info->data = vcpu->arch.apf.msr_en_val;
 		break;
 	case MSR_KVM_ASYNC_PF_INT:
 		if (!guest_pv_has(vcpu, KVM_FEATURE_ASYNC_PF_INT))
-			return 1;
+			return KVM_MSR_RET_UNSUPPORTED;
 
 		msr_info->data = vcpu->arch.apf.msr_int_val;
 		break;
 	case MSR_KVM_ASYNC_PF_ACK:
 		if (!guest_pv_has(vcpu, KVM_FEATURE_ASYNC_PF_INT))
-			return 1;
+			return KVM_MSR_RET_UNSUPPORTED;
 
 		msr_info->data = 0;
 		break;
 	case MSR_KVM_STEAL_TIME:
 		if (!guest_pv_has(vcpu, KVM_FEATURE_STEAL_TIME))
-			return 1;
+			return KVM_MSR_RET_UNSUPPORTED;
 
 		msr_info->data = vcpu->arch.st.msr_val;
 		break;
 	case MSR_KVM_PV_EOI_EN:
 		if (!guest_pv_has(vcpu, KVM_FEATURE_PV_EOI))
-			return 1;
+			return KVM_MSR_RET_UNSUPPORTED;
 
 		msr_info->data = vcpu->arch.pv_eoi.msr_val;
 		break;
 	case MSR_KVM_POLL_CONTROL:
 		if (!guest_pv_has(vcpu, KVM_FEATURE_POLL_CONTROL))
-			return 1;
+			return KVM_MSR_RET_UNSUPPORTED;
 
 		msr_info->data = vcpu->arch.msr_kvm_poll_control;
 		break;
-- 
2.51.0




