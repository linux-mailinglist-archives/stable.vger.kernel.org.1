Return-Path: <stable+bounces-203244-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA160CD772E
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 00:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88BC3301FF79
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 23:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4362F225785;
	Mon, 22 Dec 2025 23:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHKlr+6G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022E31917CD
	for <stable@vger.kernel.org>; Mon, 22 Dec 2025 23:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766445534; cv=none; b=ZtElY8O7fUGLX3OqHfes0Ri7WrJdkWGff2jFqNn1EWLdqu0K3WlALIM+/HsD9PI5dAsgGY2k2ZuusjVIhmGrrkLKLr6zLR9wJ3QnkubcjMdLUOdkCwHijj6W8GCKu7Wsrc7IM/LR6aN0np1HBby656RErrteg4fL3MnWDQv8M34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766445534; c=relaxed/simple;
	bh=1PTRj5IbPheHyKPLUeQn09lt7a0KA8xUVM3vs4ytqHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OGeL4aiADN1PLbMnSBJkFBmlwGk4Mc01Cmkq+Lmsr+hlogAV6/4VWxpKoAJi/zwX160mpj/scLvf4G0KcdULUGv8n6GLtI0T0CxcYv3grlbiLqbIepfKNNDUJXU/mW8e1YXik5oYI5wCZv0AOr1DD61OiEDA8O0Rr2rtJmqtqDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHKlr+6G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E30C2BCB1
	for <stable@vger.kernel.org>; Mon, 22 Dec 2025 23:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766445533;
	bh=1PTRj5IbPheHyKPLUeQn09lt7a0KA8xUVM3vs4ytqHE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IHKlr+6Gl+QA6DaryNduIe7WNRMfP/E6B1HbR+itsvFugogI1qMmYADh8rnIcXmNK
	 PKRGX1Eb/Hn/078PsXt6gwtRFo7Gg1sFUlfWavz7rQFCxG5psWmo49HEAKbqti2/fz
	 A2il37qqTBEs6Cw1bCzYM6zJeOUKjulJ1zJo8luVkqsRxNWYfeB+D6XxKrCu8UW3At
	 JNrDfJJ1XxNdiY86a6wVSUUf0yCo42r0DBj931tkjFHjJfmryQmXqOEIDoAdcEjBbH
	 s9nXS7azO2fxm1zST5j1Ek8F2UutDiI6uNawqwZzIkim17PjDCkfsgtx5Qql5JmZlY
	 r7c7KNDBSTy+A==
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-78c66bdf675so37024847b3.2
        for <stable@vger.kernel.org>; Mon, 22 Dec 2025 15:18:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVUuR377qp+4ouoGILB+bLM0AB8aeOvapAL3Ic43DUh0OSbono1zBZmHZRhI7pCSpsjFJ/oKrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxHDP9NqkrUAX+jpN5DTm8pwgX4uN32lBCt7AhgjNSbbLH3Vjs
	M+8VgQmu5v0Ed6VniU1Hd1JXAI8lWchyBun0dCITjU7R3DVE4jIAefUABhIfUgr1z7yVK9xRM/7
	7PpJ9x+aqo84AuTCQjefDaLSf9izhpeA=
X-Google-Smtp-Source: AGHT+IFLuNG5vfFv+hvdMwlVrLtVEINXP+UqBdcB4yXJij0JrDbJSKnUkVy8zi/D+KeXicJLx2KQRsl8vzD85DfIxMQ=
X-Received: by 2002:a05:690c:6c84:b0:786:827f:6fe8 with SMTP id
 00721157ae682-78fb41ac9e0mr105561577b3.58.1766445532634; Mon, 22 Dec 2025
 15:18:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205-drm-seq-fix-v1-0-fda68fa1b3de@ideasonboard.com>
 <3b13c7a2-f7e6-49fd-b3bb-3e0a1fe9acf3@ideasonboard.com> <CAD++jLk8-0Rkh16T+R1dh6=e_f9U1i=AKOk1Y8dLGV4bxzRtFg@mail.gmail.com>
 <817b2358-0920-4b7a-abb1-133103d0f9fe@ideasonboard.com>
In-Reply-To: <817b2358-0920-4b7a-abb1-133103d0f9fe@ideasonboard.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 23 Dec 2025 00:18:39 +0100
X-Gmail-Original-Message-ID: <CAD++jLm_0xweD4tRJ8ZfwmcOe2BBGCsUuL1UWUiNM+Gpbq3Zuw@mail.gmail.com>
X-Gm-Features: AQt7F2qVusB26rJf3VFnv1cbbMcmw7gQTV_3PZwZEvdew2fS2i_2TmDT15TKrTs
Message-ID: <CAD++jLm_0xweD4tRJ8ZfwmcOe2BBGCsUuL1UWUiNM+Gpbq3Zuw@mail.gmail.com>
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

On Sun, Dec 14, 2025 at 1:42=E2=80=AFPM Tomi Valkeinen
<tomi.valkeinen@ideasonboard.com> wrote:

> >> Should we merge this series as a fix for 6.18 rcs?
> >
> > Too late now, so let's merge it as a fix for v6.19 rcs!
>
> Ah, right. Indeed, I meant v6.19 rcs.

Are you applying it or should I?
Not sure if you want some special timing, like outside of
holidays.

Yours,
Linus Walleij

