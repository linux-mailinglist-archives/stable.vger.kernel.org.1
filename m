Return-Path: <stable+bounces-245394-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHS1L8jJAmrmwgEAu9opvQ
	(envelope-from <stable+bounces-245394-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 08:33:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D1051B135
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 08:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7A5930F67CB
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 06:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A14225B0AD;
	Tue, 12 May 2026 06:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bMI1na/+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hif2veEs";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AxQcbV3G";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AbmOTUUj"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253DE4E379B
	for <stable@vger.kernel.org>; Tue, 12 May 2026 06:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778567221; cv=none; b=M5BuSHonMkMjOZt5U2RBHyb+0G4Xv9vfrjK4Y3zumr9GV0+zODglj49P8UO5eXsI0f0WJcpbA47qqCo+T/VTK+XceNj2s/nN+Gt3fKV44qgUUHTvoIeFF9roVkZ6BFQChL7kooyLWe9yloWOnif8MNaGZa2HKmGqSUHSoT0Ti/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778567221; c=relaxed/simple;
	bh=CIiKjFJY7S48sBhowbP4ajNlaMKpYLp2FH4BZzz1QZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E6AGKaXRovnbvY/PKU3JALuu6Zi3tW6BKlW3qgreMZlOKuPIZAgPPrhdJMKlLIXouyor9VkdYb/sRIcvEdwWglycS0WWYuGPjX8Fd//niU8MdkRsekmPqQYMPt9SBv15vETG0Oo3Szisy0IUgzOOCtmO6igYEFCSlEhwzWi5+CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bMI1na/+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hif2veEs; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AxQcbV3G; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AbmOTUUj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B65806BF76;
	Tue, 12 May 2026 06:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778567204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gGdWoPQ+bTNVcVEUOfkou5v7qcXtSEQgxjBxBCUyGCE=;
	b=bMI1na/+MwgF73Y2ASNGKrvdDI/K0uQLRmUvEhgq/0Peo5PPcSjbeaCQvZWbA1WeXpQ7yy
	4aaywo3/figlXf4rWVk/cCxc4r0xs5jElnVHL1Iey5mG8hwudxJ45+ljFTdtbxTfD3CQ7L
	/EHsTGyzjc1gGWyoKa0AD6cwnL3/e4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778567204;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gGdWoPQ+bTNVcVEUOfkou5v7qcXtSEQgxjBxBCUyGCE=;
	b=hif2veEshB0axeHWNyB7e8p1RW10HMLQ8g7FS5y+gIVqPebE3mIeAXtr/mQEJNvr4NCBvO
	kedSyLIOvNYnFrCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AxQcbV3G;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=AbmOTUUj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778567203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gGdWoPQ+bTNVcVEUOfkou5v7qcXtSEQgxjBxBCUyGCE=;
	b=AxQcbV3GlqLmFFAz3Ni3tIVK4mpYq0+fvg8k6zOkX6TM7DpOMKBUFtIcTYuE4XGA7eemuY
	OFmk3T1ZuFHhyMeoZQ8kEx9/wxFLEZrLlY9XXLNpeZN+YG57EsVRBDK0+cEINJxBg8iWiB
	SmF7BRNzi/K1Gsmhvi0gNaqQpllRVMI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778567203;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gGdWoPQ+bTNVcVEUOfkou5v7qcXtSEQgxjBxBCUyGCE=;
	b=AbmOTUUjK09ClLzW0nEHrosDDhRW9jG/PFYPUs+v8j8pGVWNCOh+lhIWNftofeg6fDoKHJ
	276r+bzYuDSVm5Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 06DC3593A9;
	Tue, 12 May 2026 06:26:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Eol4OyHIAmqbAgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 12 May 2026 06:26:41 +0000
Message-ID: <eb236f5d-e185-418c-9ea1-780e8b1f985b@suse.de>
Date: Tue, 12 May 2026 08:26:41 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/loongson: clean up KMS polling on probe failure
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>, Myeonghun Pak
 <mhun512@gmail.com>, dri-devel@lists.freedesktop.org
Cc: Sui Jingfeng <suijingfeng@loongson.cn>, Jianmin Lv
 <lvjianmin@loongson.cn>, Qianhai Wu <wuqianhai@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>, Mingcong Bai <jeffbai@aosc.io>,
 Xi Ruoyao <xry111@xry111.site>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
References: <20260511170152.16957-1-mhun512@gmail.com>
 <3ee00ebc4ff5bcf2a8754466f8d9d04b24f81858.camel@iscas.ac.cn>
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
In-Reply-To: <3ee00ebc4ff5bcf2a8754466f8d9d04b24f81858.camel@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 21D1051B135
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[loongson.cn,kernel.org,aosc.io,xry111.site,linux.intel.com,gmail.com,ffwll.ch,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-245394-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[iscas.ac.cn,gmail.com,lists.freedesktop.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tzimmermann@suse.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:mid,suse.de:dkim,suse.com:url]
X-Rspamd-Action: no action

Hi

Am 11.05.26 um 19:22 schrieb Icenowy Zheng:
> 在 2026-05-12二的 02:01 +0900，Myeonghun Pak写道：
>> lsdc_pci_probe() initializes KMS polling before setting up vblank
>> support,
>> requesting the IRQ and registering the DRM device. If any of those
>> later
>> steps fails, probe returns without finalizing polling. The remove
>> path has
>> the same lifetime gap when tearing down a successfully registered
>> device.
>>
>> Route those probe failures through a poll cleanup label. Also
>> finalize
>> polling from remove before unregistering the DRM device.
> Interesting, but it looks like a `drmm_kms_helper_poll_init` function
> exists (while rarely used).
>
> Maybe it's better to switch to this? Or maybe there's some reason not
> to use this?

Agreed. DRM drivers are advised to use managed cleanup for their data 
structures. So rather switch to drmm_kms_helper_poll_init(). That also 
resolves the problem that loongson never calls poll_fini on regular 
removals.

Best regards
Thomas

>
> Thanks,
> Icenowy
>
>> This issue was identified during our ongoing static-analysis research
>> while
>> reviewing kernel code.
>>
>> Fixes: f39db26c5428 ("drm: Add kms driver for loongson display
>> controller")
>> Cc: stable@vger.kernel.org
>> Co-developed-by: Ijae Kim <ae878000@gmail.com>
>> Signed-off-by: Ijae Kim <ae878000@gmail.com>
>> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
>> ---
>>   drivers/gpu/drm/loongson/lsdc_drv.c | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/loongson/lsdc_drv.c
>> b/drivers/gpu/drm/loongson/lsdc_drv.c
>> index abf5bf68ee..3db1f8690a 100644
>> --- a/drivers/gpu/drm/loongson/lsdc_drv.c
>> +++ b/drivers/gpu/drm/loongson/lsdc_drv.c
>> @@ -297,7 +297,7 @@ static int lsdc_pci_probe(struct pci_dev *pdev,
>> const struct pci_device_id *ent)
>>   	if (loongson_vblank) {
>>   		ret = drm_vblank_init(ddev, descp->num_of_crtc);
>>   		if (ret)
>> -			return ret;
>> +			goto err_poll_fini;
>>   
>>   		ret = devm_request_irq(&pdev->dev, pdev->irq,
>>   				       descp->funcs->irq_handler,
>> @@ -305,7 +305,7 @@ static int lsdc_pci_probe(struct pci_dev *pdev,
>> const struct pci_device_id *ent)
>>   				       dev_name(&pdev->dev), ddev);
>>   		if (ret) {
>>   			drm_err(ddev, "Failed to register interrupt:
>> %d\n", ret);
>> -			return ret;
>> +			goto err_poll_fini;
>>   		}
>>   
>>   		drm_info(ddev, "registered irq: %u\n", pdev->irq);
>> @@ -313,17 +313,22 @@ static int lsdc_pci_probe(struct pci_dev *pdev,
>> const struct pci_device_id *ent)
>>   
>>   	ret = drm_dev_register(ddev, 0);
>>   	if (ret)
>> -		return ret;
>> +		goto err_poll_fini;
>>   
>>   	drm_client_setup(ddev, NULL);
>>   
>>   	return 0;
>> +
>> +err_poll_fini:
>> +	drm_kms_helper_poll_fini(ddev);
>> +	return ret;
>>   }
>>   
>>   static void lsdc_pci_remove(struct pci_dev *pdev)
>>   {
>>   	struct drm_device *ddev = pci_get_drvdata(pdev);
>>   
>> +	drm_kms_helper_poll_fini(ddev);
>>   	drm_dev_unregister(ddev);
>>   	drm_atomic_helper_shutdown(ddev);
>>   }

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)



