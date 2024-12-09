Return-Path: <stable+bounces-100198-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F5D9E98FD
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 15:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD1191887DED
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 14:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215E61ACEB8;
	Mon,  9 Dec 2024 14:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPupE4WF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D643B23313D
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 14:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733754919; cv=none; b=SfurRwF+qr1LU9xt8gMMoRQeODjViLheJWHMRdyj0kOGAjB6VaB9TnmhOtivahMgLKI0QyciBJXKgMpjRjidsEQwWiQEQzSt+yYqGIFfaHZzpk9b3O5orJyuGsWzB+9q+USp+bY/fHwOAgyKL8dk+tM5rmylREnPBHf7X8098NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733754919; c=relaxed/simple;
	bh=KyO7AmokUDRofLrMHQbiMF0EeAXTC7obyYHuQ3o0Tiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IhfIzf/f6mL7HXCWxVNha2l8V8U9Cp74ovdcK9+5o7z0OLWtDNQYyKUcncOnkyyuwo6EgBff/LGpjN4/kc8J3DMSU4OqrKttcUU5Ig3frsMO5nwT7TGQ7dEB8gIMCaN2M1fVJUuuz+Iqw+sojLB0NSFeycOdvire+bsNw1GvhRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPupE4WF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41538C4CED1;
	Mon,  9 Dec 2024 14:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733754919;
	bh=KyO7AmokUDRofLrMHQbiMF0EeAXTC7obyYHuQ3o0Tiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EPupE4WFhW8mz/5pD0JaNSZlPcl5mbwPrlGjP+Z5RcYODbQYzF5CMCp8X0ICGNbFt
	 2GtdFyD9BehUUoAzUP8X2dlNWJolh2y8kbmc5I0jqSa+q9h6c4mfvJo398wQmEbYNj
	 MVbUlh32ORKqjJkhXf3kjipC1tAdR2JpmOXB1CU0ReXQnfr4K519lBsh4Gin9aZi/j
	 atMj5tXpf05f1oAaBJ8GPNL0T8fH8xiwnq5lvm/AUeiwXrLQFo7hPoOo6xZ2+hdW9a
	 MhdHkD/U+yICHJDZJA9VCUMBSE1PnHSv0FkcTnE7GlOF3ILyVv0U8An38VvzlcuXmp
	 DghFbzujtrB1A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] cpufreq: amd-pstate: add check for cpufreq_cpu_get's return value
Date: Mon,  9 Dec 2024 09:35:17 -0500
Message-ID: <20241209074201-4c63d2b56d0c3523@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241209041951.3426114-1-jianqi.ren.cn@windriver.com>
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
-:  ------------- > 1:  f785bc9cf1853 cpufreq: amd-pstate: add check for cpufreq_cpu_get's return value
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

