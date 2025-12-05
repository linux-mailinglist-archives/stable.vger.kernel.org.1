Return-Path: <stable+bounces-200159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7712ECA795A
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 13:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DFE923022E30
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 12:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FF232FA3D;
	Fri,  5 Dec 2025 12:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kA9jAiXM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EA13254B5
	for <stable@vger.kernel.org>; Fri,  5 Dec 2025 12:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764938188; cv=none; b=rtw8hsSL2O/28bF9jnNq0tvmoX4537LJPk3nW8vrHwM7LTYC7kxHUWgO8wupwnOW30F49J3tdkAcbFRFJTezbQ5C48h2tK+XwrlesyvARDlVEHvrkq5dtcmY6wu7i51NKv5E00o2UD1tP/3FiX6VNx0/BBr525HgCi15RtL7wgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764938188; c=relaxed/simple;
	bh=40WaPL3xSyqPdfQ0BAFTST386p7tT1HulIdRWXHJkKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oRDGHAqSvcnIZZnn39ft6oOBkrJfi0JKC3RJN6IEA6VRX1VkdilYQej9kyHzxE+26+xZeZmU/CfBt4d9PZJys5ictJ0tBofeMmELAkErv1L7e88o+2DmXWZMqQq/FzbtH6fkialNNJIID/hFxf+GUedOcxLJ765MZ4k+OxGtW8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kA9jAiXM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F337FC2BCB0
	for <stable@vger.kernel.org>; Fri,  5 Dec 2025 12:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764938188;
	bh=40WaPL3xSyqPdfQ0BAFTST386p7tT1HulIdRWXHJkKo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kA9jAiXM5XfELxuKU9/l9OpMOt7HLiUaJi/7R5aGry/eGkBeBaRtm1w9auQ3EGkDk
	 daZ1xEFxRCUxO2MhMrxLlHdzG/9Cu39Wj9QBJ5/OF0sQfGnnx7a4bL0FWzsUaRCSxr
	 GMcrXuuIOSvQDiqpufJzCiIGhx0LiwbHjB8F1SFsWyde9l4ZKQzGdkljBmfTpIPDTC
	 4xkAZ58K5JMAiu3XuGb36DJ6WypdTSVnzfpxILFJJKVOd2AJZH+tgSvVDBrx/j1dAt
	 TlNwWkvcoEH28P/xAPkWqu/tbBWQw+fvin+z6lcsIWsGHpn75h1HSrTV9aQWP99VJr
	 5h8spjUvoS/mg==
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-78a6a7654a4so21446357b3.0
        for <stable@vger.kernel.org>; Fri, 05 Dec 2025 04:36:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV93Gm+b5SqH6XwTCSD2ItXW4MSUEjc+4rL3wkpEUTkEh6EH2Qdrd/NZxuy268Cr+xqL8bMAqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcuqV/hWwNJS3bLH/l67iV/nrONLgb1SNopw5QFCRP8xco1YrS
	fiGEAn3tc0nhye9i1c7i9i7GoTGfr1PSlu/zAe9bCFfzxMZS9gXL59x1SpFLTlHj72a8X39mCF0
	pxwZWZFpxw/TCBCpWuVd0vD22fEfHO1U=
X-Google-Smtp-Source: AGHT+IFJmlLvuUNZfx9GIfUBDjC2grftRlFjbvDqqrPRzj/oZgXVOMBUT7kbSYooxA8gr0guXcBsmXxXrD2+uuIJcXg=
X-Received: by 2002:a05:690c:6007:b0:784:883c:a88d with SMTP id
 00721157ae682-78c0c18ea37mr70979807b3.52.1764938187032; Fri, 05 Dec 2025
 04:36:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205-drm-seq-fix-v1-0-fda68fa1b3de@ideasonboard.com>
In-Reply-To: <20251205-drm-seq-fix-v1-0-fda68fa1b3de@ideasonboard.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 5 Dec 2025 13:36:15 +0100
X-Gmail-Original-Message-ID: <CAD++jLkpWoHe5qYSABF1GeDq-9hZh7ZdL-+8Xqu5MA_erzNqsA@mail.gmail.com>
X-Gm-Features: AQt7F2rYtL9k7rH39ohC1dih2VUr1gAYC2XO7dYs8vpOSbzH63P91fhZJWxLMZY
Message-ID: <CAD++jLkpWoHe5qYSABF1GeDq-9hZh7ZdL-+8Xqu5MA_erzNqsA@mail.gmail.com>
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

On Fri, Dec 5, 2025 at 10:52=E2=80=AFAM Tomi Valkeinen
<tomi.valkeinen@ideasonboard.com> wrote:

> Changing the enable/disable sequence in commit c9b1150a68d9
> ("drm/atomic-helper: Re-order bridge chain pre-enable and post-disable")
> has caused regressions on multiple platforms: R-Car, MCDE, Rockchip.
>
> This is an alternate series to Linus' series:
>
> https://lore.kernel.org/all/20251202-mcde-drm-regression-thirdfix-v6-0-f1=
bffd4ec0fa%40kernel.org/
>
> This series first reverts the original commit and reverts a fix for
> mediatek which is no longer needed. It then exposes helper functions
> from DRM core, and finally implements the new sequence only in the tidss
> driver.
>
> There is one more fix in upstream for the original commit, commit
> 5d91394f2361 ("drm/exynos: fimd: Guard display clock control with
> runtime PM calls"), but I have not reverted that one as it looks like a
> valid patch in its own.
>
> I added Cc stable v6.17+ to all patches, but I didn't add Fixes tags, as
> I wasn't sure what should they point to. But I could perhaps add Fixes:
> <original commit> to all of these.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

The series:
Reviewed-by: Linus Walleij <linusw@kernel.org>
Tested-by: Linus Walleij <linusw@kernel.org>

In my opinion Laurent is the more senior maintainer and my
trust level in him is the highest of all the maintainers, so
I think we should apply this revert series if
Laurent ACKs that this is what he thinks is best for DRI.

Yours,
Linus Walleij

