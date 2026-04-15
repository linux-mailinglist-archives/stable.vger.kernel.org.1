Return-Path: <stable+bounces-238048-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wF5VGEEs32nOPgAAu9opvQ
	(envelope-from <stable+bounces-238048-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 08:12:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B731B400C25
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 08:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0AD230AAE98
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 06:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36B635DA68;
	Wed, 15 Apr 2026 06:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TKqqlwJ6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="t9JFNFUS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dfX3skgD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wxXogbEL"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166E01C84D7
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 06:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776233368; cv=none; b=n6FoEMkFn5yAjsShbQxTI3zfrnHTo7OAQVNtWuF+FBpJ3Q8yTktgD1bAabEcJu+3UkP+H3kbkN8ezTk0IZ91M5PbFVHSwcQ8PRlgnEXms2PELWYmOfv4h7Pim2xQvmP8bO8+VWnLwVbGVy2lusS1FhWfs73d86mg35n9oqT0toM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776233368; c=relaxed/simple;
	bh=k0PaPfNx2tZ5WP1kFzX8K0m08tFd4ELvXloLky7W9YY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TBxuqwMS8FcUOFG93cFLkeID6zzL+CRhg4ca2Cx02ujXq8ClIT3sRUupVevMgmRjcUEOt72MP6TR45EqWYQCmPfGJyEK1fYh0o7iOFEK4bOdTABAdZD2Vgz3I90dJmCtGEhbGYd9sKdhPA8H2M+7nzBom1l+++u68I7w9+MaTJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TKqqlwJ6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=t9JFNFUS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dfX3skgD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wxXogbEL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1F5575BDFC;
	Wed, 15 Apr 2026 06:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776233365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kHMPLy7s1GXBV0H5yYDYDF1b1j44/dHbNL91eI03PuQ=;
	b=TKqqlwJ6tOdN9NEil0KcCFbqo2K6fROSGbh2lDiFHNDwvWebPYA0FPMSU0Rf3Q96bImBwx
	a7q8ltZ7C2I1KJtc8e/+J+VEBlsmoz21BNABCTCM0x3ObHNGRIozqvEvQkSYzHK3bK9QxZ
	tM5xkvIwjUZlOvKUh3hREix5loJkIM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776233365;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kHMPLy7s1GXBV0H5yYDYDF1b1j44/dHbNL91eI03PuQ=;
	b=t9JFNFUSKO3DCs1SLe/wa2o9AACQnKYASR0ZqaityB+3wF4QPHrnMnGZ/dNc90HHCH4iK4
	fHvqIMcxI3Eqj0Bw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dfX3skgD;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wxXogbEL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776233364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kHMPLy7s1GXBV0H5yYDYDF1b1j44/dHbNL91eI03PuQ=;
	b=dfX3skgDG4awo8/WimpVqdw5RsNdLJ7E81QCIVAcw4KTl3Ow7tdyKoUs6Ox1rQy+sJynwD
	AXsa0f5US3R+dfxXhQIdCsWmgQCT+vCG5fyoFX05Wz/2VaX3ROZOK43ngQAECfulHjjqhe
	Iqs1tJ69IQXkZsC3bfYzuk7Rgjn8weE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776233364;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kHMPLy7s1GXBV0H5yYDYDF1b1j44/dHbNL91eI03PuQ=;
	b=wxXogbEL+Aa8XfhQNmhG2d1leBO/X6WcN0VmtTKXW8bc/n+0+UIaEpc2oQM4gfrKBClN9l
	jDuR8GFKu2L317Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9DB644B86A;
	Wed, 15 Apr 2026 06:09:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JoVlJJMr32kuMQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 15 Apr 2026 06:09:23 +0000
Message-ID: <80e2d151-6774-4285-87bb-d68682c8c342@suse.de>
Date: Wed, 15 Apr 2026 08:09:23 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drm/hibmc: Fix list of formats on the primary plane
To: Yongbang Shi <shiyongbang@huawei.com>, xinliang.liu@linaro.org,
 tiantao6@hisilicon.com, kong.kongxinwei@hisilicon.com,
 sumit.semwal@linaro.org, yongqin.liu@linaro.org, jstultz@google.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, Rongrong Zou <zourongrong@gmail.com>,
 Sean Paul <seanpaul@chromium.org>, Dmitry Baryshkov <lumag@kernel.org>,
 Baihan Li <libaihan@huawei.com>, stable@vger.kernel.org
References: <20260413085037.17491-1-tzimmermann@suse.de>
 <20260413085037.17491-3-tzimmermann@suse.de>
 <0668b6ec-b844-4fef-804c-91e488b39516@huawei.com>
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
In-Reply-To: <0668b6ec-b844-4fef-804c-91e488b39516@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,gmail.com,chromium.org,kernel.org,huawei.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-238048-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[huawei.com,linaro.org,hisilicon.com,google.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.de:dkim,suse.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B731B400C25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi

Am 15.04.26 um 05:19 schrieb Yongbang Shi:
[...]
> Also, I looked at the commit history, and this format was already
> present in the first version of the hibmc driver. This is a historic
> issue, and it's a bit difficult to determine why it was implemented this
> way.

It's probably left over from the prototype. Back then, DRM was also less 
well structured and it might have been harder to see what's really needed.

>>
>> Reviewed-by: Yongbang Shi <shiyongbang@huawei.com>

Thanks.

Best regards
Thomas

>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)



