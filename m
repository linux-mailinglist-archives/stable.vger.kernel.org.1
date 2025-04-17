Return-Path: <stable+bounces-133198-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE04A91F79
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 16:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 672977A9327
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 14:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AED1F463D;
	Thu, 17 Apr 2025 14:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hGsONAqr"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28EB199237
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 14:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744899808; cv=none; b=SpEZx1p3Ve/NztuEzon5rdUJ53MRvJPrkgm6O7eRBC9zkv4iqxTblwTf94VZt9AtjzjNIUg7PWmzhNRsafoHp38r5he5kxl7A6uEpzw7//sNBHUGoYtYYFJZXIfumxSCECuloREoPm9OTRR6OiGOsQUYZG3+qncswTil0qv3NBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744899808; c=relaxed/simple;
	bh=ZAGoHZEg/IOUZ+4lgZTYAUa/AuRbraBJROFx2ZmY0Lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g+IY4eVy6OMZdimW9FRcdsQu+UgDk6L2yAmdvJskswPLbAf48CBa2upiCnUSLdK6LxZEBj1SLBLjKWjji8N8QF/akKpyk1lK0YgmGsw4yikGhXMANNF9WDybwutF/fgnJYzDzKhkGdTwv1yxpgvPs4RNnSpcwXC8UaoizKaQa4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hGsONAqr; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3018e2d042bso592090a91.2
        for <stable@vger.kernel.org>; Thu, 17 Apr 2025 07:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1744899805; x=1745504605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZAGoHZEg/IOUZ+4lgZTYAUa/AuRbraBJROFx2ZmY0Lg=;
        b=hGsONAqrnrpjEq8abfMJ37YkBisiZQvjSRfFJpOtvmKx553WdqX72sXlbBFmpNZPtP
         rl1By1ZV1jTxw0bBpUeZaafwkUqJzMOY+Y12GT8TS2yoMo5rVj+Nmwd26J8kEbyLRUVS
         KDDIKRweu9Yu2HwbV2e7K+Pb7U7yLOrge+lwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744899805; x=1745504605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZAGoHZEg/IOUZ+4lgZTYAUa/AuRbraBJROFx2ZmY0Lg=;
        b=wuvzMX9iln9ojfEOCWwnVCznFMuO4Hio6n4mH6x4x8sLH43lvkR4XMEOnXMZUJCYxr
         hwvI0lbXdvuqA+uGdNowWs2ZfFwBibto0hF+nZYA4WhDhFicELSf+r8XzTIQHKqUnHFd
         Bb2lAcL8OKWerQuVCjg+5oBHR6dhxt0e0kPzM30RRn9fJHzn/Tn4n6khmo3DjOSZQWP+
         mt1rFPtFXCap2NWGGG7cfPryQLxmzoMk3p9pXONejbElxoLbWbqUAAVSs9rcittv2cd5
         M8Em3uMF4wnm4nWJQPTdcTJBX2Hdk5+dXsmtLqzF15VqJKU1c6G3sAcpn+h4M+BPb7n3
         dnXw==
X-Forwarded-Encrypted: i=1; AJvYcCXIykPFMiE+uM7xyug4bRnCJanE8BBLuzFOTL1sNw+OfXpt/T55kn9dPWBqSLzKgi1U8GftNzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSG4dQVuo1oCsKcs3uOWEg7ZwAkHy4cAhMWrTyO/bTfXiDfQ0u
	0puDgrxiQpYFtokQKY7zammAPlBfV6+2RK7Chwtw8kb2ZdkwP7zxK69Y+rVeioDYXzdJKikrPRk
	=
X-Gm-Gg: ASbGncvEUhKM1qydI2DkOCznToZNlEsx7mbWLhydpciyNjbKx2hDnfq6jUWlwxw2yP2
	IVqD+SW6sElPMcTpX9PBKAtTw9mIrvzcv2KrmeCN2DrXbEe6P0QIUlksUSPgXbX/4Xn90ZlYu1l
	LHOM2dCfK25W9B+56VxwzD9ow9gXy6aszcutvOd03QLX8fqkVs7OELZo8oQAH5VnYe9RY/L82KA
	dyGP4e8CzulNDi9yjcRo+GwFX5bzKtoZd4eQX4zKpZk/eFGUFup7WPz/ZEGl5fhpsYhN3niAx3C
	KKAE6vPhwfYf06gN58xCkCwipAENH8nGSUoSw51rWcYO6215wkby5mnnl7A1eaDeOdX7FasCj/P
	/d6Xo1Zsq
X-Google-Smtp-Source: AGHT+IE++bX7rwEts3KfOqiiHFLWBtGKMsfQQKMFD8iX/qv2zLKhSnUg0OBRSsFg/1AiXeKOK4nnHw==
X-Received: by 2002:a17:90b:1f88:b0:2f6:d266:f462 with SMTP id 98e67ed59e1d1-30864172a14mr8448919a91.35.1744899805339;
        Thu, 17 Apr 2025 07:23:25 -0700 (PDT)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com. [209.85.215.174])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-308611d617csm4122913a91.9.2025.04.17.07.23.24
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 07:23:24 -0700 (PDT)
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b0b2d1f2845so567937a12.3
        for <stable@vger.kernel.org>; Thu, 17 Apr 2025 07:23:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVCMrjQloL0r5VTqhZZNXsQ6OV6G5S8rBLkWfNwsbiYL+qaLuU0a4pttunfgNz1DQKBCur7YI4=@vger.kernel.org
X-Received: by 2002:a17:90b:1b11:b0:2fe:68a5:d84b with SMTP id
 98e67ed59e1d1-30863d1de4bmr8505047a91.1.1744899803389; Thu, 17 Apr 2025
 07:23:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025040844-unlivable-strum-7c2f@gregkh> <CAD=FV=U=7G-V2FBNHJ5=bE+BVa1Jcbd=fi-zD4wCVAwxcpU2ww@mail.gmail.com>
 <CAD=FV=UrERLaPhPznUkW-O-K=_-uBROScPYy1eC_7RrDGXPS=w@mail.gmail.com> <2025041705-contented-pony-7ff8@gregkh>
In-Reply-To: <2025041705-contented-pony-7ff8@gregkh>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 17 Apr 2025 07:23:11 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VADJ5kep74NmNz_ewKZAmQf+6fUA0FH+bAdg3Z=iJq+A@mail.gmail.com>
X-Gm-Features: ATxdqUEky4zln-aSWUYDaqPTTEld1oTQeikFzOymf7hjmLIfniosUB1-7w0YuAo
Message-ID: <CAD=FV=VADJ5kep74NmNz_ewKZAmQf+6fUA0FH+bAdg3Z=iJq+A@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] arm64: errata: Add newer ARM cores to the"
 failed to apply to 6.14-stable tree
To: Greg KH <gregkh@linuxfoundation.org>
Cc: catalin.marinas@arm.com, james.morse@arm.com, stable@vger.kernel.org, 
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Sebastian Ott <sebott@redhat.com>, 
	Cornelia Huck <cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 17, 2025 at 7:10=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Mon, Apr 14, 2025 at 08:37:36AM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Tue, Apr 8, 2025 at 8:49=E2=80=AFAM Doug Anderson <dianders@chromium=
.org> wrote:
> > >
> > > Hi,
> > >
> > > On Tue, Apr 8, 2025 at 2:17=E2=80=AFAM <gregkh@linuxfoundation.org> w=
rote:
> > > >
> > > >
> > > > The patch below does not apply to the 6.14-stable tree.
> > > > If someone wants it applied there, or to any other stable or longte=
rm
> > > > tree, then please email the backport, including the original git co=
mmit
> > > > id to <stable@vger.kernel.org>.
> > > >
> > > > To reproduce the conflict and resubmit, you may use the following c=
ommands:
> > > >
> > > > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/li=
nux.git/ linux-6.14.y
> > > > git checkout FETCH_HEAD
> > > > git cherry-pick -x a5951389e58d2e816eed3dbec5877de9327fd881
> > > > # <resolve conflicts, build, test, etc.>
> > > > git commit -s
> > > > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20250=
40844-unlivable-strum-7c2f@gregkh' --subject-prefix 'PATCH 6.14.y' HEAD^..
> > >
> > > FWIW, this patch applies cleanly for me to the top of 6.14.y if you
> > > simply apply all 5 patches in the series, all of which are CC stable.
> > > AKA these commands work
> > >
> > > git checkout v6.14.1 # Current linux-6.14.y
> > > git cherry-pick ed1ce841245d~..a5951389e58d
> > >
> > > Where you start getting a conflict is if you also take this patch fro=
m mainline:
> > >
> > > e3121298c7fc arm64: Modify _midr_range() functions to read MIDR/REVID=
R
> > > internally
> > >
> > > The merge conflict between those two series was resolved upstream in:
> > >
> > > edb0e8f6e2e1 Merge tag 'for-linus' of git://git.kernel.org/pub/scm/vi=
rt/kvm/kvm
> >
> > I tried again as of today's linux-6.14.y (which is 6.14.2), and the
> > patches still apply cleanly. I can send all 5 patches to the lists if
> > it's desired, but I'm uncertain if it's required since they all apply
> > cleanly. Just "git cherry-pick ed1ce841245d~..a5951389e58d". They all
> > apply cleanly all the way back to 5.15 as far as I can tell. Would I
> > need to send the same 5 clean picks in response to every stable kernel
> > from 5.15 all the way to 6.14?
>
> I see all but the last one in the stable queues right now, let me try
> the last one...
>
> Ok, that one also applied from 5.15.y and newer.

Thanks! Yeah, I saw a bunch go through. I'll try to check back in a
few days to make sure they all show up on git.


> > These patches don't apply cleanly to 5.4, but that's because kernel
> > 5.4 doesn't have `proton-pack.c`, so presumably none of the Spectre
> > mitigations were ported back that far.
> >
> > Some of the spectre stuff is present in 5.10, but it looks like not
> > all patches are being picked there. It's probably not critical to
> > support newer ARM cores there, but changing the default to say cores
> > are vulnerable might be worth it? What do folks think?a
>
> That's up to you.

I ended up finding the spectre stuff even on v5.4--it was just in a
different file. However, I'm not going to attempt to do any
backporting to v5.4 or v5.10 myself because:

* The original incentive for me to post this series was to add
QCOM_KRYO_4XX_GOLD to the k24 list. ...but there's no support for that
CPU in 5.4 upstream anyway.

* The Kryo4XX patch _did_ apply to 5.10, just the further cleanups to
"assume vulnerable" failed because the 5.10 tree doesn't have all the
cleanups it depended upon. Backporting it would be a bigger effort and
I'm not sure what the incentive would be. I'm happy to review if
someone else wants to do the backport, though.

* The patch to add newer ARM cores seems even less likely to be needed
on 5.4 / 5.10 kernels. Hopefully anyone developing on those newer
cores is using a newer kernel.

-Doug

