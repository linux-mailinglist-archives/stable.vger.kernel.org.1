Return-Path: <stable+bounces-56317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7947A91EFE8
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 09:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05BF11F2187F
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 07:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C28C12DDAF;
	Tue,  2 Jul 2024 07:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nuz7OtPe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CRxqlIcv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nuz7OtPe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CRxqlIcv"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DA3537E7
	for <stable@vger.kernel.org>; Tue,  2 Jul 2024 07:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719904682; cv=none; b=H1fn+AkB3howqglQF+N8CL5u2G0u3QuAvk6MZQrQZEVoqxhSc3dAgK0XjO968/pvsl7UdeMAKIXe+1uS5OmQVUtmb8BIX86DWit/tx8eZ7+40Hum0Oe8x8qDIz6Pmyc51Lnrr0qts5FrZO8SxuVKiWaLF391lKz6FtJM9SetXaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719904682; c=relaxed/simple;
	bh=YwnYzHDvLoAmyGYw17Wwjkcu+at6c1OsI82d60GRNu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oA7yQN9EihFHD0+lIkfiyH9zN3uLhC/hGeB1Y3h/CDjO+MiNl9kaUebL0RLrYTN6qCjYJRuVaOV2L6xR2xJEjHopoC587VnjuIavkQNXzVCM0w+jmGTvDPym0F/IzPPxMH0AIPTZPKzy8kgZi6Rd/VTOi1nH3HFxi+a5j83qyjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nuz7OtPe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CRxqlIcv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nuz7OtPe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CRxqlIcv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 89D4921AD7;
	Tue,  2 Jul 2024 07:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719904678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wrh7qcN1wQ5bQ0Yma+yB5g5qFo7ZdFK/zJVI/uYxrdQ=;
	b=nuz7OtPe7jkCoOrVJpDTYbdqKPzjz6ib+Nhq//pZgSdDSVZyaeYlLB7bAf/d5wOILoRF5n
	P48fWLoYkzJcsGh9UB9wZI25eJhiS2uWUi1sUbh3+1b4ah4iP2uu+mRGf43EvH2QZY+Vjq
	VAD6EKD+oaOX0lvMVczWGNxDD6YCgDs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719904678;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wrh7qcN1wQ5bQ0Yma+yB5g5qFo7ZdFK/zJVI/uYxrdQ=;
	b=CRxqlIcvo5O4zvwdo4bOA2nRW+S2TF8J8mygJytI22huegpe5z1cIGb1f6/811S1ciu6rM
	TnGSUiPYgW6qapBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719904678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wrh7qcN1wQ5bQ0Yma+yB5g5qFo7ZdFK/zJVI/uYxrdQ=;
	b=nuz7OtPe7jkCoOrVJpDTYbdqKPzjz6ib+Nhq//pZgSdDSVZyaeYlLB7bAf/d5wOILoRF5n
	P48fWLoYkzJcsGh9UB9wZI25eJhiS2uWUi1sUbh3+1b4ah4iP2uu+mRGf43EvH2QZY+Vjq
	VAD6EKD+oaOX0lvMVczWGNxDD6YCgDs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719904678;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wrh7qcN1wQ5bQ0Yma+yB5g5qFo7ZdFK/zJVI/uYxrdQ=;
	b=CRxqlIcvo5O4zvwdo4bOA2nRW+S2TF8J8mygJytI22huegpe5z1cIGb1f6/811S1ciu6rM
	TnGSUiPYgW6qapBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 410041395F;
	Tue,  2 Jul 2024 07:17:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +VqcDqapg2ZLAgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 02 Jul 2024 07:17:58 +0000
Message-ID: <aa9410e7-1ad8-49f4-a31e-59e7d9543421@suse.de>
Date: Tue, 2 Jul 2024 09:17:57 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: sysfb: Fix reference count of sysfb parent
 device
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Cc: javierm@redhat.com, dri-devel@lists.freedesktop.org,
 Helge Deller <deller@gmx.de>, Jani Nikula <jani.nikula@intel.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Sui Jingfeng <suijingfeng@loongson.cn>, stable@vger.kernel.org
References: <20240625081818.15696-1-tzimmermann@suse.de>
 <CAAxE2A68QveD4nNa_OyQQHYSdbvArck6oWnV7YsmWC89B8x=yA@mail.gmail.com>
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
In-Reply-To: <CAAxE2A68QveD4nNa_OyQQHYSdbvArck6oWnV7YsmWC89B8x=yA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.29
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,lists.freedesktop.org,gmx.de,intel.com,linaro.org,arndb.de,loongson.cn,vger.kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,linaro.org:email]

Hi

Am 28.06.24 um 20:54 schrieb Marek Olšák:
> Hi Thomas,
>
> FYI, this doesn't fix the issue of lightdm not being able to start for me.

Of course, that's expected. It's a different bug.

Best regards
Thomas

>
> Marek
>
>
> Marek
>
> On Tue, Jun 25, 2024 at 4:18 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
>> Retrieving the system framebuffer's parent device in sysfb_init()
>> increments the parent device's reference count. Hence release the
>> reference before leaving the init function.
>>
>> Adding the sysfb platform device acquires and additional reference
>> for the parent. This keeps the parent device around while the system
>> framebuffer is in use.
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Fixes: 9eac534db001 ("firmware/sysfb: Set firmware-framebuffer parent device")
>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>> Cc: Javier Martinez Canillas <javierm@redhat.com>
>> Cc: Helge Deller <deller@gmx.de>
>> Cc: Jani Nikula <jani.nikula@intel.com>
>> Cc: Dan Carpenter <dan.carpenter@linaro.org>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Sui Jingfeng <suijingfeng@loongson.cn>
>> Cc: <stable@vger.kernel.org> # v6.9+
>> ---
>>   drivers/firmware/sysfb.c | 13 +++++++++----
>>   1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/firmware/sysfb.c b/drivers/firmware/sysfb.c
>> index 880ffcb50088..dd274563deeb 100644
>> --- a/drivers/firmware/sysfb.c
>> +++ b/drivers/firmware/sysfb.c
>> @@ -101,8 +101,10 @@ static __init struct device *sysfb_parent_dev(const struct screen_info *si)
>>          if (IS_ERR(pdev)) {
>>                  return ERR_CAST(pdev);
>>          } else if (pdev) {
>> -               if (!sysfb_pci_dev_is_enabled(pdev))
>> +               if (!sysfb_pci_dev_is_enabled(pdev)) {
>> +                       pci_dev_put(pdev);
>>                          return ERR_PTR(-ENODEV);
>> +               }
>>                  return &pdev->dev;
>>          }
>>
>> @@ -137,7 +139,7 @@ static __init int sysfb_init(void)
>>          if (compatible) {
>>                  pd = sysfb_create_simplefb(si, &mode, parent);
>>                  if (!IS_ERR(pd))
>> -                       goto unlock_mutex;
>> +                       goto put_device;
>>          }
>>
>>          /* if the FB is incompatible, create a legacy framebuffer device */
>> @@ -155,7 +157,7 @@ static __init int sysfb_init(void)
>>          pd = platform_device_alloc(name, 0);
>>          if (!pd) {
>>                  ret = -ENOMEM;
>> -               goto unlock_mutex;
>> +               goto put_device;
>>          }
>>
>>          pd->dev.parent = parent;
>> @@ -170,9 +172,12 @@ static __init int sysfb_init(void)
>>          if (ret)
>>                  goto err;
>>
>> -       goto unlock_mutex;
>> +
>> +       goto put_device;
>>   err:
>>          platform_device_put(pd);
>> +put_device:
>> +       put_device(parent);
>>   unlock_mutex:
>>          mutex_unlock(&disable_lock);
>>          return ret;
>> --
>> 2.45.2
>>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


