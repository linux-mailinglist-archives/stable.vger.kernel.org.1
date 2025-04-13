Return-Path: <stable+bounces-132342-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A30BEA872A7
	for <lists+stable@lfdr.de>; Sun, 13 Apr 2025 18:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C8CC3B74B9
	for <lists+stable@lfdr.de>; Sun, 13 Apr 2025 16:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4581DDC12;
	Sun, 13 Apr 2025 16:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jo3qgx9C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0C914A0A8
	for <stable@vger.kernel.org>; Sun, 13 Apr 2025 16:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744562803; cv=none; b=Pgp5LLxQ5qfLYHr8dUUVwfLGqhGNKzI5PsbO4JScHX30OLWfT+zN3iXQKBKcGC+quil4/4MvTuY8i2+RP+Wb3T0H6DjKtcSaFb/vqvHduFkNAHOBHK8vQEY4GkB3kXs8K2fQgPJVZaGnxj/HTKFxfyP/PkrXFrezCYJsuApvNp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744562803; c=relaxed/simple;
	bh=pUCgdug0gnnVS6bpwvkmGh/IZBcNkr+sBXVOV048ihM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PPo4sdWGvQ7zKQKxAIZXBbYP9dVRlu6V48ssERoCcdvch+CV/tQGRUXAFdzmMBjiGd1oR0ZDDFTXY116d6/euESSDtIcGIKPoVb3VobQ5+GHGLELmbdDB1j2l+ylE0bdh2SaHIXkDY3kkBl0AyW67MJA4QhEugIAT0LnZPlM1zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jo3qgx9C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43FFCC4CEDD;
	Sun, 13 Apr 2025 16:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744562802;
	bh=pUCgdug0gnnVS6bpwvkmGh/IZBcNkr+sBXVOV048ihM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jo3qgx9Conn67nPm+xidQCs2FTJQ4vV9ldmsSheE44R24vbB1SgFQILtkxW7BVBgH
	 d8UxAmgub13N7Obwd52qC/LboaaETfcpftxVthYlWmyyZJ7E1BeJ447SlhgQMyZtq0
	 MvTjUS7n9szlaQOxESudHwXwqJvAbnioSamsQ6SLzmrXTCM79qybasY7nyGKZ3kxLH
	 DmT0/rcjMje8mEqptl6IiayBY6FY/+WkYV3S6DuuoHM0JyEHHqlthJzSMF7L1sXrZj
	 JNgEgAQuh1VJ5Wl623Xs2qiPwRiJc8CPXxZArLbeSA1uvRj0Ydba7TnJOlpM8V/sL6
	 eOHXW5Fuox8Vg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Cliff Liu <donghua.liu@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] powerpc/rtas: Prevent Spectre v1 gadget construction in sys_rtas()
Date: Sun, 13 Apr 2025 12:46:40 -0400
Message-Id: <20250412124652-6550e072af3d9e32@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250411022623.947973-1-donghua.liu@windriver.com>
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
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  0974d03eb4793 ! 1:  4d5f35b16ee3f powerpc/rtas: Prevent Spectre v1 gadget construction in sys_rtas()
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
| stable/linux-5.10.y       |  Success    |  Success   |

