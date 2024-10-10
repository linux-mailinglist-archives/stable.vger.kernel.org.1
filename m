Return-Path: <stable+bounces-83316-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D2B9981DF
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 11:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD89F1F28E15
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 09:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9634F1BB6BA;
	Thu, 10 Oct 2024 09:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="PHLLKeOg"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7885D1BC077
	for <stable@vger.kernel.org>; Thu, 10 Oct 2024 09:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728551638; cv=none; b=SKxrypLaIA+fuNoxBJmlr/QO2HlConNW5NXHNUTdxw735CcRWjOO5NbhY/2ymW6xsV+ENaDwUrZJWAMWerIGdKQb8SGPxj5yOFI4YOC7CWDavqSvYfCg4s4d0hoSuD0nsiRIkYvhJ8h5TBClH5CAMv5Ntpgf0DmQOEfnL1BMrmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728551638; c=relaxed/simple;
	bh=llOt6bY2BFlq/d+1uLi6NRMAVLpNP5qP2scI9mNf3tU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sCR2Nz8CQ9DbMUUx6dyfqT1QxgSzZTEfLnm6OHh6rIcem3S5c6R+VLzHX13NNkLb30aY02LXuUxfB6pWFxXqfbDPyfmVoD78cPcqrKeF6ZeJiNOGtu/nedVetp1dXk6SvYHUeZonzk8ZJvAPSREtvhbpycbXnAsad3m1myw0LSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=PHLLKeOg; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d450de14fso19354f8f.2
        for <stable@vger.kernel.org>; Thu, 10 Oct 2024 02:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1728551634; x=1729156434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKHMF2LZDd7xRHQhwdJ1/mUDX8QJZVwBM4qkNy5iyBg=;
        b=PHLLKeOgTTtIk4ER7Fs0Xjf2ZLeoZ5SB3nsvV6w104F3zbPHnwNWiQGe4qkz8R/Ksm
         VHH51KA6qi3Zi4DWfGvFM3JRTmqcP6DFw1JSm8ddgttfcgMpfWO9y1n6KykuE15027dK
         40f2JlhglO7uSAwAeb8lt8NdFofVLDfgatltF3FTMK4Z9PbNSvYk1q1Wv20jxTGzr+1M
         fC2HCRS9JCbNRAHst0awyRvtzFcWxG2vkjEJGFfkQ4BFVnHSlz4Ll2K3vf8NclShxVdh
         iz+fLmyG7Z9XBLyTvEFpog/sQHlLVarVXsmhkWv8tRIJnH8mj5rWfqwW/D2jp+WqllvA
         W8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728551634; x=1729156434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKHMF2LZDd7xRHQhwdJ1/mUDX8QJZVwBM4qkNy5iyBg=;
        b=CwBHXYMFBepEevafDxVOgUxiqoB+XvSkV/DqIlTomhQv4SRNgBNGdciQGDAWIoseMN
         jWtVivKYsLQl/a4LugbD1H9R9UflVWeM8x+wea+0EANqzz+pa8wTYYuM+tIBk6BtoVxu
         18W1WKG4kNeWPHbIlx6Fkdbb+1YAapyydBDaePQPBwE7A0dQSVCv6x5aT+rJPCMP/zc/
         e8QSz45GepfPenSX2YAc9qYXw/URqj1oqT1bTpxbnbE8vyTwvUbcVQst59iPIiCQEalN
         CmSn4qaorpmiwHbPchR4EiD58ielTPc2j+moiPxubsU/ci7/AMWdW0YXyeXZ874y4fQI
         XRNg==
X-Gm-Message-State: AOJu0YwUq4kWzgJHkaqddCzL10XNqxzevkJcK8mtP3MaQqBM+w7fBezf
	YL0fqOCbwaSPuG26xpDvO3XmCAY/SCGedMLgJtqQI7sLOlLAsJgf86+DyXxTjV4ykWHNrJW/nTn
	WoT5Z1ioxBRXPoNGp+GennIsoSmZsJRN0w2C+wApAok2CiUY25jQ=
X-Google-Smtp-Source: AGHT+IHsSW4KDKyWyODdtn9Ke3EHPB7qG6NaWrVdfS71uyy0ec0dhJojf1Gr3Hwoqc6sFmBsRy08iAc08uNX41+l9bM=
X-Received: by 2002:a5d:59ad:0:b0:378:955f:d243 with SMTP id
 ffacd0b85a97d-37d3ab24422mr2035757f8f.13.1728551633701; Thu, 10 Oct 2024
 02:13:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMGffE=dPofoPD_+giBnAC66-+=RqRmO2uBmC88-Ph1RgGN=0Q@mail.gmail.com>
 <2024101006-scanner-unboxed-0190@gregkh>
In-Reply-To: <2024101006-scanner-unboxed-0190@gregkh>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Thu, 10 Oct 2024 11:13:42 +0200
Message-ID: <CAMGffE=HvMU4Syy7ATEevKQ+izAvndmpQ8-F9HN_WM+3PKwWyw@mail.gmail.com>
Subject: Re: [regression]Boot Hang on Kernel 6.1.83+ with Dell PowerEdge R770
 and Intel Xeon 6710E
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable <stable@vger.kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	baolu.lu@linux.intel.com, jroedel@suse.de, Sasha Levin <sashal@kernel.org>, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Thu, Oct 10, 2024 at 11:07=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Thu, Oct 10, 2024 at 09:31:37AM +0200, Jinpu Wang wrote:
> > Hello all,
> >
> > We are experiencing a boot hang issue when booting kernel version
> > 6.1.83+ on a Dell Inc. PowerEdge R770 equipped with an Intel Xeon
> > 6710E processor. After extensive testing and use of `git bisect`, we
> > have traced the issue to commit:
> >
> > `586e19c88a0c ("iommu/vt-d: Retrieve IOMMU perfmon capability informati=
on")`
> >
> > This commit appears to be part of a larger patchset, which can be found=
 here:
> > [Patchset on lore.kernel.org](https://lore.kernel.org/lkml/7c4b3e4e-1c5=
d-04f1-1891-84f686c94736@linux.intel.com/T/)
> >
> > We attempted to boot with the `intel_iommu=3Doff` option, but the syste=
m
> > hangs in the same manner. However, the system boots successfully after
> > disabling `CONFIG_INTEL_IOMMU_PERF_EVENTS`.
>
> Is there any error messages?  Does the latest 6.6.y tree work properly?
> If so, why not just use that, no new hardware should be using older
> kernel trees anyway :)
No error, just hang, I've removed "quiet" and added "debug".
Yes, the latest 6.6.y tree works for this, but there are other
problems/dependency we have to solve.

>
> thanks,
Thanks!
>
> greg k-h

