Return-Path: <stable+bounces-132171-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C87AA84920
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 18:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C82C41644B8
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 15:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A1D1E98FC;
	Thu, 10 Apr 2025 15:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXdMnmc+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E651EA7F1
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 15:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300596; cv=none; b=mzz/RUtoqnBjYzPfGCoiBIlC6tuVm3Q7gv5D4/9tGWqK/SOkG9uUekyLK94dQFpyrnEk17hcKDID1aQT5+IHjXZ+I5Z/D1/HfFHjKgSf013OH+q83aDejBou/e390CSq4nC9E+/h0ROp3GmxglN6jqewIdEBhXQxXgT5aQSMWRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300596; c=relaxed/simple;
	bh=dcI1b+sBWQJElqZQBLIIpPVv6t/pptivDmP2BgD7Hjw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=km3vU5UGLRi2euMM6AsyQRydX+CFVso6+y89gzTwcEeysMOg8Yq7gZBQ9D+Wq+73yRq3+82ZCwQbz7UE5ELPu+JQwHkPWS8mtOKRc64avMofzpmxV3DBhAjk7sD6ou2Ihgc0iLUl7fo1K2OJGbTOkZw5j8DvgeWV+eKjEsRyI4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXdMnmc+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD7EC4CEDD;
	Thu, 10 Apr 2025 15:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744300595;
	bh=dcI1b+sBWQJElqZQBLIIpPVv6t/pptivDmP2BgD7Hjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EXdMnmc+eNFVy++5XAKY1/7PRFnKLDq1RBY1SeEvS3p/hUYTbTMVlZOT047/DSkmr
	 /Rc/IUTKWucIeXTCJ7Yjmvx1eCq0s7CNWpuClIzgCGn/024zybViobEYzyIr5ucQmQ
	 hUfxXx2rOSumhWU595+l/aCvSmdmjB60lKdQK9AZhyb8m37EZ354dfgDOnmdlmeiVi
	 SNY/qmEmS/bdwVQEkMs5yJRAFsKkeIV35EAtX7lsG6auekyyV3W8mzhihoCkn40NuQ
	 +C6DrjTQ6UVukGh6NgN0g0vSTH5kKUeOzxhO30LqiFqJS7jOo3ARHXIaFCF030JrXZ
	 qYuZmd1Xf50YQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	anshuman.khandual@arm.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y 1/8] perf/arm_pmuv3: Add PMUv3.9 per counter EL0 access control
Date: Thu, 10 Apr 2025 11:56:33 -0400
Message-Id: <20250410110737-feae8259ab9540a6@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250410035543.1518500-2-anshuman.khandual@arm.com>
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
❌ Build failures detected
⚠️ Found matching upstream commit but patch is missing proper reference to it
⚠️ Found follow-up fixes in mainline

Found matching upstream commit: 0bbff9ed81654d5f06bfca484681756ee407f924

WARNING: Author mismatch between patch and found commit:
Backport author: Anshuman Khandual<anshuman.khandual@arm.com>
Commit author: Rob Herring (Arm)<robh@kernel.org>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)

Found fixes commits:
858c7bfcb35e arm64/boot: Enable EL2 requirements for FEAT_PMUv3p9
bdc9a64c8b20 ARM: pmuv3: Add missing write_pmuacr()

Note: The patch differs from the upstream commit:
---
1:  0bbff9ed81654 ! 1:  876f9c2d718e5 perf/arm_pmuv3: Add PMUv3.9 per counter EL0 access control
    @@ Commit message
         Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
         Link: https://lore.kernel.org/r/20241002184326.1105499-1-robh@kernel.org
         Signed-off-by: Will Deacon <will@kernel.org>
    +    [cherry picked from commit 0bbff9ed81654d5f06bfca484681756ee407f924]
    +    Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
     
      ## arch/arm/include/asm/arm_pmuv3.h ##
     @@ arch/arm/include/asm/arm_pmuv3.h: static inline void kvm_vcpu_pmu_resync_el0(void) {}
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Failed    |

Build Errors:
Build error:
    during RTL pass: bbro
    drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c: In function 'dml_core_mode_support':
    drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c:9211:1: internal compiler error: in df_compact_blocks, at df-core.cc:1746
     9211 | }
          | ^
    0x7f8f45e06d67 __libc_start_call_main
    	../sysdeps/nptl/libc_start_call_main.h:58
    0x7f8f45e06e24 __libc_start_main_impl
    	../csu/libc-start.c:360
    Please submit a full bug report, with preprocessed source (by using -freport-bug).
    Please include the complete backtrace with any bug report.
    See <https://gcc.gnu.org/bugs/> for instructions.
    make[6]: *** [scripts/Makefile.build:229: drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.o] Error 1
    make[6]: Target 'drivers/gpu/drm/amd/amdgpu/' not remade because of errors.
    make[5]: *** [scripts/Makefile.build:478: drivers/gpu/drm/amd/amdgpu] Error 2
    make[5]: Target 'drivers/gpu/drm/' not remade because of errors.
    make[4]: *** [scripts/Makefile.build:478: drivers/gpu/drm] Error 2
    make[4]: Target 'drivers/gpu/' not remade because of errors.
    make[3]: *** [scripts/Makefile.build:478: drivers/gpu] Error 2
    make[3]: Target 'drivers/' not remade because of errors.
    make[2]: *** [scripts/Makefile.build:478: drivers] Error 2
    make[2]: Target './' not remade because of errors.
    make[1]: *** [/home/sasha/build/linus-next/Makefile:1944: .] Error 2
    make[1]: Target '__all' not remade because of errors.
    make: *** [Makefile:224: __sub-make] Error 2
    make: Target '__all' not remade because of errors.

