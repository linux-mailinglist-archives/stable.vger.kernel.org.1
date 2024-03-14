Return-Path: <stable+bounces-28118-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 052C887B8F2
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 08:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4D0928A782
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 07:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CE55CDE7;
	Thu, 14 Mar 2024 07:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AjCT7cKb"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7AC5CDDA
	for <stable@vger.kernel.org>; Thu, 14 Mar 2024 07:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710402830; cv=none; b=cltxCgF9a36S4bFoOI7XzXWD6BnKgsevRe2spxhAvcy7YS3IkErHPVEafJz5RUwa0/eJNRLnHE2bGx14RvzniqQWP1UIKxmD7tSyNCPDNfz1hhbTcNPHMbQNLA4FuEjT6vKlk+6M8zfEBkDHRx+7PViMX0JGaq4cS0PaWOgmjEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710402830; c=relaxed/simple;
	bh=pwX6p+1yV2ReHGeDhBpSTG3PrWP4eW8DwCIEm9/DUTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ThfkJGM25YUhF1b9zu//A7CJC9gXEJPxVShAy4QjTAIaFJlk26P+2rOOo+oLo/d/XKGPie49F4hpgNe8lvsVXIW9ef6CPQoBPlfdvoEd4+xVJ07PMS8VrH1V7/+3he1h7TlyuWa0XBM8GqUeu3YbduxqPpWdOXcnud9R2I3OZds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AjCT7cKb; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33e9623c3a8so536683f8f.0
        for <stable@vger.kernel.org>; Thu, 14 Mar 2024 00:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1710402826; x=1711007626; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HIX2Il4Aa+k8DGAFpqbttw/bKdoZBGLQp2FUwNeGJqI=;
        b=AjCT7cKbUcjDuUZ+FiIDjBbYHTrNEDoWM6o1wnZCCLW3OQ7M0+glzuC/ntTkPpkEoc
         LUDXQ9wUg3Fl690xxZ1z1ycPLsT0DBpRT57DTMFgAkhcwa2W4snOXE42qRFQjcaShxO6
         MeuI3qbVZ/04JyKUn0VF4XvVXwFFjIQ5ftS9DX+y4y5q6p1J25PDTOP7YeDy5VeJhYpy
         x02ksXhptLtd6YusKYxC4+pn3HhS3fx6iRsviYBk4xybXMMePMjAwtO1WJ7tEdTnMezM
         3L1Z6D0EX4KYo4vVu5V+8u0H81BIRaMn/r8oXOqET8xxJUfqSPOwbFDeIfiFNjMNZLu2
         InzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710402826; x=1711007626;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HIX2Il4Aa+k8DGAFpqbttw/bKdoZBGLQp2FUwNeGJqI=;
        b=nuFMUEYz3k9TZYggkagvZUzWV9cIi69YEFBAJM/G/AWDVd5v88d/PsHaEuiIL4xTa4
         vNZ+AvaMfRLtFWvWgSMZ7bjrBoswSuYaGaTm5cENfhtmNadqyKzJlAOZnv6C+6E0NuCu
         tJxLIzwFuNggbGLh+1Qh/ZWUzd1v0kKQ0CrQ+vBZqbO/vdWT775UVL3bNFVxHW7KBYLm
         OPvB5GKwH8zQDIjgFqbHS1vH6iN5SLtPpA++D6dzpvg4w8sLQ4O/QVAXUrBgl3VJN4Bw
         4AdDGs32f0nVAJS+ShEle/in2zseWDkLhTTWVcAEhOlDkT0m4SC5xQP5uPkev36cyp6J
         +cKw==
X-Forwarded-Encrypted: i=1; AJvYcCVvFHlukzJoLq4AdnTWnAN+1szZ1HYbsfqhYGk8wadATeIsA/YyJy328An7b7Da77O+/cHh4TvJystbsjDpp61ZxnXV5A4r
X-Gm-Message-State: AOJu0YzHcpsjBQr3zfcx6Iv3xjzqitUK1xpc79BJbR0PeO80/HfJ1bgU
	ozlcBLXwtNXDLHnNr7efxpJmumkQx1sRQoWMEO+GScruBdmy6ByFyE+WG+2Ns7g=
X-Google-Smtp-Source: AGHT+IF8R2Rp90nS9THsoB9F645oT3p8ZKEzu6hDCmaav/ZfN7svDd51pgTD+WfEph8Bcz3RkqzNDg==
X-Received: by 2002:a05:6000:1965:b0:33e:76f1:3e3d with SMTP id da5-20020a056000196500b0033e76f13e3dmr684747wrb.51.1710402826202;
        Thu, 14 Mar 2024 00:53:46 -0700 (PDT)
Received: from ?IPV6:2001:a61:1366:6801:7ce4:a9a1:7f22:a638? ([2001:a61:1366:6801:7ce4:a9a1:7f22:a638])
        by smtp.gmail.com with ESMTPSA id co15-20020a0560000a0f00b0033e99b7cfa8sm113210wrb.13.2024.03.14.00.53.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 00:53:46 -0700 (PDT)
Message-ID: <2233fe16-ca3e-4a5e-bc69-a2447ddd2e82@suse.com>
Date: Thu, 14 Mar 2024 08:53:45 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] usb: f_mass_storage: reduce chance to queue disable ep
To: yuan linyu <yuanlinyu@hihonor.com>, Alan Stern
 <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, stable@vger.kernel.org
References: <20240314065949.2627778-1-yuanlinyu@hihonor.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20240314065949.2627778-1-yuanlinyu@hihonor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I am sorry, but this contains a major issue.

On 14.03.24 07:59, yuan linyu wrote:
> It is possible trigger below warning message from mass storage function,
> 
> ------------[ cut here ]------------
> WARNING: CPU: 6 PID: 3839 at drivers/usb/gadget/udc/core.c:294 usb_ep_queue+0x7c/0x104
> CPU: 6 PID: 3839 Comm: file-storage Tainted: G S      WC O       6.1.25-android14-11-g354e2a7e7cd9 #1
> pstate: 22400005 (nzCv daif +PAN -UAO +TCO -DIT -SSBS BTYPE=--)
> pc : usb_ep_queue+0x7c/0x104
> lr : fsg_main_thread+0x494/0x1b3c
> 
> Root cause is mass storage function try to queue request from main thread,
> but other thread may already disable ep when function disable.
> 
> As mass storage function have record of ep enable/disable state, let's
> add the state check before queue request to UDC, it maybe avoid warning.
> 
> Also use common lock to protect ep state which avoid race between main
> thread and function disable.
> 
> Cc: <stable@vger.kernel.org> # 6.1
> Signed-off-by: yuan linyu <yuanlinyu@hihonor.com>
Nacked-by: Oliver Neukum <oneukum@suse.com>

> ---
>   drivers/usb/gadget/function/f_mass_storage.c | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
> index c265a1f62fc1..056083cb68cb 100644
> --- a/drivers/usb/gadget/function/f_mass_storage.c
> +++ b/drivers/usb/gadget/function/f_mass_storage.c
> @@ -520,12 +520,25 @@ static int fsg_setup(struct usb_function *f,
>   static int start_transfer(struct fsg_dev *fsg, struct usb_ep *ep,
>   			   struct usb_request *req)
>   {
> +	unsigned long flags;
>   	int	rc;
>   
> -	if (ep == fsg->bulk_in)
> +	spin_lock_irqsave(&fsg->common->lock, flags);

Taking a spinlock.

> +	if (ep == fsg->bulk_in) {
> +		if (!fsg->bulk_in_enabled) {
> +			spin_unlock_irqrestore(&fsg->common->lock, flags);
> +			return -ESHUTDOWN;
> +		}
>   		dump_msg(fsg, "bulk-in", req->buf, req->length);
> +	} else {
> +		if (!fsg->bulk_out_enabled) {
> +			spin_unlock_irqrestore(&fsg->common->lock, flags);
> +			return -ESHUTDOWN;
> +		}
> +	}
>   
>   	rc = usb_ep_queue(ep, req, GFP_KERNEL);

This can sleep.

> +	spin_unlock_irqrestore(&fsg->common->lock, flags);

Giving up the lock.


Sorry, now for the longer explanation. You'd introduce a deadlock.
You just cannot sleep with a spinlock held. It seems to me that
if you want to do this cleanly, you need to revisit the locking
to use locks you can sleep under.

	HTH
		Oliver

