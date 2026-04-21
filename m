Return-Path: <stable+bounces-240073-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGdsA8st52lg5AEAu9opvQ
	(envelope-from <stable+bounces-240073-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 09:56:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EB2437E54
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 09:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8DCC300AB12
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 07:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EB53446B7;
	Tue, 21 Apr 2026 07:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Sxucc7Vg"
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A84D279DC9
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 07:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776758214; cv=none; b=u9z1+3AyYEf9YDWEtnswgo9oZU5zRPgmVvo1i3ETdgfMzi9cQ8XT2q5cGhKSa7e+ao59w7hNDrHxItuxZwo5eqiX/hnaq2l9FcHkJmXkrhD0bb92dC6/ns4CXxYK+31k/NJ+FGoz3xZiMkEmijDd1yq4idsL9uVBQFLkPg5+628=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776758214; c=relaxed/simple;
	bh=fMb1XA2kNWZN4UXG8TOX9i5S+GQy9nVu7bx3dePORDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=h0CtqPjx0Qt6BdgaKWgyZ4/fEhXJzUAX/G6Gq/s9O2aEIIti65jPejF1nyxrvnx/CyZFR+5VZqcYvG0WmCYnJjdv+I6nF3cR55C1A0smy4wbPttCig7rjMQdzmw+SbBag72zyrxteUyJC1R3dyUALqfpqzolTWVe9BaG7nwQS7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Sxucc7Vg; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=UQ/O7Ksa/m+RxlB6FRtoMDjiJJ3w54XrXWQLzeVLLUU=;
	b=Sxucc7VgYw180gKWeOpTWacw38DRhIcpymrLlhre7Kf11Q7zajHZ7shAqpz3oHJ9lmPHlcQ+R
	erFu/CDp26VwOca/FGzmR+NH5VzT4ZW9UfB5fl3fXbfemiOadfDcHprywJ7G2jCW/g/hsF1dQHh
	gF9sH0gZbrhfwHr8LgjsQ+U=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4g0Dzd4jcYzRhRV;
	Tue, 21 Apr 2026 15:50:21 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 9AD0940538;
	Tue, 21 Apr 2026 15:56:43 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Apr 2026 15:56:43 +0800
Received: from [10.159.167.44] (10.159.167.44) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Apr 2026 15:56:42 +0800
Message-ID: <ea18dc58-3607-4e84-b5a2-eb582c10e307@huawei.com>
Date: Tue, 21 Apr 2026 15:56:42 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] drm/hibmc: Use
 drm_atomic_helper_check_plane_state()
To: Thomas Zimmermann <tzimmermann@suse.de>, <xinliang.liu@linaro.org>,
	<tiantao6@hisilicon.com>, <kong.kongxinwei@hisilicon.com>,
	<sumit.semwal@linaro.org>, <yongqin.liu@linaro.org>, <jstultz@google.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<airlied@gmail.com>, <simona@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, Rongrong Zou <zourongrong@gmail.com>,
	Sean Paul <seanpaul@chromium.org>, Dmitry Baryshkov <lumag@kernel.org>,
	Baihan Li <libaihan@huawei.com>, <stable@vger.kernel.org>,
	<shiyongbang@huawei.com>, "Liangjian(Jim,Kunpeng Solution Development Dept)"
	<liangjian010@huawei.com>, Chenjianmin <chenjianmin@huawei.com>, "fengsheng
 (A)" <fengsheng5@huawei.com>
References: <20260420121130.200133-1-tzimmermann@suse.de>
 <20260420121130.200133-2-tzimmermann@suse.de>
From: Yongbang Shi <shiyongbang@huawei.com>
In-Reply-To: <20260420121130.200133-2-tzimmermann@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemq100007.china.huawei.com (7.202.195.175)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240073-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[suse.de,linaro.org,hisilicon.com,google.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,gmail.com,chromium.org,kernel.org,huawei.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,huawei.com:dkim,huawei.com:mid,linaro.org:email,chromium.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:email];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 60EB2437E54
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


> Call drm_atomic_helper_check_plane_state() from the primary plane's
> atomic-check helper and replace the custom implementation.
> 
> All plane's implementations of atomic_check should call the shared
> _check_plane_state() helper first. It adjusts the plane state for
> correct positioning, rotation and scaling of the plane. Do this
> even if the plane's CRTC has been disabled by setting the parameter
> can_update_disabled. The original code returned early in this case,
> but it's safe to so and cleaner to have all plane state initialized.
> 
> As we don't set can_position, drm_atomic_helper_check_plane_state()'s
> visibility check tests if the plane covers all of the CRTC. This is
> a small change from the original code, which tested if the plane is
> exactly the size of the CRTC. With the new test, the plane still has
> to cover all of the CRTC, but can be larger than the CRTC's size. A
> later patch can fully implement this feature in hibmc.
> 
> If the plane is disabled, the helper clears the visibility flag in the
> plane state. On errors or if the plane is not visible, the atomic-check
> helper can return early. Implement all this in hibmc and drop the custom
> code that does some of it.
> > v2:
> - extend the commit description (Yongbang)
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: da52605eea8f ("drm/hisilicon/hibmc: Add support for display engine")
> Cc: Rongrong Zou <zourongrong@gmail.com>
> Cc: Sean Paul <seanpaul@chromium.org>
> Cc: Xinliang Liu <xinliang.liu@linaro.org>
> Cc: Dmitry Baryshkov <lumag@kernel.org>
> Cc: Baihan Li <libaihan@huawei.com>
> Cc: Yongbang Shi <shiyongbang@huawei.com>
> Cc: <stable@vger.kernel.org> # v4.10+
> ---
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_de.c    | 46 ++++++-------------
>  1 file changed, 14 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
> index 89bed78f1466..8fa2a95bcdd1 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
> @@ -55,46 +55,28 @@ static const struct hibmc_dislay_pll_config hibmc_pll_table[] = {
>  static int hibmc_plane_atomic_check(struct drm_plane *plane,
>  				    struct drm_atomic_state *state)
>  {
> -	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
> -										 plane);
> -	struct drm_framebuffer *fb = new_plane_state->fb;
> -	struct drm_crtc *crtc = new_plane_state->crtc;
> -	struct drm_crtc_state *crtc_state;
> -	u32 src_w = new_plane_state->src_w >> 16;
> -	u32 src_h = new_plane_state->src_h >> 16;
> -
> -	if (!crtc || !fb)
> -		return 0;
> +	struct drm_plane_state *new_plane_state =
> +		drm_atomic_get_new_plane_state(state, plane);
> +	struct drm_crtc_state *new_crtc_state = NULL;
> +	int ret;
>  
> -	crtc_state = drm_atomic_get_crtc_state(state, crtc);
> -	if (IS_ERR(crtc_state))
> -		return PTR_ERR(crtc_state);
> +	if (new_plane_state->crtc)
> +		new_crtc_state = drm_atomic_get_new_crtc_state(state, new_plane_state->crtc);
>  
> -	if (src_w != new_plane_state->crtc_w || src_h != new_plane_state->crtc_h) {
> -		drm_dbg_atomic(plane->dev, "scale not support\n");
> -		return -EINVAL;
> -	}
> -
> -	if (new_plane_state->crtc_x < 0 || new_plane_state->crtc_y < 0) {
> -		drm_dbg_atomic(plane->dev, "crtc_x/y of drm_plane state is invalid\n");
> -		return -EINVAL;
> -	}
> -
> -	if (!crtc_state->enable)
> +	ret = drm_atomic_helper_check_plane_state(new_plane_state, new_crtc_state,
> +						  DRM_PLANE_NO_SCALING,
> +						  DRM_PLANE_NO_SCALING,
> +						  false, true);
> +	if (ret)
> +		return ret;
> +	else if (!new_plane_state->visible)
>  		return 0;
>  
> -	if (new_plane_state->crtc_x + new_plane_state->crtc_w >
> -	    crtc_state->adjusted_mode.hdisplay ||
> -	    new_plane_state->crtc_y + new_plane_state->crtc_h >
> -	    crtc_state->adjusted_mode.vdisplay) {
> -		drm_dbg_atomic(plane->dev, "visible portion of plane is invalid\n");
> -		return -EINVAL;
> -	}
> -
>  	if (new_plane_state->fb->pitches[0] % 128 != 0) {
>  		drm_dbg_atomic(plane->dev, "wrong stride with 128-byte aligned\n");
>  		return -EINVAL;
>  	}
> +
>  	return 0;
>  }
>

Reviewed-by: Yongbang Shi <shiyongbang@huawei.com>





