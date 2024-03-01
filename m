Return-Path: <stable+bounces-25720-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E9586D93B
	for <lists+stable@lfdr.de>; Fri,  1 Mar 2024 02:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FC2A285A20
	for <lists+stable@lfdr.de>; Fri,  1 Mar 2024 01:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35B036137;
	Fri,  1 Mar 2024 01:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DW3ZYV6P"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB2D2E3F9
	for <stable@vger.kernel.org>; Fri,  1 Mar 2024 01:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709258003; cv=none; b=cZk/1ghhz5VDmgwH1wCrkZ+1MKDwHL5C1KEH8rTNgwidbdeeETv9ZyMLh8i+5kH/YeYml0yqjTtQh9RhZYtVF4xpL3bT5qWWWJD9AX47/3KnXjI+0hBxBC1lz72FLEpk4UyLj5k4o/T25sUQL/Y/MB6Ko6o2J12Uxc+d9wT/Vno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709258003; c=relaxed/simple;
	bh=nIihlmgW+uwhT9twu/+xEC5jEg7HHf0+JI2opq3SmnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I2jtQo/aw6zC8iy7c63HrPcsBFAqz3LqprU0tFnqEzYIKr4xkGA2QqnCufs5jWd1+uX1K8Fj4Fa2jDdF4cCHUMzzZsIH6xPZ8pLkocVJsvcB3lXiwXo/IZafZvBKSD08ajgZvj1gU8wZcvOlqy28sAk+KsqZvUdF2VdTboTuAQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DW3ZYV6P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709258000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H2f+zUV1B6Erfx6sDWIeH2uAfVkZLUavK8muqCOy4L8=;
	b=DW3ZYV6PR2NLDJLELcdEVFDl6aVWtP7j/9BpgMPtaE5u4AvUKzUIix6ExQqKgxDvcNqs1C
	jXkgUM1etqWqJ+n2NXBSlbnRjdte4tMO04reREgL8DhhF1LVkn2ATDdW6FjS50tZWmqj+1
	I8e0IhAlR6nY3DoVf8ax7sx8EtP7VKw=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-qLBb1ZwPNWSyGGQhWkrctQ-1; Thu, 29 Feb 2024 20:53:18 -0500
X-MC-Unique: qLBb1ZwPNWSyGGQhWkrctQ-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1dcabec8fddso17147835ad.2
        for <stable@vger.kernel.org>; Thu, 29 Feb 2024 17:53:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709257998; x=1709862798;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H2f+zUV1B6Erfx6sDWIeH2uAfVkZLUavK8muqCOy4L8=;
        b=WiMt79nelQ0kFFdpsHVzaONLjxZMH4YJqWpUTv2xbOwUNqQ2+NNiAaYZ+ZiHYqFpZB
         eKcFL8l6yHOBg66GcpjLM2eKdufuFxoRIA6OwjZUOwBrm4ciLZVtNWY25VDtBerno+JW
         3gUmuIoaThST6che9NjeTAESUmx9IpIRhL4sFQ2ZlTg+w3Mmo5rCmXhpqp16Vt2CHPGq
         6b0eVZrgvKKBdCHAofWhtVD1SbVle6TeFcye9nxIxPR1iCpVroShm2wBVg680fI9hhLx
         eOw/KEcHIAHyqbddwkrkan/HQIKBXwpEm0Ib7mSkopJzrJA53r8wCw/f9d8OXuSR8UUf
         AmaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXj0/KqO9RanaCvBKrTtYgSHmHqhofUSsiShKwOYwNhd48KRl2pF6qbYTFiY3C8+1CX72rYedJrCLUdwl+Qtmc6NL4HiBxa
X-Gm-Message-State: AOJu0YwvwDqn/8MC9jEEA5Gfc36HL0R5XGHcYVzcW6QUgXbNlmAN3pdQ
	VHTd+rtqzBS8JHzDR9QlCTXcbelTkLVIeGln61CePU3o2GPiiV9sbputzDsV3mFgMTouLFVc+Wm
	fgdZcWu6xEFL87/aBg4LFmYe8PiGikK7nIyx0/RTx6RhjV2LUwp+l8A==
X-Received: by 2002:a17:902:ecd1:b0:1db:f372:a93c with SMTP id a17-20020a170902ecd100b001dbf372a93cmr309547plh.43.1709257997772;
        Thu, 29 Feb 2024 17:53:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgxp8KpJKH+5MY8w2F/PB5Ot/ZUK5Av/ZaZV4KJP/g83TZi3+n+/NnGn+HsPorVx5PFMYwYQ==
X-Received: by 2002:a17:902:ecd1:b0:1db:f372:a93c with SMTP id a17-20020a170902ecd100b001dbf372a93cmr309530plh.43.1709257997437;
        Thu, 29 Feb 2024 17:53:17 -0800 (PST)
Received: from [10.72.112.28] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id z17-20020a170903019100b001db4433ef95sm2184312plg.152.2024.02.29.17.53.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 17:53:17 -0800 (PST)
Message-ID: <6c3f5ef9-e350-4a1e-81dd-6ab63e7e5ef3@redhat.com>
Date: Fri, 1 Mar 2024 09:53:12 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] libceph: init the cursor when preparing the sparse read
Content-Language: en-US
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org, jlayton@kernel.org, vshankar@redhat.com,
 mchangir@redhat.com, stable@vger.kernel.org,
 Luis Henriques <lhenriques@suse.de>
References: <20240229041950.738878-1-xiubli@redhat.com>
 <CAOi1vP-n34TCcKoLLKe3yXRqS93qT4nc5pkM8Byo-D4zH-KZWA@mail.gmail.com>
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <CAOi1vP-n34TCcKoLLKe3yXRqS93qT4nc5pkM8Byo-D4zH-KZWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2/29/24 18:48, Ilya Dryomov wrote:
> On Thu, Feb 29, 2024 at 5:22 AM <xiubli@redhat.com> wrote:
>> From: Xiubo Li <xiubli@redhat.com>
>>
>> The osd code has remove cursor initilizing code and this will make
>> the sparse read state into a infinite loop. We should initialize
>> the cursor just before each sparse-read in messnger v2.
>>
>> Cc: stable@vger.kernel.org
>> URL: https://tracker.ceph.com/issues/64607
>> Fixes: 8e46a2d068c9 ("libceph: just wait for more data to be available on the socket")
>> Reported-by: Luis Henriques <lhenriques@suse.de>
>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
>> ---
>>   net/ceph/messenger_v2.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/net/ceph/messenger_v2.c b/net/ceph/messenger_v2.c
>> index a0ca5414b333..7ae0f80100f4 100644
>> --- a/net/ceph/messenger_v2.c
>> +++ b/net/ceph/messenger_v2.c
>> @@ -2025,6 +2025,7 @@ static int prepare_sparse_read_cont(struct ceph_connection *con)
>>   static int prepare_sparse_read_data(struct ceph_connection *con)
>>   {
>>          struct ceph_msg *msg = con->in_msg;
>> +       u64 len = con->in_msg->sparse_read_total ? : data_len(con->in_msg);
>>
>>          dout("%s: starting sparse read\n", __func__);
>>
>> @@ -2034,6 +2035,8 @@ static int prepare_sparse_read_data(struct ceph_connection *con)
>>          if (!con_secure(con))
>>                  con->in_data_crc = -1;
>>
>> +       ceph_msg_data_cursor_init(&con->v2.in_cursor, con->in_msg, len);
>> +
>>          reset_in_kvecs(con);
>>          con->v2.in_state = IN_S_PREPARE_SPARSE_DATA_CONT;
>>          con->v2.data_len_remain = data_len(msg);
>> --
>> 2.43.0
>>
> Hi Xiubo,
>
> How did this get missed?  Was generic/580 not paired with msgr2 in crc
> mode or are we not running generic/580 at all?
>
> Multiple runs have happened since the patch was staged so if the matrix
> is set up correctly ms_mode=crc should have been in effect for xfstests
> at least a couple of times.

I just found that my test script is incorrect and missed this case.

The test locally is covered the msgr1 mostly and I think the qa test 
suite also doesn't cover it too. I will try to improve the qa tests later.

Thanks

- Xiubo


> Thanks,
>
>                  Ilya
>


