Return-Path: <stable+bounces-99977-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BFF9E76CE
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 18:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B03CC188427D
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 17:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8521F8AF0;
	Fri,  6 Dec 2024 17:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="krd8Au0m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE6F206274
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 17:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733505118; cv=none; b=CqsnvQXh09fHwLdNi5Ze10YRnb4A65TFE8HpHmmbZ6c5fs1/IR07pOK/Mw/jp92g9pefa/lSdFDKldZXoy6smAP+PJCfTjGJeDVThYE9BCQjYRG3JB+Wa0qv6vNnmnRgKG2Qg0exSsFEv+DkaE5pHvFAhMv/dtC+hcojurmfxu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733505118; c=relaxed/simple;
	bh=NZNRZ54E+B78gafN1GHauUcQBU4I2YC2oqvWM528I7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YOaY+XpIyZoRjWkm4zu+hgbHCV8RMklcYVFiu1VbwA66aW4AxJqEEKYDxIIYUsM0h0rwt7pbzcIh/eSzUjSAOGWrWAYISEEbusEj2c545O4KyHrpifyiG7GO9RLERLg/8kG9EPikW1K5JqMchLggvSh4SLPa1n/Z0RlFqwPlBN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=krd8Au0m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C4DC4CED1;
	Fri,  6 Dec 2024 17:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733505118;
	bh=NZNRZ54E+B78gafN1GHauUcQBU4I2YC2oqvWM528I7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=krd8Au0mzi26rTf+TEWzGyZNjtcgxOyMoLTwhN/4pFIhylFKPjbmplGeEQ6N4KgW6
	 bF0Nrv9e9x0CwOtcBSQFm9DnKXMr6nwyUBOR4p4I99y+y2k0hgtZmhchSZKLgKdN0e
	 VPRmQ3YUBkufYX8hAvC0X3PmOGKitZyjBpb+tU2N5mnct89Lm2Ov9LSqflBNJjQXAE
	 rlfJDFWDHcMKbZZTChUg9yfCOF2dIafGRyrKhW6OKL3o9KT3oAMc18vfb/7Vi4L3cq
	 f87LY5cDu9YKHSLhjGYmM/yQSXx7qUBLKwRQ4KvT2BSrI3kyjVfswWFqZrEoKgXlGA
	 3lCwpeSaRAAEw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] cpufreq: amd-pstate: add check for cpufreq_cpu_get's return value
Date: Fri,  6 Dec 2024 12:11:56 -0500
Message-ID: <20241206093222-c92b9fd25b11a5f1@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241206104115.1273254-1-jianqi.ren.cn@windriver.com>
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
-:  ------------- > 1:  354e938883a4e cpufreq: amd-pstate: add check for cpufreq_cpu_get's return value
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

