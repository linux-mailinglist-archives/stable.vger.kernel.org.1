Return-Path: <stable+bounces-189137-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8160EC01D4C
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 16:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A76211A637EE
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 14:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA94832E142;
	Thu, 23 Oct 2025 14:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1p0PK7l"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14B032D451
	for <stable@vger.kernel.org>; Thu, 23 Oct 2025 14:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761230381; cv=none; b=rfvDQNV65Y8rcAzQrhyvge5/ERVvrsgZY8Rhe3g+0rwwemz+ssV+uK2xMZHFz6d6qfIX9H5DjBb7sIKafeVdhDQDdkXb6OxQeqj57CsPTkCcg+QIn4yl6gTylwgh2sxZJvnQqsgQk5NzcKQNHjNmWmumYHC3EcMTMpn7syMu7vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761230381; c=relaxed/simple;
	bh=K6yURn9UYOo/OGlw/SxR7FpRD28Usu6/d+6K4vyqldg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U/6r95sjff49ERAjaxMDkAtzA9GrNdVKuU638JwMZMdgeDVeFZQDwZykPEFAu1U45UQDmwMWD8AdxIb7CLpL1ci2XvPHaxLzfi9zspvGcalynQrfdYWAJX2RmK3osJ6ZPSVs1gLlJ3/wKHJmMeDSfXcv9UCNJnLmxH4y+6MaPKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1p0PK7l; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b550a522a49so702713a12.2
        for <stable@vger.kernel.org>; Thu, 23 Oct 2025 07:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761230379; x=1761835179; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R3zBGPrVkQkNSFhl6cJF22SK2sjH+IBauiisvtj1eDE=;
        b=L1p0PK7lVeu/yyIpOepIK0JyvzlSfMoWFSTO2TWfZ1PLI3QzkVm5kk5XNLwoBfcn5y
         QHgqcj8THFlDiWl5G2ABKZUEOCXvozGerwGY/xH2SbP8IPoGLDeMymKy0iDd4a2jbz9w
         HbDadNIWJ/P6TYiRk4I61XkJiAjlUnkPZsyk1GXydbU/SsVWIwqmNJWUjQBEICg/6m8r
         SEJAecq+BzRmz5AEZICVSWG9EeGfABVBI7qX6g3MrfskLLw9BQxJt/DC2bgOnHLUhcce
         mYWKKrjvPljRsDgF0mRvuY4hTqtJehNBdEBgZJ6qbNI5VWjnLwMx7AVVLgdSNzWhpDCk
         6Jqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761230379; x=1761835179;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R3zBGPrVkQkNSFhl6cJF22SK2sjH+IBauiisvtj1eDE=;
        b=mWNXNvmB1zTDafuJJqdT65ec2aTVAQmDUqKlBXy/OwHuakSMm0a+U6YS096RaQGoxt
         vn/tz7iPXglAOs3fZFm3hoPDstYDHzPu9T/iNPDyQ+83JRHOz0jaWHmXNDvTgmNawJc7
         JGcnZD4MzweEJHnrwCaAllZcCyPJ42QQ8zbc+MC5OesPreVDmxYziodoFPHCv8MoXDOf
         PXyVLfjZGkvNGMMcukBOTSpCnDbA84ibj/qrrXla4pzy1QMjymWG9BGiA5HPq+FnH4IR
         grCDVxGUp9+uidw7s5ZS0+xhfqZHPcQkaD2TyQMuywSGD3Xi1+Rm34JwNu8L9dPtUeKF
         LfnA==
X-Forwarded-Encrypted: i=1; AJvYcCX6I5QaqaYC/vquX5Bvk++YwvMuPaRpmutbHeCjqywCGjvwXKi5Nu0AAMB1w7x5jGodKgJLz2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJfXPFreuyDI5WTGaLUJBitvVdnZM49iv6RapZB6zgIqscBUnD
	WgiA/c+3jyclJdR6oqWNviGtIi8HGz2Bgu+QYooS2oWcpdXCuEpY7e48
X-Gm-Gg: ASbGncu397y/XZvetmMovMt5MaDbMwTmeqtME9Mt0spAkUikOEhKwXdZwIBiWeoLEss
	uWEj9hd7w5c0MKcioeo84SuoI0FKRLujesVAW9yGKEgfXvz4XDjtJe3eedrwUUtjdx7Mh+LjiP/
	00w10B4Wb+kWG15RRhteEnU//Feao5bqSGtQ9Q05BfujGr+sroADpC37xLL/5/bH29n3Rgy8HTe
	WdcKLAjNWhOcpfjaFhLiHbKMMlQHY2yNPD7F7d3lZY4ZB56ZkmQNNRjhU4Vs4PORfpifLYhOXBp
	IKs5y0O9/E+ZdF+IKVMm2EZxjqeSL4fkzZMKOEeEDpmGQzjaTeOzXkRUYXgdWGbmra5Du8Ccz4t
	0SlT3JBc5bVGsrEkOm9x/tjKgAjt1UNXHOOvBsol3cAvn7/e+9kiyamYLniRs33Ej12jdy9u1oo
	BRq/FRal0JO2kzxBOPFVbMBiPrF+kHjycMjEbDoIUxCysMViPvUm0=
X-Google-Smtp-Source: AGHT+IFucwEwOTFxaTJoVOzjbuSgOqn6+M6IcAfQome0saJAV+NsptRDrBbl50zj7o+T/juUYZJt+A==
X-Received: by 2002:a17:903:1a4c:b0:27e:f201:ec90 with SMTP id d9443c01a7336-290c9ce63b3mr295801785ad.25.1761230379128;
        Thu, 23 Oct 2025 07:39:39 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f4c:210:5c6f:93f3:3b14:cac4? ([2001:ee0:4f4c:210:5c6f:93f3:3b14:cac4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dfc1c8asm26155705ad.71.2025.10.23.07.39.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 07:39:38 -0700 (PDT)
Message-ID: <cd963708-784a-4b1e-a44e-6fb799937707@gmail.com>
Date: Thu, 23 Oct 2025 21:39:30 +0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] virtio-net: fix received length check in big
 packets
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Gavin Li <gavinl@nvidia.com>, Gavi Teitz <gavi@nvidia.com>,
 Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, netdev@vger.kernel.org
References: <20251022160623.51191-1-minhquangbui99@gmail.com>
 <1761206734.6182284-1-xuanzhuo@linux.alibaba.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <1761206734.6182284-1-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/23/25 15:05, Xuan Zhuo wrote:
> On Wed, 22 Oct 2025 23:06:23 +0700, Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>> Since commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length
>> for big packets"), when guest gso is off, the allocated size for big
>> packets is not MAX_SKB_FRAGS * PAGE_SIZE anymore but depends on
>> negotiated MTU. The number of allocated frags for big packets is stored
>> in vi->big_packets_num_skbfrags.
>>
>> Because the host announced buffer length can be malicious (e.g. the host
>> vhost_net driver's get_rx_bufs is modified to announce incorrect
>> length), we need a check in virtio_net receive path. Currently, the
>> check is not adapted to the new change which can lead to NULL page
>> pointer dereference in the below while loop when receiving length that
>> is larger than the allocated one.
>>
>> This commit fixes the received length check corresponding to the new
>> change.
>>
>> Fixes: 4959aebba8c0 ("virtio-net: use mtu size as buffer length for big packets")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>> ---
>> Changes in v4:
>> - Remove unrelated changes, add more comments
>> Changes in v3:
>> - Convert BUG_ON to WARN_ON_ONCE
>> Changes in v2:
>> - Remove incorrect give_pages call
>> ---
>>   drivers/net/virtio_net.c | 16 +++++++++++++---
>>   1 file changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index a757cbcab87f..0ffe78b3fd8d 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -852,7 +852,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>>   {
>>   	struct sk_buff *skb;
>>   	struct virtio_net_common_hdr *hdr;
>> -	unsigned int copy, hdr_len, hdr_padded_len;
>> +	unsigned int copy, hdr_len, hdr_padded_len, max_remaining_len;
>>   	struct page *page_to_free = NULL;
>>   	int tailroom, shinfo_size;
>>   	char *p, *hdr_p, *buf;
>> @@ -915,13 +915,23 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>>   	 * This is here to handle cases when the device erroneously
>>   	 * tries to receive more than is possible. This is usually
>>   	 * the case of a broken device.
>> +	 *
>> +	 * The number of allocated pages for big packet is
>> +	 * vi->big_packets_num_skbfrags + 1, the start of first page is
>> +	 * for virtio header, the remaining is for data. We need to ensure
>> +	 * the remaining len does not go out of the allocated pages.
>> +	 * Please refer to add_recvbuf_big for more details on big packet
>> +	 * buffer allocation.
>>   	 */
>> -	if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE)) {
>> +	BUG_ON(offset >= PAGE_SIZE);
>> +	max_remaining_len = (unsigned int)PAGE_SIZE - offset;
>> +	max_remaining_len += vi->big_packets_num_skbfrags * PAGE_SIZE;
>
> Could we perform this check inside `receive_big` to avoid computing
> `max_remaining_len` altogether? Instead, we could directly compare `len` against
> `(vi->big_packets_num_skbfrags + 1) * PAGE_SIZE`.

That looks better, I'll do that in the next version.

> And I’d like to know if this check is necessary for other modes as well.

Other modes have this check as well. check_mergeable_len is used in 
mergeable mode. In receive_small, there is a check

     if (unlikely(len > GOOD_PACKET_LEN)) {
         goto err;

Thanks,
Quang Minh.

