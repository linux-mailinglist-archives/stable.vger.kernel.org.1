Return-Path: <stable+bounces-143863-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16496AB4249
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 20:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 144841B6135A
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 18:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499422C032B;
	Mon, 12 May 2025 18:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRjAeAvr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEB42C0321
	for <stable@vger.kernel.org>; Mon, 12 May 2025 18:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073140; cv=none; b=HKO8oer+eK1yqDIm2LmP/i14LG1j47q15zfSoWViYRlozrImncdZFZf6k+ZcaV8PkAfzFf+LamXGHLxUvyd3YIiXemWyUsFDL22sLaRdIWyzQVt641p5ZF/U07fEg7fIKAzVgdacldrzp4UajgcD8Ylv8Cii9Rg8biK6lXvUsyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073140; c=relaxed/simple;
	bh=h7I6/oIdYPkQMdUoKxT3LyYL7uGmSen/dnkYWQfVlPc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mvcLdmCqHE9cGGgMrw1MdHlh6+yf8S0Tpka1+dHGy/76mEIw6oktC+feAqSSyByE11dphCqb0F1VYviIT1PX5Rs+BY6y7p2MNNAejmUghCk8sbYO642hsGLnss40S6Wu1ARH8ek1tpxGliGxQZZyZR3638q+5z4Xgm/n/nHVk4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRjAeAvr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7058FC4CEE9;
	Mon, 12 May 2025 18:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747073139;
	bh=h7I6/oIdYPkQMdUoKxT3LyYL7uGmSen/dnkYWQfVlPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qRjAeAvrrBbNX/vN/VcuBjVrZY57rrj0ZfWnjw6HDVeFFsMJdOmH4SIQnWk6TNdj1
	 Jn6IvlZwigV+Kk+9zEwoDjWPPhe00G1pmZRUXB+X5KDazAm2NaEL2/wp+tOeQofMF+
	 dXBiSaXLL4XI7xFRFTIRj8t8p+RoZQVv1l308GQe0843xR/f8h8sAdNUrEmvVbteMf
	 7OtIc0TghyrMgMV0vLEsySDbXcBALTpokCFy6WarzD2+qLACfYXGc9ADwHNdGzx+hP
	 N8e3yknUyIMYp1r3f10VDIGIc382EEIiMBQ2c+ifs9g+xHPqMw0MYMqBAWUOWd/GIj
	 6VlO9UvS1c3xQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] tty: add the option to have a tty reject a new ldisc
Date: Mon, 12 May 2025 14:05:36 -0400
Message-Id: <20250511205130-18e9222719e0fe14@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250509091947.3242314-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 6bd23e0c2bb6c65d4f5754d1456bc9a4427fc59b

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Linus Torvalds<torvalds@linux-foundation.org>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 287b569a5b91)
6.1.y | Present (different SHA1: 3c6332f3bb15)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  6bd23e0c2bb6c < -:  ------------- tty: add the option to have a tty reject a new ldisc
-:  ------------- > 1:  5cfd827469a29 tty: add the option to have a tty reject a new ldisc
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

