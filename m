Return-Path: <stable+bounces-83138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC0D995F19
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 07:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28190287B3C
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 05:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F17C43AAE;
	Wed,  9 Oct 2024 05:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+vGaNNk"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95608161313;
	Wed,  9 Oct 2024 05:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728452484; cv=none; b=G0e2/AAggZ08z3by3UMSQXkh6hjitkapJfjXQrsqVs6Jp2htrxp4FeinDbgCc+vnm2oLonB/EocOgeeoHVFjvT3Vno0ryuJpfc0bLgHQDodkcjxbtJV0YUsRU2GUTF0SpledNt3NY6HRkiknUbTQgj4ELPlUvieIJkt7uMzWVp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728452484; c=relaxed/simple;
	bh=AALkzm2IfLJecbBptAntMUQ1tTSCPkw2XpvjH+G4xXg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BqNCY8s6dV2Zfu/ve2lSNlWSxR0GM6RGVXkFb28W2RjznNkCJuzqh0CmGe4O5erWB4ZlW4/kokpvGvvI0PEBlbjFvt/Nbb5HWc4fmm5GyWvjLPUIGTYbQukdVddcK4nyIUJE7Ku9EEOoHdu1RUSIbO/g2PwrzZ8aV6YJC0TTSnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+vGaNNk; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e03be0d92so2142957b3a.3;
        Tue, 08 Oct 2024 22:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728452482; x=1729057282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aMdEytBktHvtBAPR9LNmHr8eXRV2mGTH7HPRArNPzcE=;
        b=Q+vGaNNktZ6ku5zHPFqAlqXhOnaDSj7Nunegy84YihkAr5iMESCZXIM2uF8Juv2k9L
         qrNqsuyr4PvGg3FYsOJ+JCw7e0baOLr1/GwU3zxuiBAdH1NGnWiJmy/S3/cc7ezQmGpv
         H5nk3y4moP8g3C6XaIgNhGLKi4s9+vNWm+TrRI7NMH742Ms6c+vCQPKZ9rivaqqEtiwK
         BGBHlUPZP94BMF6zJje7dmMlE1/laFpdCTCBtR/TPT8n9hX51HbngW4SLYYZPbtoG1ZP
         GYl8sKK+7evpKhkaZV52DuSBkLkvPszhDbhq7u8v/6ls/yFwr1s/XVWwkgTMOez5Hxze
         A7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728452482; x=1729057282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aMdEytBktHvtBAPR9LNmHr8eXRV2mGTH7HPRArNPzcE=;
        b=nHjxhJQnJnxEJKUGCCgeLNBUTjgfurZywS1uUadV/627gCB5Eur4IaJf4CnyzDQC/F
         WGebGcyNI0OOSVkt2fh9rkMNQGLpGd46swHrbNjBTi/3EzsJM5S0y9C+ob0MrmAp5Wxz
         +rlJhqxYONh23uLagXm+rodvPNhGEgRVWTX1c5Uob0qOB6Rsz773+OfMVyyAJOcmPOWq
         AlpY6kiVYsaDKUSNLuINRQTxo2sQQLgD/ulvHdXXaUwHpR0/bLmeqFo0+TrQlN+R0Mcf
         xM6IIKXWOLczcouiCEaSyTwTMTDtojOI8vKOFm9zXaTKWu4zK9BwxekhVMZ78hmq+OVD
         +2CA==
X-Forwarded-Encrypted: i=1; AJvYcCVha5qa/4rLOiY/QwGoW/m1XbdpEiC6QXbLb2m4RF63f+CCZ7BbNQpZOPgnzhX8HjbmtoNvQ6Ws@vger.kernel.org, AJvYcCVpPEx+eh3M4OgAoa0hAPNBsnMx6Swg9CwksNrJCf2w7NYYFZqfU8TIsZonfvOrXI+F1ldxxW9WG6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzltU0D02QvFvV1K+jjKhs+YiuqTMRqZURiI0iYJToSELYlVywO
	RxlewUFir6SWUIG5oWNJ8FaF/l+k7gn6ozBke+uk7oDjwtuNDMtki3tVL/Xk
X-Google-Smtp-Source: AGHT+IGBW9LxAlN/QvWHCEwnwhOR+3P9vxJ7njGShnCT6Ut9pX/tEzhE3WqQAksrKbefAb77rZ3RyA==
X-Received: by 2002:a05:6a20:4a17:b0:1d8:a759:5260 with SMTP id adf61e73a8af0-1d8a7595392mr577663637.44.1728452481715;
        Tue, 08 Oct 2024 22:41:21 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2a5963c96sm644129a91.39.2024.10.08.22.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 22:41:21 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: oneukum@suse.com
Cc: gregkh@linuxfoundation.org,
	keithp@keithp.com,
	linux-usb@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+422188bce66e76020e55@syzkaller.appspotmail.com
Subject: Re: [PATCH] USB: chaoskey: fail open after removal
Date: Wed,  9 Oct 2024 14:41:17 +0900
Message-Id: <20241009054117.33535-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002132201.552578-1-oneukum@suse.com>
References: <20241002132201.552578-1-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> chaoskey_open() takes the lock only to increase the
> counter of openings. That means that the mutual exclusion
> with chaoskey_disconnect() cannot prevent an increase
> of the counter and chaoskey_open() returning a success.
> 
> If that race is hit, chaoskey_disconnect() will happily
> free all resources associated with the device after
> it has dropped the lock, as it has read the counter
> as zero.
> 
> To prevent this race chaoskey_open() has to check
> the presence of the device under the lock.
> However, the current per device lock cannot be used,
> because it is a part of the data structure to be
> freed. Hence an additional global mutex is needed.
> The issue is as old as the driver.
> 

There were 3 deadlock reports uploaded by syzbot due to this patch. It seems
like this patch should be fixed or reverted in its entirety.

> Signed-off-by: Oliver Neukum <oneukum@suse.com>
> Reported-by: syzbot+422188bce66e76020e55@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=422188bce66e76020e55
> Fixes: 66e3e591891da ("usb: Add driver for Altus Metrum ChaosKey device (v2)")
> ---
>  drivers/usb/misc/chaoskey.c | 35 ++++++++++++++++++++++++-----------
>  1 file changed, 24 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/usb/misc/chaoskey.c b/drivers/usb/misc/chaoskey.c
> index 6fb5140e29b9..e8b63df5f975 100644
> --- a/drivers/usb/misc/chaoskey.c
> +++ b/drivers/usb/misc/chaoskey.c
> @@ -27,6 +27,8 @@ static struct usb_class_driver chaoskey_class;
>  static int chaoskey_rng_read(struct hwrng *rng, void *data,
>  			     size_t max, bool wait);
>  
> +static DEFINE_MUTEX(chaoskey_list_lock);
> +
>  #define usb_dbg(usb_if, format, arg...) \
>  	dev_dbg(&(usb_if)->dev, format, ## arg)
>  
> @@ -230,6 +232,7 @@ static void chaoskey_disconnect(struct usb_interface *interface)
>  	if (dev->hwrng_registered)
>  		hwrng_unregister(&dev->hwrng);
>  
> +	mutex_lock(&chaoskey_list_lock);
>  	usb_deregister_dev(interface, &chaoskey_class);
>  
>  	usb_set_intfdata(interface, NULL);
> @@ -244,6 +247,7 @@ static void chaoskey_disconnect(struct usb_interface *interface)
>  	} else
>  		mutex_unlock(&dev->lock);
>  
> +	mutex_unlock(&chaoskey_list_lock);
>  	usb_dbg(interface, "disconnect done");
>  }
>  
> @@ -251,6 +255,7 @@ static int chaoskey_open(struct inode *inode, struct file *file)
>  {
>  	struct chaoskey *dev;
>  	struct usb_interface *interface;
> +	int rv = 0;
>  
>  	/* get the interface from minor number and driver information */
>  	interface = usb_find_interface(&chaoskey_driver, iminor(inode));
> @@ -266,18 +271,23 @@ static int chaoskey_open(struct inode *inode, struct file *file)
>  	}
>  
>  	file->private_data = dev;
> +	mutex_lock(&chaoskey_list_lock);
>  	mutex_lock(&dev->lock);
> -	++dev->open;
> +	if (dev->present)
> +		++dev->open;
> +	else
> +		rv = -ENODEV;
>  	mutex_unlock(&dev->lock);
> +	mutex_unlock(&chaoskey_list_lock);
>  
> -	usb_dbg(interface, "open success");
> -	return 0;
> +	return rv;
>  }
>  
>  static int chaoskey_release(struct inode *inode, struct file *file)
>  {
>  	struct chaoskey *dev = file->private_data;
>  	struct usb_interface *interface;
> +	int rv = 0;
>  
>  	if (dev == NULL)
>  		return -ENODEV;
> @@ -286,14 +296,15 @@ static int chaoskey_release(struct inode *inode, struct file *file)
>  
>  	usb_dbg(interface, "release");
>  
> +	mutex_lock(&chaoskey_list_lock);
>  	mutex_lock(&dev->lock);
>  
>  	usb_dbg(interface, "open count at release is %d", dev->open);
>  
>  	if (dev->open <= 0) {
>  		usb_dbg(interface, "invalid open count (%d)", dev->open);
> -		mutex_unlock(&dev->lock);
> -		return -ENODEV;
> +		rv = -ENODEV;
> +		goto bail;
>  	}
>  
>  	--dev->open;
> @@ -302,13 +313,15 @@ static int chaoskey_release(struct inode *inode, struct file *file)
>  		if (dev->open == 0) {
>  			mutex_unlock(&dev->lock);
>  			chaoskey_free(dev);
> -		} else
> -			mutex_unlock(&dev->lock);
> -	} else
> -		mutex_unlock(&dev->lock);
> -
> +			goto destruction;
> +		}
> +	}
> +bail:
> +	mutex_unlock(&dev->lock);
> +destruction:
> +	mutex_lock(&chaoskey_list_lock);

Shouldn't we use mutex_unlock here? I don't know if there's a special reason
for writing it this way or if it's a mistake, but doing it this way causes a
deadlock due to recursive locking.

Regards,

Jeongjun Park

>  	usb_dbg(interface, "release success");
> -	return 0;
> +	return rv;
>  }
>  
>  static void chaos_read_callback(struct urb *urb)
> -- 
> 2.46.1
>

