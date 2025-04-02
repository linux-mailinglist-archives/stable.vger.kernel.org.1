Return-Path: <stable+bounces-127460-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C33A798BB
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 01:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6461718903DF
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 23:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93C51FAC55;
	Wed,  2 Apr 2025 23:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d76twxCE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F2A1FAC48;
	Wed,  2 Apr 2025 23:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743636083; cv=none; b=oSaoRVpxxWPnEuXNhyTfmI9ZlnYp+EvJtKS4D+2vXB7uCdFIkjMBwE5Ts7ow9+UNbCVNO5ojisJ1X4/qFRnzgy7k9Yg+HNYoz45iD3QSSvmV4mi0+ALDlY2ivOijhXaOQeLKXliUHEWte2AZppIsOAAzQVjkgCzQMWK1eT2N104=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743636083; c=relaxed/simple;
	bh=e9qvF2o7uVNtfQASnyy4CdQbnEmB3uPMMDe207tDMbc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BN+pDwTP93D5leRqMbnIUImCSxQwGLfo4U9DztbTDXvZeWnT8sPZ1O1fOx54lvF4eKpDCqW96SpSjDV/VLl/zY5n+CytND8YSNHTkeVGFcqsMtTzl5siG983I6lcLBvEVwuNbHXt7bwSCoL6x4CkYrignII1HbgpzHTQHB7bygA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d76twxCE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8192C4CEDD;
	Wed,  2 Apr 2025 23:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743636082;
	bh=e9qvF2o7uVNtfQASnyy4CdQbnEmB3uPMMDe207tDMbc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=d76twxCEnqhtukperv0HOO/yvbxwaRcOA33X0/ouHliMohTeCVWl7vc1J5hPVhSuu
	 uXj7n2eKAduWaEPJ+CzqhP/PG2FHg50auU6xUpc2TvI7PY6/+HsSieVowFpd+OXoVY
	 WhdIhZTFSs88gfm1S8FgfI5ElhsMxlyac6SiTMFTORvJlxTxddN12oVPVYqUogqvgH
	 sWP/KrMf1mnT9FwblrSizykABl1QD4qp4lW7eN7nvdT2e8ip5pianzhN36RTbEIRFb
	 55OhmovD6m3wMO06Bw2mcHz29Mgd/eY3DHZmU1ivyRGY5SaY2Wnun8KUfaZNTjLcJ8
	 wMMT7UQTLsbFA==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 03 Apr 2025 00:20:22 +0100
Subject: [PATCH 5.15 v2 07/10] KVM: arm64: Remove host FPSIMD saving for
 non-protected KVM
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-stable-sve-5-15-v2-7-30a36a78a20a@kernel.org>
References: <20250403-stable-sve-5-15-v2-0-30a36a78a20a@kernel.org>
In-Reply-To: <20250403-stable-sve-5-15-v2-0-30a36a78a20a@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Oleg Nesterov <oleg@redhat.com>, Oliver Upton <oliver.upton@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Fuad Tabba <tabba@google.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2943; i=broonie@kernel.org;
 h=from:subject:message-id; bh=IYSm9LOHiakFHli8QpJhz4RyCAaedNNXODj93c0ElHY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBn7cZRAiw8fTObijRUYHvuAUQ8JqfR9J23+Sw7pEnA
 6Y43d+aJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ+3GUQAKCRAk1otyXVSH0MB+B/
 wJ4puNvT47y3n3mvZUN9xNBPAL8/XtQpcTXrAHfZfMEEtdqCYHJdZUCkGRmt3PUU/Ic/KC5jQqN/5k
 SaxQrxRBAkBn4hvEA/3BoSjbqqA6Mur4G8H8mtQdXd60twTL8lUtWarXUdLrj3Jy+wRoGq8sORdCpF
 pvSusjb9EuuDbu3a4HtU8gtW1QFAhOR4jgeS+qivFoa/DPMbctIPu17WdjzJyOcrG3qW+2WyXdpdkv
 jDUDHDKTgqHA4+4121g1Rqo89zO3AUfhipoyG4+3WMZkL33/lbLs2PV0DBSJHOwynSPV/C3tAGXygw
 Yjvq0+mtwtmcWv+I6Rd7ndyFNfltdZ
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

From: Mark Rutland <mark.rutland@arm.com>

[ Upstream commit 8eca7f6d5100b6997df4f532090bc3f7e0203bef ]

Now that the host eagerly saves its own FPSIMD/SVE/SME state,
non-protected KVM never needs to save the host FPSIMD/SVE/SME state,
and the code to do this is never used. Protected KVM still needs to
save/restore the host FPSIMD/SVE state to avoid leaking guest state to
the host (and to avoid revealing to the host whether the guest used
FPSIMD/SVE/SME), and that code needs to be retained.

Remove the unused code and data structures.

To avoid the need for a stub copy of kvm_hyp_save_fpsimd_host() in the
VHE hyp code, the nVHE/hVHE version is moved into the shared switch
header, where it is only invoked when KVM is in protected mode.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Tested-by: Mark Brown <broonie@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Fuad Tabba <tabba@google.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
Link: https://lore.kernel.org/r/20250210195226.1215254-3-mark.rutland@arm.com
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h       | 1 -
 arch/arm64/kvm/fpsimd.c                 | 1 -
 arch/arm64/kvm/hyp/include/hyp/switch.h | 6 +-----
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index ecae31b0dab3..06e8d4645ecd 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -333,7 +333,6 @@ struct kvm_vcpu_arch {
 	struct kvm_guest_debug_arch external_debug_state;
 
 	struct thread_info *host_thread_info;	/* hyp VA */
-	struct user_fpsimd_state *host_fpsimd_state;	/* hyp VA */
 
 	struct {
 		/* {Break,watch}point registers */
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index 2afa2521bce1..1ef9d6cb91ee 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -55,7 +55,6 @@ int kvm_arch_vcpu_run_map_fp(struct kvm_vcpu *vcpu)
 	}
 
 	vcpu->arch.host_thread_info = kern_hyp_va(ti);
-	vcpu->arch.host_fpsimd_state = kern_hyp_va(fpsimd);
 error:
 	return ret;
 }
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index 269ec3587210..cc102e46b0e2 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -251,11 +251,7 @@ static inline bool __hyp_handle_fpsimd(struct kvm_vcpu *vcpu)
 	}
 	isb();
 
-	if (vcpu->arch.flags & KVM_ARM64_FP_HOST) {
-		__fpsimd_save_state(vcpu->arch.host_fpsimd_state);
-		vcpu->arch.flags &= ~KVM_ARM64_FP_HOST;
-	}
-
+	/* Restore the guest state */
 	if (sve_guest)
 		__hyp_sve_restore_guest(vcpu);
 	else

-- 
2.39.5


