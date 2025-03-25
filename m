Return-Path: <stable+bounces-126036-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED992A6F45C
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 12:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F27A6166952
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 11:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C942561D6;
	Tue, 25 Mar 2025 11:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtmBreHR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30375255E3E
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 11:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902695; cv=none; b=HP6/J4JA5jPwZJ+1C3BZfK04Q2JKAast+mmL0LWjKmO9OvteRe4smCQrXSLKjXz3Hjfz8oEW2U7X6KBNXpMRMJmU5majF3GXZVzQCoEEGxDoVlVnylcEreKQJLHdPxrTTqna1ChWK4CTQ11oPpEdAP0PR6APrDHi9fo2nARbXgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902695; c=relaxed/simple;
	bh=CX6YByi9htmPpSOc+BISCNh+nBRpvVtr4fYUfiLlZJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=akziV+PCpzdMybPv5CEDe2LOLu2kUP4TwdQmR0QMCFcXh4K8BEbYhSyWvL7mi05OXLoIZBJ1lINawK1d9wdZlqfIkEk33+mBa7uka4hvPDbauR1auSL63WbUM5JZdiZ1jCeGgpx28ZstaWPOK3ztNk4mrajC6AmW77eJj9JXAtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtmBreHR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2732CC4CEE4;
	Tue, 25 Mar 2025 11:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742902694;
	bh=CX6YByi9htmPpSOc+BISCNh+nBRpvVtr4fYUfiLlZJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OtmBreHR7lb6C/z7Cip+jPilcgitDRaVHCg4uIRU4h24qqetgbUQIxUKJ6GPU9dTV
	 rKH9kMOLijeHRl2d8la83Nwv6cXH0EtKMhT1PS1/fgqa60GVa3SrNTv8WJ+jr/G0dE
	 YlMOLZVYbnK65Uu153852pTIlSZbHYTYHeqDxbVS2/MOFVlXHqcRLPFA2ys0u8Djro
	 gerE9M3pj7P9AbBye8k2s/W5bn8r3ie8PMkEibkgcKMWY8aA1bhV12JwhIR3p5NPMN
	 KU9Ieitz94IrFX5WQnwGZUcKYM6hzXLGizPPdfFBxIuEPQv7JalItmvKdo0a0zVSER
	 ueGV0sMNnciBg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kang Wenlin <wenlin.kang@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 2/7] binfmt_elf: Support segments with 0 filesz and misaligned starts
Date: Tue, 25 Mar 2025 07:38:12 -0400
Message-Id: <20250324220941-eede19a4ec65505d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250324071942.2553928-3-wenlin.kang@windriver.com>
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

The upstream commit SHA1 provided is correct: 585a018627b4d7ed37387211f667916840b5c5ea

WARNING: Author mismatch between patch and upstream commit:
Backport author: Kang Wenlin<wenlin.kang@windriver.com>
Commit author: Eric W. Biederman<ebiederm@xmission.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  585a018627b4d ! 1:  f14beae673802 binfmt_elf: Support segments with 0 filesz and misaligned starts
    @@ Metadata
      ## Commit message ##
         binfmt_elf: Support segments with 0 filesz and misaligned starts
     
    +    commit 585a018627b4d7ed37387211f667916840b5c5ea upstream
    +
         Implement a helper elf_load() that wraps elf_map() and performs all
         of the necessary work to ensure that when "memsz > filesz" the bytes
         described by "memsz > filesz" are zeroed.
    @@ Commit message
         Signed-off-by: Sebastian Ott <sebott@redhat.com>
         Link: https://lore.kernel.org/r/20230929032435.2391507-1-keescook@chromium.org
         Signed-off-by: Kees Cook <keescook@chromium.org>
    +    Signed-off-by: Wenlin Kang <wenlin.kang@windriver.com>
     
      ## fs/binfmt_elf.c ##
     @@ fs/binfmt_elf.c: static struct linux_binfmt elf_format = {
    @@ fs/binfmt_elf.c: static int load_elf_binary(struct linux_binprm *bprm)
      
     -		if (unlikely (elf_brk > elf_bss)) {
     -			unsigned long nbyte;
    --
    +-	            
     -			/* There was a PT_LOAD segment with p_memsz > p_filesz
     -			   before this one. Map anonymous pages, if needed,
     -			   and clear the area.  */
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

