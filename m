Return-Path: <stable+bounces-50275-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D8A905573
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 16:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 027662833BE
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 14:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C138B17E908;
	Wed, 12 Jun 2024 14:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2r7wGhyb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8F517DE39;
	Wed, 12 Jun 2024 14:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718203343; cv=none; b=h9VO6yE/+1WBxxt93qyqrxivW4PWsSMhs4UuvTz9NO+Gj8tF96x6R0hJ5vpVQBRHmdC1E/XUv7FIbWnba1DCrBoqNgRymxlQ4jmC7+UQYOejMlTwp844AaIKLPS+vwf3MgkbuVmsVGGs7LhxcxpceiJWc6NyL9nBCsx6BKGOmzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718203343; c=relaxed/simple;
	bh=fIyHMCmdFag/kreazotdgSfqaaLxX6azOoYs64Naiq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MOCClNEcMmdRt/QfDpMLRzu9xCiEhXxdZL2OM4eeWxTH5/5Ua9zZY+EuStHr9RSq/mdRSf6y0R1PYx7Bq5wCBJRD67itJEwR23NCGluA+LLAPL9Sbm2gDhoqx4p/8vZZuG58A6vR1YuoxwXFaGbINMbOKYDfcs+Oiwnts/aL+uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2r7wGhyb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C34FC116B1;
	Wed, 12 Jun 2024 14:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718203342;
	bh=fIyHMCmdFag/kreazotdgSfqaaLxX6azOoYs64Naiq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2r7wGhybYveJ0OLks02tsdo8uWtqpEFFUrtDCrsXCKYC1H7xvfiNjkI9VxsQ345hk
	 TJKFXsJYUE9xA7aEoZdI9C2Va7O2R3Yd0hrKq8OC0ZkL3c5HWp82SMRze2saG2/DHQ
	 icYL9JmNEzpNy+dkQ2CDZOVDP7TwVbPDBXqoCCAs=
Date: Wed, 12 Jun 2024 16:42:20 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>,
	Frank Oltmanns <frank@oltmanns.dev>, stable@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
	Purism Kernel Team <kernel@puri.sm>, Ondrej Jirman <megi@xff.cz>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/5] clk: sunxi-ng: common: Support minimum and
 maximum rate
Message-ID: <2024061208-trapping-diminish-fda6@gregkh>
References: <20240310-pinephone-pll-fixes-v4-0-46fc80c83637@oltmanns.dev>
 <20240310-pinephone-pll-fixes-v4-1-46fc80c83637@oltmanns.dev>
 <yw1xo78z8ez0.fsf@mansr.com>
 <c4c1229c-1ed3-4b6e-a53a-e1ace2502ded@oltmanns.dev>
 <yw1x4jap90va.fsf@mansr.com>
 <yw1xo78w73uv.fsf@mansr.com>
 <8be80682-067a-4685-9830-cfed0287e617@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8be80682-067a-4685-9830-cfed0287e617@leemhuis.info>

On Wed, Jun 12, 2024 at 03:28:01PM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 23.05.24 20:58, Måns Rullgård wrote:
> > Måns Rullgård <mans@mansr.com> writes:
> >> Frank Oltmanns <frank@oltmanns.dev> writes:
> >>> 21.05.2024 15:43:10 Måns Rullgård <mans@mansr.com>:
> >>>> Frank Oltmanns <frank@oltmanns.dev> writes:
> >>>>
> >>>>> The Allwinner SoC's typically have an upper and lower limit for their
> >>>>> clocks' rates. Up until now, support for that has been implemented
> >>>>> separately for each clock type.
> >>>>>
> >>>>> Implement that functionality in the sunxi-ng's common part making use of
> >>>>> the CCF rate liming capabilities, so that it is available for all clock
> >>>>> types.
> >>>>>
> >>>>> Suggested-by: Maxime Ripard <mripard@kernel.org>
> >>>>> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
> >>>>> Cc: stable@vger.kernel.org
> >>>>> ---
> >>>>> drivers/clk/sunxi-ng/ccu_common.c | 19 +++++++++++++++++++
> >>>>> drivers/clk/sunxi-ng/ccu_common.h |  3 +++
> >>>>> 2 files changed, 22 insertions(+)
> >>>>
> >>>> This just landed in 6.6 stable, and it broke HDMI output on an A20 based
> >>>> device, the clocks ending up all wrong as seen in this diff of
> >>>> /sys/kernel/debug/clk/clk_summary:
> > [...]
> > 
> >>>> Reverting this commit makes it work again.
> >>> Thank you for your detailed report!
> > [...]
> > It turns out HDMI output is broken in v6.9 for a different reason.
> > However, this commit (b914ec33b391 clk: sunxi-ng: common: Support
> > minimum and maximum rate) requires two others as well in order not
> > to break things on the A20:
> > 
> > cedb7dd193f6 drm/sun4i: hdmi: Convert encoder to atomic
> > 9ca6bc246035 drm/sun4i: hdmi: Move mode_set into enable
> > 
> > With those two (the second depends on the first) cherry-picked on top of
> > v6.6.31, the HDMI output is working again.  Likewise on v6.8.10.
> 
> They from what I can see are not yet in 6.6.y or on their way there (6.8
> is EOL now). Did anyone ask Greg to pick this up? If not: Månsm could
> you maybe do that? CCing him on a reply and asking is likely enough if
> both changes apply cleanly.

Both now queued up, thanks.

greg k-h

