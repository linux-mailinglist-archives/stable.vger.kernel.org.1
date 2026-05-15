Return-Path: <stable+bounces-247412-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDh5H4jIBmoCoAIAu9opvQ
	(envelope-from <stable+bounces-247412-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 09:17:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D3A54A70E
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 09:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 389ED3033318
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0583E5562;
	Fri, 15 May 2026 07:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IsU5XMTZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UBFXgsnj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IsU5XMTZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UBFXgsnj"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D8F37C0FC
	for <stable@vger.kernel.org>; Fri, 15 May 2026 07:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778829434; cv=none; b=TqJwA8c7zODJ0w15lDxOCs9mV92vCmdynJT8HocITW+UX2IvV9y7vXvFWveCUTTBBB9xnHRhz+CrIq/dttU8I28tmqY/9wdZETEmgKD9ZcBtjSsIms43XOUfllmIZ9nzGf+t+Njus8UeRnARFWXbVpoe5hxcfjhsfstc9EYmCfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778829434; c=relaxed/simple;
	bh=ckUig2D74bojw03zvIoJQk6EAU9LTEM4taBj1MLjYTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mYqoS40w9hKoYtVWT+s+ANG0+RXKgQ1q9g+k+k8KAS5DtPXEabTVq0N9NVgOFS5qYPzUes7ZewgV2/EpVjyoFqWP8ys16Lf+c+UwHDyzV1MAYJNknvvQqXpZO4qdWR8f7Rt/2m95rsMYxJwSAEziGLiRUNqx+MKK8MR/vJMdU7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IsU5XMTZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UBFXgsnj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IsU5XMTZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UBFXgsnj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4A77D67D2B;
	Fri, 15 May 2026 07:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778829430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eTon/q/xB3IR/FNMJ14/zjzqxak7kXyzc3j90ZrKwDs=;
	b=IsU5XMTZIFYhWPbCIvEXXe1XNWRz8w82NJqFkqvnANjHeMKkNKbPXh1ZuMtuhj8SaljWhR
	DjafHjUoaf+g/RjQmFu0Z9DjzPB5ItukXdSojk8efQMBhgbx9Xff0/1inSWE5zyKjbmuMA
	VAkWjiW/t4GjxY8OFfXDndqqbqAYFII=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778829430;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eTon/q/xB3IR/FNMJ14/zjzqxak7kXyzc3j90ZrKwDs=;
	b=UBFXgsnjjrCRZz5yyYw0xB/K554YJWav1iiUKjhsCtey5KmZVQqhLRWPmfd2V1ZQLdHb2z
	bh/ZqqRSyU/bB0DQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IsU5XMTZ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UBFXgsnj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778829430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eTon/q/xB3IR/FNMJ14/zjzqxak7kXyzc3j90ZrKwDs=;
	b=IsU5XMTZIFYhWPbCIvEXXe1XNWRz8w82NJqFkqvnANjHeMKkNKbPXh1ZuMtuhj8SaljWhR
	DjafHjUoaf+g/RjQmFu0Z9DjzPB5ItukXdSojk8efQMBhgbx9Xff0/1inSWE5zyKjbmuMA
	VAkWjiW/t4GjxY8OFfXDndqqbqAYFII=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778829430;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eTon/q/xB3IR/FNMJ14/zjzqxak7kXyzc3j90ZrKwDs=;
	b=UBFXgsnjjrCRZz5yyYw0xB/K554YJWav1iiUKjhsCtey5KmZVQqhLRWPmfd2V1ZQLdHb2z
	bh/ZqqRSyU/bB0DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B256F593A9;
	Fri, 15 May 2026 07:17:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id O0JbKnXIBmqFaAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 15 May 2026 07:17:09 +0000
Message-ID: <d58e1df5-60b0-4047-a596-c9739167abfe@suse.de>
Date: Fri, 15 May 2026 09:17:09 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/14] fbdev: vesafb: fix memory leak in vesafb_probe()
To: Abdun Nihaal <nihaal@cse.iitm.ac.in>, Helge Deller <deller@gmx.de>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sebastian Siewior <bigeasy@linutronix.de>,
 Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
 Ondrej Zary <linux@rainbow-software.org>, Antonino Daplas
 <adaplas@gmail.com>, Paul Mundt <lethal@linux-sh.org>,
 Krzysztof Helt <krzysztof.h1@wp.pl>, Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Michal Januszewski <spock@gentoo.org>, Heiko Schocher <hs@denx.de>,
 Peter Jones <pjones@redhat.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260514-fbdev-v1-0-b3a2474fa720@cse.iitm.ac.in>
 <20260514-fbdev-v1-13-b3a2474fa720@cse.iitm.ac.in>
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
In-Reply-To: <20260514-fbdev-v1-13-b3a2474fa720@cse.iitm.ac.in>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 96D3A54A70E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247412-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[cse.iitm.ac.in,gmx.de,redhat.com,kernel.crashing.org,linux-foundation.org,linutronix.de,rainbow-software.org,gmail.com,linux-sh.org,wp.pl,ti.com,gentoo.org,denx.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tzimmermann@suse.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.de:email,suse.de:mid,suse.de:dkim,iitm.ac.in:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action



Am 14.05.26 um 10:24 schrieb Abdun Nihaal:
> Since commit 73ce73c30ba9 ("fbdev: Transfer video= option strings to
> caller; clarify ownership") the string returned from fb_get_options()
> is expected to be freed by the caller. But the string is not freed in
> vesafb_probe(). Fix that by freeing the option string after setup.
>
> Fixes: 73ce73c30ba9 ("fbdev: Transfer video= option strings to caller; clarify ownership")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   drivers/video/fbdev/vesafb.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/video/fbdev/vesafb.c b/drivers/video/fbdev/vesafb.c
> index f84f4db244bf..f1902056bd73 100644
> --- a/drivers/video/fbdev/vesafb.c
> +++ b/drivers/video/fbdev/vesafb.c
> @@ -269,6 +269,7 @@ static int vesafb_probe(struct platform_device *dev)
>   	/* ignore error return of fb_get_options */
>   	fb_get_options("vesafb", &option);
>   	vesafb_setup(option);
> +	kfree(option);
>   
>   	if (si->orig_video_isVGA != VIDEO_TYPE_VLFB)
>   		return -ENODEV;
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)



