Return-Path: <stable+bounces-158579-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20262AE85A2
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 16:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF35216DD0C
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 14:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBEB265CDD;
	Wed, 25 Jun 2025 14:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqLOGWxL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23B326560C
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 14:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750860448; cv=none; b=omfV854iXFDcWTpvlLeIbXnbN9QhENm6jM9C8JcZ4WxI5XEMiheb7/+o59PJ39ZXJbAEgzCdQXUw3bAwlwb5CxQXLrx7C+g2guUeT7YanaU8wpFTIn+2A3gxtBc/+KYU/jHOyQZjAsDtan75u3fANatpwsSi1OWVR1kEDFGDF5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750860448; c=relaxed/simple;
	bh=eS/ZUpIvsGaMXkY1ol2ZfvESms4g0TF9h1B9lWDM28A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pi1m/ySl1dZlnrEOhLjv3MfYOxz1dFPzXDzIZ3k95x5cSbSPJs1U+pUXNkhaylJn32QyFuSbVj6rW3WarIcfJBo7CKIuTCAKhP56b06WhNMFgDomaxGS+zplYyzI5+d96VsGpWGHMAN5PhywRN0rLgXwLWv11+zEu0nLIUzcUNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqLOGWxL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 769A5C4CEEA;
	Wed, 25 Jun 2025 14:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750860447;
	bh=eS/ZUpIvsGaMXkY1ol2ZfvESms4g0TF9h1B9lWDM28A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YqLOGWxLTNqJ2OZwE+1wQa/wSlXzEXXN/crnL8XBn9CBKQJUm6g/OJX3p5qVbiryt
	 Syxg9EYtB6A/ODvpOgg3xLT6ipJ6tdrf+Rmqiopt2KEuY1MR8+HrFYxQq4dZOk292D
	 3aaSiiLVz6soOwUNiT1QBJFmAf32vVH2iRiW0ANJdoReozEnKNJ7CyoWdVxdsjK+/w
	 18gg/hpYoWLxUwTHMWbd6uAMOIXqHYGlBxKwAKFchivLLO2+n0Xb2Q4pViDdPXeaVy
	 jp6QUQfoJ2BCjvCxzIIxt/EA27B3rXDMJAKBs1yVpyR/m09A0sRfsaUTS5fsySqbsi
	 WlPz7J5HRDMYA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y] s390: Add '-std=gnu11' to decompressor and purgatory CFLAGS
Date: Wed, 25 Jun 2025 10:07:26 -0400
Message-Id: <20250624172752-73e2bc78b3e7a168@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250623135456.1264864-1-hca@linux.ibm.com>
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

The upstream commit SHA1 provided is correct: 3b8b80e993766dc96d1a1c01c62f5d15fafc79b9

WARNING: Author mismatch between patch and upstream commit:
Backport author: Heiko Carstens<hca@linux.ibm.com>
Commit author: Nathan Chancellor<nathan@kernel.org>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 593d852f7fe2)
6.6.y | Present (different SHA1: cefbf9f892ce)
6.1.y | Present (different SHA1: 62d33b9e68bd)
5.15.y | Not found
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  3b8b80e993766 < -:  ------------- s390: Add '-std=gnu11' to decompressor and purgatory CFLAGS
-:  ------------- > 1:  81f0ce117f8c7 s390: Add '-std=gnu11' to decompressor and purgatory CFLAGS
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

