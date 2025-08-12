Return-Path: <stable+bounces-167133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6BBB22510
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 12:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 104B2506DE1
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 10:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D78F2ECD0B;
	Tue, 12 Aug 2025 10:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSRpRyR7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08692EBDCC
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 10:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754995937; cv=none; b=rWQwbKRVHBR8lKaW+xOkEz7DZiJU5/bBcMiP0u3h2sGt/Sx1HoYO1/WRqzj9h/6e5r9vUIwx11z42uviKgYegz24+m8oJCjbtGDXYvGpaBObMlsxlKnM9FrI0xRvn66Af3cs1yr7RIz1g6y+tluvmukF3O095bRVNjCPgDuRydc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754995937; c=relaxed/simple;
	bh=Iyx4GJBo2B6VsowD/0HRMXnJyeSD5QlcmFzFeBICrlw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n2UxMtKWQqYFYmFiwNB84a9dWhhp0ZMO4/4FeUOuJm+7C/ky5mWZNCq36OBDP/xdL4XekW05BsP4sjk6Lmi5DN9JDZCvLMkZ9xXUS4NWe1bYKdWDRBLz1L5kBze/jDzJ4FAluQinoC06t3f1ctEwlhHwniNu3PNQRN7VeN6ju/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uSRpRyR7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB465C4CEF6;
	Tue, 12 Aug 2025 10:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754995936;
	bh=Iyx4GJBo2B6VsowD/0HRMXnJyeSD5QlcmFzFeBICrlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uSRpRyR7wvG7Fcere47x0KkreRi+e3wxJ5vNIkDV8rzZNSfGlKh2RKj5IcN4Afmsr
	 93tZMMyF3iNvAq0mQbY8i7n+uCUPCqajxtwiAbfKj2CpJjcjhCcVmsNhWMbFu97loF
	 YWvLTXizSRDAaT2vTO5MEZVx1rJrk1/ECN0Tpd5KsGiVht3GY3oFn1JExMbQmMG6NF
	 fPEToYOS/OkpavUztpUxTo50NsLlgNC5g2FIOyVu1HuA7dUjA/8+jmvA6Hr0FMvB+Z
	 2OG7L94pBVT4b047MhSaPnR1npsOfx2I2yfCSBb9dsGDLCyg7hdB2FLdJraQSL9fVS
	 fSEt/sS6jW3uw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4 1/6] ARM: 9448/1: Use an absolute path to unified.h in KBUILD_AFLAGS
Date: Tue, 12 Aug 2025 00:12:33 -0400
Message-Id: <1754967255-31359407@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250811235151.1108688-2-nathan@kernel.org>
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

The upstream commit SHA1 provided is correct: 87c4e1459e80bf65066f864c762ef4dc932fad4b

Status in newer kernel trees:
6.15.y | Not found
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  87c4e1459e80 < -:  ------------ ARM: 9448/1: Use an absolute path to unified.h in KBUILD_AFLAGS
-:  ------------ > 1:  8bf09d3cd9a8 ARM: 9448/1: Use an absolute path to unified.h in KBUILD_AFLAGS

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 5.4                       | Success     | Success    |

