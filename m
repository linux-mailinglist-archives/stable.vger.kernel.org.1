Return-Path: <stable+bounces-100654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7839ED1DF
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 17:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E306D1885696
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 16:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A691B6CF3;
	Wed, 11 Dec 2024 16:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yw58MBAd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954ED38DE9
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 16:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934750; cv=none; b=jw7Az+ORS8BtKQ+CZm0NknnKb3GDGdVqc2Md7gcWGNfH3LsCPy9PYBRgZ8EPyeyU3ql0HlPlIhDPDlVj+BKCx2qdu1tjLBS1Ic7Ll9rE8BREfRBKAabXZUzGxJ8mATgjocNR3owUnWd8V7KeTu9KSJeALO0fgblDa7sjpusPYpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934750; c=relaxed/simple;
	bh=3TDg9T/nkXIFGJWuE77Va1srIvK5B5uxLCqG1sxZ2iA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e0JtchIxl/xPkewswatnEjwcBx5DLszOlB/mlqxg5bqrWrPjHIpmf4+8K/NKBuXy8GFOAmqCSqa6GbM02HEhsBef1fJPm4L3dlUMrJWZo/jd9DRpLm68fzisBauRZ2XZGtqnnS0FEEMJR9o3n1MQ7zaiVV2QYHb5Ipbt3r5P+kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yw58MBAd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0DD8C4CED4;
	Wed, 11 Dec 2024 16:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733934750;
	bh=3TDg9T/nkXIFGJWuE77Va1srIvK5B5uxLCqG1sxZ2iA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yw58MBAdc+xUzfdbfhyoVLA6BJoSCeNuTbT9s/qZypplOjDfBkacs1qEW3Yxspeb+
	 gtjORTg+l5rJpefU0LcST2KuveVmo5/kpx+IADjACI3e+X7cmxPOggaKvYXRSyw8Z4
	 aZ99ZtEMtGpB/4mS3+1X/d1f3BYy5CSqBmA14ZneUXec05h9jLKTDom1VXyIn1sWCO
	 wg04zEvv6FDUXPlJC+vpgcrdL7Jle0LeYRGmSKEhq9PSxipaz3bTy6v5E2xvLh+Vlm
	 g+w7iepkJIDj6Kzh+kMjmZn+XSnqMQpOwdNbl3MzBK9F2/25O4bmE2GjXMJ5vXxRE1
	 2ztCJ8xYphvzQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] cpufreq: amd-pstate: add check for cpufreq_cpu_get's return value
Date: Wed, 11 Dec 2024 11:32:28 -0500
Message-ID: <20241211081559-d63d73661277817f@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241211101520.2105475-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 5493f9714e4cdaf0ee7cec15899a231400cb1a9f

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Anastasia Belova <abelova@astralinux.ru>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  5493f9714e4cd < -:  ------------- cpufreq: amd-pstate: add check for cpufreq_cpu_get's return value
-:  ------------- > 1:  25946d9ece6d9 cpufreq: amd-pstate: add check for cpufreq_cpu_get's return value
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

