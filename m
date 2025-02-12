Return-Path: <stable+bounces-115073-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D5DA32E25
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 19:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 302457A0F5B
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 18:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A955525D548;
	Wed, 12 Feb 2025 18:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MkwItBvo"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D1025A622
	for <stable@vger.kernel.org>; Wed, 12 Feb 2025 18:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739383563; cv=none; b=Nk8P0Fq3VyhBp76r54Olo1fOpT9UUZ3OJXmozrgjDGx7f8abRWzlRCyj/txXEz4XeXqxENTo6GPtwtxIvxtOMUTEvRX4ObxMnK4NL6UOtIxjlCZIkR1SmhGH6DMy+R+WqgKGrw7QxOguwZUtJqPAcwYCu9FLuUMNPDrIIJDRwiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739383563; c=relaxed/simple;
	bh=tJnaPVXf7C5zD77/AWLmv25JpFX7qo5ZjH3DvCBibtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rr8b4exvEOagIwfQTjmTrK2cUVrGJ4Aaar+yLW2GtisJ9NiCqLNuosIiGTnUg5PiayKb9kr/NwSEDTjTdBvFBsfAyiI2L34HbS/0ooqsTJXftmQu9ea7uUfB54QCu2ugw/vhJjdOWH66mHs3/XcPl2FhQe+Rc2k3Z3Y0QZruvSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MkwItBvo; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5450abbdce0so3785226e87.3
        for <stable@vger.kernel.org>; Wed, 12 Feb 2025 10:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739383557; x=1739988357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJnaPVXf7C5zD77/AWLmv25JpFX7qo5ZjH3DvCBibtk=;
        b=MkwItBvoG5JoXOS6DLehBvo5sQwGngQrqpcT0oEr1oeBEABOTWwZTL+b3SrH4E1j6v
         Uyc0ChIMJ82p1KZrZXhZv1SMmcoztT88DpOUWDnGxok1FmJQHo+2008XinHAnPEV4/Vx
         F+lZj/P2auKX9EFwP3O70Rx12vL3MMyXpL/tY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739383557; x=1739988357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJnaPVXf7C5zD77/AWLmv25JpFX7qo5ZjH3DvCBibtk=;
        b=PJAKL3f/eWyzmFEbe+VqVo4L4914ZrZR01m+QrSArb8fSPZN4lP58LICqpc9Non1Sk
         IzgFIlUv884BQ8I2Uz46E4bXVp4Q1ql9UQPce9+TPAXQg54++l4tmNiSvtV4EeUKky54
         BUEo+guqp2m+3azDrkUXAe2C1zk9DCqDVztOUiLCyRw8BxlqWBjipoDoZKX96aW1AePI
         DXSNZgXa+2f8GlOw3wufmVhlfxGIO1vYsZD5wpTIxMb60/8pIg8buud8MK05xMlsGFSc
         xCfgQ0OnswIvrdMrRcK9Coyj9RmVkHnq8FgXgCnP0FSAojfbEJcBEjmeQPjgU6W4nQEl
         jvZg==
X-Forwarded-Encrypted: i=1; AJvYcCVr2WnR+EXse3yYzPXrfy4Dn+8uVPChNI+oAqYSMKa4UQA3sf3qBWCIPKLiVWiGlpK5yi34dLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YylMwAUF/8169ucroYtj23Dg+k6eQnUMC3hFusI+I/5Sxtd/Aep
	v5Y+1v4hSDO6ybEdFisAHmjDBWkiqI1CZkONMFewom1qUt+M6zVlSq+yhfZqkOxMWuJggphrslu
	KGX20
X-Gm-Gg: ASbGnctAqj8ghAjy9jUlCYf1bDuAxYx9lZYbjs/EXOEUj8KjVE5+KupLQqPsJ6TeEaV
	FEl4pRUPHz4CXq71O6QdghgFEwSrUJ0IZt8IIJaGTvZnHNhqjPwsbiZaeYhjBcy25GnevBtYAYh
	ijgr0qmQL3HVI0qGCX99jrhPzaL/ofiUsTVvNto7M94DEhuQdwbjKoCFfQW58A9ALS/FveQNFVl
	rJPQ4HIBEB1ul5E6kKExvTTGIXT3VqNZ7UD5lvu9ApyGUhul+fb48sAX+MoGTKrIsWd8nfVk3I8
	xymp12wzQnECwoDayz2tws9mL26yKRrg5GjOvvDi3wui6hk++TRJZxw=
X-Google-Smtp-Source: AGHT+IH23X17P7u8uossem0LdPQsUAJiSZk8TkZArToK/ZgyM6/QD5I4HFIRGTglIW9aYaJQqfW4GQ==
X-Received: by 2002:ac2:4e05:0:b0:545:aaf:13f5 with SMTP id 2adb3069b0e04-545184a3aa5mr1504125e87.37.1739383556453;
        Wed, 12 Feb 2025 10:05:56 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-545038d5b88sm1522651e87.178.2025.02.12.10.05.54
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 10:05:55 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5450f38393aso2999072e87.0
        for <stable@vger.kernel.org>; Wed, 12 Feb 2025 10:05:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVwuAWHxFaW3LrwxicqjzOgfDgWYXB0ZaPkszJEX2Dw6rlOCyP2vSAsJQUnfdJmgf0d5eZWHmo=@vger.kernel.org
X-Received: by 2002:a05:6512:23a0:b0:542:29b6:9c26 with SMTP id
 2adb3069b0e04-545184bc10cmr1392880e87.47.1739383553822; Wed, 12 Feb 2025
 10:05:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107200715.422172-1-dianders@chromium.org>
 <20250107120555.v4.2.I2040fa004dafe196243f67ebcc647cbedbb516e6@changeid>
 <e6820d63-a8da-4ebb-b078-741ab3fcd262@arm.com> <CAD=FV=WTe-yULo9iVUX-4o8cskPNp8dK-N9pKq6MxqrPX3UMGw@mail.gmail.com>
 <Z6zf3YJq6qqoJQRi@arm.com>
In-Reply-To: <Z6zf3YJq6qqoJQRi@arm.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 12 Feb 2025 10:05:41 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XZnb-c+9LVYWmA0EZPTX0enpZQdwokRanKZ78RRQOAzw@mail.gmail.com>
X-Gm-Features: AWEUYZkYpo4ZdBFbmBIkTo_Y8VQo51FzREvP3YsId9scTLFHz9v6oyFYchRiLcQ
Message-ID: <CAD=FV=XZnb-c+9LVYWmA0EZPTX0enpZQdwokRanKZ78RRQOAzw@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] arm64: errata: Assume that unknown CPUs _are_
 vulnerable to Spectre BHB
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Roxana Bradescu <roxabee@google.com>, 
	Julius Werner <jwerner@chromium.org>, bjorn.andersson@oss.qualcomm.com, 
	Trilok Soni <quic_tsoni@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	Florian Fainelli <florian.fainelli@broadcom.com>, linux-arm-kernel@lists.infradead.org, 
	Jeffrey Hugo <quic_jhugo@quicinc.com>, Scott Bauer <sbauer@quicinc.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 12, 2025 at 9:52=E2=80=AFAM Catalin Marinas <catalin.marinas@ar=
m.com> wrote:
>
> On Wed, Jan 29, 2025 at 11:14:20AM -0800, Doug Anderson wrote:
> > On Wed, Jan 29, 2025 at 8:43=E2=80=AFAM James Morse <james.morse@arm.co=
m> wrote:
> > > Arm have recently updated that table of CPUs
> > > with extra entries (thanks for picking those up!) - but now that patc=
h can't be easily
> > > applied to older kernels.
> > > I suspect making the reporting assuming-vulnerable may make other CPU=
s come out of the
> > > wood work too...
> > >
> > > Could we avoid changing this unless we really need to?
> >
> > Will / Catalin: Do either of you have an opinion here?
>
> Is this about whether to report "vulnerable" for unknown CPUs? I think
> Will suggested this:
>
> https://lore.kernel.org/all/20241219175128.GA25477@willie-the-truck/

Right. The patch in its current form is in direct response to what
Will requested and then subsequent feedback on the mailing lists from
Julius Werner.


> That said, some patch splitting will help to make review easier. Should
> such change be back-portable as well? I think so, it's not only for CPUs
> we'll see in the future.

Personally, I don't think the patch will be terribly hard to backport
as-is. I would expect it to just cherry-pick cleanly since it only
touches spectre code and I'd imagine all that stuff is being
backported verbatim. I did at least confirm that it applies cleanly to
v5.15.178 (I didn't try compiling though). I guess there are conflicts
back to v5.10.234, though...

While I've had plenty of time to work on this patch in the last three
months since I posted the early versions, recently my assignments at
work have changed and I have a lot less time to work on this patch
series. If breaking this up is blocking this patch from landing then
I'll try to find some time in the next month or two to do it. Let me
know.

-Doug

