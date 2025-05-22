Return-Path: <stable+bounces-146122-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 542D7AC14BB
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 21:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03D544E15B8
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 19:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0667D1E47A8;
	Thu, 22 May 2025 19:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kz1ddCio"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13615198E9B
	for <stable@vger.kernel.org>; Thu, 22 May 2025 19:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747941619; cv=none; b=BgK5xHPxJap0QJa3bOLXnB7stYWsTuGkq+qNglg5J2aXTOfIXrAAYT273MtQMhJn/ho6aYGDK80lFTSkeVfb3cN88KoIMtrWzsI41QWacrnEoadIvUnu5spGZxGYch49AAJZBwAjCJ3A7MIDE+oQmTte0jeziFz4/2jn+BHRZUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747941619; c=relaxed/simple;
	bh=Flu/isAmyCbTrz9xwLn13hoRVk9PwsB7V2D3/wlR9aE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F0YjbKi8tXC0DQ4ppiv/jMFoLKKZPAT7Ex7t4BPxJhWBnhxcshZWWjVf3uyrG4jB+50DWWWXk1O32Idit3HNKNZ1LVUFW43Tm2ca/y4B56kVbhoRR8FShvJXh6yVxWPHPDy2fznMfn9DdtV4IOZREgCWV3yBXDylVrfMalJRlgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kz1ddCio; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6f8b10b807fso91427226d6.1
        for <stable@vger.kernel.org>; Thu, 22 May 2025 12:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747941617; x=1748546417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PgIZQIPQ0j6raACnSoKFPNh2DzvC29iIOKiCMVH+gE8=;
        b=Kz1ddCio8Wg6juUFw3ZmZyvlB8xlyqBYYUdchO6LhII0ZV4DRwiyr76eJXnFRG+hoO
         elC8V1mbezzrlEHIKqZcUfQ3idyrN1jgBnxmbXl6a1JuZ6lowKhRDaTWEETCQ83eaDQS
         XL17dW1jw7dxZl/UrecyXvGHZJuA9hFYZuo0sIVpQtMWEwn46CxPa+C4KxOh0HOyYNYf
         SzQTenoVJO7ZtTb12PSKawsXDi/28va9Kqh+qzSIWzQLgx7db3KgJimnSdMv4Uz6DTcT
         4mDc9vXOlLfHHWyK36rE9/ghJpEXWijuUBtPzGB4uACRmck4NXIcr7n+5/jYHNf/ZWbA
         v3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747941617; x=1748546417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PgIZQIPQ0j6raACnSoKFPNh2DzvC29iIOKiCMVH+gE8=;
        b=reyiqvG2vz+TcT6ZQoN62aS5CDIrfTBGTdIjtfgpWTMTMO5XtkbVWAYn3THbZaqolY
         u42yCsuIzT/5YlQQvhiR6QkX2aZ0y60tME6ZlpfEWrPHCUHTHRbQXcH8DxWl0oRn2YVp
         AabAwN7Xgia2jVylOTfWEZ+V3LgtGtGYRyCshODcvYadJPBPvfw6wPxRe4W2Jr+qzB22
         ONcAWLC4o3mUBp3N/z+IWY/J2EYL2Y9YeqQNxUl2Uwpy1gl6SLYvfUf70I/Fu+QUmaJg
         lzpoghGSzLTEuqExqLzyVKqPtIJXvuP22sgBXzxEhFDst4pVWZEsCLYBr1hrzMeY7G3l
         CL/w==
X-Forwarded-Encrypted: i=1; AJvYcCXI+V5l72pk5e3VQyDovNL37XsaJ4lfzB7NwZ44xTNzCnPDMV87O0wgGG0WU5mflXylCAqiKlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAVjqHer78sYSrcCQCnq2C6Eg0ytBCX4Xfo8mOxBC4crAgpfTd
	Eq1D/RAFplGT5x9bOyeBPFJ4fMqFNY+81iYLnDDx/scbW4NOB4wDcNR/rEuuGNYsZ9V7n520WUP
	neM8JsSs0mIsw61QtSdflM6F9Nnm3P1ubb0iToYQE
X-Gm-Gg: ASbGncviFsifXdSXPu/ovVxDuFjQ9JuJxyj3subklwrxZQIFeNhIQOG2Bg3ChBK6Hgn
	4CxvRM6bPkLiUZSmOdTvWEJL/OiqrFq188iuh9CiU6pc7LPTjuK60JO5ip/IPNOM/5gjCjxBSjG
	8mBQrz4NdyU/YLwvLxDP86+S6hjqW5iLu1mjoAEe8wWpXXZvNDCeUQqhAVJfW0ApZzfUTKqTVwn
	bRv+lYq5z6+
X-Google-Smtp-Source: AGHT+IGm1Btmu3cb/tiOOdp0UebQ2jl7A41+6mFY13R7UjK0iunERZC6D0vXs4YT7J5HKX2YgiexhtSR0yQfkPA2JxA=
X-Received: by 2002:a05:6214:2345:b0:6f8:a7c2:bb11 with SMTP id
 6a1803df08f44-6fa93a29fddmr4939596d6.6.1747941616531; Thu, 22 May 2025
 12:20:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250517043942.372315-1-royluo@google.com> <8f023425-3f9b-423c-9459-449d0835c608@linux.intel.com>
 <CAMTwNXB0QLP-b=RmLPtRJo=T_efN_3H4dd5AiMNYrJDXddJkMA@mail.gmail.com>
 <fbf92981-6601-4ee9-a494-718e322ac1b9@linux.intel.com> <CA+zupgyU2czaczPcqavYBi=NrPqKqgp7SbrUocy0qbJ0m9np6g@mail.gmail.com>
 <6bfee225-7519-41ab-8ae9-99267c5ce06e@intel.com>
In-Reply-To: <6bfee225-7519-41ab-8ae9-99267c5ce06e@intel.com>
From: Roy Luo <royluo@google.com>
Date: Thu, 22 May 2025 12:19:40 -0700
X-Gm-Features: AX0GCFuJzBzMPdmywUarQdKbXYdF5W_yqGe-afth_QCS9OITwqZ39S_C5IBtRsY
Message-ID: <CA+zupgxkvm9HxG4Aj1avPA-ZgjVxmg3T3GtbfnV=rXk9P7-pFQ@mail.gmail.com>
Subject: Re: [PATCH v1] Revert "usb: xhci: Implement xhci_handshake_check_state()
 helper"
To: Mathias Nyman <mathias.nyman@intel.com>
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>, 
	Udipto Goswami <udipto.goswami@oss.qualcomm.com>, quic_ugoswami@quicinc.com, 
	Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org, michal.pecio@gmail.com, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 5:24=E2=80=AFAM Mathias Nyman <mathias.nyman@intel.=
com> wrote:
>
> On 22.5.2025 5.21, Roy Luo wrote:
> >>>> Udipto Goswami, can you recall the platforms that needed this workar=
oud?
> >>>> and do we have an easy way to detect those?
> >>>
> >>> Hi Mathias,
> >>>
> >>>   From what I recall, we saw this issue coming up on our QCOM mobile
> >>> platforms but it was not consistent. It was only reported in long run=
s
> >>> i believe. The most recent instance when I pushed this patch was with
> >>> platform SM8650, it was a watchdog timeout issue where xhci_reset() -=
>
> >>> xhci_handshake() polling read timeout upon xhci remove. Unfortunately
> >>> I was not able to simulate the scenario for more granular testing and
> >>> had validated it with long hours stress testing.
> >>> The callstack was like so:
> >>>
> >>> Full call stack on core6:
> >>> -000|readl([X19] addr =3D 0xFFFFFFC03CC08020)
> >>> -001|xhci_handshake(inline)
> >>> -001|xhci_reset([X19] xhci =3D 0xFFFFFF8942052250, [X20] timeout_us =
=3D 10000000)
> >>> -002|xhci_resume([X20] xhci =3D 0xFFFFFF8942052250, [?] hibernated =
=3D ?)
> >>> -003|xhci_plat_runtime_resume([locdesc] dev =3D ?)
> >>> -004|pm_generic_runtime_resume([locdesc] dev =3D ?)
> >>> -005|__rpm_callback([X23] cb =3D 0xFFFFFFE3F09307D8, [X22] dev =3D
> >>> 0xFFFFFF890F619C10)
> >>> -006|rpm_callback(inline)
> >>> -006|rpm_resume([X19] dev =3D 0xFFFFFF890F619C10,
> >>> [NSD:0xFFFFFFC041453AD4] rpmflags =3D 4)
> >>> -007|__pm_runtime_resume([X20] dev =3D 0xFFFFFF890F619C10, [X19] rpmf=
lags =3D 4)
> >>> -008|pm_runtime_get_sync(inline)
> >>> -008|xhci_plat_remove([X20] dev =3D 0xFFFFFF890F619C00)
> >>
> >> Thank you for clarifying this.
> >>
> >> So patch avoids the long timeout by always cutting xhci reinit path sh=
ort in
> >> xhci_resume() if resume was caused by pm_runtime_get_sync() call in
> >> xhci_plat_remove()
> >>
> >> void xhci_plat_remove(struct platform_device *dev)
> >> {
> >>          xhci->xhc_state |=3D XHCI_STATE_REMOVING;
> >>          pm_runtime_get_sync(&dev->dev);
> >>          ...
> >> }
> >>
> >> I think we can revert this patch, and just make sure that we don't res=
et the
> >> host in the reinit path of xhci_resume() if XHCI_STATE_REMOVING is set=
.
> >> Just return immediately instead.
> >>
> >
> > Just to be sure, are you proposing that we skip xhci_reset() within
> > the reinit path
> > of xhci_resume()? If we do that, could that lead to issues with
> > subsequent operations
> > in the reinit sequence, such as xhci_init() or xhci_run()?
>
> I suggest to only skip xhci_reset in xhci_resume() if XHCI_STATE_REMOVING=
 is set.
>
> This should be similar to what is going on already.
>
> xhci_reset() currently returns -ENODEV if XHCI_STATE_REMOVING is set, unl=
ess reset
> completes extremely fast. xhci_resume() bails out if xhci_reset() returns=
 error:
>
> xhci_resume()
>    ...
>    if (power_lost) {
>      ...
>      retval =3D xhci_reset(xhci, XHCI_RESET_LONG_USEC);
>      spin_unlock_irq(&xhci->lock);
>      if (retval)
>        return retval;
> >
> > Do you prefer to group the change to skip xhci_reset() within the
> > reinit path together
> > with this revert? or do you want it to be sent and reviewed separately?
>
> First a patch that bails out from xhci_resume() if XHCI_STATE_REMOVING is=
 set
> and we are in the reinit (power_lost) path about to call xhci_reset();
>
> Then a second patch that reverts 6ccb83d6c497 ("usb: xhci: Implement
> xhci_handshake_check_state()
>
> Does this sound reasonable?
>
> should avoid the QCOM 10sec watchdog issue as next xhci_rest() called
> in xhci_remove() path has a short 250ms timeout, and ensure the
> SNPS DWC3 USB regression won't trigger.
>
> Thanks
> Mathias
>

Thanks for the clarification! SGTM.
I've sent out a new patchset accordingly
https://lore.kernel.org/linux-usb/20250522190912.457583-1-royluo@google.com=
/

Thanks,
Roy

