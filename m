Return-Path: <stable+bounces-104425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 536759F41B4
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 05:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EE0A188DF8C
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 04:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D97714B092;
	Tue, 17 Dec 2024 04:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uisHgzKG"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8951920EB
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 04:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734409374; cv=none; b=NwrA7lU4t2fZK8b2A2D1Dn+l1uwPgywOcKjGpmqsoGVC0n8XI70nuuLtgmOxeGM2yIgeUberHLKRmSKHkS/3zwZXmNXmlP+2Y/wFT7c4hcNVOfTYrckryZbOVOMAdSL7hECixXgXqvuSBssCA4anONZOUR+Y6gatWgIhqL5obss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734409374; c=relaxed/simple;
	bh=zqpqLDi9o2HN9pkhqRL/t6PUB037p1nJeo7h79OIEuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKlcX0faLV0nQHtXij/dzOoJ+epMunAfiYnCgzm6qygul7dcmZtCrSG+59irwmYOeE8K3gmI1yPEgIZRbA/nncpzQKukmZhAhKa/DlfuW0PYmF93oIy5nysyz0O16w2xT/U3nwk6YsO/ymt18wsssr+PkHEUwa2/CLCEm83ZVdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uisHgzKG; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-218c8aca5f1so6645375ad.0
        for <stable@vger.kernel.org>; Mon, 16 Dec 2024 20:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734409371; x=1735014171; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=07JoRp2HdL+fGtPDXl2NqAHgCCvT4umPfbJtAb58RtM=;
        b=uisHgzKGo41X8yN2cDoQjf0jPSsWruhMhjAt3ryjllmuG1qyOA+FBJS81GRXRvvu2u
         NxFTrOVDrJBRGrY14sidtok6LIWqXHmwVeJzYn7ZADRv82XC8P5f2r80i4BpKEPhjwKS
         VC7sk7OJDByKM8Wkitvu3S1C8daaAEE2qmPzIMiHAPSkOAsk3Y9bOo6a3zl6A2qB4SNM
         1e2LuXQgTZswZHTanWSE2DW5suGF7eSjg94IKAVh20gy5ol97eqggG5pCro5Is0+i17/
         sPVZmB00nh/rapAfStCWvixT/qpSnDDoNhpB/g8ZcPFN5VT8Mr9KjvvDPYOpi6w25lsK
         y9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734409371; x=1735014171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07JoRp2HdL+fGtPDXl2NqAHgCCvT4umPfbJtAb58RtM=;
        b=UVkzmKFDeV5rX9pUfI0VvHeP9dZPoOyVyJsckcU018Dv+KwoRerRS1FaHNqG+M5tpI
         Cneq6g8N3UEEJTHwbUyhS6V0PrR8yCUEEUTDYZnQShheGx/6LZUXm/RsFL3D99mnzf/8
         U4dgFyvRY+g/AbqaHcEtcjI7dFy2aFcq+WG8OmOIlhDsUOPfHgXuX76FHqZvsMyozyVN
         c+2bIhYO5w9C8zyV1XbvJQTcU9mZL4DvMQNRhpWLc4KoTbMVRFlZZFhbLwcZ3inE/uR/
         A04h0rkYbqMF5PLK4onrprM5zb6pg7LCADLHoiE/+bXlDWkcRG1LjdMSKe9+7GkQjyLj
         ViwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXqp/RUSvjMhl0yXtlJPliBxJ5Yrr9efByXCGQYzWWV48PzV6urHZaW3u5YNlK8OZ72dlhfiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV83t/hfKT1zqK35ocoAwLQ/EV2T0TsAmON8YCx368BXie/ZB8
	7ipwCZvgz5Yj8hEai6gIb9Q9BDo6cieiB11kGlMtUxNcoUvPlcTzUgIFhm5RolA=
X-Gm-Gg: ASbGncvFts0wvTi5Ti/3dAEAy8Z1aOC77ymTHPct22wh57/GY7A0o1qGl8Kk/7GNtj3
	wULCn6v0JUVrfWd+I0Xah5/p2lalObA7Dv9QUWjMbUVmMF2kRQmAxsUqJ+oh7yZIuIk+3zdj0O8
	B5dNfXM9ZMttGnB2KEH1FbctW5xTpgoBqygVZvrE1Ndkbigf0tGTFQIiIQXf1b1XHsVeXfYlk80
	5+IHQ/bEBXB3S/3vflt5YtVLZoAUWqikQqeU0zJmyyps8iceogMdwxas4c=
X-Google-Smtp-Source: AGHT+IEKbIgA6J6tdVvc/CKVL0o8Qbd3JlzKf10BNjP+GnyYPGnHpKt+dWfA7AT7ES0/R2gK7S0k+g==
X-Received: by 2002:a17:902:d484:b0:215:431f:268f with SMTP id d9443c01a7336-21892999536mr230452625ad.10.1734409370906;
        Mon, 16 Dec 2024 20:22:50 -0800 (PST)
Received: from localhost ([122.172.83.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e7227asm50376595ad.272.2024.12.16.20.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 20:22:50 -0800 (PST)
Date: Tue, 17 Dec 2024 09:52:48 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ma Ke <make_ruc2021@163.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, arnd@arndb.de, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] virtio: fix reference leak in register_virtio_device()
Message-ID: <20241217042248.omldhsl4royrfo4o@vireshk-i7>
References: <20241217035432.2892059-1-make_ruc2021@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217035432.2892059-1-make_ruc2021@163.com>

On 17-12-24, 11:54, Ma Ke wrote:
> When device_add(&dev->dev) failed, calling put_device() to explicitly
> release dev->dev. Otherwise, it could cause double free problem.
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 694a1116b405 ("virtio: Bind virtio device to device-tree node")

The fixes tag looks incorrect as the problem must be present before this commit
too.

> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
>  drivers/virtio/virtio.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index b9095751e43b..ac721b5597e8 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -503,6 +503,7 @@ int register_virtio_device(struct virtio_device *dev)
>  
>  out_of_node_put:
>  	of_node_put(dev->dev.of_node);
> +	put_device(&dev->dev);
>  out_ida_remove:
>  	ida_free(&virtio_index_ida, dev->index);
>  out:
> -- 
> 2.25.1

-- 
viresh

