Return-Path: <stable+bounces-141760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F021AABBC0
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 09:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A83D1C430B8
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD3627BF61;
	Tue,  6 May 2025 06:47:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A93220F56;
	Tue,  6 May 2025 06:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746514047; cv=none; b=VwfLdrvbiUOJ5LXX0bi35Q5kN/fSHjNY4wRwzlw3fZbm/ec00L+2fCAQk5ahwBeCyo/rv4n2aNRjtguNPn9OXjyhQP0whsvTIIWswwa2x1LZ7IZpZrq5IyodXmzN2iWAPb2DBHIkZ2gMW0/df7LTJdUddKs7LYrysEh6Dh9B3lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746514047; c=relaxed/simple;
	bh=pVa0CJMQohvJFeF+ZNF9Ma62VDUja6pu7AjYGdUxCxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WlO3sfumW0ygDQ8OZ6hqjAaEgddfL0TNNf4GGI3G4hEhNSVBke5YWd8b3ihi4T8tuUhXUcPz4jfFKBEI5E94l+6hFX/4t3KJyjA5WOwQZw2Q7hF9ZL5SvpMRRMp/gaMdCW+tv33n47qeXzeLREhJEVfUVVwg1uhHKivE47uUUoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-523de5611a3so1511382e0c.1;
        Mon, 05 May 2025 23:47:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746514043; x=1747118843;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SqgYyr5n+leyP12ba9J/lddzsffexOyM+zyrxvJnv0A=;
        b=MZApsrSZSNZxI984ghcYL5OSFzv9q4kJqZ+Psguu1dclhAlSkgZnqA5oXk4KgfYmo7
         EU0+8fOe2z0/0rLxWNfYbUnuFmthapVgBMizQqQwFq0fZZfgNsPPWh51Cm9D8CeQ9CEX
         2DiekU0zJ2xdDugiaZ1EIAygCPihCqs81ZClWGO+4kJHtRPK/DGN7PFIz7AYqgaNbiMM
         seJh5BOfJDmV7YJQ1VamXso7fuaSzs0HfgNEgQtUyQ15vDEx52R6gihFywcDTXDhSpeT
         +dHJgcT0ZPthNyOVTB8eg5zaLC5ldVNqmt53mlgaPsmXwIkrJr8OfCanUY+J+ZBwQzk/
         PNOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmiUEnMtOHm5m+6RfNb4gXWRjbFBi2u+Hy+38umDGOaviO+5pCnCuD+QecztjWxv+6XVnFurtr@vger.kernel.org, AJvYcCXTuaPcSReGT0NVaNSHZwhoLVHmv2ChFSwV6sJ0J+2Bo6bYJmrLLIloIVaXKAojIbo03THG+NW2BfJJH84=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5DZdWMxt4Y2XmNC2s3GgfqFaTxD3A3eZ1XREbSRwJwg9HGXjX
	C5sYaNl8tkyEEzXXZYFUqQJLQ3sf9py/xOuqxBnsE+ZSIlIWgfA4puDmM/V2
X-Gm-Gg: ASbGncvgHxtPCXHJPVQpkzxqVoga9zTz1X9p7qBoex4Z8LvXFr8wkh0egTGBUu1LKk2
	mclDtUyHzDj5M2xplpDueqfU5HblSYrArGUG10iFT/O8B8DjuOIhNIogZPl88Wp7p3Z1P0MaVjK
	KV8oJBR+aOmC6Qil+oZ0H++puXUVxRyLNVEW439lSLYtxFXeFHLkgKecYOKjPwptlvxjbNBSL4v
	507w8YZVWXv4E9gL8mU/C2hD9+dkfPkSAFhZ6YjmHiZbIRUvkVx3bm/ja4u7dr24E0omRJDVIpB
	/noZX6ejmmY/Kq6TT6GPkhyKThDtWa/WE1s6BzkfgAx/W+xNsJJup++uKq3hliSPn0z4c7AFIOZ
	XYVg=
X-Google-Smtp-Source: AGHT+IFFS8ibfJPuHI8DlMmSWPuN6q/GNv7qgRMVd+nv38Jq9NRXEp8lE6LAQvuaiRDnp7n7Bb9DqQ==
X-Received: by 2002:a05:6122:3296:b0:52a:d0f2:d4da with SMTP id 71dfb90a1353d-52b26a7321cmr1156630e0c.5.1746514042839;
        Mon, 05 May 2025 23:47:22 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52ae41eb5d7sm1841430e0c.39.2025.05.05.23.47.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 23:47:21 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-86b9d1f729eso1421505241.3;
        Mon, 05 May 2025 23:47:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUU0zEgwDbO52gwSQ48gc2wd61cA8Tc2c2+bte7OrpGXf4LBR4zUh+6rRIYkRoJOnub4Xmn0U5M@vger.kernel.org, AJvYcCVIZ+uwaka04YxVKy/C9R3c0ks77fqE0Y9GsRQNxjnbthcKZUaWroDU1eGzDK86bhrhuOnPRW+g+69BCrI=@vger.kernel.org
X-Received: by 2002:a05:6102:4bca:b0:4bb:eb4a:fa03 with SMTP id
 ada2fe7eead31-4dc6393f8f9mr1426940137.23.1746514041522; Mon, 05 May 2025
 23:47:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505221419.2672473-1-sashal@kernel.org> <20250505221419.2672473-636-sashal@kernel.org>
In-Reply-To: <20250505221419.2672473-636-sashal@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 6 May 2025 08:47:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXzu1oP5hKAFFjqZ0T=d8jG8eqsTmeX5RKdjLB-jFCPMw@mail.gmail.com>
X-Gm-Features: ATxdqUGNQFMlcoIrk5ACx2Al76XOGh7HE0_txHIvrqtXiY6-LRhTUMxpIsyJcTQ
Message-ID: <CAMuHMdXzu1oP5hKAFFjqZ0T=d8jG8eqsTmeX5RKdjLB-jFCPMw@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.14 636/642] serial: sh-sci: Save and restore
 more registers
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, jirislaby@kernel.org, 
	wsa+renesas@sang-engineering.com, zack.rusin@broadcom.com, 
	namcao@linutronix.de, prabhakar.mahadev-lad.rj@bp.renesas.com, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Sasha,

On Tue, 6 May 2025 at 00:39, Sasha Levin <sashal@kernel.org> wrote:
> From: Geert Uytterhoeven <geert+renesas@glider.be>
>
> [ Upstream commit 81100b9a7b0515132996d62a7a676a77676cb6e3 ]
>
> On (H)SCIF with a Baud Rate Generator for External Clock (BRG), there
> are multiple ways to configure the requested serial speed.  If firmware
> uses a different method than Linux, and if any debug info is printed
> after the Bit Rate Register (SCBRR) is restored, but before termios is
> reconfigured (which configures the alternative method), the system may
> lock-up during resume.
>
> Fix this by saving and restoring the contents of the BRG Frequency
> Division (SCDL) and Clock Select (SCCKS) registers as well.
>
> Also save and restore the HSCIF's Sampling Rate Register (HSSRR), which
> configures the sampling point, and the SCIFA/SCIFB's Serial Port Control
> and Data Registers (SCPCR/SCPDR), which configure the optional control
> flow signals.
>
> After this, all registers that are not saved/restored are either:
>   - read-only,
>   - write-only,
>   - status registers containing flags with clear-after-set semantics,
>   - FIFO Data Count Trigger registers, which do not matter much for
>     the serial console.

Please make sure to backport this to v6.1, v6.6, and v6.12, too,
as the commit this fixes:

> Fixes: 22a6984c5b5df8ea ("serial: sh-sci: Update the suspend/resume support")

is already queued for v6.1, v6.6, and v6.12.

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Link: https://lore.kernel.org/r/11c2eab45d48211e75d8b8202cce60400880fe55.1741114989.git.geert+renesas@glider.be
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

