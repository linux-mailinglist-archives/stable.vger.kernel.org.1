Return-Path: <stable+bounces-165568-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1149CB164AE
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 18:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A7D6546ABA
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 16:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCEC2D838B;
	Wed, 30 Jul 2025 16:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTsRzQlz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD5D2DCF63
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 16:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753892983; cv=none; b=AuCCEy8/IjzY+snuTcIkkljU+IaPkVxDWhhgAl1D7Kq+paPCgSoV90ukoJaBzz8LGBVfsXWagBaT9uJXHA1MDLYqXgef40YmZQ1qSdIyu/yEJR0R5aGfO8lxNvezpgfWe/wjB2MZUHDouuRxVNnBNdVxuAzNZEVsUE86IFkmkFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753892983; c=relaxed/simple;
	bh=dUSKiCbW/5BFv8VgPgajOc+Yfd8bz045YaZJdKL/N9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sIXAIRYqX1N2PEjtZMmIGhsT7f1iqZEY0A4vVppuYPbvlgZ5aNd8kw9ABXKRH3QNg0NfN4Db3UoAackkP9JOUy4he5enz1i/Y4py0s4Hh3qFO357JWPV+moNnHPkDLcVedjcwUMJzRV8U5p4MOJwuKQ6RHcRf7tjmicV+GF8ws8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTsRzQlz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B893C4CEE3;
	Wed, 30 Jul 2025 16:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753892983;
	bh=dUSKiCbW/5BFv8VgPgajOc+Yfd8bz045YaZJdKL/N9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XTsRzQlzKso3TDKgEtz6OIGvY/rzmU6rlNvxhTr/+iJb7PSqUi6hHNDYvxNsOgf/B
	 OUR4v0CvBCyi1XdcitZnYoD+ScA4oqPXrlouLd82ijIAWhRthR6mrm/gl1vnyx1v2h
	 Xi48YAcul9MBEQef+z7SnbcCPHhX+DK8dgS6GNDwKvISE0AXw6nGplAHom1UUJQDXV
	 0xAg8k6oxwfHHVa4yrBfaTJHNqQddDxmbvsRkJIXVMhZcsBSz8s2DsAJpCyQSy1rja
	 0dmtI2QhG/uQZrTUmNJxJk1sekcCOABTIWsE4T6S4FhRa7zr29VLJnzhFy8pCLJu0d
	 D3iuSDw84t6gw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2 6.6.y] mm: khugepaged: fix call hpage_collapse_scan_file() for anonymous vma
Date: Wed, 30 Jul 2025 12:29:40 -0400
Message-Id: <1753887954-1ae21ccd@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250730073956.28488-1-acsjakub@amazon.de>
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

The upstream commit SHA1 provided is correct: f1897f2f08b28ae59476d8b73374b08f856973af

WARNING: Author mismatch between patch and upstream commit:
Backport author: Jakub Acs <acsjakub@amazon.de>
Commit author: Liu Shixin <liushixin2@huawei.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  f1897f2f08b2 ! 1:  e3e5d640233e mm: khugepaged: fix call hpage_collapse_scan_file() for anonymous vma
    @@ Metadata
      ## Commit message ##
         mm: khugepaged: fix call hpage_collapse_scan_file() for anonymous vma
     
    +    commit f1897f2f08b28ae59476d8b73374b08f856973af upstream.
    +
         syzkaller reported such a BUG_ON():
     
          ------------[ cut here ]------------
    @@ Commit message
         Cc: Nanyong Sun <sunnanyong@huawei.com>
         Cc: Qi Zheng <zhengqi.arch@bytedance.com>
         Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    +    [acsjakub: backport, clean apply]
    +    Signed-off-by: Jakub Acs <acsjakub@amazon.de>
    +    Cc: linux-mm@kvack.org
     
      ## mm/khugepaged.c ##
     @@ mm/khugepaged.c: static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-6.6.y        | Success     | Success    |

