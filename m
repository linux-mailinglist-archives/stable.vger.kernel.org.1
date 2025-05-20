Return-Path: <stable+bounces-145481-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B52ABDC09
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 16:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF4347B6F0C
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 14:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1AC248895;
	Tue, 20 May 2025 14:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uo/q2BaQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C94622D7A8;
	Tue, 20 May 2025 14:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747750302; cv=none; b=iEI0epcolj6QoD+r/4AGzp3mlvLFLw7MSOC7xH4YrEBRmTlyvvg1xoJtvVnzLZcQs8DLZMaA59M7l5D/tr4gno6VOPeDONhvF3VjE2cfaJYIefHVSGBzxAt77AZJoSMNOlyjmypfqo3OmCUzHlfwbPzkeOTG8eGJGs9uvyn/mc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747750302; c=relaxed/simple;
	bh=7H0H5peD5j5PaLsy4ojWTCVVazkCP7uOufJFBtYwn4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgvarYZx3kqW2DxNRWzJLuz83ZN1hz8hvPdcHewd2jABrVC07RZk+ogZHRDEv15h4RBSMZJUyRw0QTjl1wG2PKIHgzydCHvd+lkdMB5fXQ5pe+eS+x9cz2Llh16bWw+q5ipgeqAyVKllPINNh7Q/XsqbEdcM1BnTl6vJGhLvChY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uo/q2BaQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1006C4CEE9;
	Tue, 20 May 2025 14:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747750301;
	bh=7H0H5peD5j5PaLsy4ojWTCVVazkCP7uOufJFBtYwn4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uo/q2BaQbLDQDYWOHIR/wIbPmqGhlaMgw7JEobhcTwm8mhQYXMhTJmsZbtNwqfObz
	 lNSLhYf0HJSb3BcQvl891i9J2/p30jZ6i3tlh/RzafnQh0fPhPgqFSk0JQ9DXsbcvz
	 kf9FOcps1fZRzlalC73mOD1/xnGXQExvIkKLdf7ZQU0qmZCbLKevJ8OOM6jjSd1ASm
	 ZlrUgzrGnoyHL3A2JZs6R0SfBW1uKXwwG4sQlmYaVjDB4JqUqyuaEnQ/bHz3ekNQM+
	 hQfvUxNG+eVuYhUAivOpODVarYaoi/XvezLluIV5cpXT+RAU4Y1SmBfNQg5h42zNA7
	 waXymr7+OdYQg==
Date: Tue, 20 May 2025 10:11:40 -0400
From: Sasha Levin <sashal@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, nathan@kernel.org, ubizjak@gmail.com,
	thomas.weissschuh@linutronix.de, llvm@lists.linux.dev
Subject: Re: [PATCH AUTOSEL 6.14 400/642] x86/relocs: Handle
 R_X86_64_REX_GOTPCRELX relocations
Message-ID: <aCyNnFdhBTOby6It@lappy>
References: <20250505221419.2672473-1-sashal@kernel.org>
 <20250505221419.2672473-400-sashal@kernel.org>
 <CAMj1kXF6=t9NoH5Lsh4=RwhUTHtpBt9VmZr3bEVm6=1zGiOf2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAMj1kXF6=t9NoH5Lsh4=RwhUTHtpBt9VmZr3bEVm6=1zGiOf2w@mail.gmail.com>

On Tue, May 06, 2025 at 12:32:05AM +0200, Ard Biesheuvel wrote:
>On Tue, 6 May 2025 at 00:30, Sasha Levin <sashal@kernel.org> wrote:
>>
>> From: Brian Gerst <brgerst@gmail.com>
>>
>> [ Upstream commit cb7927fda002ca49ae62e2782c1692acc7b80c67 ]
>>
>> Clang may produce R_X86_64_REX_GOTPCRELX relocations when redefining the
>> stack protector location.  Treat them as another type of PC-relative
>> relocation.
>>
>> Signed-off-by: Brian Gerst <brgerst@gmail.com>
>> Signed-off-by: Ingo Molnar <mingo@kernel.org>
>> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>> Link: https://lore.kernel.org/r/20250123190747.745588-6-brgerst@gmail.com
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>This patch was one of a series of about 20 patches. Did you pick all of them?

Should we pick them all up?

-- 
Thanks,
Sasha

