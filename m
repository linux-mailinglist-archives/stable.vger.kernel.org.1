Return-Path: <stable+bounces-100029-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3959E7DFC
	for <lists+stable@lfdr.de>; Sat,  7 Dec 2024 03:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A83CD16C699
	for <lists+stable@lfdr.de>; Sat,  7 Dec 2024 02:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4AA4A24;
	Sat,  7 Dec 2024 02:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nuoE86Ek"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30548323D
	for <stable@vger.kernel.org>; Sat,  7 Dec 2024 02:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733537244; cv=none; b=Z18C4ZCBUfNMWQR6LmmaKnjLAQ9ukRPuw1lArHLVptL+fVGyj3Mu/JnfnPU3WhWS/ECczip2jZfPFY9H/PWr9RiRmgd717D3/2ecbE5OSbnWUVy7y+BDeOawsZO+3LgdxGDCatWbgvXzAO660hWgteRW9QyOUJS5/KcYnansPbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733537244; c=relaxed/simple;
	bh=hZiO6fOzmYaYekSA2YutRCAgDUhpm2yp3yHjfcNMSzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tXpSG52autXZ2G41MXBGl5qfYrS2aaPzT92alhPgUcqWBhCDGCr7pvrk0+W3RFKL0lldFTlkOr31NGRp2SH4NDSNJqccERUMfmyq3QVNxGP5jkbR9IRXYZxU44BMUpNHZazALXpxdpRrOb00QpTeI6CtEcClBCTxHQ+tB75/L+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nuoE86Ek; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467F2C4CED1;
	Sat,  7 Dec 2024 02:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733537243;
	bh=hZiO6fOzmYaYekSA2YutRCAgDUhpm2yp3yHjfcNMSzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nuoE86EkZmNdwAPK6aRHkBB/UUGRwxKxryPD0xizyhaaHrRWAMyH6ryT9gvcT+lYC
	 ojRTl5WTQu2z1NTasW9jft4oSD4k5AHysq/3Cza4IhHs/5Z9esCdJdGBqG0dW4C1Kk
	 qee53dni1W+tM1C2I5j/uHm74535w6+l5JNy/pchmJ87axiUull89MbRR/4JEC/xnF
	 3Dv892Jn6HHUP5co50B3wPvhmL03AG5mpjuB4PvsG52VK2GaVV9/Spi12sXuQFUXRS
	 WccxoYQTz32mIjiq1TCRV9QVRoOdkrYBPkxrSdN3kBxsa9fFqkDO04gjdo17QQ9qt5
	 z/BR/o/OrRH4Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] mm/damon/vaddr: fix issue in damon_va_evenly_split_region()
Date: Fri,  6 Dec 2024 21:07:21 -0500
Message-ID: <20241206185549-31e3750dbe0c0bae@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241206175346.114805-1-sj@kernel.org>
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

Found matching upstream commit: f3c7a1ede435e2e45177d7a490a85fb0a0ec96d1

WARNING: Author mismatch between patch and found commit:
Backport author: SeongJae Park <sj@kernel.org>
Commit author: Zheng Yejian <zhengyejian@huaweicloud.com>


Status in newer kernel trees:
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  f3c7a1ede435e ! 1:  624d3f8e31238 mm/damon/vaddr: fix issue in damon_va_evenly_split_region()
    @@ Commit message
         And add 'nr_piece == 1' check in damon_va_evenly_split_region() for better
         code readability and add a corresponding kunit testcase.
     
    -
         This patch (of 2):
     
         According to the logic of damon_va_evenly_split_region(), currently
    @@ Commit message
         Cc: Ye Weihua <yeweihua4@huawei.com>
         Cc: <stable@vger.kernel.org>
         Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    +    (cherry picked from commit f3c7a1ede435e2e45177d7a490a85fb0a0ec96d1)
     
    - ## mm/damon/tests/vaddr-kunit.h ##
    -@@ mm/damon/tests/vaddr-kunit.h: static void damon_test_split_evenly(struct kunit *test)
    + ## mm/damon/vaddr-test.h ##
    +@@ mm/damon/vaddr-test.h: static void damon_test_split_evenly(struct kunit *test)
      	damon_test_split_evenly_fail(test, 0, 100, 0);
      	damon_test_split_evenly_succ(test, 0, 100, 10);
      	damon_test_split_evenly_succ(test, 5, 59, 5);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

