Return-Path: <stable+bounces-112013-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE01A25988
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 13:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B86273A69C0
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 12:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A913320468D;
	Mon,  3 Feb 2025 12:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+dwsCd7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6848F202C3E
	for <stable@vger.kernel.org>; Mon,  3 Feb 2025 12:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738586263; cv=none; b=ARbLaKLebuT/exdLax6xgFFKJ9vPpZgf+uMUrQtjVMkkb8oqnKfPK/aIg6D4dhRTVZryuJp3v7Zn9+j1GskPlmuKjvOraAitJ1as5qtLA88DBE1k3nSidVQ9kRg1ziADEqXiOM+lhp5+nzAiS/32pBOkl5Furih5zSczzXoGEcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738586263; c=relaxed/simple;
	bh=KOg2hwhLVrgmXV2X4FitzYgJCN+DgPzed7HGS7U8x4M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BdxqkjFALCJNKA/jxovsJgNe0eH4BpDU/Wuz7L8iacPEDFSPLds8BacfLyS71tNXx/2cxW4vfrLfkNLZ5SNSY7r4mI5AM7bit8osdi5IshSguDd8+5V12eezzMZxryHidtZOfkH9fdG6dsUM2lpttAljTtY8SkCqFWQVUmJn+Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+dwsCd7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B892C4CED2;
	Mon,  3 Feb 2025 12:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738586262;
	bh=KOg2hwhLVrgmXV2X4FitzYgJCN+DgPzed7HGS7U8x4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t+dwsCd7t1KnHizctjoMCoyaPOj8D72sYH99ttvq49IyeKBR6UEOIPlLkImuX4rjY
	 9Ma6AzIgA98fC+Vqz802SczFTqKkUcQdDRP9460tudEryleA8ATHlmg6BRHNQtY0sX
	 qwPcaJY1K37wcXEZOSHX9DYot2yhmyB9RPj1I4izMUygcLTrwYB5zhHi+aJ3YnMQBP
	 Q8QwVWCGGPo9T7W43hawVTwy244uDHmc5Qel+Fc6eVvxFYXpo3KU8+VWcZOZ7yx0Uv
	 iSE9oMCPgpjLQDZG38CIqNDLtGMMVauef7Ea7c4hamseKGaOu6QZe7zu7D4gb5DpHl
	 xckMoC8Y9ljwA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hagar Hemdan <hagarhem@amazon.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] nvme: fix metadata handling in nvme-passthrough
Date: Mon,  3 Feb 2025 07:37:40 -0500
Message-Id: <20250203063017-289a829a3da5601a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250203082501.28771-1-hagarhem@amazon.com>
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

The upstream commit SHA1 provided is correct: 7c2fd76048e95dd267055b5f5e0a48e6e7c81fd9

WARNING: Author mismatch between patch and upstream commit:
Backport author: Hagar Hemdan<hagarhem@amazon.com>
Commit author: Puranjay Mohan<pjy@amazon.com>


Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 6b42ded89ba8)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  7c2fd76048e95 < -:  ------------- nvme: fix metadata handling in nvme-passthrough
-:  ------------- > 1:  93de7cb0266e2 nvme: fix metadata handling in nvme-passthrough
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

