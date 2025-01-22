Return-Path: <stable+bounces-110186-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59758A193AD
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 15:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24A9A168E47
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 14:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86CB213E86;
	Wed, 22 Jan 2025 14:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uvb1wlxa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EB4212FA9
	for <stable@vger.kernel.org>; Wed, 22 Jan 2025 14:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737555402; cv=none; b=hYr0JiumwdygwB7p0bpfmf2W6z156V5gCv2NRHwT7ZkfrFpiYBnpaYxtCC8Z7/eDy9j+3SNJOSCHd1yOvRR0CyxXWBMdQnQWKpo9YVsI7wrvH+txmlerjzeiahf6l9vK7gdnMrlQ2FRyczMXZPCsZ8PcRb6n5dvj2QLhYIVR2/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737555402; c=relaxed/simple;
	bh=wwiAc4uHzDhzN1y0pYvy+Vh6nvBwu8EpslXxawGUIyw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CB0va6OKvfAZKEboBt3UcJYGY5NU3x6VTp6O1jVLzYNfd+i56AmjaJflGPJIjjaFz8sroLP5+6YGXl8S3IwrepanvUnhK6DMgKTf/SxMSuKqogQgg0Qrygyd+/+qslKaZ+o6/cvXRM9s2jPDdANVoXP10LPMYMYIVWlAUdHzhhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uvb1wlxa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08DCEC4CED2;
	Wed, 22 Jan 2025 14:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737555402;
	bh=wwiAc4uHzDhzN1y0pYvy+Vh6nvBwu8EpslXxawGUIyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uvb1wlxas3g1dDn/CfN82msZXJGaqMKSZmsACngRGlLDclKfX22AB1qQb7TbGcD9I
	 bYo4WHuKilIxOZli1F+NSEEfiJ6BJiuyisbM6AHgzvyZRYRwJzmOXBXRBLACwSZbKw
	 qGfYLmMOJt909A/GSY5u8BzebxPdAz80XOyRQrkoMuSWVioV9olgEeYfEzL2Waz5QS
	 +eciunUH9qFmRnCNZRk5jDzm1lIEKODW8Rjn9/dlmaywwcLHCVYSgILYzFmUkEN9JQ
	 7dzNZ7XNrKpL1ZHVpIQbT5bnT3JqW7gQVfRWBr8b4tJS3oSJMaSbyXGD3S0iNifkS5
	 b3MK2wJEOSJOQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Finn Thain <fthain@linux-m68k.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y] m68k: Add missing mmap_read_lock() to sys_cacheflush()
Date: Wed, 22 Jan 2025 09:16:40 -0500
Message-Id: <20250122081011-e522c933a100f4f1@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <d0c39a02fd50c3ac2fc187d08b942c69@linux-m68k.org>
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

The upstream commit SHA1 provided is correct: f829b4b212a315b912cb23fd10aaf30534bb5ce9

WARNING: Author mismatch between patch and upstream commit:
Backport author: Finn Thain<fthain@linux-m68k.org>
Commit author: Liam Howlett<liam.howlett@oracle.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (exact SHA1)
5.10.y | Present (different SHA1: 58ee5a0de192)
5.4.y | Not found

Note: The patch differs from the upstream commit:
---
1:  f829b4b212a31 ! 1:  9f4fbaa4b6d79 m68k: Add missing mmap_read_lock() to sys_cacheflush()
    @@ Metadata
      ## Commit message ##
         m68k: Add missing mmap_read_lock() to sys_cacheflush()
     
    +    [ Upstream commit f829b4b212a315b912cb23fd10aaf30534bb5ce9 ]
    +
         When the superuser flushes the entire cache, the mmap_read_lock() is not
         taken, but mmap_read_unlock() is called.  Add the missing
         mmap_read_lock() call.
    @@ Commit message
         Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
         Link: https://lore.kernel.org/r/20210407200032.764445-1-Liam.Howlett@Oracle.com
         Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
    +    [ mmap_read_lock() open-coded using down_read() as was done prior to v5.8 ]
    +    Signed-off-by: Finn Thain <fthain@linux-m68k.org>
     
      ## arch/m68k/kernel/sys_m68k.c ##
     @@ arch/m68k/kernel/sys_m68k.c: sys_cacheflush (unsigned long addr, int scope, int cache, unsigned long len)
    @@ arch/m68k/kernel/sys_m68k.c: sys_cacheflush (unsigned long addr, int scope, int
      		if (!capable(CAP_SYS_ADMIN))
      			goto out;
     +
    -+		mmap_read_lock(current->mm);
    ++		down_read(&current->mm->mmap_sem);
      	} else {
      		struct vm_area_struct *vma;
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

