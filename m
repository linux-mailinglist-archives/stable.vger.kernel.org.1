Return-Path: <stable+bounces-237466-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOc9ADQl3WlcaQkAu9opvQ
	(envelope-from <stable+bounces-237466-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:17:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 063053F11DE
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1409D30438FA
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525A233123B;
	Mon, 13 Apr 2026 16:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="hu3tnQJT"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345FA3203B6
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 16:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099529; cv=none; b=GwtP+SdmJsrndlYnJzeZ/6BqkCvffyipBRu/kHKlJv2CWjk9+GmJmBpYrSaiB68UDjkOXzgBn5XjECIn0BzhvnkxaaS2eXSSYoL9ShovLBnQi4HyfYo2ZMhaarcBWA80qUUCHiFvl9CJoX7wymCRpLEG8poFOOFTFOzTXUb+olA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099529; c=relaxed/simple;
	bh=NW79sEuPdbHoQcLLfX2FnTYtxYGQ26IoLIPnKdpQb1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YfCOZbSzlXsHiIinCLIZXBRWKo0p4BAuNS8nOgSWVMnOcRqJho7Ma79IQU6wYEBJiQhOVIV5XH/+stXgQSfAP+IOJRfNOD8eT4B6vKYqLfqGC3Tqe+JosUlVSS61OnJyndaJ4Tr63ymXAYVoVuffUFYk2V2cWpCCe6hkALMf8Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=hu3tnQJT; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UN/jdZ4ycKnKbeFApRknBikRqWnRbiWbPLgeGde1veI=; b=hu3tnQJTejBwSJkcNx4SYw4K1S
	TwNJMjeIThhSNR/2TfQMuztwgEKJy8RMYNWsrZWE25qko7CvmD1edQOrnMeaONPpI7eKQQGY+y7c2
	zHaGiyYpGsXEwtMT2/Jz/KEPlYEAjwjRJTqh+7Y64j/L0PZKAGUfCdYbLHme02CI8FO/QukKtEktv
	PvSmPYc22npROwqLWeyyY247Zk5Lo78SwHt2M5mXhHhqPlO0QQagMQAbkn5em4W7/Cdfm194oupgt
	sxw0FHjcdM0ojTkXpQqR3+wD8rLb+/hiVGFtIB/0J0IZlwEVpC3RoGXSZF+22sWJ5gBSt1ZyT++XM
	xSnKaADQ==;
Received: from [189.7.87.169] (helo=[192.168.0.2])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1wCKcS-00FVfH-O6; Mon, 13 Apr 2026 18:58:40 +0200
Message-ID: <616c212a-067d-485c-802c-c1375094c53e@igalia.com>
Date: Mon, 13 Apr 2026 13:58:36 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/v3d: Limit ioctl extension chain depth to prevent
 infinite loop
To: Ashutosh Desai <ashutoshdesai993@gmail.com>,
 dri-devel@lists.freedesktop.org
Cc: itoral@igalia.com, stable@vger.kernel.org
References: <80158c8c-a270-498b-b947-bc3276359d4b@igalia.com>
 <20260413152115.3444105-1-ashutoshdesai993@gmail.com>
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Content-Language: en-US
Autocrypt: addr=mcanal@igalia.com; keydata=
 xsBNBGcCwywBCADgTji02Sv9zjHo26LXKdCaumcSWglfnJ93rwOCNkHfPIBll85LL9G0J7H8
 /PmEL9y0LPo9/B3fhIpbD8VhSy9Sqz8qVl1oeqSe/rh3M+GceZbFUPpMSk5pNY9wr5raZ63d
 gJc1cs8XBhuj1EzeE8qbP6JAmsL+NMEmtkkNPfjhX14yqzHDVSqmAFEsh4Vmw6oaTMXvwQ40
 SkFjtl3sr20y07cJMDe++tFet2fsfKqQNxwiGBZJsjEMO2T+mW7DuV2pKHr9aifWjABY5EPw
 G7qbrh+hXgfT+njAVg5+BcLz7w9Ju/7iwDMiIY1hx64Ogrpwykj9bXav35GKobicCAwHABEB
 AAHNIE1hw61yYSBDYW5hbCA8bWNhbmFsQGlnYWxpYS5jb20+wsCRBBMBCAA7FiEE+ORdfQEW
 dwcppnfRP/MOinaI+qoFAmcCwywCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQ
 P/MOinaI+qoUBQgAqz2gzUP7K3EBI24+a5FwFlruQGtim85GAJZXToBtzsfGLLVUSCL3aF/5
 O335Bh6ViSBgxmowIwVJlS/e+L95CkTGzIIMHgyUZfNefR2L3aZA6cgc9z8cfow62Wu8eXnq
 GM/+WWvrFQb/dBKKuohfBlpThqDWXxhozazCcJYYHradIuOM8zyMtCLDYwPW7Vqmewa+w994
 7Lo4CgOhUXVI2jJSBq3sgHEPxiUBOGxvOt1YBg7H9C37BeZYZxFmU8vh7fbOsvhx7Aqu5xV7
 FG+1ZMfDkv+PixCuGtR5yPPaqU2XdjDC/9mlRWWQTPzg74RLEw5sz/tIHQPPm6ROCACFls7A
 TQRnAsMsAQgAxTU8dnqzK6vgODTCW2A6SAzcvKztxae4YjRwN1SuGhJR2isJgQHoOH6oCItW
 Xc1CGAWnci6doh1DJvbbB7uvkQlbeNxeIz0OzHSiB+pb1ssuT31Hz6QZFbX4q+crregPIhr+
 0xeDi6Mtu+paYprI7USGFFjDUvJUf36kK0yuF2XUOBlF0beCQ7Jhc+UoI9Akmvl4sHUrZJzX
 LMeajARnSBXTcig6h6/NFVkr1mi1uuZfIRNCkxCE8QRYebZLSWxBVr3h7dtOUkq2CzL2kRCK
 T2rKkmYrvBJTqSvfK3Ba7QrDg3szEe+fENpL3gHtH6h/XQF92EOulm5S5o0I+ceREwARAQAB
 wsB2BBgBCAAgFiEE+ORdfQEWdwcppnfRP/MOinaI+qoFAmcCwywCGwwACgkQP/MOinaI+qpI
 zQf+NAcNDBXWHGA3lgvYvOU31+ik9bb30xZ7IqK9MIi6TpZqL7cxNwZ+FAK2GbUWhy+/gPkX
 it2gCAJsjo/QEKJi7Zh8IgHN+jfim942QZOkU+p/YEcvqBvXa0zqW0sYfyAxkrf/OZfTnNNE
 Tr+uBKNaQGO2vkn5AX5l8zMl9LCH3/Ieaboni35qEhoD/aM0Kpf93PhCvJGbD4n1DnRhrxm1
 uEdQ6HUjWghEjC+Jh9xUvJco2tUTepw4OwuPxOvtuPTUa1kgixYyG1Jck/67reJzMigeuYFt
 raV3P8t/6cmtawVjurhnCDuURyhUrjpRhgFp+lW8OGr6pepHol/WFIOQEg==
In-Reply-To: <20260413152115.3444105-1-ashutoshdesai993@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237466-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.freedesktop.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.883];
	FROM_NEQ_ENVFROM(0.00)[mcanal@igalia.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[igalia.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 063053F11DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Ashutosh,

On 13/04/26 12:21, Ashutosh Desai wrote:
> Hi Maíra,
> 
> On 4/13/26 09:16, Maíra Canal wrote:
>> How about checking if (!multisync.in_sync_count &&
>> !multisync.out_sync_count)? After all, it doesn't make any sense to have
>> an empty multisync.
>>
>> I believe this is better strategy than using a hard-coded max.
> 
> That check makes good semantic sense and directly closes the attack
> vector - I agree an empty multisync isn't useful.
> 
> That said, I'd like to raise one thought before sending v3. The reason
> xe and i915 added a general depth limit wasn't just to fix a specific
> known loop - it was to make the extension walker generically robust as
> the extension set grows. If a future extension is added that can also
> tolerate a second visit without erroring out, the unbounded walk
> vulnerability class reappears without a counter. Since the current
> architectural maximum is 2 (one multisync + one CPU job extension),
> capping the walk at 2 would reflect the real limit and provide that
> safety net without being arbitrary.

The problem I see is maintainability. We will need to keep updating this
macro as the number of extensions increase. So far, all the extensions
we have can only be added once, so we can guarantee that per-extension.

If in the future we have an extension that can be added multiple times,
it would make sense to add this hard-coded limit.

I'd prefer to check the multisync extension and make sure that a single
one non-empty is added.

Best regards,
- Maíra

> 
> Happy to go either way - just wanted to raise it before sending v3.
> What do you think?
> 
> Best regards,
> Ashutosh


