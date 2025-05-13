Return-Path: <stable+bounces-144229-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CE7AB5CB1
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 20:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D6C5867785
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7B32BEC3F;
	Tue, 13 May 2025 18:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvGuxWuN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497BC1B3950
	for <stable@vger.kernel.org>; Tue, 13 May 2025 18:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747162141; cv=none; b=guSw41br6UBpl7nAXa6Mf0bqtt7xZqCxNdPpDdzasBMnDaDtU6Zb2ivEDAPqlqf3SzzCnnrXQ+wzSv2me9bZZjUj+CCOj6ziZeQcOXQDEmu7ueJ7tGKcRcLeOXd+nhJjMsukY0f4tGyi64lshNMdC8Ab1DSOdwPqT5BugGDJ9uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747162141; c=relaxed/simple;
	bh=AO7LiyfTufg0tRBc7fyelNcRfFrv+wCw9ZJCYGf3gSc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kTj/TrTaYma5bAj7PfNbTo8EyZ7VmKyo20U0PntmysppVLTzEEQzmsVKZ6pmnT+WtrcWhqCqiPE1EWn3fcVTb6QIfwweHvjB3fHB4oFq2/xG4t+CkGflj5nujzC4qloJ+egghPbLvjQV86+SsD2Itm6+Ya0784EvFGB4lkKZZaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvGuxWuN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B57E8C4CEE4;
	Tue, 13 May 2025 18:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747162141;
	bh=AO7LiyfTufg0tRBc7fyelNcRfFrv+wCw9ZJCYGf3gSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cvGuxWuNz5OPN5+ITgtHBYVHzZcMJSPnNG2+vqDk8yIRoiSgGYXfBp1NIvAi444M2
	 fwsASP3STw2CIxL1XRXcrcGWrSvqcLaLozvLALOltg/CHQz9NrooSFOl3AKpNDQD+Q
	 IuFi5WuoejW7tqd8albcr9GvHf2U5EBkSG98qaHOOE49ZItpp1cgeVk7+6fJGpEclD
	 uvveroA7gLwa7kzq5KdcQIEteCT4C0cDsSzjJ2+bMEhlyek4BVPN2kvHeTzprRnBfq
	 nr1dJaoBVdNfMqXjupW10dWvQdsVp4v2qR+IxPHYTH86CKsG+utspwu7083Zq7Zt4x
	 U+AxN1iMkZ1hg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH V2 for 6.1/6.6] LoongArch: Explicitly specify code model in Makefile
Date: Tue, 13 May 2025 14:48:57 -0400
Message-Id: <20250513075741-480595720f391d9a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250513081321.252766-1-chenhuacai@loongson.cn>
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

The upstream commit SHA1 provided is correct: e67e0eb6a98b261caf45048f9eb95fd7609289c0

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 7b3a7918f10d)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  e67e0eb6a98b2 ! 1:  5d0dbec0340e9 LoongArch: Explicitly specify code model in Makefile
    @@ Metadata
      ## Commit message ##
         LoongArch: Explicitly specify code model in Makefile
     
    +    commit e67e0eb6a98b261caf45048f9eb95fd7609289c0 upstream.
    +
         LoongArch's toolchain may change the default code model from normal to
         medium. This is unnecessary for kernel, and generates some relocations
         which cannot be handled by the module loader. So explicitly specify the
    @@ arch/loongarch/Makefile: endif
     +cflags-y		+= -mabi=lp64s -mcmodel=normal
      endif
      
    - cflags-y			+= -pipe $(CC_FLAGS_NO_FPU)
    -@@ arch/loongarch/Makefile: ifdef CONFIG_OBJTOOL
    - KBUILD_CFLAGS			+= -fno-jump-tables
    - endif
    - 
    --KBUILD_RUSTFLAGS		+= --target=loongarch64-unknown-none-softfloat
    -+KBUILD_RUSTFLAGS		+= --target=loongarch64-unknown-none-softfloat -Ccode-model=small
    - KBUILD_RUSTFLAGS_KERNEL		+= -Zdirect-access-external-data=yes
    - KBUILD_RUSTFLAGS_MODULE		+= -Zdirect-access-external-data=no
    - 
    + cflags-y			+= -pipe -msoft-float
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-6.6.y        |  Success    |  Success   |

