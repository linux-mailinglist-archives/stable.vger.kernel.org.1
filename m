Return-Path: <stable+bounces-165677-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF31B174C2
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 18:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2190CA836EE
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 16:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577F520D51A;
	Thu, 31 Jul 2025 16:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="TO2TwJhu"
X-Original-To: stable@vger.kernel.org
Received: from mail-10697.protonmail.ch (mail-10697.protonmail.ch [79.135.106.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB76220F54
	for <stable@vger.kernel.org>; Thu, 31 Jul 2025 16:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753978388; cv=none; b=n/qQ0XaGcXqrn+wrpzS/1XOmEEFau7FvJaGnE3u7Uoly0Ua8FgWOGdYP98p9GkaI+JXiMtJUc9FYMN7PhcUg+LH7UwxHoIWkWU+diNT8Yviz7eh6qiiw3p4E84e9qj6QL9rSsYQ9V7oP2kufDVqfE7sYT5zKz4C5QIdfQosVdIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753978388; c=relaxed/simple;
	bh=aI1FVzVfrDeaTWiVhLom4GmGgm/c+7E5j1bMQKatl6I=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CSZGyL5seOLCSK9twBRIXqBT/5OoAtC1YJQ2A21+TLoSsNGmUMMPmenrafs0NYw3fgn8koveWFNLwQwGM1VgF86KK6Vf4Ax8V1/dFnUmP3BggIb7YI020aualIOQ82MnbFsH/kq+gNf1V45oBkGKHufoYP6DYi+qfHOVW9pMD/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=TO2TwJhu; arc=none smtp.client-ip=79.135.106.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1753978378; x=1754237578;
	bh=ReuuQ2WpSSBdPU9V3Nd3gVcOly6NwjGCUI1vmWY1pPU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=TO2TwJhu29yI/BivJboZ0hx4f3XWM3A5FIhGKSHp7vHPDYn6xkEyw8psOXFdl0a9H
	 UfXJfNMDoWdJfteBeHEXuwcIadbQmHA17U0IFQ75/TBe7+ioxJNGGgLVJXhar0S+zc
	 yi2w7Ic0S9tDiF9cDwmzKpWCzv4NGRIEPBVH1HoClVUUqjXKdBSdiMGaHTotgN2VR+
	 3imjLB5STLw9+V46WamkEYOCB5enUTMcPvuCzWq9tF130uMrP+uzMYb7cauWXAaRWX
	 X/kvyAe+k7KQVqugFrMTbhw2yhJ627C8S7mcVh3ZX5DnYllkEeSNZZmbbGsliMw27m
	 CsC+VTpCA9Lvg==
Date: Thu, 31 Jul 2025 16:12:52 +0000
To: Jiri Slaby <jirislaby@kernel.org>
From: Jari Ruusu <jariruusu@protonmail.com>
Cc: Yi Yang <yiyang13@huawei.com>, GONG Ruiqi <gongruiqi1@huawei.com>, Helge Deller <deller@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Text mode VGA-console scrolling is broken in upstream & stable trees
Message-ID: <7_oOa5sZXTsEK5rGL7HpT4HfjvhfpGa8r69NDAZWuKTxWP1ONLD9yDbrfJ3nzfducuK8TpC-fF1llnfVjpGHzdmhdzDq7FvvoOYU9eEX9Uc=@protonmail.com>
In-Reply-To: <a1d0172f-5f3c-4f3e-9362-d9de0192e8b2@kernel.org>
References: <C4_ogGo3eSdgo3wcbkdIXQDoGk2CShDfiQEjnwmgLUvd1cVp5kKguDC4M7KlWO4Tg9Ny3joveq7vH9K_zpBGvIA8-UkU2ogSE1T9Y6782js=@protonmail.com> <a1d0172f-5f3c-4f3e-9362-d9de0192e8b2@kernel.org>
Feedback-ID: 22639318:user:proton
X-Pm-Message-ID: f232cd1324770b9f5fd19ca58bf498644d43c660
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thursday, July 31st, 2025 at 10:22, Jiri Slaby <jirislaby@kernel.org> wr=
ote:
> At the time this was posted (privately and on security@), I commented:
> =3D=3D=3D=3D=3D
>  > --- a/drivers/video/console/vgacon.c
>  > +++ b/drivers/video/console/vgacon.c
>  > @@ -1168,7 +1168,7 @@ static bool vgacon_scroll(struct vc_data *c, uns=
igned int t, unsigned int b,
>  >                                    c->vc_screenbuf_size - delta);
>  >                       c->vc_origin =3D vga_vram_end - c->vc_screenbuf_=
size;
>  >                       vga_rolled_over =3D 0;
>  > -             } else
>  > +             } else if (oldo - delta >=3D (unsigned long)c->vc_screen=
buf)
>  >                       c->vc_origin -=3D delta;
>=20
> IMO you should also add:
>     else
>       c->vc_origin =3D c->vc_screenbuf;
>=20
> Or clamp 'delta' beforehand and don't add the 'if'.
> =3D=3D=3D=3D=3D
> That did not happen, AFAICS. Care to test the above suggestion?

My reading of the code in vgacon_scroll() is that it directly
bit-bangs video-RAM and checks that scroll read/write accesses
stay in range vga_vram_base...vga_vram_end-1.

Checking that c->vc_origin end up being >=3D c->vc_screenbuf is
wrong because in text mode it should be index to video-RAM.

Quote from original "messed up" patch, fix for CVE-2025-38213:
> By analyzing the vmcore, we found that vc->vc_origin was somehow placed
> one line prior to vc->vc_screenbuf when vc was in KD_TEXT mode, and
> further writings to /dev/vcs caused out-of-bounds reads (and writes
> right after) in vcs_write_buf_noattr().
>=20
> Our further experiments show that in most cases, vc->vc_origin equals to
> vga_vram_base when the console is in KD_TEXT mode, and it's around
> vc->vc_screenbuf for the KD_GRAPHICS mode. But via triggerring a
> TIOCL_SETVESABLANK ioctl beforehand, we can make vc->vc_origin be around
> vc->vc_screenbuf while the console is in KD_TEXT mode, and then by
> writing the special 'ESC M' control sequence to the tty certain times
> (depends on the value of `vc->state.y - vc->vc_top`), we can eventually
> move vc->vc_origin prior to vc->vc_screenbuf. Here's the PoC, tested on
> QEMU:

To me that sounds like the bug is in TIOCL_SETVESABLANK ioctl().
It should not be changing c->vc_origin to point elsewhere
other than video-RAM when the console is in text mode.

How about adding a check to begining of vgacon_scroll() that
bails out early if c->vc_origin is not a valid index to video-RAM?

--
Jari Ruusu=C2=A0 4096R/8132F189 12D6 4C3A DCDA 0AA4 27BD=C2=A0 ACDF F073 3C=
80 8132 F189


