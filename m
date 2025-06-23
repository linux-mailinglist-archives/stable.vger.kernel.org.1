Return-Path: <stable+bounces-155303-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB57AE361B
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 08:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1212A1709AB
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 06:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B871EEA28;
	Mon, 23 Jun 2025 06:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="waTZYRJb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE501E3DF4
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 06:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750661115; cv=none; b=VnJpLS4TKs/gQnEU4FtLy/4bJiPqrbgLgeBzlL7PbVfKO1QPxD8gIm8l4aZERr+K0A96IbF+64NxMxN2q32usqmMHG1R8kert8To2KMIXhJHUG69W5BtGuCD0SNsIvT/IDQn3G0+CeNBVHvozTyhHwsn6liTRq3eR7HlnMHA+cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750661115; c=relaxed/simple;
	bh=krsh/scOoPH4V1JFOY1bCV9xrauO+K+3BW6S/lrWxXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWP0zCrzuGQsHNMTD5S3RK2UzzqNt9SPzQ0AQI5GDr1AapLuUHQDi6IpPKuYsA96j0pTDzqEitz4r5g0FTLIdSxotOtwyA6XIrxdic0lod0KAvKQGZSbWL9EsYCFzx7UxHxeDxD9mZ0HybN9b6DhBGxMnhqGrPqHxn6Y0YNJ0TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=waTZYRJb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03AFBC4CEEF;
	Mon, 23 Jun 2025 06:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750661115;
	bh=krsh/scOoPH4V1JFOY1bCV9xrauO+K+3BW6S/lrWxXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=waTZYRJb5uZ3A8G5To2i7ZqvbignFftI6ttf5OnTm3fq5dq5Nosh+KLXzfplBai4h
	 09L88HGe4rZ9vGkYWJDXWbv04dSgEHED54hECv1OQjMRMb5eTt2LcGqDO6yp76RpLG
	 47sKtiSyyNNIt73QarEGsDL7vH54vCnDIUg1PBgs=
Date: Mon, 23 Jun 2025 08:45:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sergio =?iso-8859-1?Q?Gonz=E1lez?= Collado <sergio.collado@gmail.com>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH 6.1.y 2/2] x86/tools: Drop duplicate unlikely()
 definition in insn_decoder_test.c
Message-ID: <2025062303-hatbox-slacks-7687@gregkh>
References: <20250622160008.22195-1-sergio.collado@gmail.com>
 <20250622160008.22195-3-sergio.collado@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250622160008.22195-3-sergio.collado@gmail.com>

On Sun, Jun 22, 2025 at 06:00:08PM +0200, Sergio González Collado wrote:
> From: Nathan Chancellor <nathan@kernel.org>
> 
> commit f710202b2a45addea3dcdcd862770ecbaf6597ef upstream.
> 
> After commit c104c16073b7 ("Kunit to check the longest symbol length"),
> there is a warning when building with clang because there is now a
> definition of unlikely from compiler.h in tools/include/linux, which
> conflicts with the one in the instruction decoder selftest:
> 
>   arch/x86/tools/insn_decoder_test.c:15:9: warning: 'unlikely' macro redefined [-Wmacro-redefined]
> 
> Remove the second unlikely() definition, as it is no longer necessary,
> clearing up the warning.
> 
> Fixes: c104c16073b7 ("Kunit to check the longest symbol length")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>
> Link: https://lore.kernel.org/r/20250318-x86-decoder-test-fix-unlikely-redef-v1-1-74c84a7bf05b@kernel.org
> ---
>  arch/x86/tools/insn_decoder_test.c | 2 --
>  1 file changed, 2 deletions(-)
> 

You forgot to sign-off on this change :(

