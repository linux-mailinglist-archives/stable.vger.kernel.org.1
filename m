Return-Path: <stable+bounces-125775-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C00A6C17B
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 18:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E902F3B91F7
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 17:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5867224B1C;
	Fri, 21 Mar 2025 17:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kqu3QFHy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B401BF33F
	for <stable@vger.kernel.org>; Fri, 21 Mar 2025 17:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742578123; cv=none; b=En4YWCNL/QW8f/UqrCus+51PTPDSRfvz2/mttTC6+P1J+fD1sIyYgzZUv1PADorb4+o2S7UkqcYfGiB4kHLbM4+0YmQaZyylM3I0EuuR1lW0iowRPZfWv3HzNO4Tkm337/m/KnWy3CHYbsbL/YbZLv0zDq3Vf270WBDutyDlol4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742578123; c=relaxed/simple;
	bh=WINTuifNxZiqKCPvrt6YTbjxxr3q585uvu6/l0WEIp4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m9XuKEQOv5gDnRQiRy2RdwzOTeEIOseilfh32PszZ/9lrZx+/g7g/KN2owz/aE8kKW6nUmMKL2lJYkwjmrfoHnbu2YZI6YDhWV6irAaxC3MZu7IncU93StBF5aR1SQrUfdoj71yiyZU9VY9nl9kb7aQ6ywmpo6oS1YjFXK0vyEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kqu3QFHy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E75E5C4CEE3;
	Fri, 21 Mar 2025 17:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742578123;
	bh=WINTuifNxZiqKCPvrt6YTbjxxr3q585uvu6/l0WEIp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kqu3QFHyoqHJCtk8Pv/sUP8AW8CKhhZIJ3eSLeqdkSx8VNa57qSijEkfeFJi+Ymrw
	 WgBAtZyKmnnDvVjFdf+ueBNtLm5BQ1Cr2xHy7A3qZ4DoAk+zRhN1txtgjx8zCVpYGQ
	 jMQjND5IRBogdvh5T15nUvVcZkLffzjYOmpZzI/idHoGRSgPQ1sR1kFQ+RnGh2wch2
	 nVIHxR2uetHB3+0CiA7xpBXpdjl6f/3IRSIjTc66a6+yRPXORJcIGI9H2uqEHi4UAB
	 P63imqGCTWxW6ZDX2QRhdRmCJerH2hjmUH3C+sYMhvp0ceGf4Lb2eFDUDzwMobGgo5
	 XFcI2Y55UwoRQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 3/8] KVM: arm64: Remove host FPSIMD saving for non-protected KVM
Date: Fri, 21 Mar 2025 13:28:31 -0400
Message-Id: <20250321115803-0b9d9919a4b1ded3@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250321-stable-sve-6-6-v1-3-0b3a6a14ea53@kernel.org>
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

The upstream commit SHA1 provided is correct: 8eca7f6d5100b6997df4f532090bc3f7e0203bef

WARNING: Author mismatch between patch and upstream commit:
Backport author: Mark Brown<broonie@kernel.org>
Commit author: Mark Rutland<mark.rutland@arm.com>

Status in newer kernel trees:
6.13.y | Present (different SHA1: b52b812b3867)
6.12.y | Present (different SHA1: 5aa1f0fe0348)

Note: The patch differs from the upstream commit:
---
1:  8eca7f6d5100b < -:  ------------- KVM: arm64: Remove host FPSIMD saving for non-protected KVM
-:  ------------- > 1:  2ae6104034672 KVM: arm64: Remove host FPSIMD saving for non-protected KVM
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

