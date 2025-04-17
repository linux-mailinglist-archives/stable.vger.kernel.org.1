Return-Path: <stable+bounces-132904-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 107B6A914B7
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 09:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 042133BD75A
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 07:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0825D215197;
	Thu, 17 Apr 2025 07:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yVcccdm7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="b1Km8ZF6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KeU2rwQZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="b6WdqsfM"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045ED2063FD
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 07:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744873545; cv=none; b=nTB7xi5j77+DeugF4H9RBkjersBWw6JdC8iizD6Qrfd0/6Oj391KdiR40J+19LVP9Rju/8zCXyeAIXRsJHuKpSdvuXNRqw+pWv+V2n6fa5peuzDiUKqELaIwrjQcs6PUrDbDVb5i/fE5ikK+rLzDJ8jPL95JxmOb8i8II3oDuZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744873545; c=relaxed/simple;
	bh=HOEV45ThnY/Yb65WyKotvmiHDh3rW2o+Zy2dXl1lSu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eYu8fbDgsZ5Qg0fT91Y69d5EIauPkj2wZTD114ZJqDlYI2SPCowknmm1KPzaCmZ5NVsOQPETyuYYpyBA2/V0B001CHFvferTb4ASpL3g+PjVyepZiRdTPgBn/WIDQ34DSVcmN+lgqv7kzNwgaN6cT5P12oNsLt/1s2Ezlytfe00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yVcccdm7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=b1Km8ZF6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KeU2rwQZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=b6WdqsfM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EEB5D21197;
	Thu, 17 Apr 2025 07:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744873542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=n3JWJiXcjx1Szn8ywCGniS5/EufUBWnfIG7HjjSGdjY=;
	b=yVcccdm7STN/oIczS5hIoxdzpKyhEO1nX6hjDWZTxqCN36LV3Ey8YtJuninOeLuKhGDTr8
	mLbcy/cRsb+Ef3AFop39neO9co82lM4Z2tGbzKD/KZVVGBZkIyHhDvBvVzD+z6CI2Cgrt5
	yUaLCA7Jy/lj3B1ToGYaxqMAB+nb5wk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744873542;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=n3JWJiXcjx1Szn8ywCGniS5/EufUBWnfIG7HjjSGdjY=;
	b=b1Km8ZF6l3U/NMowMyWVwAeX9wT4NoR19jRkrPXIMbqgt7UvruJ7SbMBrHQSMDg+A0jPeC
	gzZ693kW+e12znBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744873541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=n3JWJiXcjx1Szn8ywCGniS5/EufUBWnfIG7HjjSGdjY=;
	b=KeU2rwQZmVwexd6w+5r8yqGz7SLdzAsnEiVIpA+XMEwdauciWr+x9qLpiQ8aC1QXAQcwxV
	jbGWSTy9U3st4fwiPX7eWn3AdWnnFPZlTXhHBbNcF9E1NyCSYbA2sztL9J+B4Qiavbkewc
	FCHLEaUsDKwVGOWMT7DPX/vYNCVAYik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744873541;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=n3JWJiXcjx1Szn8ywCGniS5/EufUBWnfIG7HjjSGdjY=;
	b=b6WdqsfMZP1HLZT+VzBeCG9MYcqugFI7U/Aw6d+BcOI3JQ+tSx44e/CfKdvPTYjKPl5Ohq
	b+VWJsQ6AnedFJBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA1D6137CF;
	Thu, 17 Apr 2025 07:05:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KYwBMEWoAGhlSAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 17 Apr 2025 07:05:41 +0000
Message-ID: <6c2e9f12-a271-47cc-b2aa-880d61d07b22@suse.de>
Date: Thu, 17 Apr 2025 09:05:41 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/tiny: panel-mipi-dbi: Pass
 drm_client_setup_with_fourcc()
To: Fabio Estevam <festevam@gmail.com>, noralf@tronnes.org
Cc: dri-devel@lists.freedesktop.org, Fabio Estevam <festevam@denx.de>,
 stable@vger.kernel.org
References: <20250416133048.2316297-1-festevam@gmail.com>
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
In-Reply-To: <20250416133048.2316297-1-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,tronnes.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid,denx.de:email];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,denx.de:email,suse.de:email,suse.de:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO



Am 16.04.25 um 15:30 schrieb Fabio Estevam:
> From: Fabio Estevam <festevam@denx.de>
>
> Since commit 559358282e5b ("drm/fb-helper: Don't use the preferred depth
> for the BPP default") an RGB565 CFAF240320X display no longer works
> correctly: the colors are wrong and the content appears twice on the
> screen, side by side.
>
> The reason for the regression is that bits per pixel is now 32 instead
> of 16 in the fb-helper driver.
>
> Fix this problem by passing drm_client_setup_with_fourcc() with the correct
> format depending on the bits per pixel information.
>
> Cc: stable@vger.kernel.org
> Fixes: 559358282e5b ("drm/fb-helper: Don't use the preferred depth for the BPP default")
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   drivers/gpu/drm/tiny/panel-mipi-dbi.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/tiny/panel-mipi-dbi.c b/drivers/gpu/drm/tiny/panel-mipi-dbi.c
> index 0460ecaef4bd..23914a9f7fd3 100644
> --- a/drivers/gpu/drm/tiny/panel-mipi-dbi.c
> +++ b/drivers/gpu/drm/tiny/panel-mipi-dbi.c
> @@ -390,7 +390,10 @@ static int panel_mipi_dbi_spi_probe(struct spi_device *spi)
>   
>   	spi_set_drvdata(spi, drm);
>   
> -	drm_client_setup(drm, NULL);
> +	if (bpp == 16)
> +		drm_client_setup_with_fourcc(drm, DRM_FORMAT_RGB565);
> +	else
> +		drm_client_setup_with_fourcc(drm, DRM_FORMAT_RGB888);
>   
>   	return 0;
>   }

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


