Return-Path: <stable+bounces-108451-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D87A0BB13
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 16:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 405807A1806
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 15:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C851E1FBBD3;
	Mon, 13 Jan 2025 15:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="akmVpkH2"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0B51FBBC3
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 15:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736780495; cv=none; b=fQR5cZmNhcfrxOAaWZPda/Z6rafFUcMEn70rYzw/GV/JJPYFodGZXM4wnxpBc7i32e/kC2kWRQR423A8pE7vDYZzG29Hb7oUNnVlLeyKw+I7Obm95WIF/u6v1sy6crH/BvuZy5Yw+zJav41YyPtdMwe+FvRfQsMPc68GtziwhSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736780495; c=relaxed/simple;
	bh=kRR1+QzVmvo3iRgs0Rx+6BPBHxGoHd17FoeRkxQMy60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBNkbnprWcVFN5+QoUgVVRTCgZgoBwCkQ7YVI36TyD2dO4Ox9Lfq5gxNQL2kfTZAChqFucqsGQZghDE0ogt8hRQC5vikcx/h0gZp8zjPJ5z5j1nAsURw98pMBXUNV4DAJhUrfoWGEEuCVcSBF4cloFW5cgTuFTxCVISLPlRxR3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=akmVpkH2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736780492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3yf80rtmCXKEEVXHQYDbWk5EecSmCyvTI8cS1zfM35E=;
	b=akmVpkH2K8LXHcjOuib/3koNkJiQmjjlbI2PpV9i2ZHNCgRRhqLsQNh1V28ejcIGDwXhib
	2fcDFGFt/H2TURuEWzakYYGONrA/vP9JVK3OyobGBuN0B4c3Lj5IT5cc+wV2jLsmjRLBA7
	8MBdMwqqgHDALYJjqXpGsVIIyo8tyH4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-ogkqI7GjNB6mfigtNE6UsA-1; Mon, 13 Jan 2025 10:01:31 -0500
X-MC-Unique: ogkqI7GjNB6mfigtNE6UsA-1
X-Mimecast-MFC-AGG-ID: ogkqI7GjNB6mfigtNE6UsA
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7b6e7f07332so657931985a.1
        for <stable@vger.kernel.org>; Mon, 13 Jan 2025 07:01:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736780490; x=1737385290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3yf80rtmCXKEEVXHQYDbWk5EecSmCyvTI8cS1zfM35E=;
        b=caK8h/ja9Y212rGEjSyStC1b5EoGMn9LHQz6w+YiHI8PzC87IIVF1eciME9fhXYWM4
         M2bCp40Bok4rGakqJLsbpl9nTvSPyFTiTtJKhP+TRoiZ8j1Puk/7J8miZw6bxNUJL+vj
         Xm79tH/v7UGaKq7HwbWRmvPVwvmy3wunfENywxbE36z+Bvd/6dEU1ANhumQs+P230KF1
         zmEf0uCByfJp2sCJpVPn20+G3Njf7S/MLi83+oHTW90GYexcD6pyFgYKipL3t+rRquHN
         iLuDAJ8P07QrEwmTuDj0JPTKO2YVSgJGLMVOQf5GoUVszOIci/UQ6287I2iqwaOMl9Rz
         3pYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqD8o4MbLfve9cWOa0qXk5+74x+MFuWU7atStqduA059FllOaz6NUrPTYnVPkb+5ERwkBlxJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdM/gbISLRnBCaHADLk06KWNypQfzZs/KZzTiaMfrWywK2yVbX
	L0elM0wPCGYlHTNu5ecI67ZF7YBO/XUn1IQyZ2ZLOZSRhC/yEsHGVbVfcN4PC1OgIScjkrw17sv
	1lzr0UQFur1ETMDZ9Vg/dhr88E8w/wdlKpgfUGrfj8WYlAHrzWMVoxg==
X-Gm-Gg: ASbGncvVOe1QbbTsJhuvLa4enhefg0pfzSL5EItzfPlq1XX2GIB7rmvsrWIbGdFy4sv
	1Mphah9hPUKSHqb8g/s/K9aoeBYKaBqiISU2BIRSwH970Wdy4Le+/hMZQywdSKHGDBw66iJTA/Y
	WY2i8BeH0VTmOSbmlql/4u+FEc6yZeuwviU4ISj5LLmPddDP2g4d3/rt+/8mwP249ZJcyl2BNDU
	HL5M+SXbK8YObjmWsh7pfAKsvvtiqukKajm+0rApO3PvCvKJvX48LmFl4pk6siTCo+OPQerBk4X
	HyV/1gzruwIuyizhiIL8UZsaMuKhBlCb
X-Received: by 2002:a05:620a:3726:b0:7b1:880c:5805 with SMTP id af79cd13be357-7bcd9759b5cmr3148821585a.45.1736780490411;
        Mon, 13 Jan 2025 07:01:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmhCA+6joXrA0wKVaaHTe7fd/trt2RKjBSiBo73zD2W/+WWXHhQD1dIWKITENXxjV/Gx6S4g==
X-Received: by 2002:a05:620a:3726:b0:7b1:880c:5805 with SMTP id af79cd13be357-7bcd9759b5cmr3148813685a.45.1736780489785;
        Mon, 13 Jan 2025 07:01:29 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-100.retail.telecomitalia.it. [82.53.134.100])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce35042eesm496383085a.86.2025.01.13.07.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 07:01:29 -0800 (PST)
Date: Mon, 13 Jan 2025 16:01:19 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Luigi Leonardi <leonardi@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Wongi Lee <qwerty@theori.io>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Eric Dumazet <edumazet@google.com>, kvm@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Simon Horman <horms@kernel.org>, Hyunwoo Kim <v4bel@theori.io>, 
	Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, stable@vger.kernel.org
Subject: Re: [PATCH net v2 1/5] vsock/virtio: discard packets if the
 transport changes
Message-ID: <5nkibw33isxiw57jmoaadizo3m2p76ve6zioumlu2z2nh5lwck@xodwiv56zrou>
References: <20250110083511.30419-1-sgarzare@redhat.com>
 <20250110083511.30419-2-sgarzare@redhat.com>
 <1aa83abf-6baa-4cf1-a108-66b677bcfd93@rbox.co>
 <nedvcylhjxrkmkvgugsku2lpdjgjpo5exoke4o6clxcxh64s3i@jkjnvngazr5v>
 <CAGxU2F7BoMNi-z=SHsmCV5+99=CxHo4dxFeJnJ5=q9X=CM3QMA@mail.gmail.com>
 <cccb1a4f-5495-4db1-801e-eca211b757c3@rbox.co>
 <nzpj4hc6m4jlqhcwv6ngmozl3hcoxr6kehoia4dps7jytxf6df@iqglusiqrm5n>
 <903dd624-44e5-4792-8aac-0eaaf1e675c5@rbox.co>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <903dd624-44e5-4792-8aac-0eaaf1e675c5@rbox.co>

On Mon, Jan 13, 2025 at 02:51:58PM +0100, Michal Luczaj wrote:
>On 1/13/25 12:05, Stefano Garzarella wrote:
>> On Mon, Jan 13, 2025 at 11:12:52AM +0100, Michal Luczaj wrote:
>>> On 1/13/25 10:07, Stefano Garzarella wrote:
>>>> On Mon, 13 Jan 2025 at 09:57, Stefano Garzarella <sgarzare@redhat.com> wrote:
>>>>> On Sun, Jan 12, 2025 at 11:42:30PM +0100, Michal Luczaj wrote:
>>>>
>>>> [...]
>>>>
>>>>>>
>>>>>> So, if I get this right:
>>>>>> 1. vsock_create() (refcnt=1) calls vsock_insert_unbound() (refcnt=2)
>>>>>> 2. transport->release() calls vsock_remove_bound() without checking if sk
>>>>>>   was bound and moved to bound list (refcnt=1)
>>>>>> 3. vsock_bind() assumes sk is in unbound list and before
>>>>>>   __vsock_insert_bound(vsock_bound_sockets()) calls
>>>>>>   __vsock_remove_bound() which does:
>>>>>>      list_del_init(&vsk->bound_table); // nop
>>>>>>      sock_put(&vsk->sk);               // refcnt=0
>>>>>>
>>>>>> The following fixes things for me. I'm just not certain that's the only
>>>>>> place where transport destruction may lead to an unbound socket being
>>>>>> removed from the unbound list.
>>>>>>
>>>>>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>>>>>> index 7f7de6d88096..0fe807c8c052 100644
>>>>>> --- a/net/vmw_vsock/virtio_transport_common.c
>>>>>> +++ b/net/vmw_vsock/virtio_transport_common.c
>>>>>> @@ -1303,7 +1303,8 @@ void virtio_transport_release(struct vsock_sock *vsk)
>>>>>>
>>>>>>       if (remove_sock) {
>>>>>>               sock_set_flag(sk, SOCK_DONE);
>>>>>> -              virtio_transport_remove_sock(vsk);
>>>>>> +              if (vsock_addr_bound(&vsk->local_addr))
>>>>>> +                      virtio_transport_remove_sock(vsk);
>>>>>
>>>>> I don't get this fix, virtio_transport_remove_sock() calls
>>>>>    vsock_remove_sock()
>>>>>      vsock_remove_bound()
>>>>>        if (__vsock_in_bound_table(vsk))
>>>>>            __vsock_remove_bound(vsk);
>>>>>
>>>>>
>>>>> So, should already avoid this issue, no?
>>>>
>>>> I got it wrong, I see now what are you trying to do, but I don't think
>>>> we should skip virtio_transport_remove_sock() entirely, it also purge
>>>> the rx_queue.
>>>
>>> Isn't rx_queue empty-by-definition in case of !__vsock_in_bound_table(vsk)?
>>
>> It could be.
>>
>> But I see some other issues:
>> - we need to fix also in the other transports, since they do the same
>
>Ahh, yes, VMCI and Hyper-V would need that, too.
>
>> - we need to check delayed cancel work too that call
>>    virtio_transport_remove_sock()
>
>That's the "I'm just not certain" part. As with rx_queue, I though delayed
>cancel can only happen for a bound socket. So, per architecture, no need to
>deal with that here, right?

I think so.

>
>> An alternative approach, which would perhaps allow us to avoid all this,
>> is to re-insert the socket in the unbound list after calling release()
>> when we deassign the transport.
>>
>> WDYT?
>
>If we can't keep the old state (sk_state, transport, etc) on failed
>re-connect() then reverting back to initial state sounds, uhh, like an
>option :) I'm not sure how well this aligns with (user's expectations of)
>good ol' socket API, but maybe that train has already left.

We really want to behave as similar as possible with the other sockets,
like AF_INET, so I would try to continue toward that train.

>
>Another possibility would be to simply brick the socket on failed (re)connect.
>

I see, though, this is not the behavior of AF_INET for example, right?

Do you have time to investigate/fix this problem?
If not, I'll try to look into it in the next few days, maybe next week.

Thanks,
Stefano


