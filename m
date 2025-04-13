Return-Path: <stable+bounces-132338-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 239BEA872A5
	for <lists+stable@lfdr.de>; Sun, 13 Apr 2025 18:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1D021892BCE
	for <lists+stable@lfdr.de>; Sun, 13 Apr 2025 16:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FD71DDC12;
	Sun, 13 Apr 2025 16:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovC5UfFF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B4014A0A8
	for <stable@vger.kernel.org>; Sun, 13 Apr 2025 16:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744562793; cv=none; b=iVdmbRfTJpFoEU0LxWmF/C4iTIxHQQuoWTkd9og48aUUcxwIHUOp0ouazfv8tPqyriJkCLCvLpv1jBOQf+pBmpB/agMW/TtQM14PpYAFizAcey1NGk/nf0wEK1OeJcq5ejHOQmXqwq46SWygMf7fUs6oT0DLOHZ/N8thOykZGeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744562793; c=relaxed/simple;
	bh=q6h+iNVaSgJY2y41g2BF9F2JdHYlcqLubHzmnVIyATM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hiCZ5OzS7gybwYKfT+WBt764ErOsS/1d3QwmlEP4LmN9O8O0HurjfW2IND39/Mp0LopjY04AOM09v8MiU6W6JEbCNAFcne+20v+13o3O2t5/olwmTE63062E72ZvXgOlAgbh2kWYY/O4MXJwh7rtSX78BKEQy2r2Ve9u90nhLSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovC5UfFF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E5CDC4CEDD;
	Sun, 13 Apr 2025 16:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744562793;
	bh=q6h+iNVaSgJY2y41g2BF9F2JdHYlcqLubHzmnVIyATM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ovC5UfFFb0pd/dTqdQhM+G2vOsGvMHk08uzCszf+evbQHFHViMcIaUfEi+id8Rtzt
	 R0SsKxREYaHW6zyhUO9e3oABFr2Cev4uY/Jf6VFT4H6mx0dpP50O261rSctH9Ft3XH
	 CszPhkbAZMXnEsniO7c18az6WK2iwfc5xnfLykktl0X+uh1z7hgwXLrQ9bsXjm72/6
	 +CV2ol2El3n1ph3/r4KIePJWR1+tC77bwFuUzn5AXLAa71y8EhwWNDif+/F0VmX2Pj
	 aV6cWo6G7HzjtTvRUSscptUsuzyAOgZp2g33bkdtl1XK78aK8LamEiEMfCWWZpiuWG
	 B5KiXFX4MNkvw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Cliff Liu <donghua.liu@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] powerpc/rtas: Prevent Spectre v1 gadget construction in sys_rtas()
Date: Sun, 13 Apr 2025 12:46:31 -0400
Message-Id: <20250412092821-bdf8ddd275c82b1d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250411064937.3662385-1-donghua.liu@windriver.com>
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

The upstream commit SHA1 provided is correct: 0974d03eb479384466d828d65637814bee6b26d7

WARNING: Author mismatch between patch and upstream commit:
Backport author: Cliff Liu<donghua.liu@windriver.com>
Commit author: Nathan Lynch<nathanl@linux.ibm.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  0974d03eb4793 ! 1:  6aab6e86d4055 powerpc/rtas: Prevent Spectre v1 gadget construction in sys_rtas()
    @@ Metadata
      ## Commit message ##
         powerpc/rtas: Prevent Spectre v1 gadget construction in sys_rtas()
     
    +    [ Upstream commit 0974d03eb479384466d828d65637814bee6b26d7 ]
    +
         Smatch warns:
     
           arch/powerpc/kernel/rtas.c:1932 __do_sys_rtas() warn: potential
    @@ Commit message
         Reviewed-by: Breno Leitao <leitao@debian.org>
         Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
         Link: https://msgid.link/20240530-sys_rtas-nargs-nret-v1-1-129acddd4d89@linux.ibm.com
    +    [Minor context change fixed]
    +    Signed-off-by: Cliff Liu <donghua.liu@windriver.com>
    +    Signed-off-by: He Zhe <Zhe.He@windriver.com>
     
      ## arch/powerpc/kernel/rtas.c ##
     @@
    - #include <linux/lockdep.h>
    - #include <linux/memblock.h>
    - #include <linux/mutex.h>
    + #include <linux/capability.h>
    + #include <linux/delay.h>
    + #include <linux/cpu.h>
     +#include <linux/nospec.h>
    - #include <linux/of.h>
    - #include <linux/of_fdt.h>
    - #include <linux/reboot.h>
    + #include <linux/sched.h>
    + #include <linux/smp.h>
    + #include <linux/completion.h>
     @@ arch/powerpc/kernel/rtas.c: SYSCALL_DEFINE1(rtas, struct rtas_args __user *, uargs)
      	    || nargs + nret > ARRAY_SIZE(args.args))
      		return -EINVAL;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

