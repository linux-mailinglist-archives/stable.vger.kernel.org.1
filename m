Return-Path: <stable+bounces-52110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF0E907D73
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 22:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE9761F25068
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 20:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914DE12EBF3;
	Thu, 13 Jun 2024 20:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kznGCd75"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52B112F37B
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 20:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718310443; cv=none; b=KvPkwl8mauH+epZsRns5r9trcxn9rCOcxpQ0FjgJ+K+Bvbpfw/Ndhyg5gLufUyg/OVZ19ccNr0gPB133w1/NlH9kLBYPXN8ngb4DpuJgbhIjrUUsvwSbJuQX/xGHK/6+VwZ+D4dhMZjLhKJjycmiyRGBUikdc/0EJUKUOEkwO60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718310443; c=relaxed/simple;
	bh=YXodDXz40jZ+MWcF5dv3BSI0DHRMhrp25UPaBoFObSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EGiXaNhg+X2ygA01EMAx+jiaot27cZO+pDrd09SOls6Rx3whvjjGoK9hutKsuSWOiY5DXLh5BWv5eGajjm6b9C/Im9CFxBi/Xz2l9ahJ1/UUdmBXO/jb0iR7slnO5j6ce5hiJzTvWHqW/CWQZEIBlW6ZmY1aMqqwvpOIFV9gJT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kznGCd75; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4217d451f69so12732875e9.0
        for <stable@vger.kernel.org>; Thu, 13 Jun 2024 13:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718310440; x=1718915240; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=27BzHHL+oAAoXwUjRdXZKEmPdwP3kDGWVdt6JqYjgQY=;
        b=kznGCd75iI0f6WR/2hJCcWd/T9nbkw3dbSbdphPSjCJNPxhNeob0/mElEXcZpOM5gH
         FBKzrnjM/rC6lQ0zTpHUp64fZZMseK6YovZyhf8Z3m5LcBRvfRx9qmqBrk2mJ/jMON6j
         /naUdwvw8WqVD9xZjwSNpWixGyEBwwzB9Yy/vVY5lFRNM5kc8I8c/zTIGlTxc5P16C7e
         +FHq15Gx+HSevJJTodyXpD+YafH4lvrINXv1ktHPFCUPq0kqsZLo18MBSMFyFEVkeS98
         I7CepyM2ckI9mZq/fMVEtJwi0kwLNZUknaOEKPYH6FSJjrg1175r8TUu44I8lgt8GASx
         SIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718310440; x=1718915240;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=27BzHHL+oAAoXwUjRdXZKEmPdwP3kDGWVdt6JqYjgQY=;
        b=nupa5gMYIU9364tsIl8gHbDFsaEfS25s+LDK9/2iIhmTh3I+HxKMhgdNzmF202+E6F
         ikYR8bHL8VMDxKuaeGIhEH4KVUtgC2dT2CQF7yNmxNrLhRkQAB8bb4Mv5kwLg0T2mDPB
         /jDSlkbIQ+xmVwsCfuQVC5BLRW1Ejb3ctJW7EzeyzSV95hlz8sTeWp2BKWCReCR/zSQT
         dZk8DYnBmEmUqwIuTSx1XSCc6bz0+Qc+/RfkIyi9W0nfoXRzg1u/3/jbMR43oye5MCQf
         YKMaie2pc1RvSmt++DpnfYbLBjyhL0tuqOdVTRo2LNZTeygn0UhZxrzO+74Ht/MUHtX+
         3Y+A==
X-Forwarded-Encrypted: i=1; AJvYcCUn2aYNdlNakkTcsm7gC9VrQ2Jr3lmUzhy7gX6iviFvfmy8BxPTRNxRNAn5OZRfFTZJETNM4smYfaBPMpc0KeyetQ2O6QHA
X-Gm-Message-State: AOJu0YySQmCAMkpnN897Y/qf/pXZqe9ZsUax461+1kj/C+2Ro75t+CIW
	fsmexY6/wR4INE9a2dGAtKBhFs+qBj5fSwXAfIP7rDsNMcQ8Nup2
X-Google-Smtp-Source: AGHT+IE0X+NwuPAOu/nie6YYT/cymOSravyDTreAAfC0ijY2Qct00t1yYeDx+v0USP6raooKgBwY1Q==
X-Received: by 2002:a05:600c:1d8e:b0:422:5443:96aa with SMTP id 5b1f17b1804b1-42304827573mr6962005e9.15.1718310439609;
        Thu, 13 Jun 2024 13:27:19 -0700 (PDT)
Received: from [192.168.1.227] (132.28.45.217.dyn.plus.net. [217.45.28.132])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f5f33ccesm35568745e9.3.2024.06.13.13.27.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 13:27:18 -0700 (PDT)
Message-ID: <ae35864a-9a76-4e9e-8a33-2d141f475d4d@gmail.com>
Date: Thu, 13 Jun 2024 21:27:18 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 004/317] r8169: Fix possible ring buffer corruption
 on fragmented Tx packets.
To: Alexey Khoroshilov <khoroshilov@ispras.ru>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Heiner Kallweit <hkallweit1@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>,
 "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
References: <20240613113247.525431100@linuxfoundation.org>
 <20240613113247.702462647@linuxfoundation.org>
 <9592add5-b9e3-d14d-dd1b-2ef3d1057dd1@ispras.ru>
Content-Language: en-GB
From: Ken Milmore <ken.milmore@gmail.com>
In-Reply-To: <9592add5-b9e3-d14d-dd1b-2ef3d1057dd1@ispras.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/06/2024 18:21, Alexey Khoroshilov wrote:
> On 13.06.2024 14:30, Greg Kroah-Hartman wrote:
>> 5.10-stable review patch.  If anyone has any objections, please let me know.
> 
> The patch is cleanly applied to 5.10, but it leads to uninit value
> access in rtl_tx_slots_avail().
> 
> 
> 	unsigned int frags;
> 	u32 opts[2];
> 
> 	txd_first = tp->TxDescArray + entry;
> 
> 	if (unlikely(!rtl_tx_slots_avail(tp, frags))) {
>                                              ^^^^^ - USE OF UNINIT VALUE
> 		if (net_ratelimit())
> 			netdev_err(dev, "BUG! Tx Ring full when queue awake!\n");
> 		goto err_stop_0;
> 	}
> 
> 	opts[1] = rtl8169_tx_vlan_tag(skb);
> 	opts[0] = 0;
> 
> 	if (!rtl_chip_supports_csum_v2(tp))
> 		rtl8169_tso_csum_v1(skb, opts);
> 	else if (!rtl8169_tso_csum_v2(tp, skb, opts))
> 		goto err_dma_0;
> 
> 	if (unlikely(rtl8169_tx_map(tp, opts, skb_headlen(skb), skb->data,
> 				    entry, false)))
> 		goto err_dma_0;
> 
> 	txd_first = tp->TxDescArray + entry;
> 
> 	frags = skb_shinfo(skb)->nr_frags;
>         ^^^^^^   - INITIALIZATION IS HERE AFTER THE PATCH
> 
> There is no such problem in upstream because rtl_tx_slots_avail() has no
> nr_frags argument there.
> 
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> --
> Alexey Khoroshilov
> Linux Verification Center, ISPRAS

Looks like the frags argument was removed in commit 83c317d7b36bb (r8169: remove nr_frags argument from rtl_tx_slots_avail), which first appears in linux-5.11.

I dare say it would be safe to replace
 	if (unlikely(!rtl_tx_slots_avail(tp, frags))) {
with
 	if (unlikely(!rtl_tx_slots_avail(tp, MAX_SKB_FRAGS))) {

Best wait for Heiner to confirm though.

