Return-Path: <stable+bounces-272356-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id b3LfGuOiTGrAnQEAu9opvQ
	(envelope-from <stable+bounces-272356-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 08:55:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9507182D0
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 08:55:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=dolcini.it header.s=default header.b=bJrRYeT9;
	dmarc=pass (policy=none) header.from=dolcini.it;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272356-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272356-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B3CA3098118
	for <lists+stable@lfdr.de>; Tue,  7 Jul 2026 06:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9343B583A;
	Tue,  7 Jul 2026 06:51:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB373B3C06;
	Tue,  7 Jul 2026 06:50:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783407060; cv=none; b=W7uO0RSYBHxLz+pIAK+V0tb1bI7JHlri5mvdAKHsQ06MsYX5qbKMrBtAWgQL7Is9I81Hh/KATwEwuCC5XgA4HNDOWGGc81pfEPFzaXrzMOfkZHhMV56LmhDSl65bKsirufRMcwoGQOy7LpvgeidV9dQfF3BRU0KOCagy/AecMaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783407060; c=relaxed/simple;
	bh=3Sho4eZXwTS4gAyDozYpmwbFnlwHUbtdJHZ9Rv67QgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ebIPuJTONrvnVSu6tJ19CGOL1nwLKP2Qw2u8zFKn42yQ2Xh5H0wLMytIF28YrWjvvnQYwq2RJcxme4dLdrGJGVH93nLiuJYYRiNFDMNAYGL5g+2azGp5hAQllbrPqKxwlUmEwJftyn2qX9Pw4EvBvYluY7YM9cc2plSJh2oddfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=bJrRYeT9; arc=none smtp.client-ip=217.194.8.81
Received: from francesco-nb (xcpe-178-82-120-96.dyn.res.sunrise.net [178.82.120.96])
	by mail11.truemail.it (Postfix) with ESMTPA id 4C0F922BA7;
	Tue,  7 Jul 2026 08:50:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1783407053;
	bh=gzQ0I16YwfhvYkn48LZ69ffR9JleCaK1KHWKv253E3M=; h=From:To:Subject;
	b=bJrRYeT9ZqUjPhY2wr1FjkV+D9xNvvwKV/UFUZ+OuXh0rLkT+KJrsrBL7u3Dx2amD
	 qG7ozs2unqMTCAxbWkHbL8DToXc8q5dLBVIrJ+Yh0VRvjy6yC1YMmutOeTFRYfLGNf
	 EL8i4HGAELg0vpuOL+gMLrXejKj5ER0cOAJGTRUYQWKPwqmj4oXHMt0adcUDCHx4bb
	 jbDP8nVnwF1YHhGN27TS8m0x7Lpv8jNZF2fhG7F4Pc1OgXGPRrnEKvu0yC7QzIJMan
	 VqEVEtufS4Ags8wZlAhsIlJMvM2AgN1p+EuVZNS5Dad4Zy8HneO2HQtAIO0fD1BhwH
	 GWexIg6+glxqw==
Date: Tue, 7 Jul 2026 08:50:46 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Leonardo Costa <leoreis.costa@gmail.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
	jernej.skrabec@gmail.com, luca.ceresoli@bootlin.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	tomi.valkeinen@ideasonboard.com, francesco@dolcini.it,
	leonardo.costa@toradex.com, stable@vger.kernel.org
Subject: Re: [PATCH RESEND] drm/bridge: tc358768: Enforce input bus flags via
 atomic_check
Message-ID: <20260707065046.GA24247@francesco-nb>
References: <20260706132440.1594239-1-leoreis.costa@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706132440.1594239-1-leoreis.costa@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[dolcini.it,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[dolcini.it:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:leoreis.costa@gmail.com,m:andrzej.hajda@intel.com,m:neil.armstrong@linaro.org,m:rfoss@kernel.org,m:Laurent.pinchart@ideasonboard.com,m:jonas@kwiboo.se,m:jernej.skrabec@gmail.com,m:luca.ceresoli@bootlin.com,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:tomi.valkeinen@ideasonboard.com,m:francesco@dolcini.it,m:leonardo.costa@toradex.com,m:stable@vger.kernel.org,m:leoreiscosta@gmail.com,m:jernejskrabec@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[francesco@dolcini.it,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-272356-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dolcini.it:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[francesco@dolcini.it,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,gmail.com,bootlin.com,linux.intel.com,suse.de,ffwll.ch,lists.freedesktop.org,vger.kernel.org,dolcini.it,toradex.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,francesco-nb:mid,dolcini.it:from_mime,dolcini.it:dkim,vger.kernel.org:from_smtp,toradex.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9B9507182D0

On Mon, Jul 06, 2026 at 10:24:17AM -0300, Leonardo Costa wrote:
> From: Leonardo Costa <leonardo.costa@toradex.com>
> 
> The tc358768 declares static bridge timings requiring pixel data to be
> sampled on the positive clock edge.
> 
> However, the DRM core default propagation simply copies the output-side
> bus flags, coming from the next bridge, connector or panel, to the
> input side. If the propagated flags are incompatible with the bridge
> ones, the data is wrongly sampled, typically resulting in visual
> artifacts on the panel.
> 
> Implement the atomic_check hook, replacing the mutually exclusive
> mode_fixup, and set the bridge state input bus flags to the ones
> required by the tc358768. The sync polarity defaulting previously done
> in mode_fixup is carried over into atomic_check unchanged.
> 
> Fixes: ff1ca6397b1d ("drm/bridge: Add tc358768 driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Leonardo Costa <leonardo.costa@toradex.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>


