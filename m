Return-Path: <stable+bounces-166454-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C00B19E10
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 10:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A3B6189A4D8
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 08:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BF9242D87;
	Mon,  4 Aug 2025 08:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QR/uM5MB"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B670C38FA6;
	Mon,  4 Aug 2025 08:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754297918; cv=none; b=VU9+the4t8OzkFJJ8WG4wzi+xw4hxPe6b0T8QU9loJM8zIPf0/ftPdLx+f0HPb8nmJrxaAD5YrdFOK9Xt9swnRw4xfX9WHWKIT1drVmeMhpqkLOJoRyoejDFQEU8IMYTyXiC+rosp564Eqtgjgn4rvMaxr+W0sKjRXSDhLCuZR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754297918; c=relaxed/simple;
	bh=kzFx0vBz/N42Yg4NK9sdE4rRm6vGDgq0CC2dgvkAGsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TvXea6W+8TBjgYT4Mr/mBAXpxSybciTde+kRqiounb7ABNp2OtU2JtnXik0VcGKqyLExlnMux4RWyIhIHg/A2V0zDtWl6shmzfKC1j70PutL2FinkDCBRoWDDdf6iPJOHp5HH5Y8Dg/nVQVHy45ihLQKHW2FX87b0oR5ROmgG+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QR/uM5MB; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-af66d49daffso523684266b.1;
        Mon, 04 Aug 2025 01:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754297914; x=1754902714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYiql1qYBQ2uZxFXQMxYIN/3K5JLN42y5i9uEVm4H/E=;
        b=QR/uM5MBfmsADtfQHz5moEcYfn0mVx2vwB8V+R1fX9UcYPPe/AFT6egBQbE7w2ci3c
         2nleLU4cLQ3AIEccQK3pbgbX1G+3frzCH2cyeYD6e/E4O7MNmwPybE3OiQPZf2c0WiTX
         FZ+Eghq+Xp20zKYL7aqs+/cNKL4bcOHfJbLgTULtUB6pM8OuEMHya3vVfLCqYEka6VXO
         c99Icw3WOIStadJKGdUrZL5sLgzC2F/p5grj/vmScGYVynGR7wwn1lE53bMN4TmDvMv6
         w8RbjkiRXVfTK7lYTGiI/nNdyhNB4PiCw6q3YqfV77Fi+PJlg9TpuGzJNDQbj+cYNl8p
         frlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754297914; x=1754902714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gYiql1qYBQ2uZxFXQMxYIN/3K5JLN42y5i9uEVm4H/E=;
        b=wQCSJE+ZHhVt31gK3CbcVadHdw1C0eh9ijiKNum0KfokSROSXoO+VKKZKrxoDqEz3x
         VDc0uQOc2lx8Ftwa4rO8SThErQ46aYYD2Ge5l9bXdonO7qj7qoDzJRa5qtJQtuIf0qco
         HzL8Na8RFdy7BpkWU/Zv1ziSpJyBRymykdFqzVP/mrPL05DEjlexoYXMsxzUHe6xFDaS
         F9ygEtd8qFoBAsV9xHYyoV2W+zVQdZbTeuDVY5PJNQkM+20vhGplNtwQWAki59fQyHz8
         +XIgfsM+MqRBHiHi01qk1sc33SsNDCRadPaKTDUht4oJVnr62nWr4gBapC/dUFKZ/Q31
         7oXg==
X-Forwarded-Encrypted: i=1; AJvYcCVpV/MvNjX78LcgCYWfa+oa1kcBcXnvEv4ydoD5q3q0JH5F3x7wubmQkbKCves7KLky6fng7jdkg80z/fQ=@vger.kernel.org, AJvYcCWP1/L/HLhH6DuUhvIuH2eDIs46dATkgvPXXwidmry6FV5vl+t1wLA1mM9A9eZNCYVqmHo7RsYJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzLD3u6dfN2aumN8rgfTxRqRNxJ2FGJ6RA6aPbmQOvW7t+44wif
	1kScYYtICSJGyO/tcW03cYfV4TgorDyk2YULV55YZu0LBcEIJPpYH3soYMJPQdYqTO+dv30isab
	4733SlVh9HAdIOBDBiU0IS4NfUfXXwhsZB1FcN0U=
X-Gm-Gg: ASbGncv2aDQ6VaOBKyuQJen/X/AZRgQqRR/B5AAHx1GTn07nokHTXsMexIHPsTrDKZP
	SurhPPPrrxrtPFX2Hec661/kaer27niIbPrxLGVW9sAWddCvXCTIqdHJXbudvXXIyKMCjzjUYin
	wnwQNNJoPN7zvk1mpaau+XBxEaxCw565cNqqx5Vl/+dn5qidHrLXRMiFPel5X+d6VG4BSRes8Fs
	xOoauhfRA==
X-Google-Smtp-Source: AGHT+IGTifH3mbzzH6b5SWwpDXbO0YoBZfoZciezyUabROF7mLInAPfQAzLjeJIdBpssYusb7IN5lwwuWgdeQeYdg54=
X-Received: by 2002:a17:907:7fa8:b0:ae0:d798:2ebd with SMTP id
 a640c23a62f3a-af94017fa9amr842042766b.35.1754297913723; Mon, 04 Aug 2025
 01:58:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804083419.205892-1-hansg@kernel.org> <CAHp75VdfJvKb6VegNWCiiKoQkMBf0dQPs5yP3XfPM1icgtuyeg@mail.gmail.com>
 <592e9a1e-a58f-435d-aff7-13c13fe0598a@kernel.org>
In-Reply-To: <592e9a1e-a58f-435d-aff7-13c13fe0598a@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 4 Aug 2025 10:57:57 +0200
X-Gm-Features: Ac12FXyk1CSXxk6PchTjYOjJL8YIl06HY-6O6ct_xEw_ppKLvcJs7txXRueW8Jo
Message-ID: <CAHp75VcxZXk7N3F4f=edSTHXQO9reF2kvF3JUNxNu_J6VOuoRA@mail.gmail.com>
Subject: Re: [PATCH] mfd: intel_soc_pmic_chtdc_ti: Set use_single_read
 regmap_config flag
To: Hans de Goede <hansg@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 10:51=E2=80=AFAM Hans de Goede <hansg@kernel.org> wr=
ote:
> On 4-Aug-25 10:47 AM, Andy Shevchenko wrote:
> > On Mon, Aug 4, 2025 at 10:34=E2=80=AFAM Hans de Goede <hansg@kernel.org=
> wrote:

...

> >> +       /* Reading multiple registers at once is not supported */
> >> +       .use_single_read =3D true,
> >
> > By HW or by problem in regmap as being suggested here:
> > https://lore.kernel.org/linux-gpio/CALNFmy1ZRqHz6_DD_2qamm-iLQ51AOFQH=
=3DahCWRN7SAk3pfZ_A@mail.gmail.com/
> > ?
>
> This is a hw limitation. I tried with i2ctransfer to directly
> access the chip and it returns invalid values (1) after
> the first byte read.

> 1) I don't remember if it was 0, 0xff or repeating
> of the first byte. But it definitely did not work.

Perhaps elaborate the above in the comment, by at least putting
keyword HW there?

--=20
With Best Regards,
Andy Shevchenko

