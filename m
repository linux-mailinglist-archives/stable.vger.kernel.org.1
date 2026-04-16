Return-Path: <stable+bounces-238310-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EOsNTvk4GlhnAAAu9opvQ
	(envelope-from <stable+bounces-238310-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 15:29:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F1F40ED4F
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 15:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 780B330FAA27
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 13:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2545B1B4156;
	Thu, 16 Apr 2026 13:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="WocJTjmp"
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D2770809
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 13:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776345779; cv=none; b=VRcLPjRWA6BhRDJJ9iSsu6WmvgQHnnXWmUkief8baVhRrgQSCSe1N3MR9u7JUG06DkzVv6tLGblzHhjmjXdQECFCNHhNvKR8Ipav0nnOPeAY90hP8Z7CsfxwHAlO1NbsbgCjo53r3dHWf6iyjtTox2N5BEf4wHUbM2bbOMklQvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776345779; c=relaxed/simple;
	bh=JBNbwzRPqWG2QlS27hon4GDi3BP5J2C7MIVnXt40ecs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=h/m1TX6hrGjFcqy0aASK6h8tHsPnlKixCDyoEgGqcOk43ziYRrBt2XQn6pCnYw1CoJq7NJX0UvdAwPnGSE1Ql3lXKWXnSlAWzmFLwHYivnJQFtGe/xU1i1dvM5WxU2tbPMfLMkpkhIfEgjSKBM157aVDyROgNGD1YFxAQiEiBao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=WocJTjmp; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Pwlh0abOnFff5n5KRi3X7bo6L3aBYfKagCs00mSYgO8=;
	b=WocJTjmp2A1CJyQk5au/RTseLJr20e11Sv+iLpf7xPiN0KbfYhitSohvGXsqrF5iMZLsfHPqK
	9IX1D2b4v8WGQcS/BhGOS8AMTIHinRe65EHiJ8QRz/Awu9gP5vnO0J2u3Sb4gDsetXI//rnEo8p
	f6ycpMC9+KNO5VNjueQcYwI=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4fxJSM73FQz1K9D8;
	Thu, 16 Apr 2026 21:16:35 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id C541940539;
	Thu, 16 Apr 2026 21:22:52 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 16 Apr 2026 21:22:52 +0800
Received: from [10.159.167.44] (10.159.167.44) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 16 Apr 2026 21:22:51 +0800
Message-ID: <fffc172f-6bfe-4947-8f3b-52a1534b1d3b@huawei.com>
Date: Thu, 16 Apr 2026 21:22:51 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/hibmc: Use drm_atomic_helper_check_plane_state()
To: Thomas Zimmermann <tzimmermann@suse.de>, <tiantao6@hisilicon.com>,
	<kong.kongxinwei@hisilicon.com>, <sumit.semwal@linaro.org>,
	<yongqin.liu@linaro.org>, <jstultz@google.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<airlied@gmail.com>, <simona@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, Rongrong Zou <zourongrong@gmail.com>,
	Sean Paul <seanpaul@chromium.org>, Dmitry Baryshkov <lumag@kernel.org>,
	<stable@vger.kernel.org>, "Liangjian(Jim,Kunpeng Solution Development Dept)"
	<liangjian010@huawei.com>, Chenjianmin <chenjianmin@huawei.com>, "fengsheng
 (A)" <fengsheng5@huawei.com>, "helin (T)" <helin52@h-partners.com>
References: <20260413085037.17491-1-tzimmermann@suse.de>
 <20260413085037.17491-2-tzimmermann@suse.de>
 <7fd5022a-9a5d-4976-9d4a-1e0fa2022eae@huawei.com>
 <1805a7d4-a4a0-48ee-ac6e-33e5d9d5fdc9@suse.de>
From: Yongbang Shi <shiyongbang@huawei.com>
In-Reply-To: <1805a7d4-a4a0-48ee-ac6e-33e5d9d5fdc9@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemq100007.china.huawei.com (7.202.195.175)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238310-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[suse.de,hisilicon.com,linaro.org,google.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,gmail.com,chromium.org,kernel.org,vger.kernel.org,huawei.com,h-partners.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:email,huawei.com:email,huawei.com:dkim,huawei.com:mid,bootlin.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:email];
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
X-Rspamd-Queue-Id: 38F1F40ED4F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


> Hi
> 
> Am 16.04.26 um 08:53 schrieb Yongbang Shi:
>>> Call drm_atomic_helper_check_plane_state() from the primary plane's
>>> atomic-check helper and replace the custom implementation.
>>>
>>> All plane's implementations of atomic_check should call the shared
>>> _check_plane_state() helper first. It adjusts the plane state for
>>> correct positioning, rotation and scaling of the plane. If the plane
>>> is not visible, it clears the corresponding flag in the plane state.
>>>
>>> On errors or if the plane is not visible, the atomic-check helper can
>>> return early. Implement all this in hibmc and drop the custom code
>>> that does some of it.
>>>
>>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>>> Fixes: da52605eea8f ("drm/hisilicon/hibmc: Add support for display
>>> engine")
>>> Cc: Rongrong Zou <zourongrong@gmail.com>
>>> Cc: Sean Paul <seanpaul@chromium.org>
>>> Cc: Xinliang Liu <xinliang.liu@linaro.org>
>>> Cc: Dmitry Baryshkov <lumag@kernel.org>
>>> Cc: Baihan Li <libaihan@huawei.com>
>>> Cc: Yongbang Shi <shiyongbang@huawei.com>
>>> Cc: <stable@vger.kernel.org> # v4.10+
>>> ---
>>>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_de.c    | 46 ++++++-------------
>>>   1 file changed, 14 insertions(+), 32 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c b/
>>> drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
>>> index 89bed78f1466..8fa2a95bcdd1 100644
>>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
>>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
>>> @@ -55,46 +55,28 @@ static const struct hibmc_dislay_pll_config
>>> hibmc_pll_table[] = {
>>>   static int hibmc_plane_atomic_check(struct drm_plane *plane,
>>>                       struct drm_atomic_state *state)
>>>   {
>>> -    struct drm_plane_state *new_plane_state =
>>> drm_atomic_get_new_plane_state(state,
>>> -                                         plane);
>>> -    struct drm_framebuffer *fb = new_plane_state->fb;
>>> -    struct drm_crtc *crtc = new_plane_state->crtc;
>>> -    struct drm_crtc_state *crtc_state;
>>> -    u32 src_w = new_plane_state->src_w >> 16;
>>> -    u32 src_h = new_plane_state->src_h >> 16;
>>> -
>>> -    if (!crtc || !fb)
>>> -        return 0;
>>> +    struct drm_plane_state *new_plane_state =
>>> +        drm_atomic_get_new_plane_state(state, plane);
>>> +    struct drm_crtc_state *new_crtc_state = NULL;
>>> +    int ret;
>>>   -    crtc_state = drm_atomic_get_crtc_state(state, crtc);
>>> -    if (IS_ERR(crtc_state))
>>> -        return PTR_ERR(crtc_state);
>>> +    if (new_plane_state->crtc)
>>> +        new_crtc_state = drm_atomic_get_new_crtc_state(state,
>>> new_plane_state->crtc);
>>>   -    if (src_w != new_plane_state->crtc_w || src_h !=
>>> new_plane_state->crtc_h) {
>>> -        drm_dbg_atomic(plane->dev, "scale not support\n");
>>> -        return -EINVAL;
>>> -    }
>>> -
>>> -    if (new_plane_state->crtc_x < 0 || new_plane_state->crtc_y < 0) {
>>> -        drm_dbg_atomic(plane->dev, "crtc_x/y of drm_plane state is
>>> invalid\n");
>>> -        return -EINVAL;
>>> -    }
>>> -
>>> -    if (!crtc_state->enable)
>>> +    ret = drm_atomic_helper_check_plane_state(new_plane_state,
>>> new_crtc_state,
>>> +                          DRM_PLANE_NO_SCALING,
>>> +                          DRM_PLANE_NO_SCALING,
>>> +                          false, true);
>> The last parameter, "can_update_disabled", if set to true, causes the
>> condition "if (!crtc_state->enable && !can_update_disabled)" in the
>> function `drm_atomic_helper_check_plane_state` to always evaluate to
>> false, meaning `crtc_state->enable` will not be checked. This differs
>> from the behavior prior to the modification.
>>
>> before:
>>     - crtc_state->enable(true)  --> continue check
>>     - crtc_state->enable(false) --> return 0(atomic check success)
>>
>> after:
>>     - crtc_state->enable(true)   --> _helper_check_plane_ ->  continue
>> check
>>     - crtc_state->enable(false)  --> _helper_check_plane_ ->  continue
>> check
> 
> Isn't this what the hardware supports? The plane's hardware registers
> can be updated even if the plane's CRTC is off?
> 

Sure, The plane's hardware registers could be update after disable
plane's crtc.

> In the old case, atomic check returned success. If we set
> can_update_disable to false, it would return an error in such as case. 
> Settings it ti true keeps the success for disabled CRTCs. The semantics
> of the returned value don't change. It's just that the helper fills a
> few more fields in drm_plane_state.
> 

Yes, can_update_disable couldn't be false.

I just wanted to confirm this change. There is a slight difference
between the original code and the modified version. In the original
code, at location [1], it returns "check success" directly without
checking the subsequent "new_plane_state->fb->pitches[0]" at [2],
whereas the modified version continues to perform the full check.

However, I believe the modified version is the better implementation,
the plane check should be complete even if the CRTC is not enabled.

[1]
https://elixir.bootlin.com/linux/v7.0/source/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c#L84
[2]
https://elixir.bootlin.com/linux/v7.0/source/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c#L94


> 
> 
>>
>>
>>> +    if (ret)
>>> +        return ret;
>>> +    else if (!new_plane_state->visible)
>>>           return 0;
>>>   -    if (new_plane_state->crtc_x + new_plane_state->crtc_w >
>>> -        crtc_state->adjusted_mode.hdisplay ||
>>> -        new_plane_state->crtc_y + new_plane_state->crtc_h >
>>> -        crtc_state->adjusted_mode.vdisplay) {
>>> -        drm_dbg_atomic(plane->dev, "visible portion of plane is
>>> invalid\n");
>>> -        return -EINVAL;
>>> -    }
>>> -
>> The purpose of this check is to ensure that the right and bottom
>> boundaries of the plane do not extend beyond the crtc. In
>> `drm_atomic_helper_check_plane_state`, `drm_mode_get_hv_timing` is
>> called to retrieve the crtc boundaries, and `drm_rect_clip_scaled` is
>> used to clip the plane, any portions extending beyond the right and
>> bottom boundaries are discarded.
>>
>> I'd like to confirm that my understanding is correct? previously, the
>> check failed if the plane exceeded the boundaries, but now, after
>> `drm_atomic_helper_check_plane_state` is called, the plane is clipped to
>> fit within the boundaries.
> 
> Yes. This sets plane_state->dst, which is clipped to the size of the
> display mode. But it also tests that the primary plane covers the whole
> display.
> 
>>
>> in function drm_rect_clip_scaled:
>>
>> diff = dst->x2 - clip->x2;
>> if (diff > 0) {
>>     ...
>>     dst->x2 -= diff;
>> }
>> diff = dst->y2 - clip->y2;
>> if (diff > 0) {
>>     ...
>>     dst->y2 -= diff;
>> }
> 
> I agree, the logic in drm_atomic_helper_check_plane_state() is hard to
> understand. It sets the clip rectangle to the size of the display mode
> (or zero if the CRTC is off) at [1].  Then is clips the source and
> destination coordinates against the clipping rectangle at [2].
> 
> Because we set can_position to false, it tests if the destination and
> clipping rectangles are equal at [3]. This is similar to the that is
> being replaced, but with plane state correctly adjusted. If both
> rectangles are equal, it returns success. If the destination is too
> small, it fails with an errno code and a warning.
> 
> If the plane is not visible, the helper already returned at [4].
> 
> [1] https://elixir.bootlin.com/linux/v7.0/source/drivers/gpu/drm/
> drm_atomic_helper.c#L943
> [2] https://elixir.bootlin.com/linux/v7.0/source/drivers/gpu/drm/
> drm_atomic_helper.c#L945
> [3] https://elixir.bootlin.com/linux/v7.0/source/drivers/gpu/drm/
> drm_atomic_helper.c#L959
> [4] https://elixir.bootlin.com/linux/v7.0/source/drivers/gpu/drm/
> drm_atomic_helper.c#L949
> 
> It is now possible to have a primary plane that is larger than the
> display mode. This is a feature of the DRM API.
> 

Thank you so much for the explanation. It's much clearer to understand
drm_atomic_helper_check_plane_state.

By the way, we ran some basic tests on this set of patches using the
latest BMC chip, and everything worked fine.


Thanks.

Best regards
Yongbang.


> Best regards
> Thomas
> 
> 
>>
>>
>> Thanks.
>>
>> Best regards
>> Yongbang.
>>
>>
>>>       if (new_plane_state->fb->pitches[0] % 128 != 0) {
>>>           drm_dbg_atomic(plane->dev, "wrong stride with 128-byte
>>> aligned\n");
>>>           return -EINVAL;
>>>       }
>>> +
>>>       return 0;
>>>   }
>>>   
> 

Reviewed-by: Yongbang Shi <shiyongbang@huawei.com>



