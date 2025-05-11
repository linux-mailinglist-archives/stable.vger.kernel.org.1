Return-Path: <stable+bounces-143090-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD95AB2795
	for <lists+stable@lfdr.de>; Sun, 11 May 2025 12:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD4693AD8A2
	for <lists+stable@lfdr.de>; Sun, 11 May 2025 10:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729F11E4A4;
	Sun, 11 May 2025 10:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fawpbh+A"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DE01898E9;
	Sun, 11 May 2025 10:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746958007; cv=none; b=ZSxOzF4jsQ1CWmolE/pHW0tpH/ZPV0IxOJ3MfaLl1vMOOufIK7NMz1fkyJYx2McG9kiJBqyaBMhj4/+X83ni3xYcDKqZG4u4hYlYya+eO6XZBOObswMhWgZnEAwzteKKwZLa5Fk+U1XjNlBQUzvMRftFaGzlpex5zKL7Qq/l16E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746958007; c=relaxed/simple;
	bh=xgX6hEOmFUdS4ONAM2hrKrcnp0P1biKUOCv2eqldCdQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KrMCgRFoDxtTJXbBcHzgcMMz2GMDnCBePX1eNsux/HhMrWnb/k7QGP5qfpubzCg+AgYmqnolLen9CS80NSalY7c41pUWXy3GNU8NCkwH0en6VUxvKrmUdFkzcKArmUsNBFcTB9N6fdPU+bfQU4QlXACXpW8MfB6w/W8mw40FfHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fawpbh+A; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a0b933f214so1350314f8f.0;
        Sun, 11 May 2025 03:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746958004; x=1747562804; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3lbLvQJJt49Ss/0QpE+/vZ2gEhOiwMel7wTejYzG5Mw=;
        b=Fawpbh+AS9OBxPNTZAYJobYtoMa5Ll9r1oEFgD74Wts43KvvEJLOfmoi1rT9PvFV6E
         oY71vmXDvvrnFH/xe95i7KK6nwhTT9CE1ylDOXz4o2Rm51Yd0nwTZ1A05pG/DIFiXOrm
         J1b7I/bwTclE/9kppFaOlnHZluMjO3vvF0NsVSDqJ7eu3P9Iu9MKQlJGvCOLKXaFLhfM
         fLrP1PXLZTe8nbC/wOEQbqgloENHmWPI6HqwjxFgc8In2KD7F/hZdJJx9lTVGT16gZ/b
         jabcv02JGdt05EAViuZXwyamRitHPFINArOdUWFXKkePeTL+iKHhyENCDlmpVDN2f1bV
         S+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746958004; x=1747562804;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3lbLvQJJt49Ss/0QpE+/vZ2gEhOiwMel7wTejYzG5Mw=;
        b=IqK0mkhsC64zVM6q7K9zAB0NKgkQcGLyNsLRG1WYnYo+sUyG53u/UQ7P4yENzbyWnm
         d59cEeQ6Xs3NpYRw7jl6Dv4VyE7e8+1H6Xb75w3QKgo5eO/SzaQzcN5DaM30qKHqXrFk
         NSIltYtdOw3JWfmidZbe/zIf2v9qnD0oL1ouS6O5m355XkP4M8dikcHy8nA9UsV1zjfS
         2xf8JAeIFwKjE2Z58DHKwGNgYsiEqPfqB1sV5W93r9E7Dspc8/Go9PrzzQLuIDL/bvZv
         p1qYjKDuJDUn6MsEoQS/SpueeOUbTaX1uG5jj1KD6gmXGuLudo2rgxaM5K0Ywgywzsem
         Im4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVRj2eoZdAuTuHukmruwkjLPplSO3WbCVU8OGwPtmnVX25WGVaWGbxeC8rZoahR3uYkhl7O775J@vger.kernel.org, AJvYcCWO+TqCV4pqKpk2ubQK9am2Zq/4vCbs4Zog0u6fkyR1dGloVjQcqV33ZrTOCfHfq3sGpX3ObRdY94G1FKU=@vger.kernel.org, AJvYcCXdplOGC6IY4fcaRroCx3IHZ1kHHrEFyVjncJxyja7qtJccoEV4IEaMfDaZgNEIZq1sA2yjuXZe@vger.kernel.org
X-Gm-Message-State: AOJu0YwZfoibmgHUu8JOVwCiQ7D6McuI2WSFNiMzb+nBmudtZ7EB9991
	TNx6aUpb5D3/7TdldAtT+hOwQHDixzhqf02MasHFWyguzltQQFbl
X-Gm-Gg: ASbGnctZI2ctCBnF1uYINaMuXLe2gqG4S2wzGTGcLZBuXfQz+GtG5K1/o+xmrdARARq
	/se/KoB0IBZZl7A1ciUmX30ur/aaOLBru4jzjCRbuPO6NEMqgbnBWZmzPQNmFDeLIvyJ/5XrKh8
	gwk5GIm6KsTILy3sQsH9alYnx4UhfWQT7N6gF0Xq6havJwIqCjJmSIWvl3OllA64eVK5TtMls+R
	ZLSg8EKYLwFtM/1HQBSChMlbdkCF6ghAEX2gxLPvJ8pgRMtVfQH3qAfBiZT6J3hXEdbkgZPTr4A
	so3e5Zy/ZqRIXlZnHbC8gTuDFG4mpgFgILwDAsHCEbkL+Xz26kls1BsMCAd1/EbImZTmSnSWw86
	IdavcBuc=
X-Google-Smtp-Source: AGHT+IFNk5pQks3/a9jqoV+cf8L7WnYJZgefSs3zx7emLf7m8t2SA0H3W2cjd89NKtDYgBiJn0fb0g==
X-Received: by 2002:a05:6000:2ce:b0:391:952:c728 with SMTP id ffacd0b85a97d-3a1f6427719mr7273435f8f.4.1746958003552;
        Sun, 11 May 2025 03:06:43 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a4c5c5sm8934454f8f.96.2025.05.11.03.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 03:06:43 -0700 (PDT)
Message-ID: <682076b3.5d0a0220.2603de.62cd@mx.google.com>
X-Google-Original-Message-ID: <aCB2sVejCc1-DE1D@Ansuel-XPS.>
Date: Sun, 11 May 2025 12:06:41 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [net PATCH] net: phy: aquantia: fix wrong GENMASK define for
 LED_PROV_ACT_STRETCH
References: <20250511090619.3453606-1-ansuelsmth@gmail.com>
 <aCB0dkhiO49NJhyX@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCB0dkhiO49NJhyX@shell.armlinux.org.uk>

On Sun, May 11, 2025 at 10:57:10AM +0100, Russell King (Oracle) wrote:
> On Sun, May 11, 2025 at 11:06:17AM +0200, Christian Marangi wrote:
> > In defining VEND1_GLOBAL_LED_PROV_ACT_STRETCH there was a typo where the
> > GENMASK definition was swapped.
> > 
> > Fix it to prevent any kind of misconfiguration if ever this define will
> > be used in the future.
> 
> I thought GENMASK() was supposed to warn about this kind of thing. I've
> questioned in the past whether GENMASK() is better than defining fields
> with hex numbers, and each time I see another repeat of this exact case,
> I re-question whether GENMASK() actually gives much benefit over hex
> numbers because it's just too easy to get the two arguments to
> GENMASK() swapped and it's never obvious that's happened.
>

Maybe there are warning but since this define wasn't actually used they
are not triggered?

Honestly GENMASK is a saviour as from the dev point it's much easier to
understand the mask this way than raw hex.

Also most of the programming documentation (or at least the good one)
always use this pattern of defining a table with range of bits soo
translating that to the driver with the define is only a matter of
copying the range number.

It's also worth to consider that converting bit range to raw hex might
also introduce error and probably nobody would ever notice them compared
to the much clear GENMASK macro.

Aside from this, if no check are placed for GENMASK macro then they
should be easy to implement? Simple logic should be applied like

GENMASK(x, y)

x > y should be always true.

Actually I wonder...

with GENMASK(0, 1) what kind of mask is getting created?

> I don't remember there being a dribble of patches in the past
> correcting bitfields defined using hex numbers, but that seems common
> with GENMASK().
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

-- 
	Ansuel

