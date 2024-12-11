Return-Path: <stable+bounces-100536-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A76989EC4B0
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 07:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B615118836C6
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 06:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023EA1C1F2F;
	Wed, 11 Dec 2024 06:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LV3D6XlL"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7042B2451C0;
	Wed, 11 Dec 2024 06:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733898199; cv=none; b=pbdGfzMLBf4Z/A/0/vXr4q7HXaaPeedpfOKVCjmYTT93/VA0FeKZpBdOn0ymKnVHujm3/x0NYOAUMp+UkIoydd1cTLmR38iCfK1MzFGzbKDGS3IJNDmtAPqgZf+cOTz7Rdv7Y2FOPyr3z6SGGkfZOeJVKZ8B6hJTjYNeArdzQiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733898199; c=relaxed/simple;
	bh=cmiD+UcTXJNkpZUqRbUnI7Qr3wBGV+y0BOrRVfqeupE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exTG5xT8lcX+DEr0CwHvu9+XiDFQbEn4w/Ie50RJ1vKKZfFJ4ngaqQUiGNYHOQxNMJCOmArCppwe3SMIi7DIVKAx2/fa2VtVZ1GWj0wmUiuNqQprNZk4CYN/yco7K3ihncH+kkIw0B/aC6BFs3BP6VcVkfhvoXTDI3cKGudIayY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LV3D6XlL; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7fd35b301bdso2921825a12.2;
        Tue, 10 Dec 2024 22:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733898197; x=1734502997; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5qkxY1avkOoWW07234aWtJOqYEByF+/tTPC72emPdi4=;
        b=LV3D6XlL0Fr6hTWXvGYixwyx15uoIS4YNuJ+BLge01/Pbilc+th4ow5unRVH0n5Xna
         B4CgQmqdThk0fTtncKH7sG3jHaX4nZz60IW1bIf3ts0eIg6hmCsvE8FKn7NqAZlrjz6f
         Ln0PJyVh3RX1a6eS+Q6kPEGkijr2+ptlgtho9B3hs/DUylvEub7/gJB22m0gUlnHJSGB
         DTXpXF4/Z/97HE5cGQ7owiC19YaR3jX/5c4GHHfGXy2XsMPldKfv9lp2XRR09cFh5/ya
         50N4kNalATutDKOsXmAwpCQPXQ8Tq4aqEhaMQmRRvaPanFqyrd++I4jRdx0vIXCfve8k
         htsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733898197; x=1734502997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qkxY1avkOoWW07234aWtJOqYEByF+/tTPC72emPdi4=;
        b=SoXYiIwQsMQczEa3oPFHfkNr4a/yoL1EoTeUHISsz6wU4gbJ190Gt1Kgq3EEYenIHb
         ZswolTqeePIl8qg2pHc/RUc06siodU9p4PEWP1Ahw04Txgs4ttVBscYFvutM093NRtmZ
         BzJhlSt9plifcBGcC90ijRUeGaycY5JHraG3uZ0LvCB3Vunj32ZIH9IpKVgADbM3osSE
         WQF2A+sPQJSTl8jn4EFujNCqB3R5OtnhW0wlKQHdIMexgEhyPOYWWJYdZIXQthripFCP
         7eI3mebsVNgb0q/KBMsCA0+neVvpBw4zYsElfg9kOrU4zyBxHE9XBzHioSu6Swb9xipS
         g7rQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXR7HjtiMpsqS0U31X5L2hh6ZqViiyfQTWUxi2LxCn3hZtp+dcGngtZBcFywpV24IzGE0k3Ylu@vger.kernel.org, AJvYcCX4zve4RUG2di7pIkcqNwj8i2V+aN76sqVUp1LTVZWpxFAX/PwyDeC7JoIygTwdXW1mBucNmnokF1h0g3s=@vger.kernel.org, AJvYcCXEBIuQnlFAP1buDh1CDOBvRtRUVuB2POo9gmUBwglgF/iyvS3qNP48zWw4e7wNgO2CkQDD3b6r@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg4Z9p2O/9bM9wLQykGZSqtRWNi1qtN2hVlZz54Gt5MWMTJkcD
	5G+oPsk7FDGTlJXFS/qi9NGYG5u30x0BuTz1x3vUxvRaYCth2s1d7x/jMA==
X-Gm-Gg: ASbGnctyjmVvwKbreOl9nrzzSXBfPm11vS9DwOGAuxFR9j6qsIWxhCZaw9IxoE7P91J
	cY56Yhr5Hm2RqoMwNTPcoZEkTIQA024k+uSzNHCr6bh6k/8vFULlHKa8SBdj0pHaRaJooqAwlh/
	T3/d06DLLGq8YIAhUcv8/lDMTvIfWdJzVdTXqpjkTpXs4dRaeWexjj107Cy2oG9Xz04Kark/fK5
	GBwfBvy7ryjozzlzad/IPck4AuAeUI3r1t8JnsV1A1I9EFPgOJJV/HmivoGpx8v982l66vwrQ==
X-Google-Smtp-Source: AGHT+IHQONMvanKaDDQaiCx8CuJlxl2HMa++W4IWg8efjNmZtTfNbCOt3sA5XKXviX45mNEy1oQgtg==
X-Received: by 2002:a17:90b:49:b0:2ee:a127:ba8b with SMTP id 98e67ed59e1d1-2f128048ea9mr2495853a91.36.1733898196697;
        Tue, 10 Dec 2024 22:23:16 -0800 (PST)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef26ff86d9sm12731692a91.1.2024.12.10.22.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 22:23:16 -0800 (PST)
Date: Tue, 10 Dec 2024 22:23:14 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Ma Ke <make_ruc2021@163.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, vdronov@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ptp: Check dev_set_name() return value
Message-ID: <Z1kv0tJHtoGVGmxO@hoboy.vegasvil.org>
References: <20241211022612.2159956-1-make_ruc2021@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211022612.2159956-1-make_ruc2021@163.com>

On Wed, Dec 11, 2024 at 10:26:12AM +0800, Ma Ke wrote:

> diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
> index 77a36e7bddd5..82405c07be3e 100644
> --- a/drivers/ptp/ptp_clock.c
> +++ b/drivers/ptp/ptp_clock.c
> @@ -348,7 +348,9 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
>  	ptp->dev.groups = ptp->pin_attr_groups;
>  	ptp->dev.release = ptp_clock_release;
>  	dev_set_drvdata(&ptp->dev, ptp);
> -	dev_set_name(&ptp->dev, "ptp%d", ptp->index);
> +	err = dev_set_name(&ptp->dev, "ptp%d", ptp->index);
> +	if (err)
> +		goto no_pps;

NAK

This fails to clean up by calling pps_unregister_source() on the error path.

Thanks,
Richard

