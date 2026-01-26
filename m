Return-Path: <stable+bounces-211537-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOOkLlUvd2lVdAEAu9opvQ
	(envelope-from <stable+bounces-211537-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 10:09:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 181BC85D5A
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 10:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 790BC304CA6F
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 09:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4C2303A01;
	Mon, 26 Jan 2026 09:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XJ1Kyd/j"
X-Original-To: stable@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B532F303C86
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 09:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769418339; cv=none; b=kJ+LLr4Xv/ntM7xuhGBvbigcqzHkZ5vB0LNiB9rwM1Q0TgtBU7cDAYF+5mP87HI9YekDXuKD2iGar1goZqkIV3hfimCgHCYaRRxkY/v8JCvOTLWpUFpLbnmvgJzNr625p8koLlSC6u2ahP2/00d6kkkuu25aZI+5cyHbzepd4gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769418339; c=relaxed/simple;
	bh=GDq+qoAUvzLsEjMdNageU7aMHOx0h17R0XljH+D+e/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=PTRKtRkp9R+HmnYYo4a5egpGtX/caLCaxO8qCtmUtH4ujuFEeMyMKaNy4Iyo/jHoOsLL7trjWhpJ3hQUDf/uCCk5n0sc7QfrNMifL9JZ0iLSI44kdefRmjBtq3QmYV4hwC6+G8uT4pIAYcXQCbweaVJP5s7+JPVd69oKhyCapS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=XJ1Kyd/j; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260126085703euoutp028d3d302712f1fa5c738ff6c3df703579~OPCLDoVc_2751127511euoutp02f
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 08:57:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260126085703euoutp028d3d302712f1fa5c738ff6c3df703579~OPCLDoVc_2751127511euoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1769417823;
	bh=PWcnq9fS5szFbjeETPL6IVSHfuuHn9KkLDU267P2J7s=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=XJ1Kyd/jacBLckjoc9q6J+PjMcGS98Ycr1zUlH0t8Zc1c1FHEOhgAMZB27d0fppp/
	 6wIF20UUhOo8cNSkR78SP6ZTumJN7SQiuspM+BOQcu2A9/yPxw39/cYReBwagn3ZxM
	 314hRMlZUIUHMp/KScTzc7pms+qnMgCzpQ4Qrmx8=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260126085703eucas1p1b2e7523f2f899396b9bc5eed64d63a7b~OPCKptgbw1601316013eucas1p1t;
	Mon, 26 Jan 2026 08:57:03 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260126085702eusmtip28f556c7e1168f5170037948f35863cd0~OPCJ279El0256102561eusmtip2k;
	Mon, 26 Jan 2026 08:57:02 +0000 (GMT)
Message-ID: <1db5ffdf-924b-49cb-a057-802a1bfe6073@samsung.com>
Date: Mon, 26 Jan 2026 09:57:01 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 1/3] drm/bridge: samsung-dsim: move bridge init sequence
 to atomic_enable
To: Kaustabh Chakraborty <kauschluss@disroot.org>, Inki Dae
	<inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, Andrzej
	Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart
	<Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, Jernej
	Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260124-exynos-dsim-fixes-v1-1-122d047a23d1@disroot.org>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260126085703eucas1p1b2e7523f2f899396b9bc5eed64d63a7b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260124172136eucas1p1e7a2da65c3fca268ea68f12506c6c19e
X-EPHeader: CA
X-CMS-RootMailID: 20260124172136eucas1p1e7a2da65c3fca268ea68f12506c6c19e
References: <20260124-exynos-dsim-fixes-v1-0-122d047a23d1@disroot.org>
	<CGME20260124172136eucas1p1e7a2da65c3fca268ea68f12506c6c19e@eucas1p1.samsung.com>
	<20260124-exynos-dsim-fixes-v1-1-122d047a23d1@disroot.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211537-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[disroot.org,samsung.com,amarulasolutions.com,intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[samsung.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m.szyprowski@samsung.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 181BC85D5A
X-Rspamd-Action: no action

On 24.01.2026 18:20, Kaustabh Chakraborty wrote:
> Since commit c9b1150a68d9 ("drm/atomic-helper: Re-order bridge chain
> pre-enable and post-disable"), pre-enable sequence is called before the
> CRTC is enabled.
>
> This causes unintended side-effects (abberation among potentially other
> things) in the display when samsung_dsim_init() is called in the
> pre-enable part of the sequence. Call it in samsung_dsim_atomic_enable()
> instead.
>
> Cc: stable@vger.kernel.org # v6.17 and later
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>

I'm not sure if this will be needed:

https://lore.kernel.org/all/20251205-drm-seq-fix-v1-0-fda68fa1b3de@ideasonboard.com/


> ---
>   drivers/gpu/drm/bridge/samsung-dsim.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
> index 1d85e706c74b9..975f8b50ae660 100644
> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> @@ -1655,6 +1655,13 @@ static void samsung_dsim_atomic_pre_enable(struct drm_bridge *bridge,
>   	}
>   
>   	dsi->state |= DSIM_STATE_ENABLED;
> +}
> +
> +static void samsung_dsim_atomic_enable(struct drm_bridge *bridge,
> +				       struct drm_atomic_state *state)
> +{
> +	struct samsung_dsim *dsi = bridge_to_dsi(bridge);
> +	int ret;
>   
>   	/*
>   	 * For Exynos-DSIM the downstream bridge, or panel are expecting
> @@ -1665,12 +1672,6 @@ static void samsung_dsim_atomic_pre_enable(struct drm_bridge *bridge,
>   		if (ret)
>   			return;
>   	}
> -}
> -
> -static void samsung_dsim_atomic_enable(struct drm_bridge *bridge,
> -				       struct drm_atomic_state *state)
> -{
> -	struct samsung_dsim *dsi = bridge_to_dsi(bridge);
>   
>   	samsung_dsim_set_display_mode(dsi);
>   	samsung_dsim_set_display_enable(dsi, true);
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


