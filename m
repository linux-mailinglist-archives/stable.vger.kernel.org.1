Return-Path: <stable+bounces-78226-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E258989B0B
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 09:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A37DB20A31
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 07:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B123155738;
	Mon, 30 Sep 2024 07:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PZ47fVQl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ftifLR3a";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i5nQ+cL7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="A6JZmWjX"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439603F8F7;
	Mon, 30 Sep 2024 07:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727680000; cv=none; b=B6T/5TUgSJS48oku5FcxnZoDfxe7kHHQHLsYi4dUd6Eev3gjabWX1SSK/bTZR9t74qkbbv0eOdpy57tj0myH4kvLfqD889X7q6AjJdwnjXiDQ38KFo3epIpj2ys/ucTqZCVyD3AoEz71pYO5X1qrjwM6f3DwyRatQOOheEWLabw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727680000; c=relaxed/simple;
	bh=PotLZwDi5Yn3It3Pes6b0XwMPfc9wuQfYXMsEM/VJbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LFw+fIUj+ks0GyetPzRpnmWq+7rlPYT0bWArQr+esrze0Y0958/vm5XVjMNlBS1U7w4ROC0VMfCaZKr8AStvEPzSBb80Nvc6BXLrkYuJrGD0H94XFPBazvlIEBQl0LllBd75QYYTbK2uw3uqWEW0hX0EiNWmllKY1xXEU3c6O98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PZ47fVQl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ftifLR3a; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i5nQ+cL7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=A6JZmWjX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 745BB1F7F6;
	Mon, 30 Sep 2024 07:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727679996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=177nEv4uUYwMiSy4ojSffrx/NKqvcPjca2MWS5tDcDg=;
	b=PZ47fVQlDngNztm9ejPF2XihQLVorhV6b92VvwpP5xkBUEWoJ4sJzNZ9lKMMgmTO//D00m
	KQfUQwjAf214Zx7V/fH0g7uNHJneG0Y2hzkMNdCwqBPiLZZCbklnz5j7epSlEwEYgTqxNR
	wbCie2yFb1oPh4QfFj3j4YQ5PdoIoRM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727679996;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=177nEv4uUYwMiSy4ojSffrx/NKqvcPjca2MWS5tDcDg=;
	b=ftifLR3aN9slgkSjXhmdiyJ4q8RGj0XV0P+IOZNa3uKEuxvPmhpFSgIx0eYU12oAQ/EVSq
	RanqofXNBx4gzHBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727679995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=177nEv4uUYwMiSy4ojSffrx/NKqvcPjca2MWS5tDcDg=;
	b=i5nQ+cL7VQsEkkKVnOf5SINcKBPIWIrja9dTjgsEB2JN4Xt3KpyDxHzgrsx9YMTgRrNLgs
	VlME/EMA4O3DKBaEzTL2n/VIO2xNc/+j7EF5y4bTXc3eB2ofWaTxtjfQ5l+BEOJN/YByOk
	EO75qB4kjBD6Vfg5KhqSt9LIcCTRIoI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727679995;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=177nEv4uUYwMiSy4ojSffrx/NKqvcPjca2MWS5tDcDg=;
	b=A6JZmWjXRQx6/AswvxFbvUBeTmGL8pPSNpcwt0gAuycV7W4G6rDm0LFGeRxobnvwKZDTxI
	xk135IUXxBonX4Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 33D7413AAA;
	Mon, 30 Sep 2024 07:06:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9VRSC/tN+mYGfwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 30 Sep 2024 07:06:35 +0000
Message-ID: <bcf7e1e9-b876-4efc-83ef-b48403315d31@suse.de>
Date: Mon, 30 Sep 2024 09:06:34 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/atomic_helper: Add missing NULL check for
 drm_plane_helper_funcs.atomic_update
To: Maxime Ripard <mripard@kernel.org>, Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sean Paul <seanpaul@chromium.org>, open list <linux-kernel@vger.kernel.org>
References: <20240927204616.697467-1-lyude@redhat.com>
 <htfplghwrowt4oihykcj53orgaeudo7a664ysyybint2oib3u5@lcyhfss3nyja>
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
In-Reply-To: <htfplghwrowt4oihykcj53orgaeudo7a664ysyybint2oib3u5@lcyhfss3nyja>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,linux.intel.com,gmail.com,ffwll.ch,chromium.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,lists.freedesktop.org:email]
X-Spam-Flag: NO
X-Spam-Level: 

Hi

Am 30.09.24 um 09:01 schrieb Maxime Ripard:
> Hi,
>
> On Fri, Sep 27, 2024 at 04:46:16PM GMT, Lyude Paul wrote:
>> Something I discovered while writing rvkms since some versions of the
>> driver didn't have a filled out atomic_update function - we mention that
>> this callback is "optional", but we don't actually check whether it's NULL
>> or not before calling it. As a result, we'll segfault if it's not filled
>> in.
>>
>>    rvkms rvkms.0: [drm:drm_atomic_helper_commit_modeset_disables] modeset on [ENCODER:36:Virtual-36]
>>    BUG: kernel NULL pointer dereference, address: 0000000000000000
>>    PGD 0 P4D 0
>>    Oops: Oops: 0010 [#1] PREEMPT SMP NOPTI
>>    Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20240813-1.fc40 08/13/2024
>>    RIP: 0010:0x0
>>
>> So, let's fix that.
>>
>> Signed-off-by: Lyude Paul <lyude@redhat.com>
>> Fixes: c2fcd274bce5 ("drm: Add atomic/plane helpers")
>> Cc: dri-devel@lists.freedesktop.org
>> Cc: <stable@vger.kernel.org> # v3.19+
> So we had kind of a similar argument with drm_connector_init early this
> year, but I do agree we shouldn't fault if we're missing a callback.
>
> I do wonder how we can implement a plane without atomic_update though?
> Do we have drivers in such a case?

That would likely be an output with an entirely static display. Hard to 
imaging, I think.

>
> If not, a better solution would be to make it mandatory and check it
> when registering.

Although I r-b'ed the patch already, I'd also prefer this solution.


>
> Maxime

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


