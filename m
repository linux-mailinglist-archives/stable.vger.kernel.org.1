Return-Path: <stable+bounces-124057-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A807A5CC0C
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 18:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8E32189907D
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 17:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942AA2620D1;
	Tue, 11 Mar 2025 17:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4XuMbUo"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4EE255E20;
	Tue, 11 Mar 2025 17:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741713841; cv=none; b=dRszGBJVRH1WroNxrZ9f592pair2wS2Mnmq31JEhNTqTmsOfHcyc4o+hfzbg7LUnubKfhf7AH5wgPNbvTIqyaUETaYdoRQalcCCVmYISdyVYvLbvX10g0TuSgjr911paoKsASyhIFxn7vs7PUKiwASROXk4y//7W7rwujKZUQ68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741713841; c=relaxed/simple;
	bh=owns9l5JLbWYp17TZuEzyhli5LeKH4b9XdYYGM2SdTk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dEW0AJeadrPl01ZlWMJzsWGAte3rb8tRqgeuVjZnezgqegMohYuMhsnnL0WW6mzn4WPopioU9IjGJd4SzfEzf10R9gpcJvJHfRfsTkny53XUFbeaxI+mDriln2QUMoXA6GvUGDSj2ptf3hmrYDMbpR3dvOXNL+IxhYujafJRnEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4XuMbUo; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4394036c0efso34857515e9.2;
        Tue, 11 Mar 2025 10:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741713838; x=1742318638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2CblXRDFSbYzBfdZvOZoTbib8TKXWZ1Do7JX0N+BLKY=;
        b=d4XuMbUoBqUpKKWoFYNfWAbTXK3mS3KEReiFjkzbPB7gBOA+NQAf5CkS0d5+PsFF8P
         u2XP7BbyxeeUfc2S/vtt5QRsiaq6HR8e1/kFWBMwmmnHTWl15Fy7awI/RoFWE6sarNoj
         arf4vzzl7UHE7CKtG4d4lPvY0TsCJpeTvSHWuKae9YjnkRqwhS3VaOGqqhZJVGUWI2hU
         mUecpSANozejnJ+pD9UVXPSsfDo0zOKN4g88Tqt79Bkt02Ca2knfi6Auo1kHSsLdj7Qm
         MM4btfJ6rprNLTU9jdN72i6Kb2fVth85vJQJiSgQl5v51ByL7QOdU2ox9Fdzq1f7lm4W
         tFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741713838; x=1742318638;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2CblXRDFSbYzBfdZvOZoTbib8TKXWZ1Do7JX0N+BLKY=;
        b=NeHhQgUf/Z6O6Hu5v6E6+HhgP5wYhP0SCfnp3YRIkgoQmCX0zt1QuNuNv/v4YoI7Vu
         oVUcBFR/gpMwz/qTF+CxmfzTHotirw9Pnw7QnF/dkEUzLLGoh5Su3UUbZKlm/1Km30+O
         UwqqG/Yc6hIem072VAI/pGAZT/9NwXRGVwDLQs48Xzz+h22++8sNfvLq44zd7E6a8zBx
         hbCYZ+H5D9T86qVzBxTmpWCykU74uhh8xIOAo3OjCNWpxX45p5pRdgdBkE118f15NsoJ
         s/EIGtUKgbYJxW2+XPoVLEhf80lMugXp+8G9WwpYPEFyTzt70UdRVnnwfOlQCsnGh//V
         6dCw==
X-Forwarded-Encrypted: i=1; AJvYcCXDAqCf+IgxDKugK5sSL2hJ/n8wdu97R8PCT1aaynDoKyEQGoeahmq5rkQmFKpmv91PVx0MfOw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+ZEEEHk4JDm/87+PV/AyG007P7ipuLBuXqs1GPH0XL+URG0bu
	uugIqa3ylPct+NycTB6nm+fc6EZ8q7ZRtyp6KHaRHFERqnQ428TS
X-Gm-Gg: ASbGnctKDWxHGbAg4Blr3rFc+sqddHmHlc9XDoHpjTY1Zk+SeZQu6HBo6XsS5WNICe6
	hYofHgzMiiP3UJDafQTxyFgY6LtN7cdLWa0Y+LtguOqQDT4YS4pxVe2k3b73H3I99hJYbFFIhvH
	3gISeQ6WcSDOyOflwYBlIOFUce4URMcbez7zRUXse2/s8ytMEu3Z7t7ezb3pzOUT44F3CtWzOuM
	R6UBOhHKQHvWvF4F8TfnLp9KqttBct8SJf2kiWYbwRO37U7ENYgdhKddw8N+eIwlF/E90NH9Ppq
	2DYJAYhoQBfwlrurCkjotb5ndxE/HNB8sd0NuIvpXMF+YS/NPMeks6pP36cmY62k9NpKhROTJm9
	1y0Cem4bI1Mc=
X-Google-Smtp-Source: AGHT+IHmQIwKqmpw/iCa+vydvbfQuzaYeiFEWI+fVAggDgqfNeIzbmu5lpU7cflubg+ifd7aRx+85w==
X-Received: by 2002:a5d:5886:0:b0:391:4674:b136 with SMTP id ffacd0b85a97d-3914674b5f1mr8616572f8f.29.1741713837608;
        Tue, 11 Mar 2025 10:23:57 -0700 (PDT)
Received: from [93.173.93.237] (93-173-93-237.bb.netvision.net.il. [93.173.93.237])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfb79cfsm18745734f8f.10.2025.03.11.10.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 10:23:57 -0700 (PDT)
Message-ID: <b3eda642-f181-de6c-9975-42ce3e149db3@outbound.gmail.com>
Date: Tue, 11 Mar 2025 19:23:20 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From: Eli Billauer <eli.billauer@gmail.com>
Subject: Re: [PATCH v2] char: xillybus: Fix error handling in
 xillybus_init_chrdev()
To: Ma Ke <make24@iscas.ac.cn>, arnd@arndb.de, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 stable@vger.kernel.org
References: <20250311013935.219615-1-make24@iscas.ac.cn>
Content-Language: en-US
In-Reply-To: <20250311013935.219615-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

In what way is this better? cdev_del() calls cdev_unmap() to undo the 
mapping that a successful call to cdev_add() performs, but that's 
unnecessary, because the whole point is that the latter failed. And then 
cdev_del() calls kobject_put(), and then returns.

So the existing code calls kobject_put() directly, achieving the same 
effect. It's a matter of coding style. Which is better? I don't know.

What is the common convention in the kernel? Not clear either. For 
example, in fs/fuse/cuse.c a failure of cdev_add() leads to a call to 
cdev_del(), like you suggested. However, in uio/uio.c the same scenario 
is handled by a call to kobject_put(), exactly as in my driver.

Has this topic been discussed in the past? Any decision made?

Besides, if we remove the call to kobject_put(), so should the comment 
explaining it.

Regards,
    Eli

On 11/03/2025 3:39, Ma Ke wrote:
> After cdev_alloc() succeed and cdev_add() failed, call cdev_del() to
> remove unit->cdev from the system properly.
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 8cb5d216ab33 ("char: xillybus: Move class-related functions to new xillybus_class.c")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> Changes in v2:
> - modified the patch as suggestions to avoid UAF.
> ---
>   drivers/char/xillybus/xillybus_class.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/xillybus/xillybus_class.c b/drivers/char/xillybus/xillybus_class.c
> index c92a628e389e..356af6551b0d 100644
> --- a/drivers/char/xillybus/xillybus_class.c
> +++ b/drivers/char/xillybus/xillybus_class.c
> @@ -104,8 +104,7 @@ int xillybus_init_chrdev(struct device *dev,
>   	if (rc) {
>   		dev_err(dev, "Failed to add cdev.\n");
>   		/* kobject_put() is normally done by cdev_del() */
> -		kobject_put(&unit->cdev->kobj);
> -		goto unregister_chrdev;
> +		goto err_cdev;
>   	}
>   
>   	for (i = 0; i < num_nodes; i++) {
> @@ -157,6 +156,7 @@ int xillybus_init_chrdev(struct device *dev,
>   		device_destroy(&xillybus_class, MKDEV(unit->major,
>   						     i + unit->lowest_minor));
>   
> +err_cdev:
>   	cdev_del(unit->cdev);
>   
>   unregister_chrdev:


