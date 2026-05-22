Return-Path: <stable+bounces-253800-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMylLxxlEGoKXAYAu9opvQ
	(envelope-from <stable+bounces-253800-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 16:15:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C095B5F9D
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 16:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 351C7300B1F6
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 14:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117FA3D16EA;
	Fri, 22 May 2026 14:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aAwxxDyp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="R2eEI9yp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aAwxxDyp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="R2eEI9yp"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9A04218B5
	for <stable@vger.kernel.org>; Fri, 22 May 2026 14:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779459003; cv=none; b=R2oJ5anPzHfJvAkQkMVaW/lews0wnIZtGr40Ey+QIaZ07iwhVuJ7vEY2F0eeRg87rKP45wSNSIYdR+JQA//eMKcdq3M4ZbduXFQDrTb/wt0SZ4YUBmO2P5OZFSLV1MYvSKQt4Ep4eT8fUDVF8m7GRw2QSilED4zd06X94Edw0cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779459003; c=relaxed/simple;
	bh=zbGuQW/eHOdZQR57rAiBBxFAAvrOfJq2un69+uB1WOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OB+tZifxVHCTtP+pHJ12bymV7HsPQoH84ZrhukwLwO2dW2t03QYMBa4kZHdkpMg1igNepYZBcmAtnCav4QjmBjlqZD8lu8EndRjid5Chl4UNWHfQNtBO2bgRsi2t9qS/RIqLBJ0Qz0wvc0YBv5cABs56JgMQSScGuQP/L1tpRV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aAwxxDyp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=R2eEI9yp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aAwxxDyp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=R2eEI9yp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B6F876775A;
	Fri, 22 May 2026 14:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779458996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QKjA67bLe5pKP7UGALp0Pnr8LB2ZVYfXRG0NEZkHU3c=;
	b=aAwxxDypxeB1JZj70N+bYe80Cb1oX0YWhWPMfHo45sdWO+YyHln89sh/J9mLygBp90ZBQZ
	QqUEZoOm/Uqh8bL30a6qzWHEMz9vJYwn+NTq+sdRRjOPEsB3zYfTFISm0xzo2fxWaEX2JP
	HF0RNeHhKFb6XF+avdBT7yb3TOvf4i4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779458996;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QKjA67bLe5pKP7UGALp0Pnr8LB2ZVYfXRG0NEZkHU3c=;
	b=R2eEI9ypgMGyl8melpldHvgSgNN38+meeiaYDhaWllI8820g9AcI5R+uxwUkIDwIWm6cEE
	OgMtjfVHRLvIFgCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779458996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QKjA67bLe5pKP7UGALp0Pnr8LB2ZVYfXRG0NEZkHU3c=;
	b=aAwxxDypxeB1JZj70N+bYe80Cb1oX0YWhWPMfHo45sdWO+YyHln89sh/J9mLygBp90ZBQZ
	QqUEZoOm/Uqh8bL30a6qzWHEMz9vJYwn+NTq+sdRRjOPEsB3zYfTFISm0xzo2fxWaEX2JP
	HF0RNeHhKFb6XF+avdBT7yb3TOvf4i4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779458996;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QKjA67bLe5pKP7UGALp0Pnr8LB2ZVYfXRG0NEZkHU3c=;
	b=R2eEI9ypgMGyl8melpldHvgSgNN38+meeiaYDhaWllI8820g9AcI5R+uxwUkIDwIWm6cEE
	OgMtjfVHRLvIFgCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 63AA3593A8;
	Fri, 22 May 2026 14:09:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rE6pFbRjEGpIWgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 22 May 2026 14:09:56 +0000
Message-ID: <06e079a3-c8ec-4e3f-99da-c776d35cedfe@suse.de>
Date: Fri, 22 May 2026 16:09:55 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/client: check whether CRTC is active before waiting
 for vblank
To: Icenowy Zheng <uwu@icenowy.me>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260519092420.1124348-1-zhengxingda@iscas.ac.cn>
 <ee86cb43-e5df-4946-a957-931a73dde752@suse.de> <ahBWayIcQUHuAt4i@intel.com>
 <b4b2e8cb-dd7c-42c2-88b7-0a2ab95a90ee@suse.de> <ahBZ8nIqR4qESLZg@intel.com>
 <5fbcda92-f6b0-4de2-89e5-ea43a6248b05@suse.de>
 <3219f779c2f3bd17348a70d6c8278b1b1ab317d1.camel@icenowy.me>
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
In-Reply-To: <3219f779c2f3bd17348a70d6c8278b1b1ab317d1.camel@icenowy.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-253800-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,gmail.com,ffwll.ch,ravnborg.org,lists.freedesktop.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tzimmermann@suse.de,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 63C095B5F9D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi

Am 22.05.26 um 16:01 schrieb Icenowy Zheng:
> 在 2026-05-22五的 15:43 +0200，Thomas Zimmermann写道：
>> Hi
>>
>> Am 22.05.26 um 15:28 schrieb Ville Syrjälä:
>> [...]
>>>>>> But why does your HW use CRTC 1 in the first place.
>>>>> Could be eg. the enabled outputs can't be driven with CRTC 0.
> Yes, for many embedded display solutions the CRTC-connector map is
> totally fixed.
>
>>>>> I guess what you want to do is pick the first crtc from
>>>>> modesets[]
>>>>> which is enabled. Or perhaps even "pick the Nth enabled crtc
>>>>> from
>>>>> modesets[] based on the ioctl argument".
>>>> The enable-status of each CRTC could change later on, which might
>>>> lead
>>>> to problems.
>>> Sound like a locking issue if someone is changing the configuration
>>> at the same time we're trying to do the vblank wait here.
>> I mean that the connected outputs could change at a later point or we
>> could have multiple CRTCs in use. Today, someone in #intel-gfx
>> reported
>> a problem with panning if multiple CRTCs are in use.
>>
>> Therefore picking a CRTC freely could be a problem. Let's say we
>> configure modes from one CRTC, but later wait/pan/flush with another
>> CRTC. I would not trust this to work correctly.
>>
>> Hence, my suggestion is to select a primary CRTC during the fbdev
>> client's probe and use it for all later operations until the next
>> probe
>> happens.  All other CRTCs would mirror the primary one.
> What will happen if the "primary CRTC" is then disabled because of no
> connected connectors can be driven with it?

This happens during a client hotplug event. We'd re-detect all 
connectors, pick the CRTC/output with the lowest spec as new primary and 
mirror it to all other connected outputs.

Best regards
Thomas

>
> Thanks,
> Icenowy
>
>> Best regards
>> Thomas
>>
>>
>>>> Picking the one CRTC/output with the lowest spec and
>>>> mirroring it to the others might work. This CRTC would then be
>>>> the one
>>>> to wait for.
>>>>
>>>> Best regards
>>>> Thomas
>>>>
>>>> -- 
>>>> --
>>>> Thomas Zimmermann
>>>> Graphics Driver Developer
>>>> SUSE Software Solutions Germany GmbH
>>>> Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
>>>> GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809,
>>>> AG Nürnberg)
>>>>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)



