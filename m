Return-Path: <stable+bounces-19760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA5F853579
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 16:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96D5E28860E
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 15:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566475F483;
	Tue, 13 Feb 2024 15:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="T1vanX43"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10615F476
	for <stable@vger.kernel.org>; Tue, 13 Feb 2024 15:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707839948; cv=none; b=aWRdlrqnMX81jlEwWHs9zCUCA/X6cG1CNNya1FM3+3P5KmDMS9iwYwTBJ2KPFPhRrIczarC5A3kfT+gIbR2469CdXLRWQP6tXNUVSkO/yT6ekR5JMAfp/CDVNKzOg6ZLSZJUBatoeA7S6FozRdRNv3PQKvQYrrlFHprYZ6Tca10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707839948; c=relaxed/simple;
	bh=aNMX4b+glBRJHLlsyJa9j0+humilNoh82SR98A3EaGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e6mZ5FdvoG4lNmNyUya/5hGsybn2uzDoh+QGMUjqwVjmxjOZsO2oS2JSXZUqI1soSW6FXyHeJk1TYMYDLzFXyLNAICN20y6HUBDDkVu5s1WN+kcSGXJyut29dqjtj8HZwpI2EyFaDj3gu6on1OetrboIG9MSOnSDCmlhBL3/QAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=T1vanX43; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-363acc3bbd8so4293965ab.1
        for <stable@vger.kernel.org>; Tue, 13 Feb 2024 07:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707839946; x=1708444746; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dp2zB9TlWQdBJtuLkDeHrazfa8U0AnELgxK9HNAjV1w=;
        b=T1vanX43ccM2SBx/0o9bnX4PPiWx+sSC+UsYKNTdzBUkGK/vGb8qpdc1w0eJYWTQlS
         64dzkZDbqy6502NMGVVbcgFckKLikq6mpzmJa8YKOY4hj7wg5wwjDC49BWuEfh6XUSNI
         AVY5KHWpZubRMYILBA/A3WndLl82a82ynAe1BNTZrUK2M33T803P9U4ktjlfOPR9dMWU
         Cze/IeNg0TIcvvsrmq1/Idx5Bip9EoYgPGTfFavr5Am3boq4UhVJ9AGEpmh6Z0SRYvA4
         fCkYIPb345H77uU3Ou2pYgcvMghZ9bixFTxWqmv2GdpfmxvCtG1OWQGcYpFF9GO96IZ3
         TVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707839946; x=1708444746;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dp2zB9TlWQdBJtuLkDeHrazfa8U0AnELgxK9HNAjV1w=;
        b=PLGf6s4WYF1aGrVBDKDLfn8XlrXNjGkwRnFuNoosw4d7PeQgpyoVLIlwmJrO3LjwUE
         9HjbBCm0iBzO5lUZzgNMQBINE/xfUuTv8Dhrt0sbIkh4/npkPxXql09AJB43yymIQIHj
         0ImX6UP0GE7OFqK3/mvarhnqoHAiv404w9dwv1yB7milXCo+47vkW/JcXH+ojCO8yz+I
         f/KGxjpdm4ej8tTH1gIWGoEjLWxXtKFMVh1I3+uluUzwTRPsepZWmZM+JjAwEJWUK+oA
         RR515eu6DB78k3gqyX7Utxo0KE1RYLw4ntiwWF7JC/wNLEV9uVBHNAwYZjK12xIr12g4
         5Rzg==
X-Gm-Message-State: AOJu0YyAvT6PEpPpporYcUMt9ZJuNVV7dfV/54oKVYtQJ1Y6WEKSIwX6
	4P4bJIIn6LOwX0DBKActVs8pAnk/ezfiv9ooq3hTP40l7Y9UZPL5/IJCEFO5Z1gzOhpAg09qQyV
	s
X-Google-Smtp-Source: AGHT+IEhjmlwqjxjqU1RSv5Io6J62HGwbFPQp/7El4DqIeCLtfdvdLyE8QWR46YIqZZiAeByOoeuYw==
X-Received: by 2002:a05:6e02:b4e:b0:363:b545:3a97 with SMTP id f14-20020a056e020b4e00b00363b5453a97mr131848ilu.0.1707839945754;
        Tue, 13 Feb 2024 07:59:05 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id bb15-20020a056e02000f00b00363c3ea4bb9sm2576378ilb.86.2024.02.13.07.59.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 07:59:05 -0800 (PST)
Message-ID: <2aecaa39-cb42-40bf-9705-3867d1de41b3@kernel.dk>
Date: Tue, 13 Feb 2024 08:59:04 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/net: limit inline multishot
 retries" failed to apply to 6.7-stable tree
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
References: <2024021328-washboard-crevice-aaa0@gregkh>
 <19f32ce2-cd5d-4a02-b3e6-441140e026b8@kernel.dk>
 <2024021344-headlamp-steed-92c2@gregkh>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2024021344-headlamp-steed-92c2@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/13/24 8:55 AM, Greg KH wrote:
> On Tue, Feb 13, 2024 at 07:44:12AM -0700, Jens Axboe wrote:
>> On 2/13/24 6:19 AM, gregkh@linuxfoundation.org wrote:
>>>
>>> The patch below does not apply to the 6.7-stable tree.
>>> If someone wants it applied there, or to any other stable or longterm
>>> tree, then please email the backport, including the original git commit
>>> id to <stable@vger.kernel.org>.
>>>
>>> To reproduce the conflict and resubmit, you may use the following commands:
>>>
>>> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.7.y
>>> git checkout FETCH_HEAD
>>> git cherry-pick -x 76b367a2d83163cf19173d5cb0b562acbabc8eac
>>> # <resolve conflicts, build, test, etc.>
>>> git commit -s
>>> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021328-washboard-crevice-aaa0@gregkh' --subject-prefix 'PATCH 6.7.y' HEAD^..
>>>
>>> Possible dependencies:
>>>
>>> 76b367a2d831 ("io_uring/net: limit inline multishot retries")
>>> 91e5d765a82f ("io_uring/net: un-indent mshot retry path in io_recv_finish()")
>>
>> This has a number of dependencies, as listed in the commit. You need all three
>> to make this both apply cleanly, and work. Here's the series for 6.7, I'll send
>> the same for the other ones separately.
> 
> I tried applying the dependencies, but they didn't all apply either :(

Only issue I had was the moving of code in the first dependency, so I
had to do that manually. Rest was fine after that. But yeah, it would
not have picked cleanly, required a bit of manual intervention. That's
why I'm here :-)

> Thanks for all the backports, I'll go queue them up.

Thanks!

-- 
Jens Axboe


