Return-Path: <stable+bounces-189139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4F7C02046
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 17:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 05C27560247
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 15:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BF4332912;
	Thu, 23 Oct 2025 15:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDmUQnKm"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8253E326D42
	for <stable@vger.kernel.org>; Thu, 23 Oct 2025 15:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761231989; cv=none; b=OrVpoVmgYvDH5UBSsVkEMzQm1r3bV9Z40xNq8u+nxdSYh73a9LjmtPKOlEsT8oELEhPjZVr3PlF+mRwBkfAn4NhXMDN+7LO7/5D/uAPW1TqS4oUAdVW+LgGeMRQDMBh58becLjYigOFYMdT+IoQ4OAFWndCao4VQZE5yCM8mLgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761231989; c=relaxed/simple;
	bh=MvqFL77ZOpbzsQ/1SAvP195IIaFnAZVIetxFNQjBOxo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=miOXdWKeXCBMUiQnfIRyDzpkO8ExUKB3NIRnSJitJyUR+XVkzMzApcXv/xzi0za6/J4jLxEyO7zTpLcmVHzXfeMc6IhpSm+Ft42hEMen+GZQlSYBl7H0r8en6I536b0Ei4epe/RRdoWj8x9R76AjNcaEwxGMYrHpcckO03anjLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDmUQnKm; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7a226a0798cso768886b3a.2
        for <stable@vger.kernel.org>; Thu, 23 Oct 2025 08:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761231986; x=1761836786; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mvQKZArUDl984Y6+2a44gK2373aPFXu4OMsdAqeqhEE=;
        b=lDmUQnKmDhJ1d1CXwn9n35a64uUWYw5EQ6xSxdAf2Ot4bg4Pv0KSsFKVXtfUV/SaVI
         O8GymYJcK/3mD0UHX4s/9x3I3/HHSqKirL1aaOOQYUCr09wKriSiN+Y5THpzxeY/W9OS
         Tgex+GSFHB1+pNBSIqV3lE060wrgjhuD9EQ/0NE2L2UTFQ5sdPqJQnOHGM4cY9OxPdIt
         ZSrtHuhEfrNLZ26uZgUr7CbWwLVePXUyEQpXBroCriVFdKgCDFNfMqKgCBocIo8GaPvO
         CCtZudNzlvjoBvzVXxWkquT2PjfOdgPxJfyE/SftDNpAzXN7pS3epV/EMmh06b83+aiO
         5KQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761231986; x=1761836786;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mvQKZArUDl984Y6+2a44gK2373aPFXu4OMsdAqeqhEE=;
        b=OfyBGOZXOq9pSlS3WeiEuAL8FvhiFFSR0eFUZ8sFkAwgoFIrFLPxF0zjoa+dRjIxDH
         hPu4MTITDMJsLIzkZQCVnvVeygVezZFiugWOIovAOkHn3OOZjq9Di5GDFP9fOIdMqUBh
         dwmypIyrCb+2BOwbVkzz4/wYQXm0kK1RBjyouCYle7QsEGaTVFG4lkl/OR4V7gVeJ2tO
         JGBy4WHpZdbPMqhkUjg3QO0wbNXj25rQT3r+ou0I1dcXUpaqQIIm4qafdaH1k8MKQHSL
         iBGrwRKXsr/6NJ1lt5IIId1EIzWsY9GfV1tIkqpZxK0WVD6hRbEDwZyJRkj3LlHqaEhI
         4Xdw==
X-Forwarded-Encrypted: i=1; AJvYcCXP2ygfO2QNZSwZqOEVKck/mdLhbXaFQtUpbRamp0wqA9+M50Wlg9BBXDUego1BMKkTE14Lzno=@vger.kernel.org
X-Gm-Message-State: AOJu0YyadfBdgyhVh/XmtH6sM5ajGkgH0rKjvyTaiJIBG4L/iS+ueiN9
	Y2PQZlVi0+KjzffxBO3M4PPxE7c2TwjCp5PY/hPgvXjmSaOcdkeXyWfH
X-Gm-Gg: ASbGncvOSBZ99EGpd4TbBF0KvTDUS35da74YAwznE2qWkvKcTj3vFsm6+CMOed1RHRc
	jLn9iySfQUyKdu+wmrrZ6XHkETf82HAJHCD6erzXJAhCJ1VMq0PalfN4YsY1smCQkqclP1o4dol
	BYIhYwZIUOwpd9L6i5QK9CLvTSSOX9sq3EvAcAo6dNbWkb/bI6z9DaP+kY6VjDK4r+H0SUFNWUW
	lUqAs7wy5u0eLyz5r8qYKVWrCxHBOStRDYHw7DQFI1xG4gXR0mDSKjlEOulg3QUXFVmgc+rrqI2
	RkAViOWwT0gESc5r/IncNeI6Cj4RSgG8j5N21LWABg6aJ4NEFFZR2FFyS6Zqn6AgaFpMhJXVHbW
	ImXmDaFBw4d/JlotcYCWLIJu5X6QVEuIjXPyRy+EC9tUru0swSRK23ZdLQ7hk+a5DHFrG/6hDGT
	wOFdwfioPxorP/TTsBD2uiELL6772FscxKoALb8R1wWcLy8uDDzrg=
X-Google-Smtp-Source: AGHT+IHmV7fyIld8QJGetoS158dw1CSCpgxRIKYp/OAxuCr3SCHqN63NNPoNTOeqZvoqcH0dXWwUhg==
X-Received: by 2002:a05:6a21:4613:b0:334:a9b0:1c87 with SMTP id adf61e73a8af0-334a9b01d07mr31195853637.1.1761231985521;
        Thu, 23 Oct 2025 08:06:25 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f4c:210:5c6f:93f3:3b14:cac4? ([2001:ee0:4f4c:210:5c6f:93f3:3b14:cac4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4c13ea9sm2360547a12.16.2025.10.23.08.06.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 08:06:25 -0700 (PDT)
Message-ID: <9598c7ae-fda5-4b7f-8e49-751ce7d5eafe@gmail.com>
Date: Thu, 23 Oct 2025 22:06:17 +0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] virtio-net: fix received length check in big
 packets
From: Bui Quang Minh <minhquangbui99@gmail.com>
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
 <cd963708-784a-4b1e-a44e-6fb799937707@gmail.com>
Content-Language: en-US
In-Reply-To: <cd963708-784a-4b1e-a44e-6fb799937707@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/23/25 21:39, Bui Quang Minh wrote:
> On 10/23/25 15:05, Xuan Zhuo wrote:
>> On Wed, 22 Oct 2025 23:06:23 +0700, Bui Quang Minh 
>> <minhquangbui99@gmail.com> wrote:
>>> Since commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length
>>> for big packets"), when guest gso is off, the allocated size for big
>>> packets is not MAX_SKB_FRAGS * PAGE_SIZE anymore but depends on
>>> negotiated MTU. The number of allocated frags for big packets is stored
>>> in vi->big_packets_num_skbfrags.
>>>
>>> Because the host announced buffer length can be malicious (e.g. the 
>>> host
>>> vhost_net driver's get_rx_bufs is modified to announce incorrect
>>> length), we need a check in virtio_net receive path. Currently, the
>>> check is not adapted to the new change which can lead to NULL page
>>> pointer dereference in the below while loop when receiving length that
>>> is larger than the allocated one.
>>>
>>> This commit fixes the received length check corresponding to the new
>>> change.
>>>
>>> Fixes: 4959aebba8c0 ("virtio-net: use mtu size as buffer length for 
>>> big packets")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>>> ---
>>> Changes in v4:
>>> - Remove unrelated changes, add more comments
>>> Changes in v3:
>>> - Convert BUG_ON to WARN_ON_ONCE
>>> Changes in v2:
>>> - Remove incorrect give_pages call
>>> ---
>>>   drivers/net/virtio_net.c | 16 +++++++++++++---
>>>   1 file changed, 13 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>> index a757cbcab87f..0ffe78b3fd8d 100644
>>> --- a/drivers/net/virtio_net.c
>>> +++ b/drivers/net/virtio_net.c
>>> @@ -852,7 +852,7 @@ static struct sk_buff *page_to_skb(struct 
>>> virtnet_info *vi,
>>>   {
>>>       struct sk_buff *skb;
>>>       struct virtio_net_common_hdr *hdr;
>>> -    unsigned int copy, hdr_len, hdr_padded_len;
>>> +    unsigned int copy, hdr_len, hdr_padded_len, max_remaining_len;
>>>       struct page *page_to_free = NULL;
>>>       int tailroom, shinfo_size;
>>>       char *p, *hdr_p, *buf;
>>> @@ -915,13 +915,23 @@ static struct sk_buff *page_to_skb(struct 
>>> virtnet_info *vi,
>>>        * This is here to handle cases when the device erroneously
>>>        * tries to receive more than is possible. This is usually
>>>        * the case of a broken device.
>>> +     *
>>> +     * The number of allocated pages for big packet is
>>> +     * vi->big_packets_num_skbfrags + 1, the start of first page is
>>> +     * for virtio header, the remaining is for data. We need to ensure
>>> +     * the remaining len does not go out of the allocated pages.
>>> +     * Please refer to add_recvbuf_big for more details on big packet
>>> +     * buffer allocation.
>>>        */
>>> -    if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE)) {
>>> +    BUG_ON(offset >= PAGE_SIZE);
>>> +    max_remaining_len = (unsigned int)PAGE_SIZE - offset;
>>> +    max_remaining_len += vi->big_packets_num_skbfrags * PAGE_SIZE;
>>
>> Could we perform this check inside `receive_big` to avoid computing
>> `max_remaining_len` altogether? Instead, we could directly compare 
>> `len` against
>> `(vi->big_packets_num_skbfrags + 1) * PAGE_SIZE`.
>
> That looks better, I'll do that in the next version.
>
>> And I’d like to know if this check is necessary for other modes as well.
>
> Other modes have this check as well. check_mergeable_len is used in 
> mergeable mode. In receive_small, there is a check
>
>     if (unlikely(len > GOOD_PACKET_LEN)) {
>         goto err; 

I forgot about XDP zerocopy (XSK) mode. In that mode, there is a check 
in buf_to_xdp.

     if (unlikely(len > bufsize)) {
         return NULL;

Thanks,
Quang Minh.


