Return-Path: <stable+bounces-100376-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BBE9EAC9C
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 10:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85BCA164056
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 09:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D9C22330D;
	Tue, 10 Dec 2024 09:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aZ9Feg5c"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A012F78F3C
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 09:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823522; cv=none; b=LFljJKnpCf/C7d4z9vBxc0QpnIYyitSiYg6ZFDEQPdYzhxPwX3FU1JZbGGJPdwUvdM9ps+aq+ZXLo6Nn2PoxAyLc+VCQmBmoTlTFpfYpG0rPROpmOzZtWa5bS+kOsIL3dujzBtmmAFlfPj6ZtmeHbsOsvYHHjsONl2aRTpymKqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823522; c=relaxed/simple;
	bh=WjpOIojkgkWpnxEyPeZp1Q6fKJICHzTILcB2Enu3sis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DTK3/1zQTzoV+bi13pAsIWfxB4qWzHCS25NjpBBsuKVcPiLWK2RJ/G5LN2IuRIZR+lV3gI1mwv2//9hMb6WotpMRnTs8qhwNOlu3kRpNMOs8XRRjukttyobrNTBzbjJlaGb5bVJnXOE40QUYoVFCPbzKWcDKcUvKdYB1fMrBtso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aZ9Feg5c; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-725c86bbae7so3068648b3a.3
        for <stable@vger.kernel.org>; Tue, 10 Dec 2024 01:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733823520; x=1734428320; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BjRmYQvTA7kxtBMUl5Qo/AdAWgQX/9nORXlDtE64dqs=;
        b=aZ9Feg5cA5krq2QVYQ4vaC3v+wWyBzJjfq/7fojXi2oHjZm0nPOepWuA85yP+Z+xsj
         74Mc/QB27hWUHZK9lRGPNA9WxnbrbR4HsBA9e1xooxs3NFOcjrH+YSN4NbQTzloGfJOp
         rhK3xjbfmOzOWXnbBRJwh6qiRug4ED7na6/LA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733823520; x=1734428320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BjRmYQvTA7kxtBMUl5Qo/AdAWgQX/9nORXlDtE64dqs=;
        b=VRRPDwTSP4ThaemETcSKNFSYCHJ73eSulcK1Lendi+OopwgGz5G48FzRrDvM8u6+WU
         jat1wI9mJ62YKBGC+MugS//6SxkMF7QtKL3Ne1nmCtHHPNoX+z8iYId8gbCM5QyFdlRI
         bcwtGvikWh4QiBOcnAa3RpkmTgmBijh6gvZcFzVj2YhcErC67aLfKNpeicVanw86NWq8
         EovmDPlPBa5UPJ6um/jW4bTZawcQVD+l5RNTfwUwAupnwIuZdc66ChRNoArADm6akBwt
         r/xrrxOCUt7zwRT2QrssGJRLIEttrrhMrjUKKM/CeZSSs0h3nMr0YofMUCLD0HyEAEF5
         m99w==
X-Forwarded-Encrypted: i=1; AJvYcCVyjaqAzxWyf591MsFON627ojw9UKJVUBAEiMwS7U69NJUbkERbLUsqve1fhaoXk5+6ZtOMC6M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9r51np02+KAyOccKw3patsqG1HEMqsIsNWyLdplTOjJKw0uOT
	yjY6TBe9k2mNxFPylV47Tqs8kjHFbTk8IKGNPsKzMKxBy2+1VfRXPTwQg9Zlew==
X-Gm-Gg: ASbGnctt/ydl2wq7QhvFac9eDRaE6WWcKrLOmsjDKrr9DJFaRYg+uul5bmKAwPSqTav
	3PlojaIvG6QUJu1dx6iKcw2VsPqQ+jvK3n2JARXQhu6hdBYGZkyUluqEpgiPCVxv5yKGN/ykxHR
	2Z8ffLJW6wBkJ0tPSKPd+OIobkO0XngR8luk7RMHf5GIus8UtTWTd/ra85td8oMeaqrMMi2yWZ8
	PMQVp899GAhllDb9YlqPKqF9AZPznVqYHtOqgKr9EK7YoSKDKTDSdUlvA==
X-Google-Smtp-Source: AGHT+IEb8ACl2x/OdhBgRMdOW1Hd76kamKMN7FQrKTcCyTM28/YAs9JuHDB/QXd6FPDBowYh+y9YTQ==
X-Received: by 2002:a05:6a20:d487:b0:1e1:a693:d5fd with SMTP id adf61e73a8af0-1e1b1b1bdb5mr6797786637.25.1733823519939;
        Tue, 10 Dec 2024 01:38:39 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:4d97:9dbf:1a3d:bc59])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd3a268449sm5256997a12.45.2024.12.10.01.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 01:38:39 -0800 (PST)
Date: Tue, 10 Dec 2024 18:38:35 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: mm-commits@vger.kernel.org, stable@vger.kernel.org,
	senozhatsky@chromium.org, minchan@kernel.org,
	caiqingfu@ruijie.com.cn
Subject: Re: + zram-panic-when-use-ext4-over-zram.patch added to
 mm-hotfixes-unstable branch
Message-ID: <20241210093835.GN16709@google.com>
References: <20241130030456.37C2BC4CECF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241130030456.37C2BC4CECF@smtp.kernel.org>

On (24/11/29 19:04), Andrew Morton wrote:
> --- a/drivers/block/zram/zram_drv.c~zram-panic-when-use-ext4-over-zram
> +++ a/drivers/block/zram/zram_drv.c
> @@ -1633,6 +1633,7 @@ static int zram_write_page(struct zram *
>  	unsigned long alloced_pages;
>  	unsigned long handle = -ENOMEM;
>  	unsigned int comp_len = 0;
> +	unsigned int last_comp_len = 0;
>  	void *src, *dst, *mem;
>  	struct zcomp_strm *zstrm;
>  	unsigned long element = 0;
> @@ -1664,6 +1665,11 @@ compress_again:
>  
>  	if (comp_len >= huge_class_size)
>  		comp_len = PAGE_SIZE;
> +
> +	if (last_comp_len && (last_comp_len != comp_len)) {
> +		zs_free(zram->mem_pool, handle);
> +		handle = (unsigned long)ERR_PTR(-ENOMEM);
> +	}

I don't think this needs to be this complex.  A simple -ENOMEM should
work, that's the default handle value in this function.

Andrew, can you please fold this in?  (Or we can just ask for v2)

---

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 52a005face62..5de7f30d0aa6 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1674,7 +1674,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 
 	if (last_comp_len && (last_comp_len != comp_len)) {
 		zs_free(zram->mem_pool, handle);
-		handle = (unsigned long)ERR_PTR(-ENOMEM);
+		handle = -ENOMEM;
 	}
 	/*
 	 * handle allocation has 2 paths:

