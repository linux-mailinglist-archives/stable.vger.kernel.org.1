Return-Path: <stable+bounces-65287-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6AE9458B6
	for <lists+stable@lfdr.de>; Fri,  2 Aug 2024 09:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 037AF282466
	for <lists+stable@lfdr.de>; Fri,  2 Aug 2024 07:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF811BE849;
	Fri,  2 Aug 2024 07:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IugPtRsR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="72I/J20G";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IugPtRsR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="72I/J20G"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF1D33991;
	Fri,  2 Aug 2024 07:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722583698; cv=none; b=U9Zdkq28Eknm68FT/RSE5xhF5EzaJiPh63X8rzzdDZsSVM0Cg9cIfi0uDAEL5HrWulLACwxPh0whWyQHvaVwsEco4LJ3zz+aYr9TJWt6pFSE+pkLmtjj0Jpx0VXXFzVewvNV+1OS0Lj+U9d4wOBAbkkw5o2x/jgyL2GoOL/TIIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722583698; c=relaxed/simple;
	bh=MXbC0dfh2of23i6kaVPjtdQAQsiZbD7gtOqmr5zIstc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F1FQ50jdum+r2O8NBDnHSiyRSz6ijvqfg5R1+O1HAr1m4sbyvvpiStvViNRL27hEyVefpOnI2r/2k6KPgLoCygh7gGeQzXvudMiOJ6csdgaOSsxWRaI0QfCCra4gHf7U0rDvkbAg4UrLqB4g0yxRDdkOu2QQTWcOOADAyVdOuQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IugPtRsR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=72I/J20G; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IugPtRsR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=72I/J20G; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 24F5F1FB98;
	Fri,  2 Aug 2024 07:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722583695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TF46Efa3JbFn/ZTXfp80xjaSk2yAOBnLsIQH4VXjDmk=;
	b=IugPtRsRi3a5SIwkUmMViNjxSSacKbh9JrwD45AOxc2s7evdo8m5HPM4rAARajfWiv03bB
	gA9Bmy8fwJt4QtvVuuq8Pbz3HAaOX7b8LS6HYutSnydxQNrBneGJ1b68V2RK473dqrq0ux
	saKoG3zxPzAZJxs0rMT4deZzcxA3a44=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722583695;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TF46Efa3JbFn/ZTXfp80xjaSk2yAOBnLsIQH4VXjDmk=;
	b=72I/J20Gh1rxbEcAvL0tarofeAws3JyK1tw41M3iDP2UNxcFvPueI0LGsJ5h7t+x8AR2Va
	2Le6NPV4TxtXqGDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722583695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TF46Efa3JbFn/ZTXfp80xjaSk2yAOBnLsIQH4VXjDmk=;
	b=IugPtRsRi3a5SIwkUmMViNjxSSacKbh9JrwD45AOxc2s7evdo8m5HPM4rAARajfWiv03bB
	gA9Bmy8fwJt4QtvVuuq8Pbz3HAaOX7b8LS6HYutSnydxQNrBneGJ1b68V2RK473dqrq0ux
	saKoG3zxPzAZJxs0rMT4deZzcxA3a44=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722583695;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TF46Efa3JbFn/ZTXfp80xjaSk2yAOBnLsIQH4VXjDmk=;
	b=72I/J20Gh1rxbEcAvL0tarofeAws3JyK1tw41M3iDP2UNxcFvPueI0LGsJ5h7t+x8AR2Va
	2Le6NPV4TxtXqGDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3D581388E;
	Fri,  2 Aug 2024 07:28:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TxtoMo6KrGZEBgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 02 Aug 2024 07:28:14 +0000
Message-ID: <96a2e3be-6cdb-42ee-9b74-ed9584ad3288@suse.de>
Date: Fri, 2 Aug 2024 09:28:14 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 RESEND] drm/client: fix null pointer dereference in
 drm_client_modeset_probe
To: Ma Ke <make24@iscas.ac.cn>, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, daniel@ffwll.ch, noralf@tronnes.org,
 sam@ravnborg.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240802044736.1570345-1-make24@iscas.ac.cn>
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
In-Reply-To: <20240802044736.1570345-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.09 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[iscas.ac.cn,linux.intel.com,kernel.org,gmail.com,ffwll.ch,tronnes.org,ravnborg.org];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.09

Hi

Am 02.08.24 um 06:47 schrieb Ma Ke:
> In drm_client_modeset_probe(), the return value of drm_mode_duplicate() is
> assigned to modeset->mode, which will lead to a possible NULL pointer
> dereference on failure of drm_mode_duplicate(). Add a check to avoid npd.
>
> Cc: stable@vger.kernel.org
> Fixes: cf13909aee05 ("drm/fb-helper: Move out modeset config code")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>

Thanks, merged into drm-misc-fixes.

Best regards
Thomas

> ---
> Changes in v4:
> - modified patch, set ret and break to handle error rightly.
> Changes in v3:
> - modified patch as suggestions, returned error directly when failing to
> get modeset->mode.
> Changes in v2:
> - added the recipient's email address, due to the prolonged absence of a
> response from the recipients.
> - added Cc stable.
> ---
>   drivers/gpu/drm/drm_client_modeset.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
> index 31af5cf37a09..cee5eafbfb81 100644
> --- a/drivers/gpu/drm/drm_client_modeset.c
> +++ b/drivers/gpu/drm/drm_client_modeset.c
> @@ -880,6 +880,11 @@ int drm_client_modeset_probe(struct drm_client_dev *client, unsigned int width,
>   
>   			kfree(modeset->mode);
>   			modeset->mode = drm_mode_duplicate(dev, mode);
> +			if (!modeset->mode) {
> +				ret = -ENOMEM;
> +				break;
> +			}
> +
>   			drm_connector_get(connector);
>   			modeset->connectors[modeset->num_connectors++] = connector;
>   			modeset->x = offset->x;

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


