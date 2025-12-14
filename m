Return-Path: <stable+bounces-200962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C61E6CBB9E4
	for <lists+stable@lfdr.de>; Sun, 14 Dec 2025 12:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C46CC300479C
	for <lists+stable@lfdr.de>; Sun, 14 Dec 2025 11:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39802DEA9D;
	Sun, 14 Dec 2025 11:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1b4A8U5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875782DEA97
	for <stable@vger.kernel.org>; Sun, 14 Dec 2025 11:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765710865; cv=none; b=TwGEujk+f/QyTCVKEa6+JhjIs+2/IAoCqY44owljLkGN6+XnmDC0wEURBw9uF/Qz1nlxl9pwDKIln1x2TIxNFZBmv9l7QcPDkTVoqu96dnRfoH2YfJ6e4b9K+W0n8AyemaknFIQb1PGHQYeOfQxZ4VAzNH0BcdWhlZFudmp7DCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765710865; c=relaxed/simple;
	bh=/QLe5DRA4R5uIxIMYOd08sO2x/axkjdz2V3xzbL3jPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MGCnhH0V1OIw97jAOjLGcm/S7osrHhZam2SkMwFn6EHhf3e3iuaSNcv0D9pf58scW0EvVpnLzyYMz36iXK2nMDYSMw2fEQBZ7SMFSf42xYlcJAF6zPHPmWLQ3eU+MDRZS7SIUmVnNx+mor9EPreKZGFDM7x8SRZZZheFOgP04KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1b4A8U5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3029AC4CEF1
	for <stable@vger.kernel.org>; Sun, 14 Dec 2025 11:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765710865;
	bh=/QLe5DRA4R5uIxIMYOd08sO2x/axkjdz2V3xzbL3jPA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=C1b4A8U5fahx4NyZEfKzoPiqu+9gVV2oeC57J+y3tq+P6IojjJJMZBvo6ktlOSR9q
	 zMxcW1JLDgbWSos1qoRwDz9d5VpLa3QpQLc3EAt7JjEAgByTDHG2Mz+ft7QEMtDsms
	 gbxLjzSe3NrcjbboeecGjHup0a6v93zqiIC2dPkz6FQU2BIrYMbegex6QCl8F7QEg3
	 dFVvp3DDPBWhwMX9c/9+wmlNOEGUHYo+kzvGObEIhzNHgydlnLhUBlLIAb87a92abh
	 4rp7v/zfD1T1hRK8tJ0wVnPdp+4O3/a+a8CYpO6qMX4mjvMzdWJOr90Gf4CqbGX/FO
	 MUKln9xWB1h7A==
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-64472c71fc0so2141423d50.0
        for <stable@vger.kernel.org>; Sun, 14 Dec 2025 03:14:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUVvqOWykoseltHbWCeX4uCkT4pDU9TUHHi+ml3MiOZiOR2spFLoP0JncyJHfs0HT3vHyf5Qew=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtH9m5gGwYqKGLmInX2lEJNUvH3nJ8WdNbn1gLkpoqIZPeN5IG
	FrH6IkvH7PlrmEEHhMjXJ1N1I+wK9MexOA5boX30/h4I+m+ua8c/UOo+qv5qq0ZzhfHSPdKQQar
	/6ZecFMSSrxU5YOZMmL5VSghrcIEfMV8=
X-Google-Smtp-Source: AGHT+IF59cxs2kdU4eDBNHMhmLTNz8MsYKlAx9mrL803Pj47S8lUi3lkvhPPv1HSTCcC+HsFx/YkSG29wQ1pVt26PNc=
X-Received: by 2002:a05:690e:20a:b0:63f:add1:e6da with SMTP id
 956f58d0204a3-64555651315mr5936681d50.57.1765710863949; Sun, 14 Dec 2025
 03:14:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205-drm-seq-fix-v1-0-fda68fa1b3de@ideasonboard.com> <3b13c7a2-f7e6-49fd-b3bb-3e0a1fe9acf3@ideasonboard.com>
In-Reply-To: <3b13c7a2-f7e6-49fd-b3bb-3e0a1fe9acf3@ideasonboard.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 14 Dec 2025 12:14:12 +0100
X-Gmail-Original-Message-ID: <CAD++jLk8-0Rkh16T+R1dh6=e_f9U1i=AKOk1Y8dLGV4bxzRtFg@mail.gmail.com>
X-Gm-Features: AQt7F2ocpq33b3u9qnsKC4Ot3iW4zl2olWm7s8rxLgJ7ka5jFZMptEaRqkUdvZI
Message-ID: <CAD++jLk8-0Rkh16T+R1dh6=e_f9U1i=AKOk1Y8dLGV4bxzRtFg@mail.gmail.com>
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

On Fri, Dec 12, 2025 at 3:21=E2=80=AFPM Tomi Valkeinen
<tomi.valkeinen@ideasonboard.com> wrote:
> On 05/12/2025 11:51, Tomi Valkeinen wrote:
> > Changing the enable/disable sequence in commit c9b1150a68d9
> > ("drm/atomic-helper: Re-order bridge chain pre-enable and post-disable"=
)
> > has caused regressions on multiple platforms: R-Car, MCDE, Rockchip.
> >
> > This is an alternate series to Linus' series:
> >
> > https://lore.kernel.org/all/20251202-mcde-drm-regression-thirdfix-v6-0-=
f1bffd4ec0fa%40kernel.org/
> >
> > This series first reverts the original commit and reverts a fix for
> > mediatek which is no longer needed. It then exposes helper functions
> > from DRM core, and finally implements the new sequence only in the tids=
s
> > driver.
> >
> > There is one more fix in upstream for the original commit, commit
> > 5d91394f2361 ("drm/exynos: fimd: Guard display clock control with
> > runtime PM calls"), but I have not reverted that one as it looks like a
> > valid patch in its own.
> >
> > I added Cc stable v6.17+ to all patches, but I didn't add Fixes tags, a=
s
> > I wasn't sure what should they point to. But I could perhaps add Fixes:
> > <original commit> to all of these.

> There has been no comments, so I assume this is the way to go.
>
> Should we merge this series as a fix for 6.18 rcs?

Too late now, so let's merge it as a fix for v6.19 rcs!

Yours,
Linus Walleij

