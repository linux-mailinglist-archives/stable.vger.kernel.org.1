Return-Path: <stable+bounces-144668-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA63ABAA2C
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 15:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CFE7167141
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 13:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901B61E1A3B;
	Sat, 17 May 2025 13:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYX8oUQ3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFEE35979
	for <stable@vger.kernel.org>; Sat, 17 May 2025 13:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747487280; cv=none; b=qrTcMjq+mB9mYt8Q5DNdWQVSMiewAG44hPIYTUSBTQVR9ePKDoeelPNxgYnB9044NJEzd4wBMMgLCfc4JQLE9NVAIgFmMAFYEn3QrVG931Bpb1Qw0lpxUNz57Iw/xJLM0mks8jzOXSxRB+Y9Kvw5T8laTj4WqwKV0Fwm/sxpEII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747487280; c=relaxed/simple;
	bh=op/bCIQ2a4oH/8ajix7PAvuehvq5tlDru/ZkbDTiXEs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k10RERNruKbw9ZpT41yi5Vp8QZga9ohuJ82d+jP1Eyn60mClwfJvaLzexuTypPnSQXg2+5ecR5ZXvbb7Jdoj9G5fuhu2duwi/WnncE/wK6VDNJpy3ZMPtrYg6zSlpH9TnD2koCv0Vc0mFdXQ+XNW5tLFHUxXJWoPBfsBK7TrYDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYX8oUQ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B55BC4CEE3;
	Sat, 17 May 2025 13:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747487279;
	bh=op/bCIQ2a4oH/8ajix7PAvuehvq5tlDru/ZkbDTiXEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NYX8oUQ3XtY7UUeo47sVxZDY0NpJcTkC3DqcgBjHe0XxzdUcLv64CuknLkvxdNs8P
	 DPfCTBFoXVMkpqdUlHtui76ZZG5F/YZnfBfeLDqC8qE7qfACoqz8SigKS6Pj/MMVI9
	 siH4xYBz7Muwzv30EshMPPr/+kuKOXbp11FYCRFM3hO2XHFiECRKYax06RrqIdsphf
	 XoXvIAKnIMqaBQPmfvDbECC2rVnoPJX8b6ppC6YCIpJ8X11rDMyNu3eWu3wBQOjUVt
	 mMpBG8IDGTIJ1Xss3lpT1kHzYzNczbBypF8EY9xqBZoAiH+xi1XPPsQZkEwwhSrHAp
	 7332ox/ekZY5A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] x86/its: Fix build errors when CONFIG_MODULES=n
Date: Sat, 17 May 2025 09:07:57 -0400
Message-Id: <20250516211301-f99122a5a2e67592@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250516-its-module-alloc-fix-6-1-v1-1-f3b597b5ea35@linux.intel.com>
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

The upstream commit SHA1 provided is correct: 9f35e33144ae5377d6a8de86dd3bd4d995c6ac65

WARNING: Author mismatch between patch and upstream commit:
Backport author: Pawan Gupta<pawan.kumar.gupta@linux.intel.com>
Commit author: Eric Biggers<ebiggers@google.com>

Status in newer kernel trees:
6.14.y | Present (different SHA1: 562da7368caf)
6.12.y | Present (different SHA1: 4e02382eca37)
6.6.y | Present (different SHA1: 11982473786f)

Note: The patch differs from the upstream commit:
---
1:  9f35e33144ae5 < -:  ------------- x86/its: Fix build errors when CONFIG_MODULES=n
-:  ------------- > 1:  02b72ccb5f9df Linux 6.1.138
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

