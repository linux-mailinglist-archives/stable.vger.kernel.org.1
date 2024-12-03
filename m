Return-Path: <stable+bounces-97724-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D082F9E25BC
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 17:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E279168714
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35A71F76BF;
	Tue,  3 Dec 2024 15:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dFDIpsdN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919F71F755B;
	Tue,  3 Dec 2024 15:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733241515; cv=none; b=UCnRLoVHlGNvry25sLrKHbYmIEanBJVzTgED6PeRmXtG3K94mzlcwxODIJe2NbMFPZu+L3Bqr6WTP8cjpcYsjMVytgR+8IkA7wd/9tQaqZ3gGYs2AxtqR1l8Axp8MuqkQvS+CQOtvVSt0n2Xt0yzNnKbGqxjB2RpmD/sxhwxw+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733241515; c=relaxed/simple;
	bh=bYOqqwErK0ycJKmrSt2rPIcMHg/b1SslS2WVMNl3P/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cqep7h1essviFU/HyZBDIVoiZ0W2t10FhGKNLD6xlwi/V+vNk6+VUJuDOoD9XQ14FZqUSELDOJO7iikpReTqu73kzO1i5cqqIotccnme0zsbLwmQTyj+qPBIUneu6qitKNBSqXFVdQRNysv6v3Dk/Q3zDNPTrc4S47jiM88dYMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dFDIpsdN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4EECC4CED8;
	Tue,  3 Dec 2024 15:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733241515;
	bh=bYOqqwErK0ycJKmrSt2rPIcMHg/b1SslS2WVMNl3P/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dFDIpsdNdbjQOG9aSlufQZ23IdQsPTb7JT0pFPJ4zlWH2rUpsUnQio1hlyQYf5wTy
	 +ULaZUlWhFeFhZbSaASNk39eS15o1YrgLhB9ukgK6BtVXyBBZT5N8Mj9K/sAo/lBHI
	 I+tt87ZGeLZKjygyRClvndj9Mo9O30j/FY2NTBg8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gautam Menghani <gautam@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 439/826] KVM: PPC: Book3S HV: Stop using vc->dpdes for nested KVM guests
Date: Tue,  3 Dec 2024 15:42:46 +0100
Message-ID: <20241203144800.886582351@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203144743.428732212@linuxfoundation.org>
References: <20241203144743.428732212@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gautam Menghani <gautam@linux.ibm.com>

[ Upstream commit 0d3c6b28896f9889c8864dab469e0343a0ad1c0c ]

commit 6398326b9ba1 ("KVM: PPC: Book3S HV P9: Stop using vc->dpdes")
introduced an optimization to use only vcpu->doorbell_request for SMT
emulation for Power9 and above guests, but the code for nested guests
still relies on the old way of handling doorbells, due to which an L2
guest (see [1]) cannot be booted with XICS with SMT>1. The command to
repro this issue is:

// To be run in L1

qemu-system-ppc64 \
	-drive file=rhel.qcow2,format=qcow2 \
	-m 20G \
	-smp 8,cores=1,threads=8 \
	-cpu  host \
	-nographic \
	-machine pseries,ic-mode=xics -accel kvm

Fix the plumbing to utilize vcpu->doorbell_request instead of vcore->dpdes
for nested KVM guests on P9 and above.

[1] Terminology
1. L0 : PowerNV linux running with HV privileges
2. L1 : Pseries KVM guest running on top of L0
2. L2 : Nested KVM guest running on top of L1

Fixes: 6398326b9ba1 ("KVM: PPC: Book3S HV P9: Stop using vc->dpdes")
Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://patch.msgid.link/20241109063301.105289-3-gautam@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kvm/book3s_hv.c        |  9 +++++++++
 arch/powerpc/kvm/book3s_hv_nested.c | 14 ++++++++++----
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index ad8dc4ccdaab9..b4c5295bdc31b 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -4309,6 +4309,15 @@ static int kvmhv_vcpu_entry_p9_nested(struct kvm_vcpu *vcpu, u64 time_limit, uns
 	}
 	hvregs.hdec_expiry = time_limit;
 
+	/*
+	 * hvregs has the doorbell status, so zero it here which
+	 * enables us to receive doorbells when H_ENTER_NESTED is
+	 * in progress for this vCPU
+	 */
+
+	if (vcpu->arch.doorbell_request)
+		vcpu->arch.doorbell_request = 0;
+
 	/*
 	 * When setting DEC, we must always deal with irq_work_raise
 	 * via NMI vs setting DEC. The problem occurs right as we
diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3s_hv_nested.c
index 05f5220960c63..125440a606ee3 100644
--- a/arch/powerpc/kvm/book3s_hv_nested.c
+++ b/arch/powerpc/kvm/book3s_hv_nested.c
@@ -32,7 +32,7 @@ void kvmhv_save_hv_regs(struct kvm_vcpu *vcpu, struct hv_guest_state *hr)
 	struct kvmppc_vcore *vc = vcpu->arch.vcore;
 
 	hr->pcr = vc->pcr | PCR_MASK;
-	hr->dpdes = vc->dpdes;
+	hr->dpdes = vcpu->arch.doorbell_request;
 	hr->hfscr = vcpu->arch.hfscr;
 	hr->tb_offset = vc->tb_offset;
 	hr->dawr0 = vcpu->arch.dawr0;
@@ -105,7 +105,7 @@ static void save_hv_return_state(struct kvm_vcpu *vcpu,
 {
 	struct kvmppc_vcore *vc = vcpu->arch.vcore;
 
-	hr->dpdes = vc->dpdes;
+	hr->dpdes = vcpu->arch.doorbell_request;
 	hr->purr = vcpu->arch.purr;
 	hr->spurr = vcpu->arch.spurr;
 	hr->ic = vcpu->arch.ic;
@@ -143,7 +143,7 @@ static void restore_hv_regs(struct kvm_vcpu *vcpu, const struct hv_guest_state *
 	struct kvmppc_vcore *vc = vcpu->arch.vcore;
 
 	vc->pcr = hr->pcr | PCR_MASK;
-	vc->dpdes = hr->dpdes;
+	vcpu->arch.doorbell_request = hr->dpdes;
 	vcpu->arch.hfscr = hr->hfscr;
 	vcpu->arch.dawr0 = hr->dawr0;
 	vcpu->arch.dawrx0 = hr->dawrx0;
@@ -170,7 +170,13 @@ void kvmhv_restore_hv_return_state(struct kvm_vcpu *vcpu,
 {
 	struct kvmppc_vcore *vc = vcpu->arch.vcore;
 
-	vc->dpdes = hr->dpdes;
+	/*
+	 * This L2 vCPU might have received a doorbell while H_ENTER_NESTED was being handled.
+	 * Make sure we preserve the doorbell if it was either:
+	 *   a) Sent after H_ENTER_NESTED was called on this vCPU (arch.doorbell_request would be 1)
+	 *   b) Doorbell was not handled and L2 exited for some other reason (hr->dpdes would be 1)
+	 */
+	vcpu->arch.doorbell_request = vcpu->arch.doorbell_request | hr->dpdes;
 	vcpu->arch.hfscr = hr->hfscr;
 	vcpu->arch.purr = hr->purr;
 	vcpu->arch.spurr = hr->spurr;
-- 
2.43.0




