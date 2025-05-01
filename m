Return-Path: <stable+bounces-139371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59776AA6386
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 21:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A90094684BA
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 19:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A1F2253EB;
	Thu,  1 May 2025 19:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lc4wtfyS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2902248A0
	for <stable@vger.kernel.org>; Thu,  1 May 2025 19:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746126606; cv=none; b=uoI8Lar3E54P+axEhrFU38kBlnD2IuFKFysaSdaxw+u4E+vz/oPPcRgSACAOt7YSihH7yI43+xGdSXVSvmSSDc7Ygm2IEBKeRIoR99nbT6uiXOerKRCSO2iXNB9oplaT67gV2jqIHGm62VUF3i1ySo8UGuKcFuQfwrINWIxtW80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746126606; c=relaxed/simple;
	bh=8LqFThVsrim4GMYYlgck9bLCD+RLUw8En/Oe+q2Yl7U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t+85l+yWZyu+0PEX5E+LZhPF78MWx2O2kR84VVzv8ZJI0roq4Ojak3KGHP7qonV5cs+avVsOYkjMiIMzyUyuN/CNZXG56u6VbJg6YYnikI6uIHJ0l+SM1P16+SjdDY5r7gVEiKCPV7YYxKIUjtpyv4EEnEfMtj7FWx/Dl4jV/Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lc4wtfyS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B49AC4CEE3;
	Thu,  1 May 2025 19:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746126605;
	bh=8LqFThVsrim4GMYYlgck9bLCD+RLUw8En/Oe+q2Yl7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lc4wtfySRrkjBjGZLAS3nQ72f754si8/3x/71Ag6uLpsl+2FBJH5Wpm9kcYQZCmTx
	 dYfPl/r+lnizVuzF2Ifaro8zD6nMbunI9arW3gMcSf3BDrKoXUk10ACjLzmXUjRKH4
	 aGPkTtKlgpTPmbBBC3RJkYsTkfSlUdHIJlyMRIgvyCATz+cHaoNm4R4vPBU23hjf8S
	 A69e81ZKKUsUVhD64zOWkbjeIVbxEr5ErxFNi76vO2sOHgFg2W1hn4lDjstRHkohtR
	 hlnbsCFrNIGNaT/fmVK01eaMmd/2DgHy1GTNnov3Gp1Kkq3SKL9GdX4DHIK+5x0aIT
	 vlWrPCdZoMUoQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 3/7] accel/ivpu: Fix a typo
Date: Thu,  1 May 2025 15:10:01 -0400
Message-Id: <20250501115019-bf67398d4c775f71@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250430124819.3761263-4-jacek.lawrynowicz@linux.intel.com>
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

The upstream commit SHA1 provided is correct: 284a8908f5ec25355a831e3e2d87975d748e98dc

WARNING: Author mismatch between patch and upstream commit:
Backport author: Jacek Lawrynowicz<jacek.lawrynowicz@linux.intel.com>
Commit author: Andrew Kreimer<algonell@gmail.com>

Note: The patch differs from the upstream commit:
---
1:  284a8908f5ec2 < -:  ------------- accel/ivpu: Fix a typo
-:  ------------- > 1:  ea061bad207e1 Linux 6.14.4
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

