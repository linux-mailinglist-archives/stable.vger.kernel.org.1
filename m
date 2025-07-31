Return-Path: <stable+bounces-165699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97259B1790F
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 00:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 193351AA67AE
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 22:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CF1276059;
	Thu, 31 Jul 2025 22:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYkixvyp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB153265284
	for <stable@vger.kernel.org>; Thu, 31 Jul 2025 22:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754000410; cv=none; b=PTmLiWB1ke+x80uGMC1HlDtQXI2VyiOymEN9gcQHRjUu9TV0vFjskGxyFtAuhu8vqWdC/gz4Ku+82LeAvXd9GgksxANaQKfU6P12QOoRf5+OcydYvToTwBb8GVjdaN4wWzds9YuMX3aj/jHYj706fORmVeJry0cfY5/TroiD8fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754000410; c=relaxed/simple;
	bh=WS+UnjfeoVuu7C1yZwgTd7mouD5Vc1N9mJ1F0yBc6q4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q1VOKMdihsnem8j7SY0JuZfH/ukRUMGiW3INczy/j+/q6VCpCruRMglQEHiwze3rqbxeogVDy//XDEwODSiGVdS0yr7/ThEeAmYI5Z6BEbI4fVp7nuZHdzGrCqHriD4xF/tIa2ElGwnY0essTp+Vo6ubLo88I3tOtomIKaUJ4x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYkixvyp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D70B1C4CEEF;
	Thu, 31 Jul 2025 22:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754000409;
	bh=WS+UnjfeoVuu7C1yZwgTd7mouD5Vc1N9mJ1F0yBc6q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HYkixvyp7D9BWtPpg3Dbj8N7/1Qtrbp4htOnitaqi+rBCWRpSlMYCXGYU2K9kTW1L
	 lP4FR2OndjRkzhG6u8+k1B/+Xo1ys3+Hcrr3I66sQj4L9ux7vNwzN3jepAxdUGpWhq
	 3pUqUbTnTQ1s8JmUWGn9A/ZbC+zs0PwuUejfpOFmILYxoG/obLmPCb3ZKmvNK+m/kx
	 Z6zuqJrm4XP2CUi2awuYcT7SC2HlD6Ugw+Zox1CA4lK2I8OmFPM519QDnsMi5EN8ML
	 mtJZFroQoyxjK06DrXMmLH062Q0VHjJRhzCdGGcYP26Qm9KIjn4dsEZBbNnLAZUAxr
	 ov/DfhoHVrhqg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y 3/6] mptcp: introduce MAPPING_BAD_CSUM
Date: Thu, 31 Jul 2025 18:20:07 -0400
Message-Id: <1753976053-26ce73f0@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250731112353.2638719-11-matttbe@kernel.org>
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

The upstream commit SHA1 provided is correct: 31bf11de146c3f8892093ff39f8f9b3069d6a852

WARNING: Author mismatch between patch and upstream commit:
Backport author: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Commit author: Paolo Abeni <pabeni@redhat.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)

Note: Could not generate a diff with upstream commit:
---
Note: Could not generate diff - patch failed to apply for comparison
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 5.15                      | Success     | Success    |

