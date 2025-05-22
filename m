Return-Path: <stable+bounces-146015-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5BCAC026E
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34C021B6369E
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C013F5475E;
	Thu, 22 May 2025 02:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zSeL6So1"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37CE1BC41
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747880555; cv=none; b=sRwivV2MjMfaIToTslbr/PKzpqIjhD12p5RERIaoUt8myw6Kcj/vdtjoYyQ3YKAdI6PvbtI+k99FOytAizQn10w8S/Ee/ukewGYOeFoXrPntFjdabliSqos47PfANZ8TufhNkMO48L/OpMTU6UuRSswc7TJ7TL896fy+M5D46kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747880555; c=relaxed/simple;
	bh=SbJQmBmxZPR8coPCUMiUL7otI69+WcCa0485S2sBHh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KZW3PXwVxvNvXBoJ5KG3XBR0T2I+Eeaoaif640zTYtPfSo/GKixPOAX3AlDpEhGftUIUcjoI/gi0nDErvc6VJnk1aWXPq79JCb6nfqa5lqlLKzg9BOhMVtHuPAFP8K4kY/V3hZJ4Lw6J0e9ASSuTX+nh5tPArJ7JcR0HtRsjxg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zSeL6So1; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6f8c2e87757so67325716d6.2
        for <stable@vger.kernel.org>; Wed, 21 May 2025 19:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747880553; x=1748485353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdUzQUue9v8nSaPVDipR0NdMbJfNS0IJI4RFISwRhr4=;
        b=zSeL6So1axiAzw0s0YRJNhgRJmqRq/AcJt8ZOE/O/7FTfJ7Fxxqp5el8AiIdtlHA9Q
         38gKo9tZcmS0XkHTRr+oDbTUS4B6iRGREGvNWalE233C84olQ+dWeZtQH9qEO7+YRqBH
         b1VzTdbk86NtSzI6KKKhGNaIt/vVkf6ZoUgRlm9MR7KHlw4Hn+G+7n+h/JVFKwYm4kdV
         0fVZEMHc9Ig+xS2JUnXdB/n6cVFibzh+rkZEMmfv45a+XV9A2vmfgZ+A+dX4XfC8DlZr
         el7nKcpBvKISKyuPhjuliVui+ZPeh1JjfGXfLXvnmpxOGssKby3RZWhzWnfHkLQEMx0b
         fOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747880553; x=1748485353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cdUzQUue9v8nSaPVDipR0NdMbJfNS0IJI4RFISwRhr4=;
        b=XiEAAGiI1ItSJwLmwZL/Gxp9rtVNmjUAR4S+tfSDfXJqLYrlIL4DFFZZxJ0i2npnkl
         g7jCqPJJI75UHs8TwFBFohddJhUKwSnIGFLFA/4AuCaRY+Hm68LZfSF5523VA9bGeBC5
         H7x/DbX2OUWmgnRmOe8gKxVnUyJjlBJLseVcXB9ee2PhXYar0Xs3ALn6p4/qFZrf3A//
         /MfeL2GqQ9RLxke0t6cCAnWqyTT83/qqNsU1iv/4vkLgJIjdV/l/EZu86kdwt6eieqL0
         GYcEUuxwWUL3Z1rsWq2u9f5TOk7Nqv7HDXQIh+4DzsqpK8PDdQbdRa2Ieyr9BedhFBcf
         BTgQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/21g9TvD9EUMnSxUYUigx5YXsDFsCl3SAPxSGk4aPX7QNmnbbmkbKyTRVSY9jNYJE9Gb/u9g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxah6XvDxrpyF6kDlHEyuONU3XU9lFoYeYOM4NmNrD6lJ3jEWPz
	dBaeW28L2+HE9EvRrJQEBdrimpAmaLAJdt8VhPaOklyMeiM6T2pgdJ42ugyJPcyjuZvylbr6j44
	Gb5xKNZTBcnL+TpOyYLWsmfL4A4mDzcBq4VTeuW13
X-Gm-Gg: ASbGnct8wX+uKykVNMLqFyY4R+ZCaFJSEBzp8UXxyjRYltOz8uQuW8nXjRCxckpdwGF
	U9LNfJiqiRV+PPrmRVvy+TLHXHwaP1tQEMC90QP0PUo+9BvRwy/Cx4yNDoHvic/oLd9r4nbDnix
	StExKhzNNKIMSPLz8fx5s3NvZHFIcoMQgFkJRKyRituMCKmq80Ivd+
X-Google-Smtp-Source: AGHT+IGvvbhx/OpA0ADthVbZJdPu7pa/8lX6HpZ2/4FqctQxusP4BwE7BrxBFTW4uqHmQiW92Q2I875vsEXDKNgKAo0=
X-Received: by 2002:a05:6214:202e:b0:6e8:9dfa:d932 with SMTP id
 6a1803df08f44-6f8b0836cc1mr397664296d6.15.1747880552448; Wed, 21 May 2025
 19:22:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250517043942.372315-1-royluo@google.com> <8f023425-3f9b-423c-9459-449d0835c608@linux.intel.com>
 <CAMTwNXB0QLP-b=RmLPtRJo=T_efN_3H4dd5AiMNYrJDXddJkMA@mail.gmail.com> <fbf92981-6601-4ee9-a494-718e322ac1b9@linux.intel.com>
In-Reply-To: <fbf92981-6601-4ee9-a494-718e322ac1b9@linux.intel.com>
From: Roy Luo <royluo@google.com>
Date: Wed, 21 May 2025 19:21:56 -0700
X-Gm-Features: AX0GCFvMkPkxo-3aieFdeqIqShCAfovkwXEc0Hi9O2cZxOCA7YSaj1sjHUDCI0Q
Message-ID: <CA+zupgyU2czaczPcqavYBi=NrPqKqgp7SbrUocy0qbJ0m9np6g@mail.gmail.com>
Subject: Re: [PATCH v1] Revert "usb: xhci: Implement xhci_handshake_check_state()
 helper"
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Udipto Goswami <udipto.goswami@oss.qualcomm.com>, mathias.nyman@intel.com, 
	quic_ugoswami@quicinc.com, Thinh.Nguyen@synopsys.com, 
	gregkh@linuxfoundation.org, michal.pecio@gmail.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 9:18=E2=80=AFAM Mathias Nyman
<mathias.nyman@linux.intel.com> wrote:
>
> On 19.5.2025 21.13, Udipto Goswami wrote:
> > On Mon, May 19, 2025 at 6:23=E2=80=AFPM Mathias Nyman
> > <mathias.nyman@linux.intel.com> wrote:
> >>
> >> On 17.5.2025 7.39, Roy Luo wrote:
> >>> This reverts commit 6ccb83d6c4972ebe6ae49de5eba051de3638362c.
> >>>
> >>> Commit 6ccb83d6c497 ("usb: xhci: Implement xhci_handshake_check_state=
()
> >>> helper") was introduced to workaround watchdog timeout issues on some
> >>> platforms, allowing xhci_reset() to bail out early without waiting
> >>> for the reset to complete.
> >>>
> >>> Skipping the xhci handshake during a reset is a dangerous move. The
> >>> xhci specification explicitly states that certain registers cannot
> >>> be accessed during reset in section 5.4.1 USB Command Register (USBCM=
D),
> >>> Host Controller Reset (HCRST) field:
> >>> "This bit is cleared to '0' by the Host Controller when the reset
> >>> process is complete. Software cannot terminate the reset process
> >>> early by writinga '0' to this bit and shall not write any xHC
> >>> Operational or Runtime registers until while HCRST is '1'."
> >>>
> >>> This behavior causes a regression on SNPS DWC3 USB controller with
> >>> dual-role capability. When the DWC3 controller exits host mode and
> >>> removes xhci while a reset is still in progress, and then tries to
> >>> configure its hardware for device mode, the ongoing reset leads to
> >>> register access issues; specifically, all register reads returns 0.
> >>> These issues extend beyond the xhci register space (which is expected
> >>> during a reset) and affect the entire DWC3 IP block, causing the DWC3
> >>> device mode to malfunction.
> >>
> >> I agree with you and Thinh that waiting for the HCRST bit to clear dur=
ing
> >> reset is the right thing to do, especially now when we know skipping i=
t
> >> causes issues for SNPS DWC3, even if it's only during remove phase.
> >>
> >> But reverting this patch will re-introduce the issue originally worked
> >> around by Udipto Goswami, causing regression.
> >>
> >> Best thing to do would be to wait for HCRST to clear for all other pla=
tforms
> >> except the one with the issue.
> >>
> >> Udipto Goswami, can you recall the platforms that needed this workarou=
d?
> >> and do we have an easy way to detect those?
> >
> > Hi Mathias,
> >
> >  From what I recall, we saw this issue coming up on our QCOM mobile
> > platforms but it was not consistent. It was only reported in long runs
> > i believe. The most recent instance when I pushed this patch was with
> > platform SM8650, it was a watchdog timeout issue where xhci_reset() ->
> > xhci_handshake() polling read timeout upon xhci remove. Unfortunately
> > I was not able to simulate the scenario for more granular testing and
> > had validated it with long hours stress testing.
> > The callstack was like so:
> >
> > Full call stack on core6:
> > -000|readl([X19] addr =3D 0xFFFFFFC03CC08020)
> > -001|xhci_handshake(inline)
> > -001|xhci_reset([X19] xhci =3D 0xFFFFFF8942052250, [X20] timeout_us =3D=
 10000000)
> > -002|xhci_resume([X20] xhci =3D 0xFFFFFF8942052250, [?] hibernated =3D =
?)
> > -003|xhci_plat_runtime_resume([locdesc] dev =3D ?)
> > -004|pm_generic_runtime_resume([locdesc] dev =3D ?)
> > -005|__rpm_callback([X23] cb =3D 0xFFFFFFE3F09307D8, [X22] dev =3D
> > 0xFFFFFF890F619C10)
> > -006|rpm_callback(inline)
> > -006|rpm_resume([X19] dev =3D 0xFFFFFF890F619C10,
> > [NSD:0xFFFFFFC041453AD4] rpmflags =3D 4)
> > -007|__pm_runtime_resume([X20] dev =3D 0xFFFFFF890F619C10, [X19] rpmfla=
gs =3D 4)
> > -008|pm_runtime_get_sync(inline)
> > -008|xhci_plat_remove([X20] dev =3D 0xFFFFFF890F619C00)
>
> Thank you for clarifying this.
>
> So patch avoids the long timeout by always cutting xhci reinit path short=
 in
> xhci_resume() if resume was caused by pm_runtime_get_sync() call in
> xhci_plat_remove()
>
> void xhci_plat_remove(struct platform_device *dev)
> {
>         xhci->xhc_state |=3D XHCI_STATE_REMOVING;
>         pm_runtime_get_sync(&dev->dev);
>         ...
> }
>
> I think we can revert this patch, and just make sure that we don't reset =
the
> host in the reinit path of xhci_resume() if XHCI_STATE_REMOVING is set.
> Just return immediately instead.
>

Just to be sure, are you proposing that we skip xhci_reset() within
the reinit path
of xhci_resume()? If we do that, could that lead to issues with
subsequent operations
in the reinit sequence, such as xhci_init() or xhci_run()?

Do you prefer to group the change to skip xhci_reset() within the
reinit path together
with this revert? or do you want it to be sent and reviewed separately?

Thanks,
Roy

