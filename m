Return-Path: <stable+bounces-98317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC539E4034
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79F71B2965A
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 16:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EB920B809;
	Wed,  4 Dec 2024 16:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGpBkyII"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E426C4A28;
	Wed,  4 Dec 2024 16:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733329344; cv=none; b=rdDV5SbyxTj36+pW+RVhBmcWx077d3jdG9CY0rbWBIJ3c6xVXzObJnotLqsqbvlXt465TZe562sbFj9E4K5FWw7PWIF7ZiFgpoWxudnY+IUNZE/xMmOIPNNWI9Fa7/VyZBLPHPUy6Y8u4F/PxnzyiDJO2Eh6pa2Qn6liFpSyo1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733329344; c=relaxed/simple;
	bh=A4oFzO9GNWTbQ3XOLyNV9MXETcpu40rt/iPXCpxt6O0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JrToRck7zLqP/35QT578rbcZqX627SCfrctF13LSbxiRtUCnfWqANrEEaBfw/6hPcWyQJ/jXqaPn6i1cLx6U8VwgmI5/2rIDNovP0vF49OMN2RPcGo2o438XDJ2nU8ePeCd3FtYP/jpgEfpmSTI3ON+08CVJUr30o/ECEBhVkAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGpBkyII; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A523C4CECD;
	Wed,  4 Dec 2024 16:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733329343;
	bh=A4oFzO9GNWTbQ3XOLyNV9MXETcpu40rt/iPXCpxt6O0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fGpBkyII/weC405HQoEiRu/1XgL4ZBG+6mhNu9ctwnh6fUcZPAO4pV8h+1ZLFuFgW
	 RS0QLciPWPQesBerPRF7xdvROL8vhmtOX2tkKHPuExWHhyPBztU4o7Dd6in+wQIrfR
	 Sc02RTwLFsQrdwoI90q+HKv2fFDjndzvmKq0JcugC3/vvZg6T9mtKmet0O8JMyGg4x
	 04pH28o3/WBnsxqgEUYED0NxsObiYrasGhQ6c7AueBA92UdxG31mR6qRC9Nscfxk9Z
	 pxQXbjcj5kFbZwi6PRyu/X+QqmFpKHdn+MHhGQ1wurkMN16X4a9vamKrDsLbgbUFBr
	 Q1ER1cgvPGCXw==
Message-ID: <b04ee5e7-f654-4562-bc8e-2643f37f1ba3@kernel.org>
Date: Wed, 4 Dec 2024 17:22:19 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 043/826] crypto: powerpc/p10-aes-gcm - Register
 modules as SIMD
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 Danny Tsen <dtsen@linux.ibm.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 Sasha Levin <sashal@kernel.org>
References: <20241203144743.428732212@linuxfoundation.org>
 <20241203144745.143525056@linuxfoundation.org>
 <2a720dd0-56a0-4781-81d3-118368613792@kernel.org>
 <2024120417-flattop-unpaired-fcf8@gregkh>
 <92315b46-db52-4640-b8b9-c2ddbef38a17@kernel.org>
 <2024120421-coming-snore-e6fc@gregkh>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <2024120421-coming-snore-e6fc@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04. 12. 24, 13:24, Greg Kroah-Hartman wrote:
> On Wed, Dec 04, 2024 at 11:45:05AM +0100, Jiri Slaby wrote:
>> On 04. 12. 24, 11:34, Greg Kroah-Hartman wrote:
>>> On Wed, Dec 04, 2024 at 11:00:34AM +0100, Jiri Slaby wrote:
>>>> Hi,
>>>>
>>>> On 03. 12. 24, 15:36, Greg Kroah-Hartman wrote:
>>>>> 6.12-stable review patch.  If anyone has any objections, please let me know.
>>>>>
>>>>> ------------------
>>>>>
>>>>> From: Danny Tsen <dtsen@linux.ibm.com>
>>>>>
>>>>> [ Upstream commit c954b252dee956d33ee59f594710af28fb3037d9 ]
>>>>>
>>>>> This patch is to fix an issue when simd is not usable that data mismatch
>>>>> may occur. The fix is to register algs as SIMD modules so that the
>>>>> algorithm is excecuted when SIMD instructions is usable.  Called
>>>>> gcm_update() to generate the final digest if needed.
>>>>>
>>>>> A new module rfc4106(gcm(aes)) is also added.
>>>>>
>>>>> Fixes: cdcecfd9991f ("crypto: p10-aes-gcm - Glue code for AES/GCM stitched implementation")
>>>>>
>>>>> Signed-off-by: Danny Tsen <dtsen@linux.ibm.com>
>>>>> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
>>>>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>>>>> ---
>>>>>     arch/powerpc/crypto/aes-gcm-p10-glue.c | 141 +++++++++++++++++++++----
>>>>>     1 file changed, 118 insertions(+), 23 deletions(-)
>>>>>
>>>>> diff --git a/arch/powerpc/crypto/aes-gcm-p10-glue.c b/arch/powerpc/crypto/aes-gcm-p10-glue.c
>>>>> index f66ad56e765f0..4a029d2fe06ce 100644
>>>>> --- a/arch/powerpc/crypto/aes-gcm-p10-glue.c
>>>>> +++ b/arch/powerpc/crypto/aes-gcm-p10-glue.c
>>>> ...
>>>>> @@ -281,6 +295,7 @@ static int p10_aes_gcm_crypt(struct aead_request *req, int enc)
>>>>>     	/* Finalize hash */
>>>>>     	vsx_begin();
>>>>> +	gcm_update(gctx->iv, hash->Htable);
>>>>
>>>> Now I get:
>>>> ERROR: modpost: "gcm_update" [arch/powerpc/crypto/aes-gcm-p10-crypto.ko]
>>>> undefined!
>>>>
>>>> Only this:
>>>> commit 7aa747edcb266490f93651dd749c69b7eb8541d9
>>>> Author: Danny Tsen <dtsen@linux.ibm.com>
>>>> Date:   Mon Sep 23 09:30:38 2024 -0400
>>>>
>>>>       crypto: powerpc/p10-aes-gcm - Re-write AES/GCM stitched implementation
>>>>
>>>>
>>>>
>>>> added that function...
>>>
>>> Ah, thanks, I'll go drop this patch from everywhere.
>>
>> OK.
>>
>> Looking at the queue, it looks like a prereq for un-BROKEN-ing the module in
>> the next patch:
>>    8b6c1e466eec crypto: powerpc/p10-aes-gcm - Add dependency on
>> CRYPTO_SIMDand re-enable CRYPTO_AES_GCM_P10
> 
> No, I don't see a conflict here.  Are you sure you are?

Not sure at all about this crypto stuff. But this failing patch 
introduces SIMD and the above 8b6c1e466eec adds a dep to SIMD and makes 
the module nonBROKEN at the same time. So I assume the failing one is a 
prereq to unbreak the module. Maintainers?

-- 
js
suse labs

