Return-Path: <stable+bounces-59051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAE492DD58
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 02:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B9871F2396B
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 00:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7487462;
	Thu, 11 Jul 2024 00:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwahl@gmx.de header.b="mK/W4GVJ"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D9A17FD;
	Thu, 11 Jul 2024 00:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720657251; cv=none; b=Q0yxNpTS1QDtsggatXmrLYWZzIn0YHinBTwg1tYeQYbLAlFBY/K9fwPB2rTsay/ZiNsuGMTU2w3FhKBxCJaiSSz96Ra/yt0r+C1jtSVOLqmcchiiS1OOeHweOS/K8TjXEgExAZipP1hhXsH4csLZKGXJphw0GfomKX0VroFDPvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720657251; c=relaxed/simple;
	bh=6C4tMfHM6VQngRyJonPLmoU9doo2Tpxm/TuefZt93jY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sHXc8GhDce+04nC3HfNS4cP3vQCyXrZBoSUn/KmR7rJb5TqCmmY8hPqAz1wvRkQ9YszolfvPC0CqzzDMf+HgVXEpWU4zQkp4Gnjtr1ctqIni7txZkNRqymiJ+7xrKGfSzG9RZpra5Njmie40IF0G/FB5NzPKEEtt2o63HTH1Oas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwahl@gmx.de header.b=mK/W4GVJ; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1720657225; x=1721262025; i=rwahl@gmx.de;
	bh=6C4tMfHM6VQngRyJonPLmoU9doo2Tpxm/TuefZt93jY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mK/W4GVJDRESglynGg0Q4LB4bOLfU2LLVvIn1dYlTd9z6sRr/FcGOGxt29VFhNSa
	 42hyFPjoTarLsPZvKEe5CsrECARcJsfqflhYqOKiUNDRm02Av4ABg7znJqJZQTRBw
	 /yJQbErf58UYA5p5IHOV1yty1Q2kDumT5gtZxc+7qr66LI/bGCof3JJZDZJtfWbNb
	 bZSKDRtwrFfCcmmhraEuX7KnwN7xPdKtaddT8YcGvfjlJRiJhIUwWj/R+W3PrEMfQ
	 5X5lYisbAwFCqt7g/jvet9AaR3p48m9OwWHksrucL7nyH23UsdOsWNUBj1n1HkV/F
	 VSyucwKivATCncWJtA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.24] ([84.156.147.254]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7QxB-1sJv4m0vs5-00zAqR; Thu, 11
 Jul 2024 02:20:25 +0200
Message-ID: <2a04f707-3b97-4ca8-a10b-15c3aab5fc29@gmx.de>
Date: Thu, 11 Jul 2024 02:20:17 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ks8851: Fix potential TX stall after interface
 reopen
Content-Language: en-US
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Ronald Wahl <ronald.wahl@raritan.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 stable@vger.kernel.org
References: <20240709195845.9089-1-rwahl@gmx.de>
 <8e4c281e-06d8-47bf-9347-d82107f00165@intel.com>
From: Ronald Wahl <rwahl@gmx.de>
In-Reply-To: <8e4c281e-06d8-47bf-9347-d82107f00165@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nmvsRf8tthO2HgAQmne0I0+O/UTifTjj42ENUq5gwsqtOoCTpPx
 er+wjultiKthslwfHJNO0PWxzDrv8H+SvXN14bjzdIAl/S9VhF6ASVLAg8F3y3fB/ZLmHEG
 3ZD7bNMbWgGJOi3GOxlT+XarP2ewnBhyiM9lm4rMXof4WyjxodC340iQHxzQPYP6H7BxgWT
 fBCsTPk1Vsakqvx79+slA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AcN5kMcxRjY=;foiD8tHZ1EouTN7VqD7zxOfw9g0
 8mTY6uzZcyv7xCajBgGVlIj+TUjVfzgTFg8GF56BWpOg7i+RjM/Aks7uG/ZzWcSQIMt0mKmKV
 u0b88wUkvuKHdhnwgOtvVKqN2Zo/Y6xsQAa6PfACiJG2l3lWMqplC1fqlU54wg1EvlflH6VXb
 Httuq5pbY5QJ0xbOxPKz+lYWDBWe+I/dM7+KqRYmUvLM9Q7wSRyyT+0G+ZIGeEzLwDeoMkBPv
 GCc8ySCKHVFFPybELqODB+1FnU2NnEH2zc6icYDGi8ifCmOmOmocNBPGYLyw1atQXUALpzIck
 CSJ+2v1TqWDpxEi/AerDUJnlMd2AQCO3IEJBpM5WaJTmv90gy/cCwwSbqUBdmzgT+fruLFMRQ
 iz94z21sABPHK41PtnAmOfK8r3HDIWSMgMDTBEJKzEPaU1ECZmq9a44CdDn+IYYicqBYkLRIV
 rxz0F5tiOrpqvcUJaLNk3A5K4VuZfUaRP5H4s3Y3ymE9GTUb90u5yWmWK3s2CYVnI/9E+eKcO
 jlvjoRXYiDtL/bgR/71xbXcK5i/s/tGStb9TXwSc7csthGe2F2/p6+Kiict54Od5/xLre1IVc
 9lKWIyHW/Dz2wJCKmQEPrpaqs+5fzjzM2wEQWlQC3Pk1D5MdSv98v4Qlc3hTSw4i505XkuZsA
 /7wuC34Pk6wo5NElc1Jq6DajlfKw/cMKC2pUNV+Z1+m1P8fzPeUbZuX0ya7GB9Eg10YK6PmsP
 zzQ4dr5YUlLLGWtxEfOpuj/1QBCHPrpgXAMMPrAhmyV6VmUfL+Qkh/ODV/7RELiPMwckcPP+M
 q2l4BKHMl1lfe4IMwTXfJckw==

On 11.07.24 01:48, Jacob Keller wrote:
>
>
> On 7/9/2024 12:58 PM, Ronald Wahl wrote:
>> From: Ronald Wahl <ronald.wahl@raritan.com>
>>
>> The amount of TX space in the hardware buffer is tracked in the tx_spac=
e
>> variable. The initial value is currently only set during driver probing=
.
>>
>> After closing the interface and reopening it the tx_space variable has
>> the last value it had before close. If it is smaller than the size of
>> the first send packet after reopeing the interface the queue will be
>> stopped. The queue is woken up after receiving a TX interrupt but this
>> will never happen since we did not send anything.
>>
>> This commit moves the initialization of the tx_space variable to the
>> ks8851_net_open function right before starting the TX queue. Also query
>> the value from the hardware instead of using a hard coded value.
>>
>> Only the SPI chip variant is affected by this issue because only this
>> driver variant actually depends on the tx_space variable in the xmit
>> function.
>
> I'm curious if this dependency could be removed?

I don't think so.

The driver must ensure not to write too much data to the hardware so we
need a precise accounting of how much we can write. In the original
driver code for the SPI variant this was broken and repaired in
3dc5d4454545 ("net: ks8851: Fix TX stall caused by TX buffer overrun").
Unfortunately we required some rounds of bug fixing to get it finally
working without any issues. Hopefully this was the last change in that
regard. :-)

If you ask why only the SPI version is affected then the answer is that
for the parallel interface chip there is no internal driver queuing,
i.e. it writes a single packet per xmit call. Not sure if this can also
overrun the hardware buffer if the receiver throttles via flow control.
Since I do not own this chip variant I cannot test this. In the end that
could even mean that we would need the accounting for the parallel chip
code as well.

- ron


