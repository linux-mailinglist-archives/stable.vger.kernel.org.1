Return-Path: <stable+bounces-179707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11719B59246
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 11:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C37A1B26A0C
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 09:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37F0298CB7;
	Tue, 16 Sep 2025 09:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="SBZw21VL"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFA927A92A
	for <stable@vger.kernel.org>; Tue, 16 Sep 2025 09:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758015117; cv=none; b=J6r/Ez/R4c60Kjq/5X2r1XkDi5xfN+sCqc4M8H8iGvXBMoYA6GFm5nOXooiLjMmWLvz3/TkFgasNAiIjawteNxF3XqJrxiKgvkzPYpNt2V4wBaAm/c5EWlNoqFViFwVrbx2Jjr6cUT2+FLQ+Jhdp4GPXhFLcRSlRTIDRUm4exXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758015117; c=relaxed/simple;
	bh=8sz61mLEvjrXfCAZ4z12hQwuKH6MxnxHrlSM3B3tYmU=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hnpoQRPVPCYWyui4nmSPPQ5slnqMyQPdwX2Wwdn6Xx1UunzxzYqMBHVB0Yw+8U9DwT0qjXCyTL6k5bwWX8IGK2yS2x/CO4I+gPwl+cWB4n9ZPloivHcVqy+AV1pKnfeprKl+SaST6mRvk0rgbo2oZs7qbCb5aF+Ag5yYvZldH1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=SBZw21VL; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3515a0bca13so40817751fa.1
        for <stable@vger.kernel.org>; Tue, 16 Sep 2025 02:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1758015114; x=1758619914; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=x/lctxuNWme1oYIyzwhBp3Keh1SGEGdouUS1YUPFg/U=;
        b=SBZw21VLwKUzx6WUL6IpO0oP3Sc9FVLYYi/j/K8UVUfEweZwACUNOoDhURejyybSDm
         cvWanCsG01Gps2EEkiCbb7R5EW2q4mMBLWGJYtqx1fjom5yjrExuKBbDHBMCW5DSsheg
         L5m/k+diL5KSddmY4AharrK5o0uCNgxuIZfE7xlSP3BKFuIN9m/2KzjyN/Ewa15NsP2I
         Gh1XIKXnQkOqeji4PBYmQQiFpcCOai1vUS3eJPbYMdAHPywCpPHV42N8g0GgQ+e9HKr4
         MaeT2L5Vi8RyM8ib9LrHPBaRZbRfxT1DAF9cuM1djfwvdGHWQ7iAJHufQMUDIzSKDc55
         tOHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758015114; x=1758619914;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x/lctxuNWme1oYIyzwhBp3Keh1SGEGdouUS1YUPFg/U=;
        b=qcjNECqAton2sAEoHvESfiXAuSwF58szTI5UbcSIZU9+EO2ZcieEA+y2PE9QGinjy5
         dE/NA9gm/BlLW0E5uzH2p/K9B8jkjWZNVsItRvs3c6QZ8kYuSxDDbojFCS9MSyu+38qJ
         t9lJ7u+1gFXJYws01N4j7S6h8CXoKjhvUzQSX8wCKP4SIcMTN2REF8OU5o4IUTV54NW/
         IPvb7qcv0naPCacjCmNal0jqaa0cSu9Gx3qd4Zrs+GFjloVJgu4i39UQTOtK5itx1t7D
         PLoaAQiMQS+w3WOHrJLCCJ/pFkcsfqiiH8H0dss1kGRL/dNdn68ujOGO4eiW4nBPTO4l
         gzxA==
X-Forwarded-Encrypted: i=1; AJvYcCWrhdg6rGF417LcqYQ+ShrdFUvCt/gR7rjNJfNSlts+u7KW4mrrYKhmfaguipj8oJiRjYdKBiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQNEo0U7xqF5QS6NQdKTeSMA8Y0IeMl+sqyf024Q8gkw9TRVOd
	6JQS4l3FJfq7+b5OMPZjbl8hC37QJOFun8bsk3IjVNfQ0VmnDK3MOIlgxnB25XnRVaqq07t5bdw
	Zf0DeHxHef+OISUfSbC7L+p+rRKj2LOwrRhRslcMb4g==
X-Gm-Gg: ASbGnctUuu3BdkOOiZKn3iz5UL+MbURso3yG3lEuIfrJL1JG0uyBeSp8DsvvPuAUAxi
	AOOemPsLdRqbmtKvdqiV2ftNMn8e47zrQH1ocHg8kyasH3ysuENuHjdtsk2e2ZiUPFQr0f4E1hh
	hFtFdx+q4J4GUqTsQ2oXVX9b5CT67ouPr1Y4D2wf1ebhKrVhLvDScfcyxb74Af03Q65TUlCZnUv
	FnCwnw=
X-Google-Smtp-Source: AGHT+IHZfQVeoLR8llVJaYYhfYlryPF5U2/OFVzCvZ/pSdIx3ZH0Dj1ql3FC1c3kqWJB8oDnlbr6nCOAoFKFvfn4iSQ=
X-Received: by 2002:a2e:a4d5:0:b0:359:1a9:ae62 with SMTP id
 38308e7fff4ca-35cc247c648mr3918191fa.9.1758015113578; Tue, 16 Sep 2025
 02:31:53 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Sep 2025 02:31:51 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Sep 2025 02:31:51 -0700
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <f6c18910-d870-4fa7-8035-abc8700aef2b@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913184309.81881-1-hansg@kernel.org> <kpoek6bs3rea4fl6b4h55grmsykw2zw2j6kohu3aijlabjngyc@7fbnoon3ilhw>
 <f6c18910-d870-4fa7-8035-abc8700aef2b@kernel.org>
Date: Tue, 16 Sep 2025 02:31:51 -0700
X-Gm-Features: AS18NWC7EbpzQevKHetqb6Kzf6jXQ7pBpodbyNM3-GmzjG12YE_UYgUjCuzOD_4
Message-ID: <CAMRc=MdrAwTNnE=n6-6o+F6=q=djdY9Mf3qgzYxj4u65xDOvNQ@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: Extend software-node support to support
 secondary software-nodes
To: Hans de Goede <hansg@kernel.org>
Cc: Mika Westerberg <westeri@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	stable@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Sep 2025 19:49:16 +0200, Hans de Goede <hansg@kernel.org> said:
> Hi,
>
> On 15-Sep-25 3:21 AM, Dmitry Torokhov wrote:
>> Hi Hans,
>>
>> On Sat, Sep 13, 2025 at 08:43:09PM +0200, Hans de Goede wrote:
>>> When a software-node gets added to a device which already has another
>>> fwnode as primary node it will become the secondary fwnode for that
>>> device.
>>>
>>> Currently if a software-node with GPIO properties ends up as the secondary
>>> fwnode then gpiod_find_by_fwnode() will fail to find the GPIOs.
>>>
>>> Add a check to gpiod_find_by_fwnode() to try a software-node lookup on
>>> the secondary fwnode if the GPIO was not found in the primary fwnode.
>>
>> Thanks for catching this. I think it would be better if we added
>> handling of the secondary node to gpiod_find_and_request(). This way the
>> fallback will work for all kind of combinations, even if secondary node
>> happens to be an OF or ACPI one.
>
> IOW something like this:
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index b619fea498c8..1a3b5ca00554 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -4630,6 +4630,13 @@ struct gpio_desc *gpiod_find_and_request(struct device *consumer,
>  	scoped_guard(srcu, &gpio_devices_srcu) {
>  		desc = gpiod_find_by_fwnode(fwnode, consumer, con_id, idx,
>  					    &flags, &lookupflags);
> +
> +		if (gpiod_not_found(desc) && fwnode) {
> +			dev_dbg(consumer, "trying secondary fwnode for GPIO lookup\n");
> +			desc = gpiod_find_by_fwnode(fwnode->secondary, consumer,
> +						    con_id, idx, &flags, &lookupflags);
> +		}
> +
>  		if (gpiod_not_found(desc) && platform_lookup_allowed) {
>  			/*
>  			 * Either we are not using DT or ACPI, or their lookup
>
> That should work too, but if there is an OF or ACPI node it should always
> be the primary one. So my original patch id fine as is.
>
> Either way works for me. If you prefer the above approach instead of my
> original patch let me know and I'll give it a test-run and then post a v2.
>

I'm fine either way but if you go with the above (looks like it's the
consensus) then please wrap it in its own helper, possibly called something
like gpiod_fwnode_lookup() and put this primary-secondary logic in there to
move it out of gpiod_find_and_request().

Bartosz

