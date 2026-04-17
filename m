Return-Path: <stable+bounces-238422-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHG5N8TR4WnQyQAAu9opvQ
	(envelope-from <stable+bounces-238422-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 08:23:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 599104175D9
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 08:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 634A531AF7B1
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 06:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A351736CDE8;
	Fri, 17 Apr 2026 06:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="s570TsgY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rhgN9YaQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="s570TsgY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rhgN9YaQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B837E36E468
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 06:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776406683; cv=none; b=U1xpIW/hYGvATV3ePJf4WYq5pp8Vwk45X1LcEHrykdJS+FJoFD3p1SIl7SPcvDESP6qP2mWrHuq0QmPBgcAJuYrFs6xEa6784e9qMR3pt+uOSXoOCJLp0eqEt/asparPC4ZCmlzFioFn4cFCUWrbPsb4nLOIg0MgpGl6N8E6VQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776406683; c=relaxed/simple;
	bh=uadvgaf6TR8bTc5nIUrJAfDh9B/jO14oeDy2OK40uJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iy74EslS//WwKeuMlHoMgJRnMFjpYKpb52KwvRQ3rPDO3H/5Z+aKpAF2Lt312fQGNcf3zYnvs8oAuE/ava5gH7cOSuYReXH66QcZRa3wd+Pl/ZDydjDUSVLrfOy7760WoZOK57beoycWb1e0QM7Bc2hBx3c/BZfDgSUI5BKW9FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=s570TsgY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rhgN9YaQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=s570TsgY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rhgN9YaQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B20725BD5A;
	Fri, 17 Apr 2026 06:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776406675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vF/g1RxnoC67U6Gdw0O+q+70x7Y8fx1UBEis0Zy5ZfM=;
	b=s570TsgYPLdFJ1rIchXJQipPVHqBDzH+qnSGrOQanSSEBNNrgVP13BvKfDDmZ5CcKUfqE2
	PdYuB5JBrNck4kHvsbSi2s2xcG7Pw0e4fjN2jixsi22wxP7RZ8SN8EN7vvnpl9+/CKCUE0
	rwzOuMPyJGp/XO3NYBUMgJnVFMiASyU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776406675;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vF/g1RxnoC67U6Gdw0O+q+70x7Y8fx1UBEis0Zy5ZfM=;
	b=rhgN9YaQWct27+QgwS1TQCk5jN9zSj6vmNkdOZIf7ZaFO7T+/DJvTVZZwkMk/oo+/gXJmb
	6ixjQ0LzM+SNJvAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776406675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vF/g1RxnoC67U6Gdw0O+q+70x7Y8fx1UBEis0Zy5ZfM=;
	b=s570TsgYPLdFJ1rIchXJQipPVHqBDzH+qnSGrOQanSSEBNNrgVP13BvKfDDmZ5CcKUfqE2
	PdYuB5JBrNck4kHvsbSi2s2xcG7Pw0e4fjN2jixsi22wxP7RZ8SN8EN7vvnpl9+/CKCUE0
	rwzOuMPyJGp/XO3NYBUMgJnVFMiASyU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776406675;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vF/g1RxnoC67U6Gdw0O+q+70x7Y8fx1UBEis0Zy5ZfM=;
	b=rhgN9YaQWct27+QgwS1TQCk5jN9zSj6vmNkdOZIf7ZaFO7T+/DJvTVZZwkMk/oo+/gXJmb
	6ixjQ0LzM+SNJvAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 313E0593AE;
	Fri, 17 Apr 2026 06:17:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JDSZCpPQ4WmdPAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 17 Apr 2026 06:17:55 +0000
Message-ID: <34ecfa0c-a6f5-48b0-b706-27e1f9868dd7@suse.de>
Date: Fri, 17 Apr 2026 08:17:54 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/hibmc: Use drm_atomic_helper_check_plane_state()
To: Yongbang Shi <shiyongbang@huawei.com>, tiantao6@hisilicon.com,
 kong.kongxinwei@hisilicon.com, sumit.semwal@linaro.org,
 yongqin.liu@linaro.org, jstultz@google.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, Rongrong Zou <zourongrong@gmail.com>,
 Sean Paul <seanpaul@chromium.org>, Dmitry Baryshkov <lumag@kernel.org>,
 stable@vger.kernel.org,
 "Liangjian(Jim,Kunpeng Solution Development Dept)"
 <liangjian010@huawei.com>, Chenjianmin <chenjianmin@huawei.com>,
 "fengsheng (A)" <fengsheng5@huawei.com>, "helin (T)" <helin52@h-partners.com>
References: <20260413085037.17491-1-tzimmermann@suse.de>
 <20260413085037.17491-2-tzimmermann@suse.de>
 <7fd5022a-9a5d-4976-9d4a-1e0fa2022eae@huawei.com>
 <1805a7d4-a4a0-48ee-ac6e-33e5d9d5fdc9@suse.de>
 <fffc172f-6bfe-4947-8f3b-52a1534b1d3b@huawei.com>
Content-Language: en-US
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <fffc172f-6bfe-4947-8f3b-52a1534b1d3b@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,gmail.com,chromium.org,kernel.org,vger.kernel.org,huawei.com,h-partners.com];
	TAGGED_FROM(0.00)[bounces-238422-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[huawei.com,hisilicon.com,linaro.org,google.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tzimmermann@suse.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:url,suse.com:url,huawei.com:email,suse.de:dkim,suse.de:mid]
X-Rspamd-Queue-Id: 599104175D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi

Am 16.04.26 um 15:22 schrieb Yongbang Shi:
[...]
> However, I believe the modified version is the better implementation,
> the plane check should be complete even if the CRTC is not enabled.

Great.

I agree that the logic in the helper is non-intuitive. I'll send you an 
updated series with an improved commit message next week.

Best regards
Thomas

>
> [1]
> https://elixir.bootlin.com/linux/v7.0/source/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c#L84
> [2]
> https://elixir.bootlin.com/linux/v7.0/source/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c#L94
>
>
>>
>>>
>>>> +    if (ret)
>>>> +        return ret;
>>>> +    else if (!new_plane_state->visible)
>>>>            return 0;
>>>>    -    if (new_plane_state->crtc_x + new_plane_state->crtc_w >
>>>> -        crtc_state->adjusted_mode.hdisplay ||
>>>> -        new_plane_state->crtc_y + new_plane_state->crtc_h >
>>>> -        crtc_state->adjusted_mode.vdisplay) {
>>>> -        drm_dbg_atomic(plane->dev, "visible portion of plane is
>>>> invalid\n");
>>>> -        return -EINVAL;
>>>> -    }
>>>> -
>>> The purpose of this check is to ensure that the right and bottom
>>> boundaries of the plane do not extend beyond the crtc. In
>>> `drm_atomic_helper_check_plane_state`, `drm_mode_get_hv_timing` is
>>> called to retrieve the crtc boundaries, and `drm_rect_clip_scaled` is
>>> used to clip the plane, any portions extending beyond the right and
>>> bottom boundaries are discarded.
>>>
>>> I'd like to confirm that my understanding is correct? previously, the
>>> check failed if the plane exceeded the boundaries, but now, after
>>> `drm_atomic_helper_check_plane_state` is called, the plane is clipped to
>>> fit within the boundaries.
>> Yes. This sets plane_state->dst, which is clipped to the size of the
>> display mode. But it also tests that the primary plane covers the whole
>> display.
>>
>>> in function drm_rect_clip_scaled:
>>>
>>> diff = dst->x2 - clip->x2;
>>> if (diff > 0) {
>>>      ...
>>>      dst->x2 -= diff;
>>> }
>>> diff = dst->y2 - clip->y2;
>>> if (diff > 0) {
>>>      ...
>>>      dst->y2 -= diff;
>>> }
>> I agree, the logic in drm_atomic_helper_check_plane_state() is hard to
>> understand. It sets the clip rectangle to the size of the display mode
>> (or zero if the CRTC is off) at [1].  Then is clips the source and
>> destination coordinates against the clipping rectangle at [2].
>>
>> Because we set can_position to false, it tests if the destination and
>> clipping rectangles are equal at [3]. This is similar to the that is
>> being replaced, but with plane state correctly adjusted. If both
>> rectangles are equal, it returns success. If the destination is too
>> small, it fails with an errno code and a warning.
>>
>> If the plane is not visible, the helper already returned at [4].
>>
>> [1] https://elixir.bootlin.com/linux/v7.0/source/drivers/gpu/drm/
>> drm_atomic_helper.c#L943
>> [2] https://elixir.bootlin.com/linux/v7.0/source/drivers/gpu/drm/
>> drm_atomic_helper.c#L945
>> [3] https://elixir.bootlin.com/linux/v7.0/source/drivers/gpu/drm/
>> drm_atomic_helper.c#L959
>> [4] https://elixir.bootlin.com/linux/v7.0/source/drivers/gpu/drm/
>> drm_atomic_helper.c#L949
>>
>> It is now possible to have a primary plane that is larger than the
>> display mode. This is a feature of the DRM API.
>>
> Thank you so much for the explanation. It's much clearer to understand
> drm_atomic_helper_check_plane_state.
>
> By the way, we ran some basic tests on this set of patches using the
> latest BMC chip, and everything worked fine.
>
>
> Thanks.
>
> Best regards
> Yongbang.
>
>
>> Best regards
>> Thomas
>>
>>
>>>
>>> Thanks.
>>>
>>> Best regards
>>> Yongbang.
>>>
>>>
>>>>        if (new_plane_state->fb->pitches[0] % 128 != 0) {
>>>>            drm_dbg_atomic(plane->dev, "wrong stride with 128-byte
>>>> aligned\n");
>>>>            return -EINVAL;
>>>>        }
>>>> +
>>>>        return 0;
>>>>    }
>>>>    
> Reviewed-by: Yongbang Shi <shiyongbang@huawei.com>
>
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)



