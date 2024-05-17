Return-Path: <stable+bounces-45358-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 407CE8C8059
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 06:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC5A8B21AA6
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 04:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13231C15D;
	Fri, 17 May 2024 04:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schmorgal.com header.i=@schmorgal.com header.b="GA6z9qSQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F06BA29
	for <stable@vger.kernel.org>; Fri, 17 May 2024 04:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715919743; cv=none; b=GkfMX3GZah2+wFcNgelgMdvuynczCMN8Q6oAWg5p3LR7QCUzHTHza3n8FT9TxnUBaRmVU6VraDbH9clKbYzbY5OjoKAkACXZ04Fl4B0dI95nQmciG3lernEIf9uMkiXBUQxwEPLYry0v+oeANpmgXPP1Hvo5JpLnpzNt12XoLf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715919743; c=relaxed/simple;
	bh=clGt/NkziH5Rht90QTXQDeCp0nC6Z0KNWcrwIzDDtuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MJAuTneqRRZLJuLqev9O7YVUapduF84tr5vVE/U+9urbbaGHj10GhoL7FR+QKI+OLSBGuckq1LnYggIIsiwiamx1Ex4nOwnfLr1/3O6C80zy2JBC0qtsneeHonxmj//G+OKySF3vomq2dQe+jqdumh9BELbIjqgi+WXttQdpHOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schmorgal.com; spf=pass smtp.mailfrom=schmorgal.com; dkim=pass (1024-bit key) header.d=schmorgal.com header.i=@schmorgal.com header.b=GA6z9qSQ; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schmorgal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schmorgal.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2b6215bcd03so199929a91.1
        for <stable@vger.kernel.org>; Thu, 16 May 2024 21:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google; t=1715919741; x=1716524541; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ynFbEUJKTr0niWu5r21fVbQhgmdmrbtHlCRTbOdhFU=;
        b=GA6z9qSQPJDcmdam+ps9+CMSVfrFfdCpNFc9VARe7olccSEpd+b8us/HTiwxMuc6Kx
         I+2sBzZAF+iuEYgHDX9QL9Qo2zVdBmzSQtJDGnLP1p66VRI2PpuuY7InzA7NA39rBv0L
         jbXudm+ALzLLYE2e60B/RFDtjHz3G4KgHBQmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715919741; x=1716524541;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ynFbEUJKTr0niWu5r21fVbQhgmdmrbtHlCRTbOdhFU=;
        b=H55ovh/zenPuHQrWZlVrCz7WJWmwktFnMFfZWgbotdb25CCC93gpEXWwRCEh3glIGs
         mY6HtiU/ONvMPwBH3RDu2ACo71EE9feHzM3FK7Th/rrYI6VScw4xwq47KPKflwNfYOVD
         chnFbXdJSbN6f9D5AgP39aHLx4/UF208RJsU20A6VlZb2/vykkWC6r+6oKq61b3vuKlT
         XoemIgQm4M30UyoBi77m63T3SbGkKtm+q7SASry7+jByxSb249hY4jCHbERMPDi+r3sA
         8rZKXC92MywFww13rCLc+oGJTsCe/nQLcie2GOq7ZcVBMWlNxX+/qkPxkIwVNK1jEt3N
         WOqg==
X-Forwarded-Encrypted: i=1; AJvYcCVHiU8USzeOQ81OsfhNyY7LXNV6H9XvukQ6TzDLiH1pcsrXTYanfbovXdlxCAGbS/tDW4cfIjKtJrJSode/vS4j+XEiFX57
X-Gm-Message-State: AOJu0Ywn8zvDiHIzWBsE7LPfGh8xL0ZO7ML+PxrrnLOg1JIBPUvfHP63
	GBn172gIX1iQFN5e+NRufcpRcc+HMrqw57rWB0pMUkXJtkWOKIRvsIIOe2ExnRc=
X-Google-Smtp-Source: AGHT+IH70wGfsC60Qwjp2RdHj3AWLhfWm5tjfABx/+v3IJ5TudDw/SRpqup28pLDE6y4mzVIyJLn1g==
X-Received: by 2002:a17:902:da8f:b0:1eb:2e59:d6a with SMTP id d9443c01a7336-1ef44049772mr239109195ad.3.1715919739290;
        Thu, 16 May 2024 21:22:19 -0700 (PDT)
Received: from [192.168.1.33] ([50.37.206.39])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1ef0b9d4278sm151112155ad.12.2024.05.16.21.22.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 21:22:18 -0700 (PDT)
Message-ID: <77b71bd9-42be-40e8-8b96-196e214c8afb@schmorgal.com>
Date: Thu, 16 May 2024 21:22:17 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] serial: core: only stop transmit when HW fifo is empty
To: Jonas Gorski <jonas.gorski@gmail.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>, stable@vger.kernel.org
References: <20240303150807.68117-1-jonas.gorski@gmail.com>
Content-Language: en-US
From: Doug Brown <doug@schmorgal.com>
In-Reply-To: <20240303150807.68117-1-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 3/3/2024 7:08 AM, Jonas Gorski wrote:
> If the circular buffer is empty, it just means we fit all characters to
> send into the HW fifo, but not that the hardware finished transmitting
> them.
> 
> So if we immediately call stop_tx() after that, this may abort any
> pending characters in the HW fifo, and cause dropped characters on the
> console.
> 
> Fix this by only stopping tx when the tx HW fifo is actually empty.
> 
> Fixes: 8275b48b2780 ("tty: serial: introduce transmit helpers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> ---
> (this is v2 of the bcm63xx-uart fix attempt)
> 
> v1 -> v2
> * replace workaround with fix for core issue
> * add Cc: for stable
> 
> I'm somewhat confident this is the core issue causing the broken output
> with bcm63xx-uart, and there is no actual need for the UART_TX_NOSTOP.
> 
> I wouldn't be surprised if this also fixes mxs-uart for which
> UART_TX_NOSTOP was introduced.
> 
> If it does, there is no need for the flag anymore.
>   include/linux/serial_core.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index 55b1f3ba48ac..bb0f2d4ac62f 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -786,7 +786,8 @@ enum UART_TX_FLAGS {
>   	if (pending < WAKEUP_CHARS) {					      \
>   		uart_write_wakeup(__port);				      \
>   									      \
> -		if (!((flags) & UART_TX_NOSTOP) && pending == 0)	      \
> +		if (!((flags) & UART_TX_NOSTOP) && pending == 0 &&	      \
> +		    __port->ops->tx_empty(__port))			      \
>   			__port->ops->stop_tx(__port);			      \
>   	}								      \
>   									      \

I just upgraded to kernel 6.9 and discovered through a git bisect that
this patch (7bfb915a597a301abb892f620fe5c283a9fdbd77) causes a problem
with the legacy pxa.c serial driver (CONFIG_SERIAL_PXA_NON8250). I'm
using it with a PXA168-based ARM device for a serial console as well as
getty. With this patch applied, transmissions get hung up before they
finish. The data isn't lost, because the next time a transmit occurs,
the delayed data finally goes out -- but something seems to be causing
it to get stuck right at the end of many, but not all, transmissions.
For example, if I type "ps" and hit enter, nothing shows up until I hit
enter again, which finally kickstarts the whole TX process and then I
get all of the queued ps output.

I'm really confused about this symptom because it seems at face value
like this patch would only ever improve the situation by preventing
stop_tx() from being called too early. There's something about the pxa
driver that is happier when stop_tx() is called with an empty buffer
even if the UART is reporting that it's not empty yet. I tested some
other random systems in qemu and couldn't reproduce this issue, so the
problem may very well be limited just to this driver/hardware...

I realize this driver is old and deprecated (I'm likely one of the few
users left of it) so I'm hesitant to call it a regression. Maybe it's
really a bug in this driver that the new patch exposes? I even thought,
"heck, I should probably be using the newer 8250_pxa driver instead",
but that one is even worse -- it drops TX characters like crazy,
regardless of whether this patch is applied. I want to look into that
problem eventually.

I'm hoping there is some kind of simple fix that can be made to the pxa
driver to work around it with this new behavior. Can anyone think of a
reason that this driver would not like this change? It seems
counterintuitive to me -- the patch makes perfect sense.

Thanks,
Doug

