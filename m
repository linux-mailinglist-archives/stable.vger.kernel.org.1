Return-Path: <stable+bounces-28337-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6998187E491
	for <lists+stable@lfdr.de>; Mon, 18 Mar 2024 08:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 257C5282048
	for <lists+stable@lfdr.de>; Mon, 18 Mar 2024 07:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1636F241E1;
	Mon, 18 Mar 2024 07:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kwhE11EK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SuQ9R5Tx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kwhE11EK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SuQ9R5Tx"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA1724205;
	Mon, 18 Mar 2024 07:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710748752; cv=none; b=oUgJssyO/72BllMTpFKuI0mft+BCD9oam9Gd8ZSAgho70XrS2+nK17ou7jZisLVno5e/UCnPzy7CeMPGlLxeMHF4+LE5coo34SM8VKH5BDyyWK9Ni/pH5KoB9piJibhfXhqmxGbhgYs2eSgqfxjdxrvSQXgfTBANRDffyBIJ3Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710748752; c=relaxed/simple;
	bh=JeTN4MqB8yGBLaYxLnItrAbgHwiOS17icPUePTngwi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rDIvV8W+k5HXSkAIuijQhnFbz8UPduNrHqS1Wfu9PW80u0xAtgVfkknVK1wKu0g0FCUIzwQzaxd8JKRls53IuvM5/VA3xGIgcJu9HSsj9Ev0qc/jTHxUZioM4jHWQUAARZrgk1FZ/PsYLwRRil6NcmZdk88JWMP21qj0+iI3UHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kwhE11EK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SuQ9R5Tx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kwhE11EK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SuQ9R5Tx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0ECF43478D;
	Mon, 18 Mar 2024 07:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710748742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tih/DbYo/xYgXvHEiG0TBiUDoEM4kghblpId32hVJto=;
	b=kwhE11EKzMWSQ6l3vHKIjirOZQYJ9q+f4/nPkbEetB1ZzJIRmX8rgfIZ4rH7OXD/jc2Opl
	/cgdTCa6KlxGKp6Fk0l6yibDrV/TBXM4ky3/WqbgevjSFWRgUBvGWb2ZGQiT3peMm2wf75
	jczmQFyrfDJ6B0BPs56MRtePmzCRBEE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710748742;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tih/DbYo/xYgXvHEiG0TBiUDoEM4kghblpId32hVJto=;
	b=SuQ9R5Txw32OErfPLYMjIK9iuUlxyRj+8ad5f3YKswreXhBhrz2dsqsIRK63/4lYcVgDBI
	doLXWGlKJMyUxMAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710748742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tih/DbYo/xYgXvHEiG0TBiUDoEM4kghblpId32hVJto=;
	b=kwhE11EKzMWSQ6l3vHKIjirOZQYJ9q+f4/nPkbEetB1ZzJIRmX8rgfIZ4rH7OXD/jc2Opl
	/cgdTCa6KlxGKp6Fk0l6yibDrV/TBXM4ky3/WqbgevjSFWRgUBvGWb2ZGQiT3peMm2wf75
	jczmQFyrfDJ6B0BPs56MRtePmzCRBEE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710748742;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tih/DbYo/xYgXvHEiG0TBiUDoEM4kghblpId32hVJto=;
	b=SuQ9R5Txw32OErfPLYMjIK9iuUlxyRj+8ad5f3YKswreXhBhrz2dsqsIRK63/4lYcVgDBI
	doLXWGlKJMyUxMAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B0A541389C;
	Mon, 18 Mar 2024 07:59:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KDZAKUX092UMLQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 18 Mar 2024 07:59:01 +0000
Message-ID: <e684558e-8308-4d73-b920-547f9012a2cb@suse.de>
Date: Mon, 18 Mar 2024 08:59:01 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/43] drm/fbdev-generic: Do not set physical framebuffer
 address
Content-Language: en-US
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: daniel@ffwll.ch, airlied@gmail.com, deller@gmx.de, javierm@redhat.com,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Zack Rusin <zackr@vmware.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, stable@vger.kernel.org
References: <20240312154834.26178-1-tzimmermann@suse.de>
 <20240312154834.26178-2-tzimmermann@suse.de>
 <CABQX2QPJJFrARdteFFZ8f33hvDx-HSyOQJQ7AMFK4C8C=BquTQ@mail.gmail.com>
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
In-Reply-To: <CABQX2QPJJFrARdteFFZ8f33hvDx-HSyOQJQ7AMFK4C8C=BquTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kwhE11EK;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SuQ9R5Tx
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.50 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 BAYES_HAM(-3.00)[100.00%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,intel.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_CC(0.00)[ffwll.ch,gmail.com,gmx.de,redhat.com,vger.kernel.org,lists.freedesktop.org,vmware.com,linux.intel.com,kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -4.50
X-Rspamd-Queue-Id: 0ECF43478D
X-Spam-Flag: NO

Hi

Am 18.03.24 um 03:35 schrieb Zack Rusin:
> On Tue, Mar 12, 2024 at 11:48 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
>> Framebuffer memory is allocated via vmalloc() from non-contiguous
>> physical pages. The physical framebuffer start address is therefore
>> meaningless. Do not set it.
>>
>> The value is not used within the kernel and only exported to userspace
>> on dedicated ARM configs. No functional change is expected.
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Fixes: a5b44c4adb16 ("drm/fbdev-generic: Always use shadow buffering")
>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>> Cc: Javier Martinez Canillas <javierm@redhat.com>
>> Cc: Zack Rusin <zackr@vmware.com>
>> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>> Cc: Maxime Ripard <mripard@kernel.org>
>> Cc: <stable@vger.kernel.org> # v6.4+
>> ---
>>   drivers/gpu/drm/drm_fbdev_generic.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/drm_fbdev_generic.c b/drivers/gpu/drm/drm_fbdev_generic.c
>> index d647d89764cb9..b4659cd6285ab 100644
>> --- a/drivers/gpu/drm/drm_fbdev_generic.c
>> +++ b/drivers/gpu/drm/drm_fbdev_generic.c
>> @@ -113,7 +113,6 @@ static int drm_fbdev_generic_helper_fb_probe(struct drm_fb_helper *fb_helper,
>>          /* screen */
>>          info->flags |= FBINFO_VIRTFB | FBINFO_READS_FAST;
>>          info->screen_buffer = screen_buffer;
>> -       info->fix.smem_start = page_to_phys(vmalloc_to_page(info->screen_buffer));
>>          info->fix.smem_len = screen_size;
>>
>>          /* deferred I/O */
>> --
>> 2.44.0
>>
> Good idea. I think given that drm_leak_fbdev_smem is off by default we
> could remove the setting of smem_start by all of the in-tree drm
> drivers (they all have open source userspace that won't mess around
> with fbdev fb) - it will be reset to 0 anyway. Actually, I wonder if
> we still need drm_leak_fbdev_smem at all...

All I know is that there's an embedded userspace driver that requires 
that setting. I don't even know which hardware.

Best regards
Thomas

>
> Reviewed-by: Zack Rusin <zack.rusin@broadcom.com>
>
> z

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


