Return-Path: <stable+bounces-127448-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B963A797A6
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 23:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A7861665BC
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 21:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E491F1302;
	Wed,  2 Apr 2025 21:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfKleL8t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10B115DBC1
	for <stable@vger.kernel.org>; Wed,  2 Apr 2025 21:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743629139; cv=none; b=s2QLiiCHTnuwDqrQd6WQy7HkVWReYHLK1HQJH+8pxRab3egfAMTSQDpiaGG2pd4IgOZamVDvXkozOYE1j2c0Vuc1e8tRkImXitLX5xR3ivjAQPBFZ+HFTsNHCb3aC3Mx+1AJbWsZJEByukg/1vtPfxvJxJ/YN103EuRm7e/fnGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743629139; c=relaxed/simple;
	bh=g9yPL9GJESHa6KKFnwhBJMOd7PpbRRSGJB/wDVMkjLk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lx/AB3reNBSmUjylzBXZ1SQOKewmdK4O07gb5izYDk6TBaGxt+jE8t0uhiC7ZTROXVKHnAR+0QAjRuP1rdnj3c+cZqysBT7GAWILub8I3PXpP6MGNlW3nXqEd/eZjbIwHwQA3Ek/Y7zF2DAvQ3wGTmyItna/53OkQAcwrEP0gDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfKleL8t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F1DC4CEE8;
	Wed,  2 Apr 2025 21:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743629139;
	bh=g9yPL9GJESHa6KKFnwhBJMOd7PpbRRSGJB/wDVMkjLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TfKleL8tPuN8XqS4cTFEjZDRvoAqpESD6Q00RBDxgWnOjwKulrXVmuA/f7Kza+Fsf
	 yl77PP9kOqxybKQDjY3gFT7g09duNdPJQic/rkNZXHKXvRru0RC+6o4k3xdRR/CnnX
	 mqbMNzvQA0buVeQ8UC3T/IeAp1j0iBZnKKSCnoGSi3mY6xZ1fDnrYUQY+DhhbVqHkC
	 1/GE1guvP4KP/Kw588zmqgm6CEad4u8hwdMRiwvu0Vdrhq5MSN0yZogvJ3q3Nu1UUm
	 Qwykz8aNIUnq6Dn0z7u0uOHPeLSXRIeMLYOObHyI28Q5fEjN7TALcgYp3V/psuiDjk
	 9Zqhdq/jQRZow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kang Wenlin <wenlin.kang@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y 2/6] binfmt_elf: elf_bss no longer used by load_elf_binary()
Date: Wed,  2 Apr 2025 17:25:34 -0400
Message-Id: <20250402132211-05af6ba87eb27f02@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250402082656.4177277-3-wenlin.kang@windriver.com>
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

The upstream commit SHA1 provided is correct: 8ed2ef21ff564cf4a25c098ace510ee6513c9836

WARNING: Author mismatch between patch and upstream commit:
Backport author: Kang Wenlin<wenlin.kang@windriver.com>
Commit author: Kees Cook<keescook@chromium.org>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  8ed2ef21ff564 ! 1:  f18629afe7b56 binfmt_elf: elf_bss no longer used by load_elf_binary()
    @@ Metadata
      ## Commit message ##
         binfmt_elf: elf_bss no longer used by load_elf_binary()
     
    +    commit 8ed2ef21ff564cf4a25c098ace510ee6513c9836 upstream
    +
         With the BSS handled generically via the new filesz/memsz mismatch
         handling logic in elf_load(), elf_bss no longer needs to be tracked.
         Drop the variable.
    @@ Commit message
         Signed-off-by: Sebastian Ott <sebott@redhat.com>
         Link: https://lore.kernel.org/r/20230929032435.2391507-2-keescook@chromium.org
         Signed-off-by: Kees Cook <keescook@chromium.org>
    +    Signed-off-by: Wenlin Kang <wenlin.kang@windriver.com>
     
      ## fs/binfmt_elf.c ##
     @@ fs/binfmt_elf.c: static int load_elf_binary(struct linux_binprm *bprm)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

