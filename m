Return-Path: <stable+bounces-78224-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CAA989A7D
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 08:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3DA61F21892
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 06:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F6C7DA6A;
	Mon, 30 Sep 2024 06:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2EHjwY7i";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xLf702AT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2EHjwY7i";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xLf702AT"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625D523BE;
	Mon, 30 Sep 2024 06:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727677583; cv=none; b=PJ/jFeVfHXcZaUlUq5ETXq2crRti7Ae8puhElgNO4Egr0sRgb/Y4EagYlrQGnMRUGoxZLoqm8XIcrYsJf40lAZ60WI/sA0sQIYxn3+zrCmt7aBmpeHMRiXapndtxub/PKZkz908ieZpNkjE+4uYYAwhv1ahne8J/OZWI2ZlLJPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727677583; c=relaxed/simple;
	bh=2OEVznq956jPtNEIkG0h3wVv4T1s5GhUAIC6pmH8u9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=auo3F7yNZIWEK1uz1WrVSyjldy23KDVGObhV+o1VoP1ZGNLWNzHXawNV+ivRZWt9XXYlExbSBImOeenYzn3nPu+0V9KxA1MFvma2eP7UjI6fJmfuTAq1vZWpzIpBQ88/5d2UWma47N3QU7+5SceMPrNwjkrABU/WEtwBBw+BLRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2EHjwY7i; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xLf702AT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2EHjwY7i; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xLf702AT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 87259219C9;
	Mon, 30 Sep 2024 06:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727677579; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UaNuG6Q0hq80keF3xxM8HYwJK7sRZEgk1g48NLNcKgk=;
	b=2EHjwY7iZnTSWvsuxQHyF9ji2f7SwzoZE519MbSRMxQVUF6ZxsbPHkiAmQqo2ZIQRxD6Oe
	uh0l7l7JeoI0cOmZTBpcQQTMbxOFB2JiShxM8TTk/NKuAooYmatBCXKMwGqHUzWEOCkqLa
	rc9186QQNe8IP95u90X5d2TbW+tZ7wg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727677579;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UaNuG6Q0hq80keF3xxM8HYwJK7sRZEgk1g48NLNcKgk=;
	b=xLf702ATdt+b1dXY5pWU6lLYk3LrJgb975oBZHigNnFZnQe5Wg4lmQR7gVaJ6dihOOBxfb
	Q5xpdQF2SE/NoUCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727677579; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UaNuG6Q0hq80keF3xxM8HYwJK7sRZEgk1g48NLNcKgk=;
	b=2EHjwY7iZnTSWvsuxQHyF9ji2f7SwzoZE519MbSRMxQVUF6ZxsbPHkiAmQqo2ZIQRxD6Oe
	uh0l7l7JeoI0cOmZTBpcQQTMbxOFB2JiShxM8TTk/NKuAooYmatBCXKMwGqHUzWEOCkqLa
	rc9186QQNe8IP95u90X5d2TbW+tZ7wg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727677579;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UaNuG6Q0hq80keF3xxM8HYwJK7sRZEgk1g48NLNcKgk=;
	b=xLf702ATdt+b1dXY5pWU6lLYk3LrJgb975oBZHigNnFZnQe5Wg4lmQR7gVaJ6dihOOBxfb
	Q5xpdQF2SE/NoUCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4593513A8B;
	Mon, 30 Sep 2024 06:26:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tW+uD4tE+mZkcAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 30 Sep 2024 06:26:19 +0000
Message-ID: <4dc5d357-ffdc-4e91-9519-b23c735c077e@suse.de>
Date: Mon, 30 Sep 2024 08:26:18 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/atomic_helper: Add missing NULL check for
 drm_plane_helper_funcs.atomic_update
To: Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sean Paul <seanpaul@chromium.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240927204616.697467-1-lyude@redhat.com>
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
In-Reply-To: <20240927204616.697467-1-lyude@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.intel.com,kernel.org,gmail.com,ffwll.ch,chromium.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 



Am 27.09.24 um 22:46 schrieb Lyude Paul:
> Something I discovered while writing rvkms since some versions of the
> driver didn't have a filled out atomic_update function - we mention that
> this callback is "optional", but we don't actually check whether it's NULL
> or not before calling it. As a result, we'll segfault if it's not filled
> in.
>
>    rvkms rvkms.0: [drm:drm_atomic_helper_commit_modeset_disables] modeset on [ENCODER:36:Virtual-36]
>    BUG: kernel NULL pointer dereference, address: 0000000000000000
>    PGD 0 P4D 0
>    Oops: Oops: 0010 [#1] PREEMPT SMP NOPTI
>    Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20240813-1.fc40 08/13/2024
>    RIP: 0010:0x0
>
> So, let's fix that.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Fixes: c2fcd274bce5 ("drm: Add atomic/plane helpers")
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v3.19+

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   drivers/gpu/drm/drm_atomic_helper.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 43cdf39019a44..b3c507040c6d6 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -2797,7 +2797,8 @@ void drm_atomic_helper_commit_planes(struct drm_device *dev,
>   
>   			funcs->atomic_disable(plane, old_state);
>   		} else if (new_plane_state->crtc || disabling) {
> -			funcs->atomic_update(plane, old_state);
> +			if (funcs->atomic_update)
> +				funcs->atomic_update(plane, old_state);
>   
>   			if (!disabling && funcs->atomic_enable) {
>   				if (drm_atomic_plane_enabling(old_plane_state, new_plane_state))
> @@ -2889,7 +2890,8 @@ drm_atomic_helper_commit_planes_on_crtc(struct drm_crtc_state *old_crtc_state)
>   		if (disabling && plane_funcs->atomic_disable) {
>   			plane_funcs->atomic_disable(plane, old_state);
>   		} else if (new_plane_state->crtc || disabling) {
> -			plane_funcs->atomic_update(plane, old_state);
> +			if (plane_funcs->atomic_update)
> +				plane_funcs->atomic_update(plane, old_state);
>   
>   			if (!disabling && plane_funcs->atomic_enable) {
>   				if (drm_atomic_plane_enabling(old_plane_state, new_plane_state))
>
> base-commit: 22512c3ee0f47faab5def71c4453638923c62522

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


