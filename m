Return-Path: <stable+bounces-151969-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 833E6AD16DA
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 04:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79F863AA95B
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 02:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75EC2459C7;
	Mon,  9 Jun 2025 02:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4Pel6LQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770F5157A67
	for <stable@vger.kernel.org>; Mon,  9 Jun 2025 02:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749436468; cv=none; b=mH4TZoq5EQb7irp330mA/IGLf0oV5Yc5YdQVzwPSqjeFgJ2Afo4SM4yCX+BgojIpJSsJNle0DShh9Vks9Y4NmmW3MTYYh1b6YvFNSoNCgK5LQng3DxaFEbL+isjsidtnccuL1RhQheafqQ9eEjiz9qFr/Fvp16eRZRatUC61bA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749436468; c=relaxed/simple;
	bh=kWpToJkevkpyq8AEZNWDZUFR3p58m/Vfindwb4uZ6z8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OkwEGQSHKe6LbFkRvTIkq5QZym6LwiAf3KDujOVThYizTTQlKBzJh3F41ClgSgNXGgsRVAgxE3Jgzftg09vqQ0ayLmbxbQNDLzxmyz8TxLOxBXh3QdENzM4OhcFSy6CzdshOcF8uOCb2omRhMU+753RvU7tgCwagJyqCgcC0Fuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4Pel6LQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D16FAC4CEEE;
	Mon,  9 Jun 2025 02:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749436468;
	bh=kWpToJkevkpyq8AEZNWDZUFR3p58m/Vfindwb4uZ6z8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R4Pel6LQ83geiSVWMUx9GsWaBvhHhq4Aj9Eazh14znzv3qKJJY2Mi2WrIPkrcOlc4
	 IJQrfPJVt7Zc8Y5Xjcg/kjwrw4nIPTRd7wVUQ1LTFMzVGjguBao8/dxSHKXwW2TE8y
	 0jy0bi+jWhcHhhlDFEFIq9yw7/zrb7q69WC/rtHV27F7bYyfWz485OWVAIpbe9AoZI
	 HASbMpBsDL4kFh60DWlqhagkPDvoZaqdnBp4a1mtwYPNlIB9AMChK+yk2EHoeOVDDs
	 K7vB1ANzwABXkfJwtZCCBRfWwdVtre4awQ7rK2wvHuAgM+dx8X6DeVRafGbcbDiSvo
	 87+O32i8dkHVQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pu Lehui <pulehui@huaweicloud.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 6/9] arm64: spectre: increase parameters that can be used to turn off bhb mitigation individually
Date: Sun,  8 Jun 2025 22:34:26 -0400
Message-Id: <20250608163029-e6a3c61f2f4dad77@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250607153535.3613861-7-pulehui@huaweicloud.com>
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

Note: The patch differs from the upstream commit:
---
1:  877ace9eab7de ! 1:  8c7e23e93b2d7 arm64: spectre: increase parameters that can be used to turn off bhb mitigation individually
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
    + 					       spectre_bhi=off [X86]
      					       spectre_v2_user=off [X86]
    - 					       spec_store_bypass_disable=off [X86,PPC]
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
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

