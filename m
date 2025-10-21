Return-Path: <stable+bounces-188326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 612FEBF6022
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 13:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 163B23A3514
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 11:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671482F5A3B;
	Tue, 21 Oct 2025 11:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zKAUFWWH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="by5weifs";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="y1UCChm1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OOAcYaG9"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7AC2EA75C
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 11:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761045869; cv=none; b=Pw1QT+mIKEd5Ll6fzntyxil1caeXMWx3c5ytP5qrCRh1PFapN6cJu3w9fDCcec73o/HCyyhndY0+zfPeLl7gWXQXk/w0tutatL+75psqG0N3810FuJpNIExuzAkp25ssoapTDFOz0p+rzTBdpOgHfOKCa884vKQgfFgTWxlUM9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761045869; c=relaxed/simple;
	bh=2yVYtAEdk5n82up6JX6DPq8zoDVdgduCVwE7UCgkdHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u8hQkVFWSxtET3VxRFNsPLBJiGQ3IqzUQueEE14LoGpHrvj941L+LLg9MQ3Q95Qtc5e2XhrEaZpjyPz9hJITOShaLCkh6TwZ5aYEGPncjnhPMXEx/rWkn44HY9lpBuYUmIxE01tw0BG2up117VwJKjKHTZdZ9U34teCMDaUxT5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zKAUFWWH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=by5weifs; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=y1UCChm1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OOAcYaG9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 830572116C;
	Tue, 21 Oct 2025 11:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761045861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6k+JrnOD8S8rjh/qeXDN7dKhqTLfunFUoQT/6jJZft4=;
	b=zKAUFWWHEVCjfsZClwPz66i2n99nPJ/BWdSebRjqZf3egYg7o3GpRKNhHx66xLon3u31PS
	t/K29gBFLvQt5qU99kgRVflsZs/YA08IObOOylKJn9KxUMEjlD0/lbhN7i4Dr3cP9LFaMG
	cZJ9c87f8CZ748zHdhq9zDcNQLT97A4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761045861;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6k+JrnOD8S8rjh/qeXDN7dKhqTLfunFUoQT/6jJZft4=;
	b=by5weifsKFCp7nLaOkdALZ9HmmZfzmX9CArPbqHYVEEFo7BQXG7BpMLZho7CJF9cVJO+ZI
	n/ar3XKgBbUYMUCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761045857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6k+JrnOD8S8rjh/qeXDN7dKhqTLfunFUoQT/6jJZft4=;
	b=y1UCChm13j4l0NppKmY7t01u1THTFXFahbMPy0NFDBWYafbrmO4g5S+MR5lsqR/dN7PxnD
	HtfE7sFg+79ANCyP/aXMp95bvbIFHZl5AkeCsl8wR+Ih9NM2RMiFcZQ/FbkuQAAnmRXwWm
	MMUWyajLGxbDRVm+gUpY4E08SViSfSA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761045857;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6k+JrnOD8S8rjh/qeXDN7dKhqTLfunFUoQT/6jJZft4=;
	b=OOAcYaG9Wpg0n/Q2itF8xOZrWTkLp7IPr/uKGsMEu0QoG4sI8L8POaIYCZ+VsxjGa1uvb+
	p35jRxPcSLAuQ8Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 42E99139D2;
	Tue, 21 Oct 2025 11:24:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bHLjDmFt92jXOgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 21 Oct 2025 11:24:17 +0000
Message-ID: <13bc66cd-a63b-44b9-92fb-98b5b36ce2dd@suse.de>
Date: Tue, 21 Oct 2025 13:24:16 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] drm/panic: Fixes found with kunit.
To: Jocelyn Falempe <jfalempe@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Javier Martinez Canillas <javierm@redhat.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org
References: <20251009122955.562888-1-jfalempe@redhat.com>
 <f8f1e0ec-46fe-4d71-94aa-bdd081ec35fb@redhat.com>
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
In-Reply-To: <f8f1e0ec-46fe-4d71-94aa-bdd081ec35fb@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,vger.kernel.org,lists.freedesktop.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30

Hi

Am 21.10.25 um 11:35 schrieb Jocelyn Falempe:
> On 09/10/2025 14:24, Jocelyn Falempe wrote:
>> A few fixes for drm panic, that I found when writing unit tests with 
>> kunit.
>
> Pushed to drm-misc-fixes.

There are many patches without Fixes tag here. Commits in -fixes should 
preferably have a Fixes tag to help with backporting. No need to revert, 
but something to keep in mind for next time.

Best regards
Thomas

>
> Thanks Javier for your reviews.
>
>>
>> Jocelyn Falempe (6):
>>    drm/panic: Fix drawing the logo on a small narrow screen
>>    drm/panic: Fix overlap between qr code and logo
>>    drm/panic: Fix qr_code, ensure vmargin is positive
>>    drm/panic: Fix kmsg text drawing rectangle
>>    drm/panic: Fix divide by 0 if the screen width < font width
>>    drm/panic: Fix 24bit pixel crossing page boundaries
>>
>>   drivers/gpu/drm/drm_panic.c | 60 +++++++++++++++++++++++++++++++++----
>>   1 file changed, 54 insertions(+), 6 deletions(-)
>>
>>
>> base-commit: e4bea919584ff292c9156cf7d641a2ab3cbe27b0
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)



