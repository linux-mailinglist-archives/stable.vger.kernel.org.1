Return-Path: <stable+bounces-253793-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDkhEaRcEGqDWgYAu9opvQ
	(envelope-from <stable+bounces-253793-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 15:39:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AF82B5B5531
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 15:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0731431D4F7F
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 13:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019243B637A;
	Fri, 22 May 2026 13:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OT9XjWCb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oTCD+481";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wcjtJpsR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sKripMDz"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B603B583E
	for <stable@vger.kernel.org>; Fri, 22 May 2026 13:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779456252; cv=none; b=FtOAu7krud5axA7zQA0rtYPxWXFOGPn23OZMOLDCTw9cNtwWw0TTQH3nZiipG3eXkMORDRRpXR0/0ptPOE0puAZ1uT/RcRtKFWrqJ3P+pyRrdnZmmJNSgQrOV66s3Vd504Qcvb4+jgOuyh/lkrtn0xhc9WAS3e0fO/c+Bwlvzyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779456252; c=relaxed/simple;
	bh=9AoEHBE973Mhkv/GonKF+0W1+c27EELlYpey8q0W+8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jxBKoOqMMfn2f3WR+9kt8/R/rjdNzdDn5Hx3PWaT2tTU0s5NHPRqC6jYl6t4iF4CqMLK7H3o4YRpN5036y2CIFDmAYfBlpZls3lJ3XonHCuwftflZCle03kz6KL2Fh7BW5KmlgJtmYVxNPUf2wbfRsL37yQ2MJ9Xz2xNmMLCpLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OT9XjWCb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oTCD+481; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wcjtJpsR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sKripMDz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CF4C866E99;
	Fri, 22 May 2026 13:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779456246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iZ+0ozTeC95GVs+zn1nU36tePjWc71LaXoy5Wu1qDZY=;
	b=OT9XjWCbOOI5MMAiFo+3Md6Tt1BUPOFCLxCN23TTBPO1MfJG1S6IT5AC63ztal7hKnUt3F
	MA0Wu8x9rysxe/SsQdAQ1GKzICAr7cAP9MHMd+ogdyRP25ESwBn7P1glFGgrg88/Ha8F5h
	5eJMiSoR3OsbdXcwsoeK/LkSNtBEYjU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779456246;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iZ+0ozTeC95GVs+zn1nU36tePjWc71LaXoy5Wu1qDZY=;
	b=oTCD+4814lWIUlRhDzd2RcxNkMsYsfGnRqRPWQoconmCet/tcclE5S4FcbcEVi6Ewf7fzq
	LgwmlMGMKiqPANCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779456245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iZ+0ozTeC95GVs+zn1nU36tePjWc71LaXoy5Wu1qDZY=;
	b=wcjtJpsRlRanv4/JZokBVgfj9LpFqjAyzDHQs0VDZ9VwJXntdNKXm4IPxhNBVhtTj3Xqme
	JqRDBVQee8ws4UhhoI/niXsvgawOd8vmpDqX2D0ALVqXPP5MVoiWfnSOvA5ZcqECM7ZT8i
	hoUav1aAiha+arHB+k43PQF+67DmkEA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779456245;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iZ+0ozTeC95GVs+zn1nU36tePjWc71LaXoy5Wu1qDZY=;
	b=sKripMDzRWw6fOseJDFgrA3JqU3VkZ9eaGqECb7N61BoTu9MKDlc15bUnHe+I/RyhpmPoF
	pEnxg5oZgexxxlAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 82F48593A8;
	Fri, 22 May 2026 13:24:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id StNxHvVYEGp+LgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 22 May 2026 13:24:05 +0000
Message-ID: <b4b2e8cb-dd7c-42c2-88b7-0a2ab95a90ee@suse.de>
Date: Fri, 22 May 2026 15:24:05 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/client: check whether CRTC is active before waiting
 for vblank
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Icenowy Zheng <uwu@icenowy.me>, stable@vger.kernel.org
References: <20260519092420.1124348-1-zhengxingda@iscas.ac.cn>
 <ee86cb43-e5df-4946-a957-931a73dde752@suse.de> <ahBWayIcQUHuAt4i@intel.com>
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
In-Reply-To: <ahBWayIcQUHuAt4i@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-253793-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[iscas.ac.cn,linux.intel.com,kernel.org,gmail.com,ffwll.ch,ravnborg.org,lists.freedesktop.org,vger.kernel.org,icenowy.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tzimmermann@suse.de,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: AF82B5B5531
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi

Am 22.05.26 um 15:13 schrieb Ville Syrjälä:
> On Fri, May 22, 2026 at 01:55:59PM +0200, Thomas Zimmermann wrote:
>> Hi
>>
>> Am 19.05.26 um 11:24 schrieb Icenowy Zheng:
>>> Currently the implementaion of drm_client_modeset_wait_for_vblank()
>>> assumes drm_vblank_get() will fail when the CRTC isn't active. However
>>> it seems that this is not true, and running fbcon on a device with the
>>> first CRTC inactive will lead to kernel warning in some cases (which
>>> could be reproduced with the loongson driver).
>>>
>>> Change the implementation to add a check for the active state (atomic) /
>>> enabled state (non-atomic) before calling drm_vblank_get(). As the
>>> assumption of drm_vblank_get() failing for inactive CRTC isn't met, the
>>> error status of drm_vblank_get() can now be exported too.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: d8c4bddcd8bc ("drm/fb-helper: Synchronize dirty worker with vblank")
>>> Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
>>> ---
>>>    drivers/gpu/drm/drm_client_modeset.c | 13 +++++++++++--
>>>    1 file changed, 11 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
>>> index bb49b8361271a..1b03bf351256e 100644
>>> --- a/drivers/gpu/drm/drm_client_modeset.c
>>> +++ b/drivers/gpu/drm/drm_client_modeset.c
>>> @@ -1310,7 +1310,7 @@ int drm_client_modeset_wait_for_vblank(struct drm_client_dev *client, unsigned i
>>>    {
>>>    	struct drm_device *dev = client->dev;
>>>    	struct drm_crtc *crtc;
>>> -	int ret;
>>> +	int ret = 0;
>>>    
>>>    	/*
>>>    	 * Rate-limit update frequency to vblank. If there's a DRM master
>>> @@ -1326,15 +1326,24 @@ int drm_client_modeset_wait_for_vblank(struct drm_client_dev *client, unsigned i
>>>    	 * Only wait for a vblank event if the CRTC is enabled, otherwise
>>>    	 * just don't do anything, not even report an error.
>>>    	 */
>>> +	if (drm_drv_uses_atomic_modeset(dev)) {
>>> +		if (!crtc->state || !crtc->state->active)
>>> +			goto out;
>>> +	} else {
>>> +		if (!crtc->enabled)
>>> +			goto out;
>>> +	}
>>> +
>> This part is good.
> Locking is missing.

Ok

>
>>>    	ret = drm_crtc_vblank_get(crtc);
>>>    	if (!ret) {
>>>    		drm_crtc_wait_one_vblank(crtc);
>>>    		drm_crtc_vblank_put(crtc);
>>>    	}
>>>    
>>> +out:
>>>    	drm_master_internal_release(dev);
>>>    
>>> -	return 0;
>>> +	return ret;
>> But this isn't. There can be CRTCs without any vblank at all. We still
>> want to fail silently for them. So we still have to return 0 here.
>>
>> Having set this, fixing this helper is only partially what you want.
>> Since your device has vblanking, the emulation should check on the
>> correct CRTC. IOW you need to pass the right CRTC index at
>>
>> https://elixir.bootlin.com/linux/v7.1-rc1/source/drivers/gpu/drm/drm_fb_helper.c#L237
>> https://elixir.bootlin.com/linux/v7.1-rc1/source/drivers/gpu/drm/drm_fb_helper.c#L920
>>
>> I'm not quite sure how to support this. The CRTC is under
>> fb_helper->client.modesets.crtc. You'd have to figure out which is the
>> relevant one and use that. But that's also not so great, as fbdev ioctls
>> only support CRTC 0. Doing internal re-mappings only complicates matters.
>>
>> But why does your HW use CRTC 1 in the first place.
> Could be eg. the enabled outputs can't be driven with CRTC 0.
>
> I guess what you want to do is pick the first crtc from modesets[]
> which is enabled. Or perhaps even "pick the Nth enabled crtc from
> modesets[] based on the ioctl argument".

The enable-status of each CRTC could change later on, which might lead 
to problems.  Picking the one CRTC/output with the lowest spec and 
mirroring it to the others might work. This CRTC would then be the one 
to wait for.

Best regards
Thomas

>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)



