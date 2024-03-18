Return-Path: <stable+bounces-28381-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2099D87EFFC
	for <lists+stable@lfdr.de>; Mon, 18 Mar 2024 19:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B1F11F213CC
	for <lists+stable@lfdr.de>; Mon, 18 Mar 2024 18:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7C94CE08;
	Mon, 18 Mar 2024 18:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ecMvraCI"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A3456445
	for <stable@vger.kernel.org>; Mon, 18 Mar 2024 18:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710787981; cv=none; b=rkW0Axxg8xpj8I7ev9xo+RhhKelHj0PjLmLiwXsWDcXkwdgHAU6KDCsVLtaeDmGt1KnF2LtQanZCbC3xNxUe2We+GxPa2kbBwrFmB6YEBjJXXoinw46XMgq4fYX6egQUbsh/gsXRAOVSpszNXCdq/YG3gt3QCtAthLmSKQjDW8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710787981; c=relaxed/simple;
	bh=WA9t2JLaCdhVBKvzAFSO3yj34I9PGx2jtsLcn5J2f68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oprIm3zOzhLlqlOxtl0hVZHWWaqd2Kzub0w+hlo+VXvQ6vtaMNUXAVzARBEL/+O4VC52+hX8dOR/5x3J+RONzirSoTpydNVJZ+8UlEQIIS7a/RYf1vgQzR+X0UVECVqI9akBxnYYDi7XsBok2ADSnMtgY/bNmAvh5dAuv7UO/B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ecMvraCI; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dddd7d64cdso23705ad.1
        for <stable@vger.kernel.org>; Mon, 18 Mar 2024 11:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710787979; x=1711392779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ooCrJpUnHKphfXZ5NhuriLnnuqEoFFTTE4QaO2C2COE=;
        b=ecMvraCIWowvN5IajLtRd/WNlsD4i21GxzfqBmXTyTaO3Bmlz0QZl3qI3dKC0cthMm
         bHoNEWOgj/8P+oW11+08fYuqmlrTMYNzWHruEL2HGxwfrEIw+hzQWHbWDHOyldx7n8cO
         SQdUkOKDzbqQ7XTPvhDWHeQlA4TUwz1taXKDFViBqPoApHEOXeIpKOvdso79OIdAAIuM
         EtGhwjUkM15ynFUytINpv+D5/S5F3ShY8AgT3JkmaW6c6j+Cy8KO3/dKnLh4NoK6Asfq
         9MrNrfEjsOO6igAstZiKyDgnpGMku4Xc4ZRePrT0J+1DZbL5PSqxYcuzy5GyvYbKLkLT
         IKdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710787979; x=1711392779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ooCrJpUnHKphfXZ5NhuriLnnuqEoFFTTE4QaO2C2COE=;
        b=r8yF7H8B6NEGgbZDvIFBqxQnF/I4LFOF52KN2R60HQU4HZKLV2DAZ9D4GWpp+Wpghn
         h5Wy+iuUg+yWNa9o1uUYLwIUwUYhL7eil68z0XfvMsHZtSb3d1qx73PYicSUBpzN0oMZ
         D7DC8yApHri5yls4AChF3yoZvAjlpPn8dpdNbcVEECxooFfMDDFGjPduCIf1pvB2fAV9
         O34qsSTWmNrCQrSHRs/+blcXR3pfUX0GkJ4F4ww930K7K9VTQZtBb5u8JiPaFSJgzV+I
         u5Q7rvNeaQ9WvUK55mI8QtSoGrMB6CzFKN14VthJw8/SRj0v06/GtOaf9X4T9YozT5fh
         ngFg==
X-Forwarded-Encrypted: i=1; AJvYcCUDDVylO8OFutAbspWvkktaxF0FPSTxAekBe+r/hCQ526mtQxpDMm6sow9NE5bnCLPzH0SbM3959bezlqam5yGOCE/LzvHk
X-Gm-Message-State: AOJu0YybgxB8wEN9QlfAXyP2X8h7XqO873YNFeHptFNHYzJTZzAchw+5
	1C1IvjbgO0sKAS8L3+ZihHS1guHfcKWnw4riuO8lftZWkFULerv9T+py5iJLRDitKLISTAUqyL8
	WI/LWjSWfPXmrtTV4ntgViLC1pSuEXUuDBBq4
X-Google-Smtp-Source: AGHT+IFxnWdVHhFA9G5toRi+YSBgRJ4vD3ZYF6ZNV3WhNQhJfWcVdbaPyyKN/dFGLUM66Zp9Nzo3aBAZ8CtEp5ZKoYc=
X-Received: by 2002:a17:902:e848:b0:1de:f8f:7d56 with SMTP id
 t8-20020a170902e84800b001de0f8f7d56mr48333plg.8.1710787978738; Mon, 18 Mar
 2024 11:52:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240317214123.34482-1-hdegoede@redhat.com> <ZfgZEcg2RXSz08Gd@smile.fi.intel.com>
In-Reply-To: <ZfgZEcg2RXSz08Gd@smile.fi.intel.com>
From: Peter Collingbourne <pcc@google.com>
Date: Mon, 18 Mar 2024 11:52:45 -0700
Message-ID: <CAMn1gO4zPpwVDcv5FFiimG0MkGdni_0QRMoJH9SSA3LJAk7JqQ@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250_dw: Revert: Do not reclock if already at
 correct rate
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	linux-serial@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 3:36=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Sun, Mar 17, 2024 at 10:41:23PM +0100, Hans de Goede wrote:
> > Commit e5d6bd25f93d ("serial: 8250_dw: Do not reclock if already at
> > correct rate") breaks the dw UARTs on Intel Bay Trail (BYT) and
> > Cherry Trail (CHT) SoCs.
> >
> > Before this change the RTL8732BS Bluetooth HCI which is found
> > connected over the dw UART on both BYT and CHT boards works properly:
> >
> > Bluetooth: hci0: RTL: examining hci_ver=3D06 hci_rev=3D000b lmp_ver=3D0=
6 lmp_subver=3D8723
> > Bluetooth: hci0: RTL: rom_version status=3D0 version=3D1
> > Bluetooth: hci0: RTL: loading rtl_bt/rtl8723bs_fw.bin
> > Bluetooth: hci0: RTL: loading rtl_bt/rtl8723bs_config-OBDA8723.bin
> > Bluetooth: hci0: RTL: cfg_sz 64, total sz 24508
> > Bluetooth: hci0: RTL: fw version 0x365d462e
> >
> > where as after this change probing it fails:
> >
> > Bluetooth: hci0: RTL: examining hci_ver=3D06 hci_rev=3D000b lmp_ver=3D0=
6 lmp_subver=3D8723
> > Bluetooth: hci0: RTL: rom_version status=3D0 version=3D1
> > Bluetooth: hci0: RTL: loading rtl_bt/rtl8723bs_fw.bin
> > Bluetooth: hci0: RTL: loading rtl_bt/rtl8723bs_config-OBDA8723.bin
> > Bluetooth: hci0: RTL: cfg_sz 64, total sz 24508
> > Bluetooth: hci0: command 0xfc20 tx timeout
> > Bluetooth: hci0: RTL: download fw command failed (-110)
> >
> > Revert the changes to fix this regression.
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> > Note it is not entirely clear to me why this commit is causing
> > this issue. Maybe probe() needs to explicitly set the clk rate
> > which it just got (that feels like a clk driver issue) or maybe
> > the issue is that unless setup before hand by firmware /
> > the bootloader serial8250_update_uartclk() needs to be called
> > at least once to setup things ?  Note that probe() does not call
> > serial8250_update_uartclk(), this is only called from the
> > dw8250_clk_notifier_cb()
> >
> > This requires more debugging which is why I'm proposing
> > a straight revert to fix the regression ASAP and then this
> > can be investigated further.
>
> Yep. When I reviewed the original submission I was got puzzled with
> the CLK APIs. Now I might remember that ->set_rate() can't be called
> on prepared/enabled clocks and it's possible the same limitation
> is applied to ->round_rate().
>
> I also tried to find documentation about the requirements for those
> APIs, but failed (maybe was not pursuing enough, dunno). If you happen
> to know the one, can you point on it?

To me it seems to be unlikely to be related to round_rate(). It seems
more likely that my patch causes us to never actually set the clock
rate (e.g. because uartclk was initialized to the intended clock rate
instead of the current actual clock rate). It should be possible to
confirm by checking the behavior with my patch with `&& p->uartclk !=3D
rate` removed, which I would expect to unbreak Hans's scenario. If my
hypothesis is correct, the fix might involve querying the clock with
clk_get_rate() in the if instead of reading from uartclk.

Peter

