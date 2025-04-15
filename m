Return-Path: <stable+bounces-132786-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC67A8AA3F
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 23:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C95F3BA8C4
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 21:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAA925745F;
	Tue, 15 Apr 2025 21:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWxzSr/d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF78256C60
	for <stable@vger.kernel.org>; Tue, 15 Apr 2025 21:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744753396; cv=none; b=EJikqRN+zdGuCLNTirSciUMIW005r3W+CC8wqXh1mREjhYs3cUbn2PVQNyeazJhdH4PMRTAT4O2eZ4zVX+B1pPK7cWGA3fMU2XagD7LN3k48wfxk7LGgq/62+Jd93xglOW2+UZmqdL9H0WtnOYqBmLBtRzgBCj9dlVxd77gqe0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744753396; c=relaxed/simple;
	bh=BW5GYsNrTVKOsGxzFCKjYtBVeVGcnFOyaaw/90rvOAo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KB7kDb39o8Oe3lsKxHNI9ykXNKyIuv1uZIjMdh4CggsWKBWBN/jv2S2yD1CNleal1IxD45KhWxsSvt5oyhokXF0HSmQOKR9rJX72SXnhTvGDkEd7wlY/nJguV4lmE3QveuCaGTowqBas9QkZZ7WGO/U1OEYzKijvh/mLZQ4awHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWxzSr/d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C71C4CEE7;
	Tue, 15 Apr 2025 21:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744753395;
	bh=BW5GYsNrTVKOsGxzFCKjYtBVeVGcnFOyaaw/90rvOAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UWxzSr/dXW/uukE+RLg5Is3FIlES/f8vBMQh98NuupKQw11WyAnA8JNo80dNnsFgj
	 DkDPEzMTaG4Ei5CIddq3juK0BQ9FizftGVJPgv1FauY/gXgmVNecxgOqNgGTBTHp02
	 3FxidR0PXyclgdWHnzi1wmBvCHOgn1an8w3EliDD8CSol1IU/rSx6dq8PTotZdQAl6
	 Ywoq9dSQT48dPt3z1YZXhxvliG/MOeHh2djnE4OjDufG8ZvrlXVgnYRwPvxB0ku9OH
	 kYlU8QK2Fnzx4xHb5+Jp/e5EgV2H650xV0Gq0AuBgZfP9SxP8x4rj1L0/F82jIPsOz
	 FkLqvKcz31FfQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	anshuman.khandual@arm.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH V2 6.12.y 7/7] arm64/boot: Enable EL2 requirements for FEAT_PMUv3p9
Date: Tue, 15 Apr 2025 17:43:13 -0400
Message-Id: <20250415122452-9db973d5f1054e17@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250415045728.2248935-8-anshuman.khandual@arm.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
ℹ️ This is part 7/7 of a series
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 858c7bfcb35e1100b58bb63c9f562d86e09418d9

Status in newer kernel trees:
6.14.y | Not found
6.13.y | Not found

Note: The patch differs from the upstream commit:
---
1:  858c7bfcb35e1 ! 1:  f5de0f647be12 arm64/boot: Enable EL2 requirements for FEAT_PMUv3p9
    @@ Commit message
         Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
         Link: https://lore.kernel.org/r/20250227035119.2025171-1-anshuman.khandual@arm.com
         Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
    +    (cherry picked from commit 858c7bfcb35e1100b58bb63c9f562d86e09418d9)
    +    Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
     
      ## Documentation/arch/arm64/booting.rst ##
     @@ Documentation/arch/arm64/booting.rst: Before jumping into the kernel, the following conditions must be met:
    @@ arch/arm64/include/asm/el2_setup.h
     +.Lskip_fgt2_\@:
     +.endm
     +
    - .macro __init_el2_gcs
    - 	mrs_s	x1, SYS_ID_AA64PFR1_EL1
    - 	ubfx	x1, x1, #ID_AA64PFR1_EL1_GCS_SHIFT, #4
    + .macro __init_el2_nvhe_prepare_eret
    + 	mov	x0, #INIT_PSTATE_EL1
    + 	msr	spsr_el2, x0
     @@
      	__init_el2_nvhe_idregs
      	__init_el2_cptr
      	__init_el2_fgt
     +	__init_el2_fgt2
    -         __init_el2_gcs
      .endm
      
    + #ifndef __KVM_NVHE_HYPERVISOR__
    +
    + ## arch/arm64/tools/sysreg ##
    +@@ arch/arm64/tools/sysreg: UnsignedEnum	11:8	PMUVer
    + 	0b0110	V3P5
    + 	0b0111	V3P7
    + 	0b1000	V3P8
    ++	0b1001	V3P9
    + 	0b1111	IMP_DEF
    + EndEnum
    + UnsignedEnum	7:4	TraceVer
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.13.y       |  Success    |  Success   |

