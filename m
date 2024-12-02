Return-Path: <stable+bounces-96057-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 359699E04DD
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 15:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFD76285545
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 14:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3EE20371E;
	Mon,  2 Dec 2024 14:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uA+lRXfh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02881FECB5
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 14:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149621; cv=none; b=IAljcW1T07ylXohhbu8OhZ4dCUOngp8vuGiY05eguYQC2iY4G5eKR8mD6NzvooaLw2t++pwub84BuJ1QzdZke94U+hxG/efLlWB2AtV+TL6GGn5iFSP3S8+YUJDZrWIVzg1Tmc8tI8ipurt2oBPdaX1eKLZhMQeVZZdWDaDcYjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149621; c=relaxed/simple;
	bh=lEsVEKZTYkIugE5ghsY3OVSQZ8ghNrKv/MEVjOLvjMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IsLUzWr528e3bmMK1KL3gakD2YFDOyFAuu2fqEqoYPt9eS/4SpCd29Cxg9j7OVa63VvYqUxfc2q87DxL283X4Emi8vhifcO6GN/s50Hgld73GE79Kkj4eySnwS3xNN7BJanAyGtay+sS5AtHHs8bsEmmwZIQVzJOX0wrwkEzmio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uA+lRXfh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2569C4CED1;
	Mon,  2 Dec 2024 14:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733149620;
	bh=lEsVEKZTYkIugE5ghsY3OVSQZ8ghNrKv/MEVjOLvjMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uA+lRXfhtJIWF8420PsyarsIMkNfBzlhh2E8hiYB5NarHL73jc06VkqRMR4tJI477
	 QYut1Ejk7M0k+/4LTV13TyA0vVz7ge5Qy9iqeIJnUH1GVx9Wae0OonQIFfixkJim6L
	 IUg2kEg/yl0gOPtxgZ5gnZWuF3583xTYkHMtH/Jkdk4CVXjlxaU5jMRuoG9CWOm6aU
	 jIVfY48Mco/aOcxngjoQcwMocM0DzCkNjf/Alr9Fv8tSAeyYXbVAwLHLmzCMBJHfXE
	 13ZhisEL4BJ39bET1xcJLEio9aD5x0VICkUyhzIxxL/gaUq4oh8jjR25UsQnF1Iy9H
	 +sffNcbf/yq0g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: mingli.yu@eng.windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15] parisc: fix a possible DMA corruption
Date: Mon,  2 Dec 2024 09:26:58 -0500
Message-ID: <20241202072144-2671bd3ee72a9907@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241202075632.2442890-1-mingli.yu@eng.windriver.com>
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

Found matching upstream commit: 7ae04ba36b381bffe2471eff3a93edced843240f

WARNING: Author mismatch between patch and found commit:
Backport author: <mingli.yu@eng.windriver.com>
Commit author: Mikulas Patocka <mpatocka@redhat.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 642a0b7453da)
6.1.y | Present (different SHA1: 00baca74fb58)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  7ae04ba36b381 ! 1:  398696f6c5132 parisc: fix a possible DMA corruption
    @@ Metadata
      ## Commit message ##
         parisc: fix a possible DMA corruption
     
    +    [ Upstream commit 7ae04ba36b381bffe2471eff3a93edced843240f]
    +
         ARCH_DMA_MINALIGN was defined as 16 - this is too small - it may be
         possible that two unrelated 16-byte allocations share a cache line. If
         one of these allocations is written using DMA and the other is written
    @@ Commit message
         Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
         Cc: stable@vger.kernel.org
         Signed-off-by: Helge Deller <deller@gmx.de>
    +    Signed-off-by: Mingli Yu <mingli.yu@windriver.com>
     
      ## arch/parisc/Kconfig ##
     @@ arch/parisc/Kconfig: config PARISC
    + 	select ARCH_SPLIT_ARG64 if !64BIT
      	select ARCH_SUPPORTS_HUGETLBFS if PA20
      	select ARCH_SUPPORTS_MEMORY_FAILURE
    - 	select ARCH_STACKWALK
     +	select ARCH_HAS_CACHE_LINE_SIZE
    - 	select ARCH_HAS_DEBUG_VM_PGTABLE
    - 	select HAVE_RELIABLE_STACKTRACE
      	select DMA_OPS
    + 	select RTC_CLASS
    + 	select RTC_DRV_GENERIC
     
      ## arch/parisc/include/asm/cache.h ##
     @@
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

