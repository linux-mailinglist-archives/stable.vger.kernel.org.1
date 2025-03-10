Return-Path: <stable+bounces-121654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3B9A58A50
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 03:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15EB518874F8
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 02:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5701F17A2F0;
	Mon, 10 Mar 2025 02:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7/GSFbV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145BB17A2E8
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 02:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741572887; cv=none; b=nb/nhehfXRwH5iUkA/tNcwsIw1IUa6dJMRYxdJNgSTEcgjDUNLEwLm+IehavXvcLO+kO/NlmkIfvjxXBYOPWnKxUARSzeb4a0HQR66T4jHhfPB0O938gM0nUC8QrwkDTSONQVbjz9ZrKcCjk0Q1r+MfDZvqsLp1MgMSIssW3pXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741572887; c=relaxed/simple;
	bh=jj9oW7qiHp/FZumrfBGFr/bavS96P/uqE7SE+tll7IA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RSCM3ZcLq59ozarryI2RmeOp2fU65ccUs08fxGQx1m98tHRxe0phLyj8h4wjO1M6139mylUDE4hI5nWCib0thWaj7wqsJRPDPACDPfXcDpk1VMnomgIqmj8kidwq7nIM6zniT9zBTMCU3LqEoyAR1BrHweCwVfkBmTXZYkw/Sqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7/GSFbV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FAAAC4CEE3;
	Mon, 10 Mar 2025 02:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741572886;
	bh=jj9oW7qiHp/FZumrfBGFr/bavS96P/uqE7SE+tll7IA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R7/GSFbVLCofVemrZHtUJkCaef5GpDrLVsRRaSpJ7ZFeGc2NaLTDPC5VN2sS+SXFV
	 icKR2JUSqToP9dFk9gdK4NiZVXtF+0ma6ZRuetWP09IbNLiaj6P4fuY2p5fYbTaGMg
	 9i/pq43p8KCRMcps7XqLVFNcAHM2xNGrNnAXcBoZOr2ECV/MBrtMjiWD1V5NWliz2l
	 gsyXNUSfh3fMrnTnbWPFB7fu28Hmn/JAsw1VQebafOn6aDA1emeOXXDdrXn/dvQtqn
	 wdDycBAzWU+cvIf8yHrfcciy///vG6IC+/N6S2y5MGQbbdAFAYhOHsRLlMg12CXoRk
	 Kg+W8+KRChGbA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15] x86/mm: Don't disable PCID when INVLPG has been fixed by microcode
Date: Sun,  9 Mar 2025 22:14:45 -0400
Message-Id: <20250309202241-e1c98fb312fad481@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250307-clear-pcid-5-15-v1-1-f20bafd8c5e4@linux.intel.com>
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
5.4.y | Not found

Note: The patch differs from the upstream commit:
---
1:  f24f669d03f88 ! 1:  2a5f1018995c6 x86/mm: Don't disable PCID when INVLPG has been fixed by microcode
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
    +    [ pawan: backported to 5.15
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
| stable/linux-5.15.y       |  Success    |  Success   |

