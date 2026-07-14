Return-Path: <stable+bounces-274177-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xOoON73vVWqewQAAu9opvQ
	(envelope-from <stable+bounces-274177-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 10:13:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D335C7523FC
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 10:13:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ispras.ru header.s=default header.b=U4lfxtlv;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274177-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274177-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ispras.ru;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3EF9730237EC
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 08:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694173F871C;
	Tue, 14 Jul 2026 08:11:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F4C3F99E5;
	Tue, 14 Jul 2026 08:11:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784016709; cv=none; b=KlhAkVCVcz9njbb48ggSYxUEbKpdyesBTmPjLvkJwi7duGMJo+7/1P46F35jZ+9v5eMGLov17ch1aM0iohdCSC5xRd3kltdku/X+5F3SDQGawJEG3jLA0lIPhtNdX584JscoPg2RIzaRvmKNotyJ1+s8NBMKmQWRI8NWGI+ZfjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784016709; c=relaxed/simple;
	bh=dCLX2OZmnQHZfHD9kLc9OyNRWWK37l6DX3lTNoMemdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JsPAel+vPbLLTDscVWXJegPG0+Ne9ZH267WImcLQXmB3U6dZSXe1ijCetlQRjUuj3F8u6HR3C3+O3y7LLBKQczURIC8AN+vo8CrNIorPrf1PP2Lhkbnq1kotd7I6S+6vwEgMIcVUO9BBHNCfnlXwz4hKqHkJ2ij0yaxiLuaAXCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=U4lfxtlv; arc=none smtp.client-ip=83.149.199.84
Received: from localhost (unknown [95.24.34.24])
	by mail.ispras.ru (Postfix) with ESMTPSA id 5A8654077925;
	Tue, 14 Jul 2026 08:11:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 5A8654077925
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1784016696;
	bh=VgVmW8xYosn9eiQExAeU/NJmJ4m2IB5bEc9w8himm7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U4lfxtlvxBqvv4zXOJvCCqXRoI/MEwpNB1CjNePGU3E67/CoorkTnoxv1/H745dau
	 tC9O8dXloA/RvxHG+EZn8G8B26BNtcjdsrq/abqTTv3i1b6YAq3QAcW/tKUpGMGzJo
	 AkJi/MBCKrccOfzCB5pXZy8N0lIX2lC7Q0PCfqkQ=
Date: Tue, 14 Jul 2026 11:11:36 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Elizaveta Tereshkina <etereshkina@astralinux.ru>
Cc: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simona Vetter <simona@ffwll.ch>, 
	Neil Armstrong <neil.armstrong@linaro.org>, lvc-project@linuxtesting.org, 
	Samuel Holland <samuel@sholland.org>, dri-devel@lists.freedesktop.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Ethan Tidmore <ethantidmore06@gmail.com>, Chen-Yu Tsai <wens@kernel.org>, David Airlie <airlied@gmail.com>, 
	linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [lvc-project] [PATCH 5.10/5.15] drm/sun4i: backend: fix error
 pointer dereference
Message-ID: <20260714110040-3d9d1292810372916773a64a-pchelkin@ispras>
References: <20260713175238.715526-1-etereshkina@astralinux.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260713175238.715526-1-etereshkina@astralinux.ru>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ispras.ru,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ispras.ru:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:etereshkina@astralinux.ru,m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:simona@ffwll.ch,m:neil.armstrong@linaro.org,m:lvc-project@linuxtesting.org,m:samuel@sholland.org,m:dri-devel@lists.freedesktop.org,m:maarten.lankhorst@linux.intel.com,m:linux-kernel@vger.kernel.org,m:mripard@kernel.org,m:jernej.skrabec@gmail.com,m:tzimmermann@suse.de,m:ethantidmore06@gmail.com,m:wens@kernel.org,m:airlied@gmail.com,m:linux-sunxi@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:jernejskrabec@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pchelkin@ispras.ru,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-274177-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ispras.ru:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pchelkin@ispras.ru,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,linuxfoundation.org,ffwll.ch,linaro.org,linuxtesting.org,sholland.org,lists.freedesktop.org,linux.intel.com,kernel.org,gmail.com,suse.de,lists.linux.dev,lists.infradead.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,astralinux.ru:email,ispras:mid,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D335C7523FC

On Mon, 13. Jul 20:52, Elizaveta Tereshkina wrote:
> From: Ethan Tidmore <ethantidmore06@gmail.com>
> 
> commit 06277983eca4a31d3c2114fa33d99a6e82484b11 upstream.
> 
> The function drm_atomic_get_plane_state() can return an error pointer
> and is not checked for it. Add error pointer check.
> 
> Detected by Smatch:
> drivers/gpu/drm/sun4i/sun4i_backend.c:496 sun4i_backend_atomic_check() error:
> 'plane_state' dereferencing possible ERR_PTR()
> 
> Fixes: 96180dde23b79 ("drm/sun4i: backend: Add a custom atomic_check for the frontend")
> Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
> Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
> Link: https://patch.msgid.link/20260217014801.60760-1-ethantidmore06@gmail.com
> Signed-off-by: Chen-Yu Tsai <wens@kernel.org>
> Signed-off-by: Elizaveta Tereshkina <etereshkina@astralinux.ru>
> ---
> Backport fix for CVE-2026-53066
>  drivers/gpu/drm/sun4i/sun4i_backend.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
> index d935f36a24dd..b3741827c6c3 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_backend.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
> @@ -507,6 +507,9 @@ static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
>  	drm_for_each_plane_mask(plane, drm, crtc_state->plane_mask) {
>  		struct drm_plane_state *plane_state =
>  			drm_atomic_get_plane_state(state, plane);
> +		if (IS_ERR(plane_state))
> +			return PTR_ERR(plane_state);
> +
>  		struct sun4i_layer_state *layer_state =
>  			state_to_sun4i_layer_state(plane_state);
>  		struct drm_framebuffer *fb = plane_state->fb;

This would trigger a really unnecessary build warning due to lack of
commit b5ec6fd286df ("kbuild: Drop -Wdeclaration-after-statement") in
5.10/5.15 kernels.

I wonder if that commit can just be ported to 5.10/5.15.  You may consider
it.

Otherwise the current backport should be adapted to avoid declarations
after statements.

