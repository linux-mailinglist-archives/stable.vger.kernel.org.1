Return-Path: <stable+bounces-23222-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F27585E556
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 19:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95188B21459
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 18:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557D385268;
	Wed, 21 Feb 2024 18:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QW1yClqn"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF8085261
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 18:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539386; cv=none; b=LYXV/Ff3fj6rvbyUZvGXwOgLLdXfULz7sYjOMF7ZCCXR6zZM2bVu4iXde/QppIzScCA8of64GrnlCZ0cqBpi3xIQpvjR5OuviPd/QQuiwfC/mNQG4Te5j2ZoMyTsDvhlZevhvz4cSSmkgMo900AFJTI9IfPg8y/rTwemarre8CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539386; c=relaxed/simple;
	bh=3SHL1XNkaiKpxO6lQfgzzHFCVUWOFLqJpgPVgR2uRbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aC4jnJvcMgql+U9pHkQmrNF8gnpZvODyRysFy7duMLeVXjCWP+tydDK0uJQQenMejBYlHXgwTCL8CdvRdAI1OU+PNA4yS0fAJXu2YvQ/BHe+Q8AB2dsregFwS/h7V+q7MB6YJ6TiII6rHCUYQs9XstnkILbyFy4Jybxq8rcIdPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QW1yClqn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708539383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y0pSHPkWhI1aovz8fuYtLZqGyE3hV9KFpQFptJhCaj8=;
	b=QW1yClqnzBfhd2YvaLtELbFs0IlR8w66tOUADqBqE9WjOa5JSEZYNN8oLk38IhtwGlpoPC
	DSYlBJgjnDaeARY/S3Ns7o1Lnxr+ymyVWOrPcxl05/d+leRm006EGGlIhXmktjmaXSEPGg
	kpGI7EbN4Fcx+M5MOQ9hZF2MYuRlNYE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-ERIPE4zWNIGvfz1G9jmqpg-1; Wed, 21 Feb 2024 13:16:21 -0500
X-MC-Unique: ERIPE4zWNIGvfz1G9jmqpg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a3d7cd58ae2so295858066b.1
        for <stable@vger.kernel.org>; Wed, 21 Feb 2024 10:16:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708539380; x=1709144180;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0pSHPkWhI1aovz8fuYtLZqGyE3hV9KFpQFptJhCaj8=;
        b=wG+2ER0pD8AoZ7mX0ngP4zCPrXp6xYvDnCxYwsMy+ANkJu9LH37OQf86Fxuzvki0Sn
         oQ/fcS1acv0ME3O/Z307LF1Yrv490poBAFilVwEOLwGze9ll8ZAJyyZ2XgxEiJhfYp8v
         lyZOn2a0IrYOO51mt46ATl0nF93EmCttkkFzVZJsmatvwq4jChtRUvbFzXvt9pFERlZ1
         O2MNgGOXaf/Ka2n813LTdYaOizWaoMgiSQApA/zC1rRfiPRKapNn9VhBZsd+AOVMop8Y
         IpLOa+X/4gu+p7XOHkBbgMGvMP1PrH4M3zEcocpf+ww6qFHsk0WGer3GlF1pIzRcAsVV
         JwnA==
X-Forwarded-Encrypted: i=1; AJvYcCUBFPk+frPdkX4RKJcA5SytL5T1JnDBtlVQMg8TCRlDIpDP362BPiu56ygrF6C6c6JNOZhGYXsIJkokJIPeBNTyQPo8lUef
X-Gm-Message-State: AOJu0YxowlDQCYdMA04pJFhXKiNxH3IFk9xFZYzilFlEY4N8xK6AXCRC
	AubJTldi4CIkEsW9icxnwoZEurPvWTycdCpfNxWWIlhKxzU3RFsrv2NAy6oDTpPpbVpOAaYenEW
	gRatbwwmD7fsjtv+nnbwLmVfcjB6bO/jeOBenm3IkDIRLnVWoJstz0A==
X-Received: by 2002:a17:906:48d6:b0:a3e:eb81:ab62 with SMTP id d22-20020a17090648d600b00a3eeb81ab62mr4536907ejt.7.1708539379901;
        Wed, 21 Feb 2024 10:16:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHskiBfNYd4NyraNAJC7Bc0q5aY/6QnoJyFU2X6qqBRdrzuezl4GTeeM7GvpdeWZvJ5o1hpA==
X-Received: by 2002:a17:906:48d6:b0:a3e:eb81:ab62 with SMTP id d22-20020a17090648d600b00a3eeb81ab62mr4536897ejt.7.1708539379571;
        Wed, 21 Feb 2024 10:16:19 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id k9-20020a1709063fc900b00a3cfd838f32sm5247099ejj.178.2024.02.21.10.16.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 10:16:19 -0800 (PST)
Message-ID: <2a85437b-c395-48a5-addc-16c6bb1c590c@redhat.com>
Date: Wed, 21 Feb 2024 19:16:18 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.19 123/202] misc: lis3lv02d_i2c: Add missing setting of
 the reg_ctrl callback
Content-Language: en-US, nl
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Sasha Levin <sashal@kernel.org>
References: <20240221125931.742034354@linuxfoundation.org>
 <20240221125935.687309540@linuxfoundation.org>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240221125935.687309540@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Greg,

On 2/21/24 14:07, Greg Kroah-Hartman wrote:
> 4.19-stable review patch.  If anyone has any objections, please let me know.

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
> index 14b7d539fed6..e8da06020c81 100644
> --- a/drivers/misc/lis3lv02d/lis3lv02d_i2c.c
> +++ b/drivers/misc/lis3lv02d/lis3lv02d_i2c.c
> @@ -164,6 +164,7 @@ static int lis3lv02d_i2c_probe(struct i2c_client *client,
>  	lis3_dev.init	  = lis3_i2c_init;
>  	lis3_dev.read	  = lis3_i2c_read;
>  	lis3_dev.write	  = lis3_i2c_write;
> +	lis3_dev.reg_ctrl = lis3_reg_ctrl;
>  	lis3_dev.irq	  = client->irq;
>  	lis3_dev.ac	  = lis3lv02d_axis_map;
>  	lis3_dev.pm_dev	  = &client->dev;


