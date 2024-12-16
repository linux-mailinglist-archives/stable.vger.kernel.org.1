Return-Path: <stable+bounces-104361-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB199F33CC
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 15:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62AD01889E21
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 14:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1F185626;
	Mon, 16 Dec 2024 14:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tIf8NCiQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEA541C94
	for <stable@vger.kernel.org>; Mon, 16 Dec 2024 14:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734360835; cv=none; b=XrYicr+xsj8NIx/38K9mu6da76vhtPL/I6XKV5LX2OpgdS1cuNM7PxFe83fhqLCIxd2+03jwGzzPAGgv4pw6yFH6ZlvcRhdhBtVgTrq1wz9SwpNe3soWqzusMF7qeFW7RRu9JtB1Vqsa+eIzUpfAzlsb6ybz/duae/JRWHkthSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734360835; c=relaxed/simple;
	bh=bqnBvYOPMyc4SkZ5XxYDYNoIAvco3PVin7wGh6uDU1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VMlzaCjzw83jC4461r1gaMrpkfqvivzvRfOG/xT+o1ESbTjGXGQgobSjDPK1zuihGxEyPFWPNOopyGB6HnbGqGPD4Fmvhkb4vALnWti/Rb8qstOKLtg4WMovVLk/ecDCgIKA3xhpK2UatUavOX52uEOlpMfG51aaueRU+oEIaf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tIf8NCiQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10779C4CED0;
	Mon, 16 Dec 2024 14:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734360835;
	bh=bqnBvYOPMyc4SkZ5XxYDYNoIAvco3PVin7wGh6uDU1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tIf8NCiQxekG4z5oWzvLiB/UXMNtZGGGmJVOFLZMh+dHtGn5CbKupccWeuXYuRPxj
	 F+qu6SFBMenIwwX1F/CBBteo+JKS0KXi/gqpfDE3QclcoMwxdXCCdXIz7B9X60kbFm
	 85fHrkBvxAlyIgmaWMK/nExA9owtAlahvezBLz+/yDrMgdiUR23XxLxq80OJIOI9tJ
	 07zofI052J6zND80WzZHmYjV2O/mpUmTU5ixphDDsMGbbW+p3m5fsneaKNGVNfCg8H
	 JD7C838C+5izfKH5ctINxJ9e+Z+Y/kJ6CQWeY6rskD/ZahZ+vfdXzFPpowKIsT92BG
	 /XA8G/tM968QA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.12] KVM: arm64: Disable MPAM visibility by default and ignore VMM writes
Date: Mon, 16 Dec 2024 09:53:53 -0500
Message-Id: <20241216082543-39b396803606fa7f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241216085002.334880-1-maz@kernel.org>
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
Backport author: Marc Zyngier <maz@kernel.org>
Commit author: James Morse <james.morse@arm.com>


Status in newer kernel trees:
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  6685f5d572c2 ! 1:  aab69d989e76 KVM: arm64: Disable MPAM visibility by default and ignore VMM writes
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
    +    [maz: adapted to lack of ID_FILTERED()]
    +    Signed-off-by: Marc Zyngier <maz@kernel.org>
    +    Cc: stable@vger.kernel.org
     
      ## arch/arm64/kvm/sys_regs.c ##
     @@ arch/arm64/kvm/sys_regs.c: static u64 __kvm_read_sanitised_id_reg(const struct kvm_vcpu *vcpu,
    @@ arch/arm64/kvm/sys_regs.c: static u64 __kvm_read_sanitised_id_reg(const struct k
      		break;
      	case SYS_ID_AA64PFR2_EL1:
      		/* We only expose FPMR */
    -@@ arch/arm64/kvm/sys_regs.c: static u64 sanitise_id_aa64pfr0_el1(const struct kvm_vcpu *vcpu, u64 val)
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
    + 	{ SYS_DESC(SYS_ID_AA64PFR0_EL1),
    + 	  .access = access_id_reg,
    + 	  .get_user = get_id_reg,
    +-	  .set_user = set_id_reg,
    ++	  .set_user = set_id_aa64pfr0_el1,
    + 	  .reset = read_sanitised_id_aa64pfr0_el1,
    + 	  .val = ~(ID_AA64PFR0_EL1_AMU |
    + 		   ID_AA64PFR0_EL1_MPAM |
    +@@ arch/arm64/kvm/sys_regs.c: static const struct sys_reg_desc sys_reg_descs[] = {
    + 		   ID_AA64PFR0_EL1_RAS |
    + 		   ID_AA64PFR0_EL1_AdvSIMD |
    + 		   ID_AA64PFR0_EL1_FP), },
     -	ID_WRITABLE(ID_AA64PFR1_EL1, ~(ID_AA64PFR1_EL1_PFAR |
    -+	ID_FILTERED(ID_AA64PFR1_EL1, id_aa64pfr1_el1,
    -+				     ~(ID_AA64PFR1_EL1_PFAR |
    ++	{ SYS_DESC(SYS_ID_AA64PFR1_EL1),
    ++	  .access	= access_id_reg,
    ++	  .get_user	= get_id_reg,
    ++	  .set_user	= set_id_aa64pfr1_el1,
    ++	  .reset	= kvm_read_sanitised_id_reg,
    ++	  .val		=	     ~(ID_AA64PFR1_EL1_PFAR |
      				       ID_AA64PFR1_EL1_DF2 |
      				       ID_AA64PFR1_EL1_MTEX |
      				       ID_AA64PFR1_EL1_THE |
    +@@ arch/arm64/kvm/sys_regs.c: static const struct sys_reg_desc sys_reg_descs[] = {
    + 				       ID_AA64PFR1_EL1_RES0 |
    + 				       ID_AA64PFR1_EL1_MPAM_frac |
    + 				       ID_AA64PFR1_EL1_RAS_frac |
    +-				       ID_AA64PFR1_EL1_MTE)),
    ++				       ID_AA64PFR1_EL1_MTE), },
    + 	ID_WRITABLE(ID_AA64PFR2_EL1, ID_AA64PFR2_EL1_FPMR),
    + 	ID_UNALLOCATED(4,3),
    + 	ID_WRITABLE(ID_AA64ZFR0_EL1, ~ID_AA64ZFR0_EL1_RES0),
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

