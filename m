Return-Path: <stable+bounces-83326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29144998344
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 12:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 582CF1C22DE1
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 10:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6BB1BDAA5;
	Thu, 10 Oct 2024 10:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="URwVLTPQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2921BF300
	for <stable@vger.kernel.org>; Thu, 10 Oct 2024 10:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728555065; cv=none; b=fTebLohMIbR0aFDJSzK2GlsNGhMXhsVh4BH7+dRHAqP2k+acRy/U7kbY+Kot93kxpkESnHvB60bTuENs+4XdMu8cVuQRsvic28Y/xyp1t4SB4KR8fXhxd6pHcvSFfjlbdippuJrR/FpBTYEtPuO9iWFuQarMyin9+fYYRepIdLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728555065; c=relaxed/simple;
	bh=2ZUtIX4eYIQT5jV6iYRcmEhTUULvAj4mCFnTN4cpGUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GZsK0dYGPuBQeld7YCzGrmqLHNbVyN4F0jFTBQ3Ovs06UPyhbtqIulyzWF6f/ClHPMyLiYVCKnsMRL8tqDuby62nXw3id4Mh0dxXUIgMWfbwTqQ7WRZJoQX+hmaQh6XvgoBI/78lag2NJ3nEl+QLBsMIbUfMf3gjNvE/kWwUQKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=URwVLTPQ; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c3df1a3cb6so119021a12.2
        for <stable@vger.kernel.org>; Thu, 10 Oct 2024 03:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1728555060; x=1729159860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6ny9nAyyOl7SJdnU7HLlJ1EiMW7cD0xQVIs0CZ9wvw=;
        b=URwVLTPQrJH8sKoGJ3Jl7YoNi98iukqk4nxBERtNTqYpXiza7S89N+UC6WGycyeNkZ
         bkrOWurKcxQ4dEJ2DHyIZd+rw3+RGoFGV+8Iw1i/y1M4dnK99MenAr0Gu6XV0AW9nhOk
         x/y5tqJsx7DGTYt/faM4psx1dTfmwo42TdqL0N523s9lPlrPugIONfaUHqEg08oR0suS
         RXEEyHCODZPmwKe5JeoG0IUsE+63wXGUxsRonMJn1s8M//r6Hpi6p7G2h7PxI0QFZeYz
         KSk30k3k4RZJ9MRy2qUn0gDJ5gkVNxx3L/fh461tQP3lvBxoBWjuhrn+GgpgL8XnUUct
         G8iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728555060; x=1729159860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L6ny9nAyyOl7SJdnU7HLlJ1EiMW7cD0xQVIs0CZ9wvw=;
        b=jtaATC+FOrisDCBWX9gma0/xbLid6xFynJm3h7I3xLZfdm6w2SdVcIVZhYAlQXXIQ7
         r6yYYCG2ClEaksWv+LY+mYeO2HsFlArugxhj2CTdA/8tbO76WixPmNvuVWEZ5sDlCUkD
         /XvC275LQttMzO4d94Wwe7V7T2+1dezWv2HURDrvxe11zSXHrAluFO3Z0F7wJ0ZRkYU5
         2tsUpnONDJxNX/AW0AbePxquHDsSu/JsfH31Q9MBAnat5LRSIUGJ4x6llaTTgFfpmEDv
         tuGVHvUzF527vDnOuCpkNycmh1rVITvI8Rcg1sEEAKceZsTs2No7D6BKa1ROUQI2oSf7
         JgsA==
X-Gm-Message-State: AOJu0YyP5JwRWjwBVyfHwXOH1UX9ZLprG5dqQoUpZtXMrYO4Jh1fiMhX
	EZLTIDKrRQpnO4xraUeI6K/GNrmuYsRn2NZwP2+kdKlFDKSjypq0ZwNJcdlsjFwMlOJrPj8xGdD
	6DCc3xFNfHepa9rI+56uYtfrOEMMH/ExuexToLg==
X-Google-Smtp-Source: AGHT+IFLhXXjnEmegvRiWI00Ssg29zpRgLGkrkI2ec1uUSg0oyjgVZ/d8xl1zhhexnQJ9j32IL+XsvvX5ES2v/z9QzM=
X-Received: by 2002:a05:6402:3512:b0:5c8:aecf:8e87 with SMTP id
 4fb4d7f45d1cf-5c91d6992d1mr1661101a12.9.1728555059750; Thu, 10 Oct 2024
 03:10:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMGffE=dPofoPD_+giBnAC66-+=RqRmO2uBmC88-Ph1RgGN=0Q@mail.gmail.com>
 <2024101006-scanner-unboxed-0190@gregkh> <CAMGffE=HvMU4Syy7ATEevKQ+izAvndmpQ8-F9HN_WM+3PKwWyw@mail.gmail.com>
 <2024101000-duplex-justify-97e6@gregkh>
In-Reply-To: <2024101000-duplex-justify-97e6@gregkh>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Thu, 10 Oct 2024 12:10:49 +0200
Message-ID: <CAMGffE=xSDZ8Ad9o7ayg2xwnMyPDojyBDh_AHf+h7WBV7y630w@mail.gmail.com>
Subject: Re: [regression]Boot Hang on Kernel 6.1.83+ with Dell PowerEdge R770
 and Intel Xeon 6710E
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable <stable@vger.kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	baolu.lu@linux.intel.com, jroedel@suse.de, Sasha Levin <sashal@kernel.org>, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,


On Thu, Oct 10, 2024 at 11:31=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Thu, Oct 10, 2024 at 11:13:42AM +0200, Jinpu Wang wrote:
> > Hi Greg,
> >
> > On Thu, Oct 10, 2024 at 11:07=E2=80=AFAM Greg KH <gregkh@linuxfoundatio=
n.org> wrote:
> > >
> > > On Thu, Oct 10, 2024 at 09:31:37AM +0200, Jinpu Wang wrote:
> > > > Hello all,
> > > >
> > > > We are experiencing a boot hang issue when booting kernel version
> > > > 6.1.83+ on a Dell Inc. PowerEdge R770 equipped with an Intel Xeon
> > > > 6710E processor. After extensive testing and use of `git bisect`, w=
e
> > > > have traced the issue to commit:
> > > >
> > > > `586e19c88a0c ("iommu/vt-d: Retrieve IOMMU perfmon capability infor=
mation")`
> > > >
> > > > This commit appears to be part of a larger patchset, which can be f=
ound here:
> > > > [Patchset on lore.kernel.org](https://lore.kernel.org/lkml/7c4b3e4e=
-1c5d-04f1-1891-84f686c94736@linux.intel.com/T/)
> > > >
> > > > We attempted to boot with the `intel_iommu=3Doff` option, but the s=
ystem
> > > > hangs in the same manner. However, the system boots successfully af=
ter
> > > > disabling `CONFIG_INTEL_IOMMU_PERF_EVENTS`.
> > >
> > > Is there any error messages?  Does the latest 6.6.y tree work properl=
y?
> > > If so, why not just use that, no new hardware should be using older
> > > kernel trees anyway :)
> > No error, just hang, I've removed "quiet" and added "debug".
> > Yes, the latest 6.6.y tree works for this, but there are other
> > problems/dependency we have to solve.
>
> Ok, that implies that we need to add some other patch to 6.1.y, OR we
> can revert it from 6.1.y.  Let me know what you think is the better
> thing to do.
>
I think better to revert both:
8c91a4bfc7f8 ("iommu: Fix compilation without CONFIG_IOMMU_INTEL")
586e19c88a0c ("iommu/vt-d: Retrieve IOMMU perfmon capability information")

unless other guys have a different opinon.
> thanks,
>
> greg k-h
Thanks!

