Return-Path: <stable+bounces-52182-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 757B3908AA7
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 13:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BF8D288E90
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 11:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF346194A7F;
	Fri, 14 Jun 2024 11:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfnaMntr"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1251922C6
	for <stable@vger.kernel.org>; Fri, 14 Jun 2024 11:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718363216; cv=none; b=PoTVGjIOp8Xe4nS/K59c8EoC9zeinP8zRi5dBgqDDLsl5YwOVetYd6vmHrILH6wGD0WDlnZyLz4vg2vJuc672fPKodflVgzC3tji7GILae6gsxDPjNSVWFasspCeTq3CFOKf0fJ8QhyCGpqZIW4KkcdlNkJUJlLz80jtIsdTOp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718363216; c=relaxed/simple;
	bh=K39z/7LGE/Fu+27l1PLvtZ8nbzeX+T5A+Oi7ylaDw7E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Hc3Hs8kl2GBa53i+yfNQPzhBOEUxcclopMf5x6kGW+p+dJq45egfcNGxURqBYix4bMFfzVU0vd5v8rvcVp7NMsnCsmFXo/jqN0vhmAUlP8X7HkPgLFw+dceS3yPzB4pbIZlwZWD2dXeU4didZUdsSN2vzZniTJcPMWUwVWA3xbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AfnaMntr; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e724bc46c4so21811261fa.2
        for <stable@vger.kernel.org>; Fri, 14 Jun 2024 04:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718363213; x=1718968013; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HtDpJcdpavz6cBylx2JMFPBLe/yTCka1erD+aP6W33s=;
        b=AfnaMntrGzUWsdOgTQiqiiNpoXEDQqQAvZjZnCJ7vlFtt6RdUINAqY9jR2Dvl16O9I
         4ygEzHE5fepQwKJGK+8PdwvhzBPKbzqwxmltNSGNJW8D4J+ZeDfMcVK1BaBExzCqZojm
         qRHXCZbbcROPanOoxmRrE/32MnmlexnfRjxDrx2Kt7mpdt2+hIbxEkf8V4jcJQroJx9l
         NVd1Skjpd+QQ27AwxF3RC7EP/2AVfn9y3nFfNcfqad0A6R2T2TOAEXUXFEnTyaqA9HQw
         VbzIkelb8DkcMDhfTrGYhIN5Fv+rUZjRjh/Fpx8pGAdQkvc0Ix6073bLtVwVsZ2Dtpd7
         AbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718363213; x=1718968013;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HtDpJcdpavz6cBylx2JMFPBLe/yTCka1erD+aP6W33s=;
        b=OCfYsZ8S71yZZFbWcvQsAHdUgdEq2MUg6TdkXjloImQvgCcBkgGkZxCRHne/NzDNnR
         z6N6YeZBhc1Gn0F9nHTJPp1aicxqjPpHI6ZbiVNRldY4oMuA73ze+2nPiNlF+WJdJjYr
         3e6BCDpB4dx2JcTf52iouTvB/cMvG8GMGADbP5G40zdBQ9l/E3iME4tDleDsmz1UFKnW
         IXFjcKzOJNL4uvzK5RVuokeiC10IpKycyRWYiKAF82Q8s7Njj4qh4ukGNSQ61WfnJiHl
         7J5b3zpdfQKgL4lFvb80QmTo3983WiAFyRcOUsHDjR5EKv3O6HEAByWJtQhFmhtnpbRy
         9z+w==
X-Forwarded-Encrypted: i=1; AJvYcCVCbGrN3ruuhkkFhlPfz+4iNqs+U/x5RqSLqgMejt+OC8Td2A4z73Uwb4SAmHRXthDAi9A5QH3LOboAVPSasD1V6WtvzpSk
X-Gm-Message-State: AOJu0YxQ2mIG28xNYUl1TvAL2BGcHiDNM2wqx+T2fIMJZ3P9ZlgbgVft
	OYiPHDOADHbNoIJ1WvThpXDmKcuBymAxhR9gZ5SZTz1kniUdZhYO
X-Google-Smtp-Source: AGHT+IEIySahOq+eoCwln0+vI0Wmi80YGigUharhGehoW+hvSYQ+4A1gI84xogI+CDwmaTjW6EPPfA==
X-Received: by 2002:a2e:b04a:0:b0:2eb:e505:ebea with SMTP id 38308e7fff4ca-2ec0e5d0b93mr15640041fa.25.1718363212785;
        Fri, 14 Jun 2024 04:06:52 -0700 (PDT)
Received: from [192.168.1.227] (132.28.45.217.dyn.plus.net. [217.45.28.132])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874e73e8sm94985885e9.43.2024.06.14.04.06.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 04:06:52 -0700 (PDT)
Message-ID: <a399b30f-fb9e-4d7c-8a3b-bce9898a7f19@gmail.com>
Date: Fri, 14 Jun 2024 12:06:51 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 004/317] r8169: Fix possible ring buffer corruption
 on fragmented Tx packets.
From: Ken Milmore <ken.milmore@gmail.com>
To: Alexey Khoroshilov <khoroshilov@ispras.ru>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Heiner Kallweit <hkallweit1@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>,
 "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
References: <20240613113247.525431100@linuxfoundation.org>
 <20240613113247.702462647@linuxfoundation.org>
 <9592add5-b9e3-d14d-dd1b-2ef3d1057dd1@ispras.ru>
 <ae35864a-9a76-4e9e-8a33-2d141f475d4d@gmail.com>
Content-Language: en-GB
In-Reply-To: <ae35864a-9a76-4e9e-8a33-2d141f475d4d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 13/06/2024 21:27, Ken Milmore wrote:
> On 13/06/2024 18:21, Alexey Khoroshilov wrote:
>> On 13.06.2024 14:30, Greg Kroah-Hartman wrote:
>>> 5.10-stable review patch.  If anyone has any objections, please let me know.
>>
>> The patch is cleanly applied to 5.10, but it leads to uninit value
>> access in rtl_tx_slots_avail().
>>
>>
>> 	unsigned int frags;
>> 	u32 opts[2];
>>
>> 	txd_first = tp->TxDescArray + entry;
>>
>> 	if (unlikely(!rtl_tx_slots_avail(tp, frags))) {
>>                                              ^^^^^ - USE OF UNINIT VALUE
>> 		if (net_ratelimit())
>> 			netdev_err(dev, "BUG! Tx Ring full when queue awake!\n");
>> 		goto err_stop_0;
>> 	}
>>
>> 	opts[1] = rtl8169_tx_vlan_tag(skb);
>> 	opts[0] = 0;
>>
>> 	if (!rtl_chip_supports_csum_v2(tp))
>> 		rtl8169_tso_csum_v1(skb, opts);
>> 	else if (!rtl8169_tso_csum_v2(tp, skb, opts))
>> 		goto err_dma_0;
>>
>> 	if (unlikely(rtl8169_tx_map(tp, opts, skb_headlen(skb), skb->data,
>> 				    entry, false)))
>> 		goto err_dma_0;
>>
>> 	txd_first = tp->TxDescArray + entry;
>>
>> 	frags = skb_shinfo(skb)->nr_frags;
>>         ^^^^^^   - INITIALIZATION IS HERE AFTER THE PATCH
>>
>> There is no such problem in upstream because rtl_tx_slots_avail() has no
>> nr_frags argument there.
>>
>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>
>> --
>> Alexey Khoroshilov
>> Linux Verification Center, ISPRAS
> 
> Looks like the frags argument was removed in commit 83c317d7b36bb (r8169: remove nr_frags argument from rtl_tx_slots_avail), which first appears in linux-5.11.
> 
> I dare say it would be safe to replace
>  	if (unlikely(!rtl_tx_slots_avail(tp, frags))) {
> with
>  	if (unlikely(!rtl_tx_slots_avail(tp, MAX_SKB_FRAGS))) {
> 
> Best wait for Heiner to confirm though.

Further to this, I have tested the following amended patch to 5.10 on the RTL8125b and it works without problems:


diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index c29d43c5f450..8aa0097bf887 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4279,16 +4279,16 @@ static void rtl8169_doorbell(struct rtl8169_private *tp)
 static netdev_tx_t rtl8169_start_xmit(struct sk_buff *skb,
 				      struct net_device *dev)
 {
-	unsigned int frags = skb_shinfo(skb)->nr_frags;
 	struct rtl8169_private *tp = netdev_priv(dev);
 	unsigned int entry = tp->cur_tx % NUM_TX_DESC;
 	struct TxDesc *txd_first, *txd_last;
 	bool stop_queue, door_bell;
+	unsigned int frags;
 	u32 opts[2];
 
 	txd_first = tp->TxDescArray + entry;
 
-	if (unlikely(!rtl_tx_slots_avail(tp, frags))) {
+	if (unlikely(!rtl_tx_slots_avail(tp, MAX_SKB_FRAGS))) {
 		if (net_ratelimit())
 			netdev_err(dev, "BUG! Tx Ring full when queue awake!\n");
 		goto err_stop_0;
@@ -4309,6 +4309,7 @@ static netdev_tx_t rtl8169_start_xmit(struct sk_buff *skb,
 				    entry, false)))
 		goto err_dma_0;
 
+	frags = skb_shinfo(skb)->nr_frags;
 	if (frags) {
 		if (rtl8169_xmit_frags(tp, skb, opts, entry))
 			goto err_dma_1;


An alternative to this amendment would be to apply 83c317d7b36bb as a prerequisite, but that does not apply cleanly to 5.10 without some massaging.

Because of these complications, I would suggest it may be safest to omit this patch from 5.10 for now.

NAKed-by: Ken Milmore <ken.milmore@gmail.com>

