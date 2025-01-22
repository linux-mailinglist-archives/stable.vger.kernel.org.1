Return-Path: <stable+bounces-110180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8521BA193A3
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 15:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1A7D188438E
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 14:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A0121421F;
	Wed, 22 Jan 2025 14:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHPhK0eM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170FC21420B
	for <stable@vger.kernel.org>; Wed, 22 Jan 2025 14:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737555391; cv=none; b=HQocY5ubSvHDgQ3oxwbMNBAapVCRhokC/y4bqD/Q/Lj2zjbEc1wbLo76XDtCvKYf911b9jXWW1gnC3n97BJXwxcj0DqlgYppsQ5QbnAB69TEvkG8zavjHmpOvXA+i83EPa5KYBcd4JvNyqtWHOEKtH0597sjVdh9pvKp4gjYtYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737555391; c=relaxed/simple;
	bh=cuEYxbo2kHE0jn9UAIi2i5qCbze+1gd4hzPEZVZcotg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l1CRkQfc3wL1a/QAapxnqhenVpgyQgWMTpofk8meUZc6/18TYz9j3mqBpXra6OObx8Q1/Cec3cKJSvv1dkIvO8eDOq/RgTHWvRI8e8PWz1w9qcBUWA+5RbmKi7vOes58uDReAQtzaH5b5U2FYoWDEKotERWrsBwnjVKWRYtVOCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHPhK0eM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F51C4CED2;
	Wed, 22 Jan 2025 14:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737555390;
	bh=cuEYxbo2kHE0jn9UAIi2i5qCbze+1gd4hzPEZVZcotg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AHPhK0eMYm/VOigW6z0qCFpG8c7K9Z1f/8EZI4l01xZm+b0apBVttJkSfH5gNmQp1
	 H3fqsG8nh6a5vw3B4bR2BjoMdgti4D8lc6UME/rGxddlp3n0CsbTmdOf72w0qeon0I
	 akhQUJ/HZ5FzGxS6QXAkgqqcdNT3qryimvKpKDcDpKQWJK79dQJbUwPZnm7ABNs753
	 ZcyWeFvTjz1QNjwdSC9LYTtX2ZQhhxixxj/fIkLy5Ok3blw39k4GgnUFqFsGm/Wxi8
	 q4srNF2jp9glQHElRnBkzPyuvWfCm5VDnKp/dlAZazFxoi6fzc6XszxyDXoArZ+9Sa
	 oNT2izp4Dwp9g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Finn Thain <fthain@linux-m68k.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] m68k: Update ->thread.esp0 before calling syscall_trace() in ret_from_signal
Date: Wed, 22 Jan 2025 09:16:28 -0500
Message-Id: <20250122084751-0099da4eff7526b2@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <8073f191a5759ba3bf582e4f88fde267@linux-m68k.org>
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

The upstream commit SHA1 provided is correct: 50e43a57334400668952f8e551c9d87d3ed2dfef

WARNING: Author mismatch between patch and upstream commit:
Backport author: Finn Thain<fthain@linux-m68k.org>
Commit author: Al Viro<viro@zeniv.linux.org.uk>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (exact SHA1)
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  50e43a5733440 ! 1:  b38019d2d357f m68k: Update ->thread.esp0 before calling syscall_trace() in ret_from_signal
    @@ Metadata
      ## Commit message ##
         m68k: Update ->thread.esp0 before calling syscall_trace() in ret_from_signal
     
    +    [ Upstream commit 50e43a57334400668952f8e551c9d87d3ed2dfef ]
    +
         We get there when sigreturn has performed obscene acts on kernel stack;
         in particular, the location of pt_regs has shifted.  We are about to call
         syscall_trace(), which might stop for tracer.  If that happens, we'd better
    @@ Commit message
         Tested-by: Finn Thain <fthain@linux-m68k.org>
         Link: https://lore.kernel.org/r/YP2dMWeV1LkHiOpr@zeniv-ca.linux.org.uk
         Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
    +    Signed-off-by: Finn Thain <fthain@linux-m68k.org>
     
      ## arch/m68k/kernel/entry.S ##
     @@ arch/m68k/kernel/entry.S: ENTRY(ret_from_signal)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

