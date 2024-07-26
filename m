Return-Path: <stable+bounces-61884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EED8F93D55A
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 16:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 798FFB229F8
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 14:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA2D1CD16;
	Fri, 26 Jul 2024 14:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M0pnta9l"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7FC1CD0C
	for <stable@vger.kernel.org>; Fri, 26 Jul 2024 14:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722005428; cv=none; b=s6wvv82zKr1QUWUZiJNNXeQIy22s6sFzraPEpgD1+J0OamwkDY7G9DG5hvOpsud+7MHR5ltyrvdoj8eyRgicOVdcsGnRHLR4NjkPW72Sn4NYYQVJ5zZLYKsLFbNnsJGgsBtPQuV9T34xa/Re5wkaI7drAweYMmXShDgrRNQNDRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722005428; c=relaxed/simple;
	bh=tLx/fMXOVGCyadE2i1prx1ayp8nFacEeeSEdUOK4kbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jMSp6wKOrfpoyAa1cewEh+jGCTbvrh51LgOySNhh26ab0aAWnhslzBwixGNx0k2Hk9x4jT8U0gth9PqjbIbrxbHiNddqybGj7xtwvQspzm/xgdzyta5V+6rIPRYkKVXBW2L6Rt95tjsiRB8PKQxO5VycHGZi6cvxJe6sCD6zL0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M0pnta9l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722005425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jvwUGbn07tsXSoowZQu31RzeEXtVHtqeR0AF7mHMHh4=;
	b=M0pnta9lTAozmUo5L2Pa/a7vYnJDhiK2dEx4fxRbO0mWNuN3bZzkYe+YkztNnB1A4/J96z
	Qt4zyMDwUEnE9gjQp3Je9GkFnY3hLKG87nZ6akwYMOsrVkQ6746+1uUpG+y85l28yIKdhn
	12YJ27zfBglGwAE13mS+0T7YY/SSIBE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-aNgdMLyUO0uECXvVzgygug-1; Fri, 26 Jul 2024 10:50:23 -0400
X-MC-Unique: aNgdMLyUO0uECXvVzgygug-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-428087d1ddfso1207575e9.1
        for <stable@vger.kernel.org>; Fri, 26 Jul 2024 07:50:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722005422; x=1722610222;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jvwUGbn07tsXSoowZQu31RzeEXtVHtqeR0AF7mHMHh4=;
        b=q44YN5q3dVAOCeudAK2bltmc8V82hG0waHCVoQbelyoxGPVUBJjQar/1PA9XtD2KHy
         4cQMj6IhA3pcWgjGoM54Xm6btV4eNl6kUq5GZIyaOlHA9lEtSAeohe43KYi7Eca4endC
         InR68tXRX+iVwAHhPH5lgaLtTn/05PJ5mEWDUrAFygzIM+8734kZhZWKWI/xyUS7PZs7
         SM2WsXmhzg/GsPokPwhMVzcqJunnGjey2ElnNRHYTfZXJTbJmKxOdTqz9EQLEyufq3hd
         h9oEXcLw272e4n+pDXDfuzmG1rbdpmLmTZ0012+NADG1U0jUR7FTp5MONnkWV/WH5Cde
         4sdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBGdOEhP36D4d68NxiiY6Vx+Ifsh5vtHNmlDOp8eGl5iVYKj5oMuuDpbIolsxzO4rImwGlXV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuO3mJlaZ1cAmqKS3+FQ7EtWw5ZtjTb9fiI0cMm20mVQuW9xws
	WyuYLTwU/8xCdC7pcKcB4tuu1HeVQXg/lPdqUvcBV2MlSExV0wY9nCswKXvUetapju+543X6Kbp
	HwnkcmfnhX6KL2nKWlvS+osc7wlvKIWoRB3p6XNVdKVTl/gZuxe8+YBD9PKA+3w==
X-Received: by 2002:a05:600c:3b21:b0:424:ac9f:5c61 with SMTP id 5b1f17b1804b1-428057706aemr25378605e9.3.1722005422450;
        Fri, 26 Jul 2024 07:50:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFi3Z9jbl+hMmUI7U3ZNPl1/Ndk9lNLNUNn8NAAYX7TfuFrgQKs3zUcmvvJUAtbTDzJ8aLL5Q==
X-Received: by 2002:a05:600c:3b21:b0:424:ac9f:5c61 with SMTP id 5b1f17b1804b1-428057706aemr25378485e9.3.1722005421960;
        Fri, 26 Jul 2024 07:50:21 -0700 (PDT)
Received: from [192.168.1.24] ([145.224.103.221])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36863d87sm5314384f8f.110.2024.07.26.07.50.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 07:50:21 -0700 (PDT)
Message-ID: <aad76753-d2b5-4905-b90b-e31483e5956b@redhat.com>
Date: Fri, 26 Jul 2024 16:48:06 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: drop bad gso csum_start and offset in
 virtio_net_hdr
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, mst@redhat.com, jasowang@redhat.com, arefev@swemel.ru,
 alexander.duyck@gmail.com, Willem de Bruijn <willemb@google.com>,
 stable@vger.kernel.org
References: <20240726023359.879166-1-willemdebruijn.kernel@gmail.com>
 <bab2caf1-87a5-444d-8b5f-c6388facf65d@redhat.com>
 <CAF=yD-J57z=iUZChLJR4YXq-3X-qPc+N93jvpCy5HE89B7-Tdw@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAF=yD-J57z=iUZChLJR4YXq-3X-qPc+N93jvpCy5HE89B7-Tdw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/26/24 15:52, Willem de Bruijn wrote:
> On Fri, Jul 26, 2024 at 4:23 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>
>> On 7/26/24 04:32, Willem de Bruijn wrot> @@ -182,6 +171,11 @@ static
>> inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
>>>                        if (gso_type != SKB_GSO_UDP_L4)
>>>                                return -EINVAL;
>>>                        break;
>>> +             case SKB_GSO_TCPV4:
>>> +             case SKB_GSO_TCPV6:
>>
>> I think we need to add here an additional check:
>>
>>                          if (!(hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM))
>>                                  return -EINVAL;
>>
> 
> Historically this interface has been able to request
> VIRTIO_NET_HDR_GSO_* without VIRTIO_NET_HDR_F_NEEDS_CSUM.

I see. I looked at the SKB_GSO_UDP_L4 case, but I did not dig into history.

> I would love to clamp down on this, as those packets are essentially
> illegal. But we should probably leave that discussion for a separate
> patch?

Yep, I guess we have to keep the two discussion separate.

As a consequence, I'm fine with the current checks (with Eric's 
suggested changes).

Thanks,

Paolo


