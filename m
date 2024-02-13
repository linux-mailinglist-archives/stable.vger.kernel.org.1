Return-Path: <stable+bounces-19740-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C26385339F
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 15:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F4F91C22B3C
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 14:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3392458105;
	Tue, 13 Feb 2024 14:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1b2KHwap"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A60257884
	for <stable@vger.kernel.org>; Tue, 13 Feb 2024 14:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707835991; cv=none; b=OYq8Glnae9MHNkvpsMLqYglKwxlY/rqhwBRq9BkfdcJYiERWKxApY/QanI6t/zdcyv9Y+7QLz6/YwK1iDGjmndVhEI/8XOTuOqayFemvC0NJyijI5C1O+Nlxm7K2QL26AD953LQ4lxccosAexNRzyZeEHBLFdiWUAMAdLCxCnog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707835991; c=relaxed/simple;
	bh=LVCtm0jk64Vhu5aTeH2YyPiY5Ym2iDhd4l0vJ+ilMXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X9EFmsgxrwRkM/l/3kszsP/QL9DBj4MQYnNlZZ6B15L8IPDomcrVsxlUKvIv4Gb7f4JJbLtllcyfo0P0+5ZKbPNthkpJCW/jgWT4ll3WmAjQgJ+Ykt1JQUlnBsy1NBDa3a6yr1EffbpJTUbpwUVvd3g8gr6LnhcjJ0fkYq4YmDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1b2KHwap; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7bbdd28a52aso85114839f.1
        for <stable@vger.kernel.org>; Tue, 13 Feb 2024 06:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707835987; x=1708440787; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cJK7vV3i1FMQ/vGr4i97n291cq9PK/hlU7RREggR1gA=;
        b=1b2KHwapEQrl1ArEhIdFul7QbEphlAtawQo868vzDMi5sYthi3eokLT2PU60zFdsJ1
         gkPcozhPPfFLLrs1HUAqlESZNpTV1fS4KTjT1/T6f2JVaV0kjaQubC30lJT2wJITG6Je
         nYfHqDocnXjyg/6PVyRu1CS8/BHJxKeSep2Gb5ypct9HoCPB6WWUPOebrCgWjeOtnuI8
         FRopmXQG3uea+sj+SpfnhLPQFOGH7+9MbwE8vpu0wU3uHqfFytCkQmOyCI+0d7sV47tQ
         onZs/kUoxHf9Uizi8wC014w7gPWf/7OXYybbQ+aUlcGKjDv15V4DZJTg5K6Dneeb2e3K
         56BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707835987; x=1708440787;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cJK7vV3i1FMQ/vGr4i97n291cq9PK/hlU7RREggR1gA=;
        b=wdqZAwuSknuqDX+7FP7zqePoacdF0jbjhxeYmGcaVnaAiSQU9lhtvF68SNQi1xfiui
         dQGj0Cf4UeHJA9Rol8g7PbiM8xAgcKn9Ru4seVa2zQOcONgg7KGyeTIpgQzJZPouXWFa
         SkjfmoVcT2lN3ymTbWtIcFRmDxCz8yURS7WXN3DlsN3c/TjmfYhRZiGukRpD7iXvkyzP
         HrRuO3esE69QTj4ipX0S8dYB67/UDbpgStsJC+m8dE+FxtX91OL/MHP1fSB5tvcXfzQa
         03Dn5416EuyqXEEcTkmTSTUZiVKSO1XsjAFwJuydhtUtLP02BPrUTha6wwpB5BlpxC5X
         dxeg==
X-Gm-Message-State: AOJu0YyOZlaeRIzGOE3EBRZdUAmgpAi5rt2w87kNSCt6aAiBIahE9xDz
	Tcm4fjPFawbBSW3YZB8j4LCW2UTZphlyl93J+Ov1w05+QTBW07opsJMgUp4FCEfOc+VoFHBbexU
	I
X-Google-Smtp-Source: AGHT+IEyC4IQ+UTaIWeLKqcUCtSYMmHcJPR3I9e+JnsNY6+veNrrxWjUbvNrU4hn2uooHxFrmdArCw==
X-Received: by 2002:a6b:db16:0:b0:7c4:6dfc:f697 with SMTP id t22-20020a6bdb16000000b007c46dfcf697mr3637687ioc.1.1707835987652;
        Tue, 13 Feb 2024 06:53:07 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id y72-20020a6bc84b000000b007c44a0a54d6sm2268186iof.33.2024.02.13.06.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 06:53:07 -0800 (PST)
Message-ID: <754076dd-edf4-4b8d-a3c6-9758e669ac90@kernel.dk>
Date: Tue, 13 Feb 2024 07:53:06 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/net: limit inline multishot
 retries" failed to apply to 6.1-stable tree
Content-Language: en-US
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
References: <2024021331-stool-hash-b0c4@gregkh>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2024021331-stool-hash-b0c4@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/13/24 6:19 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> git checkout FETCH_HEAD
> git cherry-pick -x 76b367a2d83163cf19173d5cb0b562acbabc8eac
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021331-stool-hash-b0c4@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

This is fine, let's just skip it for 6.1-stable.

-- 
Jens Axboe


