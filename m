Return-Path: <stable+bounces-238016-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qu4hLckD32n2NgAAu9opvQ
	(envelope-from <stable+bounces-238016-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 05:19:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 972713FFEE2
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 05:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA15E3020A71
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 03:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FED320DD51;
	Wed, 15 Apr 2026 03:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="TdR0M9zB"
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37363217704
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 03:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776223173; cv=none; b=e2rILTXr5dxcGky9pE7KwQ0zOj9zV9Q4e7cwXV5YtY/BS2FFx5XxzjjkltIHxzXJEzSNIbpI4NuUN2RPkx8CYLqsr/GfNsuUdqBAgsGuSmJaP8z1U1Y/7b+abVQXwZgo8WIqMn9+adbR0Gz3eppRGjZg8nKxdBIbTahNXER+/sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776223173; c=relaxed/simple;
	bh=bveGzaCGG/3TSX3ZGn9CuDde5OVxrjL2M4WpSbVORg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Oz/CMgU4TvfX9/BQVDkAgH1UGwbENE2zTf/69iV1D4JmHoqqGCjp+o+dejY1nos2h68YhSwO0F6btkZi6lmMEDMAn+prGW2BdhftlP1yn8QzjcEUNqPr+dV3ED9dojpykFx3ZJAawHhbhYOsfbEkmx4sohv+iskd5mV+y8PzX1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=TdR0M9zB; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=l+fJwhZnDaRqjAPGBBygKMIeCQd+QtirtJFtlB4DpJI=;
	b=TdR0M9zBA2Q6D9ExGSEop+PpOhnkfBNnZhBCJ7nwZw4UstMfBnN9XKlt9MVuO1YcMekrunED7
	oecFOZ8yotzdf3V0b41haOpjYYY7CE3BzFAwB1Qe0IBz3Du1O+usYNT2UVilH6DX1xL6mOBgIkB
	odyiH88IEhf3nnTUQxEq8cY=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4fwR6g4D1lzpStx;
	Wed, 15 Apr 2026 11:13:15 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id A07D820104;
	Wed, 15 Apr 2026 11:19:27 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 15 Apr 2026 11:19:27 +0800
Received: from [10.159.167.44] (10.159.167.44) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 15 Apr 2026 11:19:26 +0800
Message-ID: <0668b6ec-b844-4fef-804c-91e488b39516@huawei.com>
Date: Wed, 15 Apr 2026 11:19:26 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drm/hibmc: Fix list of formats on the primary plane
To: Thomas Zimmermann <tzimmermann@suse.de>, <xinliang.liu@linaro.org>,
	<tiantao6@hisilicon.com>, <kong.kongxinwei@hisilicon.com>,
	<sumit.semwal@linaro.org>, <yongqin.liu@linaro.org>, <jstultz@google.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<airlied@gmail.com>, <simona@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, Rongrong Zou <zourongrong@gmail.com>,
	Sean Paul <seanpaul@chromium.org>, Dmitry Baryshkov <lumag@kernel.org>,
	Baihan Li <libaihan@huawei.com>, <stable@vger.kernel.org>,
	<shiyongbang@huawei.com>
References: <20260413085037.17491-1-tzimmermann@suse.de>
 <20260413085037.17491-3-tzimmermann@suse.de>
From: Yongbang Shi <shiyongbang@huawei.com>
In-Reply-To: <20260413085037.17491-3-tzimmermann@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemq100007.china.huawei.com (7.202.195.175)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238016-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[suse.de,linaro.org,hisilicon.com,google.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,gmail.com,chromium.org,kernel.org,huawei.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email,huawei.com:dkim,huawei.com:mid,linaro.org:email,chromium.org:email];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shiyongbang@huawei.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 972713FFEE2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Remove all formats from the primary plane that are unsupported for
> various reasons.
> 
> * Formats with alpha channel: planes should not announce alpha channels
> unless they support transparency. There's no transparency support in
> the primary plane's implementation.
> 
> * Formats with BGR order. The common format is in RGB channel order.
> There's no BGR support in the primary plane's implementation.
> 
> * RGB888: atomic_update programs the format from cpp[0] * 8 / 16. For
> RGB888's cpp value of 3 this returns 1.5; rounded to 1. Programming
> the value of 1 to HIBMC_CRT_DISP_CTL_FORMAT sets up RGB565. Hence, the
> output is distorted. This can be tested by booting with video=1024x768-24.
> 

I tested this method and was able to reproduce the issue. Thank you for
pointing it out.


> Removing all unsupported formats leaves XRGB8888 and RGB565. Both of
> which are supported and work correctly.
> 

You're right, I checked the DataSheet and confirmed that it only
supports RGB565 and XRGB8888.

Also, I looked at the commit history, and this format was already
present in the first version of the hibmc driver. This is a historic
issue, and it's a bit difficult to determine why it was implemented this
way.


> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: da52605eea8f ("drm/hisilicon/hibmc: Add support for display engine")
> Cc: Rongrong Zou <zourongrong@gmail.com>
> Cc: Sean Paul <seanpaul@chromium.org>
> Cc: Xinliang Liu <xinliang.liu@linaro.org>
> Cc: Dmitry Baryshkov <lumag@kernel.org>
> Cc: Yongbang Shi <shiyongbang@huawei.com>
> Cc: Baihan Li <libaihan@huawei.com>
> Cc: <stable@vger.kernel.org> # v4.10+
> ---
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
> index 8fa2a95bcdd1..c4f9ebd9250d 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
> @@ -118,10 +118,8 @@ static void hibmc_plane_atomic_update(struct drm_plane *plane,
>  }
>  
>  static const u32 channel_formats1[] = {
> -	DRM_FORMAT_RGB565, DRM_FORMAT_BGR565, DRM_FORMAT_RGB888,
> -	DRM_FORMAT_BGR888, DRM_FORMAT_XRGB8888, DRM_FORMAT_XBGR8888,
> -	DRM_FORMAT_RGBA8888, DRM_FORMAT_BGRA8888, DRM_FORMAT_ARGB8888,
> -	DRM_FORMAT_ABGR8888
> +	DRM_FORMAT_XRGB8888,
> +	DRM_FORMAT_RGB565,
>  };
>  
>  static const struct drm_plane_funcs hibmc_plane_funcs = {

Reviewed-by: Yongbang Shi <shiyongbang@huawei.com>


