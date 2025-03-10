Return-Path: <stable+bounces-121653-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C08A58A4F
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 03:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77C511889509
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 02:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB7117A2F0;
	Mon, 10 Mar 2025 02:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HyCQ3r0z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D032F156861
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 02:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741572884; cv=none; b=mr3+vb9GBrzVwoNCr/Feg+aAulB9NAxuPZxy+f9ugxzekAcUjqSH+GhE4AnrGjK60LGdkJD3PnOLISMlG6HnnNVZBF80rLkNSD9gMkwIh8UytMG6QCzDBHZncx91deq30tm1gvEtOfDNQ6vroXqpQFfrpCbPN1kbPsyQ6cxbtMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741572884; c=relaxed/simple;
	bh=w07AsMQz5+Orq2tTH5d5fiZg4NPHSEu2PwAcPNN++Wc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k87Qn4UgTPJcTCEMBI0iS+LWiU+/szFMkjhCwBb/j89k2sttXTgZNMceJcyLYeopyeUFGJu2EJ+o3dH3wI9v8SBhzxpTgRYMOj/L2eHF/4iN/xdDrZQUSKD7BtaRYQJxSRdDqpRmG4BfclumZYUT/n07hXnI6Es2guRHfN4W46A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HyCQ3r0z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A649C4CEE3;
	Mon, 10 Mar 2025 02:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741572884;
	bh=w07AsMQz5+Orq2tTH5d5fiZg4NPHSEu2PwAcPNN++Wc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HyCQ3r0z3dF2l+T93TaccyAHPxzD6452gbXBs33X4sVAtpOepDoMQp4raV9roljuN
	 3oIZFAl4a1C/LZm0R0wlSSZjH4o7Xe7M4zXSsXjoU7+RIK8adOKie07gonzzAhzS8x
	 B1Ydyqd8dfSq8T9/J7m/HMSP9Hyu6VkdN9IaCOlRZiviYb0UKY200efomu7I1NSoZ4
	 FVkXgv3f2zi6idhPiI098ymvVjn0ZxqGQnn7X7FGxLgrMAC24d2R1D/g5bZ+M/5inG
	 /Lo6xI66Ee1CGLWLxzfgdYjOadziPh1+FjqkpWOQN/qF2aJGA0qY09MNPkR7VGIfJe
	 XCBpnZuVUZmNw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12] x86/mm: Don't disable PCID when INVLPG has been fixed by microcode
Date: Sun,  9 Mar 2025 22:14:42 -0400
Message-Id: <20250309163044-5872633cfcbf83c1@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250307-clear-pcid-6-12-v1-1-7c7f826c0fd1@linux.intel.com>
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
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  f24f669d03f88 ! 1:  16821bbf9c8ed x86/mm: Don't disable PCID when INVLPG has been fixed by microcode
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
    +    [ pawan: backported to 6.12 ]
     
         Signed-off-by: Xi Ruoyao <xry111@xry111.site>
         Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
         Acked-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
    +    Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
         Link: https://lore.kernel.org/all/168436059559.404.13934972543631851306.tip-bot2@tip-bot2/
         Link: https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files/releases/tag/microcode-20240312
         Link: https://cdrdv2.intel.com/v1/dl/getContent/740518 # RPL042, rev. 13
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

