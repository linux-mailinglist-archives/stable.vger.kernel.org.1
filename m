Return-Path: <stable+bounces-132784-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 199DAA8AA3D
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 23:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23ABE169DDC
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 21:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F1225744B;
	Tue, 15 Apr 2025 21:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tiIZYNWs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC64C253357
	for <stable@vger.kernel.org>; Tue, 15 Apr 2025 21:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744753391; cv=none; b=fBMAtQGDtMLF+ODfPTESeNFPvdHisefbZ+iEBuRlCh29IBu+vhWMgm45G5xTT367+2A9qSwcNeovtMa0fCU8HJ05VLxnTioTUKUUB/RNLj8QjYQLbN52+X278AAFpf+kIc98n6drdmx4XFMFeWw1KtTOgVSEpbgKVMOniLf5oIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744753391; c=relaxed/simple;
	bh=TLUBCZeV8AGAabZewf+CpME5gWVMwINl+Gt7HuddyjI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a90aELPwYjjPWLJ7ghG/nGzEhDG+Z/0mUe5s7LMH620FLi1Ee2yIzlwvgdr07LlZPcVh7UsLT6YvTbujntxgLgu4BzdySrICLEMM9MkmYZcezrFd4l+xa3sn7GA4MPx/LdPmi3czB0LV8CQhZMI/iKf3pevDwDwfDMo0qDu1KR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tiIZYNWs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33BDC4CEE9;
	Tue, 15 Apr 2025 21:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744753391;
	bh=TLUBCZeV8AGAabZewf+CpME5gWVMwINl+Gt7HuddyjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tiIZYNWsqZBlMi0x8u2o7sQfq7O5U8YbQ6xrAOISzMtmadHqD9osLo+A4Q7fwULp5
	 VzaSbhBGrddV6PNH5dr+FFT4y6uGFppPYOKKl2O/9l5WqllbozF4cKw1gzKQI3pZ5V
	 qbf9TWBFacVMV/pB6A1jRrFokVEmGOxabGk/CrW949imF/Ty/W3hhA7joYR+VMtdPT
	 9dDJdxFnPZwJkqtvylXCiKMV7+7gMqCZdA1/NYrPsr523sFDs9RA4ffAl0vemHjmH4
	 P5SxCo2/FAgWyCrXJg80/InMF3EWKksRkI3K3mmAM/EcqmP2ROCChb1jVXYifVRE9b
	 Hs+7x+DZoUw/g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	jianqi.ren.cn@windriver.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] btrfs: fix qgroup reserve leaks in cow_file_range
Date: Tue, 15 Apr 2025 17:43:09 -0400
Message-Id: <20250415130158-29c6b6cda8bfccb9@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250415055123.3683832-1-jianqi.ren.cn@windriver.com>
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

Summary of potential issues:
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: 30479f31d44d47ed00ae0c7453d9b253537005b2

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Boris Burkov<boris@bur.io>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Found fixes commits:
2b084d820594 btrfs: fix the length of reserved qgroup to free

Note: The patch differs from the upstream commit:
---
1:  30479f31d44d4 < -:  ------------- btrfs: fix qgroup reserve leaks in cow_file_range
-:  ------------- > 1:  76fcd18539b6b btrfs: fix qgroup reserve leaks in cow_file_range
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

