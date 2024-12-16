Return-Path: <stable+bounces-104348-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBDD9F323F
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 15:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8139F167A14
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 14:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4C4205E04;
	Mon, 16 Dec 2024 14:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bfnpS8kf"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF49205AA4
	for <stable@vger.kernel.org>; Mon, 16 Dec 2024 14:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734358035; cv=none; b=MABnMXamSC5xTEQP2WW8HcvlJeuPG53iRaB3n09Iq/BMpHQ2DZ4PKizD31DaCOzLUx6rQbpIGawURmWVrB6hwTn3T59ZqsGZt8+QN1mLkIrS213mZGBWoRRcXivhmt/CeMyZf0XX56B1rcIW4COkxAt+IQej//bY2w/vZS8MZow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734358035; c=relaxed/simple;
	bh=R0r6kyXtqnw9oAO0kUc+2aV4wsHJJzh2fmz7yt1ZKQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DiG0m7RI745bvy78Cy+qEwssXIdPvRZYnzeAf+mAwFVowEMSGEh4R6Tgf6mGolqcWAtln0KDKKapkj1zI1Elm6OAPLxYcZc7N89Y1FklS68h1PZ8c3T2AebsfCtnhEn82TC2tQwX1ZbiYnlZQ9LoKHeA2eTxGYcnv3or3fZA79M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bfnpS8kf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734358032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vx9u29TJnDx+NQoG8CYOpQFQkYPuT5i21NbIJ3rQxpI=;
	b=bfnpS8kfi5ykgZAlfo5rPgxRphMY/dMO7o3tPF0+szbtViFeNsRmSa9badb47uzHJ4Vgiw
	gVd9BeQeJb7Mhzfj0YpKDifbVXr/HSMQDsX5UpXvzTD4HTo9mL3PxnVH+XUXg8f2WjNug2
	4fWuS/66cEJTNV4R1a/PSBPF17uTUVo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-jd1z3OfWMCqo-If-aFq8Ww-1; Mon, 16 Dec 2024 09:07:11 -0500
X-MC-Unique: jd1z3OfWMCqo-If-aFq8Ww-1
X-Mimecast-MFC-AGG-ID: jd1z3OfWMCqo-If-aFq8Ww
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38629a685fdso1111532f8f.2
        for <stable@vger.kernel.org>; Mon, 16 Dec 2024 06:07:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734358029; x=1734962829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vx9u29TJnDx+NQoG8CYOpQFQkYPuT5i21NbIJ3rQxpI=;
        b=YgHuP1GJfo//hIjxlIhyqQ8CEzJIypUlUco5sNtytjaCBlKy3q+XB2r5W3gFKWcB3D
         BU5e3YRNYiSrhMJS3UHVpqPxfSL2ZopK6NM9pJxstuyWsv+v/vbki74g4X/GXYh9UmA1
         YG5t8Fch4Vxx+7gv7shI30pzibU5W2/BFtb3HLn/RuSrqwnb8HnVfHT7UQISD29j23dc
         2xeioK4iJ5/Lpyl7fOF6g8NcaspkyhvwI76Kux/Ufd/fPUvLe97svzVgCj61Ma+fDJU1
         tBQJoQoG98Z1zBBQFxODK1z8q3oDLEAMCNi0txvJVl0yuCoHGZHw7ciCJ86dDaRIvblq
         b8zQ==
X-Forwarded-Encrypted: i=1; AJvYcCUteBUYT3T1dFohUKvLF5HZFhYf2zAoM99dEeAdku8/vkrE8xM1KHdq1bwjIkRK5EoTxmWPy0U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz84/70JcbChihTHYdd5wOS+sFjoHTbJ8kAipXCZAc61pmIuG3Z
	9we5MnS7CZk2HgPKhKeVLxDIvcYDgk+dNlfl022bdG5bjh4FJFfkWOv1LCVJZqfsJoBnZDwzh/3
	U1Uc3ox2gVyOEcplY7Re5NZ2p6UnTfSxUhh349Mr+SlqLp2jHyDdX6SyqQVNOhw==
X-Gm-Gg: ASbGnctB6ZMCZgN7qDgi1tEXNfhpWCY6w35wdNi6zC/jlVmYOv96pIt+n9JE08vPdBI
	vwF5ndSd0Iu+UqOlnHAAplFCszBJgi39T9XDopnDlsLif1s1v2izNBE88XPUWV2dXqDdAmMeFDw
	owGeaR3o6dDcKZm+XdhRjPmttBoolwT4i4iz9PEU+ducY/jeSYvw7WPzBlsSLMQH1ci1qhHw3X3
	rwmKyijperP0zuXDDPlMU+YLNCkwN5x5Mi4avGUWVguc816saQD
X-Received: by 2002:a05:6000:400b:b0:385:f398:3e2 with SMTP id ffacd0b85a97d-3888e0b8ac2mr10303688f8f.37.1734358029437;
        Mon, 16 Dec 2024 06:07:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyZ0+O4kIxKWHQmAwP9mPVHk0LghHzqDQ6QyhAYSUm6qYdEdlC5E3x4M+gkrrJ6yoDU0YReQ==
X-Received: by 2002:a05:6000:400b:b0:385:f398:3e2 with SMTP id ffacd0b85a97d-3888e0b8ac2mr10303638f8f.37.1734358028978;
        Mon, 16 Dec 2024 06:07:08 -0800 (PST)
Received: from cassiopeiae ([2a00:79c0:644:6900:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c80613a9sm8199671f8f.101.2024.12.16.06.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 06:07:08 -0800 (PST)
Date: Mon, 16 Dec 2024 15:07:06 +0100
From: Danilo Krummrich <dakr@redhat.com>
To: Zhanxin Qi <zhanxin@nfschina.com>
Cc: kherbst@redhat.com, lyude@redhat.com, airlied@gmail.com,
	simona@ffwll.ch, dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Duanjun Li <duanjun@nfschina.com>
Subject: Re: [PATCH v1 v1] drm/nouveau: Fix memory leak in
 nvbios_iccsense_parse
Message-ID: <Z2A0CuGRJD-asF3y@cassiopeiae>
References: <Z1_2sugsla44LgIz@cassiopeiae>
 <20241216130303.246223-1-zhanxin@nfschina.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216130303.246223-1-zhanxin@nfschina.com>

The version after the inital one should be "v2". You can use

git format-patch -v{VERSION_NUMBER} for this.

On Mon, Dec 16, 2024 at 09:03:03PM +0800, Zhanxin Qi wrote:
> The nvbios_iccsense_parse function allocates memory for sensor data
> but fails to free it when the function exits, leading to a memory
> leak. Add proper cleanup to free the allocated memory.
> 
> Fixes: 39b7e6e547ff ("drm/nouveau/nvbios/iccsense: add parsing of the SENSE table")

This should be

Fixes: b71c0892631a ("drm/nouveau/iccsense: implement for ina209, ina219 and ina3221")

instead.

The function introduced by 39b7e6e547ff ("drm/nouveau/nvbios/iccsense: add
parsing of the SENSE table") is correct, but the other commit did not clean up
after using it.

> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhanxin Qi <zhanxin@nfschina.com>
> Signed-off-by: Duanjun Li <duanjun@nfschina.com>

Why is there also Duanjun's SOB? If there is a co-author, this should be
indicated with a "Co-developed-by" tag. Adding the SOB only is not sufficient,
please see [1].

> Signed-off-by: Danilo Krummrich <dakr@redhat.com>

Please don't add my SOB to your commits -- I'll add it when I apply the patch.
Please also see [1].

[1] https://docs.kernel.org/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

> ---
>  .../include/nvkm/subdev/bios/iccsense.h       |  2 ++
>  .../drm/nouveau/nvkm/subdev/bios/iccsense.c   | 20 +++++++++++++++++++
>  .../drm/nouveau/nvkm/subdev/iccsense/base.c   |  3 +++
>  3 files changed, 25 insertions(+)
> 
> diff --git a/drivers/gpu/drm/nouveau/include/nvkm/subdev/bios/iccsense.h b/drivers/gpu/drm/nouveau/include/nvkm/subdev/bios/iccsense.h
> index 4c108fd2c805..8bfc28c3f7a7 100644
> --- a/drivers/gpu/drm/nouveau/include/nvkm/subdev/bios/iccsense.h
> +++ b/drivers/gpu/drm/nouveau/include/nvkm/subdev/bios/iccsense.h
> @@ -20,4 +20,6 @@ struct nvbios_iccsense {
>  };
>  
>  int nvbios_iccsense_parse(struct nvkm_bios *, struct nvbios_iccsense *);
> +
> +void nvbios_iccsense_cleanup(struct nvbios_iccsense *iccsense);
>  #endif
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/iccsense.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/iccsense.c
> index dea444d48f94..38fcc91ffea6 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/iccsense.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/iccsense.c
> @@ -56,6 +56,19 @@ nvbios_iccsense_table(struct nvkm_bios *bios, u8 *ver, u8 *hdr, u8 *cnt,
>  	return 0;
>  }
>  
> +/**
> + * nvbios_iccsense_parse - Parse ICCSENSE table from VBIOS
> + * @bios: VBIOS base pointer
> + * @iccsense: ICCSENSE table structure to fill
> + *
> + * Parses the ICCSENSE table from VBIOS and fills the provided structure.
> + * The caller must invoke nvbios_iccsense_cleanup() after successful parsing
> + * to free the allocated rail resources.
> + *
> + * Returns:
> + *   0        - Success
> + *   -ENODEV  - Table not found
> + */

Looks good, thanks for adding this!

>  int
>  nvbios_iccsense_parse(struct nvkm_bios *bios, struct nvbios_iccsense *iccsense)
>  {
> @@ -127,3 +140,10 @@ nvbios_iccsense_parse(struct nvkm_bios *bios, struct nvbios_iccsense *iccsense)
>  
>  	return 0;
>  }
> +
> +void
> +nvbios_iccsense_cleanup(struct nvbios_iccsense *iccsense)
> +{
> +	kfree(iccsense->rail);
> +	iccsense->rail = NULL;
> +}
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c
> index 8f0ccd3664eb..4c1759ecce38 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c
> @@ -291,6 +291,9 @@ nvkm_iccsense_oneinit(struct nvkm_subdev *subdev)
>  			list_add_tail(&rail->head, &iccsense->rails);
>  		}
>  	}
> +
> +	nvbios_iccsense_cleanup(&stbl);
> +
>  	return 0;
>  }
>  
> -- 
> 2.30.2
> 


