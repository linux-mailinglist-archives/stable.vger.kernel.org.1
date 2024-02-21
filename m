Return-Path: <stable+bounces-23223-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC6485E55D
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 19:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72CF31C227AB
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 18:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A3242A8B;
	Wed, 21 Feb 2024 18:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eVO59425"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B538D8529B
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 18:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539410; cv=none; b=uAQ8TKt/POZIW1IlRit7CMQ6JopmvUzNi2bMhhy4fDqzPt+MB2rrgMws/bR5l70mQB62DWr4ColBz1fKHzf8oCOOeh0jqwQOwILWptKLWsCeJRFADXPLUYfe9X0rrwnPPkoaGEP3IBKA8pB0k4hcrJu599ywaeDdZX4QsBCFVmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539410; c=relaxed/simple;
	bh=/cidh8CN4VzTaklU4uttUClFrQiCgnt1mOisf1XiD7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bxYhOUvFxi2BRh/ckR9vJ8Abwdj8kNePGPX9ayg2w402tiBzTh3JYZWYKJqAsXWLqhC4VH/e5ca38MV/jA3HdzGiXuEKH2/d47Ie8mgiqzfYSyDzJjvrwj0zTHbiEJ6vPq3FBk80eRteUwxrNwhaCXmlgMOqCGlXAs8uSWHmQZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eVO59425; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708539407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7geH7zqTjsCuG6SWt2WbIl3Id3/C3wxgMjpQITyfqdg=;
	b=eVO59425psC6BpDJCX+eRoe+Gd4xdvCtm7dVhxwkC6z7XKRwTswdqW4QRatk00ssasdAOH
	oON7rUXKuQCYzinF81mNgmfqioTEX4cOttJ74dia9ePEe1ixkS0W9h5zAjB8Eq+xLGaXCi
	mvYoboNQNRyg0YFXM6/ixjtDkrK1bbQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-3wjfQ8nTO1KAxhRteB10bA-1; Wed, 21 Feb 2024 13:16:40 -0500
X-MC-Unique: 3wjfQ8nTO1KAxhRteB10bA-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-563ffb48a32so641842a12.2
        for <stable@vger.kernel.org>; Wed, 21 Feb 2024 10:16:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708539399; x=1709144199;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7geH7zqTjsCuG6SWt2WbIl3Id3/C3wxgMjpQITyfqdg=;
        b=VBwmfjcA5rkHV5on+CmVod7KyJCqz4isdH+TO0PhA0Wusbumz/MpdY+4D04VuGbXo0
         6caHqT1xKzPQNvHFwgAFpX86HZImujVGW4IryWPuQ9e46plu2bJT1LorYwhUY87yWpGs
         Guyeua1gv42LrKgSpHlfy8Y8HwVtGGHYG8Tyy0he++LKTJuL/SD5VRsHmpOvo0uDH3x4
         5hWsAfpGxE8PG85Vj+heSIrU5IFSGeOapUvUD7mDR9g1mNQ8atgvqSzXuXObU50fW5FT
         P5WjoZsOECQRXUiR5WcQSIxNEqONjcPnh/rIm9hgm+Hf6u7r5LyEpi2U19/NP5CVXAdy
         VjbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOZyR5PePXYiqoePfVfsT3K4osCEFzl/hFnEMdFBkA+GoLlAmloDQIMij9nSQ3bCJRy9NPd+paltJVIX/v6iD6O0nTMoRT
X-Gm-Message-State: AOJu0YwKrK67qAbA625gG2JcVZSlrlzCaNASpQkbR+qXqZt4XbV6h7F6
	TflOEbHzKU3rnVJNQaKguG4Xj8tN3EIWwyRUZoDj7ZSnnLi0igM8T/EeYW1Zg6ZCO/1C3mTyFHF
	nod+xlhR9WjQgQNdJdO3R7/FWLtZSYd5nn8pZzOVqYx3sHWGT5OBxIw==
X-Received: by 2002:a17:906:e24d:b0:a3f:1043:9078 with SMTP id gq13-20020a170906e24d00b00a3f10439078mr3353433ejb.30.1708539399322;
        Wed, 21 Feb 2024 10:16:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFiPWNkVg9jG7rLOzM5Ss0M4J1Tgmx8LWfAug9prlQp5uxH0e9eCv5b/RRiQ7qIwzoACXDSg==
X-Received: by 2002:a17:906:e24d:b0:a3f:1043:9078 with SMTP id gq13-20020a170906e24d00b00a3f10439078mr3353425ejb.30.1708539399130;
        Wed, 21 Feb 2024 10:16:39 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id k9-20020a1709063fc900b00a3cfd838f32sm5247099ejj.178.2024.02.21.10.16.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 10:16:38 -0800 (PST)
Message-ID: <1943e2b2-6232-4566-9793-2b24eed89d59@redhat.com>
Date: Wed, 21 Feb 2024 19:16:38 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 151/267] misc: lis3lv02d_i2c: Add missing setting of
 the reg_ctrl callback
Content-Language: en-US, nl
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Sasha Levin <sashal@kernel.org>
References: <20240221125940.058369148@linuxfoundation.org>
 <20240221125944.808861688@linuxfoundation.org>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240221125944.808861688@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Greg,

On 2/21/24 14:08, Greg Kroah-Hartman wrote:
> 5.4-stable review patch.  If anyone has any objections, please let me know.

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


