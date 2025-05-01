Return-Path: <stable+bounces-139347-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA25AA6323
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 20:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8644E3AAEE0
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 18:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D851EDA2B;
	Thu,  1 May 2025 18:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvi7TQ/M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66221C1F22
	for <stable@vger.kernel.org>; Thu,  1 May 2025 18:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746125467; cv=none; b=SoG8MfIv9gwXKYfTqi4CGxdY2L4YZC5ZA4iqOrAAORP5kUjp0XMK5lNXcakNgBhBcAKX3PRKoWp62nIiWqjOVqXBiawR72JsJsSqn9OhWy1kNAptRjGMMAfD0EVIPgESXfzMk9D6Zc+rbUtqw0hlQxLBo4yCEvxCeVxbI5hr5Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746125467; c=relaxed/simple;
	bh=/q8Cl1WhlSuasvSCPfEBVZ8V9M38yS7+SepOXolvhTA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=svH1xYx2U8AlbygWo6fVp031K1WyBpVyLNx0Q5Z/nsmgkAibroAlgXVNwm3IlJ20yyImMMEhnIEK/9gQZI2C237wGQlWCC0Ty0gX22iAPuFVopLRkeffPMXE/QlSPAL0pGWS1uqgG1sTIlldaM2kHUbd6zGTLDeespWxMDSOqR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvi7TQ/M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 440AFC4CEE3;
	Thu,  1 May 2025 18:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746125467;
	bh=/q8Cl1WhlSuasvSCPfEBVZ8V9M38yS7+SepOXolvhTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pvi7TQ/MUYR0qLX1o1W/Uj4O8Wo9ix0v0/l58Ndl7SojvpZRvOwM0CnwY8sz0nRls
	 V16NBpI+X18QM/VkPs9ENbccW4ZKK7UCCdawTf3Yg0IUjYFQZKanimAUw5c+VANsIC
	 TpyC/DWH9eqAq5QP3P06tCQgVYIgp17lnxxkGG7UqFFlUkHiF7FgnYVltz5xHi3g9Q
	 w6TlbbElLlBsOdxLjsa+l3PcYyLcYTaB9+PCngVilEbc4cUos09ZsVGMZ47tKVEEno
	 I4dFbjUMsHs2hGTOvazH8t89NQWj8OcbWGtpn88K6n1YMFwpC6WJpAW0zbchEx9t3s
	 pguFp62C/+WGA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Leah Rumancik <leah.rumancik@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 10/16] xfs: make xfs_bmapi_convert_delalloc() to allocate the target offset
Date: Thu,  1 May 2025 14:51:02 -0400
Message-Id: <20250501125715-18b05e02dc6bedb5@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250430212704.2905795-11-leah.rumancik@gmail.com>
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

The upstream commit SHA1 provided is correct: 2e08371a83f1c06fd85eea8cd37c87a224cc4cc4

WARNING: Author mismatch between patch and upstream commit:
Backport author: Leah Rumancik<leah.rumancik@gmail.com>
Commit author: Zhang Yi<yi.zhang@huawei.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 36081fd0ee37)

Note: The patch differs from the upstream commit:
---
1:  2e08371a83f1c ! 1:  1ba14c6680bca xfs: make xfs_bmapi_convert_delalloc() to allocate the target offset
    @@ Metadata
      ## Commit message ##
         xfs: make xfs_bmapi_convert_delalloc() to allocate the target offset
     
    +    [ Upstream commit 2e08371a83f1c06fd85eea8cd37c87a224cc4cc4 ]
    +
         Since xfs_bmapi_convert_delalloc() only attempts to allocate the entire
         delalloc extent and require multiple invocations to allocate the target
         offset. So xfs_convert_blocks() add a loop to do this job and we call it
    @@ Commit message
         Reviewed-by: Christoph Hellwig <hch@lst.de>
         Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
         Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
    +    Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
    +    Acked-by: "Darrick J. Wong" <djwong@kernel.org>
     
      ## fs/xfs/libxfs/xfs_bmap.c ##
     @@ fs/xfs/libxfs/xfs_bmap.c: xfs_bmapi_write(
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

