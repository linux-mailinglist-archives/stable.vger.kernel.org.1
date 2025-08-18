Return-Path: <stable+bounces-171630-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C48B2AE86
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 18:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CDAB3B99EF
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 16:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DFE2F30;
	Mon, 18 Aug 2025 16:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDXUQU6Y"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABBC27B325
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 16:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755535701; cv=none; b=NXlWgFwsyFU9fwdHgNWSpJ/SwhFpbBvV9jnSmcS8Vn9BZiNkHS93kq4t9iZMY+OKCALcoFmS7/TIMFYNaFaC54QVvyZDzHMbNON7k9ZmLE/sBrIbuudMa1/QXMcFP2fTiUyrrOSoxzjXCNOM2pKGWFNOt5dho3dkTjE+9PaCf0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755535701; c=relaxed/simple;
	bh=GqvNGG06Sltuzwz/F8yrTgdNd+5b1mkwIhEDVY3TV80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HwhSa8CzbAJ876f6XD4xQB8tSENlQ4CAdNlMHHHuNYtWlR0bweXzR+TM7kbRvxjn4dbHNVHpUBvKWaldXMpqe+MxTww2IJg+fgDl/yp1TUIXATqkkTV+nTQbxNXXb4yVOZu0NX9KS4QIGMmj+kg5tK5Iyso8DbSNsy7c7bTyKsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UDXUQU6Y; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b9e418ba08so2481847f8f.3
        for <stable@vger.kernel.org>; Mon, 18 Aug 2025 09:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755535698; x=1756140498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G9HESF6tWVP7OyQeIMjKi3ghPOcS2UiEdbkEvF0YEzk=;
        b=UDXUQU6Yq9YAiEjBM6ihFcd1p3Efk/TW6sjTOeeT0alNDnahpBBHzPwBcqnqpYc8q+
         /FVrlc+bMpSNoZ54j7fEls6OCG3VJF1c17GYzjyy8qjRQ9l7ai0MLReI905OTZBzT4WA
         urjVH/AqNE01KgZhFKD0Bawd3bdv63QsIWI2/kTidXrgrkduPvPc5Vr/uc75ayg1OA0Z
         zR1vtwjby5q6pcSR9GdeeYyVmguPMuFydoEJNUQRUjGgVrkLUw6AgFIDFHXWxtMw7rsR
         7o24nChGHOUesYDKKZnXn1R4uV8rYs7+lWh1/vaEGz34aoOlBX35DgHsblVhw0zUFg2A
         SreQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755535698; x=1756140498;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G9HESF6tWVP7OyQeIMjKi3ghPOcS2UiEdbkEvF0YEzk=;
        b=Pwi/nXgAiqp9cmka6pOh7gXdiLKLTH/uLFBrk48qD0YWYAhK9ONda+VoxCJ6DPn21Y
         R4TDoRLkafd+ZJqGXwCn1mvQByUoja3jlq4vOhXtKyIPU5zZp5prCH8wexXKGKZxAkqs
         zwuAAigxz4GGbPOqucwDP6vCtaNJUvqrAMBJ6lCoVXXtDIVY3K+A/I0Yku55hBMigy4v
         KQuKZULZCMZ35nZ9F7bp4wJIdVKRATFSgQ00AuQMqmYgquswu2c5mLOXMRPF/D47HqwN
         tvYE9Qhc3lCV1RT1F0l+6+UG96lLl9BjkLTOSmObd+MfkgJtEta/cyHgUohbfuvyb0ve
         VDIA==
X-Gm-Message-State: AOJu0YxImrQwulKgtWRRWJtGNEEzGQ5xkwTRSDXr2CHwFlp2pqC8bY+u
	zvzwuo8Dmu8A+29nWT32aKUj11uSl50i1q75d1LvtBqp8Tbxi8m3+v0Az1Oq8A==
X-Gm-Gg: ASbGncubWOHwqM3O0ticvCUb1q37rGqDULlBcK1JrJAR7yroe/blCkCf0pKyOS14efS
	mBq1sa6aI3W4kdMpz04SLgR+1oj+7Mv8J+5FV7PxUmBKdTWbBTERofjgCsz3TbE/0+qkFZf3Jl3
	gLq7Es6JVpE0wlm3S9mdiLNu9b0FBDyKEyr0vdELPdBTlf0Tuej76EBDDeOrryZ2f7PLH4dzXPc
	VnHA8WodgByDBQGu1evrD0QpQRqV234pBrJFud2bk0fEK+quUEoD+2ky4t35WL8p7364zcFYPpM
	NORvc9DmkMHI0VgebaaO1nCz5klaxdNAmjejv+IePNADQ7WX+nl/G17oi0Wj67ZH36cMQfBajTO
	a6GyjkTW07xCoRFvjMbA2qEEFMVcggw==
X-Google-Smtp-Source: AGHT+IGwTy+6gcrmTR1YOkIoI4dbtRX1MiSmTLpgj9XwCZMJAgCui46bS7TcILPxUiEe4gnNrgnajw==
X-Received: by 2002:a05:6000:4026:b0:3b8:d79a:6a60 with SMTP id ffacd0b85a97d-3bc685cceadmr7621448f8f.3.1755535697567;
        Mon, 18 Aug 2025 09:48:17 -0700 (PDT)
Received: from [192.168.8.100] ([185.69.144.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a23323c4bsm73732875e9.8.2025.08.18.09.48.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 09:48:17 -0700 (PDT)
Message-ID: <95a8a07e-b5ae-41dc-be53-7c3c71fad2c4@gmail.com>
Date: Mon, 18 Aug 2025 17:49:29 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/zcrx: account area memory" failed
 to apply to 6.15-stable tree
To: Jens Axboe <axboe@kernel.dk>, gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
References: <2025081527-unflawed-matrimony-2057@gregkh>
 <e27afbbb-7d13-4381-963b-8dbd1e2d06bf@kernel.dk>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <e27afbbb-7d13-4381-963b-8dbd1e2d06bf@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/18/25 16:21, Jens Axboe wrote:
> On 8/15/25 9:26 AM, gregkh@linuxfoundation.org wrote:
>>
>> The patch below does not apply to the 6.15-stable tree.
>> If someone wants it applied there, or to any other stable or longterm
>> tree, then please email the backport, including the original git commit
>> id to <stable@vger.kernel.org>.
>>
>> To reproduce the conflict and resubmit, you may use the following commands:
>>
>> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.15.y
>> git checkout FETCH_HEAD
>> git cherry-pick -x 262ab205180d2ba3ab6110899a4dbe439c51dfaa
>> # <resolve conflicts, build, test, etc.>
>> git commit -s
>> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081527-unflawed-matrimony-2057@gregkh' --subject-prefix 'PATCH 6.15.y' HEAD^..
> 
> Pavel, you fixing this one up and sending it in?

Considering that the whole thing is already limited to CAP_NET_ADMIN,
IMHO it'll be safer to leave it unpatched rather than hand applying
it / or pulling in more dependencies.

-- 
Pavel Begunkov


