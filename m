Return-Path: <stable+bounces-100253-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0E29EA0AC
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 21:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F31741886EB2
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 20:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3ADF19AD8C;
	Mon,  9 Dec 2024 20:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIyufJFU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30D61E515
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 20:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733777748; cv=none; b=NtUsY/IvrSapoyi9632ksAJOikdJ1efGf2HLnI8izLQVIbQcx707axHmWhPeWJNyhxj7yv0DeNR4i4xUFVRRUrF6prY/xylLXUE6yLYRcdLZVtkoX9Kh339z1NXpvZsVa3XbDb+oZOJLJOTrvWk4hHkwAP9YJGgJT65CYEQwxnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733777748; c=relaxed/simple;
	bh=L2cKzSxBdvxdBlB7yWr+mTf1VYNEfd0mmXCNR94x0kQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YE8Cbvnhoo/004mM3oDFkk4xPTGXm/xLuiQhL3SdkD4ecQFf4F7oZaZlvl+z13RNNoROK9aqmjBZsA944RY0fztWVhHlvjlngIHWZ0OdZO3FFRgDBKjJph9twiuh2gdBPzD3vzW9VenuCXjG/w8lAaWVZuZhBdhIodCp2GfMMCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIyufJFU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CDEEC4CED1;
	Mon,  9 Dec 2024 20:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733777748;
	bh=L2cKzSxBdvxdBlB7yWr+mTf1VYNEfd0mmXCNR94x0kQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YIyufJFUibzOMLp/e87PV3VouVpiwoKJyDxWhdoDzqIifgCy2OF6+t0SB5K7TV09C
	 /dbIZ9Ap79A7AbCxUgdcEDFtDZOoFt14hOxSXCVt9YdYXNXMAfzo1TQSJygeGSY6Iw
	 QRQP61vQhTj1TaB39T8z/+ZCGwrDJdZIP/OiPurWr3AnzhTR8T4jjwwUbqvaNdPnyI
	 PCQL+pvkfR99W/aYsYVIdS4E51VQWmAxPmgui1kIbSJOCt5bPxXSuNsgbvo7Kfhg+M
	 hgC8oaPVyA77ZTuYPe5RxrdxRylhVuEIs5Jl3pIz9bXR8LX2wv9sGtlt+F3JGRIld6
	 IegF2EVz5lsQA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] arm64: smccc: Remove broken support for SMCCCv1.3 SVE discard hint
Date: Mon,  9 Dec 2024 15:55:46 -0500
Message-ID: <20241209151021-e5ec19ee0ed2c043@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241209134339.2088127-1-mark.rutland@arm.com>
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

Note: The patch differs from the upstream commit:
---
1:  8c462d56487e3 ! 1:  0246f2b20419d arm64: smccc: Remove broken support for SMCCCv1.3 SVE discard hint
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
    +    [ Mark: fix conflicts in <linux/arm-smccc.h> ]
    +    Signed-off-by: Mark Rutland <mark.rutland@arm.com>
     
      ## arch/arm64/kernel/smccc-call.S ##
     @@
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
| stable/linux-6.1.y        |  Success    |  Success   |

