Return-Path: <stable+bounces-166452-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6112B19DEB
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 10:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 019D1166D5D
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 08:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5392B1E8836;
	Mon,  4 Aug 2025 08:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYtdfNLG"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEB02F30;
	Mon,  4 Aug 2025 08:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754297263; cv=none; b=kvs8vKpLW92f2XUIx7/zzT6rNA3ntEGLatUSR412K+cHAKOuF+BfF2GDo/n63tbQPq3sW5QQL8372JAnNl0JVcRKRWd5U5tS3nnRgK/i8p5bA5rSIIr9vySIVPINiJjbUvslvPSA+34X9jmBOluEax1mAvP/4E5FaEp8UfJa/5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754297263; c=relaxed/simple;
	bh=t3IQI/j/o1NuYJLYS+UfsaYguP9UFoif38C6HTtvXN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=txIK7XHkhbZRZwjeJkhaZeVWS5eCe5K2TwpnFUPNQ72QDPl+OSMYsGoCANGTpxsPGso+AhRNbDs2boHGZsMI0sGHo+bwkUWakCWEfm0cbfVhSsezZJCNxcCjSyBO+qvoN/jFP0WJMyaMGQ4hfPCcqTSnjU8AaGk3zq7X9NWW89w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYtdfNLG; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-615a115f0c0so6893113a12.0;
        Mon, 04 Aug 2025 01:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754297260; x=1754902060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PP95V0BUHP8GfpvVRHzFQCAfR5E80Z5oT/rWEPt87aE=;
        b=SYtdfNLG2I7t5z6M4m/USlx4I2+pAm8yVvKAXTnAP6ESqc5TBnxypMOmSIR4c8H0qo
         uqHWThSKi//ik/DZia0jaXXG5Zrw3PjPbi6y3drRbDoOqKsvILitd8VNrg2f1HuQPgzV
         KA29URBiRvKq1+QsR9XCglBB453+4mDVxwr4reRFRl4NlsnCTQyQ/sTDVQnSVvQfUUwR
         RYQ5YnIKykT0iGHp6LKm17G/B6jXNGe/bL7TlqfmbVeCuRHISPw3UAhxSTLuBQwMSn7C
         uYIXebEP3sQIJoY5VTLvCNixuzW1l6C2z1fDE/N28UtQxroer9Y0eJo8XWuHWoy27nGc
         TPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754297260; x=1754902060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PP95V0BUHP8GfpvVRHzFQCAfR5E80Z5oT/rWEPt87aE=;
        b=AOaoT1/XDAxotPuImPA02IhKTJJ9fNDANHIGf7RsfJv0AGSdUwFyqxZGBw6X33AuhN
         e/982tvqVuzvt49Bk1aZ0NgLWYADXaHNZoflB082YIqsS5kVmccbv7bMmu+IYTOfOMfm
         c3+LUxTxAfQ9dMYGwz9q7pbNqf2T9HU8puO7dbpGhFzoTtnHLEN13y/t5+b3qVtTjOIt
         uB2cbpZBBMjnfkXdRsxuc18vg1QnrRm4U/5fyUrOYWuPuVOWgMxn7VbQX+YQQkm70muc
         WXWUnxy5Fn/JzvUjKJro9Z8T7v0aPMZWQH90UwZOnaPi2paCzAr6cvUI+ozHFe/ll6ET
         Da2w==
X-Forwarded-Encrypted: i=1; AJvYcCU4DeYNY9wWCc9pv8+oQ0bhqhn53tHsvXqeDGSw0b4gzS7vq0wTfIa9Y2zgRJq5LyThJGp4SM1sj5J5+vE=@vger.kernel.org, AJvYcCWbfGxtBuyHr1huZwe+xjJ4+bpyfHC5b1Af7CHLmms5aAn/PkSbQcDM2of06HcI6Ix7yD9kbIF5@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo6xeoZqKWfMr/LzEv4LoDZSqSNwcyyXetwZiKc1u8ZkF2RfFp
	RhOOuwdOy5Lnicgb8xCMDy082j8Mx1OqSzmcZNuYNMGiRTVtNL6fvvyB6ZDbnkCQLFFH3q7o/Yf
	W4QqMt9lN1jVtGjyFMIL9KSOkQrxipl+oCH9qz3enDw==
X-Gm-Gg: ASbGnctbPcVjjTn1PXmh6qwmaRjGgxx9c2/N4B4axk1LPb0IIfWmLsmYen846tfEVoi
	+50/lGotal18MlRLnVsvOZU/pDPXICN2h7HkxnD0/VHbfeGUKtXHhQdmKiW1g1D/XXjmozoAUyt
	tx2ka61z6l9QbiM1rIKhH9XIeeHPnV9bPUeuoglW8fdDAsXiisWhWyTY3p7z1R5Sq8kGWDQ1YXU
	tvQvaU1Yg==
X-Google-Smtp-Source: AGHT+IGSo5A8HLbtMhNfbOQB5qnNLea1x4Wudz3qo3h/lutbHGYrG0B/jwsDYyx+UZrGK4zTgzGxXUYgbgXUVQZm2pU=
X-Received: by 2002:a17:907:7b85:b0:ad5:2e5b:d16b with SMTP id
 a640c23a62f3a-af94005a96cmr1047044066b.27.1754297259615; Mon, 04 Aug 2025
 01:47:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804083419.205892-1-hansg@kernel.org>
In-Reply-To: <20250804083419.205892-1-hansg@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 4 Aug 2025 10:47:03 +0200
X-Gm-Features: Ac12FXx9fXN05DYmz9AZYO2FBWPH5Tk6UiLhmrlSspr67q96BKF9Jn7FKX6z0M8
Message-ID: <CAHp75VdfJvKb6VegNWCiiKoQkMBf0dQPs5yP3XfPM1icgtuyeg@mail.gmail.com>
Subject: Re: [PATCH] mfd: intel_soc_pmic_chtdc_ti: Set use_single_read
 regmap_config flag
To: Hans de Goede <hansg@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 10:34=E2=80=AFAM Hans de Goede <hansg@kernel.org> wr=
ote:
>
> Testing has shown that reading multiple registers at once (for 10 bit
> adc values) does not work. Set the use_single_read regmap_config flag
> to make regmap split these for is.
>
> This should fix temperature opregion accesses done by
> drivers/acpi/pmic/intel_pmic_chtdc_ti.c and is also necessary for
> the upcoming drivers for the ADC and battery MFD cells.

...

> +       /* Reading multiple registers at once is not supported */
> +       .use_single_read =3D true,

By HW or by problem in regmap as being suggested here:
https://lore.kernel.org/linux-gpio/CALNFmy1ZRqHz6_DD_2qamm-iLQ51AOFQH=3DahC=
WRN7SAk3pfZ_A@mail.gmail.com/
?
(OTOH it mentioned cache init and you seems referring to run-time,
however it might be well related)

As a quick fix I am fine with this.
Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko

