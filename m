Return-Path: <stable+bounces-99973-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B529E76CA
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 18:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC0571884D6C
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 17:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F5D1E1A05;
	Fri,  6 Dec 2024 17:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7lPubCd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5E5206274
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 17:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733505110; cv=none; b=XM8487J+V6sb0cuY8sriqAMFC/HHmrdmfS3clleSAn8tuR3OP9JoStbROD1y3TL+Nwf5ia7ZmmQjFVgeGJG32HmZG0HpL4lHZgrKgbD87nZisbKjXd6E/VyRYPfxG9/1K1oyzJb6/QeLMCRfW08xrWhswnhxrinrN0nx4BaDIpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733505110; c=relaxed/simple;
	bh=70Sua4ycBW9CXoYdsrFc6zjEjo4sYr9GQ1Kcv1N7h0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FCXDWkao3NVkixFqSRAnG+Cgh4nED/y3zgz+qwD5+Sn4H6v8Z3SnFAi/+XCtBzngzdPmvW0TZj7vCcvKiNOLX2LObCX4ZcDKBIU1+emL004QEXl4AN1d9gJkZLXD2QA2oEdyE57XglLjLDnGRfz2Gk3IUp9N7s+ctEUSUgvde+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7lPubCd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32EEEC4CED1;
	Fri,  6 Dec 2024 17:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733505110;
	bh=70Sua4ycBW9CXoYdsrFc6zjEjo4sYr9GQ1Kcv1N7h0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S7lPubCdOv+YDOb8raxquNIJeWGVCnOAQxnBNb1XUbsZakvvpER2zgnn8Tgr7f8Ae
	 JYlD13geCW3rHJeS75DIStjZClOFBsgM8v1CS6MMbWsyjFH/smqRe/QJFN5g2+wmT0
	 J1S7sLCOLydasENxUCIjQN9LPzxvGLn90hRYJ9lCbWeO6bTAqCNm4GAYqUj/LzrgbA
	 jEjF1ttAmdQ04RWipe/CmX/xX9Dv+Nk0u7u5+Rele2Rl5d86eOKz7DwJ73RwtIE/Hu
	 R+Rj0OwBxrAlpcK3mRbGoCO7dCYfeROUznJQRuGtfkXcHUVTiHtAuIfeqtYJR0WcKt
	 SBB2lySXyrUNA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1&6.6 3/3] btf: Avoid weak external references
Date: Fri,  6 Dec 2024 12:11:49 -0500
Message-ID: <20241206110919-ebe1c8e70462f06a@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241206085810.112341-4-chenhuacai@loongson.cn>
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

The upstream commit SHA1 provided is correct: fc5eb4a84e4c063e75a6a6e92308e9533c0f19b5

WARNING: Author mismatch between patch and upstream commit:
Backport author: Huacai Chen <chenhuacai@loongson.cn>
Commit author: Ard Biesheuvel <ardb@kernel.org>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  fc5eb4a84e4c0 ! 1:  0637e4a3f4e0a btf: Avoid weak external references
    @@ Metadata
      ## Commit message ##
         btf: Avoid weak external references
     
    +    [ Upstream commit fc5eb4a84e4c063e75a6a6e92308e9533c0f19b5 ]
    +
         If the BTF code is enabled in the build configuration, the start/stop
         BTF markers are guaranteed to exist. Only when CONFIG_DEBUG_INFO_BTF=n,
         the references in btf_parse_vmlinux() will remain unsatisfied, relying
    @@ Commit message
         Acked-by: Arnd Bergmann <arnd@arndb.de>
         Acked-by: Jiri Olsa <jolsa@kernel.org>
         Link: https://lore.kernel.org/bpf/20240415162041.2491523-8-ardb+git@google.com
    +    Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
     
      ## kernel/bpf/btf.c ##
     @@ kernel/bpf/btf.c: static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Success   |

