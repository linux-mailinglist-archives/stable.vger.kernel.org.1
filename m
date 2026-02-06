Return-Path: <stable+bounces-214672-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MK+FBOQThmm9JgQAu9opvQ
	(envelope-from <stable+bounces-214672-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 17:16:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F961100245
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 17:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 944313067A2D
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 16:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AAF30C635;
	Fri,  6 Feb 2026 16:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="ou6udq04"
X-Original-To: stable@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA132737EB;
	Fri,  6 Feb 2026 16:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770394268; cv=none; b=UwEKxXDlVQKLnWzBHoNaI9Aeq+hILMNFIE1mle71PiQ7YKF+VTa7eSErwaRbFqXdba6QYx/JIP+t8pMPVLlZ5hDxLNCjsOJmGnesflA6ANQwc2XnQaJpqsdvb+GlAwckNZpcYPca9YZweoXfOyiQpk/+Z8AIqFYNGphqkpiqTGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770394268; c=relaxed/simple;
	bh=qWEoHxi5HN14Ce3uW+zwPyrQDcl0R5vhnLtErPfBQc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fIju/w1vunPPAGoMA6IWUS41pV1y5gXlJjY56FtSmp2tAwgrBkEgXaQ5De3Ciqr2JowWT7rs+6h6CFbWf3GsbIKrMlwLUIgZ8j1fHpRKGW7Gn9PUmq089n0lyjlow1pcRKfUo+oj472P8xO8OoEzqKPMSEvVvfLBlPjaCKB2abc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=ou6udq04; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 9A43B1FAA2;
	Fri,  6 Feb 2026 17:10:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1770394259;
	bh=NWmcPAurNjwlvM/3wgdAOFlyTkvK8iV82QRVbSW0Kyk=; h=From:To:Subject;
	b=ou6udq04170rew7KaDkpcdF0rIvdQ+e1HIu9Ue9zEq75DDwlLbBh5k+78OScUOLCs
	 3t2pw3vmrSXL0nMOoAzLDWMYW1lW46JOsjbRrvS6+E9AfLPUVpVU0XZD7sK2t/okpx
	 oTUfzX/gVGsIrY3HLJmTxk0jPJ1bpPXM5A65nU6j2oAbjP+sjCgDgzSw7wANQeYuNd
	 ThkCIxdDuAzN8x+dC2az9a4gS6ZBErejb15LxneO0SfAHJ4Ur8FAhHBiIeonMx9Wbj
	 FPq+Usha/ZIQDFDaINGChO3m4Qq/cFliwdIuksjBts7qBAfZSiYIRAWaJSvF8Xb8GN
	 4NBWha2C10FJw==
Date: Fri, 6 Feb 2026 17:10:54 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Doug Anderson <dianders@chromium.org>
Cc: Franz Schnyder <fra.schnyder@gmail.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Franz Schnyder <franz.schnyder@toradex.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco@dolcini.it>, stable@vger.kernel.org
Subject: Re: [PATCH v1] drm/bridge: ti-sn65dsi86: Enable HPD polling if IRQ
 is not used
Message-ID: <20260206161054.GA101724@francesco-nb>
References: <20260206123758.374555-1-fra.schnyder@gmail.com>
 <CAD=FV=UO3wHqGKep67pY04PgBJKgvOgDf8u1qxeXmWkgVMLXiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=UO3wHqGKep67pY04PgBJKgvOgDf8u1qxeXmWkgVMLXiQ@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[dolcini.it,none];
	R_DKIM_ALLOW(-0.20)[dolcini.it:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214672-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,linux.intel.com,suse.de,ffwll.ch,toradex.com,lists.freedesktop.org,vger.kernel.org,dolcini.it];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[francesco@dolcini.it,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[dolcini.it:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dolcini.it:dkim,toradex.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4F961100245
X-Rspamd-Action: no action

Hello Doug,

On Fri, Feb 06, 2026 at 07:46:10AM -0800, Doug Anderson wrote:
> On Fri, Feb 6, 2026 at 4:38 AM Franz Schnyder <fra.schnyder@gmail.com> wrote:
> >
> > From: Franz Schnyder <franz.schnyder@toradex.com>
> >
> > Fallback to polling to detect hotplug events on systems without
> > interrupts.
> >
> > On systems where the interrupt line of the bridge is not connected,
> > the bridge cannot notify hotplug events. Only add the
> > DRM_BRIDGE_OP_HPD flag if an interrupt has been registered
> > otherwise remain in polling mode.
> >
> > Fixes: 9133bc3f0564 ("drm/bridge: ti-sn65dsi86: Add support for DisplayPort mode with HPD")
> > Fixes: 55e8ff842051 ("drm/bridge: ti-sn65dsi86: Add HPD for DisplayPort connector type")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
> > ---
> >  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> It's weird that you have two fixes, but upon closer inspection, I see
> why you tagged it as you did.
> 
> The first commit that landed, commit 55e8ff842051 ("drm/bridge:
> ti-sn65dsi86: Add HPD for DisplayPort connector type"), was still
> using polling mode and just using the HPD line for polling. That
> commit incorrectly set the flag "DRM_BRIDGE_OP_HPD". So the proper
> backport to kernels with just that commit would be to take away that
> flag. Unfortunately, I didn't notice this problem during the review
> and I don't personally have any hardware using this bridge for DP,
> only eDP.
> 
> The second commit that landed, commit 9133bc3f0564 ("drm/bridge:
> ti-sn65dsi86: Add support for DisplayPort mode with HPD"), actually
> added support for the HPD interrupt. After this commit, your fix
> (which makes the flag "DRM_BRIDGE_OP_HPD" depend on the IRQ) is the
> correct one.
> 
> Unfortunately, I think the above will confuse the stable scripts.
> Since your patch applied cleanly atop the first commit then it will
> picked to any kernels with it, even if they don't have the second
> commit.
> 
> I think the first commit landed in v6.16 and the second commit isn't
> yet in any stable release.
> 
> Maybe the right way to look at this is to just call the 2nd patch a
> prereq? So this:
> 
> Fixes: 55e8ff842051 ("drm/bridge: ti-sn65dsi86: Add HPD for
> DisplayPort connector type")
> Cc: <stable@vger.kernel.org> # 6.16: 9133bc3f0564: drm/bridge: ti-sn65dsi86: Add
> 
> That will cause the 2nd patch to get picked up for stable too, but
> that would be preferable to having just your fix without the 2nd
> patch. Alternatively, you could try to add some other note to the
> stable team to help them arrive at the right backport.

We had some internal review before sending this patch and I am the one
that suggested to put both commit as fixes in the end.

I agree that your solution is the correct one (I am not familiar with
the syntax there, but I agree on the concept), assuming
nobody disagree on this, should we send a v2, or are you going to amend
the commit message when applying it?

Thanks,
Francesco


