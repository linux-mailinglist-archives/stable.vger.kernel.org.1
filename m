Return-Path: <stable+bounces-126016-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4EEA6F427
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 12:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09D933AD700
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 11:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2869C255E4E;
	Tue, 25 Mar 2025 11:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R80bpBqr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE381EA7F5
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 11:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902412; cv=none; b=r8qP6Eg3pmabOKSNmgFHytFfYOicYnx8YP2J05F85ycazUJLDa++qQvCu94kWr9ZmnjpqBL4k5bC9EaN+b/bDIyO/3hnTaWJyyc1jrptqHxmHd6YQ0wNRGgLWLq4jkB5dOXu0kEWyQjbD4zOdlyxpma207/8Xct5UVJiRZInCvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902412; c=relaxed/simple;
	bh=gkSNhdDMqwPOUmS+3en7ezE2TPuG7g196WZDx4cO6ZI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a8PmiRci1K2dmMElv+X3MyiyJ2vwa9vjGSw0tcsb4CpfNtTVYJ/w5sf2rsTjUywiba9Zuq83o3jpy5OclWTezvZEr5wHbFkKsL3B3Vmf3egHGYZsymBK+Ryso89lqsIL2quviIsPy5a8YF14rWJxjoA07iA6021kv8TgYa1USo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R80bpBqr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E3BC4CEE4;
	Tue, 25 Mar 2025 11:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742902412;
	bh=gkSNhdDMqwPOUmS+3en7ezE2TPuG7g196WZDx4cO6ZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R80bpBqr7KHcVdblWmpuMTeGB7jiqIgTHS3pg3oSjyyWTmZqtTA0gc5dQoVgFP0Af
	 okNqUBEAsUjkNIrXgCaEohD1i1nrRoV3SLvaGLpcMuE/y1SXM/LcTjTQcQRoP8C1pb
	 V8OeSm0qAG6N5tG3Wbhw7sY2+zmmnaVPNPJrQ8h7Egwef36t/YwUZC2IVnKIhTwoDs
	 T3WFt04hJGhU8SaxS53e9Ly1dEtJ+d9uao4IWKhwkcjFZPFTB7NX2eStMVY2uZ4MkN
	 t248MRbyZ6k+wmVveHV0wc1MN+TaomeFUeWSeELueb9IDXuVe0i7DW4FSCWnHmk1iz
	 2J5BkdDpeD09Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kang Wenlin <wenlin.kang@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 7/7] mm: Remove unused vm_brk()
Date: Tue, 25 Mar 2025 07:33:31 -0400
Message-Id: <20250324231430-2c7f5efdb1bd16bf@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250324071942.2553928-8-wenlin.kang@windriver.com>
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
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  2632bb84d1d53 ! 1:  c5b8fd8379e4c mm: Remove unused vm_brk()
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
| stable/linux-6.6.y        |  Success    |  Success   |

