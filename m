Return-Path: <stable+bounces-118932-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D07DA420D8
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 14:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B958D167F1F
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 13:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB11248864;
	Mon, 24 Feb 2025 13:34:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538C3248878;
	Mon, 24 Feb 2025 13:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740404045; cv=none; b=lB2K5iphctQSqn0yzgidAuzN28f+Nxtyl22FEggr1DPK3HlG27ZJLOk943yTktqjyinK19kYZTpKrmFljxFSmio13CQGDHzZ9ge9lXwXSqKRDqix7woRy3UgI/KTxm6znrEtOsBcYBu0tnFAS2Jpix66GfeAtekyDZUVHgqMLoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740404045; c=relaxed/simple;
	bh=s8QE7q5gI2/gnbGI/Y0TO2qy/2W3oWz7FQ4HLFw+70g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pRG6SFyqR746HBn9BuFOirbI0DyjIdpgdNLw6rj/JfRqUjNcZsU1sZN9SAFq6S4q+RcdDHsxhwuJDEdCmuuK1Y8N2dbXaefSMJExzCYCdGeZLzvvC46bb1/gc2BCxF2ln5BoZaLK0vR5qTUC60zjcdm9euSrQV5+hO00A12XTsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-521b1b8cdb6so1076053e0c.2;
        Mon, 24 Feb 2025 05:34:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740404042; x=1741008842;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n1H1EjANJHbfGOkZsEIuMwZQlIxdc83X+vl3h/blgS8=;
        b=DbDSToWkrhwBFRCecMWAVDMLOl5hbN5jCe1ZcbqHic0DWAmKFUxODCt9i0iQfeHl1t
         u+Sm0tfx7gFyItME0aUkD/9O4l+YEd1KekybMRrKGAeFXmPrOPR4X5IRq0LuqQITsmFY
         YsYv8jE244pQYI/xGNv+9c3t59TOGbfcaMp09YWsIf3u0A/vHvdGwM9IbcITnUAwzhh6
         2L2vZPkyFlTz1uYE31675MFCrcXZCksRNVZV+OvNlB2NdqdXE9o4QgqKqicDARhdKes8
         NYEy8mJ41J9Jy/UVNLoMJTAR9oHF5Vq40EF9vk+G1+d+KTv7lWKttQ4WzEf/vjTac1DD
         4hMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxdYsyPuTBZB4C94adELwWdMFCJmrn4lbfsPR68xZ39t0ZAE9CzVNr4DSPhFlh1Hl/sISjyX/3@vger.kernel.org, AJvYcCXEPb08a/QitvoumjCjYTi04Li1hv9nSTvZ36Nd1mO+2XC73o+1aVip7C4YIa1fzSp2Hd0LUFehnPK/gcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMlPkLZXY5BexZEo6rxdPto6K4Ebi+HLDBbSeIftrpnz6pdHJP
	tO9Qz1jrX1+2wCkfCCSrGDrV2E/EY/ggcLU8Elt02t9ujBVZJ3ykTjaVqQ37jyc=
X-Gm-Gg: ASbGncuiEMy9Og/Mn5b/pwIbeUODI5hCOznKqQuSEGESjmUV8LbsjpR5k97PPvEbwKs
	afZ1DdnuUGiftGxsQYTtKPNmGq3hGmUoJpYmQWikRnjNAyqbUsKQRzTd066V0x8DbSiQIn22vKb
	4tZLWMe6MPvC5RFUDsLgeWwzviSFMKil0XhaV/oVYgUU4Cu39ekb7wpPqYE43eLqeIyhVar6VPx
	2myYBssR5eXWCiMPFm7O8zVmWtkwZC9GvfEjGfEIK/emLcdQwYH1nZiQm6dJ5BGrNX7fOFu5HyN
	lKDxg3gseBCRQx4VQBwzfIsqnR62/tEdMo3mc1XaQbzIcLjyngKebXFL0/5+jSdh
X-Google-Smtp-Source: AGHT+IFwRC1DBWQIsl+ufZT/O3uyrXppKFzyXXKtTFeud7QSYhLgIGKlIhkgPU5zAhjqeXSh0eS+og==
X-Received: by 2002:a05:6122:3711:b0:520:6773:e5ea with SMTP id 71dfb90a1353d-521ee4288bcmr6249730e0c.7.1740404042648;
        Mon, 24 Feb 2025 05:34:02 -0800 (PST)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-520c02060f1sm3005508e0c.32.2025.02.24.05.34.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 05:34:02 -0800 (PST)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4be625c5365so1404956137.2;
        Mon, 24 Feb 2025 05:34:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUT5HeWNDL6VfY/9gYs7wYYKUBhrOzk6W3ckN5wFDmYZU8SYRphp3cTlhCfNdhy1R8XOIu3u1nI@vger.kernel.org, AJvYcCUey7/pjtmASP0NGnhdm+lNl9X1AThpubnKKYZ2GDqR/3o9MKsLrItjUY6FNHr2V01o6QjVHcUCUnatUQA=@vger.kernel.org
X-Received: by 2002:a05:6102:6d6:b0:4b6:8d8b:82c6 with SMTP id
 ada2fe7eead31-4bfc00afeefmr5875993137.15.1740404042031; Mon, 24 Feb 2025
 05:34:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224101527.2971012-1-haoxiang_li2024@163.com> <Z7xnnPaoHfz7lYyi@smile.fi.intel.com>
In-Reply-To: <Z7xnnPaoHfz7lYyi@smile.fi.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 24 Feb 2025 14:33:49 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVYxruwpA92FykyEAwoSBxfb0Z1AmnyqLziGTpMC3d_gg@mail.gmail.com>
X-Gm-Features: AWEUYZmDaUb1RlXfoOLr5mx6usNzPpvp7inE7zcz7NwEakWHhMlI5TGdHT4kHMs
Message-ID: <CAMuHMdVYxruwpA92FykyEAwoSBxfb0Z1AmnyqLziGTpMC3d_gg@mail.gmail.com>
Subject: Re: [PATCH v2] auxdisplay: hd44780: Fix an API misuse in hd44780.c
To: Andy Shevchenko <andy@kernel.org>
Cc: Haoxiang Li <haoxiang_li2024@163.com>, u.kleine-koenig@pengutronix.de, 
	erick.archer@outlook.com, ojeda@kernel.org, w@1wt.eu, poeschel@lemonage.de, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andy,

On Mon, 24 Feb 2025 at 13:35, Andy Shevchenko <andy@kernel.org> wrote:
> On Mon, Feb 24, 2025 at 06:15:27PM +0800, Haoxiang Li wrote:
> > Variable allocated by charlcd_alloc() should be released
> > by charlcd_free(). The following patch changed kfree() to
> > charlcd_free() to fix an API misuse.
>
> > Fixes: 718e05ed92ec ("auxdisplay: Introduce hd44780_common.[ch]")
> > Cc: stable@vger.kernel.org
>
> Okay, looking closer to the current state of affairs, the change
> does not fix anything actually. OTOH it's correct semantically and
> allows to do any further development in charlcd_alloc(), if any.
>
> That said, if Geert is okay with it, I would like to apply but without
> Fixes/Cc: stable@ tags.

I had mixed feelings about the Fixes-tag, too.
Semantically, it's indeed a fix.  If any further cleanups are ever done
and backported, but this patch would be  missed, it would introduce a bug.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

