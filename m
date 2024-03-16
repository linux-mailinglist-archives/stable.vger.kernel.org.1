Return-Path: <stable+bounces-28300-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A6587D9D1
	for <lists+stable@lfdr.de>; Sat, 16 Mar 2024 12:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A96C2282138
	for <lists+stable@lfdr.de>; Sat, 16 Mar 2024 11:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF5AFC0B;
	Sat, 16 Mar 2024 11:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spZ/8M8R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF72F11CAB
	for <stable@vger.kernel.org>; Sat, 16 Mar 2024 11:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710586908; cv=none; b=EahKg4ziZH6Ex6F3k/E3iF+slQfM+fJNdGzRRy3KAQXfcj1t1/+z7lypaZ40wOLORv34xJShyGSD/ynMsnwwk7Ku4Cdi+vYM4wsG5PgrZ5Es6MK0iNt40MqnIrgJ86fWaGCz5ZzZguLc+vWQ+VX7AWfQuqH4zvNjLl6dALzfTfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710586908; c=relaxed/simple;
	bh=OvNTqygcBCOLg1Ap9q8QiVvQhNrX1wyL4+k8PsG7dKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEiHyxtmymOydxMfxNZ+ei8XY2LX8v+1ppPCMm1QE62PsRI/OPZrYYSSfc0tDR5+/dc8YndNCL9H44wgR1i47kUmHAogZGE6nwR1UKxubTsSFnfTKIiL7n2wPXFi8JxNMOs0RLywiT5M6EkyA1NzZw7OKYZSW8HNmfPGTlrOgrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spZ/8M8R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E591C433F1;
	Sat, 16 Mar 2024 11:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710586908;
	bh=OvNTqygcBCOLg1Ap9q8QiVvQhNrX1wyL4+k8PsG7dKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=spZ/8M8RUPbqNN8iX07gTDXYJoJJBntSFWkgLowY2qvFM1YyoR5VLPOIDVGk34xAi
	 vKWSI4iLK/z4KAOcwliflH1kSc/qs3/7vY1yylMcM6q4sIUmv0KkQGhGzuloJFmfc/
	 O+yNQVQBlk5YTyCifHLZV0LNlQFLRDPJmE3faqzktlDz8GZO2G/f8Fb4Mr6NNvkFDH
	 KYptsvmnO6O/BtH8EcT7TxHw7wTQR9mEjHQrDRd/iJTQIukTkWB853YIG5tZDNs9Rx
	 ByerlmWe/2HnPh33BY9wvQuCg//Bf2LHxp3lq8oz1q6GHfADO31i757IXLfrwE33TK
	 PhF+JK68+MJSQ==
Date: Sat, 16 Mar 2024 07:01:46 -0400
From: Sasha Levin <sashal@kernel.org>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, kernel-dev@igalia.com
Subject: Re: [PATCH 5.15 0/5] Support static calls with LLVM-built kernels
Message-ID: <ZfV8Gh44eZI-Md_f@sashalap>
References: <20240313104255.1083365-1-cascardo@igalia.com>
 <ZfVpPMl3JJakSHT1@sashalap>
 <ZfVuK/Gn6sFQXV3Z@quatroqueijos.cascardo.eti.br>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZfVuK/Gn6sFQXV3Z@quatroqueijos.cascardo.eti.br>

On Sat, Mar 16, 2024 at 07:02:19AM -0300, Thadeu Lima de Souza Cascardo wrote:
>On Sat, Mar 16, 2024 at 05:41:16AM -0400, Sasha Levin wrote:
>> On Wed, Mar 13, 2024 at 07:42:50AM -0300, Thadeu Lima de Souza Cascardo wrote:
>> > Peter Zijlstra (4):
>> >  arch: Introduce CONFIG_FUNCTION_ALIGNMENT
>> >  x86/alternatives: Introduce int3_emulate_jcc()
>> >  x86/alternatives: Teach text_poke_bp() to patch Jcc.d32 instructions
>> >  x86/static_call: Add support for Jcc tail-calls
>> >
>> > Thomas Gleixner (1):
>> >  x86/asm: Differentiate between code and function alignment
>>
>> Is this not an issue on 6.1? I don't see d49a0626216b ("arch: Introduce
>> CONFIG_FUNCTION_ALIGNMENT") in that tree.
>>
>> --
>> Thanks,
>> Sasha
>
>The fix is really the last patch, 923510c88d2b ("x86/static_call: Add support
>for Jcc tail-calls"). I see that 6.1 got 3,4,5:
>
>9d80f3e60043 x86/static_call: Add support for Jcc tail-calls
>c51a456b4179 x86/alternatives: Teach text_poke_bp() to patch Jcc.d32 instructions
>75c066485bcb x86/alternatives: Introduce int3_emulate_jcc()
>
>I can resubmit the series without the first two patches if that is preferred.

I'm just curious why we needed the first two patches on 5.15 but not on 6.1.

-- 
Thanks,
Sasha

