Return-Path: <stable+bounces-144255-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A10AB5CCE
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 20:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C2624A7B4D
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D242BF994;
	Tue, 13 May 2025 18:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uUs46A5q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E212BF964
	for <stable@vger.kernel.org>; Tue, 13 May 2025 18:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747162251; cv=none; b=CKPEE3kFyzXRvE3gsoawl5pBJMKV+KtNFpYltafcJMRHZmytXqIcM5h6hZoG0i6BM1g8+vq2Jj9aCfqekbdU/O+8K/qi8Vhlso+Vz9RfsBiqQ9IR3ZWDAjxQYgxCs7Spv8sDndgsx6cRqc5G3UszpaQ3LImrZ1FBzraAd3KrWIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747162251; c=relaxed/simple;
	bh=1MZgwqdNuabU1oqa2MTGWDY0XTdxvB7wJ+7Ep3Y3+WU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DedijvJ13oTdEVJeJaT8GCnIg91HshMgDu2rH3Pf5+jUtqPD3Xr9TqnNsDgioNKpwA2CoXpoPgkfs64tEg7umiEmq9O/wSY5BSUTwLbhydNaBAfC6+dRQnMuFyl5AidYGqTqhKlwMnIEI+Te3yPTt8owQKm0xUL05mbuviimjwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uUs46A5q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B4DC4CEE4;
	Tue, 13 May 2025 18:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747162251;
	bh=1MZgwqdNuabU1oqa2MTGWDY0XTdxvB7wJ+7Ep3Y3+WU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uUs46A5qaOfb2xnoCirHSbqIXto8l9crD98peyblW9atr465Rbem0z6dr3GjwFsCo
	 WDrLFlbKJLXjYr1IxGsOLfeNc+tvZlgreGcSLZGEDXU+VPnJ4Efk1HjjTDajvp8S/y
	 2y1cdoX6tpmr08ih0o/wYME6narHHa10sO3c7i7rZV+RvKt6fy/l42tAnY65bfjzqh
	 H2+LSSsB/CHty2Mh96OXWGTev/InHAD2nWJpmJy1KrhwyNcwsJNVwXat24lIBXEG4l
	 w5d8Ss1Iq139BIN2C7XBd9Jq6Bvk+9Iv/hlfZwSQY9p8Fo7Rm8zdXqAUVNKMRCYC1H
	 gipu8P/8EvVrA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Feng Tang <feng.tang@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] selftests/mm: compaction_test: support platform with huge mount of memory
Date: Tue, 13 May 2025 14:50:46 -0400
Message-Id: <20250513072716-af2af7f9eea8bf63@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250513010056.25926-1-feng.tang@linux.alibaba.com>
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

Note: The patch differs from the upstream commit:
---
1:  ab00ddd802f80 ! 1:  1ccf7357bb200 selftests/mm: compaction_test: support platform with huge mount of memory
    @@ Metadata
      ## Commit message ##
         selftests/mm: compaction_test: support platform with huge mount of memory
     
    +    commit ab00ddd802f80e31fc9639c652d736fe3913feae upstream.
    +
         When running mm selftest to verify mm patches, 'compaction_test' case
         failed on an x86 server with 1TB memory.  And the root cause is that it
         has too much free memory than what the test supports.
    @@ Commit message
         Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
     
      ## tools/testing/selftests/mm/compaction_test.c ##
    -@@ tools/testing/selftests/mm/compaction_test.c: int check_compaction(unsigned long mem_free, unsigned long hugepage_size,
    +@@ tools/testing/selftests/mm/compaction_test.c: int check_compaction(unsigned long mem_free, unsigned long hugepage_size)
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
    +@@ tools/testing/selftests/mm/compaction_test.c: int check_compaction(unsigned long mem_free, unsigned long hugepage_size)
    + 
    + 	lseek(fd, 0, SEEK_SET);
      
     -	/* Request a large number of huge pages. The Kernel will allocate
     -	   as much as it can */
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

