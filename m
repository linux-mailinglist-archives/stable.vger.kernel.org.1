Return-Path: <stable+bounces-100252-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB27B9EA0AB
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 21:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB89118862F7
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 20:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92CE19AA72;
	Mon,  9 Dec 2024 20:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZY8wArxL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A957A1E515
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 20:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733777746; cv=none; b=dndznMak4i+oF5K8S95wUcwV9vvWLu3hBD1Yim8MSITZTxkixuC1aOKvs3XOATlAqvgazaQFs0c94glL5tCSBcenaOywni4QYkoNqj1/YQCBLMOn8oDjeIKM0hJuT/QicNG1nMVltys8UQIuZv1SeKikWt2035M8jB1GTVol/Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733777746; c=relaxed/simple;
	bh=Mlez3jVSjQr/MSsutNH5dIToivGN9BDRRwJG+Jv5CmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g2+SeSknxRj7iphK0xIMGksPASxhusm7ZMXP1ylqoNx80zvHXWYq/ZNTQF45Y98gFFXU3oy29nIe6wfeHzID371R6cbjVC1Q9yf8UW17pwyAC9aU8aHBYIpFrMSnxH/arPzMMU+sbHral0PkkNg8ZkB8NqXV7nJXiyx0GsdntFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZY8wArxL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0195C4CED1;
	Mon,  9 Dec 2024 20:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733777746;
	bh=Mlez3jVSjQr/MSsutNH5dIToivGN9BDRRwJG+Jv5CmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZY8wArxLVJpRq3CFAzsQB1bpW7Inbvh0qixVT4fCo+Pf7hd2hRfcVWe/ha0KYhkA5
	 trN6ZuAHd3ZLXqbA0sZFs8MwVQ0Gy8xhVI3yUdVlMMgoIiyBi7Hc+hAx9PYDsa0vYG
	 PhK8zTnJtuihPoet18c5bXNCZtmSev1yaaUH5k+S/Zv3NYu1TIM+LLQPPHEzF8M1tv
	 XPwdNABeqACNLG88kzquSfQoQNJQrjHjm8vi00bZutAoY5srPCIBDlJYrr/WOxOj/y
	 7MIsAKetBsV1gzfBleMjbENOc4WkvKSfvgnSO2qg5KyULlrMMn1lyozHHhGTO9fmrc
	 DKY/BTIlubz/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] arm64: smccc: Remove broken support for SMCCCv1.3 SVE discard hint
Date: Mon,  9 Dec 2024 15:55:44 -0500
Message-ID: <20241209143539-38502b99747e56fd@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241209134602.2088353-1-mark.rutland@arm.com>
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

The upstream commit SHA1 provided is correct: 8c462d56487e3abdbf8a61cedfe7c795a54f4a78


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 701fae8dce72)
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  8c462d56487e3 ! 1:  b6e0debc41724 arm64: smccc: Remove broken support for SMCCCv1.3 SVE discard hint
    @@ Metadata
      ## Commit message ##
         arm64: smccc: Remove broken support for SMCCCv1.3 SVE discard hint
     
    +    [ Upstream commit 8c462d56487e3abdbf8a61cedfe7c795a54f4a78 ]
    +
         SMCCCv1.3 added a hint bit which callers can set in an SMCCC function ID
         (AKA "FID") to indicate that it is acceptable for the SMCCC
         implementation to discard SVE and/or SME state over a specific SMCCC
    @@ Commit message
         Reviewed-by: Mark Brown <broonie@kernel.org>
         Link: https://lore.kernel.org/r/20241106160448.2712997-1-mark.rutland@arm.com
         Signed-off-by: Will Deacon <will@kernel.org>
    +    [ Mark: fix conflicts in <linux/arm-smccc.h> and drivers/firmware/smccc/smccc.c ]
    +    Signed-off-by: Mark Rutland <mark.rutland@arm.com>
     
      ## arch/arm64/kernel/smccc-call.S ##
     @@
    @@ drivers/firmware/smccc/smccc.c: static u32 smccc_version = ARM_SMCCC_VERSION_1_0
      
      bool __ro_after_init smccc_trng_available = false;
     -u64 __ro_after_init smccc_has_sve_hint = false;
    - s32 __ro_after_init smccc_soc_id_version = SMCCC_RET_NOT_SUPPORTED;
    - s32 __ro_after_init smccc_soc_id_revision = SMCCC_RET_NOT_SUPPORTED;
      
    + void __init arm_smccc_version_init(u32 version, enum arm_smccc_conduit conduit)
    + {
     @@ drivers/firmware/smccc/smccc.c: void __init arm_smccc_version_init(u32 version, enum arm_smccc_conduit conduit)
      	smccc_conduit = conduit;
      
    @@ drivers/firmware/smccc/smccc.c: void __init arm_smccc_version_init(u32 version,
     -	if (IS_ENABLED(CONFIG_ARM64_SVE) &&
     -	    smccc_version >= ARM_SMCCC_VERSION_1_3)
     -		smccc_has_sve_hint = true;
    + }
      
    - 	if ((smccc_version >= ARM_SMCCC_VERSION_1_2) &&
    - 	    (smccc_conduit != SMCCC_CONDUIT_NONE)) {
    + enum arm_smccc_conduit arm_smccc_1_1_get_conduit(void)
     
      ## include/linux/arm-smccc.h ##
     @@ include/linux/arm-smccc.h: u32 arm_smccc_get_version(void);
    @@ include/linux/arm-smccc.h: u32 arm_smccc_get_version(void);
     -extern u64 smccc_has_sve_hint;
     -
      /**
    -  * arm_smccc_get_soc_id_version()
    -  *
    +  * struct arm_smccc_res - Result from SMC/HVC call
    +  * @a0-a3 result values from registers 0 to 3
     @@ include/linux/arm-smccc.h: struct arm_smccc_quirk {
      	} state;
      };
    @@ include/linux/arm-smccc.h: asmlinkage void __arm_smccc_hvc(unsigned long a0, uns
     -
     -#endif
     -
    - #define __constraint_read_2	"r" (arg0)
    - #define __constraint_read_3	__constraint_read_2, "r" (arg1)
    - #define __constraint_read_4	__constraint_read_3, "r" (arg2)
    + #define ___count_args(_0, _1, _2, _3, _4, _5, _6, _7, _8, x, ...) x
    + 
    + #define __count_args(...)						\
     @@ include/linux/arm-smccc.h: asmlinkage void __arm_smccc_hvc(unsigned long a0, unsigned long a1,
    + 
    + #define ___constraints(count)						\
    + 	: __constraint_read_ ## count					\
    +-	: smccc_sve_clobbers "memory"
    ++	: "memory"
    + #define __constraints(count)	___constraints(count)
    + 
    + /*
    +@@ include/linux/arm-smccc.h: asmlinkage void __arm_smccc_hvc(unsigned long a0, unsigned long a1,
    + 		register unsigned long r2 asm("r2");			\
      		register unsigned long r3 asm("r3"); 			\
    - 		CONCATENATE(__declare_arg_,				\
    - 			    COUNT_ARGS(__VA_ARGS__))(__VA_ARGS__);	\
    + 		__declare_args(__count_args(__VA_ARGS__), __VA_ARGS__);	\
     -		asm volatile(SMCCC_SVE_CHECK				\
     -			     inst "\n" :				\
     +		asm volatile(inst "\n" :				\
      			     "=r" (r0), "=r" (r1), "=r" (r2), "=r" (r3)	\
    - 			     : CONCATENATE(__constraint_read_,		\
    - 					   COUNT_ARGS(__VA_ARGS__))	\
    --			     : smccc_sve_clobbers "memory");		\
    -+			     : "memory");				\
    - 		if (___res)						\
    - 			*___res = (typeof(*___res)){r0, r1, r2, r3};	\
    - 	} while (0)
    -@@ include/linux/arm-smccc.h: asmlinkage void __arm_smccc_hvc(unsigned long a0, unsigned long a1,
    - 		asm ("" :						\
    - 		     : CONCATENATE(__constraint_read_,			\
    - 				   COUNT_ARGS(__VA_ARGS__))		\
    --		     : smccc_sve_clobbers "memory");			\
    -+		     : "memory");					\
    + 			     __constraints(__count_args(__VA_ARGS__)));	\
      		if (___res)						\
    - 			___res->a0 = SMCCC_RET_NOT_SUPPORTED;		\
    - 	} while (0)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

