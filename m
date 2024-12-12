Return-Path: <stable+bounces-103902-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D0E9EFA2F
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 19:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A23071885A4C
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B6D209F58;
	Thu, 12 Dec 2024 17:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tn7jiomM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AE61C5F07
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 17:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026251; cv=none; b=sOpgxqfixEionjoCWyBMMVbRCwzhmQlH847K4vYtkfA8QJ42gqYCOqp9tJ2EOiDBN9VwkUdrObYbZGxwz1sPCzaMcngTK4rIICvCaPgubrkBQaXPJqBmpLVjwjzuecSwVGQgBogsSCb7gssNSpJjG3iLx05wvUy2zn8uxd2VT5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026251; c=relaxed/simple;
	bh=lr8wrFON4bk0S1ue/3cQSqeRo0p1YLtOF8BkEe4gWkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HdM7NWrKFSL07h8qY3nxG5oO5XPyqAWbP26CnGseRxxfoHp63N8NS6z+/cP6ipixHCNYAtciim/hZlY0NOpWH86rylIAwilFXPlpBb92va3V5oJ2Dywo+o4Ze4QQvGx4WBjxlNt6K2vliUhQNrLDfX3DJI1RXkLQyC14ljheJKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tn7jiomM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B19DC4CECE;
	Thu, 12 Dec 2024 17:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734026250;
	bh=lr8wrFON4bk0S1ue/3cQSqeRo0p1YLtOF8BkEe4gWkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tn7jiomMqAAZGUspen0pTmsNvL+UKtGigIR8/p7vXX7xxTy41cJWfykLNfrd8umZh
	 S40aiZuzcZ5zJPYLpaLhH3PlF781+sgirqK7oEbRgMS6Gu+ucUS8vXDscoqZzG54kK
	 tfBNNIHtXaklbiXxPFkwHFQJs2iT5i6ye+QoYziUR1yK8dDiVsKqZdP7+n3mHbgZ0M
	 wrciPnxZdYjUoTFM+l/buH1ak7maDtGUORj5IwUIZg7ZwyPvK2OfW5qaqOnTVrx5cU
	 8nGHAxC1DMPlkQ4dNW+RrS6r/KXwpKhLogRLK8FdUWDvmYd3QCMpQlp3qRIhvJ+TSY
	 S1SZJt8KZpNlA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joey Gouly <joey.gouly@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 v1] KVM: arm64: Disable MPAM visibility by default and ignore VMM writes
Date: Thu, 12 Dec 2024 12:57:28 -0500
Message-ID: <20241212125342-c1db4ded4bf98912@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241212151406.1436382-1-joey.gouly@arm.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 6685f5d572c22e1003e7c0d089afe1c64340ab1f

WARNING: Author mismatch between patch and upstream commit:
Backport author: Joey Gouly <joey.gouly@arm.com>
Commit author: James Morse <james.morse@arm.com>


Status in newer kernel trees:
6.12.y | Not found
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  6685f5d572c22 ! 1:  d125d9a972e48 KVM: arm64: Disable MPAM visibility by default and ignore VMM writes
    @@ Metadata
      ## Commit message ##
         KVM: arm64: Disable MPAM visibility by default and ignore VMM writes
     
    +    commit 6685f5d572c22e1003e7c0d089afe1c64340ab1f upstream.
    +
         commit 011e5f5bf529f ("arm64/cpufeature: Add remaining feature bits in
         ID_AA64PFR0 register") exposed the MPAM field of AA64PFR0_EL1 to guests,
         but didn't add trap handling. A previous patch supplied the missing trap
    @@ Commit message
         Reviewed-by: Marc Zyngier <maz@kernel.org>
         Link: https://lore.kernel.org/r/20241030160317.2528209-7-joey.gouly@arm.com
         Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
    +    [ joey: fixed up merge conflict, no ID_FILTERED macro in 6.6 ]
    +    Signed-off-by: Joey Gouly <joey.gouly@arm.com>
    +    Cc: stable@vger.kernel.org # 6.6.x
    +    Cc: Vitaly Chikunov <vt@altlinux.org>
    +    Link: https://lore.kernel.org/linux-arm-kernel/20241202045830.e4yy3nkvxtzaybxk@altlinux.org/
     
      ## arch/arm64/kvm/sys_regs.c ##
     @@ arch/arm64/kvm/sys_regs.c: static u64 __kvm_read_sanitised_id_reg(const struct kvm_vcpu *vcpu,
    - 		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_MTEX);
    - 		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_DF2);
    - 		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_PFAR);
    + 			val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_MTE);
    + 
    + 		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_SME);
     +		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_MPAM_frac);
      		break;
    - 	case SYS_ID_AA64PFR2_EL1:
    - 		/* We only expose FPMR */
    -@@ arch/arm64/kvm/sys_regs.c: static u64 sanitise_id_aa64pfr0_el1(const struct kvm_vcpu *vcpu, u64 val)
    + 	case SYS_ID_AA64ISAR1_EL1:
    + 		if (!vcpu_has_ptrauth(vcpu))
    +@@ arch/arm64/kvm/sys_regs.c: static u64 read_sanitised_id_aa64pfr0_el1(struct kvm_vcpu *vcpu,
      
      	val &= ~ID_AA64PFR0_EL1_AMU_MASK;
      
    @@ arch/arm64/kvm/sys_regs.c: static u64 sanitise_id_aa64pfr0_el1(const struct kvm_
      }
      
     @@ arch/arm64/kvm/sys_regs.c: static int set_id_dfr0_el1(struct kvm_vcpu *vcpu,
    + 	return set_id_reg(vcpu, rd, val);
      }
      
    - static int set_id_aa64pfr0_el1(struct kvm_vcpu *vcpu,
    --			       const struct sys_reg_desc *rd, u64 val)
    ++static int set_id_aa64pfr0_el1(struct kvm_vcpu *vcpu,
     +			       const struct sys_reg_desc *rd, u64 user_val)
    - {
    --	return set_id_reg(vcpu, rd, val);
    ++{
     +	u64 hw_val = read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1);
     +	u64 mpam_mask = ID_AA64PFR0_EL1_MPAM_MASK;
     +
    @@ arch/arm64/kvm/sys_regs.c: static int set_id_dfr0_el1(struct kvm_vcpu *vcpu,
     +		user_val &= ~ID_AA64PFR1_EL1_MPAM_frac_MASK;
     +
     +	return set_id_reg(vcpu, rd, user_val);
    - }
    - 
    ++}
    ++
      /*
    +  * cpufeature ID register user accessors
    +  *
     @@ arch/arm64/kvm/sys_regs.c: static const struct sys_reg_desc sys_reg_descs[] = {
    - 		      ID_AA64PFR0_EL1_RAS |
    - 		      ID_AA64PFR0_EL1_AdvSIMD |
    - 		      ID_AA64PFR0_EL1_FP)),
    --	ID_WRITABLE(ID_AA64PFR1_EL1, ~(ID_AA64PFR1_EL1_PFAR |
    -+	ID_FILTERED(ID_AA64PFR1_EL1, id_aa64pfr1_el1,
    -+				     ~(ID_AA64PFR1_EL1_PFAR |
    - 				       ID_AA64PFR1_EL1_DF2 |
    - 				       ID_AA64PFR1_EL1_MTEX |
    - 				       ID_AA64PFR1_EL1_THE |
    + 	{ SYS_DESC(SYS_ID_AA64PFR0_EL1),
    + 	  .access = access_id_reg,
    + 	  .get_user = get_id_reg,
    +-	  .set_user = set_id_reg,
    ++	  .set_user = set_id_aa64pfr0_el1,
    + 	  .reset = read_sanitised_id_aa64pfr0_el1,
    + 	  .val = ID_AA64PFR0_EL1_CSV2_MASK | ID_AA64PFR0_EL1_CSV3_MASK, },
    +-	ID_SANITISED(ID_AA64PFR1_EL1),
    ++	{ SYS_DESC(SYS_ID_AA64PFR1_EL1),
    ++	  .access = access_id_reg,
    ++	  .get_user = get_id_reg,
    ++	  .set_user = set_id_aa64pfr1_el1,
    ++	  .reset = kvm_read_sanitised_id_reg, },
    + 	ID_UNALLOCATED(4,2),
    + 	ID_UNALLOCATED(4,3),
    + 	ID_SANITISED(ID_AA64ZFR0_EL1),
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

