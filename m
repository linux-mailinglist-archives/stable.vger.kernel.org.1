Return-Path: <stable+bounces-169479-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C2CB2588C
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 02:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09A341C05D3E
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 00:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1801154774;
	Thu, 14 Aug 2025 00:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5sBR8tR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAB92FF66A
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 00:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755132516; cv=none; b=cJ+6H8rFqAWZhBZxJUXiE2xYBiZcAJY1trKx+UOzL8vQWo7RcoSjXFk4oTkGNQnpEyHvIJuBLfUPpxoQSSWlCH29tktxpHnN81IuVtLWQV3SbSTRIS62eFVCJkNSItKxia1zT+CKT4Y2aOnQyyQwLQGuxHfj+niVLYlIwe39o44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755132516; c=relaxed/simple;
	bh=6LTFpcmcegHb7aZKuHl5kfIpXEKaaktlyWEhsF+mUEw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ly/ZaPADq6mxcxrZezXbhoT/nMk1Wbg+NHWgnJsodlsvXqDLUjdQXEC/RfZ/+2nI8qUXsmo6uBf4rIg40LxeaNe21YHKIkuW7YK2P3FfzPLNKxpNTi1UqNFtz7edLWHiiP/Z6abS0G8AFYpLuwnbyeZTrnLDmVUN3n6d2iui5Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5sBR8tR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B95CBC4CEF6;
	Thu, 14 Aug 2025 00:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755132516;
	bh=6LTFpcmcegHb7aZKuHl5kfIpXEKaaktlyWEhsF+mUEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g5sBR8tRgsVETG7bffAB7vvw/8l0hSKKboXedzGxzRgTu6PhCn3anuBeW6XzdMr5O
	 B8M1uHoB7y+rKyVRmR1m0tWHYObH04RmVM9s7RGkd3ECNUWr5iSTOTxAxI8viQm+eY
	 PEWBlrKkVhn2dw+Qng6HkD71mryVXAdNXhp1Ud/7r14nlUtQsP6g5OIJKlXN8ZNsA8
	 mGglkTuP3Q73usE/gXlg9dwbhtS8xPQKSgaEXxWLdH6B3XAmq2iBng0/hhjNzQh0OZ
	 PiQwSgCnPKTffl2xV/ynWA0JXD9X9mPGXqqGOCjhPJulc/RzZ7f1+ehlryfFpeWYF/
	 DP3UDkH/jxDkA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15.y 3/5] KVM: arm64: Handle out-of-bound write to MDCR_EL2.HPMN
Date: Wed, 13 Aug 2025 17:18:18 -0400
Message-Id: <20250813211820.2074887-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250813211820.2074887-1-sashal@kernel.org>
References: <2025081248-omission-talisman-0619@gregkh>
 <20250813211820.2074887-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marc Zyngier <maz@kernel.org>

[ Upstream commit efff9dd2fee7a5969b5b2a04995e638c3ba15826 ]

We don't really pay attention to what gets written to MDCR_EL2.HPMN,
and funky guests could play ugly games on us.

Restrict what gets written there, and limit the number of counters
to what the PMU is allowed to have.

Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Stable-dep-of: c6e35dff58d3 ("KVM: arm64: Check for SYSREGS_ON_CPU before accessing the CPU state")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kvm/sys_regs.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index c1e900a66d35..2ef68b66b950 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2576,16 +2576,33 @@ static bool access_mdcr(struct kvm_vcpu *vcpu,
 			struct sys_reg_params *p,
 			const struct sys_reg_desc *r)
 {
-	u64 old = __vcpu_sys_reg(vcpu, MDCR_EL2);
+	u64 hpmn, val, old = __vcpu_sys_reg(vcpu, MDCR_EL2);
 
-	if (!access_rw(vcpu, p, r))
-		return false;
+	if (!p->is_write) {
+		p->regval = old;
+		return true;
+	}
+
+	val = p->regval;
+	hpmn = FIELD_GET(MDCR_EL2_HPMN, val);
+
+	/*
+	 * If HPMN is out of bounds, limit it to what we actually
+	 * support. This matches the UNKNOWN definition of the field
+	 * in that case, and keeps the emulation simple. Sort of.
+	 */
+	if (hpmn > vcpu->kvm->arch.nr_pmu_counters) {
+		hpmn = vcpu->kvm->arch.nr_pmu_counters;
+		u64_replace_bits(val, hpmn, MDCR_EL2_HPMN);
+	}
+
+	__vcpu_sys_reg(vcpu, MDCR_EL2) = val;
 
 	/*
-	 * Request a reload of the PMU to enable/disable the counters affected
-	 * by HPME.
+	 * Request a reload of the PMU to enable/disable the counters
+	 * affected by HPME.
 	 */
-	if ((old ^ __vcpu_sys_reg(vcpu, MDCR_EL2)) & MDCR_EL2_HPME)
+	if ((old ^ val) & MDCR_EL2_HPME)
 		kvm_make_request(KVM_REQ_RELOAD_PMU, vcpu);
 
 	return true;
-- 
2.39.5


