Return-Path: <stable+bounces-12340-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 065F08357A2
	for <lists+stable@lfdr.de>; Sun, 21 Jan 2024 20:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 388921C20FF2
	for <lists+stable@lfdr.de>; Sun, 21 Jan 2024 19:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A958383B3;
	Sun, 21 Jan 2024 19:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="epdDM4ab"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4738B38381
	for <stable@vger.kernel.org>; Sun, 21 Jan 2024 19:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705867048; cv=none; b=D+ly5W4sjJ0ty9b6aXYsxbOOWwn8V2M6m94rq1m4pgktp6AgXh7OTtkZVGWd0M8rkQpGV3hxAxxR1vUP26hMLrQdU7jqMXIN/Q/nixMSIOV4YlREPCj0YGLlFs/0lmvRQQ3IWzXE1hELfCT2mmer4C8XaahUV4UqD/Hcxyfi1Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705867048; c=relaxed/simple;
	bh=JoonGw9vQNXaHQmMN+LL9oyTK5rcSC4rZUk0sfhe/Zg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m4n/5JVmOyYsffTQVhAullSyg+KdG2o8hGiFuJoKrSEf+M2HpMEpzLk6GbfXwt/bTzFFFbbOPAu45SkOwdrfhs61HmsT2zsvwFrmaNa+GH+YQO1cBIS9uf9p93URkoht2dp4/b7ZEdxThMP0LvKIRJF/v9in5KTxW0Sb3Zc1C9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=epdDM4ab; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a26fa294e56so243569366b.0
        for <stable@vger.kernel.org>; Sun, 21 Jan 2024 11:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705867045; x=1706471845; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J0/ycZHO2LVW1a2k1bwDkHHCW1t09pgf1oyaA+mSkcw=;
        b=epdDM4abrwA6KWJq3aWm5KQbnlF7cBXEbzDdCto3xWctJYv6xNaOgCn0WqZnH62bFc
         uOnZDIG7fHWZzDWX3mOz490YzkiTN4LatU52ogy43B5SBd0XSxxSgylIRVt16sBRHFDe
         O3qK6ZcwdGavVuQGgdh8PjIe94uegDUOTFBVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705867045; x=1706471845;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J0/ycZHO2LVW1a2k1bwDkHHCW1t09pgf1oyaA+mSkcw=;
        b=LB/YRzjzfKhrbjYgoGMYS6MIBkAaJelDFUyLV5yu9DgYS/R79fFCV8mN4v/RTxbIxz
         uklHtTsOMIkfPrTsutPiISLiJvRNIOIsBsNWy8iwuXQie3LQalX2wnqUKP4Vd4lPkwWq
         1T9xqZDptXqATHhxL8YCta2/lcRdkLj3ALMpH2BAraE/xToL0LbgcijJb6moNhmZ8noZ
         P0By+BPJGqNVUmMj2kG971Sx33fky+71TlNxnk5KNfUo6W10w1tHd+IKCBktD/QTsYq7
         0JJDVD1/G3oeLSYJyu41WAcarBmQzfxnudPe/g0ogQRMZlZjOrVXGJhfztblTvSwBQvo
         WV1Q==
X-Gm-Message-State: AOJu0YxAu1Di+VTZeqXCjrGTTLFKOypLLej+5L3IDPILbIQ0E6Nz0TgI
	/24nEuUt8Dks4kUnc3jugKYTLHUTV0JLeVG1TWqe/U7K9pj3ywjTiHerhPrZt4aK9KQdyyQ+9vn
	kEE5UDg==
X-Google-Smtp-Source: AGHT+IHk+FrtiG63CCfueOQtnm0SEiKK2YvN75yPdm7UUP7iQa003phmlmJYh8tPLAasYoklBFvB9g==
X-Received: by 2002:a17:906:6a24:b0:a30:5beb:d9e8 with SMTP id qw36-20020a1709066a2400b00a305bebd9e8mr163777ejc.36.1705867045322;
        Sun, 21 Jan 2024 11:57:25 -0800 (PST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id vh12-20020a170907d38c00b00a2eb648cdc5sm5849623ejc.156.2024.01.21.11.57.24
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jan 2024 11:57:24 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40eabe33749so6186325e9.0
        for <stable@vger.kernel.org>; Sun, 21 Jan 2024 11:57:24 -0800 (PST)
X-Received: by 2002:a05:600c:56c5:b0:40d:8794:8535 with SMTP id
 ju5-20020a05600c56c500b0040d87948535mr1754394wmb.160.1705867043768; Sun, 21
 Jan 2024 11:57:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240113183334.1690740-1-aurelien@aurel32.net> <fd143cf8-5e3d-4d80-8b53-b05980558e45@xs4all.nl>
In-Reply-To: <fd143cf8-5e3d-4d80-8b53-b05980558e45@xs4all.nl>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 21 Jan 2024 11:57:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgDh18QD_Z6V96J8_gjbSo-7CvGZb9VLRLSL-JD2F8WqQ@mail.gmail.com>
Message-ID: <CAHk-=wgDh18QD_Z6V96J8_gjbSo-7CvGZb9VLRLSL-JD2F8WqQ@mail.gmail.com>
Subject: Re: [PATCH] media: solo6x10: replace max(a, min(b, c)) by clamp(b, a, c)
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Aurelien Jarno <aurelien@aurel32.net>, linux-kernel@vger.kernel.org, 
	Bluecherry Maintainers <maintainers@bluecherrydvr.com>, 
	Anton Sviridenko <anton@corp.bluecherry.net>, Andrey Utkin <andrey_utkin@fastmail.com>, 
	Ismael Luceno <ismael@iodev.co.uk>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	"open list:SOFTLOGIC 6x10 MPEG CODEC" <linux-media@vger.kernel.org>, 
	"Andy Shevchenko'" <andriy.shevchenko@linux.intel.com>, 
	"Andrew Morton'" <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	"Christoph Hellwig'" <hch@infradead.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>, Jiri Slaby <jirislaby@gmail.com>, 
	stable@vger.kernel.org, David Laight <David.Laight@aculab.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 14 Jan 2024 at 03:04, Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> I'll pick this up as a fix for v6.8.
>
> Linus, if you prefer to pick this up directly, then that's fine as well.

Bah, missed this email, and so a belated note that I picked the patch
up as commit 31e97d7c9ae3.

It even got your Reviewed-by thanks to b4 picking that up automatically.

               Linus

