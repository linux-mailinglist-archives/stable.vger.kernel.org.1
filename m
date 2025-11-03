Return-Path: <stable+bounces-192222-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CB4C2CB67
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 16:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBC2B189AB8D
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 15:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAF22A1CF;
	Mon,  3 Nov 2025 15:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PgqLVuKF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IHiFmbAa";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iO0ecAfp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3BiifxNk"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDE927990C
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 15:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762182794; cv=none; b=YZqjthAtmOtdGTbHZV1GGBPfCIxwOGzbW9AUB5OPSyOBUfRL//uIMfHDtwXtUJbH6z+OGJFu+4Kmqzij6UGEnbebvuVs7SF92DB6/azswMETj/MEQzE5IMHStEcos10Mehd6B1XFUHsEnIHwkxSfpak+VBKqfl/efJ9qqRuQxF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762182794; c=relaxed/simple;
	bh=BbqZIz+nj1CfzLiRo3lGbYi+RtbRQoof4SL/X9SXQoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IEu7pyEVBU1ddUILLf3Xmty9yaNSbz77v9v/VSNdOWb5JaG13EAujwFcTAV6s7BeYYwBAujuBEzV9+usiOq7z0PvpWXWI7yIzu8bp4TGtb1jn9B2kuOMM2KAUfio5TF8+nmfdkXuDJpmrylo2AS0T1BnPt2e+7Y/gzUoxEXPd1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PgqLVuKF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IHiFmbAa; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iO0ecAfp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3BiifxNk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2F6601F445;
	Mon,  3 Nov 2025 15:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762182790; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9oevH+lwRt6UXcsLfONcSvfDcgzNhx5OigUk3e2exio=;
	b=PgqLVuKFo1/+qo2f3eTrkORnJUJam9xbXBQ0oOLIfDZuqleC/WG2ePaAoTTxJuCVvaBnlO
	pZh9oKdMN5llKVf0WnSWl1GVCJO4PbryvIxYuHrutwOgCDDu5VMosLtq13J+L3EoT8Xt0z
	eKsertp19KKWdn3l0/lhqO3c9bauSr4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762182790;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9oevH+lwRt6UXcsLfONcSvfDcgzNhx5OigUk3e2exio=;
	b=IHiFmbAazDc0DIhvhmMFYgtDpGCEjGhq1LP+05l4sp6JZ5u7NUa9GvCcZ3j15klShwkC0N
	v2Crxo/zEdvxlXAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762182789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9oevH+lwRt6UXcsLfONcSvfDcgzNhx5OigUk3e2exio=;
	b=iO0ecAfp00/FyLqtrPXP/4xZHqJL+fdrfe6UkfSzsE0/bLreQv0olrvgT85dnRIxuowzkd
	i3zgpxYPvgRzhcJNPE1B1Mu5FRaT1XE5LUbfDbNkI1aHQXXdxs11kWkHaw5ajlk0r2vWNX
	rTN3QUR1IaHmu+/j8tVP5kKzVScfICQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762182789;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9oevH+lwRt6UXcsLfONcSvfDcgzNhx5OigUk3e2exio=;
	b=3BiifxNkyHyqYoQX16bYteRAgC/uRuLMXaUO47gdY0QgSf1KauTXlMsz6EELSW1BNMjn8+
	Q4TL09S3U1+U8wCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CAD68139A9;
	Mon,  3 Nov 2025 15:13:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id f10YMITGCGlnCwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 03 Nov 2025 15:13:08 +0000
Message-ID: <a23a2142-0564-4f15-a20e-df3e0acac0d5@suse.de>
Date: Mon, 3 Nov 2025 16:13:08 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1.y] drm/sysfb: Do not dereference NULL pointer in plane
 reset
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 Melissa Wen <melissa.srw@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 Javier Martinez Canillas <javierm@redhat.com>
References: <2025110312-duration-shape-5d38@gregkh>
 <20251103145911.4040590-1-sashal@kernel.org>
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
In-Reply-To: <20251103145911.4040590-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_CC(0.00)[linaro.org,gmail.com,linux.intel.com,kernel.org,ffwll.ch,lists.freedesktop.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,msgid.link:url,suse.com:url,intel.com:email,linaro.org:email]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 



Am 03.11.25 um 15:59 schrieb Sasha Levin:
> From: Thomas Zimmermann <tzimmermann@suse.de>
>
> [ Upstream commit 14e02ed3876f4ab0ed6d3f41972175f8b8df3d70 ]
>
> The plane state in __drm_gem_reset_shadow_plane() can be NULL. Do not
> deref that pointer, but forward NULL to the other plane-reset helpers.
> Clears plane->state to NULL.
>
> v2:
> - fix typo in commit description (Javier)
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: b71565022031 ("drm/gem: Export implementation of shadow-plane helpers")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/dri-devel/aPIDAsHIUHp_qSW4@stanley.mountain/
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Melissa Wen <melissa.srw@gmail.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v5.15+
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> Link: https://patch.msgid.link/20251017091407.58488-1-tzimmermann@suse.de
> [ removed drm_format_conv_state_init() call ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   drivers/gpu/drm/drm_gem_atomic_helper.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_gem_atomic_helper.c b/drivers/gpu/drm/drm_gem_atomic_helper.c
> index b6a0110eb64af..2e658c216959f 100644
> --- a/drivers/gpu/drm/drm_gem_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_gem_atomic_helper.c
> @@ -330,7 +330,11 @@ EXPORT_SYMBOL(drm_gem_destroy_shadow_plane_state);
>   void __drm_gem_reset_shadow_plane(struct drm_plane *plane,
>   				  struct drm_shadow_plane_state *shadow_plane_state)
>   {
> -	__drm_atomic_helper_plane_reset(plane, &shadow_plane_state->base);
> +	if (shadow_plane_state) {
> +		__drm_atomic_helper_plane_reset(plane, &shadow_plane_state->base);
> +	} else {
> +		__drm_atomic_helper_plane_reset(plane, NULL);
> +	}
>   }
>   EXPORT_SYMBOL(__drm_gem_reset_shadow_plane);
>   

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)



