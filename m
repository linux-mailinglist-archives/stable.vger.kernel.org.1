Return-Path: <stable+bounces-238436-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDkCBo7c4WmtzAAAu9opvQ
	(envelope-from <stable+bounces-238436-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 09:09:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4176417B8B
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 09:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 43EC6301D080
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 07:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4211133970F;
	Fri, 17 Apr 2026 07:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="r0E/a2T3"
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2DB335554
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 07:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776409736; cv=none; b=DtbY6Yl2k2PgwhJEOdJklTGwgjeoHVYpee0sX/ZTMDGtEBZR1BYiOkrdDXT/7EYYn9NFSTQaIzQ4z30ZpMJQXxlRfQU65k8Iu/Omykn7ZaybCi0EvHJGahSbRPKoBJnpmoiWrHQOlW6r0sKLTKQyR8kJrKta9WlZ+caS4nrL56g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776409736; c=relaxed/simple;
	bh=9KzfsTm0he9JI8a6BqIH7q/TIGWJYCMNf9XGtAkl5Us=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sY7wQIY3iHS75sZrKuPUPEyn/By+Blfir53jAVA8ilB8Lff9vQqbO8Ys7qxTP05OcxgS2VF7gki4kNAZfCdodQo0kqAsXTsrrhDTQoqivROM51YfUiC2fV5lqOlMBZMgJHnHqoXE+m1mdz4dMm+gDjr0pPIb9Gr8GNUwFdERw2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=r0E/a2T3; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=pzBLAWMzasZLljpmq7lbj2ABnUU+Y1nf8FDUPyoPiNA=;
	b=r0E/a2T3VlqKtj5pItApGfhv8ZkQUnvCfSmrN+X9OXPnXWhmE7sKS599EO3f/we3F8ZvPm5LL
	qNYtnd52KIGNGixM115H/KvGxPl6w5KIM3DueYSJ8lLRLgHLnbGPsIRxW/Z4aNHMSohxnXJSZtn
	gUfbqaHA5hoSxJaedZHsGl4=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4fxm6H0JM6z1cyQc;
	Fri, 17 Apr 2026 15:02:31 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id BCED74061D;
	Fri, 17 Apr 2026 15:08:49 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 17 Apr 2026 15:08:49 +0800
Received: from [10.159.167.44] (10.159.167.44) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 17 Apr 2026 15:08:48 +0800
Message-ID: <93568f17-2eeb-47bf-96b6-ccadec00e84c@huawei.com>
Date: Fri, 17 Apr 2026 15:08:48 +0800
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
 (A)" <fengsheng5@huawei.com>, "helin (T)" <helin52@h-partners.com>,
	<shiyongbang@huawei.com>
References: <20260413085037.17491-1-tzimmermann@suse.de>
 <20260413085037.17491-2-tzimmermann@suse.de>
 <7fd5022a-9a5d-4976-9d4a-1e0fa2022eae@huawei.com>
 <1805a7d4-a4a0-48ee-ac6e-33e5d9d5fdc9@suse.de>
 <fffc172f-6bfe-4947-8f3b-52a1534b1d3b@huawei.com>
 <34ecfa0c-a6f5-48b0-b706-27e1f9868dd7@suse.de>
From: Yongbang Shi <shiyongbang@huawei.com>
In-Reply-To: <34ecfa0c-a6f5-48b0-b706-27e1f9868dd7@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemq100007.china.huawei.com (7.202.195.175)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238436-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[suse.de,hisilicon.com,linaro.org,google.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,gmail.com,chromium.org,kernel.org,vger.kernel.org,huawei.com,h-partners.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shiyongbang@huawei.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[huawei.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D4176417B8B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


> Hi
> 
> Am 16.04.26 um 15:22 schrieb Yongbang Shi:
> [...]
>> However, I believe the modified version is the better implementation,
>> the plane check should be complete even if the CRTC is not enabled.
> 
> Great.
> 
> I agree that the logic in the helper is non-intuitive. I'll send you an
> updated series with an improved commit message next week.
> 

Looking forward to the updated series next week, and I appreciate the
improved commit message as well.

Thanks,
Yongbang.

> Best regards
> Thomas
> 
>>
>> [1]
>> https://elixir.bootlin.com/linux/v7.0/source/drivers/gpu/drm/
>> hisilicon/hibmc/hibmc_drm_de.c#L84
>> [2]
>> https://elixir.bootlin.com/linux/v7.0/source/drivers/gpu/drm/
>> hisilicon/hibmc/hibmc_drm_de.c#L94
>>
>>
>>>
>>>>
>>>>> +    if (ret)
>>>>> +        return ret;
>>>>> +    else if (!new_plane_state->visible)
>>>>>            return 0;
>>>>>    -    if (new_plane_state->crtc_x + new_plane_state->crtc_w >
>>>>> -        crtc_state->adjusted_mode.hdisplay ||
>>>>> -        new_plane_state->crtc_y + new_plane_state->crtc_h >
>>>>> -        crtc_state->adjusted_mode.vdisplay) {
>>>>> -        drm_dbg_atomic(plane->dev, "visible portion of plane is
>>>>> invalid\n");
>>>>> -        return -EINVAL;
>>>>> -    }
>>>>> -
>>>> The purpose of this check is to ensure that the right and bottom
>>>> boundaries of the plane do not extend beyond the crtc. In
>>>> `drm_atomic_helper_check_plane_state`, `drm_mode_get_hv_timing` is
>>>> called to retrieve the crtc boundaries, and `drm_rect_clip_scaled` is
>>>> used to clip the plane, any portions extending beyond the right and
>>>> bottom boundaries are discarded.
>>>>
>>>> I'd like to confirm that my understanding is correct? previously, the
>>>> check failed if the plane exceeded the boundaries, but now, after
>>>> `drm_atomic_helper_check_plane_state` is called, the plane is
>>>> clipped to
>>>> fit within the boundaries.
>>> Yes. This sets plane_state->dst, which is clipped to the size of the
>>> display mode. But it also tests that the primary plane covers the whole
>>> display.
>>>
>>>> in function drm_rect_clip_scaled:
>>>>
>>>> diff = dst->x2 - clip->x2;
>>>> if (diff > 0) {
>>>>      ...
>>>>      dst->x2 -= diff;
>>>> }
>>>> diff = dst->y2 - clip->y2;
>>>> if (diff > 0) {
>>>>      ...
>>>>      dst->y2 -= diff;
>>>> }
>>> I agree, the logic in drm_atomic_helper_check_plane_state() is hard to
>>> understand. It sets the clip rectangle to the size of the display mode
>>> (or zero if the CRTC is off) at [1].  Then is clips the source and
>>> destination coordinates against the clipping rectangle at [2].
>>>
>>> Because we set can_position to false, it tests if the destination and
>>> clipping rectangles are equal at [3]. This is similar to the that is
>>> being replaced, but with plane state correctly adjusted. If both
>>> rectangles are equal, it returns success. If the destination is too
>>> small, it fails with an errno code and a warning.
>>>
>>> If the plane is not visible, the helper already returned at [4].
>>>
>>> [1] https://elixir.bootlin.com/linux/v7.0/source/drivers/gpu/drm/
>>> drm_atomic_helper.c#L943
>>> [2] https://elixir.bootlin.com/linux/v7.0/source/drivers/gpu/drm/
>>> drm_atomic_helper.c#L945
>>> [3] https://elixir.bootlin.com/linux/v7.0/source/drivers/gpu/drm/
>>> drm_atomic_helper.c#L959
>>> [4] https://elixir.bootlin.com/linux/v7.0/source/drivers/gpu/drm/
>>> drm_atomic_helper.c#L949
>>>
>>> It is now possible to have a primary plane that is larger than the
>>> display mode. This is a feature of the DRM API.
>>>
>> Thank you so much for the explanation. It's much clearer to understand
>> drm_atomic_helper_check_plane_state.
>>
>> By the way, we ran some basic tests on this set of patches using the
>> latest BMC chip, and everything worked fine.
>>
>>
>> Thanks.
>>
>> Best regards
>> Yongbang.
>>
>>
>>> Best regards
>>> Thomas
>>>
>>>
>>>>
>>>> Thanks.
>>>>
>>>> Best regards
>>>> Yongbang.
>>>>
>>>>
>>>>>        if (new_plane_state->fb->pitches[0] % 128 != 0) {
>>>>>            drm_dbg_atomic(plane->dev, "wrong stride with 128-byte
>>>>> aligned\n");
>>>>>            return -EINVAL;
>>>>>        }
>>>>> +
>>>>>        return 0;
>>>>>    }
>>>>>    
>> Reviewed-by: Yongbang Shi <shiyongbang@huawei.com>
>>
>>
> 


