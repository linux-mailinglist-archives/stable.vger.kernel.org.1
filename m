Return-Path: <stable+bounces-131833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 937BEA81495
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 20:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD48E4E2805
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 18:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B627253F30;
	Tue,  8 Apr 2025 18:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQDJhzAf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532B8253F25;
	Tue,  8 Apr 2025 18:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744136563; cv=none; b=P0CrOqf+PEcPhh2YEfTYnj/JJThPwHqB5MNvPK2ZHEkN3lkg+s9/IToa9iXXsmyuja6bZF7ORVbSGgt5cXGks6tPyQixTnl8SagS9OIXXiZPWjC0/ROGyRIh3MTwAbYyPFJniKsnYkmcRmFgXjD6C41BW2dpSRulmgWLUrFekJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744136563; c=relaxed/simple;
	bh=e9qvF2o7uVNtfQASnyy4CdQbnEmB3uPMMDe207tDMbc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PXuZ+6aBnvDZrb6i4BJfQtnwEmusMn9E3SNfl+iZ07HaP9WZVb9nTarFMbIQD6o/5wqKswKIAIQOP5mLJdTDs+9ykhltszjUPGwq9wPHkIjd+Oo7nd+/6oEip+un4VEChNA7h0y+qcZbVKM9xryxjvuuVcUJy8oA4ON0eKFSuDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQDJhzAf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E306C4CEE5;
	Tue,  8 Apr 2025 18:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744136562;
	bh=e9qvF2o7uVNtfQASnyy4CdQbnEmB3uPMMDe207tDMbc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FQDJhzAfb7nvmMDonzRGZJgcy6Hot1cEy7VNFNxuAqjrYmWQfOQ/YXgmeQFwCyXya
	 C2BIPGW6heAsTP2wRczA/JlbvT3d/oNXfevVyCytTS6AHm4u9DOIYBVZbJn+rZ8Y1b
	 /GOQtcRzpfA3nDGV00J+WNySrrBsIpXhXGWlrgudmvuiHKA+xGeBPPRohP+KYDmyHZ
	 UzxFehpSsMSwgkGUvmvz1xApLOPs8zpkHX3V6bLNoaTOH2nfc1p+gX/9mfTcBCSyX3
	 aqQcPwupK2Q1xqwrLpPb4ZXP4ZlTIiCxbGj6zO0fIl8Pevrpv3cT1Ei6IrGcJG5bf5
	 Y1aVEKElsJN/w==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 08 Apr 2025 19:10:03 +0100
Subject: [PATCH 5.15 v3 08/11] KVM: arm64: Remove host FPSIMD saving for
 non-protected KVM
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-stable-sve-5-15-v3-8-ca9a6b850f55@kernel.org>
References: <20250408-stable-sve-5-15-v3-0-ca9a6b850f55@kernel.org>
In-Reply-To: <20250408-stable-sve-5-15-v3-0-ca9a6b850f55@kernel.org>
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
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBn9WlR+WNqKkh3Yl7jjk3LaM97k5ATftDWIUcZmY0+
 QpFoGXqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ/VpUQAKCRAk1otyXVSH0Lm+B/
 9XV/VfIVsrLFZ3h9eV9VQQQ5JX1xethAlNJ5u1v2QLLnuurnmNtvzXNIImCzIoJkxm9DlWYyzZvujq
 F26k5SWKIP0aF0uFjop96gXh/LTheFP0+8D744GZNHd2EQK7g6p7MZogkl9Z9wq6tAzdfbnmgijDkQ
 R3ZiltSus/XaiY2GkIryApFcCMsaO0M/fFShD6NJDWDi4pUn1CNaiZX9aVqURPmretvym1yy8gFCNJ
 8TLiS/n3UvECm0dmUw+O2de6yk0+fUiSVNNbKQYKZ7LrSi+XfEBr8Mz5+qQBr0jmGLd68Q81yrPJ+f
 sSADzc8K5JZqllM3epXaqhQF2D4dsG
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


