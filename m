Return-Path: <stable+bounces-95694-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D00879DB568
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 11:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E932169E62
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 10:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123B31917E4;
	Thu, 28 Nov 2024 10:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n3ZUOmIH"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13E617C219
	for <stable@vger.kernel.org>; Thu, 28 Nov 2024 10:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732788541; cv=none; b=Sv1YcaMVP+49SxYX6sWbDwsj7BFw3HqZQKQd9Pc8VPq+Bn+6x1pSnqTElmZAICasWDhDNn6HVCwfKvfhImqkVOeNXtfTgQ+I3SdLPb1Dnd4pvI+dt4C4DTZPwhP77/C1LLsYg43dapyihwupQlxnO+laSS6S647No9sAXbRqeMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732788541; c=relaxed/simple;
	bh=8JTTnCHZnnMo3oxuwzguJnJc/O1rDNf/9TTzaUfiCC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dU9ysFNDfpAa2z1vMVf4jDOxCo2ZvWDoNbhIy3oFFuRYXZpB5N7I1u2gMihzYRmPMwxcX00QGol/8XF8siq57d3Pug2WlgQ8DRkAXI9CDuyFAdgIKm3T5L4zltj+xMZN0BPYnyHEOp+qiHfE3iMICKw7UnWizexvsm2TOWewHjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=n3ZUOmIH; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ffa12ad18cso6962971fa.2
        for <stable@vger.kernel.org>; Thu, 28 Nov 2024 02:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732788538; x=1733393338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qH69DGlARRYVL50i80W3i9hrrH9KaWwkcgqBCO+wAFY=;
        b=n3ZUOmIHbd6AUqPjy8ZzEApsl6I+UZzDQXttslC8VAmLG87x1bSfRlA49do7tbWCso
         UP7wSHIsle0Na0IYHPWa1wOgY/JsMcEVkBDp4z4nbqF+X7F7WIKL/EnWW07yrm/Njnpd
         Q9EAvBYZd4G3cCPEJiH5XJ4sZIUMurQKdSJlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732788538; x=1733393338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qH69DGlARRYVL50i80W3i9hrrH9KaWwkcgqBCO+wAFY=;
        b=Rz7jELvgKeFkQgUEllRoH2JwXDt+YT0FRVM4QhdB2YEefmlq7Ktg3tggk3b0GIbMnD
         cPx1Qrd6Mome561fuOGzKLiDJW4QDtArNUy5bUBwd1YpCs1sI54VikVoWumodO1llbdI
         hCBUuhogOIlCwuIUaYPVysnMDyQDXYaF8A0yusdmHo+czDuaQ55bLXBJ6I5AUiJxQSNo
         XGESFJ2cNe4DfhJ/uXiwyiYR0jKZZi+RxlMBNIN2F4arFNe9rckdlcbT/HKiTVojmDmp
         roiPAo2kEqKo06nm6/ne7Enqt5AR0JFrGFqEthttMYWbfNvX+fXeSjycHNv6UB71/o6g
         eEtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJjWsKNwe2bjpM3MWXZOdLySlbR03sipuyT/2udUKxDx6ifBZS/EIZ1bscjiBG8one0zrgfQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF2KdfdPsxF/y1YzOCLRzHCn4jUqABSyC0lVo5CJvxpZfj5zre
	y7wEF+BtDhp2npvluBZTMq6yyX+kTQEoaCzp62HbNIJgRVobeRpGntkO6HP2Z0eOPBWbO+ZO0/o
	xo66oJyr3yz3wbI2mL/Q+Pfsnk1XMxv8uE6s=
X-Gm-Gg: ASbGncvEUNfsgMurLJQ+3I76fsf2i3DKB71vdIxKESxfWVXpsHuqBpn86er+cH2LK5W
	Hdmu3xqy4+fJMgzDRUI9xPvA6S1RfbMRmJYVxJPImFZIAiD2xJjswOrJW
X-Google-Smtp-Source: AGHT+IGwyQRa0PyyAxqMwrDBn3GABwFRoQjHsMo4wzJLNgIAsloiPCavUY3TRo7zYcP7WoCb5P11lcE30BShy2iFre8=
X-Received: by 2002:a2e:bd83:0:b0:2ff:c4a3:882a with SMTP id
 38308e7fff4ca-2ffd6059f80mr35507821fa.18.1732788537986; Thu, 28 Nov 2024
 02:08:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104154252.1463188-1-ukaszb@chromium.org> <5iacpnq5akk3gk7kdg5wkbaohbtwtuc6cl7xyubsh2apkteye3@2ztqtkpoauyg>
 <CALwA+Nb31ukU2Ox782Mq+ucBvEqm9_SioSAE23ifhX7DsHayhA@mail.gmail.com> <yphjztfvehbqd4xbdo7wtdfd4d3ziibq6hytuuxnoypdpsr462@zwl2cfj6f5kw>
In-Reply-To: <yphjztfvehbqd4xbdo7wtdfd4d3ziibq6hytuuxnoypdpsr462@zwl2cfj6f5kw>
From: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <ukaszb@chromium.org>
Date: Thu, 28 Nov 2024 11:08:46 +0100
Message-ID: <CALwA+NYOm5mrw7=PSD+w_ma0hzR2CQ5dspz5X-bqi1o7ikfq6Q@mail.gmail.com>
Subject: Re: [PATCH v1] usb: typec: ucsi: Fix completion notifications
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, Benson Leung <bleung@chromium.org>, 
	Jameson Thies <jthies@google.com>, linux-usb@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 11:53=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Wed, Nov 20, 2024 at 03:56:41PM +0100, =C5=81ukasz Bartosik wrote:
> > On Mon, Nov 18, 2024 at 6:58=E2=80=AFPM Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > >
> > > On Mon, Nov 04, 2024 at 03:42:52PM +0000, =C5=81ukasz Bartosik wrote:
> > > > OPM                         PPM                         LPM
> > > >  |        1.send cmd         |                           |
> > > >  |-------------------------->|                           |
> > > >  |                           |--                         |
> > > >  |                           |  | 2.set busy bit in CCI  |
> > > >  |                           |<-                         |
> > > >  |      3.notify the OPM     |                           |
> > > >  |<--------------------------|                           |
> > > >  |                           | 4.send cmd to be executed |
> > > >  |                           |-------------------------->|
> > > >  |                           |                           |
> > > >  |                           |      5.cmd completed      |
> > > >  |                           |<--------------------------|
> > > >  |                           |                           |
> > > >  |                           |--                         |
> > > >  |                           |  | 6.set cmd completed    |
> > > >  |                           |<-       bit in CCI        |
> > > >  |                           |                           |
> > > >  |   7.handle notification   |                           |
> > > >  |   from point 3, read CCI  |                           |
> > > >  |<--------------------------|                           |
> > > >  |                           |                           |
> > > >  |     8.notify the OPM      |                           |
> > > >  |<--------------------------|                           |
> > > >  |                           |                           |
> > > >
> > > > When the PPM receives command from the OPM (p.1) it sets the busy b=
it
> > > > in the CCI (p.2), sends notification to the OPM (p.3) and forwards =
the
> > > > command to be executed by the LPM (p.4). When the PPM receives comm=
and
> > > > completion from the LPM (p.5) it sets command completion bit in the=
 CCI
> > > > (p.6) and sends notification to the OPM (p.8). If command execution=
 by
> > > > the LPM is fast enough then when the OPM starts handling the notifi=
cation
> > > > from p.3 in p.7 and reads the CCI value it will see command complet=
ion bit
> > > > and will call complete(). Then complete() might be called again whe=
n the
> > > > OPM handles notification from p.8.
> > >
> > > I think the change is fine, but I'd like to understand, what code pat=
h
> > > causes the first read from the OPM side before the notification from
> > > the PPM?
> > >
> >
> > The read from the OPM in p.7 is a result of notification in p.3 but I a=
gree
> > it is misleading since you pointed it out. I will reorder p.7 and p.8.
>
> Ack, thanks for the explanation. Do you think that it also might be
> beneficial to call reinit_completion() when sending the command? I think
> we discussed this change few months ago on the ML, but I failed to send
> the patch...
>

Dmitry sorry for delayed response.

IMHO it makes sense to clear completion in ucsi_sync_control_common()
with reinit_completion().
But I wonder whether with this change moving from test_bit ->
test_and_clear_bit do you still see a potential
scenario for a race ?

Thanks,
Lukasz

> >
> > Thanks,
> > Lukasz
> >
> > > >
> > > > This fix replaces test_bit() with test_and_clear_bit()
> > > > in ucsi_notify_common() in order to call complete() only
> > > > once per request.
> > > >
> > > > Fixes: 584e8df58942 ("usb: typec: ucsi: extract common code for com=
mand handling")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: =C5=81ukasz Bartosik <ukaszb@chromium.org>
> > > > ---
> > > >  drivers/usb/typec/ucsi/ucsi.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi=
/ucsi.c
> > > > index e0f3925e401b..7a9b987ea80c 100644
> > > > --- a/drivers/usb/typec/ucsi/ucsi.c
> > > > +++ b/drivers/usb/typec/ucsi/ucsi.c
> > > > @@ -46,11 +46,11 @@ void ucsi_notify_common(struct ucsi *ucsi, u32 =
cci)
> > > >               ucsi_connector_change(ucsi, UCSI_CCI_CONNECTOR(cci));
> > > >
> > > >       if (cci & UCSI_CCI_ACK_COMPLETE &&
> > > > -         test_bit(ACK_PENDING, &ucsi->flags))
> > > > +         test_and_clear_bit(ACK_PENDING, &ucsi->flags))
> > > >               complete(&ucsi->complete);
> > > >
> > > >       if (cci & UCSI_CCI_COMMAND_COMPLETE &&
> > > > -         test_bit(COMMAND_PENDING, &ucsi->flags))
> > > > +         test_and_clear_bit(COMMAND_PENDING, &ucsi->flags))
> > > >               complete(&ucsi->complete);
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(ucsi_notify_common);
> > > > --
> > > > 2.47.0.199.ga7371fff76-goog
> > > >
> > >
> > > --
> > > With best wishes
> > > Dmitry
>
> --
> With best wishes
> Dmitry

