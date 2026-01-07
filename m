Return-Path: <stable+bounces-206176-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7DBCFF919
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 19:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A6853379CCE
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 18:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C8B355051;
	Wed,  7 Jan 2026 15:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oK7GDxq9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wFF/KdsH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oK7GDxq9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wFF/KdsH"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBBB33BBA7
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 15:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767801378; cv=none; b=aKgBfmPVfRW9U//QNzoKvB7PINM4wnhRRfZDhd9D9ACskpmWF+l/gVtuIv5L+kO6N9zikAGcA54Z8dbxBMR/b8G5vN8vZKy1elR+DffXla9qho9v9qKxxMnQ+IBr6iv7wSFnCkWi3VOQpGt2xvNoxbaxrWfyPs6t8R8EPWB+kP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767801378; c=relaxed/simple;
	bh=BlmV0/27FNYqN0SB+PUpr6IAXJSijcO9kgPJZ/4FV6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r9Qz13/1h40CV12RABpLYxFRpo7I/WkX+86j0ghIe4CyLwPi+wgzV4nf4BtoDND31t1rik9CU0D40zeSu/se9BrHw3SpTAff1EArq05TxX6BsTgAFrGcRiUoSXRKHGjiDMp4IakrHFUBNe0kYkrA+hdNdthybDLj6PwIg4QFYqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oK7GDxq9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wFF/KdsH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oK7GDxq9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wFF/KdsH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 84D2334027;
	Wed,  7 Jan 2026 15:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1767801374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+2WUgdN302aBfJMSWX4WXbbIKDmbpLJMq9QaMTUH2RI=;
	b=oK7GDxq9K0SdRPWoJxE716F+I1bItRPyZ1cxZpA6OIA/JqZEWpuMVfUvDt5bXVoKiN61yM
	ygXzIIEh2NWc57+XF2pXd1jo41gj38xsoQj50o6vtGgOlzOdSWNrtAiVPiZOnANtRf/aR2
	CC8bLV8W29lMRZYs3aN1p21u/AM4qRg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1767801374;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+2WUgdN302aBfJMSWX4WXbbIKDmbpLJMq9QaMTUH2RI=;
	b=wFF/KdsHiCOIBuasSNE5530Eg393/mkZvZZEAkR9V6z9fZTaCpFSebGPxn9W5YGCWCcq0r
	4tJbmyd2xRbwmECw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=oK7GDxq9;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="wFF/KdsH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1767801374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+2WUgdN302aBfJMSWX4WXbbIKDmbpLJMq9QaMTUH2RI=;
	b=oK7GDxq9K0SdRPWoJxE716F+I1bItRPyZ1cxZpA6OIA/JqZEWpuMVfUvDt5bXVoKiN61yM
	ygXzIIEh2NWc57+XF2pXd1jo41gj38xsoQj50o6vtGgOlzOdSWNrtAiVPiZOnANtRf/aR2
	CC8bLV8W29lMRZYs3aN1p21u/AM4qRg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1767801374;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+2WUgdN302aBfJMSWX4WXbbIKDmbpLJMq9QaMTUH2RI=;
	b=wFF/KdsHiCOIBuasSNE5530Eg393/mkZvZZEAkR9V6z9fZTaCpFSebGPxn9W5YGCWCcq0r
	4tJbmyd2xRbwmECw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 47AFE3EA63;
	Wed,  7 Jan 2026 15:56:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id A21MEB6CXmk8HAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 07 Jan 2026 15:56:14 +0000
Message-ID: <8929ff0f-c2e0-49e6-a0ce-c4b0dcebae99@suse.de>
Date: Wed, 7 Jan 2026 16:56:13 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/gud: fix NULL fb and crtc dereferences on USB
 disconnect
To: Ruben Wauters <rubenru09@aol.com>, Shenghao Yang <me@shenghaoyang.info>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20251231055039.44266-1-me@shenghaoyang.info>
 <28c39f1979452b24ddde4de97e60ca721334eb49.camel@aol.com>
 <938b5e8e-b849-4d12-8ee2-98312094fc1e@shenghaoyang.info>
 <571d40f4d3150e61dfb5d2beccdf5c40f3b5be2c.camel@aol.com>
 <c6324a66-5886-4fbb-ba7b-fc7782c0f790@suse.de>
 <229b5608222595bc69e7ca86509086a14501b2f7.camel@aol.com>
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
In-Reply-To: <229b5608222595bc69e7ca86509086a14501b2f7.camel@aol.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: 84D2334027
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[aol.com,shenghaoyang.info,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[aol.com,gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.com:url];
	URIBL_BLOCKED(0.00)[suse.com:url,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

Hi

Am 07.01.26 um 16:02 schrieb Ruben Wauters:
> Hi,
>
> On Wed, 2026-01-07 at 08:46 +0100, Thomas Zimmermann wrote:
>> Hi Ruben
>>
>> Am 03.01.26 um 20:18 schrieb Ruben Wauters:
>>> Hi
>>>
>>> On Sun, 2026-01-04 at 01:47 +0800, Shenghao Yang wrote:
>>>> Hi Ruben,
>>>>
>>>> On 4/1/26 01:23, Ruben Wauters wrote:
>>>>
>>>>> With the elimination of these two WARN_ON_ONCEs, it's possible that
>>>>> crtc_state may not be assigned below, and therefore may be read/passed
>>>>> to functions when it is NULL (e.g. line 488). Either protection for a
>>>>> null crtc_state should be added to the rest of the function, or the
>>>>> function shouldn't continue if crtc is NULL.
>>>>>
>>>>> Ruben
>>>>>> -	crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
>>>>>> -
>>>>>> -	mode = &crtc_state->mode;
>>>>>> +	if (crtc)
>>>>>> +		crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
>>>>>>    
>>>>>>    	ret = drm_atomic_helper_check_plane_state(new_plane_state, crtc_state,
>>>>>>    						  DRM_PLANE_NO_SCALING,
>>>>>> @@ -492,6 +485,9 @@ int gud_plane_atomic_check(struct drm_plane *plane,
>>>>>>    	if (old_plane_state->rotation != new_plane_state->rotation)
>>>>>>    		crtc_state->mode_changed = true;
>>>>>>    
>>>>>> +	mode = &crtc_state->mode;
>>>>>> +	format = fb->format;
>>>> Yup - in this case I'm relying on drm_atomic_helper_check_plane_state()
>>>> bailing out early after seeing that fb is NULL (since a NULL crtc should
>>>> imply no fb) and setting plane_state->visible to false.
>> This is correct behavior.
>>
>>>> That would cause an early return in gud_plane_atomic_check() without
>>>> dereferencing crtc_state.
>>> This does work, however this ends up returning 0, which implies that
>>> the atomic check succeded. In my opinion in this case, -EINVAL should
>>> be returned, as both the crtc and fb don't exist, therefore the check
>>> should not succeed. I would personally prefer a more explicit check
>>> that does return -EINVAL instead of 0 from
>>> drm_atomic_helper_check_planes()
>> If the plane has been disbabled, fb and crtc are NULL. So this is
>> correct. drm_atomic_helper_check_plane_state() is the place to do this
>> testing before doing much else in the atomic_check handler. If
>> drm_atomic_helper_check_plane_state() gives an error, the error should
>> be returns. But if it returns 0 and sets ->visible to false, the
>> atomic_check should return 0.  That means that the plane can
>> successfully be disabled.
>>
>>> As a side note, I'm not sure if there's a reasoning as to why
>>> drm_atomic_helper_check_planes() returns 0 if fb is NULL instead of
>>> -EINVAL, I'm assuming it's not designed to come across this specific
>>> case. Either way it's not too much of an issue but maybe one of the drm
>>> maintainers can clarify why it's this way.
>> Disabling a plane is not an error, but a common operation.
> I think I may have misunderstood the drm docs on this, if having crtc
> and fb be null and returning 0 then is ok, I am happy for this patch to
> be applied. I have tested it and it indeed works, and removes the oops
> present in the driver before this.

No worries, DRM semantics can be murky. This is one of the cases that is 
impossible to know unless you came across a patch like this one.

Best regards
Thomas

>> I think the patch is fine and IIRC we have similar logic in other drivers.
> Reviewed-by: Ruben Wauters <rubenru09@aol.com>
>
> I believe Shenghao mentioned another oops that is present? if so it may
> be best to submit that in a separate patch rather than a v2 of this
> one.
>
> Ruben
>> Best regards
>> Thomas
>>
>>> Ruben
>>>> Would a more explicit check be preferred?
>>>>
>>>> Thanks,
>>>>
>>>> Shenghao

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)



