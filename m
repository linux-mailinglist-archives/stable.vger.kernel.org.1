Return-Path: <stable+bounces-144443-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 878B7AB76A1
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 22:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ADCC1BA674B
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 20:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA15E295517;
	Wed, 14 May 2025 20:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JP/dWng3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9951B2951A6
	for <stable@vger.kernel.org>; Wed, 14 May 2025 20:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747253690; cv=none; b=AnpKOLKLi2ByVyJsgKMT2cPT76eN+a+RprvhPx+ATJf3XAlggWk4R5JU/+uchLWNX3+RtK5vawEnHJIDlrAHgUewso2sA9kxQ8wrG86gr2GWZW2bWjxWRNlHuCnz55pXfnXsWix9p8tzYEkasuR61ixY7riNENLHTnT1uVwl+0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747253690; c=relaxed/simple;
	bh=I/PP3bIP//QN4AgXCwrV1Nh70QPItmMKJKkKCI2p7kA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VdgA+AT1a7cA5XaStSqZTXFjDa2CU/Q8C6QIAimCVEyJeFearp/oh9fEmvfDWOj6pBJMlVqkvIfFiPLrbGdk8kjcLfMhA27DeNkuyu2mUvqTwCAD+cgJeFoQq/Z6UF5qh59vIKa1Ppo1lJo8D7akQ7I/bWZQf1UmYCxs0n1z4GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JP/dWng3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07264C4CEE3;
	Wed, 14 May 2025 20:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747253690;
	bh=I/PP3bIP//QN4AgXCwrV1Nh70QPItmMKJKkKCI2p7kA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JP/dWng3uhAsVYk6njeBAicDeNI2qhr0wsobJGhaNhuUNQCA66y6FNhvvRp72v7N+
	 EVYlDVfsO7AwhvauaseOCWfG5BpJpGfUQRccPtMBtYRvctLCGyeWB1Am0eaHybbzdH
	 ZD45BdbGXIu5/Ntx+qSIxFY/WN2QS9FJx0U502d4DyiP1EEr8xbYKtiiAQGqsn4XqF
	 rgFGj6f6KMyjAlMMsVsAzzvp/Nh4tNAYc3zACoWpUjy5inPmqDLV0daxpskbNac/Xt
	 WoKVSdeBOX+9DCw1leEccSSlKjOPaAzpbXN8a42Cn43XITUDepPP+S4jC89J8isa0V
	 6wFiUl5G4d22A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 2/3] x86/alternatives: Remove faulty optimization
Date: Wed, 14 May 2025 16:14:46 -0400
Message-Id: <20250514103450-27f8ecfcc4c5a486@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250513-its-fixes-6-1-v1-2-757b4ab02c79@linux.intel.com>
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

The upstream commit SHA1 provided is correct: 4ba89dd6ddeca2a733bdaed7c9a5cbe4e19d9124

WARNING: Author mismatch between patch and upstream commit:
Backport author: Pawan Gupta<pawan.kumar.gupta@linux.intel.com>
Commit author: Josh Poimboeuf<jpoimboe@kernel.org>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  4ba89dd6ddeca < -:  ------------- x86/alternatives: Remove faulty optimization
-:  ------------- > 1:  02b72ccb5f9df Linux 6.1.138
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

