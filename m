Return-Path: <stable+bounces-211957-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KhwCKfueWm41AEAu9opvQ
	(envelope-from <stable+bounces-211957-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 12:10:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F85CA0173
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 12:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11A5330086FB
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 11:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBFF2EAD1B;
	Wed, 28 Jan 2026 11:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="e7TIY0mV"
X-Original-To: stable@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83C8278E5D
	for <stable@vger.kernel.org>; Wed, 28 Jan 2026 11:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769598622; cv=none; b=AI7hXuiijCPCQqHiTQFb9cIEY7/kmChbPfCGmzoHj00aFMmmW/3xLv0d0itWc3T6EsYM7RWwYIusaHbbFanOBoeyf6rtuWdzqrItqCdazbdGWATyxGVT/ZXQ10ReYg9NQX9UHmoc2Lrz2BajNbQZLx2BYDZXkC5KuZ05UpCX6y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769598622; c=relaxed/simple;
	bh=vbouGZx3a175eMpkN5/+6+Ii1sJexF9yeGBH8vqfnRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=fNOu5FvEcVqtyPEZbACtDeLeEQjDm96p59wI3peAV0MVn8mKdiLXm9q+8HKtI5gvm+U2mcvm3dHbtlLLOMpL1A47/7Vc1rK3gjig4f023wNwMDr3EjAjRVpNoKv9UxSr9vDCKsEZZpEYrVmDIB+PX1E/bhLSva9QUUb3ww3dLLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=e7TIY0mV; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260128111012euoutp02a1f3bfbb72ede4bb88ade1c15ea2f563~O4I-zQse21029010290euoutp02Q
	for <stable@vger.kernel.org>; Wed, 28 Jan 2026 11:10:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260128111012euoutp02a1f3bfbb72ede4bb88ade1c15ea2f563~O4I-zQse21029010290euoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1769598612;
	bh=45jaImfVH7kr/nS0FqB71oJKgUEPUgwMAJFDZ02gS2I=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=e7TIY0mVVbHRZJQwi+WMMav97sC49+KwDu2GGaWW+C4sNN0zeUrKZUzpkRdRKQvkw
	 pHI9z2tl4ich1br8bHnxz0ndvvkghRdfemCwwnPSD6jHa2qm4m+aRTMOnow5zvN4O0
	 mdJv583zDVUIh3mIu+McfZ/J0GXG6r57pO1WsQn0=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260128111011eucas1p2b98d9b06481ae6d47968b83ec0ed491c~O4I-SdpCE2976529765eucas1p2U;
	Wed, 28 Jan 2026 11:10:11 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260128111011eusmtip1807cf713c50c74db811a812a02bdb2e4~O4I_kWAQE1268412684eusmtip1Y;
	Wed, 28 Jan 2026 11:10:11 +0000 (GMT)
Message-ID: <b05f6b30-04b7-4b88-b0b0-40dfdea4944b@samsung.com>
Date: Wed, 28 Jan 2026 12:10:10 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 0/3] Fixes and enhancements for Exynos (7870) DSIM
 bridge driver
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
In-Reply-To: <20260124-exynos-dsim-fixes-v1-0-122d047a23d1@disroot.org>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260128111011eucas1p2b98d9b06481ae6d47968b83ec0ed491c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260124172131eucas1p2bd0fa9cde2981c87238deb67cf5f0554
X-EPHeader: CA
X-CMS-RootMailID: 20260124172131eucas1p2bd0fa9cde2981c87238deb67cf5f0554
References: <CGME20260124172131eucas1p2bd0fa9cde2981c87238deb67cf5f0554@eucas1p2.samsung.com>
	<20260124-exynos-dsim-fixes-v1-0-122d047a23d1@disroot.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211957-lists,stable=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[disroot.org:query timed out];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[disroot.org,samsung.com,amarulasolutions.com,intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m.szyprowski@samsung.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[samsung.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email,samsung.com:dkim,samsung.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5F85CA0173
X-Rspamd-Action: no action

On 24.01.2026 18:20, Kaustabh Chakraborty wrote:
> Since v6.17, there were a few regressive changes for the Exynos 7870
> DSIM driver. These changes resulted in weird artifacts on the display,
> such as random RGB channel swaps and random aberration (the occurrences
> of both were mutually exclusive).
>
> The first two commits of this patch series address the aforementioned
> changes.
>
> The third patch replaces an implicit loop for waiting for PLL
> stabilization with an interrupt-based solution, which should be more
> reliable. This solution was suggested by Inki Dae in a discussion of an
> earlier patch series sent by me. For further details, refer to its
> commit description.
>
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>

Works fine on legacy Exynos based boards in my test lab.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
> Kaustabh Chakraborty (3):
>        drm/bridge: samsung-dsim: move bridge init sequence to atomic_enable
>        drm/bridge: samsung-dsim: enable MFLUSH_VS for Exynos 7870 DSIM
>        drm/bridge: samsung-dsim: use DSIM interrupt to wait for PLL stability
>
>   drivers/gpu/drm/bridge/samsung-dsim.c | 61 +++++++++++++++++++++++------------
>   include/drm/bridge/samsung-dsim.h     |  1 +
>   2 files changed, 42 insertions(+), 20 deletions(-)
> ---
> base-commit: ca3a02fda4da8e2c1cb6baee5d72352e9e2cfaea
> change-id: 20260124-exynos-dsim-fixes-5383d6a6f073
>
> Best regards,

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


