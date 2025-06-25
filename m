Return-Path: <stable+bounces-158573-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BBFAE85AB
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 16:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 974DB189F765
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 14:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACE1264FB3;
	Wed, 25 Jun 2025 14:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErH467c/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1959B263F27
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 14:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750860442; cv=none; b=IQFNkr/SmFLtvwaM7C6CHw+PZvgoPQ9G3fC+JHrrCB7MxHr2Rw4E02i2PpA0HRbJqOfUFiOrJc58SzFOxzwDUHRe08GrMbepBaLQDvWXqZ5FFsP21Wh7kb6VEUhxbezZ55sgzlWuDh6p5KpplKVXQ7t/MCD97NkIZo3J1fFyGFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750860442; c=relaxed/simple;
	bh=nraSRqxw07NJoeArNAmY6CdUO84Kofm5NmOTO+q1v8k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TnlhA67QwW2V3JexJEaVdDRTAeC85LbwlQCPIRdJQbvRDFV1nNeHuBn5nofFdeMoDTc/9eDIeGOADLGUO/n+bxupxlaYGEH4CnslZ9zhzIzSsnxSg+nRL6ExdcKm1iCAF2VJx5Uv4pCQn5n7K1Ho7nJ2HBj2RzCZlpLOFkHEF5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErH467c/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897E6C4CEEA;
	Wed, 25 Jun 2025 14:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750860441;
	bh=nraSRqxw07NJoeArNAmY6CdUO84Kofm5NmOTO+q1v8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ErH467c/x09l88+7/tZV841aigbbwkwVY6imrjl+USr06RHjk3zLZKMpPyw/mPLcW
	 Wc0eJIIlwUEqFgS0pkMVd2qvclIPE2kmcF0j9trdoY/kuLBIZm1nILDqgk7XdtxLVT
	 9SKdN5I0OP7JNS0aggt4OTyzBypYpzZ5X+yVAtp41FzFmIaAx1wZLOAcj9VVtrjjXK
	 C/nWH+UqCiKJHKRKkn1l/USgb/WLS8urX2cwekYjDLKpIM2kx+AVxtM7i0ODewjEtn
	 ofvibSW9RIpbzy+pAuL+8FoCmGuEIIVnGFdtYLbOZcuWAOHggaabTuJC3Cs9GGxYI8
	 w0HgnC+Fwhzwg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH for 6.1/6.6] platform/loongarch: laptop: Add backlight power control support
Date: Wed, 25 Jun 2025 10:07:20 -0400
Message-Id: <20250624174529-ce60f6879bc03278@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250623081337.3767935-1-chenhuacai@loongson.cn>
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

The upstream commit SHA1 provided is correct: 53c762b47f726e4079a1f06f684bce2fc0d56fba

WARNING: Author mismatch between patch and upstream commit:
Backport author: Huacai Chen<chenhuacai@loongson.cn>
Commit author: Yao Zi<ziyao@disroot.org>

Status in newer kernel trees:
6.15.y | Present (different SHA1: 7ba966be82c2)
6.12.y | Present (different SHA1: c452758dc2d8)
6.6.y | Present (different SHA1: b7a060eab6c4)

Note: The patch differs from the upstream commit:
---
1:  53c762b47f726 < -:  ------------- platform/loongarch: laptop: Add backlight power control support
-:  ------------- > 1:  58485ff1a74f6 Linux 6.1.141
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-6.6.y        |  Success    |  Success   |

