Return-Path: <stable+bounces-206295-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3F8D03C44
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 16:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D74A23022F19
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 15:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A81E423A60;
	Thu,  8 Jan 2026 09:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YfXJB9Ij"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF182423170
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 09:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767865984; cv=none; b=EpiUSW4PLLWT0EqsIWoVDa9g229AVqF/9fp6izefByiMg6/K/08+epPEezLhBIAgnXlQ/L863UZBFiZF7Br+cFhwSUAspuMnf21M9ISbXBkYPzxfECTPWOEpiDYiRn11ubZ0rxN1awyMOOYPbj+1N4cRfxIrSRUFMaJinOLpfbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767865984; c=relaxed/simple;
	bh=yrjyOeCsecL31s3+m59UwjLzuKBDtpFMBiqjCuPG32U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fhKSSvZj3X3kEx5BtlWKRHtWwLTRe4QdA1UfgTYUN1ELkmTMZke1irlPfMacTGRjimWEZaCUS1JTgPJIUWRLPXId/msbhIeQGTijhJJaulq/+L0Sb9B8+VIQVFSe8PJ3P6QwSyfZqnXr+Smxv6jntniAL6Mgq3y9oqCTR6XUlLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YfXJB9Ij; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59b76844f89so629644e87.1
        for <stable@vger.kernel.org>; Thu, 08 Jan 2026 01:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1767865971; x=1768470771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jqr/mVbRFYDK+OJdlTohpeoCtdLpu+LB+rwbhbH6YU4=;
        b=YfXJB9Ij+Bc3Luqo2etS4DLVlV31fCQAyVqgOzUJnxTQer9N9iVMyXldPgUmVK6Tw+
         K3Gz18BB96m12wLKwzgEkoxUeCp07MrcN4eNh5AOHk3oNiCaJKteIBFTfW6gQpTpcH1b
         dsqi9O7iTYD5thRCPKZCp91GerFnywoPB9eHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767865971; x=1768470771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jqr/mVbRFYDK+OJdlTohpeoCtdLpu+LB+rwbhbH6YU4=;
        b=MbPkBTYe7RQYXWyqIVJqklwRvQILIqi5OaijiJ99TZE3aON5HnuJjKzmfAwEisfMuD
         isyqxdJa7ZwpZoTjPcGfb4C8d0i4VTyagedY2p5kIV6O7t2xl+P5SNKklSQRbcPqAL1a
         5S+yk+fqOurXJI7ZWSwiMmZhG89AB3yJ4hDlTqomiuy0/RixZagBPeRrZOa7+ydIIEDg
         THA4dNUSXmeW65oCBowRUC0e0k1VrqdKWvpVa+MB0IlZrMhtb00sRl+5YwxAs+kCiaYS
         JZZhTLzA3yoMemG0BqL/lKUk7vAEXohbtwPN8E2T62olLKwQt7+2D7Kw0oICNzy5PQ4X
         rzJg==
X-Gm-Message-State: AOJu0Yz08tVolLKuLsuDFVKggLAp/5ySJGQdyJZHb8I3IP8rXn9wf9Hk
	1E5yJqQoG8WsxSqnK29jF+6Y+mRCxS+YG8c9Ndmukpy+dERQAM3m5GL18QYm5vJXBCIu4ezU4h0
	/TCP+7macUfHW0JH+/S6hxSyHaKUPEablrPsKqq0mDYbinT/iEJrd
X-Gm-Gg: AY/fxX6JojafDRSTKaHI3GM+XMpFf6aHGd3mP3zB/R3xGGgmF+3F6KIamaMJGKvJpeK
	J7DNyVUNDWHMY9BBqPlOrrWSZaY6bB9oSxM3Ra8WcQgbA4R2Sf+kY49ZysEAf5la/f5gzTnIpO5
	e9Nrbl2Vm9/dF+djGdOHR27cboV9l4hFb7XSKeYGT9fyIMpEAPTdecOD0+rOIc5zdqCXC4JDo4g
	qqXA6KuXo/A8CE9BwwTBrfb8gbLDYJ41BAJ8DHJsF9K8iemwPIaO+9PBFIxAefj4pEDGbox
X-Google-Smtp-Source: AGHT+IHxlLYh9vxL/06MQnPjs+l9grNCZCp/EBjhvAPJ7NdV1WQMfA0EsueYil1yFcWn+tHMSBKkpFBniIuIYDA3Tbg=
X-Received: by 2002:a05:6512:3093:b0:599:11a5:54fd with SMTP id
 2adb3069b0e04-59b6ef028e5mr2042514e87.4.1767865970595; Thu, 08 Jan 2026
 01:52:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025122918-sagging-divisible-a4a4@gregkh> <20260107003854.3458891-1-ukaszb@chromium.org>
 <2026010811-cape-directly-401e@gregkh>
In-Reply-To: <2026010811-cape-directly-401e@gregkh>
From: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <ukaszb@chromium.org>
Date: Thu, 8 Jan 2026 10:52:39 +0100
X-Gm-Features: AQt7F2qXMUqoTsKdFs8c8G_xiwcotrAh9j14fVogd4Ea-7RvwcQ0Sq6nRoCUZ6I
Message-ID: <CALwA+NZA1s5fyE-tsgfigw3oc+ot1Ememp8tfFEAn531C9TvsA@mail.gmail.com>
Subject: Re: [PATCH 6.1.y] xhci: dbgtty: fix device unregister: fixup
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, stable <stable@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 10:24=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jan 07, 2026 at 12:38:54AM +0000, =C5=81ukasz Bartosik wrote:
> > This fixup replaces tty_vhangup() call with call to
> > tty_port_tty_vhangup(). Both calls hangup tty device
> > synchronously however tty_port_tty_vhangup() increases
> > reference count during the hangup operation using
> > scoped_guard(tty_port_tty).
> >
> > Cc: stable <stable@kernel.org>
> > Fixes: 1f73b8b56cf3 ("xhci: dbgtty: fix device unregister")
> > Signed-off-by: =C5=81ukasz Bartosik <ukaszb@chromium.org>
> > Link: https://patch.msgid.link/20251127111644.3161386-1-ukaszb@google.c=
om
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/usb/host/xhci-dbgtty.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
>
> No git id?

If the new API  tty_port_tty_vhangup will be included in 6.1 stable
then my patch is not needed.

Sorry for the confusion.

Thanks,
=C5=81ukasz

