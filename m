Return-Path: <stable+bounces-197964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F2AC988E6
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 18:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 77226344D99
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 17:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B45336EC3;
	Mon,  1 Dec 2025 17:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AvW9leFg"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5EA21CC4F
	for <stable@vger.kernel.org>; Mon,  1 Dec 2025 17:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764610856; cv=none; b=T/XNH+E7xiq9u7/7I1qM2+pmOqpoE9fDk9D1/raAJ2S58IeWM+lKBvAvEITfa5Bf1oU98K2atflBI0LUXg7nzwp487EAP3eiGKWw4mFN9eSsFh755sF7ta88Ft2vhsSMvEeCJgGXzh0FgxUrW5Qe080TrVNNYIpIfxe9qElqzHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764610856; c=relaxed/simple;
	bh=ZJgcv4I6cPzN5ewPb64u//TiNBozHJSD9tXsZw4/GkY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fpOmYwNiLaxmg4SPtc0XuSjUfHvqtofX8oNDPl7PMhOvdnGE9eerlXgOvr/WEIlmupemeNkZfbMl1M++dzl4t2BX9We1QUhNetU/FXfgZtdM56grlNts6j/eujD2Bg0GdvzouUQUds49fufikknijY10lwY4q3IIw56ljLISw58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AvW9leFg; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 13D001A1E90;
	Mon,  1 Dec 2025 17:40:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C655B606BB;
	Mon,  1 Dec 2025 17:40:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 730E711918329;
	Mon,  1 Dec 2025 18:40:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764610848; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Ot37QYp52dk/c6cg1uKc5U/w8URSDggHQSTyrflhd14=;
	b=AvW9leFg8jVl+bXv8jgPKspC4XBtIAppmVqvKhO1reZeykAV+EllsRmw5uwL3QUTUJ4TOn
	gW8AseHMgE02QMwlEPoLg1lirC4iP/RHX2uUa0PdMiGPFUaDpfVq+cgxAGkwN3p4envMiL
	haHabee2OpV8mduvN2dlX7OMfdeUziVtK1/FwxJ+OP2BAo4d6PltFOZn/I10NOgE433uc5
	uFodZe5R2Yp6NypGObg/xkgpiVXwIEnql/oMSCmIZ2q/H6DTWCF21tLyeZ4jIBG9UzeAiZ
	6D9YL2MnAq66j3b1RdTzTd5f1bqXX6K8eRjqFgfczZuMH+SP2lHBj1b370+Gqw==
Date: Mon, 1 Dec 2025 18:40:39 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Maxime Ripard <mripard@kernel.org>, Francesco Dolcini
 <francesco@dolcini.it>, =?UTF-8?B?Sm/Do28=?= Paulo =?UTF-8?B?R29uw6dhbHZl?=
 =?UTF-8?B?cw==?= <jpaulo.silvagoncalves@gmail.com>, Emanuele Ghidoli
 <emanuele.ghidoli@toradex.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Francesco Dolcini <francesco.dolcini@toradex.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: Re: [PATCH v1] Revert "drm: bridge: ti-sn65dsi83: Add error
 recovery mechanism"
Message-ID: <20251201184039.79dfe0bb@bootlin.com>
In-Reply-To: <20251201-uptight-limpet-of-chivalry-404dff@houat>
References: <20251125103900.31750-1-francesco@dolcini.it>
	<DEJCGODDOTXT.QT2J4E31GUVW@bootlin.com>
	<20251201-uptight-limpet-of-chivalry-404dff@houat>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Maxime,

On Mon, 1 Dec 2025 17:36:13 +0100
Maxime Ripard <mripard@kernel.org> wrote:

> Hi,
> 
> On Thu, Nov 27, 2025 at 09:46:07AM +0100, Luca Ceresoli wrote:
> > Hello Francesco, all,
> > 
> > On Tue Nov 25, 2025 at 11:38 AM CET, Francesco Dolcini wrote:  
> > > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > >
> > > This reverts commit ad5c6ecef27e ("drm: bridge: ti-sn65dsi83: Add error
> > > recovery mechanism").
> > >
> > > The reverted commit introduces a regression on Verdin AM62, and
> > > potentially on more devices, not being able to generate a clock
> > > that the TI SN65DSI83 PLL can lock to, with the display periodically
> > > blinking.
> > >
> > > Verdin AM62 SoM has a Toshiba TC358778 DPI to DSI bridge, that can be
> > > connected to an LVDS display over a TI SN65DSI83 bridge. Before this
> > > change despite the TI SN65DSI83 reporting with a debug print a PLL
> > > locking error the display was working fine with no visible glitches.
> > >
> > > The reasons for this issue was investigated without getting to a final
> > > conclusion:
> > >
> > >  - the DPI clock was measure and it is stable/accurate
> > >  - the DSI clock was not possible to measure, but this setup is used
> > >    with other display/bridges with no known issues
> > >  - the DSI clock is configured in continuous mode
> > >  - the actual DSI clock generated from the TC358778 is generate with a
> > >    PLL from a 25MHz reference clock
> > >  - it's not clear why some frequencies are working and some are not, for
> > >    example 50000000, 68750000, 72750000, 75000000 frequencies are fine,
> > >    while 69750000, 71100000, 72500000 are not
> > >
> > > Given that the safest approach is to just revert the commit, till a
> > > proper solution for error recovery that is not introducing regression
> > > is figured out.
> > >
> > > Reported-by: João Paulo Gonçalves <jpaulo.silvagoncalves@gmail.com>
> > > Closes: https://lore.kernel.org/all/bhkn6hley4xrol5o3ytn343h4unkwsr26p6s6ltcwexnrsjsdx@mgkdf6ztow42/
> > > Fixes: ad5c6ecef27e ("drm: bridge: ti-sn65dsi83: Add error recovery mechanism")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>  
> > 
> > Thanks for having sent this revert patch.
> > 
> > However after evaluating the overall situation I decided to send a
> > different patch to address this issue in the short term. The idea is to
> > just ignore the PLL_UNLOCK error, keeping the existing
> > structure. Rationale:
> > 
> >  * this sloves the issue for Toradex, based on João's initial report
> >  * there is no evidence of any bugs in the recovery mechanism, it's
> >    just exposing a pre-existing problem that was only producing a
> >    non-fatal dev_err() before
> >  * a full revert would remove error checking for all errors, including
> >    those not creating any issue, thus removing a useful feature
> >  * a full revert would require rewriting patches such as [0] (not a big
> >    deal per se, but see next bullet)
> >  * after patches such as [0] are applied, re-adding the error recovery
> >    mechanism would require another rework, so more work for authors,
> >    reviewers, testers and maintainers  
> 
> Were are we on this? Both patches work for me, but we need to take a decision.
> 

IMHO, Luca's patch [0] is more interesting than this current patch doing a
full revert. Indeed, Luca's patch keeps the monitoring active except for
cases we known broken.

Francesco, Emanuele, João have you had time to test Luca's patch ?

[0] https://lore.kernel.org/all/20251127-drm-ti-sn65dsi83-ignore-pll-unlock-v1-1-8a03fdf562e9@bootlin.com/

Best regards,
Hervé


