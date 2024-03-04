Return-Path: <stable+bounces-25857-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 428AE86FC77
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 09:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73CE21C20A7F
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 08:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9499620323;
	Mon,  4 Mar 2024 08:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fSdFNQiu"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CE938F99
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 08:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709542298; cv=none; b=UCw3GuPghoWS2lFdWOnIHZz5+aDqBrBubbEzhEmbRdkSITz7rTjDk1laFqJHnQ3TLbiS6J2EaNHKE7mbOHBC27WtcVOxFRkyl5EzoTmGe1F4iLRJcw86vjyGis7SH6di4gzuJ2//mH2+wAzzKNiqqSwvTCTkPxqlV3FgaKFpXHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709542298; c=relaxed/simple;
	bh=FUqDuqDK3jaXfLxLku5xeZANK3Ia+SXCSM50KWYNtZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AmjrnSCfnQhhy6H1WFxiOPDpzvJNhu76djA0R/DDujddUgDxvofYJ9StnJWmAzHOENHAuSFs/AsxdFboJQ/e3UA2NEVODqauZ7wy2DkXcG6OSYODchUtCiCbRiHy7dFxvWI1xrQl2kPx/Y6Dx/ah4vels5Ce9JvVDNCWFJnYxTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fSdFNQiu; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d109e82bd0so48374691fa.3
        for <stable@vger.kernel.org>; Mon, 04 Mar 2024 00:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1709542294; x=1710147094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28qkoOsNR9DkErTLbvnZcDZ96cMGlVImyXbURgCupu8=;
        b=fSdFNQiu/U3VmlcXbV6xBvoJyw9hwTscaEbogbl327Q7jkz3l8QahRbivLGGWZ4e7l
         rtl67kb+LiM4CO97c+nLl99HxWByN+zdw2XEPoWJhSuhR/ZyrgnLHrdoBEKobl/GWxkE
         oWYJ58rkGpOoV5s310UdgabNceCzszDJ6k0jo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709542294; x=1710147094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=28qkoOsNR9DkErTLbvnZcDZ96cMGlVImyXbURgCupu8=;
        b=WF07EWwMCud1/KI5yLBELCcC/IPZdN46fC0ffEbs6Abtp9buTpA56rVwH0bQp1wyXH
         Lwq6Wsvr43PeGpjv0SeRhM8C86pWekEqWOjVUB4wW5j7ow7MNtlLD0cK/EsjQnzW7zY6
         BujaiJGbyj8Pauy9yUWb4KRtj5UZHwRQInxQ5Yvu3qZ0wefajd5etL9C5tB2t3vFOcHX
         6UJNzXzTjtPqLv2MnpA41IbAaK65lKYBFx03IUSqt0/dKt0IAGndIOJvT8Jb6SvZwb8p
         as02MWY6biLzHpB+6FQeD9t9RYvgr5FzkWuvIPsfR1tx3pIIj8nFhub+PdxxJ9zUJNaf
         5vow==
X-Forwarded-Encrypted: i=1; AJvYcCXdu/Uxtg3jC4kvsocngt/eqx7NZPBKWSP4NW99iO6SlYI3l8F19K5sBeVQQH8IvHiMLcmAQm9w30twZhVwH+Jd5gcG0wHL
X-Gm-Message-State: AOJu0YySLcry/UUZSCygxhLCCvw8kdrD0eEuFrsVPyXhIYAZ/dRvsojw
	icMWYNbD3zqTPcvNqpsq1b8wkA/JWloljyp4DK5dR40dLvfCTcrz+XaZzBI9Fk+z9AuvuYZcrl0
	zAEC4JxAupVSJwxY7t1YdM1O2rS302Q/bKmxq
X-Google-Smtp-Source: AGHT+IHTHKLt/XKBNuXCKoQzD3d0EVWAzRXMQe64uQR7CdtYWihtA7DJhqYa9jFgo7XGcqDVJSwpOBIQ8SecXFO3gLk=
X-Received: by 2002:a05:6512:3da9:b0:512:8a87:cbef with SMTP id
 k41-20020a0565123da900b005128a87cbefmr6728992lfv.41.1709542294430; Mon, 04
 Mar 2024 00:51:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024022817-remedial-agonize-2e34@gregkh> <20240228184123.24643-1-brennan.lamoreaux@broadcom.com>
 <CAD2QZ9YZM=5jDtqA-Ruw9ZcztRPp6W6mZj9tA=UvA5515uYKrQ@mail.gmail.com> <2024030407-unshaven-proud-6ac4@gregkh>
In-Reply-To: <2024030407-unshaven-proud-6ac4@gregkh>
From: Ajay Kaher <ajay.kaher@broadcom.com>
Date: Mon, 4 Mar 2024 14:21:22 +0530
Message-ID: <CAD2QZ9YPmo3X+q8g+_zHd+=Y=_qKFa+xSgvwfTC3dZ0KhiMyOA@mail.gmail.com>
Subject: Re: Backport fix for CVE-2023-2176 (8d037973 and 0e158630) to v6.1
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>, stable@vger.kernel.org, 
	phaddad@nvidia.com, shiraz.saleem@intel.com, 
	Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Vasavi Sirnapalli <vasavi.sirnapalli@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 12:14=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Thu, Feb 29, 2024 at 02:05:39PM +0530, Ajay Kaher wrote:
> > On Thu, Feb 29, 2024 at 12:13=E2=80=AFAM Brennan Lamoreaux
> > <brennan.lamoreaux@broadcom.com> wrote:
> > >
> > > > If you provide a working backport of that commit, we will be glad t=
o
> > > > apply it.  As-is, it does not apply at all, which is why it was nev=
er
> > > > added to the 6.1.y tree.
> > >
> > > Oh, apologies for requesting if they don't apply. I'd be happy to sub=
mit
> > > working backports for these patches, but I am not seeing any issues a=
pplying/building
> > > the patches on my machine... Both patches in sequence applied directl=
y and my
> > > local build was successful.
> > >
> > > This is the workflow I tested:
> > >
> > > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linu=
x.git/ linux-6.1.y
> > > git checkout FETCH_HEAD
> > > git cherry-pick -x 8d037973d48c026224ab285e6a06985ccac6f7bf
> > > git cherry-pick -x 0e15863015d97c1ee2cc29d599abcc7fa2dc3e95
> > > make allyesconfig
> > > make
> > >
> > > Please let me know if I've made a mistake with the above commands, or=
 if these patches aren't applicable
> > > for some other reason.
> > >
> >
> > I guess the reason is:
> >
> > 8d037973d48c026224ab285e6a06985ccac6f7bf doesn't have "Fixes:" and is
> > not sent to stable@vger.kernel.org.
> > And 0e15863015d97c1ee2cc29d599abcc7fa2dc3e95 is to Fix
> > 8d037973d48c026224ab285e6a06985ccac6f7bf,
> > so no need of 0e158 if 8d03 not backported to that particular branch.
>
> Ok, so there's nothing to do here, great!  If there is, please let us
> know.
>

In my previous mail, I was guessing why 8d037973d48c commit was not
backported to v6.1.

However Brennan's concern is:

As per CVE-2023-2176, because of improper cleanup local users can
crash the system.
And this crash was reported in v5.19, refer:
https://lore.kernel.org/all/ec81a9d50462d9b9303966176b17b85f7dfbb96a.167074=
9660.git.leonro@nvidia.com/#t

However, fix i.e. 8d037973d48c applied to master from v6.3-rc1 and not
backported to any stable or LTS.
So v6.1 is still vulnarbile, so 8d037973d48c and 0e15863015d9 should
be backported to v6.1.

- Ajay

