Return-Path: <stable+bounces-163595-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF6DB0C5B1
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 15:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A8D2165D46
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 13:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F277D2BE059;
	Mon, 21 Jul 2025 13:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APtK5IuX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DF519E826
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 13:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753106346; cv=none; b=EzuRgZMHir3aivc8CmiSrFsZBfgkIuIVc3+9f97Vz1RWmW1DQ8eEBE/yZ1w+yUprexOHfoMCXjj4vGhrHDDvUDPFjfYMyE+BNtkKFxKxrPjrN5CGDn3zO/UhvorhWodXoRL8WfnxW0poLm1ZISfD0pIt/0a0x6sXNKzv8J+4xJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753106346; c=relaxed/simple;
	bh=1keuvO/X9Fr440IJd9XTO9H4QniJrHseG4GhIMu1cM0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d7zE6qCXp5k7djiGA3GVD9D+MEy7wmipqJJglAwutFMQHnVLgFNa9LmQdGFlPzyvSsBdP8lksc8GrBC4LYgAYRFZZSTO0Eecw7QI3GWstseqrg9IUBf9nzgaI3xhxcsbkS+ulK/09r7PXzXxQLaFyW1JoytBAX1P4vamtw/Vkl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APtK5IuX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68E7C4CEED;
	Mon, 21 Jul 2025 13:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753106346;
	bh=1keuvO/X9Fr440IJd9XTO9H4QniJrHseG4GhIMu1cM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=APtK5IuXoS4xkj7fIji+btSJwsp9vjMqF3iTD2Bt3NCXn80X3nsjMNGJAZAMRrNuh
	 injGxpBVI3/4kXJzvndIx7S1ZFd1MpDG0dk5ckGmVdz5iwRX7xwfV+wwvtFRjyE0xW
	 VcElfARu9Z5J+RXwsefh+h6Ur0WoTWw3N/9+DT1oIcAB3IO5PIEYcws2ZKrNdYmomW
	 RgDWU+Or8Hfa3FMOEzZv/9SntkB61ufHm4LB+zrHt35OnObbxRpM5qWQzIgw+amSd+
	 l93U7zQZas4QVLia7FMjJYoAd0I3rAjtjU3LA5ENtboDX1+kWSXAZwrEBJyutJcPq5
	 ZjXfxz4o6BRDg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y 3/3] power: supply: bq24190: Fix use after free bug in bq24190_remove due to race condition
Date: Mon, 21 Jul 2025 09:59:03 -0400
Message-Id: <1753105151-494cf565@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250721114846.1360952-4-skulkarni@mvista.com>
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

The upstream commit SHA1 provided is correct: 47c29d69212911f50bdcdd0564b5999a559010d4

WARNING: Author mismatch between patch and upstream commit:
Backport author: <skulkarni@mvista.com>
Commit author: Zheng Wang <zyytlz.wz@163.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (different SHA1: 84bdb3b76b07)
5.15.y | Present (different SHA1: 4ca3fd39c72e)
5.10.y | Present (different SHA1: 2b346876b931)

Note: Could not generate a diff with upstream commit:
---
Note: Could not generate diff - patch failed to apply for comparison
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 5.4                       | Success     | Success    |

