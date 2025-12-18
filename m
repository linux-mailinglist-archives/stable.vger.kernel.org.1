Return-Path: <stable+bounces-202975-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E75BCCBC2B
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 13:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0019830852CB
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 12:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C254328B5D;
	Thu, 18 Dec 2025 12:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IfuBAzed";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hSh5/SVW"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AF1315D37
	for <stable@vger.kernel.org>; Thu, 18 Dec 2025 12:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766060089; cv=none; b=D79kkK3fon23giyxbJ52W9f73guKIRQOuKK3poBitpxocB+VvI7mym3/FkQUHjHx6n9q75vVN7PoZYRQlfD3yJ1IAgwXq2Olh/5M0OPwDgEXlcfTALVpZWDv8fLCqqqw4OONPTX4DzsiU3q7HosRITzyk6xDLouqVtMixBAGSW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766060089; c=relaxed/simple;
	bh=zZq/z6A+c1YO3amUlGXD/9ir5S5QJCBcNizEkWsYebE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sNXuYwEjE4hZh+saPFk/3LtONlrM48xcAit8vy6NjJuD9luVewGpmCy9bsVWU/1QbbPXK92wuI6doDnt1mEyOZKoMC3NpllIse/UTaYYJY/A67YMJV7aK1kkNpNOkSZ+IAucpCFOhE7a1zgOAP2UtJPPx7fdyodJKkLdNLDHjYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IfuBAzed; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hSh5/SVW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766060087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cgRR9HkYxgKFCBqZFhUlWNzAPSgCWmIS+3s3iTb+nEc=;
	b=IfuBAzedwb1bHDHO+23+VbFcPaEGPAQFXtsTK27SVwNSquY2Aine/DeUH8o3/40WK2oekd
	fG0bHPSS2+wAe4Sy8eI4sPNF5w7GwKQiUHh1bdG87ei93FuMSygEKmguTwkFuwLU7mNoAT
	zk0l8PQExubnhCVQF1kRty1XlxxvmhE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-KQ8D_XyhMqmMj0ZaU9pBsQ-1; Thu, 18 Dec 2025 07:14:45 -0500
X-MC-Unique: KQ8D_XyhMqmMj0ZaU9pBsQ-1
X-Mimecast-MFC-AGG-ID: KQ8D_XyhMqmMj0ZaU9pBsQ_1766060085
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-430f5dcd4cdso265142f8f.2
        for <stable@vger.kernel.org>; Thu, 18 Dec 2025 04:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766060084; x=1766664884; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cgRR9HkYxgKFCBqZFhUlWNzAPSgCWmIS+3s3iTb+nEc=;
        b=hSh5/SVWDSBolN7b/O+rkn5o90BSF8Jh1b/OZBrfmdsdzCL3/Mjr7t0SL6JTJgvn7t
         bul5M8D133L9sgpOPZCkxYPl6jQqrn7pMizhdKiSsW9cMCA2tLiUUTeiFmGSmCxSZPQZ
         ChqcaOVcPoOwGhx3U6DLdGDPDVlCLOiISWYOnL1acwppMalX4R8ZMJqe5a1+ozr+Earm
         UECARwXRgD/N3Geg5qsBBrZp2l60Mum287Bus2hgTWpofmrlIDcdE6FIXjKQOSTZWW1o
         KcEt6u5gk/nsFdDNoxz+8OF5dl5SpHnPBtz4uNOxJePiYW+pDSqatrhWuhxGrMqkMoc+
         Wl6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766060084; x=1766664884;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cgRR9HkYxgKFCBqZFhUlWNzAPSgCWmIS+3s3iTb+nEc=;
        b=tK+xbHxwsIpApFxMz0plheraFVWQOynR5TlzhqTeRkCS85uMzcKJNwl8YEAltbL8Yc
         9dmPHAfl1buSHjc5nmXZWrbu1ibX06rPGCM2bhcCoO2WRn75S4kL66paC2sd4bDzMx/J
         jHnj4P+VZQKM5rsYY77uLvOOu9VYwAdNE2c8suijb4wY6Y9b/6kcwK7X8dOpdrr4pGei
         Wlp/FMReuA++9GVUBRzQOUCZLmp3PEIDbzpmUrrcCcDgVx3CyqXz6GFPIpyQ7RCjrKwI
         RogRdfYM1RxdkVeF5zYFMk7gIociKpJ2L/78UT9Z5wtqaiKPHqKsorgXsLLCwyIAwGGf
         xbWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVROwILLkiem/5kUO3kJnthzmQaRepIS3rpd3nDnMX/WNX/0YaRoS+z2IS/kYL3yWFlI7cfi8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuUgXSRGZmMcXauG4EuOltzi58LxRSqTtSnpws6BjXdJU2kny0
	QrTygI7u0AFEdW5XgLgx/48539QmxekpN+dJAQUtTOxjY0kge953QG5X3eIAddtAkOHJs0tKN9I
	hMnYD9fz/O+fZuUk4ud/94N5mOvJjcg2TMnzTFwQzQvx47KfkMSdmnHyCWA==
X-Gm-Gg: AY/fxX4NyapWtGRV/aOQbuk+NHS5QjePrb2sbmQ4VaFKNeg0j3arBkbYIx2UFYExpT7
	XOsK5qGaDATNeftVn2oolI2qOa3GhHnQ8E8ZJ3WFf3MgzsMcL42oF0VRSxTJZg0aSm1AyUwkTD6
	vw4uQkYPc3LNsepHGDqIKGyZEYBXQEsNoB8sIyLlC1rwpKPc5T6IdljOaBZMv1D11ySTAzrJUZl
	eI5GaOQNqBEJTkJok/Y+uuhW0p/Ynwku/Ty4f/Z5g8ZrGUOF9k67JKSg7lPMWkw5zJ0nQsFDqTA
	XgtuXLnzdZfjM/ovS7GJo0iRHK1uuzpC08X95nyetmA8X8p7lIL140uZXJBWxNdpFrCDDm0iea0
	+tgH0iaF8On8GGw==
X-Received: by 2002:a05:6000:2f81:b0:42b:47da:c313 with SMTP id ffacd0b85a97d-42fb4476da0mr21110617f8f.3.1766060084549;
        Thu, 18 Dec 2025 04:14:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0An4Sok3enuv2kgkb9o1arBJPUDV09ozAK/U7xjG+0Sp9Co7WHhQ+s/88Jm0Y8UT/MGGhcA==
X-Received: by 2002:a05:6000:2f81:b0:42b:47da:c313 with SMTP id ffacd0b85a97d-42fb4476da0mr21110595f8f.3.1766060084083;
        Thu, 18 Dec 2025 04:14:44 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.159])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43244934cf5sm4767319f8f.1.2025.12.18.04.14.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Dec 2025 04:14:43 -0800 (PST)
Message-ID: <f73dcdc2-a63f-44e9-9c3e-c1c6340d099f@redhat.com>
Date: Thu, 18 Dec 2025 13:14:42 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: macb: Relocate mog_init_rings() callback from
 macb_mac_link_up() to macb_open()
To: Xiaolei Wang <xiaolei.wang@windriver.com>, nicolas.ferre@microchip.com,
 claudiu.beznea@tuxon.dev, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, rmk+kernel@armlinux.org.uk,
 Kexin.Hao@windriver.com
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251209085238.2570041-1-xiaolei.wang@windriver.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251209085238.2570041-1-xiaolei.wang@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/9/25 9:52 AM, Xiaolei Wang wrote:
> In the non-RT kernel, local_bh_disable() merely disables preemption,
> whereas it maps to an actual spin lock in the RT kernel. Consequently,
> when attempting to refill RX buffers via netdev_alloc_skb() in
> macb_mac_link_up(), a deadlock scenario arises as follows:
>   Chain caused by macb_mac_link_up():
>    &bp->lock --> (softirq_ctrl.lock)
> 
>    Chain caused by macb_start_xmit():
>    (softirq_ctrl.lock) --> _xmit_ETHER#2 --> &bp->lock

Including the whole lockdep splat instead of the above would be clearer;
in fact, I had to fetch the relevant info from there.

> Notably, invoking the mog_init_rings() callback upon link establishment
> is unnecessary. Instead, we can exclusively call mog_init_rings() within
> the ndo_open() callback. This adjustment resolves the deadlock issue.
> Given that mog_init_rings() is only applicable to
> non-MACB_CAPS_MACB_IS_EMAC cases, we can simply move it to macb_open()
> and simultaneously eliminate the MACB_CAPS_MACB_IS_EMAC check.

This part is not clear to me: AFAICS the new code now does such init
step unconditionally, which looks confusing. I think such step should
still be under the relevant conditional (or you need to include a
better/more verbose explanation describing why such check is not really
needed).

> Fixes: 633e98a711ac ("net: macb: use resolved link config in mac_link_up()")
> Cc: stable@vger.kernel.org
> Suggested-by: Kevin Hao <kexin.hao@windriver.com>
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>

Side note: you still need to include the 'net' tag into the subj prefix.

/P


