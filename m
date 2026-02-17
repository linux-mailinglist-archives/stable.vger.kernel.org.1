Return-Path: <stable+bounces-216844-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OENtMAaElGlBFQIAu9opvQ
	(envelope-from <stable+bounces-216844-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 16:06:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8FB14D65F
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 16:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 46D90302AF20
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 15:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D7B36BCEE;
	Tue, 17 Feb 2026 15:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J/6mUaKo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7QjNi51n";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J/6mUaKo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7QjNi51n"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CE936B047
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 15:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771340747; cv=none; b=WSx74VHk6xIT4nm+7WJBOsMSpUAk+aONCYBIes+KECfPPE08yWBH4oD8DCUwwI+E1txGX2KD4KOdIbDhnNx8STxsfgsaEbxbDrht4cWaKPMqEXLB66ANUa2rEY0M+KqnDsDX0IXC0P4oCC8R3bsycEvr7TpyNng2BMeppcC3fMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771340747; c=relaxed/simple;
	bh=tkpBUrf1yaEPgew9Z2YWr5VcNGOYKcw0RDnp7nsjb04=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=swregh77TYS2w7calllPGjq7/qhNiMn3vr90+BS6K2Z/+dRw6Qtsud1sovddusAxBNAcoFFEkcnb+K7QGKodaNaPpGUAOgljkiMLcI6d8g7o38F+B8KskVG/dTmjHRfm8wq5+ROjIoNaTDUWV+yAt7HIL1unLbEwu66014m+vVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=J/6mUaKo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7QjNi51n; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=J/6mUaKo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7QjNi51n; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C18AE3E6F0;
	Tue, 17 Feb 2026 15:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771340737; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0a5QgKrPsYbt60SbyVxiqxH8fETr4Fl9YLE29T4uFAE=;
	b=J/6mUaKovJKQpCE2FRf7ofomfxNE4TfvW4c3AhyTHfkqER5jb1M6GQSNELOMdDdGocdlYn
	kj+Au7n+6A3RqIuNMHUV7lAlKhDj9MgYz84E5e1R2kPoV4uxRbB3C9ABJdCugw6ae/zzKU
	GCLC6v0sRyn9TaGGUWOU2nyBqRSN0qc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771340737;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0a5QgKrPsYbt60SbyVxiqxH8fETr4Fl9YLE29T4uFAE=;
	b=7QjNi51n+xrXxPfAKxS8Yq87y3pdI3mvkl55IYVvai+FqJdyuO3ehIRbxBcr3ZzMWGSiTc
	ifv7mH6XgPcHLwDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="J/6mUaKo";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7QjNi51n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771340737; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0a5QgKrPsYbt60SbyVxiqxH8fETr4Fl9YLE29T4uFAE=;
	b=J/6mUaKovJKQpCE2FRf7ofomfxNE4TfvW4c3AhyTHfkqER5jb1M6GQSNELOMdDdGocdlYn
	kj+Au7n+6A3RqIuNMHUV7lAlKhDj9MgYz84E5e1R2kPoV4uxRbB3C9ABJdCugw6ae/zzKU
	GCLC6v0sRyn9TaGGUWOU2nyBqRSN0qc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771340737;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0a5QgKrPsYbt60SbyVxiqxH8fETr4Fl9YLE29T4uFAE=;
	b=7QjNi51n+xrXxPfAKxS8Yq87y3pdI3mvkl55IYVvai+FqJdyuO3ehIRbxBcr3ZzMWGSiTc
	ifv7mH6XgPcHLwDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 96F4F3EA65;
	Tue, 17 Feb 2026 15:05:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WmpaI8GDlGnoBwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 17 Feb 2026 15:05:37 +0000
Message-ID: <d4aeb7b2-f141-4113-a207-d27eaa303686@suse.de>
Date: Tue, 17 Feb 2026 16:05:37 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: WTF: patch "[PATCH] fbcon: Remove struct fbcon_display.inverse"
 was seriously submitted to be applied to the 6.1-stable tree?
To: gregkh@linuxfoundation.org, deller@gmx.de, stable@vger.kernel.org
References: <2026021751-prefix-delivery-06f4@gregkh>
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
In-Reply-To: <2026021751-prefix-delivery-06f4@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216844-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[linuxfoundation.org,gmx.de,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tzimmermann@suse.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.de:mid,suse.de:dkim,suse.de:email,linuxfoundation.org:email,gmx.de:email]
X-Rspamd-Queue-Id: 3A8FB14D65F
X-Rspamd-Action: no action

Hi

Am 17.02.26 um 13:55 schrieb gregkh@linuxfoundation.org:
> The patch below was submitted to be applied to the 6.1-stable tree.
>
> I fail to see how this patch meets the stable kernel rules as found at
> Documentation/process/stable-kernel-rules.rst.
>
> I could be totally wrong, and if so, please respond to
> <stable@vger.kernel.org> and let me know why this patch should be
> applied.  Otherwise, it is now dropped from my patch queues, never to be
> seen again.

This patch originally had a Fixes tag, so it also got a CC: stable. The 
Fixes didn't belong there, but the CC was erroneously kept. Please 
ignore the patch in all stable branches.

Apologies for this mistake.

Best regards
Thomas

>
> thanks,
>
> greg k-h
>
> ------------------ original commit in Linus's tree ------------------
>
>  From 30baedeeeab524172abc0b58cb101e8df86b5be8 Mon Sep 17 00:00:00 2001
> From: Thomas Zimmermann <tzimmermann@suse.de>
> Date: Mon, 9 Feb 2026 17:15:43 +0100
> Subject: [PATCH] fbcon: Remove struct fbcon_display.inverse
>
> The field inverse in struct fbcon_display is unused. Remove it.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: <stable@vger.kernel.org> # v6.0+
> Signed-off-by: Helge Deller <deller@gmx.de>
>
> diff --git a/drivers/video/fbdev/core/fbcon.h b/drivers/video/fbdev/core/fbcon.h
> index 1cd10a7faab0..fca14e9b729b 100644
> --- a/drivers/video/fbdev/core/fbcon.h
> +++ b/drivers/video/fbdev/core/fbcon.h
> @@ -30,7 +30,6 @@ struct fbcon_display {
>   #ifdef CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION
>       u_short scrollmode;             /* Scroll Method, use fb_scrollmode() */
>   #endif
> -    u_short inverse;                /* != 0 text black on white as default */
>       short yscroll;                  /* Hardware scrolling */
>       int vrows;                      /* number of virtual rows */
>       int cursor_shape;
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)



