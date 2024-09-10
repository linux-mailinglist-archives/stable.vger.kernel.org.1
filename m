Return-Path: <stable+bounces-74117-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F77972AA3
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BEDE1C2411C
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 07:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1ED117C9B9;
	Tue, 10 Sep 2024 07:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zUWLy9Ov";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="td/M7CLG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zUWLy9Ov";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="td/M7CLG"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CD317BB3F;
	Tue, 10 Sep 2024 07:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725953213; cv=none; b=gDyUtxlH4oMLPj/3d6LhgW206YeWIY8g67jV+ebCXM1r/5zp7r7Hk4yK1YWq84OeNdP1G6KSjiTvuSmgA/qSr0vjmOS1UgwiSCYeUiP+WemrmrbmX1m4QAIjstAwXrNAum92Q3fn5AXKasHQPA4lA+K7Vh6M/cxNFUkPYTjEVo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725953213; c=relaxed/simple;
	bh=xw60bUIRo7WKTtSnWsEqgbl4rhYeBzdN89V46KJZgqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lpx4QmVA5bI8+Q83m1YO6IPuigrOYLqKXzsE539+JBZkfDZJEjJcJFvY7fkcfKE7+6f8CGcMFh69rYqmF/DvFoZsNxZdwDbX/UUilrEHcIY9LOLd3PhsSco3VhJdNYqb0bHA9xy6VQhVNfVPusWglNBQ+sm6B/F730QewNyZuG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zUWLy9Ov; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=td/M7CLG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zUWLy9Ov; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=td/M7CLG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BEF00219FB;
	Tue, 10 Sep 2024 07:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725953203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=m7fVBlL4PNu24Is+8HspZt8gB7mcRXk5r+0veAHr0/w=;
	b=zUWLy9OvAO7XrxoS6/UoJhkJSrj0WB+6fVF6nDh1pZmKtFVCfEXqJNKgFj18SsmLMBmMy5
	VHyBv1nUd3A0tiOCUZ6C6MsMedok/C/qhTHobr9SPz/p2kTCp2IsTPeCrdejqpqnpHxL1H
	QrxtOlzVSKrZ2v+uZr2jEgR+e14sHOs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725953203;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=m7fVBlL4PNu24Is+8HspZt8gB7mcRXk5r+0veAHr0/w=;
	b=td/M7CLG23zworLW4Ao5DjziNtE2XM3TIOp3+791DBeDDuhtff3nXK8o1URUxeLVkjcKBr
	yepoUyf+F6YU43BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725953203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=m7fVBlL4PNu24Is+8HspZt8gB7mcRXk5r+0veAHr0/w=;
	b=zUWLy9OvAO7XrxoS6/UoJhkJSrj0WB+6fVF6nDh1pZmKtFVCfEXqJNKgFj18SsmLMBmMy5
	VHyBv1nUd3A0tiOCUZ6C6MsMedok/C/qhTHobr9SPz/p2kTCp2IsTPeCrdejqpqnpHxL1H
	QrxtOlzVSKrZ2v+uZr2jEgR+e14sHOs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725953203;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=m7fVBlL4PNu24Is+8HspZt8gB7mcRXk5r+0veAHr0/w=;
	b=td/M7CLG23zworLW4Ao5DjziNtE2XM3TIOp3+791DBeDDuhtff3nXK8o1URUxeLVkjcKBr
	yepoUyf+F6YU43BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7729713A3A;
	Tue, 10 Sep 2024 07:26:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EapyG7P032YTJgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 10 Sep 2024 07:26:43 +0000
Message-ID: <0cbcaa64-2cbe-4c8e-86a0-e12da60a42ab@suse.de>
Date: Tue, 10 Sep 2024 09:26:42 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev/xen-fbfront: Assign fb_info->device
To: Jason Andryuk <jandryuk@gmail.com>, Helge Deller <deller@gmx.de>,
 Arnd Bergmann <arnd@arndb.de>, Sam Ravnborg <sam@ravnborg.org>
Cc: xen-devel@lists.xenproject.org, Jason Andryuk <jason.andryuk@amd.com>,
 Arthur Borsboom <arthurborsboom@gmail.com>, stable@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240910020919.5757-1-jandryuk@gmail.com>
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
In-Reply-To: <20240910020919.5757-1-jandryuk@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,gmx.de,arndb.de,ravnborg.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.xenproject.org,amd.com,gmail.com,vger.kernel.org,lists.freedesktop.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 



Am 10.09.24 um 04:09 schrieb Jason Andryuk:
> From: Jason Andryuk <jason.andryuk@amd.com>
>
> Probing xen-fbfront faults in video_is_primary_device().  The passed-in
> struct device is NULL since xen-fbfront doesn't assign it and the
> memory is kzalloc()-ed.  Assign fb_info->device to avoid this.
>
> This was exposed by the conversion of fb_is_primary_device() to
> video_is_primary_device() which dropped a NULL check for struct device.
>
> Fixes: f178e96de7f0 ("arch: Remove struct fb_info from video helpers")
> Reported-by: Arthur Borsboom <arthurborsboom@gmail.com>
> Closes: https://lore.kernel.org/xen-devel/CALUcmUncX=LkXWeiSiTKsDY-cOe8QksWhFvcCneOKfrKd0ZajA@mail.gmail.com/
> Tested-by: Arthur Borsboom <arthurborsboom@gmail.com>
> CC: stable@vger.kernel.org
> Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

Thanks a lot.

> ---
> The other option would be to re-instate the NULL check in
> video_is_primary_device()
> ---
>   drivers/video/fbdev/xen-fbfront.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/video/fbdev/xen-fbfront.c b/drivers/video/fbdev/xen-fbfront.c
> index 66d4628a96ae..c90f48ebb15e 100644
> --- a/drivers/video/fbdev/xen-fbfront.c
> +++ b/drivers/video/fbdev/xen-fbfront.c
> @@ -407,6 +407,7 @@ static int xenfb_probe(struct xenbus_device *dev,
>   	/* complete the abuse: */
>   	fb_info->pseudo_palette = fb_info->par;
>   	fb_info->par = info;
> +	fb_info->device = &dev->dev;
>   
>   	fb_info->screen_buffer = info->fb;
>   

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


