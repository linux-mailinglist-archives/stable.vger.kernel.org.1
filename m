Return-Path: <stable+bounces-121387-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCA3A5699B
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 14:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFCA51887E4B
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 13:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCC221A92F;
	Fri,  7 Mar 2025 13:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3N04IbC"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE6521A459
	for <stable@vger.kernel.org>; Fri,  7 Mar 2025 13:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741355760; cv=none; b=oUSNZ7uUuE0PLrUkxYqAW3/Kygh+CDytM7YU9Jw7OB+RzsuCvVAsbep+Y+o9FU6hQmHa5ctpkZtZwaMr5KTRc2SZdoCVjuBmR7IR0zxgDlA3JOaPhfldTKIIxu58qiUF0IkAffxHfWoM0e1mO9zn/lgaHvNSK57Uh9DZvhiAvQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741355760; c=relaxed/simple;
	bh=BQIxO94xvXdkNO3PXg4UhM+yGFpZA83lzc/Qj5UtOro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNs9Ag4cVGrL7Hej1041e3aiFxkdNxGVYqwGinHUum3/1yYRENnFKfrLGmZvmEIh1BvtKZg1dcgkG6tV0bk4iQKDBaNw6g5MwKoiJmGzmn/fHO8UOM7GrPI5WDty99cnC4ZI7Wdoapkfv0ylMNCJJTslN07eUtHnP8uIeVmp5zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3N04IbC; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43bdf0cbb6bso10648385e9.1
        for <stable@vger.kernel.org>; Fri, 07 Mar 2025 05:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741355757; x=1741960557; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uzboEv0igGnKY+SEuCkCYVRzgehZuYEjrF10nTusinM=;
        b=P3N04IbCZQ38RxKonpskL9hOFT0VTabBQyXz/muY/pZJD+d5ZVljZ3z1aEUUJnZf4f
         +sdsfgcbjASADO2Sp86ZO64I5V5w4F2SgmEmXdXjCQfuPbXzHlqNHxjakDtFz9E42CiW
         Bv27BSekqHEvOqhvMj3vNkGEh4MDXvqy5Mx0pUT/uxP/pTNj55lRC5DaWJFSG3Rm1Swb
         8R+bvv9yPwASMXRsGcceFCJ2cD8o7Fs0jtOFPzi7HXoynpsqvbz4hGEKJgUgWRnWWWP2
         XdXqCzdvEXy4nECdWgcSoO35JAeTczrnMDga7EVEypEG7f/Wk4lsJwCDrXIBEsgVV63A
         8mpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741355757; x=1741960557;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uzboEv0igGnKY+SEuCkCYVRzgehZuYEjrF10nTusinM=;
        b=ZeAZxBF+DZWiOwcU/FN0PsLO/J8w30tKzqgGLzRakljPsQyot5Yd6IhXw3QjShN7JN
         DKmp8PxhOp8axCkKbTFpeVcGzKTAjK/oST7BnpRfu5Ay2fPA0bRbQXX+dmVjyNGfnAJm
         7e9pnej/sYxfgFv74GVb39/iOlyeYHeiWYVigG0CzjWbCtnEHod4pKze0ztI1S4Bb8iG
         +LgTM5wGsxze4J+ptKTl320pNuINWipJFaP5keDZxF0ZPxc7Erg2srZu323mXJZqpbhL
         3ZZDTcbhlZo8F33+6r15Ub5RNUf8GiwL6nBAx1nrL3VTtdohxZjyT1hh29sVVuoQLn6O
         sYVw==
X-Forwarded-Encrypted: i=1; AJvYcCVcvbux+dEjZ0pnoH3jraJsApdir0AUUTt0JTmg1hyIR4rZexBV7IawahSs0BdHUU+18IYk5rU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUZQRT4OKshqgdKw6epU4/DJQc65oJAlaqn+2bCwHZwx3wf8Ys
	747ccMdAmfBfEuB8Xmu5XHFDKP1VVkhMdVjVAqRmVLyHg9UVls0P
X-Gm-Gg: ASbGncuZg8kvf8VELFc7KJ252LP9JUbibUBbABS4DUyd2jxV0KURjFGaE+tdp+eIcxW
	S3zrAfpGVpzOreee1eY8OcmQ3kgQpu1ojBfKQvqW5UROcd3rg0QMA24ohwIX9uMgzhaHIeI30Yn
	KgU1AomVLF6bn+Y6wWg3aUQeWokzcqZwhDyb1+1N3VET/g3uMeXoN1qCnqGerC2WPjNP5ncj0E8
	eA1nK0MDddSRvpah0hpA928S3oXijH7Y28Sb09K4cIpdbRhwFw8N0OGWpsdos0OhgxnMUzZVg++
	wCjWUVgos3ocfOugJLKb1qmcQZ4HX846VJCCl6LoQe+Jfg==
X-Google-Smtp-Source: AGHT+IGThVOOilfP4U6kU+xUizJktbSaTzucqaUtLSLHETFX85viuBUxcT27veRt08YSDmsuVYdX2A==
X-Received: by 2002:a05:600c:1990:b0:439:8523:36cc with SMTP id 5b1f17b1804b1-43c601d9172mr30088185e9.11.1741355756360;
        Fri, 07 Mar 2025 05:55:56 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:a201:48ff:95d2:7dab:ae81])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43bd435c592sm81107535e9.35.2025.03.07.05.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 05:55:55 -0800 (PST)
Date: Fri, 7 Mar 2025 14:55:37 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jared Finder <jared@finder.org>, stable@vger.kernel.org,
	Jann Horn <jannh@google.com>,
	Hanno =?iso-8859-1?Q?B=F6ck?= <hanno@hboeck.de>,
	Jiri Slaby <jirislaby@kernel.org>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH] tty: Require CAP_SYS_ADMIN for all usages of
 TIOCL_SELMOUSEREPORT
Message-ID: <20250307.80ee8ceb5f5b@gnoack.org>
References: <491f3df9de6593df8e70dbe77614b026@finder.org>
 <20250223205449.7432-2-gnoack3000@gmail.com>
 <20250307.9339126c0c96@gnoack.org>
 <2025030708-tidal-mothproof-0deb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2025030708-tidal-mothproof-0deb@gregkh>

Hello Greg!

On Fri, Mar 07, 2025 at 12:05:43PM +0100, Greg Kroah-Hartman wrote:
> On Fri, Mar 07, 2025 at 11:16:21AM +0100, Günther Noack wrote:
> > On Sun, Feb 23, 2025 at 09:54:50PM +0100, Günther Noack wrote:
> > > This requirement was overeagerly loosened in commit 2f83e38a095f
> > > ("tty: Permit some TIOCL_SETSEL modes without CAP_SYS_ADMIN"), but as
> > > it turns out,
> > > 
> > >   (1) the logic I implemented there was inconsistent (apologies!),
> > > 
> > >   (2) TIOCL_SELMOUSEREPORT might actually be a small security risk
> > >       after all, and
> > > 
> > >   (3) TIOCL_SELMOUSEREPORT is only meant to be used by the mouse
> > >       daemon (GPM or Consolation), which runs as CAP_SYS_ADMIN
> > >       already.
> > 
> > 
> > Greg and Jared: Friendly ping on this patch.
> 
> I think my bot found a problem with the v2 version so I was waiting for
> a new one to meet the issues there, right?

I made a submission mistake with the previous patch, which your bot
tripped over, but you already merged it into master and stable as
commit 2f83e38a095f ("tty: Permit some TIOCL_SETSEL modes without
CAP_SYS_ADMIN"):
https://lore.kernel.org/all/2025011205-spinout-rewrap-2dfa@gregkh/

The patch I am submitting here is a new bugfix on top, for which I am
seeking your approval, since the previous patch is already merged.  (I
should have sent it as a new mail thread, I guess. :-/)

(If that helps, I explained the relationship between these different
patches more visually in the table in
https://lore.kernel.org/all/20250307.9339126c0c96@gnoack.org/.)

Thanks,
–Günther

