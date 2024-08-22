Return-Path: <stable+bounces-69860-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C25E695ACB8
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 07:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B5D91F22A92
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 05:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A76743AC4;
	Thu, 22 Aug 2024 05:03:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6111D12E5;
	Thu, 22 Aug 2024 05:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724303010; cv=none; b=V9EJoX11w3aPsv/phBXWn3o4zlK+Y3qD6ncdI6SKt2YIITQZrI6qb+i9+A0VXYbk16ch6w7Fq+QV9oSOTA5xSZ2ithgr8gTj8pOHHC62CM54bGasAeyzE/ylXuvIRQpQIe4PrSyr04rPb14LEFjEkCoPTdXXNYaWfChJG8S+/EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724303010; c=relaxed/simple;
	bh=YX7mLMP06S6ypAt2alnUaUCfMaLCr2a+7eVQihu11v4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q0TWOzch4ykC04mQ/PyzRAtf63L4KK0wyEz7ViZh3B7wUSGKE75O2zSIMZGhWKGXQAhkOtuQXc4PTFwe9WYHN5WoJE0auALtVXqTCGZl0e4OyOqV++z4pYzMG6piSTOPWlRv8VFY+6uk5NC1pcrfKeVEhKhTHP3KgCaLqrCOTUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-371b015572cso158038f8f.1;
        Wed, 21 Aug 2024 22:03:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724303006; x=1724907806;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YxcAV9YpuA7HjlGzK4+c642htFL0GJBcbgu5k6DbtKk=;
        b=CG0McXXk9wf2zLX7qV8bd/mqtAs5D25+NwcL/t3HvYEblJD8g8QwCWNGEcbN792KGl
         A3L/9KRkaM5Ux6fh6A9uPchmXOY+Uxz9SbeNAbzwzSxWs4aR/oX8Prfbu/j8l+53DTFf
         4UEKxjeMsorUprL3JZGwLQRv9UW4nWcr+YCKrehdzHyaQUa6fzjvKXMWKB1SLlyw7hRH
         lC+/JH3J26vrgAKRS/pAGyVh6lFCr7MUGoTF3CbS+pMWpo8g/f0X+tcOfWiiGPxMcJS+
         Bq06X/KbZuZSh0LYcioWrVlmO91nXZXRBw/Efd5yrg7jV/Lpx65UTm7MWcROd9QG1NhO
         YnsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOJT626GgfNKdI0kNi8MdApIS8ks2WmQOwupsJmwhh4S9b+tby1uwFjIxPCT8eff50W6lAeGHuo5J4ML6GJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzFm7yiowPmmbrJTvHyLBWk68VM19c1+x/igJpO1gctmyz2u0V
	b/jSE8/gAW+aFL2qKae/reOCdcEDClVKhJzf0Cv+0BsHdbt/26ZjSotkBgLS
X-Google-Smtp-Source: AGHT+IE6qCmuEpuVUWE8r5KsEJ/4JXHvtYpkKBWYAftg+VyFrz5rImV0GCsHCThwOgLEkOJm5jeK3Q==
X-Received: by 2002:adf:e3c4:0:b0:368:4def:921a with SMTP id ffacd0b85a97d-37308d75b60mr389913f8f.48.1724303005707;
        Wed, 21 Aug 2024 22:03:25 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f484b5csm57590566b.164.2024.08.21.22.03.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 22:03:25 -0700 (PDT)
Message-ID: <f7d3abbc-60ec-46d1-8486-cd43121d76cf@kernel.org>
Date: Thu, 22 Aug 2024 07:03:24 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "serial: pch: Don't disable interrupts while acquiring lock
 in ISR." has been added to the 6.1-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org,
 bigeasy@linutronix.de
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240821133745.1670922-1-sashal@kernel.org>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240821133745.1670922-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21. 08. 24, 15:37, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>      serial: pch: Don't disable interrupts while acquiring lock in ISR.
> 
> to the 6.1-stable tree which can be found at:
>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>       serial-pch-don-t-disable-interrupts-while-acquiring-.patch
> and it can be found in the queue-6.1 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

I feel so. It does not fix anything real. It is a prep for 
d47dd323bf959. So unless you take that too, this one does not make sense 
on its own.

> commit 2e7194802a740ab6ef47e19e56bd1b06c03610d3
> Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Date:   Fri Mar 1 22:45:28 2024 +0100
> 
>      serial: pch: Don't disable interrupts while acquiring lock in ISR.
>      
>      [ Upstream commit f8ff23ebce8c305383c8070e1ea3b08a69eb1e8d ]
>      
>      The interrupt service routine is always invoked with disabled
>      interrupts.
>      
>      Remove the _irqsave() from the locking functions in the interrupts
>      service routine/ pch_uart_interrupt().
>      
>      Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>      Link: https://lore.kernel.org/r/20240301215246.891055-16-bigeasy@linutronix.de
>      Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>      Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
> index abff1c6470f6a..d638e890ef6f0 100644
> --- a/drivers/tty/serial/pch_uart.c
> +++ b/drivers/tty/serial/pch_uart.c
> @@ -1023,11 +1023,10 @@ static irqreturn_t pch_uart_interrupt(int irq, void *dev_id)
>   	u8 lsr;
>   	int ret = 0;
>   	unsigned char iid;
> -	unsigned long flags;
>   	int next = 1;
>   	u8 msr;
>   
> -	spin_lock_irqsave(&priv->lock, flags);
> +	spin_lock(&priv->lock);
>   	handled = 0;
>   	while (next) {
>   		iid = pch_uart_hal_get_iid(priv);
> @@ -1087,7 +1086,7 @@ static irqreturn_t pch_uart_interrupt(int irq, void *dev_id)
>   		handled |= (unsigned int)ret;
>   	}
>   
> -	spin_unlock_irqrestore(&priv->lock, flags);
> +	spin_unlock(&priv->lock);
>   	return IRQ_RETVAL(handled);
>   }
>   

-- 
js
suse labs


