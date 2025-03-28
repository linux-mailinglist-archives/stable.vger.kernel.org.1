Return-Path: <stable+bounces-126951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A28F0A74ECB
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 18:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 613823A69EF
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 17:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CD51D8DF6;
	Fri, 28 Mar 2025 17:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J02nBxSD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2422B1D8A0B
	for <stable@vger.kernel.org>; Fri, 28 Mar 2025 17:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743181383; cv=none; b=j+/HIUMuEdSLMFFewdSQqL8DcOc684jFLACaIqe038OAN4lXPxIewxYMJyT3BWaf3Rn3oz7rtdJ53HI8U5hRZAoGHOVac/sV3ZXUhP5D62dYYWgAQc5VDgcoramELDZCr3UJq9E8ZzsWg1gS7N5jOe1mOHqVRnwSgZ5vsOHnNqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743181383; c=relaxed/simple;
	bh=8s1j+lXoCRc3tdDTLRFPch/8mwlG31nhPY+gb3M6BkU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cudSyO/1gyVSKeOHC58cxsTnaIQhC+LG+q/XLBAl2fwSyEg6mCF1Z6GPRTQM7cQMzKSj4Jqu3ddDSkrYi0p04GQhvNFI64hzzZ4gzf6oj2Uga5hQnixdDz4T59M/YPaGLe3+6HjogmHHmld/p4V5V3DGI210cm46rTgEHk7xpD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J02nBxSD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7B7C4CEE4;
	Fri, 28 Mar 2025 17:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743181382;
	bh=8s1j+lXoCRc3tdDTLRFPch/8mwlG31nhPY+gb3M6BkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J02nBxSDyEZdKQl0X8Q3gRxKxugRi3x0+F/r8YS+vd2Av7GyDRRSrh7SxVztZb7SZ
	 otZf7V6gPBNoWEMphacaDuTP4ifuGiydsR2iNHiCUhgbEgV1r8d39mFaN15yfbAc7I
	 ejL+vFwU/MD6kl34zu9LVhC4d0/VA4gW4eiwrbC+5o/Q98H2ZkOtWRnaSEP1bp55IN
	 41BbkG8aNF8DcDeTztkknIeEDj9MxREn7/MvrdBj4NYJgpVQ8Y+7Te1L3rXa/KtWfN
	 TFWfh9eMKhVvZryjONisn4WzDULQZcy8cJEp/ZN5OLEc/BjZCK8JjUbnA3FPGp/1OH
	 9fYVsHcwD6Mmg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] scsi: ufs: qcom: Only free platform MSIs when ESI is enabled
Date: Fri, 28 Mar 2025 13:03:01 -0400
Message-Id: <20250328112922-c48f324afdf03abb@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250327091026.1239657-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 64506b3d23a337e98a74b18dcb10c8619365f2bd

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Manivannan Sadhasivam<manivannan.sadhasivam@linaro.org>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (different SHA1: f99cb5f6344e)

Note: The patch differs from the upstream commit:
---
1:  64506b3d23a33 < -:  ------------- scsi: ufs: qcom: Only free platform MSIs when ESI is enabled
-:  ------------- > 1:  e2ac4e6ae36e7 scsi: ufs: qcom: Only free platform MSIs when ESI is enabled
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

