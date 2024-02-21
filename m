Return-Path: <stable+bounces-23220-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 044CB85E553
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 19:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6090D1F23475
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 18:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3232D85270;
	Wed, 21 Feb 2024 18:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A5bSu343"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D1B85265
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 18:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539365; cv=none; b=HMsx5azQDcTKKtD4n7vBPoOgrqlOYFgFwWEZIy++f4M0/sCpbKhoca1C/mQAWqAPXD9+6UopyC5TO4KRA3TuafX06xcq5XYO0MOD3y0GABBK/7ljKS3YDLySgxUExCE2zWTwZAKtqpC2WeTExYx24ZVT3jBkcWysRzDknY26NLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539365; c=relaxed/simple;
	bh=aaVj+7+xcUJ0TAvfKQmReKsq542AIgczhjpa+od3Ivw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=leSC0FX3Bhic2i5jMGV2rGmucpOgoC9ffB7qyaLc2jvafdsDrycjGER4hg2OiWgGYiXy3cX+C4BN3w6I69FT2M7wrSihjv1gzPrv/lLZG2oyT75lPPhYzPlHCYMzeGDapEz3ceKBG+Y6fmRsW5D27iTZqG3kjLpBIdch9Nf6wfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A5bSu343; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708539362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aIgwniDVwi1Yc8NbtGih2FZGklnZfTaCbp1/IK9Qqik=;
	b=A5bSu343bfftgzOsrHMmadAu+pR9aiagJs21QFAX2t5X5lYGkU3Nzc1LKG/fPm8Tp41mRA
	MBvdOGp+xdNRBz1IF0xfUl4z/Dm5EC1IAZ5WkvHMQzlsPm9Byp++ytfipt1xTx/NcmXcfZ
	ovR2np2ikrVLVy18/gbTZJ9zotbDlos=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-TCtzvc40N32UI9uNHXsHmg-1; Wed, 21 Feb 2024 13:15:58 -0500
X-MC-Unique: TCtzvc40N32UI9uNHXsHmg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a2b6c2a5fddso462947966b.1
        for <stable@vger.kernel.org>; Wed, 21 Feb 2024 10:15:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708539357; x=1709144157;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aIgwniDVwi1Yc8NbtGih2FZGklnZfTaCbp1/IK9Qqik=;
        b=l+mMhUKQH2qDdZesAW/xZmtsZQzESDmsu+PWUvWpg1+F/TosSHfub/HmSRt3gJ3hVE
         rt7Pb95ugQLri/xLecqOWBda7x2kFJTRUIcEO2lyw9dkc5QOeCJzAP6w2jkDvrVUVMDR
         sKeZc+61T8/4u/qu88fL8+H8KvSoh2EyaBS2qoYH09WuEuM67vVOp3R1K9mTt4aqifrs
         t9ghLWc88/w+tDNxmS6W/cM5O1JrTT0hNAi4TPP1WVwyL3NMm+nQlftKLM3kKrcYxsTs
         bem8ufPquI53elpAsG6fr6rm0UsunA8fSs4kzix9pALUomjMJpiCKmzm7ZI9TpCDPVU3
         CKpA==
X-Forwarded-Encrypted: i=1; AJvYcCXwd8EmYpqK1Df9UU7/ME/u/8XHVhvOWKai0LZtz0qYIvHFXN0XTxAWydSyUj1/z9LL5w2eipmVqZP+zXT3a1qU/hx5ewC2
X-Gm-Message-State: AOJu0YxDwskCtlsF7ZQpMe9dBCSCWlKxVGOkmPuxwApkA2u5A6/VoHWh
	W6RgtXqBHikEq8/xKOj/UN2H4RhRw4q3hFgeUFSUWVffr29hTEmkejgHN5hC+lyXTOLgBs/PUgi
	m5ndo8z9lb0ccqFMXxIz96ZeKLOykf4ceUROs9o0rF22wqChsigo63mgCxyrgDQ==
X-Received: by 2002:a17:906:7c92:b0:a3f:357b:d98f with SMTP id w18-20020a1709067c9200b00a3f357bd98fmr1969958ejo.15.1708539357532;
        Wed, 21 Feb 2024 10:15:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHuH6grTG4y8T2kFIfCnDQrx/fkFGCMrWQiDqoxqB7nI9P0ezkXpHigx1S3szqLYPLjgCzvYw==
X-Received: by 2002:a17:906:7c92:b0:a3f:357b:d98f with SMTP id w18-20020a1709067c9200b00a3f357bd98fmr1969946ejo.15.1708539357233;
        Wed, 21 Feb 2024 10:15:57 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id k9-20020a1709063fc900b00a3cfd838f32sm5247099ejj.178.2024.02.21.10.15.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 10:15:56 -0800 (PST)
Message-ID: <5c172ec4-c3ec-4daf-95de-79b27351502e@redhat.com>
Date: Wed, 21 Feb 2024 19:15:56 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 258/476] misc: lis3lv02d_i2c: Add missing setting of
 the reg_ctrl callback
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Sasha Levin <sashal@kernel.org>
References: <20240221130007.738356493@linuxfoundation.org>
 <20240221130017.380309277@linuxfoundation.org>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240221130017.380309277@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Greg,

On 2/21/24 14:05, Greg Kroah-Hartman wrote:
> 5.15-stable review patch.  If anyone has any objections, please let me know.

This is known to cause a regression (WARN triggering on suspend,
possible panic if panic-on-warn is set).

A fix for the regression is pending:

https://lore.kernel.org/regressions/20240220190035.53402-1-hdegoede@redhat.com/T/#u

but it has not been merged yet, so please hold of on merging this 
patch until you can apply both at once.

I see that you are also planning to apply this to other stable
branches. I'm not sure if this is necessary but to be safe
I'll copy and paste this reply to the emails for the other stable
branches.

Regards,

Hans




> 
> ------------------
> 
> From: Hans de Goede <hdegoede@redhat.com>
> 
> [ Upstream commit b1b9f7a494400c0c39f8cd83de3aaa6111c55087 ]
> 
> The lis3lv02d_i2c driver was missing a line to set the lis3_dev's
> reg_ctrl callback.
> 
> lis3_reg_ctrl(on) is called from the init callback, but due to
> the missing reg_ctrl callback the regulators where never turned off
> again leading to the following oops/backtrace when detaching the driver:
> 
> [   82.313527] ------------[ cut here ]------------
> [   82.313546] WARNING: CPU: 1 PID: 1724 at drivers/regulator/core.c:2396 _regulator_put+0x219/0x230
> ...
> [   82.313695] RIP: 0010:_regulator_put+0x219/0x230
> ...
> [   82.314767] Call Trace:
> [   82.314770]  <TASK>
> [   82.314772]  ? _regulator_put+0x219/0x230
> [   82.314777]  ? __warn+0x81/0x170
> [   82.314784]  ? _regulator_put+0x219/0x230
> [   82.314791]  ? report_bug+0x18d/0x1c0
> [   82.314801]  ? handle_bug+0x3c/0x80
> [   82.314806]  ? exc_invalid_op+0x13/0x60
> [   82.314812]  ? asm_exc_invalid_op+0x16/0x20
> [   82.314845]  ? _regulator_put+0x219/0x230
> [   82.314857]  regulator_bulk_free+0x39/0x60
> [   82.314865]  i2c_device_remove+0x22/0xb0
> 
> Add the missing setting of the callback so that the regulators
> properly get turned off again when not used.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Link: https://lore.kernel.org/r/20231224183402.95640-1-hdegoede@redhat.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/misc/lis3lv02d/lis3lv02d_i2c.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/misc/lis3lv02d/lis3lv02d_i2c.c b/drivers/misc/lis3lv02d/lis3lv02d_i2c.c
> index 52555d2e824b..ab1db760ba4e 100644
> --- a/drivers/misc/lis3lv02d/lis3lv02d_i2c.c
> +++ b/drivers/misc/lis3lv02d/lis3lv02d_i2c.c
> @@ -151,6 +151,7 @@ static int lis3lv02d_i2c_probe(struct i2c_client *client,
>  	lis3_dev.init	  = lis3_i2c_init;
>  	lis3_dev.read	  = lis3_i2c_read;
>  	lis3_dev.write	  = lis3_i2c_write;
> +	lis3_dev.reg_ctrl = lis3_reg_ctrl;
>  	lis3_dev.irq	  = client->irq;
>  	lis3_dev.ac	  = lis3lv02d_axis_map;
>  	lis3_dev.pm_dev	  = &client->dev;


