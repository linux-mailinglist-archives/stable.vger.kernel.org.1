Return-Path: <stable+bounces-111863-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD1AA2475C
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 07:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEC62162F13
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 06:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1D913665A;
	Sat,  1 Feb 2025 06:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPr7aPuW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613F2BA34;
	Sat,  1 Feb 2025 06:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738392175; cv=none; b=UTMK8nIXL+vl2p8hsTsit1WCZ3fx/R5eicSYuY+KVpkmEj+Fv2NObw1WCxNmPw4AHOy2qDN8OzFkoxGmmCV2MoToEY9Ze8lyVFlWVvvzeYn1vwWzDQOXq6W9U+FtI6dxTNrcQQtHuAWsDc57C4xbYY/pQ2lfyPU/98lHNF898cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738392175; c=relaxed/simple;
	bh=qRUMr2C7bnplx32uzkCBYZF/yG8fgbs2QV7S9U9Iv0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YRvP6QeL7+gPJfviHflnoJ1fI5n1O+zxEGEKmS3/rfgPWo6U74dgCqKiVspFsH+mvni+YLe0z3rpOeJzxQakXMdLNDeZ2XmmsaWXz7OqS72z2tLk7SVGwgw4nCUBq/2AGsKrx0rLwvqcicMc1PokBwpGXNjjjXN8FKAITvntsxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPr7aPuW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC408C4CED3;
	Sat,  1 Feb 2025 06:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738392174;
	bh=qRUMr2C7bnplx32uzkCBYZF/yG8fgbs2QV7S9U9Iv0Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aPr7aPuW2CGdQcjeYYLgM8n8G/X4KePpgFBUQ7oPrk4H0q8B2fVYPyKYtIk5GFv0e
	 /N7n6XUhoQaLJIA8K4AEjPWJGxiH7Ve618CZShwJSfVnWBYZ0biS3pbPp8PORcp1nh
	 6E916cxHJgPQP5rDnEMiSc3UqX+CweNFneHBr2kRdFfVTYx0qiggzUxX5dmNqdgUja
	 BdFi/AJeo7PELLmM+L1RbFFT6y4Ib5e5X6/HbFCAYgvlXmv4Frp6M0eLyf2bbrUKWB
	 MJXO5SM5rU0xkyxEYWo8FmZE7acgx4ZsJ0zcSh3BaVPUy+L+IWJZ6xhr69rxcL1F9z
	 Hc2H43DaT3MTQ==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaedd529ba1so376884966b.1;
        Fri, 31 Jan 2025 22:42:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUFaXTsttQJNZE0lAXNWfJBTKmtE8EyLT3UQ1y5ZPEU8WOZAnp1WUCfiaTWgDYqPGiIFteqG1lz@vger.kernel.org, AJvYcCWOOcwZE3ddS1rwk8hGxA1/W7BSL+WoESDj8xuSwWCuH16ULmZ8T03lDnULgkVAxboCSuatRl+Itt37@vger.kernel.org, AJvYcCXPtd5keKyUHFw8iYIAW5SjFbhJg7TMpQ+e6x6ie6Xw75fpsXnSyuL4RiiOdi6TTODl+wSdP1YInOCdjiY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Ixualcje301D111COnIDArgsOP96+hmcxVC85A+mCJssGwmY
	qyN7kT85GPLkOXjWxoH/ZiDfmkEweD7VekoVNUeDTYRV9NLo1gyqW+fFiIMpmc7BRpbNTaILqrB
	VT3I3JZ8zVjb91Kyt8yJDj4akXRc=
X-Google-Smtp-Source: AGHT+IEohOzlys0DzwwmnCZmEsG9YPtDkm81knQ3Z2TKfZuhYJD396lvVVwSun6lJ1jeQHu3D+vTpn3CLkltWDbI5e8=
X-Received: by 2002:a05:6402:274e:b0:5d0:9054:b119 with SMTP id
 4fb4d7f45d1cf-5dc5efec007mr32073734a12.21.1738392173268; Fri, 31 Jan 2025
 22:42:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131100630.342995-1-chenhuacai@loongson.cn> <2f583e59-5322-4cac-aaaf-02163084c32c@rowland.harvard.edu>
In-Reply-To: <2f583e59-5322-4cac-aaaf-02163084c32c@rowland.harvard.edu>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 1 Feb 2025 14:42:43 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7Dt1bEo8qcwfVfcjTOgXSKW71D19k3+418J6CtV3pVsQ@mail.gmail.com>
X-Gm-Features: AWEUYZlQHUxevtPPgs_rGlrvqUJoM3AN5A7v2-XstBa6hlYh61mfMirSPbYQf0U
Message-ID: <CAAhV-H7Dt1bEo8qcwfVfcjTOgXSKW71D19k3+418J6CtV3pVsQ@mail.gmail.com>
Subject: Re: [PATCH] USB: core: Enable root_hub's remote wakeup for wakeup sources
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Alan,

On Fri, Jan 31, 2025 at 11:17=E2=80=AFPM Alan Stern <stern@rowland.harvard.=
edu> wrote:
>
> On Fri, Jan 31, 2025 at 06:06:30PM +0800, Huacai Chen wrote:
> > Now we only enable the remote wakeup function for the USB wakeup source
> > itself at usb_port_suspend(). But on pre-XHCI controllers this is not
> > enough to enable the S3 wakeup function for USB keyboards,
>
> Why do you say this?  It was enough on my system with an EHCI/UHCI
> controller when I wrote that code.  What hardware do you have that isn't
> working?
>
> >  so we also
> > enable the root_hub's remote wakeup (and disable it on error). Frankly
> > this is unnecessary for XHCI, but enable it unconditionally make code
> > simple and seems harmless.
>
> This does not make sense.  For hubs (including root hubs), enabling
> remote wakeup means that the hub will generate a wakeup request when
> there is a connect, disconnect, or over-current change.  That's not what
> you want to do, is it?  And it has nothing to do with how the hub
> handles wakeup requests received from downstream devices.
>
> You need to explain what's going on here in much more detail.  What
> exactly is going wrong, and why?  What is the hardware actually doing,
> as compared to what we expect it to do?
OK, let me tell a long story:

At first, someone reported that on Loongson platform we cannot wake up
S3 with a USB keyboard, but no problem on x86. At that time we thought
this was a platform-specific problem.

After that we have done many experiments, then we found that if the
keyboard is connected to a XHCI controller, it can wake up, but cannot
wake up if it is connected to a non-XHCI controller, no matter on x86
or on Loongson. We are not familiar with USB protocol, this is just
observed from experiments.

You are probably right that enabling remote wakeup on a hub means it
can generate wakeup requests rather than forward downstream devices'
requests. But from experiments we found that if we enable the "wakeup"
knob of the root_hub via sysfs, then a keyboard becomes able to wake
up S3 (for non-XHCI controllers). So we guess that the enablement also
enables forwarding. So maybe this is an implementation-specific
problem (but most implementations have problems)?

This patch itself just emulates the enablement of root_hub's remote
wakeup automatically (then we needn't operate on sysfs).

Huacai

>
> Alan Stern

