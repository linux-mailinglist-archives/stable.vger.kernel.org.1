Return-Path: <stable+bounces-110188-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 629D9A193AA
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 15:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 541F53A3F71
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 14:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C04213E6C;
	Wed, 22 Jan 2025 14:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZRQ61WY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054DB2135DB
	for <stable@vger.kernel.org>; Wed, 22 Jan 2025 14:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737555407; cv=none; b=Hv/QNWIZFIKeHAOrF6LE+9hhdzpAEJeUSiZ87sFFJlxNG7cjGa+TF8iZff7Pw/fhr/VyoCDHf4LMGW4bUhmtNz6HpL6D4mnECcUCpztGRKEsPHelvDkkOh7ESyO34+4xmDOLNhFqxejVQiS7pZegZ1TNFAUWoVg6nm/z7Nsx5HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737555407; c=relaxed/simple;
	bh=Un9dAuLiJgfQrkhhneZmx5WdAFp5lYnh1IAyQX8U3uo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vDhWtn/thOnjREgGUpMrMnT9gOLkF+cVPRAJ8gBs6oqF0V3jhW/wLkvGxfUcjHYRWbeiYAFt6Wk5l6xM+JGpl1VJ3MnD4Qdc1JNoaJ+eu+x0SBxvdAvCcWPgqEAAGCuglPCrwA7/JV3SVnedmYGjBRHRMO6cbuJoxtxMA4MC77w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZRQ61WY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 074EFC4CED2;
	Wed, 22 Jan 2025 14:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737555406;
	bh=Un9dAuLiJgfQrkhhneZmx5WdAFp5lYnh1IAyQX8U3uo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OZRQ61WYrDrgDGgeEUeCiYhFthYS8oePPrnqrhEf081CCejm85P0MN0aM1V94sZ3s
	 pxdKA2qOWiRGzaQics/1DRrCBzVO0FFInwcJL2oxbwub9SxZA1BhoVbFJoVGYZKaYv
	 7wW76mUMmnz31MdjPr5hQ4L748O/Lm6BgElkZ4L4Huj6dahVmyKGLJrgFSxptCxOTr
	 IcHHOBibVv2tZhSNN20h5gpJOQO0l8IV7UmaE6PwfrgvWJ2Zr5o5OAeMVwPwlrUbBj
	 PsXOpZ5XfHx6CSit4CcutHSijrJmD+YlaAPp5PJn0AP/psa4hcYvvYlttf9OP1k7MG
	 sGqilPMkf03TQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Finn Thain <fthain@linux-m68k.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y] signal/m68k: Use force_sigsegv(SIGSEGV) in fpsp040_die
Date: Wed, 22 Jan 2025 09:16:44 -0500
Message-Id: <20250122085539-621c490778d361b8@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <dd7ca3ed8cfac012d6001fe4d3e8d604@linux-m68k.org>
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
5.4.y | Not found

Note: The patch differs from the upstream commit:
---
1:  a3616a3c02722 ! 1:  bf9f85b11138f signal/m68k: Use force_sigsegv(SIGSEGV) in fpsp040_die
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
| stable/linux-5.4.y        |  Success    |  Success   |

