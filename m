Return-Path: <stable+bounces-151961-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 708AEAD16D2
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 04:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83AB17A42CE
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 02:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1ECB2451F0;
	Mon,  9 Jun 2025 02:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGDiKpI/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8214E157A67
	for <stable@vger.kernel.org>; Mon,  9 Jun 2025 02:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749436451; cv=none; b=GShS/pAW7tA55sX5L3Km8kSz7b30qjAG8vdGDpw3tDzgQvLGif9xT8rMMWo/TwJl1t/Z9VEOKPr5PiHae/FcZgGKT5bbgdy1EYsatL7Mko9557Ktcq17Bye6xXEzrf8jRLij1YTV+3xLbTlTZQoMHyuOt4Bld8GnQuQdYt86K64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749436451; c=relaxed/simple;
	bh=hm+xeYUlSDfPyTQkMD9quFTXeoKQvTg8lgnt7ZPVGxk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tKc8Kxl6we0BLtnFxCB/PJyHBvDpaqlzEtkAkN/D3dVyTWFju5XwClptVfctRqBnLZtdarl2zNZxL6XzXcR2ePaY7vLWN4ZYAdq7ai1TmtlPizjaqIsXQuxa38aPQqSRTjRKCgAwVZQ5QhZYuwbROpVIYd1P22YD1QvLYl92S1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGDiKpI/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD34C4CEEE;
	Mon,  9 Jun 2025 02:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749436451;
	bh=hm+xeYUlSDfPyTQkMD9quFTXeoKQvTg8lgnt7ZPVGxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cGDiKpI/rbKNt4IewOwjWTb4/4bGZdmRSgqa99LojYTu47iPnpu8vhroG6kfb6aFN
	 y6s2CF+Ir/LJsnlOTO5TvBX9J12hlT5kbpyZAC3z9AOb9Ky5HuU8tsSRnbokFYEQcc
	 Uj+fSNXnee23lJOnHiON31NON+QkU7UO+Y3czEwN98b1Usi55oJfXnLCwTCwunTx29
	 2E1KytZgy8SnbCD32tmK3Mbfkm1QGKBAPP710iuccko2OyOXq8xGzeL7OfhAYUz+Sb
	 c6uqwXr8i3sM1yWbHhzoJILw5cnHfZ1G2K7FLgzir79otArl1Cof+FnqCn47o+r+hy
	 iAVpHihci6UkQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pu Lehui <pulehui@huaweicloud.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 11/14] arm64: spectre: increase parameters that can be used to turn off bhb mitigation individually
Date: Sun,  8 Jun 2025 22:34:08 -0400
Message-Id: <20250608195655-056c0568b54ff326@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250607152521.2828291-12-pulehui@huaweicloud.com>
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

The upstream commit SHA1 provided is correct: 877ace9eab7de032f954533afd5d1ecd0cf62eaf

WARNING: Author mismatch between patch and upstream commit:
Backport author: Pu Lehui<pulehui@huaweicloud.com>
Commit author: Liu Song<liusong@linux.alibaba.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  877ace9eab7de ! 1:  02dd583c7ea39 arm64: spectre: increase parameters that can be used to turn off bhb mitigation individually
    @@ Metadata
      ## Commit message ##
         arm64: spectre: increase parameters that can be used to turn off bhb mitigation individually
     
    +    [ Upstream commit 877ace9eab7de032f954533afd5d1ecd0cf62eaf ]
    +
         In our environment, it was found that the mitigation BHB has a great
         impact on the benchmark performance. For example, in the lmbench test,
         the "process fork && exit" test performance drops by 20%.
    @@ Commit message
         Acked-by: Catalin Marinas <catalin.marinas@arm.com>
         Link: https://lore.kernel.org/r/1661514050-22263-1-git-send-email-liusong@linux.alibaba.com
         Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
    +    Signed-off-by: Pu Lehui <pulehui@huawei.com>
     
      ## Documentation/admin-guide/kernel-parameters.txt ##
     @@
    - 					       spectre_v2_user=off [X86]
      					       spec_store_bypass_disable=off [X86,PPC]
    + 					       spectre_v2_user=off [X86]
      					       ssbd=force-off [ARM64]
     +					       nospectre_bhb [ARM64]
    - 					       l1tf=off [X86]
    - 					       mds=off [X86]
      					       tsx_async_abort=off [X86]
    + 
    + 				Exceptions:
     @@
      			vulnerability. System may allow data leaks with this
      			option.
      
    -+	nospectre_bhb	[ARM64] Disable all mitigations for Spectre-BHB (branch
    ++	nospectre_bhb   [ARM64] Disable all mitigations for Spectre-BHB (branch
     +			history injection) vulnerability. System may allow data leaks
     +			with this option.
     +
    @@ Documentation/admin-guide/kernel-parameters.txt
      
     
      ## arch/arm64/kernel/proton-pack.c ##
    -@@ arch/arm64/kernel/proton-pack.c: static void this_cpu_set_vectors(enum arm64_bp_harden_el1_vectors slot)
    - 	isb();
    - }
    +@@ arch/arm64/kernel/proton-pack.c: static void kvm_setup_bhb_slot(const char *hyp_vecs_start) { }
    + #endif /* CONFIG_KVM */
      
    + static bool spectre_bhb_fw_mitigated;
     +static bool __read_mostly __nospectre_bhb;
     +static int __init parse_spectre_bhb_param(char *str)
     +{
    @@ arch/arm64/kernel/proton-pack.c: static void this_cpu_set_vectors(enum arm64_bp_
     +	return 0;
     +}
     +early_param("nospectre_bhb", parse_spectre_bhb_param);
    -+
    + 
      void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *entry)
      {
    - 	bp_hardening_cb_t cpu_cb;
     @@ arch/arm64/kernel/proton-pack.c: void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *entry)
      		/* No point mitigating Spectre-BHB alone. */
      	} else if (!IS_ENABLED(CONFIG_MITIGATE_SPECTRE_BRANCH_HISTORY)) {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

