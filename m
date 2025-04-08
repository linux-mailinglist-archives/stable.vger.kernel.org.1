Return-Path: <stable+bounces-131827-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 036F7A81489
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 20:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50BA71BA6547
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 18:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEED245020;
	Tue,  8 Apr 2025 18:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2Ppd5i4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AABA245016;
	Tue,  8 Apr 2025 18:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744136543; cv=none; b=QejRviZ32+h4IJly2LtoYLIhWI7ZeuG3jX+rqZst2vK+viIIVdW93ud3oBNT9iq6GmYbSLmwzXvnJuRKVx4/IkaWCz9Ii2qnCoeiFVPMS6BDECan9Zm2MoA25lKUsn5CCrBg3FuPdhT64f3wAMPJdGm9yf0jYw9kiX4OJiSqK4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744136543; c=relaxed/simple;
	bh=DHaryj/zCLrbSQFZpiYi3QKZgzGIpgsLSnX9179Q5K8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i3zUPPcu1O9q6JJAk1L4NZSq92JLsMQoI/xprbMMkHNcg52bQ+Iw/OxiQvP3KnunXikrYYV4Cir09IzfFACftrQXLpPLMkHX5lFvs8WhI88T2Nsw9tTju463w2fVkTHJjxytA9duyCWNGxqdQrz1HqMEnmtbBbAikX6UjsSw0Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2Ppd5i4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B3DCC4CEE5;
	Tue,  8 Apr 2025 18:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744136543;
	bh=DHaryj/zCLrbSQFZpiYi3QKZgzGIpgsLSnX9179Q5K8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=D2Ppd5i4W+A1WmJFUyd6uuPQjtTKicLwsVf6YDcZAmC0qV9YADvJS0dMIvEEMk0y3
	 ee/K+LWSRm9iZefWkk8E41WYxUGP35gfjJG1sB0WLEmwLv1USasIyy1AsfKoTyI/VD
	 ebC0DVs5R9OrDKB/1o6pzg9lOrtYN8iIO+vBtqcPNYj3rZpKx2aYY6igrF5burginR
	 4etQQDuyBSAKGMo1vlLGfp+lhi0t+AwySNsnxpcXsVvJMXzBDtBEfEOTPzxPB70GJ3
	 llpDSQZTS5h8eVaV8DW3tTr9dr1O/f1o5+46sZaj7fx6fLYma0G6lBCgNKcm++Lvd9
	 ttRNNwZzvTtSQ==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 08 Apr 2025 19:09:57 +0100
Subject: [PATCH 5.15 v3 02/11] KVM: arm64: Always start with clearing SVE
 flag on load
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-stable-sve-5-15-v3-2-ca9a6b850f55@kernel.org>
References: <20250408-stable-sve-5-15-v3-0-ca9a6b850f55@kernel.org>
In-Reply-To: <20250408-stable-sve-5-15-v3-0-ca9a6b850f55@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Oleg Nesterov <oleg@redhat.com>, Oliver Upton <oliver.upton@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1451; i=broonie@kernel.org;
 h=from:subject:message-id; bh=06yjEiaT5GfiKOx7oXipPxuoURJltRxjW1MKje5sij8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBn9WlNXXxeqvd2CLOCotpZJXbf0hekyj7Jzjju625g
 ZKOXEd+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ/VpTQAKCRAk1otyXVSH0GqCB/
 9TF13fM9RkX5iTdLahTVsnI3XOcb3c0bGqgpF8O+KkzOMaAI66sl6Nz6qF74i4If+djyJKwLGCWQ1y
 +euvFe60hGhhzlnbmJ7SMhI7M+hi1hjadiWuTCRq7uHK3zof4ibjJl3Iq6I/Ip8N9Njc5J+m9iHN89
 90cQRwvyugmwyTcWgd4vNSixakvZM8Egmedt6+rlf6IwRw2EGvbCro8sfT618cHmw4N1jcU00TQ3b3
 z9HM4hsi9a6l8HQ5w6Pulh5oOBpFarhX7r+TcG50k24Fc3sFEtn2CrPM9dVxEUmsi4lZlKnF8Gj/NH
 Hwwvql2qocwQt9XzF+6B55eXicY3ay
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

From: Marc Zyngier <maz@kernel.org>

[ Upstream commit d52d165d67c5aa26c8c89909003c94a66492d23d ]

On each vcpu load, we set the KVM_ARM64_HOST_SVE_ENABLED
flag if SVE is enabled for EL0 on the host. This is used to restore
the correct state on vpcu put.

However, it appears that nothing ever clears this flag. Once
set, it will stick until the vcpu is destroyed, which has the
potential to spuriously enable SVE for userspace.

We probably never saw the issue because no VMM uses SVE, but
that's still pretty bad. Unconditionally clearing the flag
on vcpu load addresses the issue.

Fixes: 8383741ab2e7 ("KVM: arm64: Get rid of host SVE tracking/saving")
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
Reviewed-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20220528113829.1043361-2-maz@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kvm/fpsimd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index 2d15e1d6e214..24734bfcfaa0 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -75,6 +75,7 @@ void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu)
 	vcpu->arch.flags &= ~KVM_ARM64_FP_ENABLED;
 	vcpu->arch.flags |= KVM_ARM64_FP_HOST;
 
+	vcpu->arch.flags &= ~KVM_ARM64_HOST_SVE_ENABLED;
 	if (read_sysreg(cpacr_el1) & CPACR_EL1_ZEN_EL0EN)
 		vcpu->arch.flags |= KVM_ARM64_HOST_SVE_ENABLED;
 }

-- 
2.39.5


