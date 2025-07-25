Return-Path: <stable+bounces-164794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49151B12767
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 01:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 613841CE3459
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 23:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB34E262FC0;
	Fri, 25 Jul 2025 23:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dl8ti39H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B54F262FD0
	for <stable@vger.kernel.org>; Fri, 25 Jul 2025 23:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753485987; cv=none; b=tq10n9V64IvlDZxMRujRQKj6e7m+nXoT+tHaw7FuFgUr4TTq2AEa/1b8JohmDjUpQM80q+GYfMCSOb2wv5VTLJKU4qYSEEiJeX2HtkPpFr27gpB06v4b7WgghG9/9hlB7DQR5DOua7m/scGhCQGUG5jPPr8icFvEiifHBXGmtkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753485987; c=relaxed/simple;
	bh=lgzYbGw3gTkCoib8U7knbmk08y1P9IiKMVgNvvQW74w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UJPb5hv5Evrg7NyFZcOuXFhGEQHyOUNHkrSQzCsVtegL1US8nE4/45U2Kcp7s0kr1Xke8ZOBId8GwfijB1d+KEcmRVFWpTLEZuPuTd57yflULJpTgB+a7lGqUK7sG+HYu35uTd0f1LQFJ8Bf16Pezi2VU8X3AG3CEYa7pebkLJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dl8ti39H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0251C4CEE7;
	Fri, 25 Jul 2025 23:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753485987;
	bh=lgzYbGw3gTkCoib8U7knbmk08y1P9IiKMVgNvvQW74w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dl8ti39HRorjbug7id1hM16hsislVZ8efb0SdzxA4urQatQyIrsHdT6s5lqb729aT
	 QqMVehkySWq5SwFH/QjMI6am9ui1U7LFTHKV3hD3UjkMz3rTAPYocBDHZQsuFv/INE
	 uldOV+cWQSuY3fxLQI1OhRZVGpe381s+ZxHPHOZ4xohevklQqF3H9P6CAWMrTsMrWU
	 cd/qAFHQLrSW/lqxWalMhEncymKkT6LapgAX2dAiyAvRw5BfeW43ipMfPgswPeUJlI
	 6gmd/LK37ow5IPJu/pf1o2Xdh0eqn48zK3KbaUuAzyof5EfPR4vNUHrbCk1ug08fqn
	 uVH6VR9gVg4Dw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y 6/8] net/sched: act_mirred: refactor the handle of xmit
Date: Fri, 25 Jul 2025 19:26:25 -0400
Message-Id: <1753463983-79358008@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250724192619.217203-7-skulkarni@mvista.com>
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

The upstream commit SHA1 provided is correct: fa6d639930ee5cd3f932cc314f3407f07a06582d

WARNING: Author mismatch between patch and upstream commit:
Backport author: <skulkarni@mvista.com>
Commit author: wenxu <wenxu@ucloud.cn>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (exact SHA1)
5.10.y | Present (different SHA1: bba7ebe10baf)

Note: Could not generate a diff with upstream commit:
---
Note: Could not generate diff - patch failed to apply for comparison
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 5.4                       | Success     | Success    |

