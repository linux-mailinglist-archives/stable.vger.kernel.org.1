Return-Path: <stable+bounces-154973-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 886FDAE1567
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 10:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0258169DDA
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 08:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C45223236F;
	Fri, 20 Jun 2025 08:04:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36774231839;
	Fri, 20 Jun 2025 08:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750406690; cv=none; b=W4nUAjlR9lO/0zaQRIpUA+3WbiYQSG1tBD9BtuoExRD2SpT0o5aRb6IQaRDLdo+ERelYRplch4URFlzWTn+aQYjfbpkY7HPGnhecdblvL9O7VQukuXt47cehgIAUuuQfoQG5fzUPG7AS/kmb0M/gOuG4Agh5tzGMpClc9p+hgpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750406690; c=relaxed/simple;
	bh=6mR4fOP6MNO3YRuX9MZpyW1vo/oZGxSsIDAcFTU9vX4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GNY3xutrsB13NG7eoVImSCAwkV3srqaobTh/0xXLMgU/Dd+xhnVTfYYhWg1XwIQ0yzaCmIAUxIWXsH8/0OM8a0cFc6+2SCiWAMTa7AgJJ4rGgFS6eQuK8506DlhurVrWgk+VYXDIJ+LwtDhzp9v+U/v92t+mPckTS2WUOuUYuXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-ae04ce9153aso199961066b.0;
        Fri, 20 Jun 2025 01:04:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750406686; x=1751011486;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLhZ95wJzeGFC6l3NMx0nFISsvWc6wJkbwkQc8bhIos=;
        b=wkUeFqQRzR0MvpnIyW8MwWR3g71lZbEVvoWXs9IMxleAb1KSVl5xHZ+9QVK2uLkrlS
         JrzBBKM82uAv/VYkZjrEJL7jciTjqgXtvzLWtvdbaK/XOu4zy3Ui59t2Q+ZZsDTXJd9H
         7BDIlejHIyBzTTl1hoP/b795eYGgsWm4wPVuhth4epvKCRNg4ruv+5/bc1UFdnOZ+g1Y
         HnDYb5P9BPQ/dQ0rvhGqoLuLy4v3B1/aYXe8hgUjAFgXcE4ErM1dWH4nA9nLo1kfOUJc
         2xKVPnANMJnkiv3K7OQeEDBoce+buoz1inSMB5OLvxKI4YWe8g6v03albGzbwH1sBFKE
         tBCw==
X-Forwarded-Encrypted: i=1; AJvYcCWbvJuNDTjt8V7xzGHbQ+kQ6Q6SMV9nchUMuvpVtgXNBpydo+VIxUDIcI2Bfx/UAr8rCLPKssL3KV8phlDL9A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwBZbRtBdUvzaIO2mHrOWwE15QjXrPKLv93f3Nn9vnYzsFegQjc
	y2s0BGI2gfczOu2PZkp2X4Oxl7i2VDIKYr0hIOc8j6ypcaIz6YsEoIACMr1anXz6
X-Gm-Gg: ASbGncumkQwyzEqGDSAg9Br89/wB5tuSN/6WSEMIn8MU/EPnSPhctXg0Ez+qg6EbUCB
	/DSVG3sEpUjvfxJjVJxNejHlKf456rzirw23HKffipmQVXvMC7pTW2aJkPS4rBh5A4TuAftrfon
	lqjdsheoUOGHsnn52/RWq5+XleoYXQteapR4dsNDbfZfMF4rYZVBIzP1FSQlB7S6hfX3+y6k1L9
	Cw8i35EBCM5MWyWJo8b8vbHbckndnGn9eXcyc1DX/GpZiBtkwDFk/zBSXtKz1BRIQ/uTe1ktDKA
	6gk0eKskxhV49nIu/e8hgOV6pGCUB+QQ7svmF4VyuiwNpVn57fQ8kUBMRu7NWH6OEtUh3pdk4TL
	t1O72fpnhqp7nfOxJ1yXj2wY=
X-Google-Smtp-Source: AGHT+IHcIZ/tq396XhbbLxmJks7XraSLn1tBDXLoV7FPjaYpSng5Fvb9lTME+X8ZHkqs+UCSNHJF9w==
X-Received: by 2002:a17:906:fd85:b0:ae0:33aa:986d with SMTP id a640c23a62f3a-ae05adfcf58mr137113566b.6.1750406686121;
        Fri, 20 Jun 2025 01:04:46 -0700 (PDT)
Received: from [192.168.88.252] (78-80-106-150.customers.tmcz.cz. [78.80.106.150])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0541b6b54sm121059066b.116.2025.06.20.01.04.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 01:04:45 -0700 (PDT)
Message-ID: <6d21ab64-88f9-4380-9e28-63700bddbe30@ovn.org>
Date: Fri, 20 Jun 2025 10:04:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, Aaron Conole <aconole@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Greg KH <greg@kroah.com>,
 Sasha Levin <sashal@kernel.org>
Subject: Re: Patch "openvswitch: Stricter validation for the userspace action"
 has been added to the 6.15-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org,
 echaudro@redhat.com
References: <20250620023232.2605858-1-sashal@kernel.org>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20250620023232.2605858-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/20/25 4:32 AM, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     openvswitch: Stricter validation for the userspace action
> 
> to the 6.15-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      openvswitch-stricter-validation-for-the-userspace-ac.patch
> and it can be found in the queue-6.15 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

FWIW, backporting of this change was previously discussed here:
  https://lore.kernel.org/netdev/2025060520-slacking-swimmer-1b31@gregkh/

With the conclusion to drop it as it's not a bug fix and hence there is
no reason to backport it.

Best regards, Ilya Maximets.

> 
> 
> 
> commit 77c2ef6608f0cb47cbcc0d3e0a4371e35f70e125
> Author: Eelco Chaudron <echaudro@redhat.com>
> Date:   Mon May 12 10:08:24 2025 +0200
> 
>     openvswitch: Stricter validation for the userspace action
>     
>     [ Upstream commit 88906f55954131ed2d3974e044b7fb48129b86ae ]
>     
>     This change enhances the robustness of validate_userspace() by ensuring
>     that all Netlink attributes are fully contained within the parent
>     attribute. The previous use of nla_parse_nested_deprecated() could
>     silently skip trailing or malformed attributes, as it stops parsing at
>     the first invalid entry.
>     
>     By switching to nla_parse_deprecated_strict(), we make sure only fully
>     validated attributes are copied for later use.
>     
>     Signed-off-by: Eelco Chaudron <echaudro@redhat.com>
>     Reviewed-by: Simon Horman <horms@kernel.org>
>     Acked-by: Ilya Maximets <i.maximets@ovn.org>
>     Link: https://patch.msgid.link/67eb414e2d250e8408bb8afeb982deca2ff2b10b.1747037304.git.echaudro@redhat.com
>     Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
> index 518be23e48ea9..ad64bb9ab5e25 100644
> --- a/net/openvswitch/flow_netlink.c
> +++ b/net/openvswitch/flow_netlink.c
> @@ -3049,7 +3049,8 @@ static int validate_userspace(const struct nlattr *attr)
>  	struct nlattr *a[OVS_USERSPACE_ATTR_MAX + 1];
>  	int error;
>  
> -	error = nla_parse_nested_deprecated(a, OVS_USERSPACE_ATTR_MAX, attr,
> +	error = nla_parse_deprecated_strict(a, OVS_USERSPACE_ATTR_MAX,
> +					    nla_data(attr), nla_len(attr),
>  					    userspace_policy, NULL);
>  	if (error)
>  		return error;


