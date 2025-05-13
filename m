Return-Path: <stable+bounces-144242-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A00ACAB5CC1
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 20:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30DCB19E86DF
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE322BFC7D;
	Tue, 13 May 2025 18:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGyejPRa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC3E2BFC78
	for <stable@vger.kernel.org>; Tue, 13 May 2025 18:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747162195; cv=none; b=juwn4+nhiMGct8pMxYnwEv9JM8Fs7vZVchF12AwzYlewZ1iDMQrASIYXohF9RvmW/AbKwA75JeGqU6gp2KERu8Aif2qK0uqM47zRjbXluKltjRc8L0TfmZEbV/3ImZHbTeiFfsvi+7d7fpef5LLhlRZL8e3mFbzqbPFEZ9kZf0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747162195; c=relaxed/simple;
	bh=bQ/qCibLPU393mJ/Lvx3b5AgywnRHHeUWs4ZxKeU07o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GEiFWaE+dtbDTJQyMZHSPBSNIi6NVZJTjUeYf7tKi5frXbTPb+sWjaZyUbBGHKGIUGd7JxNqgpPrBus/lhjrc3d9SpOjKAbVbjJIdKO/UENdoF3s+DAXJ6O2QpqnmImWSmSzk9Dz+MCwPvOniArdBxWT8WJIrKJ/qptglBbjafA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGyejPRa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0420AC4CEEF;
	Tue, 13 May 2025 18:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747162195;
	bh=bQ/qCibLPU393mJ/Lvx3b5AgywnRHHeUWs4ZxKeU07o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WGyejPRaENFOC+92/smGkSFnM7obzqlwN7hGSRT21FF0evb1j8Qmp4cq1nfVEVPIO
	 1GxTDIAMfsd9IuzVY7I+BOvYtpX5rTpus9qaNGAbio3ykLlRbfWm4TmoFxqXvHFAC7
	 R8mMamEexU4UPXvsVYe0an3DDBW+D++s6WSw4bhBsWa5Mzr7LA71xXZOr//qc5WE7b
	 ycKstzFEuyva80hYX3wW0BKYfW+xG1lDitXXrIpb5jaQVtKODIiLLJM7LeL9rH2mBG
	 2zfpN5FvMNtexuVi0vYzkL63ihY4OBaZ4nKwpU/waIya8dy3tpG/IE26UktuwRH0UL
	 39vGXioQA5Olw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Feng Tang <feng.tang@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] selftests/mm: compaction_test: support platform with huge mount of memory
Date: Tue, 13 May 2025 14:49:51 -0400
Message-Id: <20250513112902-67c201360cff774d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250513055831.93239-1-feng.tang@linux.alibaba.com>
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

The upstream commit SHA1 provided is correct: ab00ddd802f80e31fc9639c652d736fe3913feae

Status in newer kernel trees:
6.14.y | Present (different SHA1: cc09dec6cce3)
6.12.y | Present (different SHA1: 72669f82feb1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  ab00ddd802f80 ! 1:  a22426c38dd6a selftests/mm: compaction_test: support platform with huge mount of memory
    @@ Metadata
      ## Commit message ##
         selftests/mm: compaction_test: support platform with huge mount of memory
     
    +    commit ab00ddd802f80e31fc9639c652d736fe3913feae upstream.
    +
         When running mm selftest to verify mm patches, 'compaction_test' case
         failed on an x86 server with 1TB memory.  And the root cause is that it
         has too much free memory than what the test supports.
    @@ Commit message
         Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
         Acked-by: Dev Jain <dev.jain@arm.com>
         Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
    -    Tested-by: Baolin Wang <baolin.wang@inux.alibaba.com>
    +    Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
         Cc: Shuah Khan <shuah@kernel.org>
         Cc: Sri Jayaramappa <sjayaram@akamai.com>
         Cc: <stable@vger.kernel.org>
         Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
     
    - ## tools/testing/selftests/mm/compaction_test.c ##
    -@@ tools/testing/selftests/mm/compaction_test.c: int check_compaction(unsigned long mem_free, unsigned long hugepage_size,
    + ## tools/testing/selftests/vm/compaction_test.c ##
    +@@ tools/testing/selftests/vm/compaction_test.c: int check_compaction(unsigned long mem_free, unsigned long hugepage_size)
      	int compaction_index = 0;
    + 	char initial_nr_hugepages[20] = {0};
      	char nr_hugepages[20] = {0};
    - 	char init_nr_hugepages[24] = {0};
     +	char target_nr_hugepages[24] = {0};
     +	int slen;
      
    - 	snprintf(init_nr_hugepages, sizeof(init_nr_hugepages),
    - 		 "%lu", initial_nr_hugepages);
    -@@ tools/testing/selftests/mm/compaction_test.c: int check_compaction(unsigned long mem_free, unsigned long hugepage_size,
    - 		goto out;
    - 	}
    + 	/* We want to test with 80% of available memory. Else, OOM killer comes
    + 	   in to play */
    +@@ tools/testing/selftests/vm/compaction_test.c: int check_compaction(unsigned long mem_free, unsigned long hugepage_size)
    + 
    + 	lseek(fd, 0, SEEK_SET);
      
     -	/* Request a large number of huge pages. The Kernel will allocate
     -	   as much as it can */
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

