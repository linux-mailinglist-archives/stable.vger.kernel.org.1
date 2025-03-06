Return-Path: <stable+bounces-121303-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B59F8A55638
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 20:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB55E3AA75F
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 19:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B181F26D5C3;
	Thu,  6 Mar 2025 19:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5iiuh1Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7291025A652
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 19:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741288275; cv=none; b=qd/wTNa/QnditHhbFvl0cgkDl3E4OL6lPkCAzhxHUPpqX7N13gzeOlEfdD/U/Z2JBi9byL8rkDOIzOx1c0A36GARxZmJAb8jWGloGnLWEy/qil3uRvpYmbeWWdJKsXw2pQrdFhRC9iF357M45sAoNcwNJYvaZcFBgBQ0RTFb90M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741288275; c=relaxed/simple;
	bh=wGjntAuMnq0DeZMD5g/fuW6wGsEnoK2JjoyFg7pwcmw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lGLSVJ06J8WfNudcBckT5oRYew/IHbW/hxW2NzyIyU2veG95p49pK47rp8OdcVNGZbarNlKgb1uMoYmAqOACZf8k2vDLn+yI12XRQ0EaskA8PUwkG0zxzlVDyUGWKKNiQcm+T2fYnjKt4BCaYKhdHLGBG/jyi7z0OjIVJ5rG7rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5iiuh1Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DECFC4CEE0;
	Thu,  6 Mar 2025 19:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741288273;
	bh=wGjntAuMnq0DeZMD5g/fuW6wGsEnoK2JjoyFg7pwcmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I5iiuh1Ya3GCHXwYQ2ZEwgNvFUiLq0QRhutMWj6EuBuY2cWHsUEiUeEEBbm91moP1
	 BrcHcnCvuNW83iN67vjEMEtghLIp5s19PspECbRmUB9/7Xanlm+2UqW1VEeR21r/tC
	 t9gFMmyP8St63o6pXQzCCSuyLGgeAM9mgl4e9jhOcvEylL1pKrmjoEV2cmuOJ7VDoK
	 qQBr1eLNQflsaZ58vdJq5VrNwChERzbsGPdNObZJW8ZKDl3c/cdBvGwcG6yF42Dmap
	 +/gK8QfUBOF5qDKE04KP2S2mPxn6B8KvuWQqc/lppzOl+paoWKh7MRkhkAdqmPLVAa
	 iRnnzwExEi4RQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	pbonzini@redhat.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12] KVM: e500: always restore irqs
Date: Thu,  6 Mar 2025 14:11:12 -0500
Message-Id: <20250306113002-205fba433e36aa27@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250305144938.212918-1-pbonzini@redhat.com>
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

The upstream commit SHA1 provided is correct: 87ecfdbc699cc95fac73291b52650283ddcf929d

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.6.y | Present (different SHA1: b9d93eda1214)

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly.
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Failed     |  N/A       |

Build Errors:
Patch failed to apply on stable/linux-6.12.y. Reject:

diff a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c	(rejected hunks)
@@ -481,7 +481,6 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 		if (pte_present(pte)) {
 			wimg = (pte_val(pte) >> PTE_WIMGE_SHIFT) &
 				MAS2_WIMGE_MASK;
-			local_irq_restore(flags);
 		} else {
 			local_irq_restore(flags);
 			pr_err_ratelimited("%s: pte not present: gfn %lx,pfn %lx\n",
@@ -490,8 +489,9 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 			goto out;
 		}
 	}
+	local_irq_restore(flags);
+
 	kvmppc_e500_ref_setup(ref, gtlbe, pfn, wimg);
-
 	kvmppc_e500_setup_stlbe(&vcpu_e500->vcpu, gtlbe, tsize,
 				ref, gvaddr, stlbe);
 

