Return-Path: <stable+bounces-62653-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC78940C5E
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 10:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44A4A28809C
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 08:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE6419408E;
	Tue, 30 Jul 2024 08:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cZrFFiUf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JX4xcZ4z";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cZrFFiUf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JX4xcZ4z"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559131B86DD
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 08:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722329550; cv=none; b=QExP65fyQSjTqWzR+4RCzJBT3uEnXek0bOxROUb3d+McRIFjRngqd6ac1XWkmzoZgwt29xw6uBbHRjGJTvAryiuQcVBcFEJk81T2UP2XewtJw58aYF4a7gyq87ETqEad3TX/YWd5Oz2NoWi7E6WvegVtRZ/mxqGwCPbvXyB7zzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722329550; c=relaxed/simple;
	bh=eUrIiyjAv8+q6uUDZeDRryUCLbKteGK9QObC9yfAP7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T62sqSMJr+FAQGaYPNPGuPfYoQNCj7VDwvM/5+ypiJey9/bEFpfonmvqPrg1twk9yGpKWdDDWO6gQQ4n7FVEWLmjXk3fyzA8IkpWBUSIihPGr+LYEOlR9CI4E//CEhmcF+jmwCxKVURxvlnAjgV/mKjbbY1qmwWw6+2jxqOkFto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cZrFFiUf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JX4xcZ4z; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cZrFFiUf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JX4xcZ4z; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6054821B5C;
	Tue, 30 Jul 2024 08:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722329546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VrnSN+Hi+plf1wCIyYH4uh/WBbuBnPEnFiIQu480KFY=;
	b=cZrFFiUf3bFjrpAh3Yas8Q3/6UQgKFmqcMRuS1SlGmjvvxT8wcRn94GWjpDVE6l84ovysB
	ScKMWCuyDL+afRRIoQbHsSEU1yX3RZH2scBA/xE5lFpVq1+OPDKH3WpcCDoMGttx1c1B6q
	teeP3rzyVBevohQYtHsQcOIg5OHaQzo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722329546;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VrnSN+Hi+plf1wCIyYH4uh/WBbuBnPEnFiIQu480KFY=;
	b=JX4xcZ4zo4ESSb0cpOFNiHPrQxq8RuG6cpTsDtc8kIQ49wEAQmFP+RwFlk7LduM8Kws377
	Btqqg+MO2aaPnyBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722329546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VrnSN+Hi+plf1wCIyYH4uh/WBbuBnPEnFiIQu480KFY=;
	b=cZrFFiUf3bFjrpAh3Yas8Q3/6UQgKFmqcMRuS1SlGmjvvxT8wcRn94GWjpDVE6l84ovysB
	ScKMWCuyDL+afRRIoQbHsSEU1yX3RZH2scBA/xE5lFpVq1+OPDKH3WpcCDoMGttx1c1B6q
	teeP3rzyVBevohQYtHsQcOIg5OHaQzo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722329546;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VrnSN+Hi+plf1wCIyYH4uh/WBbuBnPEnFiIQu480KFY=;
	b=JX4xcZ4zo4ESSb0cpOFNiHPrQxq8RuG6cpTsDtc8kIQ49wEAQmFP+RwFlk7LduM8Kws377
	Btqqg+MO2aaPnyBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2854F13983;
	Tue, 30 Jul 2024 08:52:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Y2+JCMqpqGY7CQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 30 Jul 2024 08:52:26 +0000
Message-ID: <f890e750-cd0d-48bb-9452-a41dd1775788@suse.de>
Date: Tue, 30 Jul 2024 10:52:25 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] drm/ast: astdp: Wake up during connector status
 detection
To: airlied@redhat.com, jfalempe@redhat.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, stable@vger.kernel.org
References: <20240717143319.104012-1-tzimmermann@suse.de>
 <20240717143319.104012-2-tzimmermann@suse.de>
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
In-Reply-To: <20240717143319.104012-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.09 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo,lists.freedesktop.org:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.09

I merged this patch into drm-misc-fixes.

Am 17.07.24 um 16:24 schrieb Thomas Zimmermann:
> Power up the ASTDP connector for connection status detection if the
> connector is not active. Keep it powered if a display is attached.
>
> This fixes a bug where the connector does not come back after
> disconnecting the display. The encoder's atomic_disable turns off
> power on the physical connector. Further HPD reads will fail,
> thus preventing the driver from detecting re-connected displays.
>
> For connectors that are actively used, only test the HPD flag without
> touching power.
>
> Fixes: f81bb0ac7872 ("drm/ast: report connection status on Display Port.")
> Cc: Jocelyn Falempe <jfalempe@redhat.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.6+
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/ast/ast_dp.c   |  7 +++++++
>   drivers/gpu/drm/ast/ast_drv.h  |  1 +
>   drivers/gpu/drm/ast/ast_mode.c | 29 +++++++++++++++++++++++++++--
>   3 files changed, 35 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/ast/ast_dp.c b/drivers/gpu/drm/ast/ast_dp.c
> index 1e9259416980..e6c7f0d64e99 100644
> --- a/drivers/gpu/drm/ast/ast_dp.c
> +++ b/drivers/gpu/drm/ast/ast_dp.c
> @@ -158,7 +158,14 @@ void ast_dp_launch(struct drm_device *dev)
>   			       ASTDP_HOST_EDID_READ_DONE);
>   }
>   
> +bool ast_dp_power_is_on(struct ast_device *ast)
> +{
> +	u8 vgacre3;
> +
> +	vgacre3 = ast_get_index_reg(ast, AST_IO_VGACRI, 0xe3);
>   
> +	return !(vgacre3 & AST_DP_PHY_SLEEP);
> +}
>   
>   void ast_dp_power_on_off(struct drm_device *dev, bool on)
>   {
> diff --git a/drivers/gpu/drm/ast/ast_drv.h b/drivers/gpu/drm/ast/ast_drv.h
> index ba3d86973995..47bab5596c16 100644
> --- a/drivers/gpu/drm/ast/ast_drv.h
> +++ b/drivers/gpu/drm/ast/ast_drv.h
> @@ -472,6 +472,7 @@ void ast_init_3rdtx(struct drm_device *dev);
>   bool ast_astdp_is_connected(struct ast_device *ast);
>   int ast_astdp_read_edid(struct drm_device *dev, u8 *ediddata);
>   void ast_dp_launch(struct drm_device *dev);
> +bool ast_dp_power_is_on(struct ast_device *ast);
>   void ast_dp_power_on_off(struct drm_device *dev, bool no);
>   void ast_dp_set_on_off(struct drm_device *dev, bool no);
>   void ast_dp_set_mode(struct drm_crtc *crtc, struct ast_vbios_mode_info *vbios_mode);
> diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
> index dc8f639e82fd..049ee1477c33 100644
> --- a/drivers/gpu/drm/ast/ast_mode.c
> +++ b/drivers/gpu/drm/ast/ast_mode.c
> @@ -28,6 +28,7 @@
>    * Authors: Dave Airlie <airlied@redhat.com>
>    */
>   
> +#include <linux/delay.h>
>   #include <linux/export.h>
>   #include <linux/pci.h>
>   
> @@ -1687,11 +1688,35 @@ static int ast_astdp_connector_helper_detect_ctx(struct drm_connector *connector
>   						 struct drm_modeset_acquire_ctx *ctx,
>   						 bool force)
>   {
> +	struct drm_device *dev = connector->dev;
>   	struct ast_device *ast = to_ast_device(connector->dev);
> +	enum drm_connector_status status = connector_status_disconnected;
> +	struct drm_connector_state *connector_state = connector->state;
> +	bool is_active = false;
> +
> +	mutex_lock(&ast->modeset_lock);
> +
> +	if (connector_state && connector_state->crtc) {
> +		struct drm_crtc_state *crtc_state = connector_state->crtc->state;
> +
> +		if (crtc_state && crtc_state->active)
> +			is_active = true;
> +	}
> +
> +	if (!is_active && !ast_dp_power_is_on(ast)) {
> +		ast_dp_power_on_off(dev, true);
> +		msleep(50);
> +	}
>   
>   	if (ast_astdp_is_connected(ast))
> -		return connector_status_connected;
> -	return connector_status_disconnected;
> +		status = connector_status_connected;
> +
> +	if (!is_active && status == connector_status_disconnected)
> +		ast_dp_power_on_off(dev, false);
> +
> +	mutex_unlock(&ast->modeset_lock);
> +
> +	return status;
>   }
>   
>   static const struct drm_connector_helper_funcs ast_astdp_connector_helper_funcs = {

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


