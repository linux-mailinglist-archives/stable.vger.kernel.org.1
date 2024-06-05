Return-Path: <stable+bounces-48231-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFC38FD14F
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 17:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 968B3285F21
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 15:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8EE3C482;
	Wed,  5 Jun 2024 15:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZsTIQQ+"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B2317BD5
	for <stable@vger.kernel.org>; Wed,  5 Jun 2024 15:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717599621; cv=none; b=LPUC5jRcNcipyzsA9TxpWBFa19unT+Y/1sZvzbLZiGSWbZLwezBP13c9fkJpP/U9sBI0wag1zndL+I9gawgOBpu8g1fFGSD4jZFdZe1u2xELy7FUEd8q+GLtSLNBu0lup5/bbiVmLvvz4jKf+9bY+X/fMv203GqgtQGyT5+sm3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717599621; c=relaxed/simple;
	bh=hfB6KyMdnp9dJZwn7lGH3NhK764UmRlQ8Bjpr+UBFmo=;
	h=Message-ID:Date:MIME-Version:Subject:References:From:To:
	 In-Reply-To:Content-Type; b=ua3v4OpnrihZTK+fmcRuTmdE+uL7oCKfFyjThthsWCKvwDGS3FQrcg52GILxoqIx9cPYBz7n5/PW13qQ05VyuMbBmtdZQbpXIHyX9i2Gg2OmsT4Gmw+HqqmQIWxBHh89UJzbntSUmAAZhk1egXoxaJgSZOZpy3zTYH51QXgyH9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZsTIQQ+; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57a3a886bb7so574675a12.3
        for <stable@vger.kernel.org>; Wed, 05 Jun 2024 08:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717599597; x=1718204397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:to:from
         :content-language:references:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mvAx5zV1LEI7tA6py/iwWQYlQ7AWZCqLMD0ltjBgEAU=;
        b=AZsTIQQ+Fyu9fHmPrODy3QCw2QiWYSlOecHJODdNcmkMXA3PkqKD+WoKX5WcbyHIor
         F91jtkFoB7WY6Z7TaV2MYVy1TPyKtLhaNE19WdNQVWbh8DUaqJGShFaWBpGF+cO6TyhY
         UK5MRK9dGp3DepIp/S2huZwVVJd9UnGaC3FPlOsK8UUCaaGgVrmoiyXHWMWDDZ8bcGYr
         tR4HoXaty/jJkox0EHzTpS50bp1w3R1sD1kUfboDnDJYGjKPMJDStEta8pUqLmHvF3VT
         T2/ZlfRN6QBVPnf9k/Q+0nUkNaUnDWZ8BLeC4m83YUF6CT4CE7N15w40lFhLdAhbbZ0C
         b5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717599597; x=1718204397;
        h=content-transfer-encoding:in-reply-to:autocrypt:to:from
         :content-language:references:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mvAx5zV1LEI7tA6py/iwWQYlQ7AWZCqLMD0ltjBgEAU=;
        b=DvE1yiOAbQyzafqfwU50qdzZA8njgYycAJc+c/gLnepNb+6TyFAh7GT7wc1cbHOV5i
         e6a0zRBb5g5CE/uAGCz3+2LrfUpQkzVcbjyzSgbuj9Xm0az9YwwVIb8GgaeTc/yk701C
         L7nHjZ0D40LaFOr2ZO84T0FcWKqOQ5QnD6rWwuhWemz2hrQlnkckvx8lvo3C3m+UZ2gs
         m6rRHRYP3xe4myG4NB/Te86X5Ib+ue0IRpRcaArVgRonrPdzd1Xb1w+mA2pE9Wu1bGPt
         UcRumf2UvIaCoH8PSeuhYja0v3pozA7MOpMuwdoefEqYZe5yR01fPGxM7eUe6c3DJL+R
         8cUQ==
X-Gm-Message-State: AOJu0YxX9TVue5fFu/9LAame9YMidoMLKlxb1Nsg+9wyAfuQw/PiPUOU
	b+Y6M3OXPDEe/Ryzq6lGNmOwvZMG704O/LyMNF4dq69fmQc4tJxiY87l/8EX
X-Google-Smtp-Source: AGHT+IGmWtORe6owdyI+3PLVhAi12HYwDnY5LO4eY/7MSxvwqe0Ogp1VnhLNwHc6HLjbeONa6ZPHmg==
X-Received: by 2002:a50:8e02:0:b0:57a:1e62:4d56 with SMTP id 4fb4d7f45d1cf-57a8b69c589mr1843778a12.1.1717599596921;
        Wed, 05 Jun 2024 07:59:56 -0700 (PDT)
Received: from [192.168.1.3] ([91.86.182.228])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a6b6d0741sm4669304a12.73.2024.06.05.07.59.56
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 07:59:56 -0700 (PDT)
Message-ID: <aef09490-f8bd-46e9-abbf-a4cc9acc49aa@gmail.com>
Date: Wed, 5 Jun 2024 16:59:54 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 6.6 18/18] null_blk: Do not allow runt zone with
 zone capacity smaller then zone size
References: <20240605120409.2967044-1-sashal@kernel.org>
 <20240605120409.2967044-18-sashal@kernel.org>
Content-Language: fr-FR
From: =?UTF-8?Q?Fran=C3=A7ois_Valenduc?= <francoisvalenduc@gmail.com>
To: stable@vger.kernel.org
Autocrypt: addr=francoisvalenduc@gmail.com; keydata=
 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
In-Reply-To: <20240605120409.2967044-18-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 5/06/24 à 14:03, Sasha Levin a écrit :
> From: Damien Le Moal <dlemoal@kernel.org>
> 
> [ Upstream commit b164316808ec5de391c3e7b0148ec937d32d280d ]
> 
> A zoned device with a smaller last zone together with a zone capacity
> smaller than the zone size does make any sense as that does not
> correspond to any possible setup for a real device:
> 1) For ZNS and zoned UFS devices, all zones are always the same size.
> 2) For SMR HDDs, all zones always have the same capacity.
> In other words, if we have a smaller last runt zone, then this zone
> capacity should always be equal to the zone size.
> 
> Add a check in null_init_zoned_dev() to prevent a configuration to have
> both a smaller zone size and a zone capacity smaller than the zone size.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Link: https://lore.kernel.org/r/20240530054035.491497-2-dlemoal@kernel.org
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   drivers/block/null_blk/zoned.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
> index 55c5b48bc276f..9f6d7316b99aa 100644
> --- a/drivers/block/null_blk/zoned.c
> +++ b/drivers/block/null_blk/zoned.c
> @@ -83,6 +83,17 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
>   		return -EINVAL;
>   	}
>   
> +	/*
> +	 * If a smaller zone capacity was requested, do not allow a smaller last
> +	 * zone at the same time as such zone configuration does not correspond
> +	 * to any real zoned device.
> +	 */
> +	if (dev->zone_capacity != dev->zone_size &&
> +	    dev->size & (dev->zone_size - 1)) {
> +		pr_err("A smaller last zone is not allowed with zone capacity smaller than zone size.\n");
> +		return -EINVAL;
> +	}
> +
>   	zone_capacity_sects = mb_to_sects(dev->zone_capacity);
>   	dev_capacity_sects = mb_to_sects(dev->size);
>   	dev->zone_size_sects = mb_to_sects(dev->zone_size);

Is not 6.8 supposed to be end-of-life ?

François Valenduc

