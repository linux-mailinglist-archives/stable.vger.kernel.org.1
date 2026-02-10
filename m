Return-Path: <stable+bounces-215624-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHjUOhf1imkNPAAAu9opvQ
	(envelope-from <stable+bounces-215624-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 10:06:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFA81188BE
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 10:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 819D7302DA3D
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 09:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA2E33EB1B;
	Tue, 10 Feb 2026 09:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rryLx/vv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TgCAGtR1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rryLx/vv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TgCAGtR1"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B6933DEE9
	for <stable@vger.kernel.org>; Tue, 10 Feb 2026 09:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770714387; cv=none; b=NVNvmlQ1QdU5hERRNg+uULOd4qUYx09ssv/cYZKe29hfmZ3hBO4vgARWwXNqPtOzSbVjfoQjtY0EcfbUmzNuD12zcfmFNLMJGAR3UU8KKyNbeTioyFXSSCAOw5lIwfmBHHUEs1L6hfYAHcMlOZ65if+VJD9cdOT41wQfOdMbI8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770714387; c=relaxed/simple;
	bh=U18CLTNG8sEzss/Ty+AvhRxvPqgYXgM1Z66fgMb+e9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vu+hE0bAHNUnu5LFFDAd0PjraV9zHrWK+IzYDmP9fSTA7Hq4vqMP9IuwugE+fW+itXlagrIuABkfQmXRdwsl+k0/nwSyrJKdtPSmkJr70ZzzTz/UxqAZ8prg4ZdtxqnLTuqObf8FI8NIHg+a/d8oE3bzo8SgmTuwh56ZGLKDwus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rryLx/vv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TgCAGtR1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rryLx/vv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TgCAGtR1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 010B45BCD3;
	Tue, 10 Feb 2026 09:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770714383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2zZ/wKM3Ns11Odbs9dhoE5BBxpUvbuB2Bbz9Jl/8EqU=;
	b=rryLx/vv4m6GWCSeTlhQd2ZhsZKU4CI8RUJqDIAWB8ly3P0L1s3xUbwLGsoCn6fOk4HJBi
	hokgLeSWzQqVX1eYy55hxvQd9ak0CjnCAMfMT8MQ+tcA1jqT/Nw+o/zruompoIx7AMiYR8
	FgrkLyOsG4HS0k8LIlxn5rgXOZslNaU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770714383;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2zZ/wKM3Ns11Odbs9dhoE5BBxpUvbuB2Bbz9Jl/8EqU=;
	b=TgCAGtR1ALgaBugqSm0XdwVzsNxCTpOo9TwobehaVH96qmU5iq6WgimPnggye8m/LBTRfU
	r0wCk0icWRIxM9Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770714383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2zZ/wKM3Ns11Odbs9dhoE5BBxpUvbuB2Bbz9Jl/8EqU=;
	b=rryLx/vv4m6GWCSeTlhQd2ZhsZKU4CI8RUJqDIAWB8ly3P0L1s3xUbwLGsoCn6fOk4HJBi
	hokgLeSWzQqVX1eYy55hxvQd9ak0CjnCAMfMT8MQ+tcA1jqT/Nw+o/zruompoIx7AMiYR8
	FgrkLyOsG4HS0k8LIlxn5rgXOZslNaU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770714383;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2zZ/wKM3Ns11Odbs9dhoE5BBxpUvbuB2Bbz9Jl/8EqU=;
	b=TgCAGtR1ALgaBugqSm0XdwVzsNxCTpOo9TwobehaVH96qmU5iq6WgimPnggye8m/LBTRfU
	r0wCk0icWRIxM9Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4CF43EA62;
	Tue, 10 Feb 2026 09:06:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id puLYLg71imn1VAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 10 Feb 2026 09:06:22 +0000
Message-ID: <a4f65f26-f577-4029-b0cc-db9da95222dd@suse.de>
Date: Tue, 10 Feb 2026 10:06:22 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbcon: Remove struct fbcon_display.inverse
To: Helge Deller <deller@gmx.de>, geert@linux-m68k.org
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org
References: <20260209161609.251510-1-tzimmermann@suse.de>
 <3e70bea8-aa35-4cfd-9e54-eaeaa7b5267a@gmx.de>
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
In-Reply-To: <3e70bea8-aa35-4cfd-9e54-eaeaa7b5267a@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-215624-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de,linux-m68k.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tzimmermann@suse.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-m68k.org:email,suse.de:mid,suse.de:dkim,suse.de:email,suse.com:url]
X-Rspamd-Queue-Id: 4DFA81188BE
X-Rspamd-Action: no action

Hi

Am 09.02.26 um 22:31 schrieb Helge Deller:
> On 2/9/26 17:15, Thomas Zimmermann wrote:
>> The field inverse in struct fbcon_display is unused. Remove it.
>
> Indeed, seems to be unused.
>
>> The field apparently never did anything. Commit c7ef5e285c84 ("video:
>> fbdev: atari: Fix inverse handling") converted its final user to call
>> fb_invert_cmaps() instead.
>
> That commit seems not to be related, as it touches a static
> inverse variable inside the atafb driver only.
> Commit e4fc27618b75 (from 2005) touched it last time, but it seems 
> even older.

Oh well. What a stupid mistake...

>
> Patch applied to fbdev, but I dropped the wrong commit reference in the
> commit message.

Thanks a lot.

Best regards,
Thomas

>
> Thanks!
> Helge
>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Fixes: c7ef5e285c84 ("video: fbdev: atari: Fix inverse handling")
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Cc: Helge Deller <deller@gmx.de>
>> Cc: <stable@vger.kernel.org> # v6.0+
>> ---
>>   drivers/video/fbdev/core/fbcon.h | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/video/fbdev/core/fbcon.h 
>> b/drivers/video/fbdev/core/fbcon.h
>> index 1cd10a7faab0..fca14e9b729b 100644
>> --- a/drivers/video/fbdev/core/fbcon.h
>> +++ b/drivers/video/fbdev/core/fbcon.h
>> @@ -30,7 +30,6 @@ struct fbcon_display {
>>   #ifdef CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION
>>       u_short scrollmode;             /* Scroll Method, use 
>> fb_scrollmode() */
>>   #endif
>> -    u_short inverse;                /* != 0 text black on white as 
>> default */
>>       short yscroll;                  /* Hardware scrolling */
>>       int vrows;                      /* number of virtual rows */
>>       int cursor_shape;
>
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)



