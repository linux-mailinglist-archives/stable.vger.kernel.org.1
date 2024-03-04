Return-Path: <stable+bounces-25978-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EB6870BE5
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 21:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50DAD1C22164
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 20:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063EB101C1;
	Mon,  4 Mar 2024 20:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="u9LAcnIZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD4579C5
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 20:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709585619; cv=none; b=ClYnIAu8I/oy9nZwFo0rHRvRbRIz/l0FDjVAi/J2FMqsl1mE3sPlz4cIDuylUHxXhRi9VmDNMYviMoeCjFmi+7qiqJuSDQKi5P7qmSEUYK2hfjmJWBxOX3zJNzFkdwsZv41inmtI8HkpvQSDt8kZs76SiNgG4qOWukSW4D9F5A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709585619; c=relaxed/simple;
	bh=DgKavsA85fHRI/A2Xu/QYBjb/sHID9ZOaQyjgq9v73Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RLwEanYQd7LPFf1+iyoFtaXJ9bFhNQEzG5K5k08dC3TrD70m53eYSxl8yiOpmHmqTNCCEpd23u1SJYRTR6sQKL+Zcz8+emcO+oflkA6a1WXtPdNZ7Yfo7+w7uXVEU6NqtRH9FMtPtz7nd8DmnNkXQUuSad3nwroJh6vHHpK+zSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=u9LAcnIZ; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-60858cfbc98so2208257b3.1
        for <stable@vger.kernel.org>; Mon, 04 Mar 2024 12:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709585616; x=1710190416; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UaiFPeljKQTnnuDl9y1nPNnYywTRghw1tefyhALlBkA=;
        b=u9LAcnIZdBHdLpKpAwpcYnYoVPmOVOutvtwSmZUdpzjvaBbh93RgHZxHJ4VWHA48Sw
         WME2VQMWSfMqcmYaSDo8mXLAH9BH6aFZFxjxtK6wC8ALGhV8SjXMQEawnC/C6UIdXV+0
         IvuAaDLyizNFPK+J2cOoOjIWrlPwLc3KhqWG+V0ISNs22BYML0VQhWm7EyLeNd8rgXvh
         yvs44DT40t2WADfS2AX8lkiIxYsWjSZ7jsBZXf9HtCeZrIZJrrPvfRmRsKdtYiNiH7vK
         pr47jb/gcEQTE1qdqK6qSsRnOGU5xXk46+8lt7+fYDsvmu922I2vB0ND93vv0WTDW2hF
         2wKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709585616; x=1710190416;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UaiFPeljKQTnnuDl9y1nPNnYywTRghw1tefyhALlBkA=;
        b=iGu5wDDP9pBA046aMrL+R/WbhQqV52NyJu7Wb1GEOWzjsDgaDBD36EzuNLjoeZgH8W
         wmeqaaGDKtq29yIvBXHZ2H3hNVqrmPWEgw/TdVqt8BGZUxR/IU33LL4YDj8EQ5kbSpD3
         IVi5q+YQWAZVVC2zvbchF92q3kTSb+HvLIIzho7ZDgsmA6rDMAX246CmchyMzd4hob3Q
         MMInje/YkG9BZ/vEjaZ3ODCkcPJjxdrKQAvMuLP224chFszZ/7ICmuWSY191UlzBcx8R
         oSpvvchSRRqSHXUunM6LkClw6omOTSkqebva4C2hWW+o/mhu4/PNO3GcAVWW59uOUcVr
         bIig==
X-Forwarded-Encrypted: i=1; AJvYcCVScdkXMBItYKcq2bqv4h2Fu3V3qhJp8c0GMcSAeFsAv0ETQyk8ayUKs39OV3Y7LXm82M/OMl0AA7d4jFTO49LNik6ly53Q
X-Gm-Message-State: AOJu0Ywg3ttzcqk70veiMiRzWEqCXmIN4JgnYyU5bsY0JK+Shjxh6PBF
	4TbmvHNmXT9T3OLnp0/LBeYX7NBNNvMgAndSdh605RgB+XE3fToMyHH/l3f3QpU=
X-Google-Smtp-Source: AGHT+IEn6Isdmp/elK7/SXYEAztI+sNFtGSfVwsMN8V+Bu0638zU06OmxXF05jr9h3XT4WDbgKVRwQ==
X-Received: by 2002:a05:690c:338c:b0:609:552:2fcb with SMTP id fl12-20020a05690c338c00b0060905522fcbmr8538455ywb.3.1709585616620;
        Mon, 04 Mar 2024 12:53:36 -0800 (PST)
Received: from ?IPV6:2600:380:9e4e:d529:fa8c:33a4:688a:83e? ([2600:380:9e4e:d529:fa8c:33a4:688a:83e])
        by smtp.gmail.com with ESMTPSA id u125-20020a816083000000b006078f8caa68sm2842990ywb.71.2024.03.04.12.53.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 12:53:36 -0800 (PST)
Message-ID: <c4da881c-db33-4cf8-ae5f-fea81aba1f6d@kernel.dk>
Date: Mon, 4 Mar 2024 13:53:34 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] fs/aio: Restrict kiocb_set_cancel_fn() to I/O
 submitted via libaio
Content-Language: en-US
To: Eric Biggers <ebiggers@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
 Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Avi Kivity <avi@scylladb.com>,
 Sandeep Dhavale <dhavale@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kent Overstreet <kent.overstreet@linux.dev>, stable@vger.kernel.org
References: <20240215204739.2677806-1-bvanassche@acm.org>
 <20240215204739.2677806-2-bvanassche@acm.org>
 <20240304191047.GB1195@sol.localdomain>
 <73d9e8a1-597a-46fc-b81c-0cc745507c53@kernel.dk>
 <20240304204916.GD1195@sol.localdomain>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240304204916.GD1195@sol.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/4/24 1:49 PM, Eric Biggers wrote:
> On Mon, Mar 04, 2024 at 01:09:15PM -0700, Jens Axboe wrote:
>>> If I understand correctly, this patch is supposed to fix a memory
>>> safety bug when kiocb_set_cancel_fn() is called on a kiocb that is
>>> owned by io_uring instead of legacy AIO.  However, the kiocb still
>>> gets accessed as an aio_kiocb at the very beginning of the function,
>>> so it's still broken:
>>>
>>> 	struct aio_kiocb *req = container_of(iocb, struct aio_kiocb, rw);
>>> 	struct kioctx *ctx = req->ki_ctx;
>>>
>> Doesn't matter, they are both just pointer math. But it'd look cleaner
>> if it was below.
> 
> It dereferences the pointer.

Oops yes, was too focused on the container_of(). We should move them
down, one for clarity and one for not dereferencing it.

>>> I'm also wondering why "ignore" is the right fix.  The USB gadget
>>> driver sees that it has asynchronous I/O (kiocb::ki_complete != NULL)
>>> and then tries to set a cancellation function.  What is the expected
>>> behavior when the I/O is owned by io_uring?  Should it perhaps call
>>> into io_uring to set a cancellation function with io_uring?  Or is the
>>> concept of cancellation functions indeed specific to legacy AIO, and
>>> nothing should be done with io_uring I/O?
>>
>> Because the ->ki_cancel() is a hack, as demonstrated by this issue in
>> teh first place, which is a gross layering violation. io_uring supports
>> proper cancelations, invoked from userspace. It would never have worked
>> with this scheme.
> 
> Maybe kiocb_set_cancel_fn() should have a comment that explains this?

It should have a big fat comment that nobody should be using it. At
least the gadget stuff is the only one doing it, and we haven't grown a
new one in decades, thankfully.

-- 
Jens Axboe


