Return-Path: <stable+bounces-95723-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1099DB972
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 15:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87AEAB203D3
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 14:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED02D1ADFF5;
	Thu, 28 Nov 2024 14:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YgNkF+Il"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F8D19DF8D
	for <stable@vger.kernel.org>; Thu, 28 Nov 2024 14:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732803404; cv=none; b=uL8nNSP4a8ivrVSJILQ5THx7giZkpcPWe0YJWYbUA+Kb8PsiI1knaM8KxK+zYYyEbaUZTVihOv5I5Vh8bZwYIeVOM5sir5I+TjM65TDvh+A0x9qa5C3GjmTN68ImX0XWGdiIblCauxrTKNMjPV0M4tg9KcmPWr4D50sViUVLtYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732803404; c=relaxed/simple;
	bh=pGJwVkhBavn7usUj1U3H0VsG3g3e1vAC4GGeds7ZWO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFuyTEOKIUk+EHCj1jcYcwBCEuyHS21PP0wjUM9xuEYz8TUOkuf6Zss7+j4qOr1/u534OuY91dPpllOuMUUQ3nV2JvDrwquw4sir8du3EeaprDm09MH6RSUJXu4mqOhxIi+TWlIGFQLbp2rq477kkqtlVG5RyEQZhjEVC73jWtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YgNkF+Il; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53df1e0641fso994628e87.1
        for <stable@vger.kernel.org>; Thu, 28 Nov 2024 06:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732803400; x=1733408200; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Weqeryws7cMd2oim1FlBCZJW7c40sebxRrMb3q5ySJQ=;
        b=YgNkF+Il1jYqaeBDqdZrDBardJnnXGcp1rKvtdOo7tfyZRarvvhOQ7+00HpjYK80gY
         dR7XjJ+9tLnNucUmKG7g190aqasK7gmgbUpaX4wpFESnMGf+rzfzRchqPtD5zi7nv5Y2
         PV/+sAMrItmYRqx+n0Btx8zukjaCndVqhR2dqlBOtlnDqai56e497AfdgKoSGggsklm6
         f2rbFdCMyBYr69dUTmSlY56fddqaK9Yrd6hwP/xHgYCTMnYpX7llmg5meKJAcfPX8YAE
         Ug6xO3JNWcxS6joA1+KHPXYbTt72z8MvONzCILDDYYhu79Vs9J7VQPNdXZuMdWwDYVaR
         32vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732803400; x=1733408200;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Weqeryws7cMd2oim1FlBCZJW7c40sebxRrMb3q5ySJQ=;
        b=J8ThMIpLdgN0mKKROd8hVCVW8OztIU3x9B19HIsmcZVBd2LCfsligeKz2mWBX0/L1y
         Hyaj5lC9PInwP8TPsahWyKoFLwEzAG0lM7I42s1vvfc3peIVnwXFAMV+SeAUtt9FLmJu
         gZKkHRmUAqcrmjvMVbfT7k8dmmwtpveTHnC5wl94n1LDYCpO3SeoXnQeHxBS6KMJDgwV
         cvLWG6atmNZVWi2RL4rfTTp00fx7iawCsXNySN0bAdNVxsM7ygcVbfj/CNAlK/lHO07f
         oUz08175Qh9egIDaPfw5fwl8niAFpswCg2z5vpwOWuF3AGrGYhN1vBp4bP7IyC4Loe/e
         9tkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQ2CDdIFKLMEaxIaYy81uJT4zVXhWV8q3zAxG7/u2JU1i8R9zDNPiGi1gMPB466nUotrKh6Rc=@vger.kernel.org
X-Gm-Message-State: AOJu0YziHZHoH6zqynp9lPTDVs6syOsBMx5d6Rj5Um6Huy8QUDsc+wO0
	SKvchmvQVSi46KYR2M55889YTwJ1tROPu6C3e+MHcpywEUHvlx+1o38NnA0FOAXjKF1DyKueFFG
	3
X-Gm-Gg: ASbGnctwdahQd3QdFg1whlOTW00ezWj/qZhz0SuUGqMUJb/tP07ox6ImE0aCiLJknz+
	mpc6tw88CyvbaC1HFOksR2L3+UrdahQOlO01P9Lk0OfaLOBz22N0NfKVGRM+QBDJnosDLq9ooLQ
	AgbOtHTfQMiIhhBpIBoveXUSQihNdSrAkoN67ge/6U40zEUJ3QPs7uND6g//OIXQDh6NudCFWLz
	ey75UmVg8JVGrxl+rJy+8+vHqrZjXFRo/zf+i5/28XdPwS49uPWFAt9svJSgEVw1MrY1rzzG/qm
	t8SeKE2Y7STURLthY8jHe2Zqxb7cog==
X-Google-Smtp-Source: AGHT+IH86Bw/EX6P3h1wRisNh0npZ+oiUFEi9OATWnxDcSUA7CdbhOWFzSmutrVwhuZzNJKNDXSKAw==
X-Received: by 2002:a05:6512:3ba2:b0:539:9505:7e5 with SMTP id 2adb3069b0e04-53df0106cccmr4621382e87.36.1732803400286;
        Thu, 28 Nov 2024 06:16:40 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df646efd9sm187897e87.143.2024.11.28.06.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 06:16:39 -0800 (PST)
Date: Thu, 28 Nov 2024 16:16:37 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: =?utf-8?Q?=C5=81ukasz?= Bartosik <ukaszb@chromium.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, 
	Benson Leung <bleung@chromium.org>, Jameson Thies <jthies@google.com>, linux-usb@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: ucsi: Fix completion notifications
Message-ID: <7e5p2ekpvxosb4axrzenifrtitzof6femyzld6wdcp3i7a5jh6@v476mzjit5zw>
References: <20241104154252.1463188-1-ukaszb@chromium.org>
 <5iacpnq5akk3gk7kdg5wkbaohbtwtuc6cl7xyubsh2apkteye3@2ztqtkpoauyg>
 <CALwA+Nb31ukU2Ox782Mq+ucBvEqm9_SioSAE23ifhX7DsHayhA@mail.gmail.com>
 <yphjztfvehbqd4xbdo7wtdfd4d3ziibq6hytuuxnoypdpsr462@zwl2cfj6f5kw>
 <CALwA+NYOm5mrw7=PSD+w_ma0hzR2CQ5dspz5X-bqi1o7ikfq6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALwA+NYOm5mrw7=PSD+w_ma0hzR2CQ5dspz5X-bqi1o7ikfq6Q@mail.gmail.com>

On Thu, Nov 28, 2024 at 11:08:46AM +0100, Łukasz Bartosik wrote:
> On Thu, Nov 21, 2024 at 11:53 PM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Wed, Nov 20, 2024 at 03:56:41PM +0100, Łukasz Bartosik wrote:
> > > On Mon, Nov 18, 2024 at 6:58 PM Dmitry Baryshkov
> > > <dmitry.baryshkov@linaro.org> wrote:
> > > >
> > > > On Mon, Nov 04, 2024 at 03:42:52PM +0000, Łukasz Bartosik wrote:
> > > > > OPM                         PPM                         LPM
> > > > >  |        1.send cmd         |                           |
> > > > >  |-------------------------->|                           |
> > > > >  |                           |--                         |
> > > > >  |                           |  | 2.set busy bit in CCI  |
> > > > >  |                           |<-                         |
> > > > >  |      3.notify the OPM     |                           |
> > > > >  |<--------------------------|                           |
> > > > >  |                           | 4.send cmd to be executed |
> > > > >  |                           |-------------------------->|
> > > > >  |                           |                           |
> > > > >  |                           |      5.cmd completed      |
> > > > >  |                           |<--------------------------|
> > > > >  |                           |                           |
> > > > >  |                           |--                         |
> > > > >  |                           |  | 6.set cmd completed    |
> > > > >  |                           |<-       bit in CCI        |
> > > > >  |                           |                           |
> > > > >  |   7.handle notification   |                           |
> > > > >  |   from point 3, read CCI  |                           |
> > > > >  |<--------------------------|                           |
> > > > >  |                           |                           |
> > > > >  |     8.notify the OPM      |                           |
> > > > >  |<--------------------------|                           |
> > > > >  |                           |                           |
> > > > >
> > > > > When the PPM receives command from the OPM (p.1) it sets the busy bit
> > > > > in the CCI (p.2), sends notification to the OPM (p.3) and forwards the
> > > > > command to be executed by the LPM (p.4). When the PPM receives command
> > > > > completion from the LPM (p.5) it sets command completion bit in the CCI
> > > > > (p.6) and sends notification to the OPM (p.8). If command execution by
> > > > > the LPM is fast enough then when the OPM starts handling the notification
> > > > > from p.3 in p.7 and reads the CCI value it will see command completion bit
> > > > > and will call complete(). Then complete() might be called again when the
> > > > > OPM handles notification from p.8.
> > > >
> > > > I think the change is fine, but I'd like to understand, what code path
> > > > causes the first read from the OPM side before the notification from
> > > > the PPM?
> > > >
> > >
> > > The read from the OPM in p.7 is a result of notification in p.3 but I agree
> > > it is misleading since you pointed it out. I will reorder p.7 and p.8.
> >
> > Ack, thanks for the explanation. Do you think that it also might be
> > beneficial to call reinit_completion() when sending the command? I think
> > we discussed this change few months ago on the ML, but I failed to send
> > the patch...
> >
> 
> Dmitry sorry for delayed response.
> 
> IMHO it makes sense to clear completion in ucsi_sync_control_common()
> with reinit_completion().

yes. before sending the command.

> But I wonder whether with this change moving from test_bit ->
> test_and_clear_bit do you still see a potential
> scenario for a race ?

Two notifications coming close enough so that the second one starts being
processed after receiving the first one but before completing it? On the
other hand, test_and_clear_bit() will handle that already.

> > > > > This fix replaces test_bit() with test_and_clear_bit()
> > > > > in ucsi_notify_common() in order to call complete() only
> > > > > once per request.
> > > > >
> > > > > Fixes: 584e8df58942 ("usb: typec: ucsi: extract common code for command handling")
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
> > > > > ---
> > > > >  drivers/usb/typec/ucsi/ucsi.c | 4 ++--
> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> > > > > index e0f3925e401b..7a9b987ea80c 100644
> > > > > --- a/drivers/usb/typec/ucsi/ucsi.c
> > > > > +++ b/drivers/usb/typec/ucsi/ucsi.c
> > > > > @@ -46,11 +46,11 @@ void ucsi_notify_common(struct ucsi *ucsi, u32 cci)
> > > > >               ucsi_connector_change(ucsi, UCSI_CCI_CONNECTOR(cci));
> > > > >
> > > > >       if (cci & UCSI_CCI_ACK_COMPLETE &&
> > > > > -         test_bit(ACK_PENDING, &ucsi->flags))
> > > > > +         test_and_clear_bit(ACK_PENDING, &ucsi->flags))
> > > > >               complete(&ucsi->complete);
> > > > >
> > > > >       if (cci & UCSI_CCI_COMMAND_COMPLETE &&
> > > > > -         test_bit(COMMAND_PENDING, &ucsi->flags))
> > > > > +         test_and_clear_bit(COMMAND_PENDING, &ucsi->flags))
> > > > >               complete(&ucsi->complete);
> > > > >  }
> > > > >  EXPORT_SYMBOL_GPL(ucsi_notify_common);

-- 
With best wishes
Dmitry

