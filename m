Return-Path: <stable+bounces-166480-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4130FB1A17E
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 14:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F134F188BC44
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 12:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F6A2550D0;
	Mon,  4 Aug 2025 12:34:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC7F156228
	for <stable@vger.kernel.org>; Mon,  4 Aug 2025 12:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754310857; cv=none; b=fg+trzFjmZ7/jyr0U0cxLu6zM8AcpwwahkDq3ABcxbb0/YBJGXQt01ua94J0FJa0d8thnRU2+U531z6kfjhgccbo2youvpJ3DYOAg9gaf52rikbtFWufTbu+leHZZ6Z0uNq5nkrQQZBeS8Ef4LIcEE57yq/+I5N5QHcXlvXHvSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754310857; c=relaxed/simple;
	bh=fcJzP/9/e6F+zsAx2xJXJXbGjsmtrULT3/IuUM37nhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=imwne24jM/WPsSltyBoHtMIMKQOr84TSSOU7S6V3LGacdWX+5qcIlR6hrBxVZqrp6/sm0vsRP+ZazGTwNhJlGslyPgzDQ8u4JJIqVVetm9xDd86Sx7yQR6TrDy8AC7aWqMdIyTjfZQjyd3xO18+Lg6tYCW0E7PxTBtVi06fQHLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-af93150f7c2so541717466b.3
        for <stable@vger.kernel.org>; Mon, 04 Aug 2025 05:34:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754310854; x=1754915654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fcJzP/9/e6F+zsAx2xJXJXbGjsmtrULT3/IuUM37nhI=;
        b=C7wPGp84HGUh9+NWMfQ1z6Iw/2K2gb41qnbuuoCBYFQqMzNN+fbwSWW4drxKwy4LTm
         DCuYiBpvDzcm0PE9XM2CvVubEXd/xNavZfdleo7eFS/vbqXXlgPlnGXxyH3DdNNbyRm3
         FThCiYUgmKQlG9uFZqWw7OXNJhOnSe0BmMesizJC9UCM0tHjm53dkQeDYCuUMseoKGXT
         RU3F8pB5nN7agnMG8MGIa3JzMY7VGCgKnqUV7ouln1wdIR5+5xIG0ZO30Kn9aS472fvP
         07QBVfESztilkRj3nRHfZyoQNsu2B67zqom/umDve5/cAwjMmpOjWA5vmMLgAY51lK4C
         qNog==
X-Forwarded-Encrypted: i=1; AJvYcCV9J4CfoBesCJ6VNVUjPFeawRX20DzN0harBXHK6Gf7S+Hm84n+aH25o0xc23JVGfU92epG6SY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2l8fh88cZ/8rznEDElFcLgGQv+euJ8OPf7HY3e8twbOtVbebd
	arilwjkNi3rycqvLPs3hyL84cWLR3XvqYUKZXsUOzvZPB4g4YhB2ZcAV
X-Gm-Gg: ASbGncuk/yJwWWvSYJb962ltrjKIBDI9dkirx4/tYMGP9SB6oucwm5ZceoBmT48hcfI
	WiQqiuQV3hGS0zSxT2w6EKxzjndvzgrs/vceIxWb10Jo3Sy6ET1P8OgBHn8MArOy5HGfo16iWeO
	D8B0G8BkyjMD5Q3MAA72w0v+Ts/9v+7FahU2gVyXwlD44Q7rXrThDGUM0nUBkeC5RAw6tnvZECz
	LUg2R0Gh4UXnV93jZPVIsmYktid7mJG6O3cLDsLAO2zcEnkGRXscNuJDX4rxJjqtwmajVaCsGrH
	zFFI1JyC8HgHz293n81jN+RO7uzyg+02YbgAhLMccWv/J3wPpTPsRJu7iDyczVVlesk72u8d5Vj
	dnjdJDvEEjpZ3kQ==
X-Google-Smtp-Source: AGHT+IECUNouT2U9h5TI6BInd7LsnZbMx7FCXQ9fV1tWe0f3xyBoO4sFI73N95UIyrcsouvL8Lh1TA==
X-Received: by 2002:a17:907:2da5:b0:af9:38ed:5b37 with SMTP id a640c23a62f3a-af93ff9ffa0mr898859366b.6.1754310853621;
        Mon, 04 Aug 2025 05:34:13 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a1e833dsm717785566b.64.2025.08.04.05.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 05:34:13 -0700 (PDT)
Date: Mon, 4 Aug 2025 05:34:10 -0700
From: Breno Leitao <leitao@debian.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Waiman Long <llong@redhat.com>, Gu Bowen <gubowen5@huawei.com>, stable@vger.kernel.org, 
	linux-mm@kvack.org, Lu Jialin <lujialin4@huawei.com>
Subject: Re: [PATCH] mm: Fix possible deadlock in console_trylock_spinning
Message-ID: <o2gpvdtxqrdfrsbayorvzvjqcreb45puojpgfye7dimbuuvbdt@gxquukahrxo7>
References: <20250730094914.566582-1-gubowen5@huawei.com>
 <20250801153303.cee42dcfc94c63fb5026bba0@linux-foundation.org>
 <5ca375cd-4a20-4807-b897-68b289626550@redhat.com>
 <20250801205323.70c2fabe5f64d2fb7c64fd94@linux-foundation.org>
 <aJCir5Wh362XzLSx@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJCir5Wh362XzLSx@arm.com>

On Mon, Aug 04, 2025 at 01:08:15PM +0100, Catalin Marinas wrote:

> I'm surprised we haven't seen these until recently. Has printk always
> allocated memory?

I can talk about netconsole, and the answer is yes!

weird enought, lockdep never picked this issue, and I have a few set of
hosts running kmemleak and lockdep for a while.

This time was different because I have decided to invstiage the code,
and found the deadlock. Still, no lockdep complain at all.

