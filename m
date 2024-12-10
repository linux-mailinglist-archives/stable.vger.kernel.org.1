Return-Path: <stable+bounces-100475-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B5D9EBA13
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 20:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD1CB16787A
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 19:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AA422617E;
	Tue, 10 Dec 2024 19:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tz+AYeEQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164EE23ED63
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 19:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733858698; cv=none; b=f45xZ4PWgh2pbHEE5oQidzduASCJSIs8dK7ZKVNBKZKMG4Ty7LnSjk4jGS1fq+q5J3ZuwMFQ1FHdyQmHZs1V1b4SFfuv6ROpuZ2eDOb0NfR57pJjl7rDOCnIVR6Ddgxpfy4ZKrQNg+N4UYdk62pnvCFNX9wS+KaCv+3qGeZmEK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733858698; c=relaxed/simple;
	bh=LVG0GB/bbwgx5lloKjny97FoWlyoWkEBFLnkctWLm7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M+fjN4hs5yo56whyQb2DEQuDN7wOrN8OfdTgBSWbACWp8T3O3rkASszTiUpIn2uqmQXz0Y/K+K49AOSrlNVad0YjQFaYmgE8mw8Nnnq4OP7VYpaOAF/P+7da8luA5GByKc5ahMlQzCsg9IU3/aJKXJvCzbEP2PAdbj/K1LfmlTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tz+AYeEQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED5BC4CED6;
	Tue, 10 Dec 2024 19:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733858697;
	bh=LVG0GB/bbwgx5lloKjny97FoWlyoWkEBFLnkctWLm7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tz+AYeEQh38B4VycdkNy8xs2wmkw3RXlOhSHxZFRn684xU7A8M7LycS/XOFv6XB/p
	 dK5fM8o7nU0hkMnMOms9DuvydR+FUcgnVRen/3ZDA9PaOw7lb8Bj4Uuigt606/c9pA
	 kFRnG0tVKryQKLRDgWDZVkm14uhIcs1Ujt+uzHVOWP9T3bS+7L730Md1crkx+0PlOX
	 XZbSvTaFyH/wRZp8QiQhB8BDwubm1rzUn+GkjjN0pKxmZEEEC34mxc1vkkI2Dugj2J
	 MofHKhptU/am0xUD4snzWlYpygsx1lc7sat/JPq3x6oPhtFaFw8017QwlNnbSus7/L
	 matXjjfh/I3IQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Robin Murphy <robin.murphy@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] iommu/arm-smmu: Defer probe of clients after smmu device bound
Date: Tue, 10 Dec 2024 14:24:55 -0500
Message-ID: <20241210140712-319ff66848c6cb4b@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <acd8068372673fb881aa9e13531470669c985519.1733834302.git.robin.murphy@arm.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 229e6ee43d2a160a1592b83aad620d6027084aad

WARNING: Author mismatch between patch and upstream commit:
Backport author: Robin Murphy <robin.murphy@arm.com>
Commit author: Pratyush Brahma <quic_pbrahma@quicinc.com>


Status in newer kernel trees:
6.12.y | Present (different SHA1: 5018696b19bc)
6.6.y | Present (different SHA1: fe9d9839a755)

Note: The patch differs from the upstream commit:
---
1:  229e6ee43d2a1 ! 1:  a937416dbd5d3 iommu/arm-smmu: Defer probe of clients after smmu device bound
    @@ Metadata
      ## Commit message ##
         iommu/arm-smmu: Defer probe of clients after smmu device bound
     
    +    [ Upstream commit 229e6ee43d2a160a1592b83aad620d6027084aad ]
    +
         Null pointer dereference occurs due to a race between smmu
         driver probe and client driver probe, when of_dma_configure()
         for client is called after the iommu_device_register() for smmu driver
    @@ Commit message
         until the smmu device has bound to the arm smmu driver.
     
         Fixes: 021bb8420d44 ("iommu/arm-smmu: Wire up generic configuration support")
    -    Cc: stable@vger.kernel.org
    +    Cc: stable@vger.kernel.org # 6.6
         Co-developed-by: Prakash Gupta <quic_guptap@quicinc.com>
         Signed-off-by: Prakash Gupta <quic_guptap@quicinc.com>
         Signed-off-by: Pratyush Brahma <quic_pbrahma@quicinc.com>
         Link: https://lore.kernel.org/r/20241004090428.2035-1-quic_pbrahma@quicinc.com
         [will: Add comment]
         Signed-off-by: Will Deacon <will@kernel.org>
    +    [rm: backport for context conflict prior to 6.8]
    +    Signed-off-by: Robin Murphy <robin.murphy@arm.com>
     
      ## drivers/iommu/arm/arm-smmu/arm-smmu.c ##
     @@ drivers/iommu/arm/arm-smmu/arm-smmu.c: static struct iommu_device *arm_smmu_probe_device(struct device *dev)
      			goto out_free;
    - 	} else {
    + 	} else if (fwspec && fwspec->ops == &arm_smmu_ops) {
      		smmu = arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
     +
     +		/*
    @@ drivers/iommu/arm/arm-smmu/arm-smmu.c: static struct iommu_device *arm_smmu_prob
     +		if (!smmu)
     +			return ERR_PTR(dev_err_probe(dev, -EPROBE_DEFER,
     +						"smmu dev has not bound yet\n"));
    + 	} else {
    + 		return ERR_PTR(-ENODEV);
      	}
    - 
    - 	ret = -EINVAL;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

