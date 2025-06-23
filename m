Return-Path: <stable+bounces-155302-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C031BAE360B
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 08:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1D7B188FBC4
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 06:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2391EEA3C;
	Mon, 23 Jun 2025 06:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nvcHMKyn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B0E1EB5CE
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 06:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750661101; cv=none; b=tcTFQCGDINcmZSnBGvcAnltOkyNWewcEbe1/Lkj9uwtXUTa2dPxIrEbYM1jX0zzqeQm6DeXgc5FRGN5h5qDJULnm/nfULMQVUgHsHqKoWzCNXCTFh9a0MLfq1AaSqwp0Q6zPkgI/H0KU+h/3+RFvG14PZZ6VFN3PfXi4zlQZfD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750661101; c=relaxed/simple;
	bh=koIoOzs7lb07TKYEyA6GBSigH/YJrcNQioPdH2X/Rl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DsjiawFQ0ms+k0V3efCsSU8TwxU44L2uus9DuA0k4VxqkPhxcjB0+swjLgNW0njOLEFyz5I+3y25Gp8W2jNK6vLuNgvxR3j3FIEwdpHO6dWyffo/A5ss8qS3bHgZU2roPfET8d/nefG2Tgyr9xMe7ZNzBnz1zAgrrD70M6LArNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nvcHMKyn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34590C4CEF2;
	Mon, 23 Jun 2025 06:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750661100;
	bh=koIoOzs7lb07TKYEyA6GBSigH/YJrcNQioPdH2X/Rl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nvcHMKynNKT7yKZZAEB2zaNRYuaKh6GwsmN411CnZsHC+FmJTr5CI0BY03wXQIHCi
	 h34w8a89GuWCcfegsZWKZ0bwlxyRFZgpCFBAySFZX3LwlEaPuTYU2gws9UpRp9byh1
	 ApHNqi5ujFEG3SmfGwDTFzwa0l2SH6f/fW9wGD+Y=
Date: Mon, 23 Jun 2025 08:44:58 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sergio =?iso-8859-1?Q?Gonz=E1lez?= Collado <sergio.collado@gmail.com>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH 6.6.y 2/2] x86/tools: Drop duplicate unlikely()
 definition in insn_decoder_test.c
Message-ID: <2025062348-showplace-twistable-9264@gregkh>
References: <20250622163439.22951-1-sergio.collado@gmail.com>
 <20250622163439.22951-3-sergio.collado@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250622163439.22951-3-sergio.collado@gmail.com>

On Sun, Jun 22, 2025 at 06:34:39PM +0200, Sergio González Collado wrote:
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

You forgot to sign-off on this patch :(

