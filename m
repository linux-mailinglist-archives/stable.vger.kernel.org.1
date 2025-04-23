Return-Path: <stable+bounces-135276-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E32AA9897F
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 14:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 111431B63299
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 12:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433BC20127B;
	Wed, 23 Apr 2025 12:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9F9Suiy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045721FF1A0
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 12:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745410627; cv=none; b=L8fq62RpTR7mXKbLM5CtW/G1KteoQw1ByuANGv1CRV2CTzMaYOrAaXVEXkSiNhWAKv/lI23nOFRi/1WUgU1hyzoHAcj/QtKOKcmsROg5r7tNu8/RWWD3JKt5L/vTbYQmXQV2z6aAeSvycx3VnZjicSARZ+03oXeXtNrT1/J76Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745410627; c=relaxed/simple;
	bh=CpDss3LBVP9tcyTwM6F9D353HVcrgrT8GC/0hOD1GUU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fUYev/Uls4nfkOLVvmCGbHmwg5jf7ta4ONoCsuxp3if1fHm/exu57uKOMkO44JEHo9xq3s+q6+GpB1kU1RzD90+ZJ2cqTRrgkNVmo6JPCB38ov8wemZ6DYEwSiZ/93uvAcy2OURN5vLYJBiRsiMgnM5WRUkMcPyjnjXAnCH4uH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9F9Suiy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB32C4CEE2;
	Wed, 23 Apr 2025 12:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745410626;
	bh=CpDss3LBVP9tcyTwM6F9D353HVcrgrT8GC/0hOD1GUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P9F9Suiyxev+XQdzKyp14LwkQ8MFRJiyQWioNpCAw0W1lf6U9VtOfZUE8IuhuX8lo
	 guL4nJ6Kq9qvZw8N3GCB8vJnbhnNQxdpKoLVVp4C5fvt47q+JPESThuF8Tz3djoVwZ
	 EHG41isT0CwElylwOkzmVHehJRt/tyKiwVYe8+3BGYxu1c1duJaOZN2RrIYr0HIHlj
	 IBgoqmt4iswr5GK9iJ7TPijo5ujq8cC6nZLA4T2971+++D27CjdVGdu1fSo/rGyiLD
	 kqNGZkCa5FFMbiwMPrjC6o/D9hMfuNiIYkHSiMbTUETjX6VHNWxl9ngsET6tpguoLn
	 IBLPJHyFTY0Tg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] net/sched: act_mirred: don't override retval if we already lost the skb
Date: Wed, 23 Apr 2025 08:17:05 -0400
Message-Id: <20250423073225-0a390e62cf6bb07c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250423085936.2892096-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 166c2c8a6a4dc2e4ceba9e10cfe81c3e469e3210

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Jakub Kicinski<kuba@kernel.org>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 28cdbbd38a44)
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  166c2c8a6a4dc < -:  ------------- net/sched: act_mirred: don't override retval if we already lost the skb
-:  ------------- > 1:  80f8a61846a5e net/sched: act_mirred: don't override retval if we already lost the skb
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

