Return-Path: <stable+bounces-145982-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 261B1AC0222
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A49F1B6434C
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99845D8F0;
	Thu, 22 May 2025 02:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xk24trT9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BD32B9B7
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879553; cv=none; b=uxdkwMSonG0OrFeYSGHXnRUqeyTv15PSyv3dtMMhDHMSgkBHkaiI3eedXbRziND8ZXs9zc0TQYLnl4aMpfbaELqeIeYDiHfxVjTCL5reA/6s0EIRXYgF/ZeR89/5ILucGtN1YqBBFCUhtb4Xo4fbwGYh17b2s9VYWseZ1R9pMgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879553; c=relaxed/simple;
	bh=9Dw9jmM5NknDtHENpp3kTV07N1V9153zkQqRCJGHXOM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LscAaCtnRx1jG3om+t+oKFC6k5oCBHHZBT6aAh/78ppqUPezP5rP3LoDhphV6NVyad5sG9VKWl/95Mlbr4egbq2XFprKRWp/o3evU9VVtf6n5OLrxrey6J3pYsMPgvO95C0G5KvLgRICwMhm464OIJJ00e5hh6NDMedqTmKRZU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xk24trT9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC9BC4CEE4;
	Thu, 22 May 2025 02:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879552;
	bh=9Dw9jmM5NknDtHENpp3kTV07N1V9153zkQqRCJGHXOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xk24trT9ynn4NMERCbOYqR3k46Ybpne39vsGDxsErBl5tF/eLvF0Ljk4iGSiZ6Y20
	 S98rYkgXDj5UTUq/0nKQak8jfN2Gje93JMSRvPu7NE4f8OJMOv2GuF5T4Gipzsij1g
	 2ToDLytEJFulYyogtkuV0FZaVWFHYSuWkCD5z5f+bXEdfRezt8V4V4MlM7ACdJWEj4
	 ouPDyaqn5covXHrfROkYwdKndFnqSSP2DAcyUvWu3Sa1RpsZRzHTYxiWencflCvGfg
	 moMvSuaNHG73DUSRDspmNOaujnVI/L0NOgk0/EhQOZSW/J3aRaC+BOBMme5AmT1E1m
	 8j0kyzMC9QbJw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.1 08/27] af_unix: Allocate struct unix_vertex for each inflight AF_UNIX fd.
Date: Wed, 21 May 2025 22:05:48 -0400
Message-Id: <20250521200309-00704777a33680f3@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521152920.1116756-9-lee@kernel.org>
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

The upstream commit SHA1 provided is correct: 1fbfdfaa590248c1d86407f578e40e5c65136330

WARNING: Author mismatch between patch and upstream commit:
Backport author: Lee Jones<lee@kernel.org>
Commit author: Kuniyuki Iwashima<kuniyu@amazon.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  1fbfdfaa59024 < -:  ------------- af_unix: Allocate struct unix_vertex for each inflight AF_UNIX fd.
-:  ------------- > 1:  325285d9fc869 Linux 6.1.139
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

