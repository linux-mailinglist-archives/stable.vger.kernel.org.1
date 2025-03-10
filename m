Return-Path: <stable+bounces-121648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4E7A58A4A
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 03:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1748B3A8A64
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 02:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEEB18FC74;
	Mon, 10 Mar 2025 02:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NlV5wxuz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E70A17A2F0
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 02:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741572874; cv=none; b=sLW0nnMjCsOrTK8ZPqlYUcndxXqJv90XfJEba9FsCspJCZQ0zhrn/YB19pUXxMbnOSyKrB40yBET0UdjzPi7+QsC5MY8FM+8sTVuEak1uMLYht8/PbA1oFvWMC9qD4fG4Y0c9q2WiSxpcQLQUuqXUDe5ghdye4T2Nqz0mQuQ3Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741572874; c=relaxed/simple;
	bh=+Qhd7LZ4uOVpEVjEu7m1uXa4+mItjQ1lsS6fp1GV+VQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kwqGhLz7o3I2iUWujL++SXAbzkEaccDZEjephSIRUa6LL+A7pWrarS6KE7fTJ2vNqSQ/WnKqe6Ic9i2dlBvOxFL3dY619CDWCqNqhO29RZqj6NK67SFjyXe1OislH1ZGXd3VJdEi2nQ/1aMQPIwKwIXJ6TWDy7B6zQo/nzsDYGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NlV5wxuz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF17C4CEE3;
	Mon, 10 Mar 2025 02:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741572874;
	bh=+Qhd7LZ4uOVpEVjEu7m1uXa4+mItjQ1lsS6fp1GV+VQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NlV5wxuze+cAmZX5FBIVZe0FQcy96w34xlKkqNplj7MiRVIbfG0HobpLTwt+q+jSe
	 f3KrmXfPLXF72xxMHS+7F4cGTHinKalTztQTSiqukcaN2ANrPOYQSTxXtWbdKEJa95
	 B7fZGo2iOW9sh3e1sCCoRtp/rmdPBCwne3DALqM1NKH02OcDF/ddSV0hxxBcQCweJd
	 MfIYFbK6AoA6r6qtmnhKIV5zQRTnIGPHE5K/5cw5//ncC2rOG126j4ianlffs/0oGP
	 OHYpXVlTpc0qYTeaXaTAlyhRq1POlIar6QFb2oF+bpZ6nbj/iVbuszvqr7yH9nY+oV
	 8tXlQHbIiLy4w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] x86/mm: Don't disable PCID when INVLPG has been fixed by microcode
Date: Sun,  9 Mar 2025 22:14:32 -0400
Message-Id: <20250309203920-ea8794737a065644@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250307-clear-pcid-6-1-v1-1-2cbbd0aa3150@linux.intel.com>
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

Note: The patch differs from the upstream commit:
---
1:  f24f669d03f88 ! 1:  52d35a0a69a69 x86/mm: Don't disable PCID when INVLPG has been fixed by microcode
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
    +    [ pawan: backported to 6.1
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
| stable/linux-6.1.y        |  Success    |  Success   |

