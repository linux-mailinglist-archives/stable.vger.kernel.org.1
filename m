Return-Path: <stable+bounces-67717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF279524CF
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 23:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E49AF1C22CEB
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 21:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FEC1C8232;
	Wed, 14 Aug 2024 21:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJQ99KhU"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233451BE85F
	for <stable@vger.kernel.org>; Wed, 14 Aug 2024 21:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723671023; cv=none; b=Hp3Qqh1m+n+W2hmCQGCH2v5BtycwSWecd2E4w1v9oD3XMtREMIlOgje3jO9Bt1OSpQlE8rAn1dBt3Npul3eq7oLbd03yjADHIIuUMscJOxh0dgPNH4r0WLd112uqzaH+E2vgJ3C94Wkl2DufWV4ZNtp18YcPMLvsVhN3UpWK9iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723671023; c=relaxed/simple;
	bh=jDP0WeUn8pqi8uBL9YVkn/FzJaNBB/i2IA/j0/4ZwOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uSa3IDNJ7jaHIYq3mkWqR1FWYQfFsZTZCnCqC3/i68ON+dh1mqG8VBbKCYT597xWbfDAR0APxWi7FQ5koLsq1v9jyNk4cs8Ke+0DI5U/F6vsEFxC33Q+w62JFxbJWBWTBV52FnsCXf9wRejD+zdU9fj4slybQtFv8eiuuUY+OxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJQ99KhU; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fd90c2fc68so2755395ad.1
        for <stable@vger.kernel.org>; Wed, 14 Aug 2024 14:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723671020; x=1724275820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NsHo05PbFGthvrcP1w5YnBAGWCrQpMiSVu6yHBZxoE=;
        b=iJQ99KhUyAvtJ10tOQnfLcb0TKCuQ5/i+qiMX/wc/R9iFvqrOIRZP5E2kxAhTGlk3G
         nLaoMZLukK5Hcgzz+y/UBZ0in6hMs3W8vmKE9rjQs+/VYRRXgpmTPhl4k49EycFcRTEX
         QkK9Y1Qmz7m8Z6NojyZM3qhvEraYuIjKi4LootY0stOlXzxwHr/0fHDltyLcofKgmezL
         NGPgKQJu7t/CWUB4nQ4O1krdLmSdN3flSKg3s10zBvYUIVdEkz4/VdIfI/b/cmcz8Sol
         8y3pyzA65+0rBukp9W5iffDU+poVaHKpttRgSyJkK6NweoW/6ytRsYd53MuYaR7nvFtW
         BdlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723671020; x=1724275820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1NsHo05PbFGthvrcP1w5YnBAGWCrQpMiSVu6yHBZxoE=;
        b=nZT+xKAqf1Od/Uq5dWprYFry9XOQMXJzo7IfpP5851Ix+psskUsKqWrAQ8PnTADYg6
         tzrNCApwoL1faHnZzOtdPrbA1BUlwjdlwA1yQ0IvLpIlI5srWpypBbWry/OXQIwRPybA
         SdvuhwjLnoJgCoSBaoLVn9+ERXciSo9WPiiDhZLWcnLcOujyTxEmluLEUPE0Ug8E0/a8
         c+vUJEyt6bgNRdFkjfkgx6l77v2tspjx7hyKyB4mYkdxuTq1/DYKFOCQqybi1TaJ/p2s
         b1coYFvF31WW4oRbGY31mEOgEBYQDnQxdssJzC2RZ8HBXIJmHajdNdrBQYNZrRYhclRb
         nw6g==
X-Forwarded-Encrypted: i=1; AJvYcCV4lNqtHkJ745xc1FRh0Bmz9JsIoWZiLGFGPOdxq4fNwSGdn9PmGobM9S1/17v9YU7/i+I9mLWcLpzlA6VvhajbtS6rGZuo
X-Gm-Message-State: AOJu0YxK7vDaxG07CcJ1YTHFQeNoYtvDh7wpjCwYlEo9PXw2OcBs7gtx
	anzZQ9j9ErdmtV3NWc+utgMuCmbQ6tzn0qH5qrTdyvfiweu+pwowB326ThuWZ+Tdob68A/rtNcG
	ifrgYYaT8hUaSNZ+5boN7enldWPA=
X-Google-Smtp-Source: AGHT+IGO/6VFtbWnQmfGb+Soi+oj2GvKapSaNMUWtUjMTaIk9DGw3xSWQGUT3mrpqp6wi8a+/6CwpbhvPC7P1WDaC5U=
X-Received: by 2002:a17:902:e544:b0:1fc:6a13:a394 with SMTP id
 d9443c01a7336-201d63bacdfmr62422645ad.23.1723671020124; Wed, 14 Aug 2024
 14:30:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024081247-until-audacious-6383@gregkh> <07bbc66f-5689-405d-9232-87ba59d2f421@amd.com>
In-Reply-To: <07bbc66f-5689-405d-9232-87ba59d2f421@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 14 Aug 2024 17:30:08 -0400
Message-ID: <CADnq5_MXBZ_WykSMv-GtHZv60aNzvLFVBOvze09o6da3-4-dTQ@mail.gmail.com>
Subject: Re: AMD drm patch workflow is broken for stable trees
To: Felix Kuehling <felix.kuehling@amd.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, amd-gfx@lists.freedesktop.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 4:55=E2=80=AFPM Felix Kuehling <felix.kuehling@amd.=
com> wrote:
>
> On 2024-08-12 11:00, Greg KH wrote:
> > Hi all,
> >
> > As some of you have noticed, there's a TON of failure messages being
> > sent out for AMD gpu driver commits that are tagged for stable
> > backports.  In short, you all are doing something really wrong with how
> > you are tagging these.
> Hi Greg,
>
> I got notifications about one KFD patch failing to apply on six branches
> (6.10, 6.6, 6.1, 5.15, 5.10 and 5.4). The funny thing is, that you
> already applied this patch on two branches back in May. The emails had a
> suspicious looking date in the header (Sep 17, 2001). I wonder if there
> was some date glitch that caused a whole bunch of patches to be re-sent
> to stable somehow:

I think the crux of the problem is that sometimes patches go into
-next with stable tags and they end getting taken into -fixes as well
so after the merge window they end up getting picked up for stable
again.  Going forward, if they land in -next, I'll cherry-pick -x the
changes into -fixes so there is better traceability.

Alex

>
>     ------------------ original commit in Linus's tree
>     ------------------ From 24e82654e98e96cece5d8b919c522054456eeec6 Mon
>     Sep 17 00:00:00 2001 From: Alex Deucher
>     <alexander.deucher@amd.com>Date: Sun, 14 Apr 2024 13:06:39 -0400
>     Subject: [PATCH] drm/amdkfd: don't allow mapping the MMIO HDP page
>     with large pages ...
>
> On 6.1 and 6.6, the patch was already applied by you in May:
>
>     $ git log --pretty=3Dfuller stable/linux-6.6.y --grep "drm/amdkfd: do=
n't allow mapping the MMIO HDP page with large pages"
>     commit 4b4cff994a27ebf7bd3fb9a798a1cdfa8d01b724
>     Author:     Alex Deucher <alexander.deucher@amd.com>
>     AuthorDate: Sun Apr 14 13:06:39 2024 -0400
>     Commit:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     CommitDate: Fri May 17 12:02:34 2024 +0200
>
>          drm/amdkfd: don't allow mapping the MMIO HDP page with large pag=
es
>     ...
>
> On 6.10 it was already upstream.
>
> On 5.4-5.15 it doesn't apply because of conflicts. I can resolve those
> and send the fixed patches out for you.
>
> Regards,
>    Felix
>
>
> >
> > Please fix it up to NOT have duplicates in multiple branches that end u=
p
> > in Linus's tree at different times.  Or if you MUST do that, then give
> > us a chance to figure out that it IS a duplicate.  As-is, it's not
> > working at all, and I think I need to just drop all patches for this
> > driver that are tagged for stable going forward and rely on you all to
> > provide a proper set of backported fixes when you say they are needed.
> >
> > Again, what you are doing today is NOT ok and is broken.  Please fix.
> >
> > greg k-h

