Return-Path: <stable+bounces-148360-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B62AC9E3D
	for <lists+stable@lfdr.de>; Sun,  1 Jun 2025 11:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C0543B7B18
	for <lists+stable@lfdr.de>; Sun,  1 Jun 2025 09:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5871A0714;
	Sun,  1 Jun 2025 09:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o68TLCL9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFE519DF40
	for <stable@vger.kernel.org>; Sun,  1 Jun 2025 09:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748770635; cv=none; b=VqFNQNKjE5OIir1vwM58aMavme1H4i3DP6bP9CshNzlbwrnotmf+kTs4k14n0AvNyGgOYuzFBBuHriioy/pn75B2KWSgngTSaBS9brFG6ZEeip2HmVQVqJ+SZg29FOs2mEF7aAVl/1qOgHSft6hLEmr6V0I06LuxOHjwVRT49+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748770635; c=relaxed/simple;
	bh=r+VvSLwAUOcFf2TLAQ6MsWP+6WY45kVxdCjjLyfuzDA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=krs+ulDiijF7oB59yw5sJ7Wpm6+CrO0ZHqr+bEeuwIFWASZPzHwdsJLmugU6D0nmNwu/VcBAHRltOVRbY97ovVDyQu/Di8lyl6gVnseLymqaoLe6K4Es/CUPK9aKwthmYtruoNQl4mHCUbTyg7Dl6GOmPly6N3Gsg8GAk2HDVEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o68TLCL9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4A4BC4CEE7;
	Sun,  1 Jun 2025 09:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748770635;
	bh=r+VvSLwAUOcFf2TLAQ6MsWP+6WY45kVxdCjjLyfuzDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o68TLCL9UK4VFbrzZGv9Hk8cXDANos/fiu5ry/xWIWHRyTSaTGzBwFlaJrS/3GCP8
	 o/DbOjorR1TYpD3ZIvw2dgqchMrd6ZRB5eKA6QB4+EsJYVhnS89jSaFlT4v88TSBdk
	 kw4OYEu1bAeT4x+AwAhUySLDKIkrEM5BKDH/Vmc3WAmCg4Tn5j1adRyRrHE8566Bvt
	 BF+Yf5VaoHF7QPjcOFi00oQaogO1Rw8gwQuLhSt+FwmzqE0JP9wQt8s7+ytw26aVSh
	 e03kv09ykK5dLEDUH93UJrCq1aGMqJpSJyLlEtT+gdi4C8ie0nuiqBuTu137KI/2AQ
	 M1NIB5p3vWJKQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangming Wang <guangming.wang@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y v2] selftests/vm: fix split huge page tests
Date: Sun,  1 Jun 2025 05:37:13 -0400
Message-Id: <20250531222647-f5d1adda86e168cf@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250530045140.3838342-1-guangming.wang@windriver.com>
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

The upstream commit SHA1 provided is correct: dd63bd7df41a8f9393a2e3ff9157a441c08eb996

WARNING: Author mismatch between patch and upstream commit:
Backport author: Guangming Wang<guangming.wang@windriver.com>
Commit author: Zi Yan<ziy@nvidia.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  dd63bd7df41a8 ! 1:  11da32ef6e926 selftests/mm: fix split huge page tests
    @@ Metadata
     Author: Zi Yan <ziy@nvidia.com>
     
      ## Commit message ##
    -    selftests/mm: fix split huge page tests
    +    selftests/vm: fix split huge page tests
    +
    +    [ upstream commit dd63bd7df41a8f9393a2e3ff9157a441c08eb996  ]
     
         Fix two inputs to check_anon_huge() and one if condition, so the tests
         work as expected.
     
    +    Steps to reproduce the issue.
    +    make headers
    +    make -C tools/testing/selftests/vm
    +
    +    Before patching:test fails with a non-zero exit code
    +
    +    ~/linux$ sudo tools/testing/selftests/vm/split_huge_page_test \
    +    > /dev/null 2>&1;echo $?
    +    1
    +
    +    ~/linux$ ./split_huge_page_test
    +    No THP is allocated
    +
    +    After patching:
    +
    +    ~/linux$ sudo tools/testing/selftests/vm/split_huge_page_test \
    +    > /dev/null 2>&1;echo $?
    +    0
    +
    +    ~/linux$ sudo tools/testing/selftests/vm/split_huge_page_test
    +    Split huge pages successful
    +    ...
    +
         Link: https://lkml.kernel.org/r/20230306160907.16804-1-zi.yan@sent.com
         Fixes: c07c343cda8e ("selftests/vm: dedup THP helpers")
    +    Cc: stable@vger.kernel.org
         Signed-off-by: Zi Yan <ziy@nvidia.com>
         Reviewed-by: Zach O'Keefe <zokeefe@google.com>
         Tested-by: Zach O'Keefe <zokeefe@google.com>
         Acked-by: David Hildenbrand <david@redhat.com>
    -    Cc: Shuah Khan <shuah@kernel.org>
         Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    +    Signed-off-by: Guangming Wang <guangming.wang@windriver.com>
     
    - ## tools/testing/selftests/mm/split_huge_page_test.c ##
    -@@ tools/testing/selftests/mm/split_huge_page_test.c: void split_pmd_thp(void)
    + ## tools/testing/selftests/vm/split_huge_page_test.c ##
    +@@ tools/testing/selftests/vm/split_huge_page_test.c: void split_pmd_thp(void)
      	for (i = 0; i < len; i++)
      		one_page[i] = (char)i;
      
    @@ tools/testing/selftests/mm/split_huge_page_test.c: void split_pmd_thp(void)
      		printf("No THP is allocated\n");
      		exit(EXIT_FAILURE);
      	}
    -@@ tools/testing/selftests/mm/split_huge_page_test.c: void split_pmd_thp(void)
    +@@ tools/testing/selftests/vm/split_huge_page_test.c: void split_pmd_thp(void)
      		}
      
      
    @@ tools/testing/selftests/mm/split_huge_page_test.c: void split_pmd_thp(void)
      		printf("Still AnonHugePages not split\n");
      		exit(EXIT_FAILURE);
      	}
    -@@ tools/testing/selftests/mm/split_huge_page_test.c: void split_pte_mapped_thp(void)
    +@@ tools/testing/selftests/vm/split_huge_page_test.c: void split_pte_mapped_thp(void)
      	for (i = 0; i < len; i++)
      		one_page[i] = (char)i;
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

