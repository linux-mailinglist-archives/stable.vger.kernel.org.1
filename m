Return-Path: <stable+bounces-89495-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9059B9375
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 15:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03C2C282A85
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 14:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7341A76BB;
	Fri,  1 Nov 2024 14:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VPZB/+CB"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7379849620
	for <stable@vger.kernel.org>; Fri,  1 Nov 2024 14:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730471945; cv=none; b=gQwUKQuO2YNbpJjzM56jKvRao/id0Uk4ZyO/h78k1Ce4B7eO3C0OCJrCTAF55x6XgVEb+zgKuxwlCZBUF4DcL/coQbEx+Y/42zXv0BvMhPn/9NR6Y80V9y0mzeYbw7r4O0x5stipFSMZpS28BrQ6QH+X5VjyQfRoS9pwF6+PvcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730471945; c=relaxed/simple;
	bh=Y38QQrJXyIzC27Zb5Y70kq+LVb66PlU9agQi+H5nsOU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EIfnDD+NfnaLHFjz+ZQFQtN9do9eLaZhVKUZucEwnnBYB2NS8Aa1+54R9JV/mEynHUKAZOtAe3En2pg+5ZNMAYM0AGG3o9v2JDh4M/hjHtXup6p1wVL+GUL13rDKCr6ScH4DDQkGpFf6V9CN/d8stW8eXIATTFpZoFP6QgNBDgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VPZB/+CB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730471942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PjBxXqU+pM0vC60LmXgGLO5qOIRdoqxNpK1lcWYvr1A=;
	b=VPZB/+CBjWU1arZWB0e1/jbDloEb09zyWaBKJS8wZmK0SWmgpbvCSRBECsMEMrouZeLHLE
	jrRbOSsEUv9jkn2e54a2CFbWfi2QN+u8LryaLl4QdcuM9nk+EUFzMvQyLbR6niUdutRSqk
	/Ega1XNreZxEpYb8QBSRLjnlGhN0eE0=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-XNHpDlb5MySlClJCLwfeIA-1; Fri, 01 Nov 2024 10:38:59 -0400
X-MC-Unique: XNHpDlb5MySlClJCLwfeIA-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3f496232bso1748875ab.2
        for <stable@vger.kernel.org>; Fri, 01 Nov 2024 07:38:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730471938; x=1731076738;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PjBxXqU+pM0vC60LmXgGLO5qOIRdoqxNpK1lcWYvr1A=;
        b=p37AFf5z+CH8X8PPq/TocNX2H2N4wS+n6J9uMHlxzpiweKX/SF8Vek1/UQJfpdPGlw
         qUUDjGhuX98xiSGGAJZF609FnK7GL0dG7p8ZpQe1lNwG96lbBcauE19NrKMDRnCAEV1s
         JJS3eFu1tcUblJWvgEXxUgCuCpmUZa3DuAgP1ZHadHuEKftVwpIxQoMe84EqrbcD60ln
         /wIMsebPKsG58PDqB1jZfh7zMpfd4rlmBk4lN9gaN7x/xJUlTOHkZ2qJeWyHCwWWNEnk
         ae1tq+Ab/WfyQuZFG1F7z+H16pgULfi15zyGN0/1XBo6tqV8DM/DursLx6Jm/bk75W4/
         hPUw==
X-Forwarded-Encrypted: i=1; AJvYcCU80QA28X68yq5JphIWbNWjgVXtPRyFfrmURuOzyuTH/cOptFKGU309pBIk6RKCaJbjVLyBKGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVG19SbS1IoVJ0LIF+xJewQZeIAadgNpo1shL+HH0vEMmnhx8I
	CcREmscXM9lxSJ6xx731xtWr1Z1SUqiqmBzrpTt3M8noFlpXxFqU6oCASAijqWjA5EvbC+sPp55
	0DWr2UsmSHPG7OPiN8s1fZg1Fhy5d4Wy8xejqEYg/kTGNcdLrXHTzJQ==
X-Received: by 2002:a92:c264:0:b0:3a3:b4ec:b3fe with SMTP id e9e14a558f8ab-3a4ed30ccaamr64455395ab.5.1730471938350;
        Fri, 01 Nov 2024 07:38:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7nZwd4QYd2Kqt6n+Vk5UKw8q+RJ0a/CtlOIPXX1gGRhLlpcRjOUVpYuIqY4BAyZdXiPM68A==
X-Received: by 2002:a92:c264:0:b0:3a3:b4ec:b3fe with SMTP id e9e14a558f8ab-3a4ed30ccaamr64455235ab.5.1730471937957;
        Fri, 01 Nov 2024 07:38:57 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de04acaa2csm748195173.172.2024.11.01.07.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 07:38:57 -0700 (PDT)
Date: Fri, 1 Nov 2024 08:38:55 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc: jgg@ziepe.ca, yishaih@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 kevin.tian@intel.com, xin.zeng@intel.com, kvm@vger.kernel.org,
 qat-linux@intel.com, stable@vger.kernel.org, Zijie Zhao <zzjas98@gmail.com>
Subject: Re: [PATCH] vfio/qat: fix overflow check in qat_vf_resume_write()
Message-ID: <20241101083855.233afee0.alex.williamson@redhat.com>
In-Reply-To: <20241021123843.42979-1-giovanni.cabiddu@intel.com>
References: <20241021123843.42979-1-giovanni.cabiddu@intel.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Oct 2024 13:37:53 +0100
Giovanni Cabiddu <giovanni.cabiddu@intel.com> wrote:

> The unsigned variable `size_t len` is cast to the signed type `loff_t`
> when passed to the function check_add_overflow(). This function considers
> the type of the destination, which is of type loff_t (signed),
> potentially leading to an overflow. This issue is similar to the one
> described in the link below.
> 
> Remove the cast.
> 
> Note that even if check_add_overflow() is bypassed, by setting `len` to
> a value that is greater than LONG_MAX (which is considered as a negative
> value after the cast), the function copy_from_user(), invoked a few lines
> later, will not perform any copy and return `len` as (len > INT_MAX)
> causing qat_vf_resume_write() to fail with -EFAULT.
> 
> Fixes: bb208810b1ab ("vfio/qat: Add vfio_pci driver for Intel QAT SR-IOV VF devices")
> CC: stable@vger.kernel.org # 6.10+
> Link: https://lore.kernel.org/all/138bd2e2-ede8-4bcc-aa7b-f3d9de167a37@moroto.mountain
> Reported-by: Zijie Zhao <zzjas98@gmail.com>
> Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Reviewed-by: Xin Zeng <xin.zeng@intel.com>
> ---
>  drivers/vfio/pci/qat/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/pci/qat/main.c b/drivers/vfio/pci/qat/main.c
> index e36740a282e7..1e3563fe7cab 100644
> --- a/drivers/vfio/pci/qat/main.c
> +++ b/drivers/vfio/pci/qat/main.c
> @@ -305,7 +305,7 @@ static ssize_t qat_vf_resume_write(struct file *filp, const char __user *buf,
>  	offs = &filp->f_pos;
>  
>  	if (*offs < 0 ||
> -	    check_add_overflow((loff_t)len, *offs, &end))
> +	    check_add_overflow(len, *offs, &end))
>  		return -EOVERFLOW;
>  
>  	if (end > mig_dev->state_size)

Applied to vfio next branch for v6.13.  Thanks,

Alex


