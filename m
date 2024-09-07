Return-Path: <stable+bounces-73823-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 031179701B9
	for <lists+stable@lfdr.de>; Sat,  7 Sep 2024 12:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7F72283DD7
	for <lists+stable@lfdr.de>; Sat,  7 Sep 2024 10:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327CA14E2C0;
	Sat,  7 Sep 2024 10:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="F6Vz94Ne"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B0C28E8
	for <stable@vger.kernel.org>; Sat,  7 Sep 2024 10:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725705536; cv=none; b=hIMfoqTcui51T7+G+d6Zx6XhauwcKZ6UdsmLhxkIEpkkGd/87fqOuuMqQjiB4xWbfzPjHZXAUoCNR4/Nt5cqhiGzOJXftZbY6aKeppvQGpc1lHfI8gv74rEpGPuuGV2eQPH4QiQuhoUairwc60AxZ6Cn+uGU5OcYQq3Y4P9hSZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725705536; c=relaxed/simple;
	bh=hh8rCURHlU1S0VzeEOr/qPRmG5pOjwvou/UUAN4mAIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CEbrIbJPrRSRHQig0tINwATrnYfZhzDJEUfosoUK+8IXjG+SvXEvfc0Sh13+HnUxZRKpcHGv1e+XqRfkwqsqgHKEyL30BYF6fIVPcAxDTee8fG2DqtUo7e5JXnPSwoIW2lFc1Pa5bu5juDyKHCVLgTWpH0+d6AZJSJgCv6i/eFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=F6Vz94Ne; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c27067b81aso3039607a12.0
        for <stable@vger.kernel.org>; Sat, 07 Sep 2024 03:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1725705533; x=1726310333; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2CwdNcIB9tXV/LLx26cXgF2y6u1PTSNCri52GY6FU6s=;
        b=F6Vz94NeBnPue+ffLitQKHYgJhnECcf89/XohBGfryiv23qmHqc3fOFVj2FPyTozPn
         Xbsx75boNECtNj6rEj9Q8mXitlT9DGm0rK1OHJK5ynkIkFuiTYnSFkSqbOq8RqKLfqzz
         p6jk/j4mI37kIiZwovcy+dg90mJL5oS3VeR4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725705533; x=1726310333;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2CwdNcIB9tXV/LLx26cXgF2y6u1PTSNCri52GY6FU6s=;
        b=U+5t6rDLs67WYpVbAqYdTzqJpO0v7KNv0fZOLsTlCoybAZTcEpTNgx27RaNcYHE1Om
         BjxSqxH2wNmGgr+zGbYc0jlog7GVfRvKSYgYe69mBE10tbtI9x76aItRhVLZ2IZgsLhO
         mZdqKKvTO00gBjSKDZ0dMbAJoUGYkSUvMUtdvStItBZ4fvx5Ih2E6OGT0hZ/XXkvAZKL
         Q56fXN74NiNn2eAF9HU9UqWDDRMMEvi2gz7Y6CY/+1BJCCPyQ2Nv08dQeMdI1NgrvBiF
         ako7t9HCyQ0gc4xAeoJ+ZJWkql2vFPUG/YWIvDOQBR/+iJHIr25/78WojwY1MxkS1JJT
         YBcw==
X-Forwarded-Encrypted: i=1; AJvYcCUuqFACipsbei9zYmQDWa8jamw5YwXRXqY2OqujzHFYsm5XqyOhm9sEy/I1u4JeF868C1qgS0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMsmbG/JSR5lOCeJ4+QgreEI3Q5H4mLbDkkdUO/o0z4CkDrCCl
	9KZxvrDfPSrcJvEDSpQBbTyGOYO1jth5AGHK9bmmumrLDi77TKy2XJys4yQ0EpU=
X-Google-Smtp-Source: AGHT+IFDe69CkyHE4Nq97ZTYjKfNF5v2aG9NzuqS3isvoJdEiUzylAQ02iPjot71qkSyE9nmFP7jHg==
X-Received: by 2002:a05:6402:5419:b0:5c2:54a3:6b3e with SMTP id 4fb4d7f45d1cf-5c3eac064a2mr855308a12.16.1725705532223;
        Sat, 07 Sep 2024 03:38:52 -0700 (PDT)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd76fc4sm522094a12.78.2024.09.07.03.38.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Sep 2024 03:38:51 -0700 (PDT)
Message-ID: <9eda21ac-2ce7-47d5-be49-65b941e76340@citrix.com>
Date: Sat, 7 Sep 2024 11:38:50 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "ALSA: memalloc: Workaround for Xen PV"
To: Takashi Iwai <tiwai@suse.de>, Ariadne Conill <ariadne@ariadne.space>
Cc: xen-devel@lists.xenproject.org, alsa-devel@alsa-project.org,
 stable@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
References: <20240906184209.25423-1-ariadne@ariadne.space>
 <877cbnewib.wl-tiwai@suse.de>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <877cbnewib.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/09/2024 8:46 am, Takashi Iwai wrote:
> On Fri, 06 Sep 2024 20:42:09 +0200,
> Ariadne Conill wrote:
>> This patch attempted to work around a DMA issue involving Xen, but
>> causes subtle kernel memory corruption.
>>
>> When I brought up this patch in the XenDevel matrix channel, I was
>> told that it had been requested by the Qubes OS developers because
>> they were trying to fix an issue where the sound stack would fail
>> after a few hours of uptime.  They wound up disabling SG buffering
>> entirely instead as a workaround.
>>
>> Accordingly, I propose that we should revert this workaround patch,
>> since it causes kernel memory corruption and that the ALSA and Xen
>> communities should collaborate on fixing the underlying problem in
>> such a way that SG buffering works correctly under Xen.
>>
>> This reverts commit 53466ebdec614f915c691809b0861acecb941e30.
>>
>> Signed-off-by: Ariadne Conill <ariadne@ariadne.space>
>> Cc: stable@vger.kernel.org
>> Cc: xen-devel@lists.xenproject.org
>> Cc: alsa-devel@alsa-project.org
>> Cc: Takashi Iwai <tiwai@suse.de>
> The relevant code has been largely rewritten for 6.12, so please check
> the behavior with sound.git tree for-next branch.  I guess the same
> issue should happen as the Xen workaround was kept and applied there,
> too, but it has to be checked at first.
>
> If the issue is persistent with there, the fix for 6.12 code would be
> rather much simpler like the blow.
>
>
> thanks,
>
> Takashi
>
> --- a/sound/core/memalloc.c
> +++ b/sound/core/memalloc.c
> @@ -793,9 +793,6 @@ static void *snd_dma_sg_alloc(struct snd_dma_buffer *dmab, size_t size)
>  	int type = dmab->dev.type;
>  	void *p;
>  
> -	if (cpu_feature_enabled(X86_FEATURE_XENPV))
> -		return snd_dma_sg_fallback_alloc(dmab, size);
> -
>  	/* try the standard DMA API allocation at first */
>  	if (type == SNDRV_DMA_TYPE_DEV_WC_SG)
>  		dmab->dev.type = SNDRV_DMA_TYPE_DEV_WC;
>
>

Individual subsystems ought not to know or care about XENPV; it's a
layering violation.

If the main APIs don't behave properly, then it probably means we've got
a bug at a lower level (e.g. Xen SWIOTLB is a constant source of fun)
which is probably affecting other subsystems too.

I think we need to re-analyse the original bug.  Right now, the
behaviour resulting from 53466ebde is worse than what it was trying to fix.

~Andrew

