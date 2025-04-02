Return-Path: <stable+bounces-127443-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 214DCA797A1
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 23:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E55061677B0
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 21:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A54C1F1936;
	Wed,  2 Apr 2025 21:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HxRTsj0M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF80E288DA
	for <stable@vger.kernel.org>; Wed,  2 Apr 2025 21:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743629117; cv=none; b=Ycr3Yj/IW1F5hABmF6TkZrCZL5FnUKZz8dVIFKsIGdgfzCBO0M3rl5+0wJ0TBtK0o7vnvUlDw7Fctd9LgML+PKxT5D5uVvDmUcG0b1FAJHJ3xvCwp64/JYEeW2HmTP46eY65hpdFEBuUN6LLukobW7ecjRFAYMizC+bYjm+W9RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743629117; c=relaxed/simple;
	bh=o4hL/p+rOAoDVYRfkP+37twT48P8ANuZ2qY5czSea3U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kc7GXu34HgwHMomsdsZyMM8K9jRGicPncqXMwtk1Ps5mMi80moPdiIHqfMVERGFeybcXCTWCKZj98N8ITSkU43Wms3JAFIPe3r2x5YTHQthmDavEulrWu95y0h91hwY31sVP/RHapNPXT1WEihVVlzWAv+A9WO+BskIATIJJd8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HxRTsj0M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D715BC4CEDD;
	Wed,  2 Apr 2025 21:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743629116;
	bh=o4hL/p+rOAoDVYRfkP+37twT48P8ANuZ2qY5czSea3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HxRTsj0MmB864IpsZuklsIUzQ/VPK5m8rcRtH+MHSDdNAhsWuNHaCCd6vfTAFIId5
	 8I/pcxVzR2/2dk8UDjR8252d1gumwPl2g4gQHvv9vYXhd3IsEdfomaUwf7Nx59EVDy
	 /dBwSdA1CWXrpMTxrBsb9Lb/ss1iy+cfWtBP/6YjlHilTFBneOtSK6hc5GhkUy4jEt
	 q2AVKfru/Dq21yDB7rie2pfpwX7Zwuuo3t+PKUl6ydc4mzTISzONUDwjwX55RcJMO7
	 72zNfI4HcwOWwVBeza1a8vfmzXxY0z0IvzZVZDdNEZPtVZi8MdhS311/GkgREx+ldh
	 T2tLLBjVpMK2Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kang Wenlin <wenlin.kang@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y 3/6] binfmt_elf: Use elf_load() for interpreter
Date: Wed,  2 Apr 2025 17:25:14 -0400
Message-Id: <20250402133325-29332c05069f740f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250402082656.4177277-4-wenlin.kang@windriver.com>
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

The upstream commit SHA1 provided is correct: 8b04d32678e3c46b8a738178e0e55918eaa3be17

WARNING: Author mismatch between patch and upstream commit:
Backport author: Kang Wenlin<wenlin.kang@windriver.com>
Commit author: Kees Cook<keescook@chromium.org>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  8b04d32678e3c ! 1:  498e3c72603ad binfmt_elf: Use elf_load() for interpreter
    @@ Metadata
      ## Commit message ##
         binfmt_elf: Use elf_load() for interpreter
     
    +    commit 8b04d32678e3c46b8a738178e0e55918eaa3be17 upstream
    +
         Handle arbitrary memsz>filesz in interpreter ELF segments, instead of
         only supporting it in the last segment (which is expected to be the
         BSS).
    @@ Commit message
         Signed-off-by: Sebastian Ott <sebott@redhat.com>
         Link: https://lore.kernel.org/r/20230929032435.2391507-3-keescook@chromium.org
         Signed-off-by: Kees Cook <keescook@chromium.org>
    +    Signed-off-by: Wenlin Kang <wenlin.kang@windriver.com>
     
      ## fs/binfmt_elf.c ##
     @@ fs/binfmt_elf.c: static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

