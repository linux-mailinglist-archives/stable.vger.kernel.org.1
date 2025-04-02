Return-Path: <stable+bounces-127440-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1783BA7979E
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 23:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ED6C3B3ABB
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 21:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A2215DBC1;
	Wed,  2 Apr 2025 21:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGqo7++/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258FC288DA
	for <stable@vger.kernel.org>; Wed,  2 Apr 2025 21:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743629107; cv=none; b=pRMVv7A9CsdbihK3BHyDM2PMyAt2NfobtyGtPEWRA9w2KJSH+eQ3PGu9Qn3G9Jq4Fcdq7EkYAYDNXAyoCcc/fV6NNolWbRft0WijUuo95/aUzn4qWEnfhxax78van9IzoAU/Oz4URzgncHKbu+bmUUGmHS8JhUEaxj0/FFCvS4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743629107; c=relaxed/simple;
	bh=YEUT4uLZzYgUPKVV4P1u/0huiAtbmZLG2lrMkAPXNyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=El0BA4lx11E0fDhS4BWhxpq8N2E9J2Rb5aInSDd+Rjmu0Ayd7CHquVEk//jRcZ9nGx5uJG60/3KT1wULZPuCVyC0BhcmWAJMH6p/gJgREHNQFccY3cyWhvq7+wcAheRDS2xC9ERAGzrKgleroMaJmUNtYYamYbjLISStYVkmAgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGqo7++/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C31C4CEDD;
	Wed,  2 Apr 2025 21:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743629105;
	bh=YEUT4uLZzYgUPKVV4P1u/0huiAtbmZLG2lrMkAPXNyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EGqo7++/DZh8F4WdLuw3FsLanuw5DqrjouM5GOxelOhOmG05j5D9rB2yN6018c+85
	 zTdlbW9TiN8vRwPfqmRqrMVn/80WLQHeGmKQ+EqzsBmh5JDnLdOv7keIQQq9m67AHV
	 /hhYINnHjXyWv8MXHP4Wj9RVkM5y8Pzh4wkWIpUf9RuEAQgsklSmmPJAsdzIqVzMHO
	 4IOSoT2yVZ8J3Y0iYHh+xUoH4+bKQ0MVkz6SUhS5ugYn1VvjDY702LVXEfMtSqO5Tu
	 J0uFyJ2EXEHO9a7q/eH0Ulg1lskgtuofi9kIxmysmqKki5wwDaS5OC6UGPqoqSnEHO
	 3pxQys47ThG0g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kang Wenlin <wenlin.kang@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y 5/6] binfmt_elf: Only report padzero() errors when PROT_WRITE
Date: Wed,  2 Apr 2025 17:25:03 -0400
Message-Id: <20250402135512-c05d3309eed84a41@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250402082656.4177277-6-wenlin.kang@windriver.com>
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

The upstream commit SHA1 provided is correct: f9c0a39d95301a36baacfd3495374c6128d662fa

WARNING: Author mismatch between patch and upstream commit:
Backport author: Kang Wenlin<wenlin.kang@windriver.com>
Commit author: Kees Cook<keescook@chromium.org>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  f9c0a39d95301 ! 1:  d7251c2864622 binfmt_elf: Only report padzero() errors when PROT_WRITE
    @@ Metadata
      ## Commit message ##
         binfmt_elf: Only report padzero() errors when PROT_WRITE
     
    +    commit f9c0a39d95301a36baacfd3495374c6128d662fa upstream
    +
         Errors with padzero() should be caught unless we're expecting a
         pathological (non-writable) segment. Report -EFAULT only when PROT_WRITE
         is present.
    @@ Commit message
         Signed-off-by: Sebastian Ott <sebott@redhat.com>
         Link: https://lore.kernel.org/r/20230929032435.2391507-5-keescook@chromium.org
         Signed-off-by: Kees Cook <keescook@chromium.org>
    +    Signed-off-by: Wenlin Kang <wenlin.kang@windriver.com>
     
      ## fs/binfmt_elf.c ##
     @@ fs/binfmt_elf.c: static struct linux_binfmt elf_format = {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

