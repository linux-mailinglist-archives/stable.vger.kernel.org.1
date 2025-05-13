Return-Path: <stable+bounces-144243-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D319AB5CC4
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 20:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E21A64C094F
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E55748F;
	Tue, 13 May 2025 18:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XL+pB/k0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F5F1E521A
	for <stable@vger.kernel.org>; Tue, 13 May 2025 18:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747162200; cv=none; b=seGOZ0VFxkEX4YBATg3lY1b+vvbKu1ZCBGxZjBLECPmaRoTTPpgXuOXCa2XmftDBgX7XXyZuvMFFxOQFKTSLIPA8QkbBH6S+EPbZqYNQS+dTet0Xiby/0WycSR8ZsKYMSqc1ttkc5Xtaaejh2rL4Qq+8ZCkkUcUFAQt1GTk0juc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747162200; c=relaxed/simple;
	bh=A+SKe/wktFdjlVFY3lqcuQ4gmBK7AZ+AYPYxtTLe+FM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SxPbju6wQwJwpuQJcOFbOtC/p0CUUJa087zr/jCmeM2i1dl4bbVxQWxpm1t5zUR8gaYhs5/o2ap8q8wR/RkvjyDQbCRHY8qjt2qkmfyCFfd9GilHnauyrakJ5vOKD32q2YnN/cM3B0ndGoypvPSQ+VCsAc5aGmDlNNbgD8Q8FZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XL+pB/k0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F674C4CEE4;
	Tue, 13 May 2025 18:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747162199;
	bh=A+SKe/wktFdjlVFY3lqcuQ4gmBK7AZ+AYPYxtTLe+FM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XL+pB/k0bRMghPdyi5vXUxVKbPGfCTt/WBtiFKnOGixNer2P8+Ceu42X9wf9idNta
	 few+2yFELTqe7RhS6ypUP3TW4mGXDe3P4zR5/f07ZYsx7+G6qUezqFaW4myNaiP8Qm
	 zkxeYgt11+dGoxh6CTf1xhyFACU9mO1iiZNDo+y12EGzzphVCod8Vr5lK4erskoNz6
	 CIcj0zfymJvg5NRQAQxCqUXoLP5pd/o/88LK3hYzoLY1RBkb9IjdNqcVsXd3Tn8HLn
	 86JZ+w9sXs1YL2lQHvYEdt+Var6+SQhqSQ6LWOB/NH+MkUU6hHJZXTAyQ0FngzZrqC
	 7MY7H0WIAHuVA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	chenhuacai@loongson.cn
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH for 6.1/6.6] LoongArch: Explicitly specify code model in Makefile
Date: Tue, 13 May 2025 14:49:55 -0400
Message-Id: <20250513113647-90f20a5797414ec0@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250513080645.252607-1-chenhuacai@loongson.cn>
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
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: e67e0eb6a98b261caf45048f9eb95fd7609289c0

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 7b3a7918f10d)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  e67e0eb6a98b2 ! 1:  fa2ca06c43c1a LoongArch: Explicitly specify code model in Makefile
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

