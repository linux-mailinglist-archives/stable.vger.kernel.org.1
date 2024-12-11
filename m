Return-Path: <stable+bounces-100531-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCF79EC416
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 05:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BAAC2844ED
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 04:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CCB1BD9C5;
	Wed, 11 Dec 2024 04:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTmeQXns"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3291B3B791;
	Wed, 11 Dec 2024 04:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733892161; cv=none; b=DQSL+BQK+Is4WWJlnwJdO8zPssy6panzZ5pzuz02kkTFgzHwtHY1wUGKEWR4FqIndrBYm0Jt1vusklnG5F8xLOX/JANCCi5XA/7U7iOVhu7QEAwZubpKoncaZbvJzcGF0/JPi8b34XTcUwIoeQeJLl6RacjFfqvLxgIewToMh6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733892161; c=relaxed/simple;
	bh=+9p9J1jelSz8duI+gfrRD2u+jGQrZ4/a6LnYZjzdNyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o2/dwSXDNqMGKDvtVmxfRqkWweGAAOiiKRiV69QoRquOQobOBA4m5z8JzMfdrEYcwluqDCaGjem9iv39KNkCSOpUOfPW0P/KJxO/IJYanP2GIBWrz4zvmqGgxToTOtvQ8+sRpBDb1iU5BSew7XOOxGLU1L8OgV9A0f1SQrrkxlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTmeQXns; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7f71f2b1370so3963672a12.1;
        Tue, 10 Dec 2024 20:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733892159; x=1734496959; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Osyz45DUr5zikPFMa16MVUwwoDjyzDxn9quKrfwUbdQ=;
        b=gTmeQXnsQf5voGcTI/jCuL+ahx6FEQ6AxVpT2Vx8RLDqLLwQSA6oaT9EBXBPNCtnpo
         o6Zl/QTWtgqHCp2sSYwJG+BxQplP8JoJtd3Fom+pfIwgD2J1pS94cuK1zoLRtsFL74QC
         LShdPDSZ9n4Nz0t/NLTCE9eWQnX+EIzpA2k3d2FurT1ObjokjmsjUCAdvJFfFq5LdqRI
         LDbIRW19LB2X7p4uI3+4SFKu4CY/r3PThBDg1Asqy+SybjY9z85I82mt0lDbfMm3sKKt
         aVIIC8lXChL0mgpKobTFKWshealdMsP78V+aOIN+Xv6h2/K8g6rso16nRzncgWUcBPum
         mxmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733892159; x=1734496959;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Osyz45DUr5zikPFMa16MVUwwoDjyzDxn9quKrfwUbdQ=;
        b=gzhsOO5Qg2eqMdt1a/b1jW30R822w5V9/QeBbWvapcqwRt231y5VRZtLdzJvaWATdx
         4hOMFu2rxiP3Dm9ySiJ8MErlk3YKDoAeBVXhqM9U1bVyKcCRrEz+HRFEjRu2wwNm4sb0
         oE5+ANf76lYclOewwpnv7noKKcXPybn3lG1cC1fdxj1RKs3U4XUjxOI71phe4Yx4yZBC
         Nbm7MYq8vmHWW66H7DLHuNWPpFApLT1olnxzhukHB+SvTE3lcn8Ra0RwyI8m54NDYky4
         P4j4LXY8lkPiZuHkrE6iHjfWsH81iltlf+/B//4G7tEutqGpYYwv/3SUqWFF7C56BcgV
         G/PA==
X-Forwarded-Encrypted: i=1; AJvYcCUoOOy6iyK3c6PvZDou1dgzUqWnZq3sDT+G+K+B4UsS9OrUtHuvVB/abIUl9hCt5yx4zeTB1AiJizVcg34=@vger.kernel.org, AJvYcCVK55CIrMhrQWuPrM+gk/3vK6y6SNCub/7AJPBDdaigxCLbs8JutBurWiJF8M0Wx1zaqoXAwj7L@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6XS5asM0E1pfI3SIJj7ztIyUk6FaFZzuyoCsLuRqq9TReog0g
	rxEpdnAlw/CncSWBmS+YzPvnzs3ebo+YS6EwfaOqXYZ03jsybUzx
X-Gm-Gg: ASbGncs0R3RxtxG0MVsHblIzAS8CKCsSMozUilMrHLeuYdrwTNVeaSBx4w/+6ZuA+x2
	eTKicVxnhgSXn0kxGJFK5Y20s0LxrzWA05HN6aZK55Q0xB/ysyX4f2zPMxA5xFNRswv0CqWejxT
	qqIIRE/ywJ18M5yb4IWRuEToHzTBD6/ipZ6HSvYXU7dejtcDi2oQSwnnK0Esh68guM2EMWGSWwo
	SwMnImRWA4k3+sgtTnBr/st13HuVtAsqdhys9+so0dPVTz5B9a/QDe+aiX8gJ/WOuWg9LDBCGRZ
	94oygrYOk1nOsM+R4qRb9ojn01A=
X-Google-Smtp-Source: AGHT+IE9v9ZJTBOVn10dDLaSi+1GulC4xq+ul1aUbCuFbJ5DhUyCJfD8kxJpL58r21UkNYggt90bEg==
X-Received: by 2002:a05:6a21:9997:b0:1e1:b404:d854 with SMTP id adf61e73a8af0-1e1c12f3b65mr2720187637.23.1733892159364;
        Tue, 10 Dec 2024 20:42:39 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd4e202e9asm4276178a12.72.2024.12.10.20.42.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 20:42:38 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <861fc71e-45ca-405a-9b1e-849cbcb8fcaf@roeck-us.net>
Date: Tue, 10 Dec 2024 20:42:36 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: Check dev_set_name() return value
To: Ma Ke <make_ruc2021@163.com>, jdelvare@suse.com, jic23@kernel.org,
 punitagrawal@gmail.com
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20241211023404.2174629-1-make_ruc2021@163.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241211023404.2174629-1-make_ruc2021@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/10/24 18:34, Ma Ke wrote:
> It's possible that dev_set_name() returns -ENOMEM. We could catch and
> handle it by adding dev_set_name() return value check.
> 
> Cc: stable@vger.kernel.org
> Fixes: d560168b5d0f ("hwmon: (core) New hwmon registration API")
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
>   drivers/hwmon/hwmon.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> index bbb9cc44e29f..8b9bdb28650d 100644
> --- a/drivers/hwmon/hwmon.c
> +++ b/drivers/hwmon/hwmon.c
> @@ -955,7 +955,10 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
>   	hdev->of_node = tdev ? tdev->of_node : NULL;
>   	hwdev->chip = chip;
>   	dev_set_drvdata(hdev, drvdata);
> -	dev_set_name(hdev, HWMON_ID_FORMAT, id);
> +	err = dev_set_name(hdev, HWMON_ID_FORMAT, id);
> +	if (err)
> +		goto free_hwmon;
> +
>   	err = device_register(hdev);
>   	if (err) {
>   		put_device(hdev);

As has been mentioned elsewhere:

If dev_set_name() fails, device_add() will fail. device_register() calls
device_add() and will therefore fail as well. For that reason, error
checking dev_set_name() is unnecessary for hwmon devices.

Guenter


