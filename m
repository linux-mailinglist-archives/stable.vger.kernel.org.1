Return-Path: <stable+bounces-178003-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF63B4772A
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 22:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22E8DA07482
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 20:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA671C860C;
	Sat,  6 Sep 2025 20:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="VTMQjKOt"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0174315D45
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 20:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757191630; cv=none; b=rDIURX/Pc1aiUYX46R2Ki1dfK8/OnCp94zUzwgZbllZUyy/uU3X91XRnefKcAZQ0qph16JtI5ceO6Av9b+aY6SP7j0XkWgLyQ2fjhkodGN83rpAlDfaO0De4dwKxEgW9kxtG8K3alq2oTZt/B99kA5s5nnl3FdyeCaxmxAWo/1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757191630; c=relaxed/simple;
	bh=jTnEaxp9BP8/AddUH+XwLJ/cVG+SC8HH3vPYcnBn9Io=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GCRl/VJkiJWZPtccztgsH+KGbXd1AREMrueXrat9eB3b2cYDHXKMmNrM/Et2zMKMcepvr/K03GBrY59nz89btOoEsPKWNx+Xq2c2lSRA9O+SGgE6WoNRd5VrbSb3+VQRAcqP2Jr36BkvPAJtqcp27BZnc2IM4Aoc29w4EEvlQoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=VTMQjKOt; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e96d65194c1so2863110276.1
        for <stable@vger.kernel.org>; Sat, 06 Sep 2025 13:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757191625; x=1757796425; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z9ZVeJL/Emwv/SkZ0DbsDCHxEglqau8eQ790MYJRke4=;
        b=VTMQjKOtlYVb9pH1sEOFi7QTNNWcLkmFn20ZHnPliU4ZdPvp/lMbcMeDRhcZSDq0I4
         WMOYMbVzP/ZvKgkybBht9s+dhdd56w0mjimg9Z6EF9gKIhz9pRoe21pzFvU3AmZ9CAhW
         9b9SvRl50IUS53RAuPRduPktlitsQ4OO6KLixHPw5/ybcqzXTE6N3TR8v0q6RlazCUg5
         53BuHCEGYIEHukCH0WiTdXfkGHkVWy0NK3BeV1wsnR9nsxbqOPpPP48dA15eUxmtetga
         akM08DMeN1kmrSxT1S2VsQpJ0jApLitK0oTpUhvEfKGUlpmEWEHutXyJm/ILdV+UOstL
         0Ilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757191625; x=1757796425;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9ZVeJL/Emwv/SkZ0DbsDCHxEglqau8eQ790MYJRke4=;
        b=JOyRpR5usMRYfIGi8u7g9QO3BJEl9mqNIA2II978FrdZFAQ/8jLvJjlgwWbn08w1ju
         iNvaahbt4fsw0n+gHBoJH43cONgU4cv8K/otvFvbmjhJL+alxCG75WhMKuQ3GgVbP7XR
         tunLhPft4GbZCZg7RMoqUF1IlgxdK6TM/X88CCdNdlIay6zZVy7AxZrLLxzRJKzahNiM
         Fw9foZhxHliFq3S+52Sl/Q0kQXi+TOlXTT/e6c5om7/2zfbESvF0ncJFffCUxowF68+C
         4sOZGI0pqjfffyMdgvF3PZWjE9/5wTtWcHEh4A5mlP+KI/jzB2SbahHrnSFbGSymdtrx
         x6aQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0Am/GSVSQUOh2TXiGYz3/U+mjRiWwDKGGROPx1lcLCdsd3ahYkR99QEcGKziRHJ0Hj2hkMog=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZzGYPZFrSiyxG/cylYFY0iqsp9tS/oB3dYpLjHWsmwDRqFMOX
	j7kq0g6t6q+WpLNuIzShX2LSto5ba1wgj9Px1a2s1AcymVxGFmh5VXm00kSJbux29geyVNoI15Q
	7qnmW
X-Gm-Gg: ASbGnctE/48K22Yljo3jrFPBexDjeTQVTe7nECuidZzc74FarKUqQy0ESfOFehIx7w+
	7ekeVh/mfbSOUx3PB7Ln53Jqkb484lz69f9GH7dPAlw5rbvOLO8cSx4Kylw2heo+WwgTtMe2nNv
	yIMSKVuVMq01fjjX7QAvSBdJindawVctwbJ5jnBNvI64oyHNXzP5RrkJwQz0coxxHgXSBmXy+dT
	BxaRTe5BLzImu/Avw3KiZdN1vJ68JEjGFp5kiWsNfnLx0PpJJPjUhs7pP2QqOqnzaCSuwRm+YV5
	cIBTqnt+Ym0O78fVJxd5eDFNqwyo2meHzUriOs119pHDnNerf3AHmwa3FnF5Tao+WwX1rtDoxzG
	A3bq8Antj3sd6bwinH6JoXvFOorDH+A==
X-Google-Smtp-Source: AGHT+IH0JU0CsJpoTew8bkpiLx7b7OMUDAjukeaJHF8Hyg7A5DBr3Lf//AEO1G0wFgAf7a0qwdbk2Q==
X-Received: by 2002:a05:690e:42c1:b0:5fc:f7dc:571 with SMTP id 956f58d0204a3-6102191b939mr1925752d50.4.1757191625494;
        Sat, 06 Sep 2025 13:47:05 -0700 (PDT)
Received: from [172.17.0.109] ([50.168.186.2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723bd2cd669sm31849107b3.0.2025.09.06.13.47.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Sep 2025 13:47:05 -0700 (PDT)
Message-ID: <368617ee-8e77-4fec-81cd-45ee3d3532bb@kernel.dk>
Date: Sat, 6 Sep 2025 14:47:04 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12.y 11/15] io_uring/msg_ring: ensure io_kiocb freeing
 is deferred for RCU
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 stable@vger.kernel.org, vegard.nossum@oracle.com,
 syzbot+54cbbfb4db9145d26fc2@syzkaller.appspotmail.com
References: <20250905110406.3021567-1-harshit.m.mogalapalli@oracle.com>
 <20250905110406.3021567-12-harshit.m.mogalapalli@oracle.com>
 <f43fe976-4ef5-4dea-a2d0-336456a4deae@kernel.dk>
 <96857683-167a-4ba8-ad26-564e5dcae79b@kernel.dk>
 <2025090622-crispy-germproof-3d11@gregkh>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <2025090622-crispy-germproof-3d11@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/6/25 12:36 PM, Greg KH wrote:
> On Fri, Sep 05, 2025 at 07:23:00PM -0600, Jens Axboe wrote:
>> On 9/5/25 1:58 PM, Jens Axboe wrote:
>>> On 9/5/25 5:04 AM, Harshit Mogalapalli wrote:
>>>> diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
>>>> index 5ce332fc6ff5..3b27d9bcf298 100644
>>>> --- a/include/linux/io_uring_types.h
>>>> +++ b/include/linux/io_uring_types.h
>>>> @@ -648,6 +648,8 @@ struct io_kiocb {
>>>>  	struct io_task_work		io_task_work;
>>>>  	/* for polled requests, i.e. IORING_OP_POLL_ADD and async armed poll */
>>>>  	struct hlist_node		hash_node;
>>>> +	/* for private io_kiocb freeing */
>>>> +	struct rcu_head		rcu_head;
>>>>  	/* internal polling, see IORING_FEAT_FAST_POLL */
>>>>  	struct async_poll		*apoll;
>>>>  	/* opcode allocated if it needs to store data for async defer */
>>>
>>> This should go into a union with hash_node, rather than bloat the
>>> struct. That's how it was done upstream, not sure why this one is
>>> different?
>>
>> Here's a test variant with that sorted. Greg, I never got a FAILED email
>> on this one, as far as I can tell. When a patch is marked with CC:
>> stable@vger.kernel.org and the origin of the bug clearly marked with
>> Fixes, I'm expecting to have a 100% reliable notification if it fails to
>> apply. If not, I just kind of assume patches flow into stable.
>>
>> Was this missed on my side, or was it on the stable side? If the latter,
>> how did that happen? I always ensure that stable has what it needs and
>> play nice on my side, but if misses like this can happen with the
>> tooling, that makes me a bit nervous.
>>
> 
> This looks like a failure on my side, sorry.  I don't see any FAILED
> email that went out for this anywhere, so I messed up.
> 
> sorry about that, and Harshit, thanks for noticing it.

Thanks for confirming, because I was worried it was on my side. But I
thought these things were fully automated? I'm going to add something on
my side to catch these in the future, just in case.

-- 
Jens Axboe

