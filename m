Return-Path: <stable+bounces-110175-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56646A1939C
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 15:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED8A71882C92
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 14:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033B0213E85;
	Wed, 22 Jan 2025 14:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/9dd7SB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49FD20F990
	for <stable@vger.kernel.org>; Wed, 22 Jan 2025 14:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737555380; cv=none; b=mxoEJF6XeQV3o3Yyx8vPHvt2o86vHsn2fVBmayL0oquSv6iwVevdnqyFdEINvag+2iizKooJVh0iXYg8LjzUgX/yI0wWiPfn+Av0wzvULONlVRNgNjPxwMtyu24DFm5wMjLrIMNUx6zFHrdDxOeUjeSfpHD5NZORV7uqhNwwdaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737555380; c=relaxed/simple;
	bh=v0V3+8DerCz1uqEa5djUWIWhhhptAU/Kz1iYWyjjE4g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xq7AR5VG28QBCIJAMq8/CslepzZEOsQjCTkX9JB1i0ERrvMFOoYD6jO/b3zoaf+yk+XRUN75mdvkVdQfZroyVd+RI3I4jHUc+l2fS1L2qcckdijRZI2s3F9R6HiqzmS5V8Seq3GlzfxyjiW1AuXGRTt8JOxXyG8jOGBf1Fn0tJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/9dd7SB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A370FC4CED2;
	Wed, 22 Jan 2025 14:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737555380;
	bh=v0V3+8DerCz1uqEa5djUWIWhhhptAU/Kz1iYWyjjE4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p/9dd7SBDlrUQQzUD29Z+sNKQ5YsfAYWFRwM/GKjHawVUkx3jOHKJxlPD6tlgR+4T
	 q1uiTYuwU3y1/aLQSnadJGZWsobwldrgUuwcl0ZqX17yGeoyuPfJT9oAt5XXnxcLHR
	 ZWR8TzUGCjEHbMsPT2v3exm7beV06U6LRsi4/MN+rDhataZbLmcZjEDeOyJwTOd8i5
	 t6Y6f1k7Ik25j+G/We6tYv3r9mDhyzbAVep3JrEbe4tMPGml4zhPpcApxdiPRXMcGh
	 yT8+Po/KpTaFwBZtoOtxjZ190UzRd0wBNN9V462oQZvsC6jANDJ6i5JSsF/y6+NGps
	 QERV6JwZrzeEg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Finn Thain <fthain@linux-m68k.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y] m68k: Update ->thread.esp0 before calling syscall_trace() in ret_from_signal
Date: Wed, 22 Jan 2025 09:16:18 -0500
Message-Id: <20250122090647-9e1a7ea48b176609@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <590189176a007c7526f041dbf1ff0eea@linux-m68k.org>
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
5.4.y | Not found

Note: The patch differs from the upstream commit:
---
1:  50e43a5733440 ! 1:  bdb54357febe2 m68k: Update ->thread.esp0 before calling syscall_trace() in ret_from_signal
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
| stable/linux-5.4.y        |  Success    |  Success   |

