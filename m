Return-Path: <stable+bounces-210371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6DED3AFDB
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 17:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 280F23009690
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 16:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784C42737FC;
	Mon, 19 Jan 2026 16:00:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7D51DF26E
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 16:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768838412; cv=none; b=jk2lnA6eHy3JJE/FKApXine+1XPA8w6Kjym47ylZeLrTtl8oPmg63TGUOt1gcE3GUCBBySTiD0qHwb/EWnHTYEfyozCmbGtFP18U8f0LZgsKw6htER3YahGm+kR687edI66Kd4XNQJFRjkHZ4EoSAl+FFwGfxb8wSCc+OIKKkVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768838412; c=relaxed/simple;
	bh=eb6D6/a55vm9al21kajs54FVPI2y4Ag9eZRWr0kdwgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nWO4cKKp+562sLJD7MISn/vPFQ9uO/iyIuCYKbuXLJjaGk7DllrYZpP+oK/AilCz1RhPC/97i14Gk4nTDPlyWTIgzQfQj6zBlNrayle4qO04G9aGmPq1ltfNrbCenO06ve5J8pVpzS7cBssnq0AFdDX2e7R2i9r1QYBN6eKzPNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5636dce976eso3451950e0c.0
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 08:00:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768838410; x=1769443210;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hT58BDTF1pvqexWRcVDA+bO694WnbhM+to2RCxxMZI=;
        b=cpLOjW+fxFDIKxJkEcPhDKZ2oqWin2hP4DwCoXLRUU+AvYJjvs/zsbG7LvuExZm7j1
         KtsJpWl0c0x9LXvSYyRk5iMTC1165S///fSXFWwRpZLCuQ12rqWPytawQkpNxqQuBMev
         ZTbawEk0S5uVkp77XAVT0e7DzTNlWSdzG1NZLtYnm29uk7VSXdLeaBYsi+IQvaIcd3/1
         hMWRn/xDtVrJI+CirURq8UjrdD0+NFF+FrXnw3R0mdtZ1Dlu17eWfgJjakQLtm+H+8D7
         nyM9VFkPdaTZab0PKscjUAeCEX/BLE0RGt12lQI/eWZKM4V8d5a4hyNBgsKseFX8lEiY
         9ojw==
X-Forwarded-Encrypted: i=1; AJvYcCUdEsdDqo1jumIKhD5M6VqHwqtMCW1HnmMoo7Bss76wMUmnO3uCOqwRHzGci1r6XoM41n+f9Qg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOuulszAzBnGF3j79gsjSlwqplm/YijbciRJYaaSU3HysSGNE6
	2wHzjZw7wK77Gd2oDZEcCYZv6GL3KoxFGnDhKw8CnpioB8RN7kb0AtauuDgWiSy0
X-Gm-Gg: AY/fxX5+byFHobZPplpomoisY+teaWq8XpTwcfb7/zDWItTVm0OirSPqF4r9HamDp3R
	M+pzS4Z9fbcli5wZ6aDyrtjz1PJK8V2oayJ8r8Guw9xq0ww/LrX16h/X0BQfalZ1DJwmbPV2ZOb
	d1HKx5QA83xKunlueFznAttBn/00Me3rowRzif/fc0w3EteUW+Y6u06zqOXnBuwNY5xY3R1bj9S
	2uStvPhsK8hf04U7zHaAaJQ6GHPxus5YXZPeAXlSQA5hO3dQGCQg0ZbeFH6KiIjnvwoRkJ3LuDB
	sQ0h3SvI24v5J37XHVxxNislvgGwA7XX8wo/eSvbQtlxc0p3EaIWZf4NYzlmHCZpHOWY3Md/4yn
	sYfPcGhYIqB+tFARVYlvlO7A4ZCN8Lupyl5XMNAM2uVBgHlee1Te7+96ozVvWdGRpQHHXuU1jJl
	HsAerW2DgoeXd30EaskL3YaAJwWGZ3DgVHSAsY0hPh8xNx6TIPviUHoCjEZfs=
X-Received: by 2002:a05:6122:3b0d:b0:563:5f5e:3cc with SMTP id 71dfb90a1353d-563aa8f3134mr4155430e0c.4.1768838408342;
        Mon, 19 Jan 2026 08:00:08 -0800 (PST)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-563b71197easm2795691e0c.19.2026.01.19.08.00.07
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 08:00:07 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5eea75115ceso3973069137.1
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 08:00:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWvqgLATJsCo5ermq0MfLfRhbtBLRFVoKolrgZpt+7WkXhwO/vNobUIo2YYEq4LiwYohihpnD4=@vger.kernel.org
X-Received: by 2002:a05:6102:c54:b0:5df:abc1:e6b5 with SMTP id
 ada2fe7eead31-5f192539aa3mr5432025137.17.1768838406940; Mon, 19 Jan 2026
 08:00:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119150242.29444-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260119150242.29444-1-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 19 Jan 2026 16:59:54 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUwD9+hYbut37gnJML-Fhz+6kDqUWOcgKSo1eycZRgsvw@mail.gmail.com>
X-Gm-Features: AZwV_QiLc3qN2dSh2kpzFDVeY21PCd07Pkeq9W0NJqI963gYqgaIk1PGN_jervk
Message-ID: <CAMuHMdUwD9+hYbut37gnJML-Fhz+6kDqUWOcgKSo1eycZRgsvw@mail.gmail.com>
Subject: Re: [PATCH v2] clk: rs9: Reserve 8 struct clk_hw slots for for 9FGV0841
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-clk@vger.kernel.org, stable@vger.kernel.org, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Jan 2026 at 16:02, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
> The 9FGV0841 has 8 outputs and registers 8 struct clk_hw, make sure
> there are 8 slots for those newly registered clk_hw pointers, else
> there is going to be out of bounds write when pointers 4..7 are set
> into struct rs9_driver_data .clk_dif[4..7] field.
>
> Since there are other structure members past this struct clk_hw
> pointer array, writing to .clk_dif[4..7] fields corrupts both
> the struct rs9_driver_data content and data around it, sometimes
> without crashing the kernel. However, the kernel does surely
> crash when the driver is unbound or during suspend.
>
> Fix this, increase the struct clk_hw pointer array size to the
> maximum output count of 9FGV0841, which is the biggest chip that
> is supported by this driver.
>
> Cc: stable@vger.kernel.org
> Fixes: f0e5e1800204 ("clk: rs9: Add support for 9FGV0841")
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>

Closes: https://lore.kernel.org/CAMuHMdVyQpOBT+Ho+mXY07fndFN9bKJdaaWGn91WOFnnYErLyg@mail.gmail.com

> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-renesas-soc@vger.kernel.org
> ---
> V2: - Update the commit message crash paragraph
>     - Add RB/TB from Geert

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

