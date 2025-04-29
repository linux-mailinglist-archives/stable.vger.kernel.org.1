Return-Path: <stable+bounces-137083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA11AA0C1F
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 14:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71D5D46401A
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 12:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD6620E023;
	Tue, 29 Apr 2025 12:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pi/cyBjv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACE42701C4
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 12:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745931049; cv=none; b=TDmFu10SSGN8GxEGpyho8EkLAr4rlIo9ff+PbTlrcnKdxUtxmC95iO3FmDGzivAtjNZqD2wSyQNfovE8OAMqowPNOjEexhx9+RV6BviQViAepd9ihaaWZz+97otslB0OT4o7wKibdX2SBqIRFQsj1MYKNi/ArCmJ1NHqXwC6o/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745931049; c=relaxed/simple;
	bh=wz8X5FU0eRofZ+2PkODensp6mt+lqr4dt7jfLCNz4hQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jL0HhAAqi5HD62etSH08t/TlXqAV4ri7PrjCHqD8lmXpet0JUa3wfdtIFgF27OxE+J5BKhrIe4S2qhKvHhY4ro//sqYz4/H4jO36U9uLB/IUY7xvXIGnwtCPFlFuztEBl57SqD/DnCXFvxzhxU66Aw4nz3WRUaKhRA/5zJLR8h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pi/cyBjv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C253AC4CEE3;
	Tue, 29 Apr 2025 12:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745931049;
	bh=wz8X5FU0eRofZ+2PkODensp6mt+lqr4dt7jfLCNz4hQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pi/cyBjvLzfYAgxQ+lYmIuUiK7oiX1wMekEUAQUGBDw1qtfgPA9B0c0istPyMhqSi
	 stO+Sv4W7mEKSW1Gy9xQT4UF8wvrAormfwK92uZjRAg14+bjb4Iiv1nsOnItBUicUP
	 wqoBFs3UFAD9/F1E+CS9WEBPq0BMn9wXw6TQf8VEzDIN+DctGBMpvpE/cKmcUyJRZ3
	 s4p3vVqz3H8UDrNOl5en+3a4l4xnrkaUMGVCfkGIw3WOkypLmqPyy9OYMp4aYWOEYk
	 SskbRt2cQYqA8zN2Qc9FhqqCtftOGPythFwsBmsHHHBMWNe/wDO1Sl6BHjJ/DO9rM7
	 K1dxfBcWHzIpg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y v2] net/sched: act_mirred: don't override retval if we already lost the skb
Date: Tue, 29 Apr 2025 08:50:45 -0400
Message-Id: <20250429004035-abcce9e84c34be5e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250428074550.4155739-1-jianqi.ren.cn@windriver.com>
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

Note: The patch differs from the upstream commit:
---
1:  166c2c8a6a4dc < -:  ------------- net/sched: act_mirred: don't override retval if we already lost the skb
-:  ------------- > 1:  c4da0f421ec02 net/sched: act_mirred: don't override retval if we already lost the skb
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

