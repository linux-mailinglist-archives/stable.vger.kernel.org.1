Return-Path: <stable+bounces-24187-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A821B86930C
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E8F5283D05
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1332613B2B9;
	Tue, 27 Feb 2024 13:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="onJUDYTJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BFE13B29B;
	Tue, 27 Feb 2024 13:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041277; cv=none; b=ayAVoYL+NGkdUh+crX3YN64bU7lGnqNJRvFPmy+wTNBvbD+4rmjYR13+R8BHaH7vcajdHvsmF7zxJfHqNJg0Q3xk6u33ZExVGabACmpgyaT/KxhHBBJEsjmX8Sb/obruZBRULkYLOROZwRaEE2r8YlRh68Wpx/SM4zKOTPuLOTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041277; c=relaxed/simple;
	bh=47dKxmmZtwwfzYG3FdeAFv/gCMtxNrDt+rjuE8usKbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=avyC25wrhzQomIr35XDXX9uFV4k7HvD5dugw9SD9hstcPU4L52VhRSCQmFJ/pPJc/DY5W3rLnNkCpfgFZ+PlcdQdLID1v1P8RlvBWcndYKkJYmi52iIQaOEKYXzJ8+0iIhzjqnYxt9K4RWnnm03OkoQcYOeHvoj8rM4UJFPsLsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=onJUDYTJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F47FC433C7;
	Tue, 27 Feb 2024 13:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709041277;
	bh=47dKxmmZtwwfzYG3FdeAFv/gCMtxNrDt+rjuE8usKbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=onJUDYTJzOXbPaztvBhnyGlthGn/xWGjb28wHlibpM3Jn4bqhRltxA+ReXqUL9DuE
	 GBpTOvbfm9us/iMgTC61pALCwZyd6hbJHJpxi5MAGIJYUspO9gHu2E4luqgB/uifX6
	 DYoQJmIt78kPnOQPWG56SqcslG8o+BpwWFvyeIBs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Aneesh Kumar K.V (IBM)" <aneesh.kumar@kernel.org>,
	Vaibhav Jain <vaibhav@linux.ibm.com>,
	Amit Machhiwal <amachhiw@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 283/334] KVM: PPC: Book3S HV: Fix L2 guest reboot failure due to empty arch_compat
Date: Tue, 27 Feb 2024 14:22:21 +0100
Message-ID: <20240227131640.120221883@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131630.636392135@linuxfoundation.org>
References: <20240227131630.636392135@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amit Machhiwal <amachhiw@linux.ibm.com>

[ Upstream commit 20c8c4dafe93e82441583e93bd68c0d256d7bed4 ]

Currently, rebooting a pseries nested qemu-kvm guest (L2) results in
below error as L1 qemu sends PVR value 'arch_compat' == 0 via
ppc_set_compat ioctl. This triggers a condition failure in
kvmppc_set_arch_compat() resulting in an EINVAL.

qemu-system-ppc64: Unable to set CPU compatibility mode in KVM: Invalid
argument

Also, a value of 0 for arch_compat generally refers the default
compatibility of the host. But, arch_compat, being a Guest Wide Element
in nested API v2, cannot be set to 0 in GSB as PowerVM (L0) expects a
non-zero value. A value of 0 triggers a kernel trap during a reboot and
consequently causes it to fail:

[   22.106360] reboot: Restarting system
KVM: unknown exit, hardware reason ffffffffffffffea
NIP 0000000000000100   LR 000000000000fe44 CTR 0000000000000000 XER 0000000020040092 CPU#0
MSR 0000000000001000 HID0 0000000000000000  HF 6c000000 iidx 3 didx 3
TB 00000000 00000000 DECR 0
GPR00 0000000000000000 0000000000000000 c000000002a8c300 000000007fe00000
GPR04 0000000000000000 0000000000000000 0000000000001002 8000000002803033
GPR08 000000000a000000 0000000000000000 0000000000000004 000000002fff0000
GPR12 0000000000000000 c000000002e10000 0000000105639200 0000000000000004
GPR16 0000000000000000 000000010563a090 0000000000000000 0000000000000000
GPR20 0000000105639e20 00000001056399c8 00007fffe54abab0 0000000105639288
GPR24 0000000000000000 0000000000000001 0000000000000001 0000000000000000
GPR28 0000000000000000 0000000000000000 c000000002b30840 0000000000000000
CR 00000000  [ -  -  -  -  -  -  -  -  ]     RES 000@ffffffffffffffff
 SRR0 0000000000000000  SRR1 0000000000000000    PVR 0000000000800200 VRSAVE 0000000000000000
SPRG0 0000000000000000 SPRG1 0000000000000000  SPRG2 0000000000000000  SPRG3 0000000000000000
SPRG4 0000000000000000 SPRG5 0000000000000000  SPRG6 0000000000000000  SPRG7 0000000000000000
HSRR0 0000000000000000 HSRR1 0000000000000000
 CFAR 0000000000000000
 LPCR 0000000000020400
 PTCR 0000000000000000   DAR 0000000000000000  DSISR 0000000000000000

 kernel:trap=0xffffffea | pc=0x100 | msr=0x1000

This patch updates kvmppc_set_arch_compat() to use the host PVR value if
'compat_pvr' == 0 indicating that qemu doesn't want to enforce any
specific PVR compat mode.

The relevant part of the code might need a rework if PowerVM implements
a support for `arch_compat == 0` in nestedv2 API.

Fixes: 19d31c5f1157 ("KVM: PPC: Add support for nestedv2 guests")
Reviewed-by: "Aneesh Kumar K.V (IBM)" <aneesh.kumar@kernel.org>
Reviewed-by: Vaibhav Jain <vaibhav@linux.ibm.com>
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20240207054526.3720087-1-amachhiw@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kvm/book3s_hv.c          | 26 ++++++++++++++++++++++++--
 arch/powerpc/kvm/book3s_hv_nestedv2.c | 20 ++++++++++++++++++--
 2 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 002a7573a5d44..b5c6af0bef81e 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -391,6 +391,24 @@ static void kvmppc_set_pvr_hv(struct kvm_vcpu *vcpu, u32 pvr)
 /* Dummy value used in computing PCR value below */
 #define PCR_ARCH_31    (PCR_ARCH_300 << 1)
 
+static inline unsigned long map_pcr_to_cap(unsigned long pcr)
+{
+	unsigned long cap = 0;
+
+	switch (pcr) {
+	case PCR_ARCH_300:
+		cap = H_GUEST_CAP_POWER9;
+		break;
+	case PCR_ARCH_31:
+		cap = H_GUEST_CAP_POWER10;
+		break;
+	default:
+		break;
+	}
+
+	return cap;
+}
+
 static int kvmppc_set_arch_compat(struct kvm_vcpu *vcpu, u32 arch_compat)
 {
 	unsigned long host_pcr_bit = 0, guest_pcr_bit = 0, cap = 0;
@@ -424,11 +442,9 @@ static int kvmppc_set_arch_compat(struct kvm_vcpu *vcpu, u32 arch_compat)
 			break;
 		case PVR_ARCH_300:
 			guest_pcr_bit = PCR_ARCH_300;
-			cap = H_GUEST_CAP_POWER9;
 			break;
 		case PVR_ARCH_31:
 			guest_pcr_bit = PCR_ARCH_31;
-			cap = H_GUEST_CAP_POWER10;
 			break;
 		default:
 			return -EINVAL;
@@ -440,6 +456,12 @@ static int kvmppc_set_arch_compat(struct kvm_vcpu *vcpu, u32 arch_compat)
 		return -EINVAL;
 
 	if (kvmhv_on_pseries() && kvmhv_is_nestedv2()) {
+		/*
+		 * 'arch_compat == 0' would mean the guest should default to
+		 * L1's compatibility. In this case, the guest would pick
+		 * host's PCR and evaluate the corresponding capabilities.
+		 */
+		cap = map_pcr_to_cap(guest_pcr_bit);
 		if (!(cap & nested_capabilities))
 			return -EINVAL;
 	}
diff --git a/arch/powerpc/kvm/book3s_hv_nestedv2.c b/arch/powerpc/kvm/book3s_hv_nestedv2.c
index fd3c4f2d94805..f354af7e85114 100644
--- a/arch/powerpc/kvm/book3s_hv_nestedv2.c
+++ b/arch/powerpc/kvm/book3s_hv_nestedv2.c
@@ -138,6 +138,7 @@ static int gs_msg_ops_vcpu_fill_info(struct kvmppc_gs_buff *gsb,
 	vector128 v;
 	int rc, i;
 	u16 iden;
+	u32 arch_compat = 0;
 
 	vcpu = gsm->data;
 
@@ -347,8 +348,23 @@ static int gs_msg_ops_vcpu_fill_info(struct kvmppc_gs_buff *gsb,
 			break;
 		}
 		case KVMPPC_GSID_LOGICAL_PVR:
-			rc = kvmppc_gse_put_u32(gsb, iden,
-						vcpu->arch.vcore->arch_compat);
+			/*
+			 * Though 'arch_compat == 0' would mean the default
+			 * compatibility, arch_compat, being a Guest Wide
+			 * Element, cannot be filled with a value of 0 in GSB
+			 * as this would result into a kernel trap.
+			 * Hence, when `arch_compat == 0`, arch_compat should
+			 * default to L1's PVR.
+			 */
+			if (!vcpu->arch.vcore->arch_compat) {
+				if (cpu_has_feature(CPU_FTR_ARCH_31))
+					arch_compat = PVR_ARCH_31;
+				else if (cpu_has_feature(CPU_FTR_ARCH_300))
+					arch_compat = PVR_ARCH_300;
+			} else {
+				arch_compat = vcpu->arch.vcore->arch_compat;
+			}
+			rc = kvmppc_gse_put_u32(gsb, iden, arch_compat);
 			break;
 		}
 
-- 
2.43.0




