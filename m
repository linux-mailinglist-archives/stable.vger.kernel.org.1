Return-Path: <stable+bounces-65366-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF98E94764D
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 09:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C08191C213F1
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 07:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7EA14885C;
	Mon,  5 Aug 2024 07:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="Iwh57txZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE5C13FD72
	for <stable@vger.kernel.org>; Mon,  5 Aug 2024 07:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722843840; cv=none; b=KhDp5D0Eym+5lyAMGyKJ9p2uWaaAKv359RZIdXmkzk6nPH4kI4frm+x8QrBHPlwAsubBC+x4STilh+3jpyk/N7shhsZ8kxcQhsF1JrDNwYfDvNK993cjR03z/tqPVkjom5upqaPDMnZ+N4oqJ+Lb2etZUPwM7AdxbJB3oebPmfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722843840; c=relaxed/simple;
	bh=len6xyqu7lvhqIKXEssTjisEE2SntHQ5UO5jFAwBoWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g4nkgKg1sDyWfs3c4Nebh59/6QcRuCz9xfO56AazMhxb5IPlPQiq7SuY/7eQiTc1HUnXRGhNmc0F4zgheRmhiS9tzsI3KSPurRWlkgnf9GkmeWq8MtPg+vMtwgpR96DFeOLK4tHCLlXvxrknnNC41Rd1VvjlIMNgxUVXcOaWr+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=Iwh57txZ; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ef2fccca2cso115502131fa.1
        for <stable@vger.kernel.org>; Mon, 05 Aug 2024 00:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1722843835; x=1723448635; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/+Tb94arZaHlFuvw58wOtuu7WeigbyWQnSs76r5OilU=;
        b=Iwh57txZmlg1uA9azYPZMhrUaBjFEK9r9KxNeeLKaVXj6qxe2OYaa20ey+e5OajUjQ
         n654Jy3skuRY4PS/ycXC5X5xlE5y8hjZhGoi3m8QhGLjyOk0vtL7ldODcAOpGrNCAR+L
         C4woRorggTkzzeTCIeHcktYlEhIRnFiBTGMXUSzQJkt5w0xL2vXXZIvANUjtVTQ3Aves
         uGOdULlxWk7MQtM2lhARK4nvigGhL8lmJ+MvBvSMhwfnWyZyV4XyA7AX1sXcuwu5ztSy
         dE2Zt4hScFwLliGgM3ZTdFjLYS/OoXmWnGDOC06UV+X1Ibm8DBRNoYZkGS12I6tk58jS
         NNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722843835; x=1723448635;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/+Tb94arZaHlFuvw58wOtuu7WeigbyWQnSs76r5OilU=;
        b=BnwhYwpQZlXUuhyJA5q2ANNaNtOkNDa2XO9nQHGTCle/aKNzcN8XJoGP+RC7bcC6ni
         lo2V9HDi2qUE8GY3hSKOg92L2315WuhZHpkWPQohri/JNOZwDTPR4pg9x5VscPyOejzq
         kKbetegpAw/n8FMUvPQyh5SGJ2l/1cYADH6miObSQbwKLxFjpw9tZb/X7W5ip8Ebj7Hd
         lncMlMyfTtnAYDBv3TAceDPaNYIlKFiWd0aqHK+6o81ivTSnPSznSYQ0ooJ49hsOPrnM
         6MHprPsMtmWfjrq5DRwjSyU/s3htNBHsIKBe0VwhwtxB2WkIYSQHcJAU/ZuIm2B6iHtf
         s5Fg==
X-Gm-Message-State: AOJu0YzoJ8l5zGYfHdDybOKP8pGdVXcqsFDCw9oizxDhjnvtl3M30G4A
	C56HxaljFaNob6adKKH2jM7V2sjaSI9RmAcmyFSJznNv+ICmL9nCuuWBId580wYmUqAld93s17E
	e
X-Google-Smtp-Source: AGHT+IHkAQ99eZoZJ5LG/VJuLrwwxKz5i1MtaMTVdJIAt0lzZsYmUIF5oRhgooJT+0c4CsgzeEvjWA==
X-Received: by 2002:a2e:9484:0:b0:2ef:dd45:8755 with SMTP id 38308e7fff4ca-2f15aa8364cmr71274631fa.9.1722843834967;
        Mon, 05 Aug 2024 00:43:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:215c:4f6d:331d:d824? ([2a01:e0a:b41:c160:215c:4f6d:331d:d824])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6d643a4sm127521705e9.2.2024.08.05.00.43.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 00:43:54 -0700 (PDT)
Message-ID: <fa631c09-60e4-4fec-98ce-3f02fd412408@6wind.com>
Date: Mon, 5 Aug 2024 09:43:53 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: Patch "ipv4: fix source address selection with route leak" has
 been added to the 5.15-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20240803145547.888173-1-sashal@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20240803145547.888173-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 03/08/2024 à 16:55, Sasha Levin a écrit :
> This is a note to let you know that I've just added the patch titled
> 
>     ipv4: fix source address selection with route leak
> 
> to the 5.15-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      ipv4-fix-source-address-selection-with-route-leak.patch
> and it can be found in the queue-5.15 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
I'm not sure I fully understand the process, but Greg already sent a mail
because this patch doesn't compile on the 5.15 stable branch.

I sent a backport:
https://lore.kernel.org/stable/20240802085305.2749750-1-nicolas.dichtel@6wind.com/


Regards,
Nicolas

> 
> 
> 
> commit dfd009372d960dc1ccf694e7369d58e63cd133c4
> Author: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> Date:   Wed Jul 10 10:14:27 2024 +0200
> 
>     ipv4: fix source address selection with route leak
>     
>     [ Upstream commit 6807352353561187a718e87204458999dbcbba1b ]
>     
>     By default, an address assigned to the output interface is selected when
>     the source address is not specified. This is problematic when a route,
>     configured in a vrf, uses an interface from another vrf (aka route leak).
>     The original vrf does not own the selected source address.
>     
>     Let's add a check against the output interface and call the appropriate
>     function to select the source address.
>     
>     CC: stable@vger.kernel.org
>     Fixes: 8cbb512c923d ("net: Add source address lookup op for VRF")
>     Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
>     Reviewed-by: David Ahern <dsahern@kernel.org>
>     Link: https://patch.msgid.link/20240710081521.3809742-2-nicolas.dichtel@6wind.com
>     Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
> index 3d00253afbb8d..4f1236458c214 100644
> --- a/net/ipv4/fib_semantics.c
> +++ b/net/ipv4/fib_semantics.c
> @@ -2286,6 +2286,15 @@ void fib_select_path(struct net *net, struct fib_result *res,
>  		fib_select_default(fl4, res);
>  
>  check_saddr:
> -	if (!fl4->saddr)
> -		fl4->saddr = fib_result_prefsrc(net, res);
> +	if (!fl4->saddr) {
> +		struct net_device *l3mdev;
> +
> +		l3mdev = dev_get_by_index_rcu(net, fl4->flowi4_l3mdev);
> +
> +		if (!l3mdev ||
> +		    l3mdev_master_dev_rcu(FIB_RES_DEV(*res)) == l3mdev)
> +			fl4->saddr = fib_result_prefsrc(net, res);
> +		else
> +			fl4->saddr = inet_select_addr(l3mdev, 0, RT_SCOPE_LINK);
> +	}
>  }

