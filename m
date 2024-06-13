Return-Path: <stable+bounces-52081-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C369079B0
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 19:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 873CC1F246E7
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 17:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E785C12FF8E;
	Thu, 13 Jun 2024 17:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="Q5x+We/6"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F220D1494D1
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 17:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718299329; cv=none; b=lxrkmvva+klmYSJb2mVUYygMbjE5e7BcPLUGz5snbb++BNiHpwYrbrRwtuJG3FXds0yA0x8cVCs5KKgiKz/R4PslaCFtRVSX70CNv1qiEhkC35ZGVyMY2suQmQbM3Yo0dVIGGhommlKkwOJGMWiX+DIkEL6Rjwfknucu06aBQi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718299329; c=relaxed/simple;
	bh=Wu4vLKYYfYmzdJTZcksSYwuoKqeJDPqUPkuJ0GJlQSY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=jmjL0K1QbM1LUZb9Snj3UKRul7HJUWFD6BctSqexeIYGiU+YCXnjqlXto1sym48wwFHabw40fNojChJZxDNLi/MXGDCPrEZJJ7/UQHhcHwuczHwK7ftQksqC3nrBtGMaUewxdqAg0dJLTAC28WwD59fs1/YB4Fj1+9F3gbpAGbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=Q5x+We/6; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from [10.10.2.52] (unknown [10.10.2.52])
	by mail.ispras.ru (Postfix) with ESMTPSA id C113540737CA;
	Thu, 13 Jun 2024 17:21:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru C113540737CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1718299314;
	bh=g3v2Vty2w7Rq9q9Q5VvRCudaV6Bs94Q7Y2dxGyTz/bQ=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
	b=Q5x+We/67O7dcMUgY778Wy/YvFgCPC8B49oF8/c9kbLP5Dp59JMrvsOEo8CsL1/y1
	 vHPFfAs4iFs7K+8sU8lbt5c/zvht87dGUS3lP8zNjRjNIPcYKRvYVgpGBfTuZdcP8E
	 e1ZQg391iNAdo9UfpOquqZAYyepQLP6ElA0owpes=
Subject: Re: [PATCH 5.10 004/317] r8169: Fix possible ring buffer corruption
 on fragmented Tx packets.
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Ken Milmore <ken.milmore@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
References: <20240613113247.525431100@linuxfoundation.org>
 <20240613113247.702462647@linuxfoundation.org>
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Message-ID: <9592add5-b9e3-d14d-dd1b-2ef3d1057dd1@ispras.ru>
Date: Thu, 13 Jun 2024 20:21:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240613113247.702462647@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 13.06.2024 14:30, Greg Kroah-Hartman wrote:
> 5.10-stable review patch.  If anyone has any objections, please let me know.

The patch is cleanly applied to 5.10, but it leads to uninit value
access in rtl_tx_slots_avail().


	unsigned int frags;
	u32 opts[2];

	txd_first = tp->TxDescArray + entry;

	if (unlikely(!rtl_tx_slots_avail(tp, frags))) {
                                             ^^^^^ - USE OF UNINIT VALUE
		if (net_ratelimit())
			netdev_err(dev, "BUG! Tx Ring full when queue awake!\n");
		goto err_stop_0;
	}

	opts[1] = rtl8169_tx_vlan_tag(skb);
	opts[0] = 0;

	if (!rtl_chip_supports_csum_v2(tp))
		rtl8169_tso_csum_v1(skb, opts);
	else if (!rtl8169_tso_csum_v2(tp, skb, opts))
		goto err_dma_0;

	if (unlikely(rtl8169_tx_map(tp, opts, skb_headlen(skb), skb->data,
				    entry, false)))
		goto err_dma_0;

	txd_first = tp->TxDescArray + entry;

	frags = skb_shinfo(skb)->nr_frags;
        ^^^^^^   - INITIALIZATION IS HERE AFTER THE PATCH

There is no such problem in upstream because rtl_tx_slots_avail() has no
nr_frags argument there.


Found by Linux Verification Center (linuxtesting.org) with SVACE.

--
Alexey Khoroshilov
Linux Verification Center, ISPRAS

