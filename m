Return-Path: <stable+bounces-197072-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3405DC8D662
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 09:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 103014E31DD
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 08:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C298B1F8AC8;
	Thu, 27 Nov 2025 08:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ar+Cujs5"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AED919ABD8
	for <stable@vger.kernel.org>; Thu, 27 Nov 2025 08:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764233177; cv=none; b=CjcoKKmNjqfkHTc6zjz9V03/kQ4quIEhEjnUjFEV7sxew80IKGDJgarq8DqhmS1G+pTkYKUkbVxZ4bl8Gx0FnaYCJWIaqbTeYoSpOr5SPIsdTc7X9NqARtzj4onx1IBjTK1FPKy2f0H6u9+vwKLdFzytDwrIMMBqL9BxU57AhBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764233177; c=relaxed/simple;
	bh=dyx7pVflONcgVriAOz1RtQHm2UvacLUsKujLD5due4k=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=IuC1SP9RC5nBPc/vJi9xHipDGkUeWkz1pNFBxXCei0VKkpJGy5Lx45r3KkeFThamCVbl8GfURYcfln1HRNNCjqilfp+2vrhMe9MmksCQ0BIWJ2cc5T1SVv1yl+L51ukDDmyuqvZI44rZMwl4ABrPDhUfjcgJGzMfLg5Ku1Wwgrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ar+Cujs5; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 7ECCB4E41916;
	Thu, 27 Nov 2025 08:46:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 41A0B6068C;
	Thu, 27 Nov 2025 08:46:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0DF23102F260E;
	Thu, 27 Nov 2025 09:46:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764233172; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=9y+3k0UXBrLmTd/kE3SkjhPOUSTrfoL+BRA+CPkJoI8=;
	b=ar+Cujs5LCkyGBX7TuqAjrZEw7Ihu3b+1t/au6zcWhx9zVj6IDiztgT0sIvjPVw7QRbPPs
	ElMBQrEEOLQhvVo9riB63q31VWEkGkMMJsh4tW+SkoVoNJQXvwOJ4MRmOvqw4fSHus5A7u
	QwHYWOY/lP3OeSCAR6jxvaLswAfHU5FLYkKmoLtj2+5/oeLr1t3HLTuELVjF6I1sGxsKJH
	FtwFI34GgQV3nVNfNbrurcwFLVRhTkJKh7prnThxYrmEbS5CiPE4CyB3nRGnaKUYP1O4BA
	RJzs8hCBnXBqrPvingI5hUShNMnjT/CZhdGckaK7qkNROj/OApL/ABnskU0jMg==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Nov 2025 09:46:07 +0100
Message-Id: <DEJCGODDOTXT.QT2J4E31GUVW@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v1] Revert "drm: bridge: ti-sn65dsi83: Add error
 recovery mechanism"
Cc: "Francesco Dolcini" <francesco.dolcini@toradex.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>, <stable@vger.kernel.org>, "Herve Codina"
 <herve.codina@bootlin.com>, "Tomi Valkeinen"
 <tomi.valkeinen@ideasonboard.com>, "Emanuele Ghidoli"
 <emanuele.ghidoli@toradex.com>
To: "Francesco Dolcini" <francesco@dolcini.it>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
X-Mailer: aerc 0.20.1
References: <20251125103900.31750-1-francesco@dolcini.it>
In-Reply-To: <20251125103900.31750-1-francesco@dolcini.it>
X-Last-TLS-Session-Version: TLSv1.3

Hello Francesco, all,

On Tue Nov 25, 2025 at 11:38 AM CET, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>
> This reverts commit ad5c6ecef27e ("drm: bridge: ti-sn65dsi83: Add error
> recovery mechanism").
>
> The reverted commit introduces a regression on Verdin AM62, and
> potentially on more devices, not being able to generate a clock
> that the TI SN65DSI83 PLL can lock to, with the display periodically
> blinking.
>
> Verdin AM62 SoM has a Toshiba TC358778 DPI to DSI bridge, that can be
> connected to an LVDS display over a TI SN65DSI83 bridge. Before this
> change despite the TI SN65DSI83 reporting with a debug print a PLL
> locking error the display was working fine with no visible glitches.
>
> The reasons for this issue was investigated without getting to a final
> conclusion:
>
>  - the DPI clock was measure and it is stable/accurate
>  - the DSI clock was not possible to measure, but this setup is used
>    with other display/bridges with no known issues
>  - the DSI clock is configured in continuous mode
>  - the actual DSI clock generated from the TC358778 is generate with a
>    PLL from a 25MHz reference clock
>  - it's not clear why some frequencies are working and some are not, for
>    example 50000000, 68750000, 72750000, 75000000 frequencies are fine,
>    while 69750000, 71100000, 72500000 are not
>
> Given that the safest approach is to just revert the commit, till a
> proper solution for error recovery that is not introducing regression
> is figured out.
>
> Reported-by: Jo=C3=A3o Paulo Gon=C3=A7alves <jpaulo.silvagoncalves@gmail.=
com>
> Closes: https://lore.kernel.org/all/bhkn6hley4xrol5o3ytn343h4unkwsr26p6s6=
ltcwexnrsjsdx@mgkdf6ztow42/
> Fixes: ad5c6ecef27e ("drm: bridge: ti-sn65dsi83: Add error recovery mecha=
nism")
> Cc: stable@vger.kernel.org
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Thanks for having sent this revert patch.

However after evaluating the overall situation I decided to send a
different patch to address this issue in the short term. The idea is to
just ignore the PLL_UNLOCK error, keeping the existing
structure. Rationale:

 * this sloves the issue for Toradex, based on Jo=C3=A3o's initial report
 * there is no evidence of any bugs in the recovery mechanism, it's
   just exposing a pre-existing problem that was only producing a
   non-fatal dev_err() before
 * a full revert would remove error checking for all errors, including
   those not creating any issue, thus removing a useful feature
 * a full revert would require rewriting patches such as [0] (not a big
   deal per se, but see next bullet)
 * after patches such as [0] are applied, re-adding the error recovery
   mechanism would require another rework, so more work for authors,
   reviewers, testers and maintainers

[0] https://lore.kernel.org/lkml/20251112-drm-bridge-atomic-vs-remove-v3-2-=
85db717ce094@bootlin.com/

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

