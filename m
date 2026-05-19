Return-Path: <stable+bounces-249518-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 7kpyOqYwDGrdZAUAu9opvQ
	(envelope-from <stable+bounces-249518-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 11:43:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E40757B7BC
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 11:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C9850303927B
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 09:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D98466B52;
	Tue, 19 May 2026 09:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GbTCACME"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9063E44DB62;
	Tue, 19 May 2026 09:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779183732; cv=none; b=qFsBCd9fkGTbXAIJiKe5oJKebi+Crvx+okVZ6YE/Utc5WsosATHF/vaUsnhPig065FsJmmk+MywuMrFvWjkZFAu0lYRTAX8IOci9nSOrIrmx5/8CztqhuGovE/nHzrmobm8eikwe/POyloZoCPeW5wY78DiZuiTVGEIkKlDvv9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779183732; c=relaxed/simple;
	bh=Hhfs4nT6HC6MjT0jJEYdGh2bUJavvEbTjP0QQhz4c6M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IxsHvbUqVu93zVivMKVkMr103qRN1Tkz5f21eG16tKVaK/5jYqPsp71A+OFQJi8tVl0niuuX8cwFFo9prre5wJhBEctt5WrkmI/avasPBnNk3e2dfzRTzl5kZyejzuWeuigeK4udhafVGPfEZysAJty6C96H1I4T7SoLMuUV+tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GbTCACME; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779183728; x=1810719728;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Hhfs4nT6HC6MjT0jJEYdGh2bUJavvEbTjP0QQhz4c6M=;
  b=GbTCACME8fZ3cVEAxOEPb+pMl5PcbLlje/GgSe5YwWMBtmyc0PlZV5Vc
   svUO+VGo4Ei0FaUn448FcIFGzZNlw2Xi1y9ilVKXAfNSQxEQedQBxKks/
   26MIhe0V5YXFvYAxWIcUgOhdbQuOtemVzpDnXDToT+id3HnD1sNNyuWLd
   IOlyg60dlsjI689eVA8QbWTUHQPZwWRJpYOPeb7XWwr34X/AGNJ/z6pRW
   gawl53W/zVxctCsLR7rRd6XIliUvLhoAfyIC3wQAI6+KM0QNkrLrNVCNS
   V0Iry5BANmIUskSDvvTRqtcPC/NzvfTIPl7/G5GXzDwOOQEU5H4j8eyPV
   g==;
X-CSE-ConnectionGUID: e7Yy8COPTx+8xqyPIgIFdw==
X-CSE-MsgGUID: JdMQNon4TqeebiKbNz5aOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="80107824"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="80107824"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 02:42:03 -0700
X-CSE-ConnectionGUID: E06rSB3EQfKvvVdX2MGUQA==
X-CSE-MsgGUID: 6zvRwQlASeG1cDcXcrC1Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="233340391"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.218])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 02:41:59 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Icenowy
 Zheng <uwu@icenowy.me>, Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/client: check whether CRTC is active before waiting
 for vblank
In-Reply-To: <20260519092420.1124348-1-zhengxingda@iscas.ac.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260519092420.1124348-1-zhengxingda@iscas.ac.cn>
Date: Tue, 19 May 2026 12:41:56 +0300
Message-ID: <889a09d63c62d88a85d8a31a85feb8bbc178534c@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249518-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[iscas.ac.cn,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,ravnborg.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jani.nikula@linux.intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,intel.com:mid,intel.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7E40757B7BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 19 May 2026, Icenowy Zheng <zhengxingda@iscas.ac.cn> wrote:
> Currently the implementaion of drm_client_modeset_wait_for_vblank()
> assumes drm_vblank_get() will fail when the CRTC isn't active. However
> it seems that this is not true, and running fbcon on a device with the
> first CRTC inactive will lead to kernel warning in some cases (which
> could be reproduced with the loongson driver).
>
> Change the implementation to add a check for the active state (atomic) /
> enabled state (non-atomic) before calling drm_vblank_get(). As the
> assumption of drm_vblank_get() failing for inactive CRTC isn't met, the
> error status of drm_vblank_get() can now be exported too.
>
> Cc: stable@vger.kernel.org
> Fixes: d8c4bddcd8bc ("drm/fb-helper: Synchronize dirty worker with vblank")
> Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> ---
>  drivers/gpu/drm/drm_client_modeset.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
> index bb49b8361271a..1b03bf351256e 100644
> --- a/drivers/gpu/drm/drm_client_modeset.c
> +++ b/drivers/gpu/drm/drm_client_modeset.c
> @@ -1310,7 +1310,7 @@ int drm_client_modeset_wait_for_vblank(struct drm_client_dev *client, unsigned i
>  {
>  	struct drm_device *dev = client->dev;
>  	struct drm_crtc *crtc;
> -	int ret;
> +	int ret = 0;
>  
>  	/*
>  	 * Rate-limit update frequency to vblank. If there's a DRM master
> @@ -1326,15 +1326,24 @@ int drm_client_modeset_wait_for_vblank(struct drm_client_dev *client, unsigned i
>  	 * Only wait for a vblank event if the CRTC is enabled, otherwise
>  	 * just don't do anything, not even report an error.
>  	 */

I'll dodge the question whether the change below is right or not, but
for sure the comment above needs to be amended to match the change.

(Please wait for other review comments before sending another version
with the comment changed.)

BR,
Jani.

> +	if (drm_drv_uses_atomic_modeset(dev)) {
> +		if (!crtc->state || !crtc->state->active)
> +			goto out;
> +	} else {
> +		if (!crtc->enabled)
> +			goto out;
> +	}
> +
>  	ret = drm_crtc_vblank_get(crtc);
>  	if (!ret) {
>  		drm_crtc_wait_one_vblank(crtc);
>  		drm_crtc_vblank_put(crtc);
>  	}
>  
> +out:
>  	drm_master_internal_release(dev);
>  
> -	return 0;
> +	return ret;
>  }
>  EXPORT_SYMBOL(drm_client_modeset_wait_for_vblank);

-- 
Jani Nikula, Intel

