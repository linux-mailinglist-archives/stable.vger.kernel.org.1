Return-Path: <stable+bounces-170603-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 358FCB2A55C
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 15:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 828AA68249F
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8784D3375CD;
	Mon, 18 Aug 2025 13:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkeN+Ncf"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BDF3375C0;
	Mon, 18 Aug 2025 13:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755523171; cv=none; b=fIt2wu//DEjyJbr9XUj9EAhaHZUbjc4HyM22n1GGfOTjwFCv9zyuVBzz7g63fV+Bk/u3KlD2mCEY4hueGMYCY7noyQtBss4Aa4rhH//blvZLHeJGGO3UK8FfLgXhcFn2sHVZDHXULV7stl07/xIxgHnTSvxRzNy2yJAfDi2mIAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755523171; c=relaxed/simple;
	bh=d8H++LMNz1lxoCPsYGPyOhmw1eLBXRyF3ledLNsKlnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J0osl3lLtsYjbtXIOboXsKkFvIuEOxPglBwNH1W6wNa1i/TqSkM6rTIToRTzU4szVfH1Z3kmLOSd2pL3haDNinUOryBtt/0lo+ldLRV24dIjvf7yKnP2o//Os/d6Z9p62Ce0FYR//hLJwvJvXEq9F5cXXF5L2ln14cHMEijj+nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkeN+Ncf; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45a1b0c8867so33321725e9.3;
        Mon, 18 Aug 2025 06:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755523168; x=1756127968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hkRhgj6u3LmpnQlstGfUBG2btp13oJgkyn6qmMW5F2s=;
        b=hkeN+NcfVI91Nrs80nxrvlkGO15dWExAzpL5mMChlgOVRyfGtorJF3w2pLdjk8m6s2
         vwmdcrV8AiWia0bHgVV5zVgybYfpHMQagh2KzMr/DkQ/iEt5Q2D/qIDxPGS6TMn55cX8
         mRgRE+U2elacOi2FLuHn8QGYp/qSdza7Z2WIY7VF1gkJbjIo+OrqYW2bHceUTJUyHPBR
         vXKSwavPkfzSrrNs3ebyQx+XERBJqDAXc2QkE+PCvRCF2x78bva2s5RNLAiGvoTLq1xt
         6TqsmZb1TA1vXh5gGuxXhQWUiTPwBhafoQMncyUSEa1T5lODKQlcHl9abDw7qrxVx45J
         HWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755523168; x=1756127968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hkRhgj6u3LmpnQlstGfUBG2btp13oJgkyn6qmMW5F2s=;
        b=rR0lah5VpANjqJxDyN5nel9pgr4BTv7vfVsHtH72o2nl6kob8jvtKaXkLhzfvqDnu+
         t4TNwvLJytypSAUuYeytcL75Bifija8vaST+O+n5nTl4AeNWJTt6gdYP55stFDqrAh5O
         FTPl37d2kZv9ygBdN9hTGB+wOnPjI15zc9Sy3SMFaLdxrPHZN3W4cUrgOen/0oPvWnk0
         VDL83H/7NHnV8Vs2jGFaHxDUVVdzwKeSmOaGm0U2vopat7Y6UcLD0UXn8SaZRk8hz/Zz
         1FqY7ro7lLoqyZWngcKYF0GWXzFODLOxyd+UgtmwiUNR52Ft1HK/xWlb2fDTZD4f0QTa
         I45A==
X-Forwarded-Encrypted: i=1; AJvYcCWhQUT1XiJs0wA+uksfsUrTHNBgoX+6cqC2VcjtVnyHTwu8/8bRDc81y7cNVa5GCDbZhJElHaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkgTsAx8U6/cKT9WxS8+f7wSk14hT4dau62nLLJroFY1HnHjWH
	kWsjm4EVaM7QylTqCdzPTvn2P/PTWlRuRL1JWpY6905AexGQcgixBrg97k8sbwDc9dMKxQAfMrW
	4ZY5rwGOGmpH0CU71jeYrGF7377Prkn4=
X-Gm-Gg: ASbGncuCeSz7bgN4IJU6XehyqNCTnGiuO35oGVsz+bbSqy2AH8yhJFrNsZkXAYPktF4
	pji3HQQWBw+qKFkDz8zIdgZjtvjegVFWVHvKCGImycqycwBRGYb3H1O2IVyxpooZytW4tBoNR6I
	Tq5f+cSvjOqFmAwgBz4XJ4wS4UzaEmTyXizZ3yFdUNH9KIrmKXUuuvvAUDWJuvCG8ytPALg0/tV
	qNJso2bZXwiDU7yqeJh1PPHk3BF9ypGESG12Hr1Ww==
X-Google-Smtp-Source: AGHT+IGNjevdxuEeCCQDuEyujDtrMHmT/jKR/Bp96iHsp/TRECkv5we1BEl2ldAO/E0rwgBF7RI8/FmaT28EriP98Ps=
X-Received: by 2002:a05:600c:1906:b0:459:d8c2:80b2 with SMTP id
 5b1f17b1804b1-45a217f71b3mr76250805e9.7.1755523167182; Mon, 18 Aug 2025
 06:19:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACBcRw+Fu1B+fXEFvhfsZFtPqa5G=AYSW0K3L2RBWh8YfkgUhg@mail.gmail.com>
 <2025081831-viewable-vanquish-e8bc@gregkh>
In-Reply-To: <2025081831-viewable-vanquish-e8bc@gregkh>
From: =?UTF-8?B?5Za15YWs5a2Q?= <miaogongzi0227@gmail.com>
Date: Mon, 18 Aug 2025 21:19:15 +0800
X-Gm-Features: Ac12FXyfyUVl5TZp3_bAB7947fWLUOKmM-rxcMVcmVIN9DO9KRz5xZIM_jnBCqE
Message-ID: <CACBcRwKcApHzYssnPj2YQht1yYicTALs03GYkyP88W-9Thmo3w@mail.gmail.com>
Subject: Re: [REGRESSION] IPv6 RA default router advertisement fails after
 kernel 6.12.42 updates
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev, edumazet@google.com, 
	kuba@kernel.org, sashal@kernel.org, yoshfuji@linux-ipv6.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Thanks for the quick reply.

This regression has been reproduced on Linux 6.12.42 as shipped with
OpenWrt. Currently, OpenWrt only provides kernels from the 6.12.y
stable series, so I was only able to verify on 6.12.42.

I am looping in the networking/IPv6 maintainers so the right people
can take a look at this issue.

Best regards,
gongzi miao

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2025=E5=B9=B48=E6=9C=8818=E6=
=97=A5=E5=91=A8=E4=B8=80 20:25=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Aug 18, 2025 at 08:03:00PM +0800, =E5=96=B5=E5=85=AC=E5=AD=90 wro=
te:
> > Hi,
> >
> > While testing Linux kernel 6.12.42 on OpenWrt, we observed a
> > regression in IPv6 Router Advertisement (RA) handling for the default
> > router.
> >
> > Affected commits
> >
> > The following commits appear related and may have introduced the issue:
> >
> > ipv6: fix possible infinite loop in fib6_info_uses_dev()=EF=BC=9A
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit=
/?h=3Dv6.12.42&id=3Ddb65739d406c72776fbdbbc334be827ef05880d2
> >
> > ipv6: prevent infinite loop in rt6_nlmsg_size()=EF=BC=9A
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit=
/?h=3Dv6.12.42&id=3Dcd8d8bbd9ced4cc5d06d858f67d4aa87745e8f38
> >
> > ipv6: annotate data-races around rt->fib6_nsiblings=EF=BC=9A
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit=
/?h=3Dv6.12.42&id=3D0c58f74f8aa991c2a63bb58ff743e1ff3d584b62
>
> Does this also happen on the latest kernel releases?
>
> Also, please always include the developers/maintainers/mailing list of
> the subsystem where you find an issue with.  Otherwise you are not going
> to reach the developers who can help you out.
>
> thanks,
>
> greg k-h

