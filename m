Return-Path: <stable+bounces-161604-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE363B0069B
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 17:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50FA1162367
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 15:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4909E274670;
	Thu, 10 Jul 2025 15:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EhD+Ibzd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE8622E3FA
	for <stable@vger.kernel.org>; Thu, 10 Jul 2025 15:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752161260; cv=none; b=SMiTdhZWuyImohsLhHff2dIoHVxzDb8BVFxefy9Gn7rhkS/w2ZL41f6d3eAfM8bsDiGSsKYzhG0TwQx2ebgzC6qgH6kEwocK8OKrTsTI/w6bikoq3tPwm1CcAx+i6Tm2lSQ62Czu1Cd1isjsR8FsfpM4TJvRXhyVsz7sCzz2Vjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752161260; c=relaxed/simple;
	bh=pKRdtFgALBbZdhxNfbWQ/uQxCdo+NLCTDjpwD4dQupg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=db1KVnN4uetb9kvk4IvQPm/TWytkvDRwlslDBqLOJTuFZhuu636oVUK5t4mpViaoBiSRQUGg+z/rys0vWqsWcRjYm64DWDxPIAX5NZS4LP6wHI+KupaAZ555dxwkdoV7PO7URWEuqywmm990lDQ2ZHksyPmjWcieZOTdzbYXNWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EhD+Ibzd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26EA6C4CEE3;
	Thu, 10 Jul 2025 15:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752161259;
	bh=pKRdtFgALBbZdhxNfbWQ/uQxCdo+NLCTDjpwD4dQupg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EhD+IbzdpBxvezK1gpiMxHRQ4vG/wnX/Mw31oF/iww4CG+wuhokmCUZkaFLqtkHD5
	 4KVHEAl5PkDuibtZ3SRy/RAGGSp8kZ+mVwDwVN0f1tanNE0j8g2GTyL5Jj3IbzG+aB
	 NBPszvVEGLLIOTPSySS4+n3HbBtR7xm4QXS7XL4cOKX5TLAJux82knHkJ9KidJZfvA
	 4eh4Wfn2bih9RpXtK8rGeeiSKefhJapw81GEyd2eW8WNOI7YB+BEZaynUxYnIkcY/K
	 09E3vRJxUyKvz2p8wDyfj1LELVLECVRbjO0PMnKm+hCFm6oB83F3fz8pCiQbCdt0B+
	 37PTopn1LBwOA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Heyne, Maximilian" <mheyne@amazon.de>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15] fs/proc: do_task_stat: use __for_each_thread()
Date: Thu, 10 Jul 2025 11:27:37 -0400
Message-Id: <20250710083544-7c837bb69eacc572@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250605-monty-tee-7cec3e1e@mheyne-amazon>
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

The upstream commit SHA1 provided is correct: 7904e53ed5a20fc678c01d5d1b07ec486425bb6a

WARNING: Author mismatch between patch and upstream commit:
Backport author: "Heyne, Maximilian"<mheyne@amazon.de>
Commit author: Oleg Nesterov<oleg@redhat.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found
6.1.y | Present (different SHA1: d95ef75162f4)

Note: The patch differs from the upstream commit:
---
1:  7904e53ed5a20 < -:  ------------- fs/proc: do_task_stat: use __for_each_thread()
-:  ------------- > 1:  acb7f8c64955e fs/proc: do_task_stat: use __for_each_thread()
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

