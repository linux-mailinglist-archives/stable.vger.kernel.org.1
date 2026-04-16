Return-Path: <stable+bounces-238289-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBmCMgyw4GkRkwAAu9opvQ
	(envelope-from <stable+bounces-238289-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 11:46:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B23540C96F
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 11:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 776DC318433B
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 09:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D96372B4F;
	Thu, 16 Apr 2026 09:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OjB2r7bf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="71hEbbXv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OjB2r7bf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="71hEbbXv"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBF02D0603
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 09:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776332509; cv=none; b=p0HPp7SqdIgeLLs6Cy3kaKqgXb1AgBsN9pfVwJBXVr1aPj9CNoTH4mh9EIbUntG5FFi60oPrI4GaNmoAWCZZueq6fdYcG8heRJmKFxOX1nIdL0/mGgujWBTa1yZRWgKoBKo9mwIO9+XKq1RXzZlr5eIgXsd45MLyGCwCNNA3QKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776332509; c=relaxed/simple;
	bh=fb+TXaoetDBcYapqv37LV7giL5KgcBX/+pHXg9+hqpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mcvI55tn+ue2v5VNWrWRZz3lFVttDThiu6HxG+ooALox6L77fw60hJi3OPR4FUBYy1l+MbVuTDerW7jbnf6ac0rA7exSCfrtYV7fsByOeBoAVHlucCn5PpUDAoTKh+3dbu2Ad3YiEDHeKkyYb4lzdUiFbTIOfWLuowoLNBYjeEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OjB2r7bf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=71hEbbXv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OjB2r7bf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=71hEbbXv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0CFAC6A7F4;
	Thu, 16 Apr 2026 09:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776332506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Hh76HKGGEAlo+atWjMCKYJIGIzrcjr+dYrwWi459E7Q=;
	b=OjB2r7bfPcIyYfQYotQKQmJCiRMtr54bwA1gKjnn/yWHUvT2fbVDFywOjvm98ry9RfDXyO
	TYIldr/BrH28+ouVXCbbPafbQUOrJ/fyoxCjHdK/itRuRM5SMT/1mbBqhXiIMmv8gfJm27
	1ZYYKvB0eoe+Gx6JLQgZPOMgK0u/CRU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776332506;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Hh76HKGGEAlo+atWjMCKYJIGIzrcjr+dYrwWi459E7Q=;
	b=71hEbbXvGGjINEQL8lmQzHOOCHCJSlljOUeHTgY5lvWyqhyznUG6PuWvIFKU1nI3yyM4IG
	aM4BTUk5ytNlqEDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776332506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Hh76HKGGEAlo+atWjMCKYJIGIzrcjr+dYrwWi459E7Q=;
	b=OjB2r7bfPcIyYfQYotQKQmJCiRMtr54bwA1gKjnn/yWHUvT2fbVDFywOjvm98ry9RfDXyO
	TYIldr/BrH28+ouVXCbbPafbQUOrJ/fyoxCjHdK/itRuRM5SMT/1mbBqhXiIMmv8gfJm27
	1ZYYKvB0eoe+Gx6JLQgZPOMgK0u/CRU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776332506;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Hh76HKGGEAlo+atWjMCKYJIGIzrcjr+dYrwWi459E7Q=;
	b=71hEbbXvGGjINEQL8lmQzHOOCHCJSlljOUeHTgY5lvWyqhyznUG6PuWvIFKU1nI3yyM4IG
	aM4BTUk5ytNlqEDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A9944BEC2;
	Thu, 16 Apr 2026 09:41:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dmLsH9mu4Gl9dwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 16 Apr 2026 09:41:45 +0000
Message-ID: <1805a7d4-a4a0-48ee-ac6e-33e5d9d5fdc9@suse.de>
Date: Thu, 16 Apr 2026 11:41:45 +0200
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
 "fengsheng (A)" <fengsheng5@huawei.com>
References: <20260413085037.17491-1-tzimmermann@suse.de>
 <20260413085037.17491-2-tzimmermann@suse.de>
 <7fd5022a-9a5d-4976-9d4a-1e0fa2022eae@huawei.com>
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
In-Reply-To: <7fd5022a-9a5d-4976-9d4a-1e0fa2022eae@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,gmail.com,chromium.org,kernel.org,vger.kernel.org,huawei.com];
	TAGGED_FROM(0.00)[bounces-238289-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[huawei.com,hisilicon.com,linaro.org,google.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:url,huawei.com:email,suse.de:email,suse.de:dkim,suse.de:mid,linaro.org:email,bootlin.com:url]
X-Rspamd-Queue-Id: 2B23540C96F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi

Am 16.04.26 um 08:53 schrieb Yongbang Shi:
>> Call drm_atomic_helper_check_plane_state() from the primary plane's
>> atomic-check helper and replace the custom implementation.
>>
>> All plane's implementations of atomic_check should call the shared
>> _check_plane_state() helper first. It adjusts the plane state for
>> correct positioning, rotation and scaling of the plane. If the plane
>> is not visible, it clears the corresponding flag in the plane state.
>>
>> On errors or if the plane is not visible, the atomic-check helper can
>> return early. Implement all this in hibmc and drop the custom code
>> that does some of it.
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Fixes: da52605eea8f ("drm/hisilicon/hibmc: Add support for display engine")
>> Cc: Rongrong Zou <zourongrong@gmail.com>
>> Cc: Sean Paul <seanpaul@chromium.org>
>> Cc: Xinliang Liu <xinliang.liu@linaro.org>
>> Cc: Dmitry Baryshkov <lumag@kernel.org>
>> Cc: Baihan Li <libaihan@huawei.com>
>> Cc: Yongbang Shi <shiyongbang@huawei.com>
>> Cc: <stable@vger.kernel.org> # v4.10+
>> ---
>>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_de.c    | 46 ++++++-------------
>>   1 file changed, 14 insertions(+), 32 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
>> index 89bed78f1466..8fa2a95bcdd1 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
>> @@ -55,46 +55,28 @@ static const struct hibmc_dislay_pll_config hibmc_pll_table[] = {
>>   static int hibmc_plane_atomic_check(struct drm_plane *plane,
>>   				    struct drm_atomic_state *state)
>>   {
>> -	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
>> -										 plane);
>> -	struct drm_framebuffer *fb = new_plane_state->fb;
>> -	struct drm_crtc *crtc = new_plane_state->crtc;
>> -	struct drm_crtc_state *crtc_state;
>> -	u32 src_w = new_plane_state->src_w >> 16;
>> -	u32 src_h = new_plane_state->src_h >> 16;
>> -
>> -	if (!crtc || !fb)
>> -		return 0;
>> +	struct drm_plane_state *new_plane_state =
>> +		drm_atomic_get_new_plane_state(state, plane);
>> +	struct drm_crtc_state *new_crtc_state = NULL;
>> +	int ret;
>>   
>> -	crtc_state = drm_atomic_get_crtc_state(state, crtc);
>> -	if (IS_ERR(crtc_state))
>> -		return PTR_ERR(crtc_state);
>> +	if (new_plane_state->crtc)
>> +		new_crtc_state = drm_atomic_get_new_crtc_state(state, new_plane_state->crtc);
>>   
>> -	if (src_w != new_plane_state->crtc_w || src_h != new_plane_state->crtc_h) {
>> -		drm_dbg_atomic(plane->dev, "scale not support\n");
>> -		return -EINVAL;
>> -	}
>> -
>> -	if (new_plane_state->crtc_x < 0 || new_plane_state->crtc_y < 0) {
>> -		drm_dbg_atomic(plane->dev, "crtc_x/y of drm_plane state is invalid\n");
>> -		return -EINVAL;
>> -	}
>> -
>> -	if (!crtc_state->enable)
>> +	ret = drm_atomic_helper_check_plane_state(new_plane_state, new_crtc_state,
>> +						  DRM_PLANE_NO_SCALING,
>> +						  DRM_PLANE_NO_SCALING,
>> +						  false, true);
> The last parameter, "can_update_disabled", if set to true, causes the
> condition "if (!crtc_state->enable && !can_update_disabled)" in the
> function `drm_atomic_helper_check_plane_state` to always evaluate to
> false, meaning `crtc_state->enable` will not be checked. This differs
> from the behavior prior to the modification.
>
> before:
> 	- crtc_state->enable(true)  --> continue check
> 	- crtc_state->enable(false) --> return 0(atomic check success)
>
> after:
> 	- crtc_state->enable(true)   --> _helper_check_plane_ ->  continue check
> 	- crtc_state->enable(false)  --> _helper_check_plane_ ->  continue check

Isn't this what the hardware supports? The plane's hardware registers 
can be updated even if the plane's CRTC is off?

In the old case, atomic check returned success. If we set 
can_update_disable to false, it would return an error in such as case.  
Settings it ti true keeps the success for disabled CRTCs. The semantics 
of the returned value don't change. It's just that the helper fills a 
few more fields in drm_plane_state.



>
>
>> +	if (ret)
>> +		return ret;
>> +	else if (!new_plane_state->visible)
>>   		return 0;
>>   
>> -	if (new_plane_state->crtc_x + new_plane_state->crtc_w >
>> -	    crtc_state->adjusted_mode.hdisplay ||
>> -	    new_plane_state->crtc_y + new_plane_state->crtc_h >
>> -	    crtc_state->adjusted_mode.vdisplay) {
>> -		drm_dbg_atomic(plane->dev, "visible portion of plane is invalid\n");
>> -		return -EINVAL;
>> -	}
>> -
> The purpose of this check is to ensure that the right and bottom
> boundaries of the plane do not extend beyond the crtc. In
> `drm_atomic_helper_check_plane_state`, `drm_mode_get_hv_timing` is
> called to retrieve the crtc boundaries, and `drm_rect_clip_scaled` is
> used to clip the plane, any portions extending beyond the right and
> bottom boundaries are discarded.
>
> I'd like to confirm that my understanding is correct? previously, the
> check failed if the plane exceeded the boundaries, but now, after
> `drm_atomic_helper_check_plane_state` is called, the plane is clipped to
> fit within the boundaries.

Yes. This sets plane_state->dst, which is clipped to the size of the 
display mode. But it also tests that the primary plane covers the whole 
display.

>
> in function drm_rect_clip_scaled:
>
> diff = dst->x2 - clip->x2;
> if (diff > 0) {
> 	...
> 	dst->x2 -= diff;
> }
> diff = dst->y2 - clip->y2;
> if (diff > 0) {
> 	...
> 	dst->y2 -= diff;
> }

I agree, the logic in drm_atomic_helper_check_plane_state() is hard to 
understand. It sets the clip rectangle to the size of the display mode 
(or zero if the CRTC is off) at [1].  Then is clips the source and 
destination coordinates against the clipping rectangle at [2].

Because we set can_position to false, it tests if the destination and 
clipping rectangles are equal at [3]. This is similar to the that is 
being replaced, but with plane state correctly adjusted. If both 
rectangles are equal, it returns success. If the destination is too 
small, it fails with an errno code and a warning.

If the plane is not visible, the helper already returned at [4].

[1] 
https://elixir.bootlin.com/linux/v7.0/source/drivers/gpu/drm/drm_atomic_helper.c#L943
[2] 
https://elixir.bootlin.com/linux/v7.0/source/drivers/gpu/drm/drm_atomic_helper.c#L945
[3] 
https://elixir.bootlin.com/linux/v7.0/source/drivers/gpu/drm/drm_atomic_helper.c#L959
[4] 
https://elixir.bootlin.com/linux/v7.0/source/drivers/gpu/drm/drm_atomic_helper.c#L949

It is now possible to have a primary plane that is larger than the 
display mode. This is a feature of the DRM API.

Best regards
Thomas


>
>
> Thanks.
>
> Best regards
> Yongbang.
>
>
>>   	if (new_plane_state->fb->pitches[0] % 128 != 0) {
>>   		drm_dbg_atomic(plane->dev, "wrong stride with 128-byte aligned\n");
>>   		return -EINVAL;
>>   	}
>> +
>>   	return 0;
>>   }
>>   

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)



