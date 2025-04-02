Return-Path: <stable+bounces-127446-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E256EA797A4
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 23:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8B4C1699B6
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 21:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706F91F1302;
	Wed,  2 Apr 2025 21:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jm/WNt/F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F19288DA
	for <stable@vger.kernel.org>; Wed,  2 Apr 2025 21:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743629130; cv=none; b=Fkn9H5pprgSsEvs78A4/QuGOmvfjpHgS0nywPjWQ+KVs4SYduLdhT76/mdqNG2AowKRLWOlrS2LVqEyPCmEgTfJfRxZWGSWCgu1l5sjs4ZjPH8opnDCoJY+T50Bd/DkPNfLOVYaRCNCZll/ofzI+023BiDuVivh/XpE1a9deCOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743629130; c=relaxed/simple;
	bh=Crf3fQyqOX7k2VQZq75p8QQi477Wpcy2xc1t9NJf9e8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pxn6mMHZWJpYvASSzsuWGHQvaV/h/7SALFzaGl/8dZA9g1q1/XU+SdFzw8IO2G9Uv5JWoRoSC7Fi3pWTEyVjaJMZM3PAlBV4vkqXy0sxhx8Ngy/1x8CFdt9wGu/HB0odJHUQ5lf3JTgO5uEzmsdQ2BMWhYSi5Kqk18uVIj9M5I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jm/WNt/F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D877C4CEDD;
	Wed,  2 Apr 2025 21:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743629130;
	bh=Crf3fQyqOX7k2VQZq75p8QQi477Wpcy2xc1t9NJf9e8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jm/WNt/FB4mfHaOWRzI8IW/4EsWEfCpjVHzCILj3hAtx7tXhCPGNXGcIHDzz77oBP
	 zaJd4Q0GensNsR/YvGIhlVPvObGT6SeB625+qQTN2+++/B9VjHl+PtTra8HeKk84bb
	 iLnK2TtW75Pli9UnF2gJ8MmSRzYFXk2wVWZOqItrfg9FgUO10Ub30XAggYaSgJtKzO
	 kGERkPJMjQmmRnJb7LGm8+WhcBJPDvwi9rkR8KBU4UZI6P8MDUcmJolsQdODAO8GG3
	 kY2MzrTptthSd/7912wo7JlxA4KlI5JJKiUqZDY32yHmvnHPfzr3WoC+TlKC63RzTV
	 dXJzkbHks/saw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kang Wenlin <wenlin.kang@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y 6/6] mm: Remove unused vm_brk()
Date: Wed,  2 Apr 2025 17:25:25 -0400
Message-Id: <20250402150212-d8f1cc163bc1c347@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250402082656.4177277-7-wenlin.kang@windriver.com>
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

The upstream commit SHA1 provided is correct: 2632bb84d1d53cfd6cf65261064273ded4f759d5

WARNING: Author mismatch between patch and upstream commit:
Backport author: Kang Wenlin<wenlin.kang@windriver.com>
Commit author: Kees Cook<keescook@chromium.org>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  2632bb84d1d53 ! 1:  3f390c20a6af6 mm: Remove unused vm_brk()
    @@ Metadata
      ## Commit message ##
         mm: Remove unused vm_brk()
     
    +    commit 2632bb84d1d53cfd6cf65261064273ded4f759d5 upstream
    +
         With fs/binfmt_elf.c fully refactored to use the new elf_load() helper,
         there are no more users of vm_brk(), so remove it.
     
    @@ Commit message
         Signed-off-by: Sebastian Ott <sebott@redhat.com>
         Link: https://lore.kernel.org/r/20230929032435.2391507-6-keescook@chromium.org
         Signed-off-by: Kees Cook <keescook@chromium.org>
    +    Signed-off-by: Wenlin Kang <wenlin.kang@windriver.com>
     
      ## include/linux/mm.h ##
     @@ include/linux/mm.h: static inline void mm_populate(unsigned long addr, unsigned long len)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

