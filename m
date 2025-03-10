Return-Path: <stable+bounces-121652-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AD7A58A4E
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 03:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB1F93A8C29
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 02:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCB118E764;
	Mon, 10 Mar 2025 02:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmjvozT/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF3F156861
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 02:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741572883; cv=none; b=N9q8VNUcQ2Y5hWqW/+/ADK8x/+F8xPTh3o9T7zZUMafrE4b1uu0qPuF/aFiGm3889XDty+Bv4cRRTej8VmMehLGivgf+Fumettp86xzESUC1F/7WpK2uNoYjNWss2rFbhegoN+F5VU+5zwofOxbG0d1NiEx6BhfbmCZaAie1cfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741572883; c=relaxed/simple;
	bh=ky+givcLhSJIihNrfYBWVvz/SlnDrAXz80Z33vnC68w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AENuskA3oolqxsJQhWUvisPjeio0v0uwuMV2nA26fScvZ8/wGnVYMLLQTbbN/0NRHkAuQsrZ/3MAJdZMRmA1f6KXw38MatzyaqJL22VR31HSb2yUb27iBGNBxoS5bNe9Cf9SYPAenPrRxPEWrNIxzvm4bQissBhR56nvyxximx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmjvozT/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14816C4CEE3;
	Mon, 10 Mar 2025 02:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741572882;
	bh=ky+givcLhSJIihNrfYBWVvz/SlnDrAXz80Z33vnC68w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kmjvozT/2ZNei6/jTIZoQF0t6/f1ZBIXj3mOATIr9hH3iA/Vik2wxNY89/paqLr7t
	 wPpZw2/WIENKGQEwBc+6mzNjf4OLveXmLTXRJtASPEc64sTgTUduP+z1y2EvM+ZaWs
	 0Gi+3+TWlwufZOGLActNSR+KICaJLBiYMKugCdkhXXVCl0VttMa0A0oK4yT3n9ojYv
	 GmyCGtxH8fgrnyVfRuFAbwmdHSNdZ+odkRVBgxmIlT8SU3VnxK6RwkWw2etj1uSEcc
	 Od4sxm1zOpCQAeNioTSEcfiovXL9bAjotsjyTKjfsRhwz9y8TeQJC3qnoDMCRBmfhk
	 VLBmY01WN72xg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10] x86/mm: Don't disable PCID when INVLPG has been fixed by microcode
Date: Sun,  9 Mar 2025 22:14:40 -0400
Message-Id: <20250309201819-e0de29413d07e09a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250307-clear-pcid-5-10-v1-1-79ed114bc031@linux.intel.com>
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
5.15.y | Not found
5.4.y | Not found

Note: The patch differs from the upstream commit:
---
1:  f24f669d03f88 ! 1:  bcbd0211aafe3 x86/mm: Don't disable PCID when INVLPG has been fixed by microcode
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
    +    [ pawan: backported to 5.10
    +             s/ATOM_GRACEMONT/ALDERLAKE_N/ ]
     
         Signed-off-by: Xi Ruoyao <xry111@xry111.site>
         Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
         Acked-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
    +    Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
         Link: https://lore.kernel.org/all/168436059559.404.13934972543631851306.tip-bot2@tip-bot2/
         Link: https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files/releases/tag/microcode-20240312
         Link: https://cdrdv2.intel.com/v1/dl/getContent/740518 # RPL042, rev. 13
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
    +-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,      0),
    +-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,    0),
    +-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,    0),
    +-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,     0),
    +-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,   0),
    +-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,   0),
    ++	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,      0x2e),
    ++	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,    0x42c),
    ++	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,    0x11),
    ++	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,     0x118),
    ++	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,   0x4117),
    ++	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,   0x2e),
      	{}
      };
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

