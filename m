Return-Path: <stable+bounces-110174-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C94A1939E
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 15:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A64723A03EC
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 14:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D706A213E8E;
	Wed, 22 Jan 2025 14:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Miqn8EbU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C3B20F990
	for <stable@vger.kernel.org>; Wed, 22 Jan 2025 14:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737555378; cv=none; b=paZ04J/XO3TNhMn2P7/NhiL70VZcV/+hNqOXxhFOsVNvHK1C4VprwB0dIlw6tlve45AEQ/vYNuxoHVvkcGJArwEpazBOrujcGIcEvx2ceMmMkurulPeGFKd7F2zMGesRUeoHvCXy4Lg1Df7lf7NA3KMtvwFj1kndn0fphGktdsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737555378; c=relaxed/simple;
	bh=qEe78/l4oS3+wNf7Eyu4RwbqLX9I7Y39MU9/VQXlMnA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZNn8/5DZaG/MC4z4WubwDVQQQ17LyvTK2VZ9acNcH6VE1MYdJq8IWH+WpCpiP0VQXyXnA9DPZCJMrTAUhlGn9CMOESt+1dPnFBnAcsP9Z7my/ADVScmhSl5onkR4oomy8OQJWkrNsIEoUijrLUodYNF2XjDmA8dddcwi4QxYW+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Miqn8EbU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9836EC4CED2;
	Wed, 22 Jan 2025 14:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737555378;
	bh=qEe78/l4oS3+wNf7Eyu4RwbqLX9I7Y39MU9/VQXlMnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Miqn8EbUUhlT5Y+gkgy00ek45oVW3IzqxeFWbJAD2Y/r7EOzaHWFPeha0esHPaIC4
	 cIGWCtmBqZuBA6UeJ0v1+9lsz+oySTsli1wi2/+BRDsWrXMDgOnjxbZStyDVx/9KXU
	 gNRzUYZ0+E41Y9mpfQ1MlaOFH5bozS+yfHjudrBgfrnOAvzNY8ijCoR0nTaVSV50VU
	 kDsCki6VCTarKa0BKC6EIHahnvm9CgKTpejv0263s487mOlEJggB/O3TNnoeT+GpLs
	 +Auu9291W8jblX6vBmGtocXnpoCDJt+foQ4p4C0A2CmHvi8IbUdZf18kOp2483EeG+
	 AEa3d+31WY1gw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Finn Thain <fthain@linux-m68k.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] signal/m68k: Use force_sigsegv(SIGSEGV) in fpsp040_die
Date: Wed, 22 Jan 2025 09:16:16 -0500
Message-Id: <20250122084247-2265294a6ce42491@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <543c08353cd05bad3362e9c811ea6869@linux-m68k.org>
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

The upstream commit SHA1 provided is correct: a3616a3c02722d1edb95acc7fceade242f6553ba

WARNING: Author mismatch between patch and upstream commit:
Backport author: Finn Thain<fthain@linux-m68k.org>
Commit author: Eric W. Biederman<ebiederm@xmission.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (exact SHA1)
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  a3616a3c02722 ! 1:  005dfe5862666 signal/m68k: Use force_sigsegv(SIGSEGV) in fpsp040_die
    @@ Metadata
      ## Commit message ##
         signal/m68k: Use force_sigsegv(SIGSEGV) in fpsp040_die
     
    +    [ Upstream commit a3616a3c02722d1edb95acc7fceade242f6553ba ]
    +
         In the fpsp040 code when copyin or copyout fails call
         force_sigsegv(SIGSEGV) instead of do_exit(SIGSEGV).
     
    @@ Commit message
         Link: https://lkml.kernel.org/r/87tukghjfs.fsf_-_@disp2133
         Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
         Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
    +    Signed-off-by: Finn Thain <fthain@linux-m68k.org>
     
      ## arch/m68k/fpsp040/skeleton.S ##
     @@ arch/m68k/fpsp040/skeleton.S: in_ea:
    - 	.section .fixup,#alloc,#execinstr
    + 	.section .fixup,"ax"
      	.even
      1:
     -	jbra	fpsp040_die
     +	jbsr	fpsp040_die
     +	jbra	.Lnotkern
      
    - 	.section __ex_table,#alloc
    + 	.section __ex_table,"a"
      	.align	4
     
      ## arch/m68k/kernel/traps.c ##
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

