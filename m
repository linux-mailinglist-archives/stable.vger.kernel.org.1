Return-Path: <stable+bounces-105139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 974F19F6141
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 10:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E492E166E03
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 09:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3384191F75;
	Wed, 18 Dec 2024 09:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zc/U2OL4"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A5215B13D
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 09:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734513513; cv=none; b=bwQNRSZOHr7K+lqabviXCtNWnna00YtNr2+cSKlBIzAElz/WvWMeVNIzHp5hYH6zPUgskJe4LmhMLBCxjubel5Hpc+KoKZzKIKEnBsIPOiOsGbvfuq9GVGP5PqkySwkE++RBzJ63m9UnRUorwOi3OV2WdD1m6GQMszDguD6yjQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734513513; c=relaxed/simple;
	bh=HSyDULdwQXu3xlcnyukj7r2kntKBqz06an3YCwlmq7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lI1mmbeWjjpEm/73R+eYastGP17Pjgd/puLUrpKO+Ursgm/HnNUKzk9LmQaD9MLtw+DuFQPap0mQnI1l4FE5d7AL9ig3x0hZP6BDQNJAC8PVCVjHYAnuHGBqmaPUsKMRyZrWc4KI21BnEMwWE3Q0c9arkKPx3IXoVSK466+DE40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zc/U2OL4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734513509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RLeA091LzMVlS973SFASJBgcuRe2YSP+pMH6a6B7hJQ=;
	b=Zc/U2OL4Jxm6oiQI9Qdc1wS2dbqjrTBmDZlTIi+0ufn4IYhzQ6CQk70HsgwDKkBaGwdOkk
	LDJiLBs97STPDoOPCMh/zBtF2PFmOUSp3l5E+Wb0A/GVpwNamZW2xWjKsPV9lEjPSUrsqq
	ZQkdjxaEVI1+UJriTxCCC1iNw0va0Ag=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-4UoivWYpObidAdhczTRIMw-1; Wed, 18 Dec 2024 04:18:28 -0500
X-MC-Unique: 4UoivWYpObidAdhczTRIMw-1
X-Mimecast-MFC-AGG-ID: 4UoivWYpObidAdhczTRIMw
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-436379713baso21561965e9.2
        for <stable@vger.kernel.org>; Wed, 18 Dec 2024 01:18:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734513507; x=1735118307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RLeA091LzMVlS973SFASJBgcuRe2YSP+pMH6a6B7hJQ=;
        b=jDSn4/m6dkn+Mruav5x9QelAI+UTRMkWU5mi7EQulrveY5MSf4Cpg1bx56A1aDFv3h
         KAL4jClWWIiTZdva7kE8qzb+K2vaiE3WZ15i9RMQSUb8/QYPWWT/DW6tIEY0rdEZeSzQ
         17lyJLbiqbo7llwrrRC/xEfNj2cu0HOYYgmd18tyLyOashcP98DnCWeANXxUaDxQCQ3/
         AFk9Zvpn9aIJmLF4ZtEYmssTRR8z9eaBir3XO9oGlQwBVNpuHrS8BtCasNXqzO2s7zi9
         queJMOy7S3VoBld67buZpjjP3CClpggSQ4LIAnyxv1Exbk/HrsI5RQ586m2uOr6jLQfV
         dWcw==
X-Forwarded-Encrypted: i=1; AJvYcCXnsNKShJl8aS9dGlW2BET0wCEtRp3cAmp7bmuiPHWDiKEWd+5YmQy4bJ4eNgLSej7WuLnxu6s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4AHfyVN8L3kCR//Ng2iD2EWnUhFZuZNxOWLV4z6Q/Smb/C2h3
	Kjv1ZmOHw+4r9mBx28XzdSkQqHt86IkUz/3NaVZwKwe++wpQivgfIwjgSkhLHzczft99VaZCa4v
	wYXTC5ca+LdTSfj9jFoTXdwT/KTKxRvEsNORdqGtfhcgD4/95srMsVA==
X-Gm-Gg: ASbGncu9SrbxjYgPg6mTJHN90pBYBNoo5OBUOF5108IUWC2+O9FFQIvBiHJY5obvuuh
	9Ewg2RWxCB7a2xDdy7PvNw2IMZLNgm/gHYZOKJsYiTrWVMov3lHj6voPJOP59ENbyLqeE5/+Bpp
	17Y+jlNLd/+Zk07GTKz0i7Nw4G4v9Ayqa5nMc21NxCQO85HNAQIKnjk66NtP1fcLivU2eAFg9wu
	FPoKMFhko+OQi6lDBM6ZNKe4jJyer4vevfJ2g9yX8M=
X-Received: by 2002:a05:600c:4748:b0:434:a1d3:a326 with SMTP id 5b1f17b1804b1-436553492e9mr15885255e9.6.1734513506928;
        Wed, 18 Dec 2024 01:18:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzQFTHFw7fnVGsOgmaN2fVP2YDadBMDrQRnfY9WghIfpNZbHV2iytk+s+GOfHa1YGNMY6H+Q==
X-Received: by 2002:a05:600c:4748:b0:434:a1d3:a326 with SMTP id 5b1f17b1804b1-436553492e9mr15884945e9.6.1734513506566;
        Wed, 18 Dec 2024 01:18:26 -0800 (PST)
Received: from redhat.com ([2.52.9.192])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c80470afsm13691223f8f.75.2024.12.18.01.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 01:18:25 -0800 (PST)
Date: Wed, 18 Dec 2024 04:18:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ma Ke <make_ruc2021@163.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	zhangweiping@didichuxing.com, cohuck@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] virtio: fix reference leak in register_virtio_device()
Message-ID: <20241218041403-mutt-send-email-mst@kernel.org>
References: <20241218031201.2968918-1-make_ruc2021@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218031201.2968918-1-make_ruc2021@163.com>

On Wed, Dec 18, 2024 at 11:12:01AM +0800, Ma Ke wrote:
> Once device_add(&dev->dev) failed, call put_device() to explicitly
> release dev->dev. Or it could cause double free problem.
> 
> As comment of device_add() says, 'if device_add() succeeds, you should
> call device_del() when you want to get rid of it. If device_add() has
> not succeeded, use only put_device() to drop the reference count'.
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: f2b44cde7e16 ("virtio: split device_register into device_initialize and device_add")
> Signed-off-by: Ma Ke <make_ruc2021@163.com>


Did you actually test this, triggering an error,
and with debug options enabled to find double free
and use after free? Which configurations?

Because if you did, you would find for example this
in drivers/virtio/virtio_vdpa.c:

        ret = register_virtio_device(&vd_dev->vdev);
        reg_dev = vd_dev;
        if (ret)
                goto err;

        vdpa_set_drvdata(vdpa, vd_dev);

        return 0;
        
err:    
        if (reg_dev)
                put_device(&vd_dev->vdev.dev);
        else
                kfree(vd_dev);
        return ret;




> ---
> Changes in v2:
> - modified the bug description to make it more clear;
> - changed the Fixes tag.
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
> 


