Return-Path: <stable+bounces-163594-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AB4B0C5B0
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 15:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D24FB167699
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 13:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D582D8DD6;
	Mon, 21 Jul 2025 13:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZl2lGBA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8566D19E826
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 13:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753106343; cv=none; b=RW4N/X5RwKw17eIAJKWlYBgajDqkMauR2TqCJCPc/Bzc0fo18O47n+NDPkozoFoIM5Pe6yCftCxcBOHOQOjJrhdjMpCB9tzoeNNE4LyaWg7apJwudVgO/YvT5o+JkqPWxpp29cJIFdFCeGAuDHyTSH6TlIhUK9490jmifh7N67A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753106343; c=relaxed/simple;
	bh=HfG5Ey5dJXwLJ70Y9iv1lOHxXYt3I8kku4po52+wosw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NVv9Q0FQ59+8Q6bWJewOhZ5u258iEq5mFj6/wRA7x1QYPJHaUbjbkZDD02UT6/cQlN+t/ySknCJsY0fjuNfVQWddDyeHgnRuF0a4jUKeyKJK4BE9MFmsX5eW+q/lgvUdSllPIRQImCrHikPqAZ/yNzkZ8CzZ8+HG8yXnFNTAxWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZl2lGBA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6775FC4CEED;
	Mon, 21 Jul 2025 13:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753106343;
	bh=HfG5Ey5dJXwLJ70Y9iv1lOHxXYt3I8kku4po52+wosw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZZl2lGBAaQnXdyGkD8l/l/2WLzqULfVVZkfhnEttgYyf94c+k52zV65WdQkVExIBG
	 oQvPKZAu9gFj+eHEi9O1npsX3Gw9QanCdhbebgRYxakfQT427xYymj7BH+tRYgXQ7U
	 O6JMoi2GX4knWQF58vurPf0RSHphoBQ1TwjkwZpgSlMpwEHMlKCRkJVF3yhr5r0oGT
	 ueM4QfdXkJxH6wQW68R2zprG7A6riZwFwVmS91HrMKwesMTFZkSkdqnLprDVR46ROt
	 PXbxW+lWphsR34bgXXSZ2YV94kJbcHMGdB6ypqvThXU3YZc8Zoa88NPglWJIK1xGzX
	 xHFePmEq2myBQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y 2/3] power: supply: bq24190_charger: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date: Mon, 21 Jul 2025 09:59:00 -0400
Message-Id: <1753105092-09735345@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250721114846.1360952-3-skulkarni@mvista.com>
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

The upstream commit SHA1 provided is correct: d96a89407e5f682d1cb22569d91784506c784863

WARNING: Author mismatch between patch and upstream commit:
Backport author: <skulkarni@mvista.com>
Commit author: Minghao Chi <chi.minghao@zte.com.cn>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (different SHA1: 10ce6db6253d)
5.10.y | Present (different SHA1: 18359b8e30c4)

Note: Could not generate a diff with upstream commit:
---
Note: Could not generate diff - patch failed to apply for comparison
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 5.4                       | Success     | Success    |

