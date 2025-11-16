Return-Path: <stable+bounces-194853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0106C60EE2
	for <lists+stable@lfdr.de>; Sun, 16 Nov 2025 03:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2952235625A
	for <lists+stable@lfdr.de>; Sun, 16 Nov 2025 02:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59CD1D31B9;
	Sun, 16 Nov 2025 02:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="dVR64hPW"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031D8B67E
	for <stable@vger.kernel.org>; Sun, 16 Nov 2025 02:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763258567; cv=none; b=gCKLnUxmHN5jKMUrlvjYq8PT/YvxeM8qqWIPE5hiMtKDKahds/LsQR+ZckPeYhS0v08Tl1RFEvs+MhV7YzLyqeRdEHBo5Y1rV5ElMKtgkh1caTGWILKNkpQ6b6x5R+Bzi6i6iJV7NVIVNubvs69C8D8VzdDSp24G2U3K/Ya0rp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763258567; c=relaxed/simple;
	bh=ix3L74YT5V67SxQcvcSjcHCLWXPN7DwdUDzu7JUwpac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+uLP0vooTdEc4OD1moUWnv9afZA3lIwFNreQocQBzal/E0K5vc9Ps2lFUcXMIgipUx4djzhDz62DHHwjfgrprDY8XnCrno0+gRUB6uLJcvYnzaeDOvUfGkNFDLfzyhWZn9sZ1oBkZeSiVeJJtuIMb6aEKlefrQrxT+89f5ykHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=dVR64hPW; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8b2ea2b9631so2335685a.3
        for <stable@vger.kernel.org>; Sat, 15 Nov 2025 18:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1763258565; x=1763863365; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pkXB0RiOx00wRtlBivyr40k1pXaqD5wN/4yTU+LCQbk=;
        b=dVR64hPWX38dH/Hbc+t3ataLS/k+ldyJ+MI9ha15l6pP3qxcVgApW4nfx7tKqUMKZ+
         g7xEkQO+yyZzc/nNISsG948Iy2oWBSaniDnDO+T1j6s0FBQwP88r/xAAR1Bf0AR3YzUw
         WCOGMBkJUd7BakVQItkRFx2cSTZb+FqkcfqEEI1clsgCAeZYK/3YcO+t0Y96mFxtUCo+
         yh0ePFBLnehTKv6EbKfL82PuLXNIaeV5ps5zY+OLQbXIvg9UT7hLcSl9nSfpzAE0W6l9
         fsbu2mRBLwJO75W1w1a48fGTTALubjV5iZ4aa9xcJWYs2mP0+7mbCOuWTCBaoKqxvKV5
         ZznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763258565; x=1763863365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pkXB0RiOx00wRtlBivyr40k1pXaqD5wN/4yTU+LCQbk=;
        b=ItiJ1SpXOggUk+AJRfmELbqYvb+k6N7TKyGWIoof+AJIyhxOZJC0v/t4ewHtFTd4z2
         FOafdd9DkrjwSDL2v1k+UW4OaRlQpDAHx9V0wZqHKjVgCreb7mPSBiKvRf7F9FgwcXKD
         bJzjViEewJ10pmNZ3cdgJd2D48x0R/7Xn3VXX1VcgdR3RMg64fes61uT6GJtG4JXP8lu
         dBJvpbK2iWY+dOXsnT7gJJHoM1iXTmrryRp9DuD5QIeWY7LvMW+hvIGeKSk6kOi2Bac0
         XcAbcL6exN66f4NpoCVWpSxNKH0O9c0tN+jFp2ju74KQU8tO9tzIEl5UHvrV0XugOdv/
         b/Ag==
X-Forwarded-Encrypted: i=1; AJvYcCWAFJtTiphSCvdkI3FrCzO13YnYXZeoRcIQ75Pfiazt9Dy3WT/5Q29IVI+BeCTL0OySGr6mdy0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0q4XAQ9zILmZ7b0di7Am73NN4zvFhC0nppLC68PgDUQOEO4wn
	RRX+JYtCuJf5Vy0FEknDWgA5NWcZfY0hkM4Ptv6gov90smZk4kiKJL+KAl0sTu2OwFlXSLg3h4F
	FqmFIqg==
X-Gm-Gg: ASbGncvQ/phz6JCJItdPUG/Z3Hf9+sXuZRRxCqCI0J7RsfIhLF2eAhwZ3i5q6ZjaSVY
	El4Mu1nadZngLY50TSHTWfS7SyO7jFekxhCjfZ4ZgxfUVa/Of3Fus83NE+nWQ7W95WQUgVBhQeU
	dTDnAmzGbWqifAEseRaxYpuBh1jK8EK70rh3J6qnDEG8nMAlPL+6Ht5gmq9BqtN9xddCyg3BJDu
	VZoVClpy4gOC8NcyfIDgWXBpHSiadH/1PZMbMjJ+N7CNV2rY3M6dMPbEOD3mYARA/ApdFK8Y+5j
	iMYuLTHKqEp0QVXQNxvqcn7pZ/DLYqTS5AFAZAQOaQQSzK9tRr8euMZ/6uw5cvmkT/DHXpqTkNS
	/3yprtbu8zYMCLqFwbofd+uzo3jbXFV9lzbaTIVW96PX4jiqYmhvtkye7y/RHrZlLmSioee9h7R
	DMcg==
X-Google-Smtp-Source: AGHT+IGadHCqqKWDl62JvuYVsXnkpYDC3mZv4xvz6u4dz1J6qc7Ey4fFE9duNHKyg1jQsybJWUGC9Q==
X-Received: by 2002:a05:620a:1aa5:b0:8b2:5649:25ef with SMTP id af79cd13be357-8b2c31585a3mr1026069885a.21.1763258564892;
        Sat, 15 Nov 2025 18:02:44 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d03:1700::db9a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2aeeb4afbsm659488785a.14.2025.11.15.18.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 18:02:44 -0800 (PST)
Date: Sat, 15 Nov 2025 21:02:40 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Ma Ke <make24@iscas.ac.cn>
Cc: vz@mleia.com, piotr.wojtaszczyk@timesys.com, gregkh@linuxfoundation.org,
	stigge@antcom.de, arnd@arndb.de, linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, stable@vger.kernel.org
Subject: Re: [PATCH] USB: ohci-nxp: Fix error handling in ohci-hcd-nxp driver
Message-ID: <69b9818e-7db3-4c2b-80f2-29b8170a95eb@rowland.harvard.edu>
References: <20251116010613.7966-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251116010613.7966-1-make24@iscas.ac.cn>

On Sun, Nov 16, 2025 at 09:06:13AM +0800, Ma Ke wrote:
> When obtaining the ISP1301 I2C client through the device tree, the

What if the client is obtained not through the device tree but through 
normal I2C probing?  See the isp1301_get_client() routine in 
drivers/usb/phy/phy-isp1301.c.

> driver does not release the device reference in the probe failure path
> or in the remove function. This could cause a reference count leak,
> which may prevent the device from being properly unbound or freed,
> leading to resource leakage. Add put_device() to release the reference
> in the probe failure path and in the remove function.
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 73108aa90cbf ("USB: ohci-nxp: Use isp1301 driver")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  drivers/usb/host/ohci-nxp.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/host/ohci-nxp.c b/drivers/usb/host/ohci-nxp.c
> index 24d5a1dc5056..f79558ef0b45 100644
> --- a/drivers/usb/host/ohci-nxp.c
> +++ b/drivers/usb/host/ohci-nxp.c
> @@ -223,6 +223,8 @@ static int ohci_hcd_nxp_probe(struct platform_device *pdev)
>  fail_resource:
>  	usb_put_hcd(hcd);
>  fail_disable:
> +	if (isp1301_i2c_client)

This test is not needed; there is no way to get here if 
isp1301_i2c_client is NULL.

> +		put_device(&isp1301_i2c_client->dev);
>  	isp1301_i2c_client = NULL;
>  	return ret;
>  }
> @@ -234,6 +236,8 @@ static void ohci_hcd_nxp_remove(struct platform_device *pdev)
>  	usb_remove_hcd(hcd);
>  	ohci_nxp_stop_hc();
>  	usb_put_hcd(hcd);
> +	if (isp1301_i2c_client)

The same is true for this test.

Alan Stern

> +		put_device(&isp1301_i2c_client->dev);
>  	isp1301_i2c_client = NULL;
>  }
>  
> -- 
> 2.17.1
> 

