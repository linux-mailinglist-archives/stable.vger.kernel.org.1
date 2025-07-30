Return-Path: <stable+bounces-165560-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D83B164A7
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 18:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5900A544D75
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 16:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DA22DEA6E;
	Wed, 30 Jul 2025 16:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbmFPyj5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025F02DD5F7
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 16:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753892962; cv=none; b=MUEfGfDapo+fXdLpYQJJBiW6wBMEaRiLZd9aMZFYjiJhsjsDI2VfHS5okT1EltYCpT5YCUADRXCLoVuVsduIEbXhWzkwjh5dvI1eKmx/qn5241W2h/3LsCSQ4C9BLD+wDuILV8sxnTTyrzZNwUdccmbOTDVC5V6X7bBRFLPsmJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753892962; c=relaxed/simple;
	bh=uQEfad1c9x2gHQBW0E3lJH/yMJ4lmLBNB7YoVwrxpmg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OuVYUsJUbwmn5B9ac5bArcEO/2HxWgz+HGFG1PfpjAgskMM8YLRG7bS0v18GQEiV5FgFrFeZnPUB3c7zkdQm2yoJ4+3EOJxELKNE1Lg5nPglpN4qTIi9MYhRKH4JW2hczfqfTCVY7RMLyLbFJE+PGFeTOVr2QIrecqaxHO8Z2Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbmFPyj5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 059D3C4CEE3;
	Wed, 30 Jul 2025 16:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753892961;
	bh=uQEfad1c9x2gHQBW0E3lJH/yMJ4lmLBNB7YoVwrxpmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EbmFPyj5n7nKYj19xLx2O8oeADMarCEx6f05qATMS7zRV67m6nCmVaMbkoPYU9xvZ
	 cCvYdeGOexj7I6r9TTUrsFLuJGBCGIHgDFzxGoDkNosrJW2YX9TzIHBdCHCESKqE8x
	 3VLhQYSYqiqUPeOc1r1sDv3pkm8nQ0B7i2HfNif5SLbxYqUSFqPIJqKJfX/AUpLM2F
	 /Qg6FW0oBlGwOZ5a/C4RYSHICQRvEKOMSVFHtsTOA9EELAxEOgT6AjPjcNm+zOyCpQ
	 ZeO2O/jHvnLeNnB2uuZ9K2cPjscumS01Ebj8oyuo1fi8+DNVsrYvsl4kR+5ppBXp/4
	 vfFXPb3/mDOIg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y 4/4] selftests/memfd: add test for mapping write-sealed memfd read-only
Date: Wed, 30 Jul 2025 12:29:19 -0400
Message-Id: <1753857363-2b20f7a2@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250730015337.31730-5-isaacmanjarres@google.com>
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

The upstream commit SHA1 provided is correct: ea0916e01d0b0f2cce1369ac1494239a79827270

WARNING: Author mismatch between patch and upstream commit:
Backport author: Isaac J. Manjarres <isaacmanjarres@google.com>
Commit author: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  ea0916e01d0b ! 1:  8d24baf25bd2 selftests/memfd: add test for mapping write-sealed memfd read-only
    @@ Metadata
      ## Commit message ##
         selftests/memfd: add test for mapping write-sealed memfd read-only
     
    +    [ Upstream commit ea0916e01d0b0f2cce1369ac1494239a79827270 ]
    +
         Now we have reinstated the ability to map F_SEAL_WRITE mappings read-only,
         assert that we are able to do this in a test to ensure that we do not
         regress this again.
    @@ Commit message
         Cc: Shuah Khan <shuah@kernel.org>
         Cc: Vlastimil Babka <vbabka@suse.cz>
         Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    +    Cc: stable@vger.kernel.org
    +    Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
     
      ## tools/testing/selftests/memfd/memfd_test.c ##
     @@ tools/testing/selftests/memfd/memfd_test.c: static void *mfd_assert_mmap_shared(int fd)

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 5.15                      | Success     | Success    |

