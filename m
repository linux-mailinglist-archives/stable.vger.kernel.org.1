Return-Path: <stable+bounces-240377-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id VV0pANoL6WmXTgIAu9opvQ
	(envelope-from <stable+bounces-240377-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 19:56:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9FE449761
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 19:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67ED73028808
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 17:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F3D3921DC;
	Wed, 22 Apr 2026 17:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=m1k.cloud header.i=@m1k.cloud header.b="SsFFmOva"
X-Original-To: stable@vger.kernel.org
Received: from mail.m1k.cloud (mail.m1k.cloud [195.231.66.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9909C37F8A6
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 17:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.66.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776880598; cv=none; b=VZMIiB++F8lpqbpa84h20KVQ/dj16sF8GnhqdCeq0fnI8KkkWOOR5zILC1Z6mMnVb147JEFN4GkT3Vlvilrv0RVQIJpdSZV2Y8DiaEOrZtfM/skAgDgVzG6fvNxX5UTCUTvGhwIE/v4JPBED8G+9pOlOFDHoHR2do9px2Wbb0aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776880598; c=relaxed/simple;
	bh=nwAQ65vyjGKqfQ9+EDHDmYy+Gjqoz7OgTxqBMrQ/4CM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gocoPChQ5l97/ZpClcx0jP82nqaIBd/82rhBD8YDmxx0QCtn6IwGyYawrqZoZ7j6iJMg0KcFyc8fR+MG1JNe/7hVHtbfewUuKJMeIAxQrMm0TaUuxkRT86FVJXOtEiepYfvmrITBNS0pTrrHYrxiR3M8vKldqW0QHej4etfM34Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=m1k.cloud; spf=pass smtp.mailfrom=m1k.cloud; dkim=pass (2048-bit key) header.d=m1k.cloud header.i=@m1k.cloud header.b=SsFFmOva; arc=none smtp.client-ip=195.231.66.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=m1k.cloud
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m1k.cloud
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=m1k.cloud; s=mail;
	t=1776880205; bh=nwAQ65vyjGKqfQ9+EDHDmYy+Gjqoz7OgTxqBMrQ/4CM=;
	h=Subject:To:Cc:References:From:In-Reply-To;
	b=SsFFmOva4KeOTd3i3DJ7ApUqHGTJgOgL961bta4L1hPNShTKNzND7OJrS/dvhNfoZ
	 SDszbNPRr3EMckiRbPdQVHOif36aDP10mRHKU+XDDn8CaUDzDXFet0Loy94gzEo0un
	 iE4OQV4jrhxufQthFdBZgHobNwAVlyt7YXeLBdbC2zSUzbpjuRPuqZDFG7AEG3n+ix
	 1adoN8Ck38hC70ox4pssC0XCpLmDKwXaG5cacx/UmbvGiZjMEC4pGPjogdWYqxFaDt
	 exzBt3nuAzYhN5c6+vC9SrvkTVrHnzAHz4WyoA3758IoVR/JhX2vy0Gz/nB+Lj90mA
	 umXSEUo91AEHg==
Message-ID: <cc5aad8a-e69c-42ab-a36f-15770b1038a1@m1k.cloud>
Date: Wed, 22 Apr 2026 19:50:04 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] drm/amd/display: Restore 5s vbl offdelay for NV3x+ DGPUs
To: Mario Limonciello <mario.limonciello@amd.com>, Leo Li
 <sunpeng.li@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Harry.Wentland@amd.com,
 Aurabindo.Pillai@amd.com, wiagn233@outlook.com, stable@vger.kernel.org
References: <20260422162956.620362-1-sunpeng.li@amd.com>
 <CADnq5_OYNSoWteuXDJrCOtj4qYn2q+vyXUKZaHvgNN+5xFFg2Q@mail.gmail.com>
 <5b0ea1b1-40be-4941-b4cc-521a9fca8c09@amd.com>
 <78ef350e-b425-489d-8fd8-23df8a652e1a@amd.com>
Content-Language: en-US
From: Michele Palazzi <sysdadmin@m1k.cloud>
In-Reply-To: <78ef350e-b425-489d-8fd8-23df8a652e1a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[m1k.cloud,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[m1k.cloud:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240377-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,amd.com,outlook.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[amd.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[m1k.cloud:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sysdadmin@m1k.cloud,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[m1k.cloud:email,m1k.cloud:dkim,m1k.cloud:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3F9FE449761
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/22/26 19:42, Mario Limonciello wrote:
> 
> In Michele's proposal (https://lore.kernel.org/amd- 
> gfx/20260217191632.1243826-1-sysdadmin@m1k.cloud/) there was a mention 
> that it was tested on DCN 3.5 too, which made me think that the exact 
> same issue was on both.
> 
> Michele - can you readily reproduce the page flip timeout on DCN 3.5?
> 
> If so; could you modify Leo's patch to drop the IS_APU designation and 
> see if it happens to be the same solution?
> 
>>
>>>
>>>> +                       /*
>>>> +                        * DGPUs NV3x and newer that support idle 
>>>> optimizations
>>>> +                        * experience intermittent flip-done 
>>>> timeouts on cursor
>>>> +                        * updates. Restore 5s offdelay behavior for 
>>>> now.
>>>> +                        *
>>>> +                        * Discussion on the issue:
>>>> +                        * https://lore.kernel.org/amd- 
>>>> gfx/20260217191632.1243826-1-sysdadmin@m1k.cloud/
>>>> +                        */
>>>> +                       config.offdelay_ms = 5000;
>>>> +                       config.disable_immediate = false;
>>>> +               } else if (amdgpu_ip_version(adev, DCE_HWIP, 0) <
>>>> +                            IP_VERSION(3, 5, 0)) {
>>>>                          /*
>>>>                           * Older HW and DGPU have issues with 
>>>> instant off;
>>>>                           * use a 2 frame offdelay.
>>>> -- 
>>>> 2.53.0
>>>>
>>
> 

Hi Mario, i had tested my proposed patch on multiple APUs in order to 
exclude regressions or side effects, but personally i only ever 
encountered this particular issue on dGPUs, specifically a 7900 GRE 
first and a 9070XT later.


