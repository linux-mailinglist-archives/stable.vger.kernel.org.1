Return-Path: <stable+bounces-128395-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E39A9A7C904
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 13:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 360493BC250
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 11:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2308C2FD;
	Sat,  5 Apr 2025 11:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+uy4Qu1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933718F64
	for <stable@vger.kernel.org>; Sat,  5 Apr 2025 11:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743854284; cv=none; b=Zko4yR4x5tiuR/YPldcnau5Isi9dnw2K7ZUY0wjMnuVazEKX4ac9bpoCouPe0i6IdObq32Xr+PtlTmBRDVZqK8RevzTbXg4mB9P1YEbTiJDRAM14T4PvY2ZbIpBPAwVDchAsSlEK11ssnEcibLzvRRK5sW5wMgn0ssbmAxNBQWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743854284; c=relaxed/simple;
	bh=vPsymyQccipN+azcxWTpszDZcQJ59edbPDKdAsAS4VM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LnnAXbXEAnNSh7o0lSdVYH8JZtVKfR/ZRSzex+g1K4ZWs2LVpN9SWVNosJsqt0ouh4Jrrk/B9v6MOjm0knNpcyYNNnU7fqPqrThTwY3RPinDf3PeoC837HEgu1odHV5w6kI5/U3MDHrGw8+ldwl8EhXbNcCc6C69DsFwvnJ7OMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+uy4Qu1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A0CDC4CEE4;
	Sat,  5 Apr 2025 11:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743854284;
	bh=vPsymyQccipN+azcxWTpszDZcQJ59edbPDKdAsAS4VM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T+uy4Qu1b5/lqEgwk3IuqTIBigqeqOe3imy+bE4v8BnP8Jw7Ax03Aeb/dkfZCA/xr
	 D+JyM0H8iINk2vxdI9pWFgWeac+EnLOzJjBqIaDfwx9dYUs9LSXirto+DSX5PnuMJ4
	 RSNgbtM93r+lq74Bc0XZ8W/cVIcLv7dlf+NmOIIjwxpP3ap37ITIt1sWt00SWPp2OY
	 17YPA1/E6iF2x4T7ve4xnO98ePQvw8X1S8C+NB18Voca9aandDY+6B7R+aqKD3JKlw
	 tDiDwymT1tmZlLpy62OTxetEwCirrjbkPzXJi6jiGYjr0JCdBgd7bFhBOdyGPojbyN
	 LUSAfkFfLVlXg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH RESEND 6.1 06/12] KVM: arm64: Remove host FPSIMD saving for non-protected KVM
Date: Sat,  5 Apr 2025 07:58:02 -0400
Message-Id: <20250405020633-fa4a8e0697f81ca8@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250404-stable-sve-6-1-v1-6-cd5c9eb52d49@kernel.org>
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
6.14.y | Present (exact SHA1)
6.13.y | Present (different SHA1: d933e2198538)
6.12.y | Present (different SHA1: f19a46cb5373)
6.6.y | Present (different SHA1: 73f64c676a6b)

Note: The patch differs from the upstream commit:
---
1:  8eca7f6d5100b < -:  ------------- KVM: arm64: Remove host FPSIMD saving for non-protected KVM
-:  ------------- > 1:  dc054c3889969 KVM: arm64: Remove host FPSIMD saving for non-protected KVM
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

