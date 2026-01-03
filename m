Return-Path: <stable+bounces-204543-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8209ACF04C6
	for <lists+stable@lfdr.de>; Sat, 03 Jan 2026 20:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7939C3011AB2
	for <lists+stable@lfdr.de>; Sat,  3 Jan 2026 19:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B3930C62B;
	Sat,  3 Jan 2026 19:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwkdHVZV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFD2271448
	for <stable@vger.kernel.org>; Sat,  3 Jan 2026 19:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767467560; cv=none; b=iiHPHE10CFp7WzvWow9s7UYm+1vWlbvMAxNZf7HSd5G1DtnXpNBhceMfcOQG5TPGf/+zcP44v/yiP3keT9N8qb+IXj9CYDyPpkskGyI2aTuO79BKv0YTxNhlSJxngnxsLv+C64ug35YvoaRITlnwyFvP6RPBGhVPgNiqfTsZmBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767467560; c=relaxed/simple;
	bh=T925OkrZcUDgPFL2mYysHSWwXId47m50zcvgTJvCH2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j8vN2GhNUjnD2fdIKQ0NGPkf4n/M6NiHC5t+hW7r1JMGet+GpCdK35NNdeii9iSRX4uf7l7VpmYS0dALx+pCdrF81cWvYDoFrFlyJDtH4gcQf/0HeTZZMAKdUh4QedY6H0SNGs9hNALxgx5+/nxunXT/Hp4XKvwToNuVeEu54pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwkdHVZV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 625F7C19422
	for <stable@vger.kernel.org>; Sat,  3 Jan 2026 19:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767467560;
	bh=T925OkrZcUDgPFL2mYysHSWwXId47m50zcvgTJvCH2c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XwkdHVZV3gQnw/Squqt0WQf2kgDmWCB3uLhB4vNPfLhUYflWMvg0DlOyvLv6lOWkp
	 GxueGN/DejHjmBa9Q90itz6LELagfJKXs/snV9U7yJC+iCD9CyzzFUj6qTUop4scjD
	 pqQ7yjuP3byWkKSdyd0DCyYJ4TLXzhOM0IP5wXrvb8nbbq5WDjvxt5Xo9fPFPOBSOs
	 U85EwkPdKHWSQWmnpVHVj1cmGS9TlzUxF0c0zKJuYHRGeWMrmYAUro96BVlbfXlJaH
	 2lzbhsxLlt/0vTNe6dCS1vYhYKKknqgjcV4eVykEomW57WOKnMJ6d0FKBOmXku8BKA
	 JIQ6TfoXrZcOA==
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-64472121ad5so7656734d50.0
        for <stable@vger.kernel.org>; Sat, 03 Jan 2026 11:12:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWaLgsWQx7kf9Te2bMAe6mqzDqTOK/k91WA83i00fVOt/+THTCrELt2DEtzLG0bqJPJJvOUHY8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0A41IAb11k5+zBS0AmJAdj4E8qiX1gzrK3JGrGYWRTIPHUMzV
	H/C5ApxOkjaqllExc3HyARxGlaoTF39SoH7cJegxLQN8zoGOFl49Yh2hkmUIxNlVg4H7qJtbgDC
	8ud0e3Kw31r5EL8Bdf6cmMwDTzBjdxNM=
X-Google-Smtp-Source: AGHT+IGShwlfB3khNYsriA05VuQGUjyDnWfdgI+OFTb0UW6gPumdUc17cvVkNIGVynpsd6//h1UTyWv7gZLMzA3VXbk=
X-Received: by 2002:a53:bf8e:0:b0:643:833:bf3 with SMTP id 956f58d0204a3-6466a8598f6mr27408373d50.42.1767467559732;
 Sat, 03 Jan 2026 11:12:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205-drm-seq-fix-v1-0-fda68fa1b3de@ideasonboard.com>
 <3b13c7a2-f7e6-49fd-b3bb-3e0a1fe9acf3@ideasonboard.com> <CAD++jLk8-0Rkh16T+R1dh6=e_f9U1i=AKOk1Y8dLGV4bxzRtFg@mail.gmail.com>
 <817b2358-0920-4b7a-abb1-133103d0f9fe@ideasonboard.com> <CAD++jLm_0xweD4tRJ8ZfwmcOe2BBGCsUuL1UWUiNM+Gpbq3Zuw@mail.gmail.com>
 <6be8aaf6-b01d-4444-9850-967f8e316896@ideasonboard.com>
In-Reply-To: <6be8aaf6-b01d-4444-9850-967f8e316896@ideasonboard.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 3 Jan 2026 20:12:28 +0100
X-Gmail-Original-Message-ID: <CAD++jLkWH8xxT+bTXseuJv+pXeEGy7qqE7Z1Mid2CwRg8O5D7A@mail.gmail.com>
X-Gm-Features: AQt7F2oqzhLbhnApuLunbol1WMXqKAfZVNbTglNtWTgf1-h4HM11uw_w8WHAIqs
Message-ID: <CAD++jLkWH8xxT+bTXseuJv+pXeEGy7qqE7Z1Mid2CwRg8O5D7A@mail.gmail.com>
Subject: Re: [PATCH 0/4] drm: Revert and fix enable/disable sequence
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Dmitry Baryshkov <lumag@kernel.org>, Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Jyri Sarha <jyri.sarha@iki.fi>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	Marek Szyprowski <m.szyprowski@samsung.com>, 
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, 
	Aradhya Bhatia <aradhya.bhatia@linux.dev>, Chaoyi Chen <chaoyi.chen@rock-chips.com>, 
	Vicente Bergas <vicencb@gmail.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025 at 12:48=E2=80=AFPM Tomi Valkeinen
<tomi.valkeinen@ideasonboard.com> wrote:
> On 23/12/2025 01:18, Linus Walleij wrote:
> > On Sun, Dec 14, 2025 at 1:42=E2=80=AFPM Tomi Valkeinen
> > <tomi.valkeinen@ideasonboard.com> wrote:
> >
> >>>> Should we merge this series as a fix for 6.18 rcs?
> >>>
> >>> Too late now, so let's merge it as a fix for v6.19 rcs!
> >>
> >> Ah, right. Indeed, I meant v6.19 rcs.
> >
> > Are you applying it or should I?
> > Not sure if you want some special timing, like outside of
> > holidays.
>
> Oh. No, I'm not a DRM maintainer, so I was waiting for someone to merge
> this. From my point of view it's ready for merging.

Aha OK, I applied and pushed it now. I added the same Fixes: tag as on
patch 1/4 to all 4 patches in the process.

Yours,
Linus Walleij

