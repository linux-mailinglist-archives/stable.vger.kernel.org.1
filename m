Return-Path: <stable+bounces-126806-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4816CA724B3
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 23:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A9A63B1452
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 22:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78BF2638AD;
	Wed, 26 Mar 2025 22:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qokUbgcG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C80118BC2F;
	Wed, 26 Mar 2025 22:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743028560; cv=none; b=ra/5th/BS6jeHlxV2UxFV6BjjZIxyJFyq2rtHlDLtSfRTOT86s61EMg1Db+stKwkU28l+3BeCLAd3ykduKhg+6nptbtr/g8rFxuq5PICxdD+lS/2XaGMHM2SdI5/QAPQGxERWmgdA1jqJtC1qVyEiTHWm1eS3ehQZW7eJWFNPEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743028560; c=relaxed/simple;
	bh=eOTKzmRs+bwoW5lr5TNvNEtSGFqce0QMmgSQHH0xkMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=asi8w3SgjJ9NfDjpHKNM/aVFn6IoZuvJPC1LOYd34XXHt2hifodpm0+Z69U+q2GgkkhOmLBo4H4IVe32J0LjxbdT7mVni3Gl7x7Un2YFdVr+ExdI6odqguHXb0+riwmT8g4cUTphDRwiTFrVFeSxDN40Yyzhq0WhJeUHabgjYwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qokUbgcG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84079C4CEE5;
	Wed, 26 Mar 2025 22:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743028559;
	bh=eOTKzmRs+bwoW5lr5TNvNEtSGFqce0QMmgSQHH0xkMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qokUbgcG8rzF734QjCiM09F2xGV9YyKqr59sZjOR7SXH+rbIEC8RV46/5J2lVhZMu
	 m01RWqyOp5Fim68h4UYoKkQ3MO8gzKN0P3Eo9Z75jV4FyPM4fYlyz6A/N1kRCIfvGR
	 eheZ2qSSkVAtapZS8LVYJiulLAG2yXNVYadbWH6I2vJgaT49Z42O/nct4XmadMQ+V0
	 mSQEx0DWFd4iVX5671HXui+NsRYy7Q75LnDUwwhA2IV7mEpWYG90Oqow0nU1seA2hX
	 XGtxclvUk6yZlve3beJPvMVgE40IhRPdsvkgFNhrCkq0+WTm73TS9O//i+zYg001SQ
	 tRmE0bRsbimVg==
Date: Wed, 26 Mar 2025 15:35:54 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] lib/string.c: Add wcslen()
Message-ID: <20250326223554.GB378784@ax162>
References: <20250326-string-add-wcslen-for-llvm-opt-v2-0-d864ab2cbfe4@kernel.org>
 <20250326-string-add-wcslen-for-llvm-opt-v2-2-d864ab2cbfe4@kernel.org>
 <CAHp75Vd_mJggRRLfziWUf0tgr3K125uVBNh9VdSo9LHVJz2r_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vd_mJggRRLfziWUf0tgr3K125uVBNh9VdSo9LHVJz2r_w@mail.gmail.com>

On Wed, Mar 26, 2025 at 08:39:37PM +0200, Andy Shevchenko wrote:
> On Wed, Mar 26, 2025 at 7:19 PM Nathan Chancellor <nathan@kernel.org> wrote:
> >  #ifndef __HAVE_ARCH_STRNLEN
> >  extern __kernel_size_t strnlen(const char *,__kernel_size_t);
> >  #endif
> > +extern __kernel_size_t wcslen(const wchar_t *s);
> 
> I'm wondering why we still continue putting this 'extern' keyword.
> Yes, I see that the rest is like this, but for new code do we really
> need it?

Yeah, I just did it to keep it consistent with what is around it but
there should be no reason that it cannot be removed. I am happy to do
that in v3 if desired.

Cheers,
Nathan

