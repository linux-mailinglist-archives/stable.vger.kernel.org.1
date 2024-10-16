Return-Path: <stable+bounces-86524-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 622E29A1026
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 18:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93B001C211CD
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 16:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7F8210C2B;
	Wed, 16 Oct 2024 16:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSDtNnvj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB11210C1E;
	Wed, 16 Oct 2024 16:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729097795; cv=none; b=XDANzgIjRdHtI5TSdbyTugHo3HJFSMsOzpdjOeu+71M3tMDdXwSmzM1B/k+fCjgU27bbVf6fqB+9yPTuvwlb3Sd6NckGLiYUN1MENyugXzxbosOgejXtfqjyKjvAXfIiKCSrSeIbs0ngrn24Dtz0sY7xMFU5OIeyM4GWsLjNhyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729097795; c=relaxed/simple;
	bh=J4gS1FGlplHm9RrwafcRcFsITwBOWiS3jUhhKd+VZj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWI+r+1N9ncHeBft4UmxK76ZZEm4Y3kwvjU0O4dz1KpImMX9F8XRWbZvvRO/qZI9YB/5s0y+LLRagif2cDse8qP7ZtGkwdE4RGjtGXbgMiVFl/ZG5tS631UCjF7XuBKUHBDbSBcXW0Fm0mP3KTVkIQUCOixWcxqDeJhao7/AqhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uSDtNnvj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C121CC4CEC5;
	Wed, 16 Oct 2024 16:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729097793;
	bh=J4gS1FGlplHm9RrwafcRcFsITwBOWiS3jUhhKd+VZj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uSDtNnvj5YAUyrcN6vQghIBxe8+gzxGwwq+3C6x+L1EJIeGsKx395jdikje2uB7bN
	 C5U96insHJRbw5mmMuAb6Xs2tB66GswiHcE4mZCX1iw+WdYoHTsJ/ynw4tG3L7epud
	 VAx9HjT9yP4j+u8d3JhDIx6wNYZIRzFaoiFT+V9KwzG1N1LcywQUhMw7b7Ux/c6rtN
	 sGnDEC0FrUibAIYd0b5cpgD86azQZRWBnazmaSJyvvt7jessi64HmF2a4Fv88RdaSl
	 jUI4P6Naq6g4graXkHbu9VF/ip1kAfWEDloWFNfRe9FVUiWQAcLnxSm7mbRB11dJJr
	 zNyHrnpVOcqUg==
Date: Wed, 16 Oct 2024 09:56:30 -0700
From: Kees Cook <kees@kernel.org>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Jessica Clarke <jrtc27@jrtc27.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Heiko Stuebner <heiko@sntech.de>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Jason Montleon <jmontleo@redhat.com>, stable@vger.kernel.org
Subject: Re: [PATCH -fixes] riscv: Do not use fortify in early code
Message-ID: <202410160951.E825F7A5@keescook>
References: <20241009072749.45006-1-alexghiti@rivosinc.com>
 <1CA19FB3-C1E3-4C2F-A4FB-05B69EC66D2F@jrtc27.com>
 <3fe1e610-c863-4fbf-85cb-6e83ba7684af@ghiti.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3fe1e610-c863-4fbf-85cb-6e83ba7684af@ghiti.fr>

On Wed, Oct 16, 2024 at 01:26:24PM +0200, Alexandre Ghiti wrote:
> On 16/10/2024 00:04, Jessica Clarke wrote:
> > Is the problem in [1] not just that the early boot path uses memcpy on
> > the result of ALT_OLD_PTR, which is a wildly out-of-bounds pointer from
> > the compiler’s perspective? If so, it would seem better to use
> > unsafe_memcpy for that one call site rather than use the big
> > __NO_FORTIFY hammer, surely?
> 
> Not sure why fortify complains here, and I have just seen that I forgot to
> cc Kees (done now).

I haven't had time to investigate this -- something is confusing the
compiler about the object size. It's likely that it has decided that
"char *" is literally pointing to a single byte. (Instead of being
unable to determine the origin of the pointer and being forced to return
SIZE_MAX for the object size -- "unknown" size.) In other cases, we've
been able to convert "char *ptr" to "char ptr[]" and that tells the
compiler it's an array of unknown size. That didn't look very possible
here.

> [...]
> And I believe that enabling fortify and using the unsafe_*() variants is
> error-prone since we'd have to make sure that all the "fortified" functions
> used in that code use the unsafe_*() variants.
> 
> So to me, it's way easier in terms of maintenance to just disabling fortify.

I would agree: there's no way to report a fortify failure, so best to
turn it off here.

-- 
Kees Cook

