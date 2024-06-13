Return-Path: <stable+bounces-50483-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E07906962
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 11:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC19AB20C8B
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 09:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AA8140396;
	Thu, 13 Jun 2024 09:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bBOrEeBg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qXAxiDFu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bBOrEeBg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qXAxiDFu"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322391304AA;
	Thu, 13 Jun 2024 09:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718272432; cv=none; b=e6dNg7vHP/bsbaR7n5La6FDeIR1ug7vzEey1gcDP76KN0+yJo7IG1iRujYrTc/3tj4ALXcHP9LDB8KbY+jTOKKNorZ1bRKPAIlOLyIymn22k/ToQRY/84J01pCzytjZgX7Ml/RA9G6iPPWG96UEVeXLjVZJTheTXS4HFo2q/OZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718272432; c=relaxed/simple;
	bh=NdGk7Q1YPRr2F5bOdU9VtB5banUl0awxx0DNPGWouCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XVtiZ0kxwHd8mEwoQiUoXmzPugatsekuDNAnB/Dm2C/LydLHtDUcfMtt3JdM9rWrObwEkaLg5qZEPzWsbM03RFwYtXYdVii6KsyLPGTWAe5K5Hxi5SjimIMGnI6TpgVTYvhIuCBnPmuvstBesgn0+TXLl9YYzviVm+6KWLZXrmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bBOrEeBg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qXAxiDFu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bBOrEeBg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qXAxiDFu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1B9605D122;
	Thu, 13 Jun 2024 09:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718272428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6jEj8lekXr4HF5UwaMqkAoMrU2pu86s94yaGeLGdBHA=;
	b=bBOrEeBgo8zKpWg9gZz53XZ389BHerx4AqM+uYKeYYH5kR5NBZB2dxVm6kplgoOFy/cOMQ
	4TtKBZnBufjvJ8QpFgrPOtAtXMxpL0Q+lWCffcFLKmTH2izkVqvh7Zwo+0I3HqobpiwdEw
	qqAFzYN3wKWLWScJrQpsgjFHUfZCCZg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718272428;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6jEj8lekXr4HF5UwaMqkAoMrU2pu86s94yaGeLGdBHA=;
	b=qXAxiDFuPx0eQZgpBT8LjO3Dcx2zvzRi0D+eBnD8tZsvlBChc3JLrNQPkfQZJ7kkZDLEKS
	LE0xDm1WykQp8CAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bBOrEeBg;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qXAxiDFu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718272428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6jEj8lekXr4HF5UwaMqkAoMrU2pu86s94yaGeLGdBHA=;
	b=bBOrEeBgo8zKpWg9gZz53XZ389BHerx4AqM+uYKeYYH5kR5NBZB2dxVm6kplgoOFy/cOMQ
	4TtKBZnBufjvJ8QpFgrPOtAtXMxpL0Q+lWCffcFLKmTH2izkVqvh7Zwo+0I3HqobpiwdEw
	qqAFzYN3wKWLWScJrQpsgjFHUfZCCZg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718272428;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6jEj8lekXr4HF5UwaMqkAoMrU2pu86s94yaGeLGdBHA=;
	b=qXAxiDFuPx0eQZgpBT8LjO3Dcx2zvzRi0D+eBnD8tZsvlBChc3JLrNQPkfQZJ7kkZDLEKS
	LE0xDm1WykQp8CAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D8B5013A87;
	Thu, 13 Jun 2024 09:53:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2MjlMqvBamawdgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 13 Jun 2024 09:53:47 +0000
Message-ID: <eea40059-2692-4b1e-a92e-006908220f34@suse.de>
Date: Thu, 13 Jun 2024 11:53:47 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: vesafb: Detect VGA compatibility from screen
 info's VESA attributes
To: Javier Martinez Canillas <javierm@redhat.com>, deller@gmx.de,
 sam@ravnborg.org, hpa@zytor.com
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org
References: <20240613090240.7107-1-tzimmermann@suse.de>
 <87zfrpqj5y.fsf@minerva.mail-host-address-is-not-set>
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
In-Reply-To: <87zfrpqj5y.fsf@minerva.mail-host-address-is-not-set>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1B9605D122
X-Spam-Score: -4.50
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[redhat.com,gmx.de,ravnborg.org,zytor.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Hi Javier

Am 13.06.24 um 11:35 schrieb Javier Martinez Canillas:
> Thomas Zimmermann <tzimmermann@suse.de> writes:
>
> Hello Thomas,
>
>> Test the vesa_attributes field in struct screen_info for compatibility
>> with VGA hardware. Vesafb currently tests bit 1 in screen_info's
>> capabilities field, It sets the framebuffer address size and is
>> unrelated to VGA.
>>
>> Section 4.4 of the Vesa VBE 2.0 specifications defines that bit 5 in
>> the mode's attributes field signals VGA compatibility. The mode is
>> compatible with VGA hardware if the bit is clear. In that case, the
>> driver can access VGA state of the VBE's underlying hardware. The
>> vesafb driver uses this feature to program the color LUT in palette
>> modes. Without, colors might be incorrect.
>>
>> The problem got introduced in commit 89ec4c238e7a ("[PATCH] vesafb: Fix
>> incorrect logo colors in x86_64"). It incorrectly stores the mode
>> attributes in the screen_info's capabilities field and updates vesafb
>> accordingly. Later, commit 5e8ddcbe8692 ("Video mode probing support for
>> the new x86 setup code") fixed the screen_info, but did not update vesafb.
>> Color output still tends to work, because bit 1 in capabilities is
>> usually 0.
>>
> How did you find this ?

I was reading through vesafb and found that [1] and [2] look 
surprisingly similar, which makes no sense. So I started looking where 
bit 1 came from. The flag signals a 64-bit framebuffer address for EFI 
(see VIDEO_CAPABILITY_64BIT_BASE 
<https://elixir.bootlin.com/linux/latest/C/ident/VIDEO_CAPABILITY_64BIT_BASE>). 
But old VESA framebuffers are usually located within the first 32-bit 
range. So the bit is mostly 0 and vesafb works as expected.

[1] 
https://elixir.bootlin.com/linux/latest/source/drivers/video/fbdev/vesafb.c#L274
[2] 
https://elixir.bootlin.com/linux/latest/source/include/linux/screen_info.h#L26

>
>> Besides fixing the bug in vesafb, this commit introduces a helper that
>> reads the correct bit from screen_info.
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Fixes: 5e8ddcbe8692 ("Video mode probing support for the new x86 setup code")
>> Cc: <stable@vger.kernel.org> # v2.6.23+
>> ---
> The patch looks correct to me after your explanation in the commit message
> and looking at the mentioned commits.
>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Thanks a lot.

Best regards
Thomas

>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


