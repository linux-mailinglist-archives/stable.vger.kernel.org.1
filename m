Return-Path: <stable+bounces-126690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF81AA7140B
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 10:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A1621898B87
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 09:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99991B0F17;
	Wed, 26 Mar 2025 09:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EslX+LhK"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F51719E992
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 09:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742982376; cv=none; b=AI5QSXz6eil6qu79mgzF/tmYHKRz4hYwZtvD9U15y1wBeRuDr+h3xn7KKu20GCQ3L1QzGHxR3XC8pqQzH+Sa5LMhWDPaoNRtgZR6ZYQWesTom14Hxf0dQnMTM9tonsxiN2OFDRspmElVwMga2EsaiR1YuqAao6LdHGffpmc6Rfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742982376; c=relaxed/simple;
	bh=gJIYGQR+RiGM0XJWCm7NWAzwfhYCn3x9TxE2VX287jg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OoukuPn5QdEfU+KGyVlPJzkI299HdJKU8x7bUzEc9X4qz2hdE+TbwCdPIkWKqKCYpMUTNsZuZy5PFOeYtKSjQMputMcKIG0jl6Wkn5ycCfaehrxx1vf7xXi4lYpGTedujkp0bok+CnN8VXW9rWJ9UF5htD/Wd7QiHQoT/nDJhC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EslX+LhK; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abf3d64849dso1063611066b.3
        for <stable@vger.kernel.org>; Wed, 26 Mar 2025 02:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742982371; x=1743587171; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9/kXXpYh2KweuiB5zHwjY0q/TjqrU3OfimILMTsVvAo=;
        b=EslX+LhKXdrPfZT36eafoi5lnJKtuJIdH0X+vutYf208eI3Um4drcmiL/leOFxKuQ/
         iHL7RHrVkkP6ecOsOAdixpOJn3plizjTP9ohyiHn+vi1HM5ivMEvAysv2FQ1ScXwN3DX
         7cCi+qk7ab5XAQhORW96if/0RQBjIw1cctobq22k+tHJtuipVFOkO3J5jszdeMgF27Gb
         qfEDy79uih87UjqXP1DDo3OON4eFuUumqTd60iWzdBKoPoG/kut6F7XSn39M208dMsS5
         fj5vmRMMk9BR5FleJ6cFPoH/YN8/ZoIE4L/JXG+oDEv1UhdPikKJdOzeulFav8a5GJlT
         U+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742982371; x=1743587171;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9/kXXpYh2KweuiB5zHwjY0q/TjqrU3OfimILMTsVvAo=;
        b=woMIKZy98VcQFK173gBRGrKALg2ZEyLmtqWbf3LuNowfKwy2lYsI/kAxA/BvokEJDG
         VZQK/waBYVe/nZ3mNznUrOvmIp0yxcMn0Hx6UmxiJkshyi2qprdokMHcDuAA0rAnQZ+A
         qC/JzX+oTky1L2xX6ZhGUd9lVBN0bTKEMDuo6/GgQmadOb4/gpmx89jXKfohgzFGEvq9
         UrZ0IUQThrUuueog+22JHhJHe97RoSwD/UDSUmkLA+jjgA/M++l5OteKxNcONDfzF4/o
         z1pVYLmLz7A9/JWi0TF5g3JdQ1qWhNrAH78e9KIvoTK+qzqD/rPabhuVWk0UC+RxF0L7
         uryQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJR+E7SPDhM2k7E1MUm4RD4rHIjBN8bHE2sF4pknK7qt1BNPijmJYH+wQwfrIy++IfKt+6R9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBiWOFswuTLz8PQYKSVqjXl1+34vZzWHVGhxNU4+V4Ju2eCI6F
	AL5IjV4YLCl3/GitegmdKttg8b0T0mwnCVGnQ+kpNEJx33LOLkR7QfgKzLZoTvk=
X-Gm-Gg: ASbGncujgrzHnrCRwub24U1JOWcA9eOfTS55BNImydOqC3S0XajU285BqC2oGIosPf8
	D3eXKLN9+djI5TVvVb/dc7jA8pI3BiFuAUDzXDO7g9SR5Cin+1txT06fOZ01GgzaLVnxYT8ZlWB
	pUNCmNMf6K4ChbFnCqbYmJb3f4kREGzqH4ZwFgRFaEQ9eGGvAnutt/JBKQHbDCht+P52RVF3f9u
	xxqJgSfVCU1VCijwb5l6i8lzk07GSGRTASKey8jRdBsMg3akbGrQmayuwx+r5WGMBq8ZRLx2Gw+
	RuwbuBpul8J5huF1RR/Cy4oG/xQUEbWO6Njpnlg4fxyQGK9AgaxrRJ+x5A0kBf0D2MQOXLZYkQz
	LenYQm8el58Du
X-Google-Smtp-Source: AGHT+IHx/kCnyQhbohYhyZQ+ypuL87ESt4h+TC7om1KV6AWAGl0sRqBA5fm81htRzwYvpmm4nlJCag==
X-Received: by 2002:a17:907:3dab:b0:ac3:3cfc:a59a with SMTP id a640c23a62f3a-ac3f26b18e4mr1876478266b.45.1742982371410;
        Wed, 26 Mar 2025 02:46:11 -0700 (PDT)
Received: from ?IPV6:2a02:3033:273:9b44:1f61:c513:306b:cf0e? ([2a02:3033:273:9b44:1f61:c513:306b:cf0e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efbdca5dsm997614466b.137.2025.03.26.02.46.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 02:46:11 -0700 (PDT)
Message-ID: <59f34bce-1069-446f-92ee-934cbad3d7ac@suse.com>
Date: Wed, 26 Mar 2025 10:46:08 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: usb: usbnet: restore usb%d name exception for
 local mac addresses
To: Dominique Martinet <dominique.martinet@atmark-techno.com>,
 Oliver Neukum <oneukum@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Ahmed Naseef <naseefkm@gmail.com>
References: <20250326-usbnet_rename-v2-1-57eb21fcff26@atmark-techno.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20250326-usbnet_rename-v2-1-57eb21fcff26@atmark-techno.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26.03.25 09:32, Dominique Martinet wrote:
> commit 8a7d12d674ac ("net: usb: usbnet: fix name regression") assumed
> that local addresses always came from the kernel, but some devices hand
> out local mac addresses so we ended up with point-to-point devices with
> a mac set by the driver, renaming to eth%d when they used to be named
> usb%d.
> 
> Userspace should not rely on device name, but for the sake of stability
> restore the local mac address check portion of the naming exception:
> point to point devices which either have no mac set by the driver or
> have a local mac handed out by the driver will keep the usb%d name.
> 
> (some USB LTE modems are known to hand out a stable mac from the locally
> administered range; that mac appears to be random (different for
> mulitple devices) and can be reset with device-specific commands, so
> while such devices would benefit from getting a OUI reserved, we have
> to deal with these and might as well preserve the existing behavior
> to avoid breaking fragile openwrt configurations and such on upgrade.)
> 
> Link: https://lkml.kernel.org/r/20241203130457.904325-1-asmadeus@codewreck.org
> Fixes: 8a7d12d674ac ("net: usb: usbnet: fix name regression")
> Cc: stable@vger.kernel.org
> Tested-by: Ahmed Naseef <naseefkm@gmail.com>
> Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
Acked-by: Oliver Neukum <oneukum@suse.com>

