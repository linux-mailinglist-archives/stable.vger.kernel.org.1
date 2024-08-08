Return-Path: <stable+bounces-66006-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 085B994B7EF
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 09:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BDE61C20B8B
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 07:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C1813BACC;
	Thu,  8 Aug 2024 07:34:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EF52F23;
	Thu,  8 Aug 2024 07:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723102478; cv=none; b=C+Q5rdfTXNfNl5WTfz28Vnf/VeoycBm/f89REoReFOMi1YIl+FM9vnKKFkkGfePMFjdytPC9Nez2Rg2MNJKSpVcAd3ixcFu0A3Ij/0uaXLxoBCxFQJThQA00r7o656B48xSzX0cxH3bpypWAsL7h19439H9x9lrT9aen/V7x+k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723102478; c=relaxed/simple;
	bh=j9ovGLKLRbVUHzGl3j99h9JATtcDt806a7C51Xn2VgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LhWYtmT1P1ek6okbBLqNyB+QJTYUTk1PJ+OK3Vl5GwNvc+E9fV1kMABr+l7FNLSKeMbd32Hq6/to3nHuwwfghbonfIPH2Nw5NjuogylJHuEB/LfdHv0BLl+3gBhJG/UoLV5B50FRYLNRMbvcHTQol4s6AOCWEw/S0BebHbStEA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5a10bb7bcd0so773493a12.3;
        Thu, 08 Aug 2024 00:34:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723102475; x=1723707275;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LANE1F4E7M4VxmxKZ4CBz1EcLRFw15dRl39LaLAGgJI=;
        b=O5blTkVSyLAq++pba6iQBVeoitQ8BjLhjDqAymZXCnTtPtIJ16J5uLwCN/ahvDFqcI
         EXEC1XWcNK1FGaQdfFYp5stXvOzIpAeqlzsLR8kiAGZ+8ELF4DfigJQumpIgUTjSp+Ju
         G9qjngknvWWYaLIaOL+/fDPf5iXhPzBQc8naIDp/uc8Q5l8i98QPkrftxBZB/V9ORnI+
         z6rTYQ0kEn73E09gsACGX1uXW0nOsbfYKRf0ibaCSBgo/qlET30XYjFl6u/m4xGnJgnC
         GbRKnO9ValrmuCLAC6If5UUnccB/BDcMoDh2PCidAAqUt2YqZJ/KM4lpTkqayU3BABGF
         XfyA==
X-Forwarded-Encrypted: i=1; AJvYcCW+PzmwMSZkkCSwcb+HsLtlDTbkn4u+oXSCfovrvNVbBk//tb09TdV4VjTTFP4SRSU+nbRfa7jMI+L0bGtVQKC/1Pzi3OwbI0yqsVIroPFf3wG05j9B5O3D61Ui0wTyNL3NzF2Khvt3AdoCUoVW6jgEQWaZfyv8N11TkvGtZ4QjrLJ3
X-Gm-Message-State: AOJu0YyMRyfJjfHeFm8mL07G6aeaAplKY0zEvjMFS4bNKF7pzSTI5WsB
	BNtC7bdxtnLNAt3cjlOYDZJYplnn2pDxb8npCjuIIZWOl75fC4zb
X-Google-Smtp-Source: AGHT+IHqpxgFNQLtYa1M+xts7q1ockNFi4t26CIhEU96NCeb5gqqCtpZD+0AqTR0NPuUYQhCFlQawA==
X-Received: by 2002:a05:6402:d05:b0:5b9:df62:15cd with SMTP id 4fb4d7f45d1cf-5bbb240fcd4mr846488a12.32.1723102475131;
        Thu, 08 Aug 2024 00:34:35 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2d34eb0sm358292a12.68.2024.08.08.00.34.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 00:34:34 -0700 (PDT)
Message-ID: <c4c01c01-e926-49fb-8704-90a69662254d@kernel.org>
Date: Thu, 8 Aug 2024 09:34:33 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] serial: don't use uninitialized value in
 uart_poll_init()
To: Doug Anderson <dianders@chromium.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-serial <linux-serial@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
References: <20240805102046.307511-1-jirislaby@kernel.org>
 <20240805102046.307511-4-jirislaby@kernel.org>
 <84af065c-b1a1-dc84-4c28-4596c3803fd2@linux.intel.com>
 <CAD=FV=WeekuQXzjk90K8jn=Evn8dMaT1RyctbT7gwEZYYgA9Aw@mail.gmail.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <CAD=FV=WeekuQXzjk90K8jn=Evn8dMaT1RyctbT7gwEZYYgA9Aw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05. 08. 24, 17:46, Doug Anderson wrote:
>>> @@ -2717,10 +2716,10 @@ static int uart_poll_init(struct tty_driver *driver, int line, char *options)
>>>                ret = uart_set_options(port, NULL, baud, parity, bits, flow);
>>>                console_list_unlock();
>>>        }
>>> -out:
>>> +
>>>        if (ret)
>>>                uart_change_pm(state, pm_state);
>>> -     mutex_unlock(&tport->mutex);
>>> +
>>>        return ret;
>>>   }
>>
>> This too needs #include.
> 
> Why? I see in "mutex.h" (which is already included by serial_core.c):
> 
> DEFINE_GUARD(mutex, struct mutex *, mutex_lock(_T), mutex_unlock(_T))
> 
> ...so we're using the mutex guard and including the header file that
> defines the mutex guard. Seems like it's all legit to me.

The patches got merged. But I can post a fix on top, of course. But, 
what is the consensus here -- include or not to include? I assume 
mutex.h includes cleanup.h already due to the above guard definition.

thanks,
-- 
js
suse labs


