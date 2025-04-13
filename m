Return-Path: <stable+bounces-132337-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09102A872A3
	for <lists+stable@lfdr.de>; Sun, 13 Apr 2025 18:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08EE516D048
	for <lists+stable@lfdr.de>; Sun, 13 Apr 2025 16:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF641D7E37;
	Sun, 13 Apr 2025 16:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwJwStCJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC8114A0A8
	for <stable@vger.kernel.org>; Sun, 13 Apr 2025 16:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744562791; cv=none; b=skoQVIDSeb++1nw18ODtNcmeD1kzRDHSy9Z8LVM1CaHXzT4EmFW37e9nnuJDyuvbiNjER0SI96l6dmf4qlMrFdJmKaY97fp5AOlDgeEEmnj607NJ552brDNCPVNEE2mL6EScX4XpzfpZ0GvU7qSIpjFwYKJe9CgkNxxasir9Vnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744562791; c=relaxed/simple;
	bh=I6puS38yAt3nnBI1X9gqPD3NpYXr/9DnPrjeYwEc0Cc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=itpQELh6ykHq1l2KXsX9BbxMHFqdhvEKFRz9YZqjDAfFa5hJkX2nQO1l3vUM4Zg4CPNIoosR2rcMP+PgFYfyu52v/EkNv7eY7cERinYH/7GK251k+lgLrVLynPXagmLFv62iykeTHE4SlLl7rVolK6so8khq2uFfm/f3FUdZrEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwJwStCJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E29AC4CEDD;
	Sun, 13 Apr 2025 16:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744562790;
	bh=I6puS38yAt3nnBI1X9gqPD3NpYXr/9DnPrjeYwEc0Cc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QwJwStCJcHgq/NlSn1IeO8FdueGfchR8At2bRcG87NjG75Bo7ptSMADKv10m4XEmF
	 sd+bU2Q+bPvLvvnhvpsJhB5lxOTiIArmDegQOX9vdCd9r+m15qYlVoav2/3LKQoP94
	 0zzLoqYDeoz6QkDFeU69IgLtflVSX36TjulrYRKtMpE8drqvnewUpKjcdcIpQGP9bU
	 lhAOk1bxXMiy0Hk4u7lrJtm/xijfJsew/D2YZOW2UUKxdeuKB0FMClWc0vDLPzGQDL
	 lxAMXzqcseViXsthhXaQ1Wslf12To6DsFH6N1NEMVU2pQ9sxAFs690LUBrkViBy3hC
	 nXhT8P1yF43oQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Cliff Liu <donghua.liu@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] powerpc/rtas: Prevent Spectre v1 gadget construction in sys_rtas()
Date: Sun, 13 Apr 2025 12:46:28 -0400
Message-Id: <20250412110821-2825366719a51b42@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250411064727.3654037-1-donghua.liu@windriver.com>
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

Note: The patch differs from the upstream commit:
---
1:  0974d03eb4793 ! 1:  7e124d2790a6e powerpc/rtas: Prevent Spectre v1 gadget construction in sys_rtas()
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
    + #include <linux/reboot.h>
    + #include <linux/security.h>
    + #include <linux/syscalls.h>
     +#include <linux/nospec.h>
      #include <linux/of.h>
      #include <linux/of_fdt.h>
    - #include <linux/reboot.h>
    + 
     @@ arch/powerpc/kernel/rtas.c: SYSCALL_DEFINE1(rtas, struct rtas_args __user *, uargs)
      	    || nargs + nret > ARRAY_SIZE(args.args))
      		return -EINVAL;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

