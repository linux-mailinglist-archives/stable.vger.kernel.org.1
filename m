Return-Path: <stable+bounces-134685-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2392CA94334
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 13:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61958189A07D
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 11:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3321B4244;
	Sat, 19 Apr 2025 11:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JuO+WMHK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00AC18DB29
	for <stable@vger.kernel.org>; Sat, 19 Apr 2025 11:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745063235; cv=none; b=HMZbI2Dhg3ccPkHDh4lHFfr+uAhj5VYMxNsry/dHngACWxFZrxZYLM7EfIxI8+iLsCQT8Q/Fxi4S6iCPGW4CkWPsutnhrG49/mH0f0gAE7DcB6sEyKlXBqzMoZbbzsDe1yve+R1OdHkKb8ESSIQ7idR4JGK0ReX2aRz0y02yuxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745063235; c=relaxed/simple;
	bh=JNuaHXPfYThxrvd64YCHcdbIk39VyFxBGGVvOA3JOMo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QLFUnpBDOk6CUswdB2WLiQLzJdlEINIz0Kvuh7hdQHTO7P9xshREAQupjPaOMTzvC36bmmbLHUviix+miEcNifUxOEvSukPrcmGBgFuIvfwPOLfzz5N4IaUJklQyabjdvVmiSO59FGJjltFl3jMCnZhIcrW0UGbrzVkyNzTgXHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JuO+WMHK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65EEC4CEE7;
	Sat, 19 Apr 2025 11:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745063235;
	bh=JNuaHXPfYThxrvd64YCHcdbIk39VyFxBGGVvOA3JOMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JuO+WMHK1HoFpLRf59OBm+EV2gkEW8POCAmSLjAXDqfbLTmoj0r3xCVtsevZ298Bo
	 8poxUaScneMxKIQZnL8AIKuvf/8PZ+76WTa+lZzA/AsYcD1hg62gYUJcwZMgn9Ubs8
	 BZz9vvUpZuY2FdAu3lPyUQaHMB74xdIfy04+m2QyvPrvhTfbgOsYwOkDe4/pcBA626
	 U81rkhG/dqVSDwms6Z+RKdqL/AVbZkjbXeek38UhSHuBGdthZwuYXPd5VAikQIO8Lq
	 JLxYQpuXBBtWzUCv+EoC+EgF9iNx/GNFAGQyARwqF+BxMur2Ns4mrp8WjrgrFTodtA
	 8FM66d7umHpiA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	hayashi.kunihiko@socionext.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] misc: pci_endpoint_test: Avoid issue of interrupts remaining after request_irq error
Date: Sat, 19 Apr 2025 07:47:13 -0400
Message-Id: <20250418155241-63c88ea48831deda@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250418120612.2019795-1-hayashi.kunihiko@socionext.com>
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
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: f6cb7828c8e17520d4f5afb416515d3fae1af9a9

Status in newer kernel trees:
6.14.y | Present (different SHA1: 501ef7ee1f76)
6.13.y | Not found
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  f6cb7828c8e17 < -:  ------------- misc: pci_endpoint_test: Avoid issue of interrupts remaining after request_irq error
-:  ------------- > 1:  4a42c26c5a2bf misc: pci_endpoint_test: Avoid issue of interrupts remaining after request_irq error
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

