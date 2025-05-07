Return-Path: <stable+bounces-142119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1125AAAE859
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 20:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12E259C2F22
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 18:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CFA1EA7DD;
	Wed,  7 May 2025 18:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="senatFYT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bG6FX6gL"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3753A1B6CE9;
	Wed,  7 May 2025 18:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746641120; cv=none; b=YFQH2sEW6hKbRJDJ8D97eLQ3MTmpzdzEuChKyEvEFyRK2HptqUvFJX0VKTN2VYN/2mKcA9A7WcDhV1u2Kr+wfNOu0BPFySd85udHEQ3EW4PG6FgWGtEF+DAWLP/cj25gFLGHPrehsbv4EuTLyjsROtyhhu22V6Dfo98etGK1Qkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746641120; c=relaxed/simple;
	bh=nQW2w4A5rV3QNKsQbd1MjdTNbp8yoCsX4DamhPMRvTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plswlgvcZMgJbMBXgIB2LHlOzDbRgBk5guyCGLaiNNo14EXrpdvgOgeoz05vXeNN50AfUVMcr6w1rwEg51XGT70AFxxyajmEnVQhdirwtrUxOBPwN/brDiVZ/ewsmF5aL4WAalOFrN2R6slKMDOeGxpJyRHrl5q7NVAMHRpAi/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=senatFYT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bG6FX6gL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 7 May 2025 20:05:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746641117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FXst0CMcOK/c0+0GH4at5bz4vSFgCore/pjeWNIxyRI=;
	b=senatFYT8Kfharf76k+o7V0D1E9zjXtBBm5+i91m5AiS3ym/bHHbAvjUDW4VRGIohccV5F
	mjK4VqQA0OSROOwoi7iqPQR1sMeP6oiIZKSKM+XgzS2mbGf8l/aEhPv7LHn6DfaNqfKG9R
	3i1YCkPzBSgK01lobdkzVSyfP19kSXgjzEgb/bHtRE7Lt7cOIrS1PPcJO4L8S0j9jsLkvH
	nBEvnTSIvaLKBPFD3izMk9fms7zsA8nYPbD+DgbiZTdCSn8HjLZ92YjgY6BJPhSHPUpbrI
	31SXywH7RZmiNZbXK/EYckN3on46Iwe2G1NRdRteqst6gyWOPvLOVasovMS+Cw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746641117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FXst0CMcOK/c0+0GH4at5bz4vSFgCore/pjeWNIxyRI=;
	b=bG6FX6gLGAiTxwnYsttDX9EsapsqZQRwFXgGgwyQsATxJ046bJ4YTztS7j6/z1mAxwZ/1a
	N7StPaN5nG+Bk6Cw==
From: Nam Cao <namcao@linutronix.de>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] riscv: Fix kernel crash due to PR_SET_TAGGED_ADDR_CTRL
Message-ID: <20250507180509.pbQ6A8b3@linutronix.de>
References: <20250504101920.3393053-1-namcao@linutronix.de>
 <c59f2632-d96f-43c6-869d-5e5f743f2dbd@ghiti.fr>
 <20250505160722.s_w3u1pd@linutronix.de>
 <d7232e99-e899-4e50-b60f-2527be709d2c@ghiti.fr>
 <570ce61a-00ca-446f-ae89-7ab7c340828f@ghiti.fr>
 <49897822-76c4-45c5-87ff-085c3f6fb318@sifive.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49897822-76c4-45c5-87ff-085c3f6fb318@sifive.com>

On Tue, May 06, 2025 at 05:29:57PM -0500, Samuel Holland wrote:
> That said, I wonder if set_tagged_addr_ctrl(task, 0) should succeed when Supm is
> not implemented, matching get_tagged_addr_ctrl(). Without Supm, we know that
> have_user_pmlen_7 and have_user_pmlen_16 will both be false, so pmlen == 0 is
> the only case where we would call envcfg_update_bits(). And we know it would be
> a no-op. So an alternative fix would be to return 0 below the pmlen checks:
> 
> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> index 7c244de77180..536da9aa690e 100644
> --- a/arch/riscv/kernel/process.c
> +++ b/arch/riscv/kernel/process.c
> @@ -309,6 +309,9 @@ long set_tagged_addr_ctrl(struct task_struct *task, unsigned
> long arg)
>  	if (!(arg & PR_TAGGED_ADDR_ENABLE))
>  		pmlen = PMLEN_0;
> 
> +	if (!riscv_has_extension_unlikely(RISCV_ISA_EXT_SUPM))
> +		return 0;
> +
>  	if (mmap_write_lock_killable(mm))
>  		return -EINTR;
> 
> 
> But I don't know if this better matches what userspace would expect.

I'm not sure about this either. The man page says:

|If the  arguments  are  invalid,  the mode specified in arg2 is
|unrecognized, or if this feature is unsupported by the kernel or disabled
|via /proc/sys/abi/tagged_addr_disabled, the call fails with the error
|EINVAL.
|
|In particular, if prctl(PR_SET_TAGGED_ADDR_CTRL, 0, 0, 0, 0) fails with
|EINVAL, then all addresses passed to the kernel must be untagged.

So according to the man page, returning -EINVAL is the right thing.

But arm64 returns 0 in this case.

I would say let's follow the man page, and leave it as is.

Best regards,
Nam

