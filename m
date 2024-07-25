Return-Path: <stable+bounces-61779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 920A693C77B
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 18:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C309F1C218FD
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 16:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40091990CD;
	Thu, 25 Jul 2024 16:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YbD29a8n"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AC419D087
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 16:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721926752; cv=none; b=Vk5IH6BbuGFV1i3HL754EhPMVWPbXOWJIWjCvqxists1sKLd2SbUl7spuqb6AXgY6DFd3nsesYX93MaSTzN1Dct0tM92hcJ27nzTYyRBH3xmf0vHVro5oo3KiO9yJgHk0zLL0NkY4qSpsZ+2o1VDZnzwsgJY5dufU0p5fcNfe20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721926752; c=relaxed/simple;
	bh=zbz2uz2X/Qj5LK8ZHZYiF+bV5FFXK8uOhdFiKgWEdrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tqid0RHTE0ZYR7vKc/4YyKbmOWefMyX/foEI6uKLWPbLa2P+lHcMTbFUYwqKBGPYFEP8sZZf4K8uNcIyxqh1yhYEmx0OWingfB5TjIl79hMEkWlC24V7anbLd/tL3YxtKUp2/Aw7HmT0vYSHio1jDGQVjZtV/LRAZt8s6KYZ6So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YbD29a8n; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a3458bf989so1420052a12.0
        for <stable@vger.kernel.org>; Thu, 25 Jul 2024 09:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721926749; x=1722531549; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=otHL7EsRGMXAdCY+bJE7Pic8AIGF/rLoS3HxdujJZJo=;
        b=YbD29a8nsJ2CT7AMpTH6uABnLP7pK8DiluODlOhEPispbCF9GN9m8VggiXY0bK/Zkw
         4V24SfQHtsu4KnCj0FWm3MlyydaAg1FzBoSe3jTo3rjCH5D+XWqzBfEJu39M2Z3nvahM
         /K3t5kU8OzlDgAYh7vjBSw4+ABIIBt6f0Tqjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721926749; x=1722531549;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=otHL7EsRGMXAdCY+bJE7Pic8AIGF/rLoS3HxdujJZJo=;
        b=lf2ypk4+CO80h0Y9aYpj8JTwG7Q/fu7amj5mSdZ0LZzFZbHHiuxMeujwjwdzfX7Efd
         ZFeYdrpYLpRK2pYuWwDyOe9oqH+TAxM29+ONGbBHJBuPD/o8oWXVCypdwGK8xV9NHIiO
         4cwK8D/a/UVjUkY8B6SkOedA4aIl1imXii0DhLqGsxwi2BraWg+x/ZM+Ak+gExn7I//Y
         QnHeXhXpt6af6sIukdKkgRE4E5O/M9UTyiivSZpRMDu+QbfLyQRKy4nIx2oEwlcy5HQY
         KY+DPYRhdx5lrwvd9q/OnkXxXZGljB0EEp4GMq4igYcuidQa6O38D2if/28ZHzYYxL84
         LdDw==
X-Gm-Message-State: AOJu0YyRtC3988t26shbrOR39YNato/FqLdaDY7CPVkSkKgJIASkAfHL
	Jm5/yKm0lBbxFM4bFeqCfs36HnUQZLCijN1mCHlkcBwma7atRQNrq75O+aT14UwM4NdghLo9OHB
	YyLk=
X-Google-Smtp-Source: AGHT+IEcXPpA24DgkUBnSlW/Bez1Y341Iyj9GLcssovBBPaKVpZokelSizrb4VlUIw3YQ1UlnaxhHA==
X-Received: by 2002:a17:906:24da:b0:a77:db97:f4fd with SMTP id a640c23a62f3a-a7ac4f21a02mr188216666b.34.1721926749315;
        Thu, 25 Jul 2024 09:59:09 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab52d46sm90858566b.80.2024.07.25.09.59.07
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 09:59:08 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7a8553db90so99092866b.2
        for <stable@vger.kernel.org>; Thu, 25 Jul 2024 09:59:07 -0700 (PDT)
X-Received: by 2002:a17:906:dc95:b0:a79:8149:967a with SMTP id
 a640c23a62f3a-a7ac4de31d8mr293056566b.16.1721926747586; Thu, 25 Jul 2024
 09:59:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725142738.422724252@linuxfoundation.org> <20240725142741.075359047@linuxfoundation.org>
In-Reply-To: <20240725142741.075359047@linuxfoundation.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 25 Jul 2024 09:58:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=whsVLP==D=VYGJUpuWaNbcB_nW-ZR5XBs_RddXgtLRiGA@mail.gmail.com>
Message-ID: <CAHk-=whsVLP==D=VYGJUpuWaNbcB_nW-ZR5XBs_RddXgtLRiGA@mail.gmail.com>
Subject: Re: [PATCH 5.15 70/87] minmax: relax check to allow comparison
 between unsigned arguments and signed constants
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	David Laight <david.laight@aculab.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Christoph Hellwig <hch@infradead.org>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, SeongJae Park <sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Jul 2024 at 07:55, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 5.15-stable review patch.  If anyone has any objections, please let me know.

I assume the min/max patches had some reason to be backported that is
probably mentioned somewhere in the forest of patches, but I missed
it.

It's ok, but people are literally talking about this set of patches
causing a big slowdown in building the kernel, with some files going
from less than a second to build to being 15+ seconds because of the
preprocessor expansion they can cause.

               Linus

