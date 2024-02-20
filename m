Return-Path: <stable+bounces-20791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4A885B805
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 10:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C261A1F25067
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 09:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6B76351D;
	Tue, 20 Feb 2024 09:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lhMvpXN9"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F44562178
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 09:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708422216; cv=none; b=pfPLE23+nNNLrQufIVn6ccVWu4fslbjj1QPCZ12sq4wXkYHAPOgH9nWPDiOqVS/uZys5LgtRoRy294STyPJ823Q6o5cpzlHSr4xcQQ28eb2mMh4JaVmC5LiFbnj741B2D11xCEBEIOr2k3GjnWSAo6UZbLz6RaqK911/FwXUik8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708422216; c=relaxed/simple;
	bh=rlFKBjfxBfB5przc60p+qp81VvS1nj/vKLjjDNglv3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V/Rnzze2Im/+7gPMgtxfaUowHwQvMym3euk+A5B3oBalhsiKSoSLPw63cMSqGOcUrLnUB4Yd4zuasiceehH+BeIi4+V9EzAxzjv2sjBP/AjHT8eFIsdFq65L4YiUkq88UCZbvAtAqbTN2A7elLJL1SRtkE3b0UxRGzC4zhcNOjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lhMvpXN9; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-563e6131140so4768800a12.2
        for <stable@vger.kernel.org>; Tue, 20 Feb 2024 01:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708422213; x=1709027013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wXGNSO7EAp4ThzIsFzmHN2w6lFZhp54XNCpapquw2M=;
        b=lhMvpXN904q2pks39RZqlAavJW8u9xVuxVNfmDwC0VRkR06xSxBTTOcx2TmUarqFOw
         n29uVI1hmLITquzoPhEO7VBmWTKO/iWJgzxkpJ6R8JUU0OPq6fVsuY1nRTL047tONHdj
         YxSo+arbnPZxqXm8fn79pXozFqIV7zoZwJc6uRIuLggcZmmzo2lruNee7VgS7r3nWh1H
         C3OEn3+EXha5AdDMtvirEUAf1JyYTjbnHFFtkaewLNamlU+UWsZmeRP4DbrN+JFwmCRy
         Wm1hMSAMefS1I/wjZXERJhqnapVlX9I2MwJ06AvkQwZsku8CHo2TLXPqKsbu46FAgfzI
         H/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708422213; x=1709027013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6wXGNSO7EAp4ThzIsFzmHN2w6lFZhp54XNCpapquw2M=;
        b=adOaKFEqoiTZOLepDCzqyTBA3+XOzh0TNC98YCFDgodOh7Tu4jljyjHvZD2jZPeGpm
         HIlMrLQCFXBkQzsT4nPxHh8uWEzSo8B1H++9jOHuBsWuo+mqAQDznkCBHiPtmQgrlAXo
         PCuCJXOHr5TmSaEEXZA87AxYBw/T6w7v7xKwLO5JcRRsluF5lZc84ihJb9zy7iikIcU1
         Nw+2oW0qRfwJqe0GU+D2h3wL1yw/kqari8OnSUTlKWICQIY8KUJj7r7wL6lhnp6xpFwD
         wBe9qsFbLwCYKcMP2G6+4JzYqBSRDLjQ3AykqYxjzxHM29SjlpYgzVjiBpjP6DBc6pZL
         lGlg==
X-Forwarded-Encrypted: i=1; AJvYcCXq3dYm0BZnVmict/TEdpxqo64n21WA4aZNHz1Iri/5JexK1tdmnZftl3hLpoc69TOuAASVFNrFH5jGr1FVlKBVbYrp6UkB
X-Gm-Message-State: AOJu0YwIlH4Elfj0dp+DbJyQ0AxAPhsHlNHradAquYYcl4DAy1T+0+KF
	kBtGFAi0vegvzH9u/HdXUujKx8YxaiYYPmvqxsCNkawhZdMrZ6ozIq9XXz0ZS23EZgkAP38v13T
	0QMl8usIJB6vhVXzZULLVhZMKzP8n5Tixl4Rz
X-Google-Smtp-Source: AGHT+IGo8bMi1ufIugwBQxJ09WQnYJlAWn1e8eQOJeCgyp5JhtuInq+rAAuyt68+BhpUHU0p7WmO3Bz0UMzJA8+aWuo=
X-Received: by 2002:a05:6402:3588:b0:564:762c:fe5e with SMTP id
 y8-20020a056402358800b00564762cfe5emr3859938edc.20.1708422212502; Tue, 20 Feb
 2024 01:43:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220081205.135063-1-raychi@google.com> <2024022024-trout-kennel-6d14@gregkh>
 <4d62d4d0-3f28-486b-8132-4cc571b6f721@quicinc.com>
In-Reply-To: <4d62d4d0-3f28-486b-8132-4cc571b6f721@quicinc.com>
From: Ray Chi <raychi@google.com>
Date: Tue, 20 Feb 2024 17:42:56 +0800
Message-ID: <CAPBYUsD=3ux8RXgRcroVsmpqNs0D+2NeLhqPHh3TBB_oq=ziXA@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc3: gadget: remove warning during kernel boot
To: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Thinh.Nguyen@synopsys.com, 
	quic_uaggarwa@quicinc.com, albertccwang@google.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krishna,

I verified the Thinh's patch and the warning could be
fixed. Thanks for the information.

Regards,
Ray

On Tue, Feb 20, 2024 at 4:40=E2=80=AFPM Krishna Kurapati PSSNV
<quic_kriskura@quicinc.com> wrote:
>
>
>
> On 2/20/2024 2:04 PM, Greg KH wrote:
> > On Tue, Feb 20, 2024 at 04:12:04PM +0800, Ray Chi wrote:
> >> The dwc3->gadget_driver is not initialized during the dwc3 probe
> >> process. This leads to a warning when the runtime power management (PM=
)
> >> attempts to suspend the gadget using dwc3_gadget_suspend().
> >
> > What type of warning happens?
> >
> >> This patch adds a check to prevent the warning.
> >>
> >> Cc: stable@vger.kernel.org
> >> Fixes: 61a348857e86 ("usb: dwc3: gadget: Fix NULL pointer dereference =
in dwc3_gadget_suspend")
> >> Signed-off-by: Ray Chi <raychi@google.com>
> >> ---
> >>   drivers/usb/dwc3/gadget.c | 3 +++
> >>   1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> >> index 28f49400f3e8..de987cffe1ec 100644
> >> --- a/drivers/usb/dwc3/gadget.c
> >> +++ b/drivers/usb/dwc3/gadget.c
> >> @@ -4708,6 +4708,9 @@ int dwc3_gadget_suspend(struct dwc3 *dwc)
> >>      unsigned long flags;
> >>      int ret;
> >>
> >> +    if (!dwc->gadget_driver)
> >> +            return 0;
> >> +
> >
> > This directly reverts part of the commit you say this fixes, are you
> > SURE about this?  Why?
> >
>
> Hi Ray,
>
> Thinh sent a patch recently addressing the issue in soft disconnect.
> Can you check if it helps:
>
> https://lore.kernel.org/all/e3be9b929934e0680a6f4b8f6eb11b18ae9c7e07.1708=
043922.git.Thinh.Nguyen@synopsys.com/
>
> Regards,
> Krishna,

