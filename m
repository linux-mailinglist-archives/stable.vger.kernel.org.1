Return-Path: <stable+bounces-165695-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6509EB1790B
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 00:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F6383B13E5
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 22:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4BD2701DF;
	Thu, 31 Jul 2025 22:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2TXk2JX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F97D265284
	for <stable@vger.kernel.org>; Thu, 31 Jul 2025 22:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754000355; cv=none; b=ArsvVrRwDMDjN07XndCrnifRe+1jaujzO2h03KPtqkvvGOi1B7xIJKiepZHsX8fCCp/UZmTnLu/OiYqXCMuo4tc1IduyYTG5poWM0bcwHMzq1B0htTMc2votYqAPVgjWfphQIuZ2Q9X7mN3RUntV8bojDFS2k6rtfkePcHb3Lw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754000355; c=relaxed/simple;
	bh=yuI4CQemnL7A5mVT5PGCHc6prjeV7Qy30Il4XFziPu8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z3eIP+cmWc71n/MedKvvRKb7+tFW5inFZo4oOFUJFgiW0qpapgpNMiXgUKi/eFEQMzi1xlaVi4i1ts7+yCf3klvdN9glfpy469BIoeRpf4y3XbxGTR9DoaaJYKsJfzsyJCX7/mNojq5NIwkqFfEIp3fHaApnJ65bOFmljmhsLDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2TXk2JX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48335C4CEEF;
	Thu, 31 Jul 2025 22:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754000354;
	bh=yuI4CQemnL7A5mVT5PGCHc6prjeV7Qy30Il4XFziPu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V2TXk2JXEwc5vsfS1FrOr6ZUSYEEcsKo8rQPuCIZELmIulshFbA3bn2IcNZ2nzDbU
	 cS/aziXTYp/zNOaMCthttRyUA+jvZHC0FQmMsA+wfO+/rvIb9suepT1tcHWXABUPwx
	 GuO7urwebfQl8CoLHaKK0XtBICq+knnuw3vYbMAEXonBtjy+mai+G9VxG7NW3dA5qo
	 0AwnQF6mLzYJejmKcRYC9E9ZJ/InvNws6fF0vC9Sw3Ge5CO3RV1p5EVI4Aom5PFOJa
	 s8GTD/7h0xiNGlHQbgmhkvzBYEccwcfqlWIJkNZT+iEzQxPneEkAbSnDg1gSqng8C9
	 qeXpr4ViefuOw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y 4/6] selftests: mptcp: Initialize variables to quiet gcc 12 warnings
Date: Thu, 31 Jul 2025 18:19:12 -0400
Message-Id: <1753976139-4f0c157a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250731112353.2638719-12-matttbe@kernel.org>
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

The upstream commit SHA1 provided is correct: fd37c2ecb21f7aee04ccca5f561469f07d00063c

WARNING: Author mismatch between patch and upstream commit:
Backport author: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Commit author: Mat Martineau <mathew.j.martineau@linux.intel.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  fd37c2ecb21f < -:  ------------ selftests: mptcp: Initialize variables to quiet gcc 12 warnings
-:  ------------ > 1:  95a487dc0102 selftests: mptcp: Initialize variables to quiet gcc 12 warnings

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 5.15                      | Success     | Success    |

