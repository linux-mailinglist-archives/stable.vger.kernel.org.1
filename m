Return-Path: <stable+bounces-186083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07796BE383C
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 14:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B17E95844A9
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 12:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D07334380;
	Thu, 16 Oct 2025 12:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="W1l0wR4T"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478D1215F6B
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 12:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760619302; cv=none; b=j5QQ6hd08UpuDgr5pWUdWlXJTlp7rThBei+sjFj9gEUJqmszgohxUF9LrA2sphH+QZ/bqQgbzMYSI6/bRezuK9cvYubw3Pec2nKuQx+PITq7Llj0dXn7ngIWDbf+ERoZdemtF7CKBuBQ/59apCEgPciaSb4W+4spwPQ8d7iUDn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760619302; c=relaxed/simple;
	bh=ZUUjOUmPi99YByQi2GU9o7fH4nLtDooMLe4/nsf+y+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JrPyQ3DFkGMb1HX2MjMy6giOZ2X/+HdR+PXNILCJFtjhHDjMwDMxlIoqdXA9sW00yzitEXIOBjedSKppSK+n3WZqfgylKPEyizTKgABWjiiVs2vl8drHPBxgMwr3SoG03YbbEMTu0J/6VZizLT7g8YqZz/x78qZbm4GRivOKQXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=W1l0wR4T; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b4c89df6145so118782366b.3
        for <stable@vger.kernel.org>; Thu, 16 Oct 2025 05:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1760619298; x=1761224098; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lwkOC946NVK5Ay5tT6TcDur2LlBPpaKMS7PptjXrqlg=;
        b=W1l0wR4TaWGwBUbq/ab/6ckr2AdByPJ71vqOIKY5WaIGOkZ7dJLMrgWUE0eteg2YDd
         xPKM2NoOTyX7xQSk8k3tCcamfreRMtHLKSrNdQQOMcyXkwIroCVWB9irJAGp6jnHKIbC
         OXO123h3ayv05YZtJRW/Xf4ssw/1CikxVumz8ci4Mw4xTkRzbrZFi0yXRYtm53VHhiIC
         CsLH+OrAbcDyhJkkMS335Bnu9YfdpGXu112WhauXmPoEjay5juvpp0xGNUgReHWqJLzs
         yrnJlsqrzUYtzcM1yU1vA66x0YNGmtWNUDw6CbGIscErnjkdiCouil3CdEJOzlljLP/v
         YFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760619298; x=1761224098;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lwkOC946NVK5Ay5tT6TcDur2LlBPpaKMS7PptjXrqlg=;
        b=AqOls6eB2QiuPYelWQFZqFwhZRCgVOSnIxpamsO4PvaFzxdKAw8+EvCU6SXRACdWtG
         Zu4o0UtCJN8rxt3v6+7B+z9bZPLy/d8r6f4WLGdvH6lxeL0gOdmGDD/YZqeEICm7xkm3
         r7i/YYDkKpZhohM2fIhtb/R1PBpMvkDE8yiIvd+8k0fVfbLJhbpOtIFTDzf+APfOqfe9
         UThNYlxad4PG3v43QpTj3ur4jX4QeUK2E4XN1ujuVWYRH1Z3VsDNTK3mU6Og3MIJVF9T
         ylfQgxGLa1gx8qWwpICUSxpLmosJ5oauzcXDuXVmgbY9e2xm8m4hh6AHO7tNTjA/CEKR
         Z4Sw==
X-Forwarded-Encrypted: i=1; AJvYcCUgkpN5Pfn/041jZCJ1OPTnri8cAuLj5CjILayNp7sZq5dTkDiyNd+Y5ZdoKHsuAPhMq+YfUxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YznpbhYFf8MUHaaOPAk6N4le+TZokfckNJ6EPmq+f9WwYl/BbAr
	iVGnDpgTvlFHdOS445XFKPQQSzOLFFmsDeRbQpETuxIWGG5l1eI9nAPpB96gZx+J/SA=
X-Gm-Gg: ASbGncvVz7mKTX6CVdq8DOHvhgUqnVJXBbqOpBTaktCqKSEXKif/Iw9cSb8yGqioJcY
	pXSyeO6UuYC2qlbS4U32vnordqvXhO2/ck05HSqAcGCz2ZUvEpEPTs4mz7TOdlI6OJP7yZXRkVx
	BrOEFxPgN43PpmYpu3i39sKy0LN8JgDEWD7gASVDshSxsaAqQtJondol78EYKu2nDeWDVzVzkx+
	UG1HU4E3G6YGFitPpH92b9mxavhL9d2A3Xqr8K1YRnUxVVz6lsV7zrj4XLg6dORqksJQOc26b8o
	K8k1aGvY7GrMGOTzIyhkNI7+jl/D7TU+MklupukWXPS6GRA3hHmT55SEcdDiRThkAWPoiGomnqO
	NDujz28EShShIOFDDqtv5L3hqJHoeX09Jgcd9cD0IOLxLus0xg6zJpGfepBPPA/IqBqG3mbbrby
	lv3BxjN7xuBfPO8q2Am+erMTsPiX3TirGb9o3B2D9VZOA=
X-Google-Smtp-Source: AGHT+IFVF436vNsuSyK1BdMzDZ4sJZPhS32XY4Fq1N1PXqLrCDq/cqw04QJpxvzdr76ooTNaiQ5xzg==
X-Received: by 2002:a17:907:3f13:b0:b40:5752:169a with SMTP id a640c23a62f3a-b50acc1a94amr3374920566b.58.1760619298216;
        Thu, 16 Oct 2025 05:54:58 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5ccd1af87bsm511915766b.63.2025.10.16.05.54.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 05:54:57 -0700 (PDT)
Message-ID: <d6473e8b-903c-4116-a059-50814bceec75@blackwall.org>
Date: Thu, 16 Oct 2025 15:54:56 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: bonding: update the slave array for broadcast
 mode
To: Tonghao Zhang <tonghao@bamaicloud.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Hangbin Liu <liuhangbin@gmail.com>, Jiri Slaby <jirislaby@kernel.org>,
 stable@vger.kernel.org
References: <20251016125136.16568-1-tonghao@bamaicloud.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20251016125136.16568-1-tonghao@bamaicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/25 15:51, Tonghao Zhang wrote:
> This patch fixes ce7a381697cb ("net: bonding: add broadcast_neighbor option for 802.3ad").
> Before this commit, on the broadcast mode, all devices were traversed using the
> bond_for_each_slave_rcu. This patch supports traversing devices by using all_slaves.
> Therefore, we need to update the slave array when enslave or release slave.
> 
> Fixes: ce7a381697cb ("net: bonding: add broadcast_neighbor option for 802.3ad")
> Cc: Jay Vosburgh <jv@jvosburgh.net>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Hangbin Liu <liuhangbin@gmail.com>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: <stable@vger.kernel.org>
> Reported-by: Jiri Slaby <jirislaby@kernel.org>
> Tested-by: Jiri Slaby <jirislaby@kernel.org>
> Link: https://lore.kernel.org/all/a97e6e1e-81bc-4a79-8352-9e4794b0d2ca@kernel.org/
> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
> Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
> v2:
> - fix the typo in the comments, salve -> slave
> - add the target repo in the subject
> ---
>  drivers/net/bonding/bond_main.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 17c7542be6a5..2d6883296e32 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -2384,7 +2384,9 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
>  		unblock_netpoll_tx();
>  	}
>  
> -	if (bond_mode_can_use_xmit_hash(bond))
> +	/* broadcast mode uses the all_slaves to loop through slaves. */
> +	if (bond_mode_can_use_xmit_hash(bond) ||
> +	    BOND_MODE(bond) == BOND_MODE_BROADCAST)
>  		bond_update_slave_arr(bond, NULL);
>  
>  	if (!slave_dev->netdev_ops->ndo_bpf ||
> @@ -2560,7 +2562,8 @@ static int __bond_release_one(struct net_device *bond_dev,
>  
>  	bond_upper_dev_unlink(bond, slave);
>  
> -	if (bond_mode_can_use_xmit_hash(bond))
> +	if (bond_mode_can_use_xmit_hash(bond) ||
> +	    BOND_MODE(bond) == BOND_MODE_BROADCAST)
>  		bond_update_slave_arr(bond, slave);
>  
>  	slave_info(bond_dev, slave_dev, "Releasing %s interface\n",

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


