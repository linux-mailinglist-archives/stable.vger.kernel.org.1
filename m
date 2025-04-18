Return-Path: <stable+bounces-134600-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11892A93A02
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 17:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7305169A75
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 15:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A981D2147F3;
	Fri, 18 Apr 2025 15:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VavM0cRl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6821E2144D8
	for <stable@vger.kernel.org>; Fri, 18 Apr 2025 15:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744990954; cv=none; b=A83vnDPB7kKxcrFmXMUTG1RAnDUemGkzLj62+G+rQn0P67KMMkis7SO53b9P7neeuyt6bVZPC+japFVriErbhmnmjacTl5KNZ3VJk9VqNdK4Tp6fEJr4sln2lBPhsNppGqwNgdJ0DAYGADYN4EHJt7SDlx4VxI2gX53foEe/oJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744990954; c=relaxed/simple;
	bh=rjsETskN0Cmo9gyBHZIHsodtsb+TiJsEOiZL53DSS1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h32noSNcecZKPhroSEpniQ+obEc2j+fvWmu2mIO8g2RuHquwVQeeqEyPvsiBNfiJb7usU0b+GJLAvYi/Spfu2nGaqbPE+MJng3FbGwbnChS/2EoNExV+97Fwj1vMqjJB7oo3WVIsiwXbqA1hkqdLf2/92qovvZ3rk+RzjX8r/Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VavM0cRl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B85E4C4CEEB;
	Fri, 18 Apr 2025 15:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744990954;
	bh=rjsETskN0Cmo9gyBHZIHsodtsb+TiJsEOiZL53DSS1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VavM0cRlZ1RMyd6EjNphBmVyTBHpAJnp9dyXfzImbAZ7bZFVpyEMkleZ1Lb8pjzRy
	 zLgGL3hxnZM8UFwbu7nElL0ANrkcQgUNnjCzuzjqhFhP5Zb3DLKHJ3A5qNloe8II0x
	 8uCBsZvcshj3LZctqBWG1yBV2iLEUUvqN8oOnq+/sYORRkQiBFv067VV9deo/2DpEU
	 7oVUdJeozEPSb86M1HbEGjucRgHLnWNXeH0i1VP+ZlHrPpumB2LZYVkGKKyye/baZ3
	 mAL6wkqMNvRQ3uYVrpo3JSJsHxLwus2NeSG2JX2XUckBKb69af26McxJAdnJG34asI
	 62xqe1AMLFboA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 1/2] blk-cgroup: support to track if policy is online
Date: Fri, 18 Apr 2025 11:42:32 -0400
Message-Id: <20250418093539-8b7fc7e00568226c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250417073041.2670459-1-bin.lan.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: dfd6200a095440b663099d8d42f1efb0175a1ce3

WARNING: Author mismatch between patch and upstream commit:
Backport author: bin.lan.cn@windriver.com
Commit author: Yu Kuai<yukuai3@huawei.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  dfd6200a09544 ! 1:  4169a84a4fdda blk-cgroup: support to track if policy is online
    @@ Metadata
      ## Commit message ##
         blk-cgroup: support to track if policy is online
     
    +    [ Upstream commit dfd6200a095440b663099d8d42f1efb0175a1ce3 ]
    +
         A new field 'online' is added to blkg_policy_data to fix following
         2 problem:
     
    @@ Commit message
         Reviewed-by: Christoph Hellwig <hch@lst.de>
         Link: https://lore.kernel.org/r/20230119110350.2287325-3-yukuai1@huaweicloud.com
         Signed-off-by: Jens Axboe <axboe@kernel.dk>
    +    Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## block/blk-cgroup.c ##
     @@ block/blk-cgroup.c: static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct gendisk *disk,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

