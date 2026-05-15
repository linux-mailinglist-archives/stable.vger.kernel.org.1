Return-Path: <stable+bounces-247469-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPKJB+fRBmqKoAIAu9opvQ
	(envelope-from <stable+bounces-247469-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 09:57:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C51754AE5D
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 09:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF400301388F
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C5C3F7A9A;
	Fri, 15 May 2026 07:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="v0OmErCA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+1jzwHJ1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="q0zmy2lg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GD3D7uC2"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415E23F7A84
	for <stable@vger.kernel.org>; Fri, 15 May 2026 07:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778831805; cv=none; b=rJZyStP36AYsxUfWYOMA4I4L8b1ARwjm+A4jN8fVwIywAkEsYZf0/XlG2oBtF6sPCs+fzVi/Jn12eRJKBeMUNNebz10s5IRiaEccw7w46t6xCiivsl+2IEmSsZ+0BZ6fhA/VRR+i5A+sI2MBtLnZbQxt4xPzhNkewMd03ZS6N+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778831805; c=relaxed/simple;
	bh=lce/FJEYywt2Hc9l65aqshT5a7GCepPY5dQBSvE06a4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W0bkSAQL2N0mCSbCWIAX/TChe+LMx2Tt3cgNt5a9vdz21s+XB3lj1lg2OF2P5Y2NUhT6CHZ3m7bvEzkzDo3RKxcqp7xFznrPf2UE4mpqyLt3LRUbtFZe7F8BZBZnJUFwD0bFu4LeT292R3NEjV77W4Hbp670d9GjYlr4cm28Tf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=v0OmErCA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+1jzwHJ1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=q0zmy2lg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GD3D7uC2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8BF855E87C;
	Fri, 15 May 2026 07:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778831796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5qqrmLlFTEZ7ISI+4b2QP1omWUbIuwpSSqwSc5CT0uM=;
	b=v0OmErCAm1VlI4AVooPmxqcPdji7LQp+7kx12LQKRKLysmjY3MrX1rBeRjr4Nr4HoyjaLr
	JVzWbqmcjnArKAazWjri0wqjDVMTrPuUs6ffll0/P2+ZLaiqy+JHVRxmKKrlHjtWS3chK+
	qsO1hbrUT0EHs3Pkwk5rNKtOePVnuzI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778831796;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5qqrmLlFTEZ7ISI+4b2QP1omWUbIuwpSSqwSc5CT0uM=;
	b=+1jzwHJ1CPO6p9Y+1kxWk27HBQnAizCg/MFOxXf9isV0mgxUTCxLE74EYGPPep1+GQvita
	alkOqnlbYOsKQiCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=q0zmy2lg;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GD3D7uC2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778831795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5qqrmLlFTEZ7ISI+4b2QP1omWUbIuwpSSqwSc5CT0uM=;
	b=q0zmy2lg1Oy5/4QACWte+Ugpw4xEUbJqfeO40+/Q/5m/HJNj8vmFYcg7GS4KIAXbbgrTpu
	MyCDLid2o5tjnETexoVGsPswdjmtgQ+vLhTWxMcTVZUsNdAwoU4q5VeZFpm3RcTzlK4Y01
	Jz/AFov+8vf2wJ4IQKyqzjpudB5FMLY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778831795;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5qqrmLlFTEZ7ISI+4b2QP1omWUbIuwpSSqwSc5CT0uM=;
	b=GD3D7uC2TTvpZzyuoR2lCB839Ef08GBD3WcGa/oPeMDes/CPSYlYHaVlfDXgJ9gHOww7x2
	UWvsgVQV6PuYcuBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D32A7593A9;
	Fri, 15 May 2026 07:56:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P5phMrLRBmpREAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 15 May 2026 07:56:34 +0000
Message-ID: <224eb142-3818-4dea-9cd7-4778c1de0e8d@suse.de>
Date: Fri, 15 May 2026 09:56:34 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] fbdev: broadsheetfb: fix potential memory leak in
 broadsheetfb_probe()
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
 <20260514-fbdev-v1-2-b3a2474fa720@cse.iitm.ac.in>
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
In-Reply-To: <20260514-fbdev-v1-2-b3a2474fa720@cse.iitm.ac.in>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: 8C51754AE5D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247469-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:email,suse.de:mid,suse.de:dkim,iitm.ac.in:email]
X-Rspamd-Action: no action



Am 14.05.26 um 10:24 schrieb Abdun Nihaal:
> The memory allocated for pagerefs in fb_deferred_io_init() is not freed
> on the error path. Fix it by calling fb_deferred_io_cleanup().
>
> Fixes: 56c134f7f1b5 ("fbdev: Track deferred-I/O pages in pageref struct")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   drivers/video/fbdev/broadsheetfb.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/fbdev/broadsheetfb.c b/drivers/video/fbdev/broadsheetfb.c
> index c8ba098a8c42..582f1ee4c9b6 100644
> --- a/drivers/video/fbdev/broadsheetfb.c
> +++ b/drivers/video/fbdev/broadsheetfb.c
> @@ -1072,12 +1072,14 @@ static int broadsheetfb_probe(struct platform_device *dev)
>   	info->flags = FBINFO_VIRTFB;
>   
>   	info->fbdefio = &broadsheetfb_defio;
> -	fb_deferred_io_init(info);
> +	retval = fb_deferred_io_init(info);
> +	if (retval)
> +		goto err_vfree;
>   
>   	retval = fb_alloc_cmap(&info->cmap, 16, 0);
>   	if (retval < 0) {
>   		dev_err(&dev->dev, "Failed to allocate colormap\n");
> -		goto err_vfree;
> +		goto err_fbdefio;
>   	}
>   
>   	/* set cmap */
> @@ -1121,6 +1123,8 @@ static int broadsheetfb_probe(struct platform_device *dev)
>   	board->cleanup(par);
>   err_cmap:
>   	fb_dealloc_cmap(&info->cmap);
> +err_fbdefio:
> +	fb_deferred_io_cleanup(info);
>   err_vfree:
>   	vfree(videomemory);
>   err_fb_rel:
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)



