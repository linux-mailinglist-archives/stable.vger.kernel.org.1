Return-Path: <stable+bounces-125778-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44701A6C17E
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 18:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF4563B7652
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 17:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE91224B1C;
	Fri, 21 Mar 2025 17:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DsxKlsmT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22031BF33F
	for <stable@vger.kernel.org>; Fri, 21 Mar 2025 17:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742578160; cv=none; b=hjz9Et0fuotVo6jeOR+4wRwiHxs/W/7MOxUeVUJ86nDQW6Vzfyx9bCg1QhWIq7s99PtwG8bt2R4GaeyaI04061uEDwYUTkKvzZDzlHyDNGLu79feBiyHebiMW1muEZCmaAu4gdeEUssOMDxRYtnVoEUD+N8vGE2LZBcZricS4ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742578160; c=relaxed/simple;
	bh=RSFsp8CTRiASILWOZ1JBcOCtcismSuwkEGplnMmta5c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AsQWvtPAhmkYJ+z2oo0cFjW307FZ5H85W+Ur5eSyVd0+PNzHpgvzncthWPkQ8xO254K52fVaGWbiGnrjLRR34r4bI54fYFL8L96nOPE/I8Xx49hhFoS0MXed6EdWqOcjmICQ2znmdTp+Quqyp7p0LHALUeE2cnVupX/6vL2ZMFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DsxKlsmT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E12C4CEE3;
	Fri, 21 Mar 2025 17:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742578160;
	bh=RSFsp8CTRiASILWOZ1JBcOCtcismSuwkEGplnMmta5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DsxKlsmTrHR6rcvHZxtat3bn7ORqDODe2qnTmM1u47YyEgnyJA8fsx3ERi3qzSkZR
	 49zrYJ/+G25mhol61LP0Rc/CTgoAouwW5X6BzX3xufA8tVLJGghhap8jwXUI4RGSji
	 fLjdZKEvwGM2nt31f30OHs/Hp9eLIII5YjakSMn4THeL6oJ4eRq3tQ+Tf6Z6wgUJQT
	 OP8X2iF/XeN2RFx2XrJJk7k07VNARf7zEr+BieKdINKe7GnUVo4V5m5wEt1yrAqxin
	 iGRZ9HP1LDDL3ReLtVviGLALNtvEcwN+7b+ZE3bs6JPsQ9xkOHpkWm3gW9ArlDCMRZ
	 Nc0/DKhpOc63g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.13 v2 7/8] KVM: arm64: Mark some header functions as inline
Date: Fri, 21 Mar 2025 13:29:08 -0400
Message-Id: <20250321131628-81d2301ef95ac73b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250321-stable-sve-6-13-v2-7-3150e3370c40@kernel.org>
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

The upstream commit SHA1 provided is correct: f9dd00de1e53a47763dfad601635d18542c3836d

WARNING: Author mismatch between patch and upstream commit:
Backport author: Mark Brown<broonie@kernel.org>
Commit author: Mark Rutland<mark.rutland@arm.com>

Note: The patch differs from the upstream commit:
---
1:  f9dd00de1e53a ! 1:  d5176938804c0 KVM: arm64: Mark some header functions as inline
    @@ Metadata
      ## Commit message ##
         KVM: arm64: Mark some header functions as inline
     
    +    [ Upstream commit f9dd00de1e53a47763dfad601635d18542c3836d ]
    +
         The shared hyp switch header has a number of static functions which
         might not be used by all files that include the header, and when unused
         they will provoke compiler warnings, e.g.
    @@ Commit message
         Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
         Link: https://lore.kernel.org/r/20250210195226.1215254-8-mark.rutland@arm.com
         Signed-off-by: Marc Zyngier <maz@kernel.org>
    +    Signed-off-by: Mark Brown <broonie@kernel.org>
     
      ## arch/arm64/kvm/hyp/include/hyp/switch.h ##
     @@ arch/arm64/kvm/hyp/include/hyp/switch.h: static inline bool __populate_fault_info(struct kvm_vcpu *vcpu)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

