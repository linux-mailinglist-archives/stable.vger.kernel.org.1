Return-Path: <stable+bounces-155246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDD3AE2EF2
	for <lists+stable@lfdr.de>; Sun, 22 Jun 2025 11:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E226A7A2EF8
	for <lists+stable@lfdr.de>; Sun, 22 Jun 2025 09:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D2C1AAA1A;
	Sun, 22 Jun 2025 09:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yEAkt/Ao"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3238E1A8F60
	for <stable@vger.kernel.org>; Sun, 22 Jun 2025 09:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750583319; cv=none; b=ln+/sVkk1CAsVoJ5csb2Gzq58sW1oZn5TAmr9+/+a404lGPQjuo8zrbE1XS/HOeXzqXg8vd8oUtFG+NU5bxUVTPFrYWo9veqQi1aMAo2sBo6p6/J1DfbEHIt+t6qOUVFbycPa7n7HrG5uSvc2x+OtpeUNHyAX/0Qt5RnaTEyZKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750583319; c=relaxed/simple;
	bh=149m2/W1pZQwb9wZMsd5gXC2L05cqby5KB9yTTnuIJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZIPpqbp2WOUejAjafrsmL+NIErNyi682POJLVEUAeTURpd71hx807ZyNWu4Sy8uFCOr5J2pCuStiZkIg7plRsqR28/EFYF+ShPdUgMWUKX6kzppQ4dSsve5HlYSkjBx87I/zqfS5xHqEMeYC8u25FmEbC0tHbskfejJcnmLhW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yEAkt/Ao; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B52F7C4CEE3;
	Sun, 22 Jun 2025 09:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750583319;
	bh=149m2/W1pZQwb9wZMsd5gXC2L05cqby5KB9yTTnuIJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yEAkt/Aoh32htdYPwioZt3DKq39LrGelydg+pURmGAwnBvLs0DzXvuawbQNk3aoBy
	 NFgHCecXipRtxM964aCGI7wjwyCSmNjIP6lTk+epmwH2jacAYN/ASDRfJy7XjbM5+B
	 jgfAlq+NytllZTvF7ypBmKSnz6Vvnr21+Hx0LurE=
Date: Sun, 22 Jun 2025 11:08:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sergio =?iso-8859-1?Q?Gonz=E1lez?= Collado <sergio.collado@gmail.com>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: Re: Backport of `Kunit to check the longest symbol length` to 6.12
Message-ID: <2025062226-unnamable-shamrock-1005@gregkh>
References: <CAA76j91PrdB4c=W9p7p7YwXyH9tWPfDcUfRBX3SrVj9mdMd8Jg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA76j91PrdB4c=W9p7p7YwXyH9tWPfDcUfRBX3SrVj9mdMd8Jg@mail.gmail.com>

On Thu, Jun 19, 2025 at 02:00:29PM +0200, Sergio González Collado wrote:
> Hello,
> 
> Please consider applying the following commits for 6.12.y:
> 
>     c104c16073b7 ("Kunit to check the longest symbol length")
>     f710202b2a45 ("x86/tools: Drop duplicate unlikely() definition in
> insn_decoder_test.c")
> 
> They should apply cleanly.
> 
> Those two commits implement a kunit test to verify that a symbol with
> KSYM_NAME_LEN of 512 can be read.
> 
> The first commit implements the test. This commit also includes a fix
> for the test x86/insn_decoder_test. In the case a symbol exceeds the
> symbol length limit, an error will happen:
> 
>     arch/x86/tools/insn_decoder_test: error: malformed line 1152000:
>     tBb_+0xf2>
> 
> ..which overflowed by 10 characters reading this line:
> 
>     ffffffff81458193:   74 3d                   je
> ffffffff814581d2
> <_RNvXse_NtNtNtCshGpAVYOtgW1_4core4iter8adapters7flattenINtB5_13FlattenCompatINtNtB7_3map3MapNtNtNtBb_3str4iter5CharsNtB1v_17CharEscapeDefaultENtNtBb_4char13EscapeDefaultENtNtBb_3fmt5Debug3fmtBb_+0xf2>
> 
> The fix was proposed in [1] and initially mentioned at [2].
> 
> The second commit fixes a warning when building with clang because
> there was a definition of unlikely from compiler.h in tools/include/linux,
> which conflicted with the one in the instruction decoder selftest.
> 
> [1] https://lore.kernel.org/lkml/Y9ES4UKl%2F+DtvAVS@gmail.com/
> [2] https://lore.kernel.org/lkml/320c4dba-9919-404b-8a26-a8af16be1845@app.fastmail.com/

Both now queued up, thanks.

greg k-h

