Return-Path: <stable+bounces-121659-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F91A58A56
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 03:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F35FD188ACF9
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 02:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE35F199223;
	Mon, 10 Mar 2025 02:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adiHPbh3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E58B198E81
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 02:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741572897; cv=none; b=DOigMV6gcsyBIUaw0lf7VycrIiYkAco+JBd8t7IfHv0OykNKfDLkNpXbsZBorB97wVG3cSv3cR7J9OfPwen5lKpZ9eAqOhhDMV+oY43Dd95q+zQWZn0mMWimnzwZCryu3a17WeuiwOIHKq2RtqzbYlPlHcsJOl1blkXKwBSaD0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741572897; c=relaxed/simple;
	bh=XnmVPGLupYRkD0AM68QGNmO7LgRfQXKkhRFWLlkoHzo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pW3RHElOQwZqwUvMnBq0zIe1pkQpA+iVhl2fY0Mvd9IX2T+uW1ad0HZKGaU+n7ezDB2u2k+FPXDxoBs73zDS1pSQOCL72oFzvForJqRuqg4UzITOnbpyOjjVRb99tezkwQogVHdLO2jOVBj4t7agp9vliu48Y9xj6RLV1mTN6fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adiHPbh3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29F3C4CEED;
	Mon, 10 Mar 2025 02:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741572897;
	bh=XnmVPGLupYRkD0AM68QGNmO7LgRfQXKkhRFWLlkoHzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=adiHPbh3ViJyzkkXT9YR0ENuTCBZP2uFuOblX5V/MZboNWhSuQiUcBYuJ52VT9QGr
	 sUdeiww7QalU4Hyadi/dFJR1eGRZSlcyadA5o4QpDeWehriog5OxA7/LzxCQfAOG2/
	 akfL3O+YMN7WkzeP1dhvNcvz6Ns9Ib9nxXOaeomRY7VyqAlc8GImp0KLQ9iiN7MIrx
	 HYDzlnTCcb7/OvIavPy1HJt7DJVKFOfqXtzgOy4Eq0HXdajuaR0soqpJEkPuKz9oAF
	 RFrUB0+GoVikIoun+5x//tScvFiwuJ5Wx1q/a5ZnSJ0WyoOZA2nFWRFPhn6gTnYNMA
	 81ec3lY/HpZeg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4] x86/mm: Don't disable PCID when INVLPG has been fixed by microcode
Date: Sun,  9 Mar 2025 22:14:55 -0400
Message-Id: <20250309202750-392a3cc39587e3b3@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250308-clear-pcid-5-4-v1-1-e8bd7c402503@linux.intel.com>
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

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: f24f669d03f884a6ef95cca84317d0f329e93961

WARNING: Author mismatch between patch and upstream commit:
Backport author: Pawan Gupta<pawan.kumar.gupta@linux.intel.com>
Commit author: Xi Ruoyao<xry111@xry111.site>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  f24f669d03f88 ! 1:  1bbb6075a546b x86/mm: Don't disable PCID when INVLPG has been fixed by microcode
    @@ Metadata
      ## Commit message ##
         x86/mm: Don't disable PCID when INVLPG has been fixed by microcode
     
    +    commit f24f669d03f884a6ef95cca84317d0f329e93961 upstream.
    +
         Per the "Processor Specification Update" documentations referred by
         the intel-microcode-20240312 release note, this microcode release has
         fixed the issue for all affected models.
    @@ Commit message
         Intel.
     
         [ dhansen: comment and changelog tweaks ]
    +    [ pawan: backported to 5.4
    +             s/ATOM_GRACEMONT/ALDERLAKE_N/
    +             added microcode matching to INTEL_MATCH() and invlpg_miss_ids ]
     
         Signed-off-by: Xi Ruoyao <xry111@xry111.site>
         Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
         Acked-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
    +    Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
         Link: https://lore.kernel.org/all/168436059559.404.13934972543631851306.tip-bot2@tip-bot2/
         Link: https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files/releases/tag/microcode-20240312
         Link: https://cdrdv2.intel.com/v1/dl/getContent/740518 # RPL042, rev. 13
    @@ Commit message
     
      ## arch/x86/mm/init.c ##
     @@ arch/x86/mm/init.c: static void __init probe_page_size_mask(void)
    + 	}
      }
      
    +-#define INTEL_MATCH(_model) { .vendor  = X86_VENDOR_INTEL,	\
    +-			      .family  = 6,			\
    +-			      .model = _model,			\
    +-			    }
    ++#define INTEL_MATCH(_model, ucode) { .vendor  = X86_VENDOR_INTEL,	\
    ++				     .family  = 6,			\
    ++				     .model = _model,			\
    ++				     .driver_data = ucode,		\
    ++				   }
      /*
     - * INVLPG may not properly flush Global entries
     - * on these CPUs when PCIDs are enabled.
    @@ arch/x86/mm/init.c: static void __init probe_page_size_mask(void)
     + * these CPUs.  New microcode fixes the issue.
       */
      static const struct x86_cpu_id invlpg_miss_ids[] = {
    --	X86_MATCH_VFM(INTEL_ALDERLAKE,	    0),
    --	X86_MATCH_VFM(INTEL_ALDERLAKE_L,    0),
    --	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT, 0),
    --	X86_MATCH_VFM(INTEL_RAPTORLAKE,	    0),
    --	X86_MATCH_VFM(INTEL_RAPTORLAKE_P,   0),
    --	X86_MATCH_VFM(INTEL_RAPTORLAKE_S,   0),
    -+	X86_MATCH_VFM(INTEL_ALDERLAKE,	    0x2e),
    -+	X86_MATCH_VFM(INTEL_ALDERLAKE_L,    0x42c),
    -+	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT, 0x11),
    -+	X86_MATCH_VFM(INTEL_RAPTORLAKE,	    0x118),
    -+	X86_MATCH_VFM(INTEL_RAPTORLAKE_P,   0x4117),
    -+	X86_MATCH_VFM(INTEL_RAPTORLAKE_S,   0x2e),
    +-	INTEL_MATCH(INTEL_FAM6_ALDERLAKE   ),
    +-	INTEL_MATCH(INTEL_FAM6_ALDERLAKE_L ),
    +-	INTEL_MATCH(INTEL_FAM6_ALDERLAKE_N ),
    +-	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE  ),
    +-	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_P),
    +-	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_S),
    ++	INTEL_MATCH(INTEL_FAM6_ALDERLAKE,	0x2e),
    ++	INTEL_MATCH(INTEL_FAM6_ALDERLAKE_L,	0x42c),
    ++	INTEL_MATCH(INTEL_FAM6_ALDERLAKE_N,	0x11),
    ++	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE,	0x118),
    ++	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_P,	0x4117),
    ++	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_S,	0x2e),
      	{}
      };
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

