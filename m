Return-Path: <stable+bounces-94557-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B5E9D55D8
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 23:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C49661F21FFB
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 22:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C901DDC1F;
	Thu, 21 Nov 2024 22:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vQawWu5Q"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22E023098E
	for <stable@vger.kernel.org>; Thu, 21 Nov 2024 22:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732229630; cv=none; b=n/ycjPHqcWkKUAATfk8ez3GF0aSVTa/VuXedrSyHUxEfFWSz/iKlUVOqLoliAPKvEbUpAaq1+ShPwTmdqCHA6ArVTQ+RcLoodpUJjIyR/SO7OO269BHbPOQozwiwTMxeTch9lSvENW4FCX0qIPC0WzD1rysOX/YV8e1R4raZOvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732229630; c=relaxed/simple;
	bh=zS+XS8ogUVZ6A8yFN6IeLpIsHgWd7UUfIiqVVoPp4wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b3RzYz27DujCtvb67mt8EumR8nRuGFlxk8d8kI+a7dAm1wostqTtrH8Y8OoDwQwqRHQ70e8ggWD7YQ+OrQLka3QyPLKSQt5OJzWA2lcmmcINQvRJQ5mevgyxn2hrqZJITX6NDbiaU46B0+/4U/pvhV1TG510DkLr6X6LOc/RaKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vQawWu5Q; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53c779ef19cso1686327e87.3
        for <stable@vger.kernel.org>; Thu, 21 Nov 2024 14:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732229627; x=1732834427; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NAGNZNP1x0dn4FJ/bV16PujKmWclfcTAJHMzWwhkGUg=;
        b=vQawWu5Q2NfMddBk5qgkTUl6C0vC12XI274J4n6VR+wrmsiOuvdLn8BvcFZ6QpIVXG
         UWZh6d+1akdN66XsUmOqKDeukK3LNR05UXM2aaEK6pYNpq3aTMcAhG2wpVl0HygEEaST
         GX98CrCwc9Z6fs78dyzyV5EUCPl0JlCexrFmskKXb3vxRoUoUX4MbHLRN2XqQpOEGj8X
         YB3OhfhSgF/Emw1QIoml+RJAYSuQr0YQFbXRH0yXgLjTldA0cwSGfX4ZxJif6lea2tZq
         SxNsU4Va6J3qsZViN2FXst7Cs3IbLtmRTzY3/dkodk2/zEUYO3KqBZnu1D34qTRv8urL
         9eHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732229627; x=1732834427;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NAGNZNP1x0dn4FJ/bV16PujKmWclfcTAJHMzWwhkGUg=;
        b=utN7JABw+fNhRmuiV6ZlOx2NnlpT2lnXzWXTNJAhn20TMDp2cWeULVLZj/waT7369+
         Nq6b4xmX+WDgAUAbLpEwtQ7hMecZ4e5hzPVgXNWLVYgpClJPbSVf8iRbB8sWG7+z+Q7v
         fHZ4Z6kJgBO0loq73ubzQkbmFK54Fu11fty26/l2LvAKWbdJSUOJgQgp411BHEMrtTI2
         JKXl+v92QcOrZjJtxlMFc33d2/iWcs73UbcnY3xl3dMstCmylY/km/O5VBkgRkaIlbBA
         gXWdajBLKtCd2HdjUtLiUreCh1V9KhK7AGDJH3OWJE/knkINJ/KlMwt1BI2JUbK7G0o2
         TzZw==
X-Forwarded-Encrypted: i=1; AJvYcCV1zxzlGIFuSR6ijxetewzYXMc8KCHKvfY5hOEf9su5VTyhDdpXLuh4Q/ztSHmqcQG3OMN3Sss=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI50PnAj9Y3L0W36vcBqus8L3/X3yBsu3nqmzVYh0pIxuHtxAZ
	mp1n1pgWkgWSarGZxf0bVVHegqErYR8VLVvnx00nyqqhZlLv6bbadBpt616HqzQ=
X-Gm-Gg: ASbGncsM6CXagENATgnZHZbhx9fkmaf7iJG1Mu4PBmVMQ+2kjl6zG6qmXllDeeo//Bl
	dmOnM1lk4B793Q4KH48A6CXP+PZiFXaCT1wgh08zMX0z6eXkCdnZDMf11DA1WuRRpFlP4E4nwjC
	/o8V/MWdf+qwvHxxuVnI6ldnnZjpP+nBVoVrlCuat/6lKIlCx2esYYr8sDHFOgU71cPi0NNBDW2
	KM4mQbRj/duVTs98J5ZPmxNc7tx9Ek3YST0nyEM06LO95k8O/FD4c06eHSc9SswcLOC18mQhm69
	ZbVbXs2qkdFPaviF755oWPLij9DbPw==
X-Google-Smtp-Source: AGHT+IEQHrSbbNkvcznYbVoG3t7wpxI2u6VB/SpC0Aklv7XdGqUhhOod5Es1rnlg867zgwKNCABXgg==
X-Received: by 2002:a05:6512:6d6:b0:53d:cbab:8afa with SMTP id 2adb3069b0e04-53dd33682c5mr293735e87.0.1732229627027;
        Thu, 21 Nov 2024 14:53:47 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd2497df2sm102486e87.245.2024.11.21.14.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 14:53:45 -0800 (PST)
Date: Fri, 22 Nov 2024 00:53:44 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: =?utf-8?Q?=C5=81ukasz?= Bartosik <ukaszb@chromium.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, 
	Benson Leung <bleung@chromium.org>, Jameson Thies <jthies@google.com>, linux-usb@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: ucsi: Fix completion notifications
Message-ID: <yphjztfvehbqd4xbdo7wtdfd4d3ziibq6hytuuxnoypdpsr462@zwl2cfj6f5kw>
References: <20241104154252.1463188-1-ukaszb@chromium.org>
 <5iacpnq5akk3gk7kdg5wkbaohbtwtuc6cl7xyubsh2apkteye3@2ztqtkpoauyg>
 <CALwA+Nb31ukU2Ox782Mq+ucBvEqm9_SioSAE23ifhX7DsHayhA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALwA+Nb31ukU2Ox782Mq+ucBvEqm9_SioSAE23ifhX7DsHayhA@mail.gmail.com>

On Wed, Nov 20, 2024 at 03:56:41PM +0100, Łukasz Bartosik wrote:
> On Mon, Nov 18, 2024 at 6:58 PM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Mon, Nov 04, 2024 at 03:42:52PM +0000, Łukasz Bartosik wrote:
> > > OPM                         PPM                         LPM
> > >  |        1.send cmd         |                           |
> > >  |-------------------------->|                           |
> > >  |                           |--                         |
> > >  |                           |  | 2.set busy bit in CCI  |
> > >  |                           |<-                         |
> > >  |      3.notify the OPM     |                           |
> > >  |<--------------------------|                           |
> > >  |                           | 4.send cmd to be executed |
> > >  |                           |-------------------------->|
> > >  |                           |                           |
> > >  |                           |      5.cmd completed      |
> > >  |                           |<--------------------------|
> > >  |                           |                           |
> > >  |                           |--                         |
> > >  |                           |  | 6.set cmd completed    |
> > >  |                           |<-       bit in CCI        |
> > >  |                           |                           |
> > >  |   7.handle notification   |                           |
> > >  |   from point 3, read CCI  |                           |
> > >  |<--------------------------|                           |
> > >  |                           |                           |
> > >  |     8.notify the OPM      |                           |
> > >  |<--------------------------|                           |
> > >  |                           |                           |
> > >
> > > When the PPM receives command from the OPM (p.1) it sets the busy bit
> > > in the CCI (p.2), sends notification to the OPM (p.3) and forwards the
> > > command to be executed by the LPM (p.4). When the PPM receives command
> > > completion from the LPM (p.5) it sets command completion bit in the CCI
> > > (p.6) and sends notification to the OPM (p.8). If command execution by
> > > the LPM is fast enough then when the OPM starts handling the notification
> > > from p.3 in p.7 and reads the CCI value it will see command completion bit
> > > and will call complete(). Then complete() might be called again when the
> > > OPM handles notification from p.8.
> >
> > I think the change is fine, but I'd like to understand, what code path
> > causes the first read from the OPM side before the notification from
> > the PPM?
> >
> 
> The read from the OPM in p.7 is a result of notification in p.3 but I agree
> it is misleading since you pointed it out. I will reorder p.7 and p.8.

Ack, thanks for the explanation. Do you think that it also might be
beneficial to call reinit_completion() when sending the command? I think
we discussed this change few months ago on the ML, but I failed to send
the patch...

> 
> Thanks,
> Lukasz
> 
> > >
> > > This fix replaces test_bit() with test_and_clear_bit()
> > > in ucsi_notify_common() in order to call complete() only
> > > once per request.
> > >
> > > Fixes: 584e8df58942 ("usb: typec: ucsi: extract common code for command handling")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
> > > ---
> > >  drivers/usb/typec/ucsi/ucsi.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> > > index e0f3925e401b..7a9b987ea80c 100644
> > > --- a/drivers/usb/typec/ucsi/ucsi.c
> > > +++ b/drivers/usb/typec/ucsi/ucsi.c
> > > @@ -46,11 +46,11 @@ void ucsi_notify_common(struct ucsi *ucsi, u32 cci)
> > >               ucsi_connector_change(ucsi, UCSI_CCI_CONNECTOR(cci));
> > >
> > >       if (cci & UCSI_CCI_ACK_COMPLETE &&
> > > -         test_bit(ACK_PENDING, &ucsi->flags))
> > > +         test_and_clear_bit(ACK_PENDING, &ucsi->flags))
> > >               complete(&ucsi->complete);
> > >
> > >       if (cci & UCSI_CCI_COMMAND_COMPLETE &&
> > > -         test_bit(COMMAND_PENDING, &ucsi->flags))
> > > +         test_and_clear_bit(COMMAND_PENDING, &ucsi->flags))
> > >               complete(&ucsi->complete);
> > >  }
> > >  EXPORT_SYMBOL_GPL(ucsi_notify_common);
> > > --
> > > 2.47.0.199.ga7371fff76-goog
> > >
> >
> > --
> > With best wishes
> > Dmitry

-- 
With best wishes
Dmitry

