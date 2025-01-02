Return-Path: <stable+bounces-106656-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 951679FFB7F
	for <lists+stable@lfdr.de>; Thu,  2 Jan 2025 17:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34CB77A10D8
	for <lists+stable@lfdr.de>; Thu,  2 Jan 2025 16:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC387EF09;
	Thu,  2 Jan 2025 16:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="UcpVOSZk"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0856C374CB
	for <stable@vger.kernel.org>; Thu,  2 Jan 2025 16:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735834929; cv=none; b=Q2uQafrFl+QrK6cBc3ULKWduaVsmQMn/4SORmm415l0Bwyo5JINgJr1HOfhbCY0IgoUgIDDUKjOP9bIbaKudbiuQmjFZXbUn36WhkJuHevjA413mBFuvrcv/RI+I8pXhMGY+wrwmrUN1vtK8E4smIQkB6KXchchO7geItLjjWlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735834929; c=relaxed/simple;
	bh=8QPh+jIeQ0IBkfPRTmkE6+dC5nRC/Q8ErvJ33oHBX54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T2fLg7a2F4FlUkKtpwbj571Qo4GFLywTONyfPLdsjVqNz8C2FgLl1H6rqx6kAkzvgOZMSHUEVtum6WWJfFE1N/KfMlX1emZMHS9D2AmgXncIKzON1tmJsomglZUh3pPAgpMHDsL8cbLHmvN0CLgfdbp07mV7Nva7IdBejG63PQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=UcpVOSZk; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b6e8fe401eso958742085a.2
        for <stable@vger.kernel.org>; Thu, 02 Jan 2025 08:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1735834925; x=1736439725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tWHzBldpxbOCgZcOrvwHEBYJhcR2y22SwrCIPpcGRuw=;
        b=UcpVOSZkq+zG2pOcO27U+vUWEJuQxFJ5wFgQ91sAi0uadKNcQLQs40p1pqlTxN0pfC
         AIHrPU+arjqHTq5wPwwBX2ngiGpoxD3zoCa+JHQi5PoYDGIZ9B3T9HmPrC5XOZ+fi5ul
         QL12FRez0cQ60ljg/R3rHeeTz+ojMNb2F6juokPPT/yXs+esD3bXQkW+Ssa9Mn3P2/0A
         u2IrVrVoY+ZSDE9Vmxf5nMN7/bfhxZYKmWU4Xq6Ms7PkK6DSBa+FYydu5nG4rJo/XjoO
         Z7hM0sijq+V3qgg5OdiLSmXhq8HErDchyenTl/Wqy5mQ62HVzDJVAqPeZub3PmmM07hq
         zVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735834925; x=1736439725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tWHzBldpxbOCgZcOrvwHEBYJhcR2y22SwrCIPpcGRuw=;
        b=JT6WTYd+5gHX4VWJvKj2MUSyPrVcuakuNmjRhPFqSomUMssQUlhD48tn22zRoVHtF2
         YdesWbg6HOeXbbHG0w8c+fHcBDab3NSZdtvszcefoXKALTj1e1E+5BHL2/jmuyP390Im
         hiJwXhtJGxi7lbESLPvDCViLJXrfmH+mgDbnnYiDd0XEBnKvBtW2IJ69jK64CTy9ocyr
         io86Jo5T2aYkf6EAKCMoTDSRW3gVigy+G1f75ny/uc3+f+c1oE3iONEhGH0InggXTjFL
         BcKtRyZwlPD4wtHgehI1LTyVdHiULwsOvuWTBqUZbtsoTmhQkexzSDiq+ytZcum3Lqgf
         xoAw==
X-Forwarded-Encrypted: i=1; AJvYcCWVKTzkEx98kfpGACaawFXyedqh5bP3g90ucAfp6dcWvHdXHCAyGWVtNibV7DRmxQAFuzp/KqE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7zeHXAi/WsrdByffNhehLMhnp5R/9dkTuakUFI0ZTFsI5d/Yi
	iPmfZrptFqr1mtkV3gLDH/nVbYwCx9EmeuyNLTciDWjgFSnXU6A1xBQYZXIW7Q==
X-Gm-Gg: ASbGnctUmNtg+cs5eAct4hgndh6WIzLJLzx8hVYpzjxkN12CjdxGxjdFTO+UhtMEmnH
	P94h09uI7bWzRX8cJvsbeG7fk5KJwXHX1gYM3HRbzD0pCN4gHPzeGNyksJkvbexN6nlhfrbwzs/
	TyvCpvjQHl81xQ+qPLkBy7h5zSt7NLXO8Oxuk3e7XlSzV2+U3ejjhTaoHzkWlFaRPIcLdvjRtIc
	iE985cSGtCFTEA/KOQvaqmxLBwvDNS0X2EBykX1wlJu2sl5bir2HVcE8Q==
X-Google-Smtp-Source: AGHT+IGPeGlZhs3SZmzzPtxXieDoyxFut2a12WvTgbTRURZs2CA1LHQkvRcJOBxQaRRNLu4q/S33lQ==
X-Received: by 2002:a05:620a:2911:b0:7b6:d870:ca2d with SMTP id af79cd13be357-7b9ba716910mr8209001685a.13.1735834924825;
        Thu, 02 Jan 2025 08:22:04 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::5653])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac4eef11sm1193928885a.126.2025.01.02.08.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 08:22:04 -0800 (PST)
Date: Thu, 2 Jan 2025 11:22:00 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Lubomir Rintel <lrintel@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
	Lubomir Rintel <lkundrak@v3.sk>, stable@vger.kernel.org
Subject: Re: [PATCH] usb-storage: Add max sectors quirk for Nokia 208
Message-ID: <729d6c93-a794-4102-a191-494bf86df219@rowland.harvard.edu>
References: <20250101212206.2386207-1-lkundrak@v3.sk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250101212206.2386207-1-lkundrak@v3.sk>

On Wed, Jan 01, 2025 at 10:22:06PM +0100, Lubomir Rintel wrote:
> This fixes data corruption when accessing the internal SD card in mass
> storage mode.
> 
> I am actually not too sure why. I didn't figure a straightforward way to
> reproduce the issue, but i seem to get garbage when issuing a lot (over 50)
> of large reads (over 120 sectors) are done in a quick succession. That is,
> time seems to matter here -- larger reads are fine if they are done with
> some delay between them.
> 
> But I'm not great at understanding this sort of things, so I'll assume
> the issue other, smarter, folks were seeing with similar phones is the
> same problem and I'll just put my quirk next to theirs.
> 
> The "Software details" screen on the phone is as follows:
> 
>   V 04.06
>   07-08-13
>   RM-849
>   (c) Nokia
> 
> TL;DR version of the device descriptor:
> 
>   idVendor           0x0421 Nokia Mobile Phones
>   idProduct          0x06c2
>   bcdDevice            4.06
>   iManufacturer           1 Nokia
>   iProduct                2 Nokia 208
> 
> The patch assumes older firmwares are broken too (I'm unable to test, but
> no biggie if they aren't I guess), and I have no idea if newer firmware
> exists.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Cc: <stable@vger.kernel.org>
> ---

Hmmm, maybe we should automatically set this flag for all Nokia devices.  
In any case,

Acked-by: Alan Stern <stern@rowland.harvard.edu>

However, Greg's patch bot is going to ask why you didn't include a 
Fixes: tag.

>  drivers/usb/storage/unusual_devs.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unusual_devs.h
> index e5ad23d86833..54f0b1c83317 100644
> --- a/drivers/usb/storage/unusual_devs.h
> +++ b/drivers/usb/storage/unusual_devs.h
> @@ -255,6 +255,13 @@ UNUSUAL_DEV(  0x0421, 0x06aa, 0x1110, 0x1110,
>  		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
>  		US_FL_MAX_SECTORS_64 ),
>  
> +/* Added by Lubomir Rintel <lkundrak@v3.sk>, a very fine chap */
> +UNUSUAL_DEV(  0x0421, 0x06c2, 0x0000, 0x0406,
> +		"Nokia",
> +		"Nokia 208",
> +		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
> +		US_FL_MAX_SECTORS_64 ),
> +
>  #ifdef NO_SDDR09
>  UNUSUAL_DEV(  0x0436, 0x0005, 0x0100, 0x0100,
>  		"Microtech",
> -- 
> 2.47.1
> 

