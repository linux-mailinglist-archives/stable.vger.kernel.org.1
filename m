Return-Path: <stable+bounces-154689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F4042ADF363
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 19:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2CEC3A5153
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 17:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5612EF9B0;
	Wed, 18 Jun 2025 17:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q3YHtCZb"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B1427F007
	for <stable@vger.kernel.org>; Wed, 18 Jun 2025 17:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750266297; cv=none; b=CuwxMd7/8+gCMhuGjQkTjNUHE2eXiDSWZSCGNNfdQDALib0AFNztSQiLTsKut/PTJeLOvBavm6xB1pAXQAXr9XBHjQrjhepz9MU4+Uit45YGgISoFZwlT6tOXrdVqtAf4izNWLUJoDxqXxvM53eWt4U3OQV2P69A0K1SZNh6z7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750266297; c=relaxed/simple;
	bh=GTy2PvCYPFvLUsCSngTuNqGVyYNKX0N0F1THUwKHJIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qAGUemgnobwYuQ65keSICyK2tcym84I9HKrRsziGQpeAu8euZZScWSAjnK2dvH86yLne06O0MtasJbMH/MZdg/U0BNOYet6d14FCe7Rbr7bvhF9ZYGkfcezY6O8BQN46oV/gSbG8/Z96UVEQYmpNHgr1ECioPlYbrnFnSYODsmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q3YHtCZb; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7d3f192a64eso7810185a.2
        for <stable@vger.kernel.org>; Wed, 18 Jun 2025 10:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750266294; x=1750871094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nIj7/912U1hLS69DmdTyCJ8d+fvfWdHshome4WGvT9U=;
        b=Q3YHtCZb8x0K6q5VSlokIgW7WTidGSFFNXZkRSQF1Sp66I5hlo2nrAR7/SI8fVYdqR
         V/epRnYQ3kRuN3pz+8wLHrk8V7l08L+yQ786Y9wwNvdUaJX7hEG984UGqtT4R3aNhOLP
         QeKIcDO5lDTkL36MbTYKv7w3ySll7z6bbLs1zZMlC49lI6sKdveKdxp35AOd4JHjbMKn
         oQQQvbjRS3BdQUuFPS/eXLrDDeZIRwRm5v1JXveJwyIUxwWVhY8DFwDbncqUtzyGm/E4
         c2zDY0S1uG0qgt7APJWZBj0RrIezG/aA9o+p89ixvpfQA0QbgSbtMuifRtsBQHxiXMhF
         eplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750266294; x=1750871094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nIj7/912U1hLS69DmdTyCJ8d+fvfWdHshome4WGvT9U=;
        b=TeHXyb9c1rB5Rk2O/+rPnp1hMrNmMVK2wODXzRK+gh0Xa0gxbrtqWcy3qyxB6tJQTH
         skviLSFgwuQILH09H3vonKPuSgUdXXsXe89Yj0aKom3GrR29ENJQKy342Cu+3nIZn4OU
         6+AbUARmAqfS1D5awMB3JOrBf1fdoqoyXT6Q6olfIWPxAFPLk3IjLlG+v+f6B8Dnm9zi
         mLu4GgSOy3H4Z+25hOxDkp7ug5Z2xg3M4kpGfUIFpgnQSSCnAirCcFTjMwenqOZUOSiZ
         636XZkuuVPNaO+JWoJUAMMUFBRbrGG9vBTe43IKiIgkJfHnDsw+9QJMymZShlV05f4/O
         oQWg==
X-Forwarded-Encrypted: i=1; AJvYcCUXu0jtuL3SoCwUtV75lwjLNJnJrRt/w2hD/oBvJb2e4i3pNwxfe52IAPOBePftif06Q5Gl4H8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmhe60JPoBVn5+ILbjy/bMF5zCBefqPzH/GDRLFTQseG1BnYZA
	tnmNYJhBKRgrwdAEopg9/MhzD02tWzKvX/a8v2xpf+gzvcqRfL8F4PiREmRLWXQ7vksmwSR+gLk
	fmudTtZRKuWlifGOP0Go0dgsjsvO9X8ZkJoP+0RlH
X-Gm-Gg: ASbGnct+FTo7SgLoFDYxCQjtfHOn/DB/2KrcQpbo/Iw7wpbGcwg3vHvSIXQMiQ6kEPm
	5bf687c6Qxrnqg+uS0xPWb17fhSiS6rOowdQDG9KALwpV9PG8oSx15NT8V8y50BBrB3zLurv1AS
	e88rzejgNJNv08WQWf782oJEhi3q1AlQfaAxmcDR/VGb2yxWDin2Qw1BbuY6w7EREul6mcXf3ep
	o1CIb1pW+3i+44=
X-Google-Smtp-Source: AGHT+IH6EVcpTkTw8JUim83xuUFB8wy9O7eSl84h9hvZtn+Su5XHCUSFtap/mY1OURayGAsXwHK+Jtpft8ah/aDmp1Y=
X-Received: by 2002:a05:620a:2628:b0:7d3:8f51:a5a5 with SMTP id
 af79cd13be357-7d3c6cfe4efmr3043653185a.51.1750266293724; Wed, 18 Jun 2025
 10:04:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250522190912.457583-1-royluo@google.com> <20250522190912.457583-2-royluo@google.com>
 <20250523230633.u46zpptaoob5jcdk@synopsys.com> <b982ff0e-1ae8-429d-aa11-c3e81a9c14e5@linux.intel.com>
 <20250529011745.xkssevnj2u44dxqm@synopsys.com> <459184db-6fc6-453b-933d-299f827bdc55@linux.intel.com>
 <20250605001838.yw633sgpn2fr65kc@synopsys.com>
In-Reply-To: <20250605001838.yw633sgpn2fr65kc@synopsys.com>
From: Roy Luo <royluo@google.com>
Date: Wed, 18 Jun 2025 10:04:17 -0700
X-Gm-Features: Ac12FXwY_QrogUvvcPl-lKVgH0ASDSjF3Wdv-xGgP0Lciad5aKdoQcEiS3RwWkI
Message-ID: <CA+zupgwLkq_KSN9aawNtYpHzPQpAtQ0A9EJ9iaQQ7vHUPmJohA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] usb: xhci: Skip xhci_reset in xhci_resume if xhci
 is being removed
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>, 
	"mathias.nyman@intel.com" <mathias.nyman@intel.com>, 
	"quic_ugoswami@quicinc.com" <quic_ugoswami@quicinc.com>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	"michal.pecio@gmail.com" <michal.pecio@gmail.com>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025 at 5:18=E2=80=AFPM Thinh Nguyen <Thinh.Nguyen@synopsys.=
com> wrote:
>
> On Wed, Jun 04, 2025, Mathias Nyman wrote:
> > On 29.5.2025 4.17, Thinh Nguyen wrote:
> > > On Mon, May 26, 2025, Mathias Nyman wrote:
> > > > On 24.5.2025 2.06, Thinh Nguyen wrote:
> > > > > Hi Mathias, Roy,
> > > > >
> > > > > On Thu, May 22, 2025, Roy Luo wrote:
> > > > > > xhci_reset() currently returns -ENODEV if XHCI_STATE_REMOVING i=
s
> > > > > > set, without completing the xhci handshake, unless the reset co=
mpletes
> > > > > > exceptionally quickly. This behavior causes a regression on Syn=
opsys
> > > > > > DWC3 USB controllers with dual-role capabilities.
> > > > > >
> > > > > > Specifically, when a DWC3 controller exits host mode and remove=
s xhci
> > > > > > while a reset is still in progress, and then attempts to config=
ure its
> > > > > > hardware for device mode, the ongoing, incomplete reset leads t=
o
> > > > > > critical register access issues. All register reads return zero=
, not
> > > > > > just within the xHCI register space (which might be expected du=
ring a
> > > > > > reset), but across the entire DWC3 IP block.
> > > > > >
> > > > > > This patch addresses the issue by preventing xhci_reset() from =
being
> > > > > > called in xhci_resume() and bailing out early in the reinit flo=
w when
> > > > > > XHCI_STATE_REMOVING is set.
> > > > > >
> > > > > > Cc: stable@vger.kernel.org
> > > > > > Fixes: 6ccb83d6c497 ("usb: xhci: Implement xhci_handshake_check=
_state() helper")
> > > > > > Suggested-by: Mathias Nyman <mathias.nyman@intel.com>
> > > > > > Signed-off-by: Roy Luo <royluo@google.com>
> > > > > > ---
> > > > > >    drivers/usb/host/xhci.c | 5 ++++-
> > > > > >    1 file changed, 4 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> > > > > > index 90eb491267b5..244b12eafd95 100644
> > > > > > --- a/drivers/usb/host/xhci.c
> > > > > > +++ b/drivers/usb/host/xhci.c
> > > > > > @@ -1084,7 +1084,10 @@ int xhci_resume(struct xhci_hcd *xhci, b=
ool power_lost, bool is_auto_resume)
> > > > > >               xhci_dbg(xhci, "Stop HCD\n");
> > > > > >               xhci_halt(xhci);
> > > > > >               xhci_zero_64b_regs(xhci);
> > > > > > -             retval =3D xhci_reset(xhci, XHCI_RESET_LONG_USEC)=
;
> > > > > > +             if (xhci->xhc_state & XHCI_STATE_REMOVING)
> > > > > > +                     retval =3D -ENODEV;
> > > > > > +             else
> > > > > > +                     retval =3D xhci_reset(xhci, XHCI_RESET_LO=
NG_USEC);
> > > > >
> > > > > How can this prevent the xhc_state from changing while in reset? =
There's
> > > > > no locking in xhci-plat.
> > > >
> > > > Patch 2/2, which is the revert of 6ccb83d6c497 prevents xhci_reset(=
) from
> > > > aborting due to xhc_state flags change.
> > > >
> > > > This patch makes sure xHC is not reset twice if xhci is resuming du=
e to
> > > > remove being called. (XHCI_STATE_REMOVING is set).
> > >
> > > Wouldn't it still be possible for xhci to be removed in the middle of
> > > reset on resume? The watchdog may still timeout afterward if there's =
an
> > > issue with reset right?
> > >
> >
> > Probably yes, but that problem is the same if we only revert 6ccb83d6c4=
97.
> >
> > > > Why intentionally bring back the Qcom watchdog issue by only revert=
ing
> > > > 6ccb83d6c497 ?. Can't we solve both in one go?
> > >
> > > I feel that the fix is doesn't cover all the scenarios, that's why I
> > > suggest the revert for now and wait until the fix is properly tested
> > > before applying it to stable?
> >
> > Ok, we have different views on this.
> >
> > I think we should avoid causing as much known regression as possible ev=
en
> > if the patch  might not cover all scenarios.
> >
> > By reverting 6ccb83d6c497 we fix a SNPS DWC3 regression, but at the sam=
e
> > time bring back the Qcom issue, so cause another regression.
> >
> > We can avoid the main part or the Qcom regression by adding this patch =
as
> > issue is with (long) xhci reset during resume if xhci is being removed,=
 and
> > driver always resumes xhci during ->remove callback.
> >
> > If we discover the patch is not perfect then we fix it
> >
>
> Ok. Fair enough.
>
> BR,
> Thinh

Thanks Thinh and Mathias for the review.
Please let me know if any further changes are needed before these
patches can be accepted.
I just want to make sure they're still on your radar.

Thanks,
Roy

