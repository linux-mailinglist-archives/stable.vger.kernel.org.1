Return-Path: <stable+bounces-229510-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOKKJWtjwWkDSwQAu9opvQ
	(envelope-from <stable+bounces-229510-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:59:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 385162F73BA
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6563935B2832
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B818A3BFE47;
	Mon, 23 Mar 2026 15:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fiRuZspi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7013BFE3A;
	Mon, 23 Mar 2026 15:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279463; cv=none; b=gEgyUCDk7YPBJF+Pdgu+JAAMYlhmOPtgyJW36lDdgKAh2wk0Hkei/KiMX7gJH/UTRKSsrQXdNfX9Yo0flNh8ne49uYI9cg14sxb6U4oLHMVzFpUzVt1LizufI5LuyYphCqF5Zp6a9IxhQ8Q5Q1y2sn92Xz3N4eKCMQkRyoo6Q2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279463; c=relaxed/simple;
	bh=yWiyBmh18NHD3f6ZJGgzVoVKhpRlJoqAy6GM8V0wWoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJNYJXAxuzYBwRh6rJKasjb2sx519QrWR/Gv/GsooTq77EOGpf7+A/3Tu4DD7+aJZUFbs7+hN1CZ4g/cKCmh2xrfsBjE9n7po34RPf4/ZWT47P7IXcq7XST8hb6UYJCqduspbpNIsEhQhOBzNhE18tIBnGadksALaBuTukj5agM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fiRuZspi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0401FC4CEF7;
	Mon, 23 Mar 2026 15:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774279463;
	bh=yWiyBmh18NHD3f6ZJGgzVoVKhpRlJoqAy6GM8V0wWoE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fiRuZspiqx0HMf/TBeFGSQd8GyjgBq+QKmz62uptvYawHvUipMHA+7OuwZ2XaN0/5
	 TmKEZMGOQAC55Y3h6pk+9/GUXououvhu88wVuLnbhvzWrXJ431bGR9nUiUhfVokthh
	 c5Vofnq3D8qRciC/lXYJf42mC8WYuiWfgp9va6kQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 026/481] KVM: x86/pmu: Provide "error" semantics for unsupported-but-known PMU MSRs
Date: Mon, 23 Mar 2026 14:40:08 +0100
Message-ID: <20260323134525.879310874@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-229510-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 385162F73BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 2de154f541fc5b9f2aed3fe06e218130718ce320 ]

Provide "error" semantics (read zeros, drop writes) for userspace accesses
to MSRs that are ultimately unsupported for whatever reason, but for which
KVM told userspace to save and restore the MSR, i.e. for MSRs that KVM
included in KVM_GET_MSR_INDEX_LIST.

Previously, KVM special cased a few PMU MSRs that were problematic at one
point or another.  Extend the treatment to all PMU MSRs, e.g. to avoid
spurious unsupported accesses.

Note, the logic can also be used for non-PMU MSRs, but as of today only
PMU MSRs can end up being unsupported after KVM told userspace to save and
restore them.

Link: https://lore.kernel.org/r/20230124234905.3774678-7-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Stable-dep-of: 5bb9ac186512 ("KVM: x86: Return "unsupported" instead of "invalid" on access to unsupported PV MSR")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/x86.c | 51 ++++++++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2253c51e33e36..0b8ec5886d44f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3576,6 +3576,18 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
 	mark_page_dirty_in_slot(vcpu->kvm, ghc->memslot, gpa_to_gfn(ghc->gpa));
 }
 
+static bool kvm_is_msr_to_save(u32 msr_index)
+{
+	unsigned int i;
+
+	for (i = 0; i < num_msrs_to_save; i++) {
+		if (msrs_to_save[i] == msr_index)
+			return true;
+	}
+
+	return false;
+}
+
 int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
 	u32 msr = msr_info->index;
@@ -3896,20 +3908,18 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		vcpu->arch.guest_fpu.xfd_err = data;
 		break;
 #endif
-	case MSR_IA32_PEBS_ENABLE:
-	case MSR_IA32_DS_AREA:
-	case MSR_PEBS_DATA_CFG:
-	case MSR_F15H_PERF_CTL0 ... MSR_F15H_PERF_CTR5:
+	default:
 		if (kvm_pmu_is_valid_msr(vcpu, msr))
 			return kvm_pmu_set_msr(vcpu, msr_info);
+
 		/*
 		 * Userspace is allowed to write '0' to MSRs that KVM reports
 		 * as to-be-saved, even if an MSRs isn't fully supported.
 		 */
-		return !msr_info->host_initiated || data;
-	default:
-		if (kvm_pmu_is_valid_msr(vcpu, msr))
-			return kvm_pmu_set_msr(vcpu, msr_info);
+		if (msr_info->host_initiated && !data &&
+		    kvm_is_msr_to_save(msr))
+			break;
+
 		return KVM_MSR_RET_INVALID;
 	}
 	return 0;
@@ -4000,20 +4010,6 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_DRAM_ENERGY_STATUS:	/* DRAM controller */
 		msr_info->data = 0;
 		break;
-	case MSR_IA32_PEBS_ENABLE:
-	case MSR_IA32_DS_AREA:
-	case MSR_PEBS_DATA_CFG:
-	case MSR_F15H_PERF_CTL0 ... MSR_F15H_PERF_CTR5:
-		if (kvm_pmu_is_valid_msr(vcpu, msr_info->index))
-			return kvm_pmu_get_msr(vcpu, msr_info);
-		/*
-		 * Userspace is allowed to read MSRs that KVM reports as
-		 * to-be-saved, even if an MSR isn't fully supported.
-		 */
-		if (!msr_info->host_initiated)
-			return 1;
-		msr_info->data = 0;
-		break;
 	case MSR_K7_EVNTSEL0 ... MSR_K7_EVNTSEL3:
 	case MSR_K7_PERFCTR0 ... MSR_K7_PERFCTR3:
 	case MSR_P6_PERFCTR0 ... MSR_P6_PERFCTR1:
@@ -4268,6 +4264,17 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	default:
 		if (kvm_pmu_is_valid_msr(vcpu, msr_info->index))
 			return kvm_pmu_get_msr(vcpu, msr_info);
+
+		/*
+		 * Userspace is allowed to read MSRs that KVM reports as
+		 * to-be-saved, even if an MSR isn't fully supported.
+		 */
+		if (msr_info->host_initiated &&
+		    kvm_is_msr_to_save(msr_info->index)) {
+			msr_info->data = 0;
+			break;
+		}
+
 		return KVM_MSR_RET_INVALID;
 	}
 	return 0;
-- 
2.51.0




