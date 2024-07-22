Return-Path: <stable+bounces-60713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95618939347
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 19:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 275A31F21E68
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 17:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7FC16EC05;
	Mon, 22 Jul 2024 17:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="paTEZkxY"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A4616EB41
	for <stable@vger.kernel.org>; Mon, 22 Jul 2024 17:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721670127; cv=none; b=FVr61SFp8WjlqdnLitSy5151wiL6abjCOx+ge42H3vPV2tMM5koS02Snb36Nf2Rx+1OQCaEj4sdDgvu5L6WgqOLbRiuzVZJ+d4n02+Wv3Zktm4xvoMEnAEeioCQT2keYJlRvHHPLaQvpbpDYKSvx5wPXUSJ6jPnETmMjdmne1CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721670127; c=relaxed/simple;
	bh=ugor9w5E1mjhIPRTlWtgixZzPX0NqkshVh+YsIeluos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OG/Wry/1kXgPS1wH4Zsutya3skGMrbL+Pl3awi54YwnGFkKTh2iwCQ8EgQt92EUtB9lGVPDn0VskrvHsttLgXh3tRWWZpJ6gAkX/PbYneN2ZXhy9jx2+i2Zspjn6P0Ig9t0Pd5xFu+aUzIZZhm/eqGAKwckf5qwmV9Ylyd/bNDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=paTEZkxY; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.harvard.edu
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6510c0c8e29so44186217b3.0
        for <stable@vger.kernel.org>; Mon, 22 Jul 2024 10:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1721670124; x=1722274924; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GEAsfep1o9bHfuVcReQXlWhCpCPBZX/z+vcGE41Ain8=;
        b=paTEZkxYSt7I+TVvHCcf+cG5Ttrag7DgIl4cZBYjlLk+dpYuYmUiuA8KbUGaTGLIaK
         VzgjmAce1n9PalHB+8AKdYvOlBBOAD/P/0XFkG/FxG2jKPxXEDRZ2aKkdiughOvxXAuF
         DINQzhiMgVUW9oerS290WLshnq4ry/zaHwzpsPXkV99QxCYZvThj783DZJeKBgTqoHaf
         xIMb8NDkflriruhA3TQ018UdfkFWJEfH82JfyZ7nZO76e+Qc5wdBhH8QyNN1BPcnLOfO
         HW0AJG11EaIA3ndZT3pWv8StByDEOITeEXSMFMVgd8hOOFplW3dt9gmZYA5O4kHInyQo
         PQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721670124; x=1722274924;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GEAsfep1o9bHfuVcReQXlWhCpCPBZX/z+vcGE41Ain8=;
        b=b7SGBS9IVF2rK7TW9ocNQLHYezWxnXnUjeK5cL4K87a4e9fjLCYgXt7yKRQSkckAmk
         ddRzHWYM3P1MnXcoh2MpSBkHjloqTm+TkDkl6tnkXkguv7j/+XDIydkEodwlrD+K0d84
         EJkT9okF/kDCbG66eC/UfAqanok6fqv8j3AoIrRkvxBiXKM51BlLv5hsgkCVes5TN94g
         GYUK1SmEPqyY6APc1gTY5QrIEfEbsfyRPiAOusC8dFJP9/K6/FuzA0d94AF6y2b3nhV4
         qVjuyZ7Y+pQ5oqshUEepHEDdEKdYcAKaLfd3gDVB3Si6ch0FTVzUYDem3f0/IYaB0HxP
         VYwg==
X-Forwarded-Encrypted: i=1; AJvYcCVWHFdVmxFNhLpnZX9C5ZS58VIdvKdk0K2eYaQnE0F/UmulJCfBhcJ52J0D6pPt0MMNlt+3VFRUJTegN/gSDcBwqYPLekn7
X-Gm-Message-State: AOJu0YyPJ/RGqytS6KjJMQfdE/MBzeG5ojB7kW0T2D16KalDQvJJcaKO
	HUBtk5bQo/E2dLKU6DWXVt7KVpyRfko21A+qWA+uywLPiSuQRCkh5eAvQt4Egg==
X-Google-Smtp-Source: AGHT+IHj+m1AO569rZQrG4jvehlr1DtinQEuf9uup9u3ryjKrg2R5yTBlWyPsl8/KQkTrF2H/4zZkw==
X-Received: by 2002:a0d:cd82:0:b0:62f:a250:632b with SMTP id 00721157ae682-66e4b8e155cmr5726207b3.8.1721670124661;
        Mon, 22 Jul 2024 10:42:04 -0700 (PDT)
Received: from rowland.harvard.edu (iolanthe.rowland.org. [192.131.102.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a19905a8f3sm383032885a.80.2024.07.22.10.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 10:42:04 -0700 (PDT)
Date: Mon, 22 Jul 2024 13:42:01 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Chris Wulff <crwulff@gmail.com>
Cc: linux-usb@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Roy Luo <royluo@google.com>,
	Krishna Kurapati <quic_kriskura@quicinc.com>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	yuan linyu <yuanlinyu@hihonor.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Felipe Balbi <balbi@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: core: Check for unset descriptor
Message-ID: <97672e7a-edb4-4a00-b404-c5891319912e@rowland.harvard.edu>
References: <20240721192048.3530097-2-crwulff@gmail.com>
 <29bc21ae-1f8a-47fd-b361-c761564f483a@rowland.harvard.edu>
 <CAB0kiBJYm9F4w5H8+9=dcmoCecgCwe6rTDM+=Ch1x-4mXEqB5A@mail.gmail.com>
 <b35e043d-a371-4cf9-b414-34ba72df1ccc@rowland.harvard.edu>
 <CAB0kiBKDB=1kF4YRXckph4QG7tQbDdBMsOtcQh9+p1jtyokdPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB0kiBKDB=1kF4YRXckph4QG7tQbDdBMsOtcQh9+p1jtyokdPw@mail.gmail.com>

On Mon, Jul 22, 2024 at 01:11:01PM -0400, Chris Wulff wrote:
> On Mon, Jul 22, 2024 at 9:38 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Mon, Jul 22, 2024 at 09:00:07AM -0400, Chris Wulff wrote:
> > > On Sun, Jul 21, 2024 at 9:07 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > > >
> > > > On Sun, Jul 21, 2024 at 03:20:49PM -0400, crwulff@gmail.com wrote:
> > > > > From: Chris Wulff <crwulff@gmail.com>
> ...
> > > The previous check was also hiding the error, and introduced a panic.
> > > I could add a printk to that error case, though it would be unassociated
> > > with the gadget that caused the problem. This function does also return
> > > an error code when it fails, so the calling function can check that and
> > > print an error.
> >
> > Okay.  It wouldn't hurt to print out an error message, even if there's
> > no way to tell which gadget it refers to.  A dump_stack() would help in
> > that regard, but it won't be needed if the guilty party will always be
> > pretty obvious.
> >
> > By the way, how did you manage to trigger this error?  None of the
> > in-kernel gadget drivers are known to have this bug, and both the
> > gadgetfs and raw_gadget drivers prevent userspace from doing it.  Were
> > you testing a gadget driver that was under development?
> 
> I am working on adding alternate settings to UAC1/2 gadgets, so this really
> was a case of trying to make the failure in development easier to deal with.
> I don't believe there are any problems with existing gadgets causing this.
> 
> I will add an error message and submit a new version. Perhaps
> WARN_ON_ONCE would be appropriate here to get that backtrace
> instead of a printk?

That sounds good.  You should also mention in the patch description that 
the purpose is to prevent undebuggable panics during driver development, 
and no existing drivers will trigger the warning.

Alan Stern

