Return-Path: <stable+bounces-121658-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 487C4A58A54
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 03:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 120923A8D6B
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 02:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F8918A6AE;
	Mon, 10 Mar 2025 02:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxoGmTwt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56972156861
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 02:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741572895; cv=none; b=Tkx9PsbgwuDz81SOBCJwuGyD1Y9eeknIP6yRlTtk0E8qnWYY0J2Bk/jeyXe44JhI/oY/K5KPxAWkG2gWPQNh5GcLyAX2UHBWwf2vjLnCnP5il4m7ZxLqX+azdu3Uqwcpg8OvbZS0NeQ2EAsbLwArfm2370URMPV3ugzHIx8HElI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741572895; c=relaxed/simple;
	bh=VVFqNAdJ1z/9w+beKYA5PxjFWmHZzDddDXa+UdUMgTI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M6Rs/xJjmLZ38U0ex8x7/DpILAQxqrMO9sx89ioF9eAVfkXLNrJ/N+X+7KfxsUTFjM27yrseJznM6TjiPaM4Ui7BNA8IpB+qU3yzG70VsWT7KQdS386YlfsB3oJGK0g6XBrDaxdJvsdL2TPqpiumA/bC7lyEqTMw0kDmn3+if2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxoGmTwt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F12C4CEE3;
	Mon, 10 Mar 2025 02:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741572895;
	bh=VVFqNAdJ1z/9w+beKYA5PxjFWmHZzDddDXa+UdUMgTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dxoGmTwtnsnTBcTCiWsJaTlkz0GA/g5u/asc9j80/cumDu3zrygtJS1yaEvQwbSqW
	 7FSXEFRGys8v59X/KoLzoJpaj1rvPKHQqA7N8QhqK/P02fW3rU/y2vtJV1/wtY+IHL
	 OmESWoEQe3CNq/sPrSNSKN8D59NVmFlZ2i3G/KyzLZZHjscfLpL1SXZDbOE0MSBUia
	 ePc237K4PpDKl8cBDj6DdCPGt/8HJsNDVLbnBPBrh9OpmHBRbtD+LrzObx8HYhAXsA
	 7pLqjibEDhOR5ReyqDv+339WsDzCLM1jKBTuKRji7hZC6o1u1Rq9l2BOC37E37Ui2n
	 971QcjBjx2mlg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6] x86/mm: Don't disable PCID when INVLPG has been fixed by microcode
Date: Sun,  9 Mar 2025 22:14:53 -0400
Message-Id: <20250309170051-9ad32b902100fbb3@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250307-clear-pcid-6-6-v1-1-cbf7ff0e817c@linux.intel.com>
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

Note: The patch differs from the upstream commit:
---
1:  f24f669d03f88 ! 1:  b5ea42106470f x86/mm: Don't disable PCID when INVLPG has been fixed by microcode
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
    +    [ pawan: backported to 6.6 ]
     
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
    +-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT, 0),
    +-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,     0),
    +-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,   0),
    +-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,   0),
    ++	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,      0x2e),
    ++	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,    0x42c),
    ++	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT, 0x11),
    ++	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,     0x118),
    ++	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,   0x4117),
    ++	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,   0x2e),
      	{}
      };
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

