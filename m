Return-Path: <stable+bounces-126009-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 600B7A6F424
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 12:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D2D63AF729
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 11:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006601EA7F5;
	Tue, 25 Mar 2025 11:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6Deeli5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5348BA36
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 11:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902398; cv=none; b=IcubjHWyKkwJk4wP3/LAQL/bzYvTl8wULxnttlvbvyAR1bjLXcsEv+raHLAAkKZHSyeDwESJR7ksvi2vq0U7I3XY8l18mc9VTizE85F6CPvCmuyVwcqqu6/O0LyMr1MRAH0XAmPW/RwdgfGburnKXNY0LF/aJ0M1Ylorr4zoQIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902398; c=relaxed/simple;
	bh=M7JLIbcO7VXIUj8nyWnBDFPSPlVVtBxUbf29Zg8/LHk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uT66K74QNyiulZIRKDcxBKtQt2SpD4pCGgW6qWyTt2ryznx2tvmB7xZmttm1GmAWKrEazPCZZOeidVJ5neGuxWkpsFpC3CHE4RV97l89mak07kOiHleet+10XhxTgCAwJhZRs7oB64Ji9SQMXNzEmdEEpElFVMOwkBkxr24HvJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6Deeli5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A68C4CEE4;
	Tue, 25 Mar 2025 11:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742902398;
	bh=M7JLIbcO7VXIUj8nyWnBDFPSPlVVtBxUbf29Zg8/LHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G6Deeli5yy9uUqNAUM6K03G0smwBly5FRZpAwACQCPIuFbop1RAaaCp/FuPrWcHqE
	 LRFoCW+H7mIihXQmNnlNbdPoMkWl2KoB4uiDsPJCTVaiqAhIp1x5zzxiXmIJdaiJFy
	 1GbqxaAqFXmvPDEfOiZ42mK1euiVqCyfL3gRPEe+KXZ1N/g4O1QgYLQpbPk+wtrDMo
	 RzkIYjT9qPu+u9h99XVpjdjLXv2ij/dbUoMOfIcZ6by5DmmunJ5b3BqAkTVNvLTBaa
	 GJ1Xr+bbY3DK1SpEeIFpvF8gnROcp5fq1YZ/C7vPFqDxP1DQmSsp3DZLFtoFu3fDjx
	 A4347cDL/EVvQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kang Wenlin <wenlin.kang@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 3/7] binfmt_elf: elf_bss no longer used by load_elf_binary()
Date: Tue, 25 Mar 2025 07:33:16 -0400
Message-Id: <20250324221607-2b5e8195a0e5ac9e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250324071942.2553928-4-wenlin.kang@windriver.com>
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
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  8ed2ef21ff564 ! 1:  b68e62cd6249e binfmt_elf: elf_bss no longer used by load_elf_binary()
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
    @@ fs/binfmt_elf.c: static int load_elf_binary(struct linux_binprm *bprm)
     @@ fs/binfmt_elf.c: static int load_elf_binary(struct linux_binprm *bprm)
      	if (retval < 0)
      		goto out_free_dentry;
    - 
    + 	
     -	elf_bss = 0;
      	elf_brk = 0;
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

