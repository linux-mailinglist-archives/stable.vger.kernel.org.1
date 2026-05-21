Return-Path: <stable+bounces-253460-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJzHMD2kDmpxAwYAu9opvQ
	(envelope-from <stable+bounces-253460-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 08:20:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 233D059F5D4
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 08:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F4423041AB5
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 06:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE5639282B;
	Thu, 21 May 2026 06:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="PmcFJds3"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE541386552
	for <stable@vger.kernel.org>; Thu, 21 May 2026 06:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779344077; cv=none; b=nSxYMVw4gEw5nQ5aNIWzaMkgdUmHDYTvIq3lrqEKQQWnBCUdNwWPuKwDLDlVEfyJVQBZ9wSDoxoukngV2ULrxXvb4gabufb5FJeWW6DL50RnL4RiNUmtehJOjiOqGBJ7kJwRONxbBf4ij2tQirMdIfSPAS9Y/XC69XZWy/JyQt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779344077; c=relaxed/simple;
	bh=mVIiD0RVDenjsOxb5e5BMzgLEeZRsf+/DVb2UcQ6CHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WZB0NgSY9G8Bn81/6h0nGffI71Jh7wpEeElrfPc1W0A561i3btSwnENiaHkuZcLl2ZPwLJyC1M28NT0TWIaWpmR94T7MvrLvf4zgbUNQhmt9kjXTgNBH7R2EuC6oyhyorsjwiB9PYmEoBOCgLZuzbAg1iDLNqP44p/LmW0+/7+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=PmcFJds3; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4585a116a4aso4762936f8f.3
        for <stable@vger.kernel.org>; Wed, 20 May 2026 23:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1779344074; x=1779948874; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JOjcszfYBOtrIqFg5ayXWqcuSiWz2y2sNwX7DqkC0Z4=;
        b=PmcFJds3wXYif8gm4W5yZRxlwYIUjYryZLU+vIeq1XKtENgGXufA46J+jJHMEBbkyT
         ZJKVIsDA5EtCJO8cp9FL2yUvhoXiSOBYIU/6e4zE44qYxEgeyDJhe1SFzbnomD1SaR2R
         rlEHEC3xGt7ZIZCQjQn3DZ10gWbaUheNDaaN3Wx14zWkGIClfrVwcnWlVEWG+Bdk2yuZ
         LJGlLEzkmYwNSx2o37zeYM98VRHgYr+d3uJaLD60F7QNAe1WXdSdm5MUw0sVRW8n9K2j
         vT34bcL6a3thVvq6jL/eq//cKHKBO3//jtCQCLe8zjfbFeEccheh8bmE4y1GZGlrKqV4
         NB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779344074; x=1779948874;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JOjcszfYBOtrIqFg5ayXWqcuSiWz2y2sNwX7DqkC0Z4=;
        b=cXwe3kY3NieRutTYpwlmYM2K5/MRWYUH//GdcD5qTcqOkdlpD0anSuVTIZm4wy1FX+
         GUwkZWSW8tVT8EnbB45Jdwj9saQUZYt1dbJ+LrZSRStbVEsHkwwIqMxsXMdh3eLcouL0
         X4bvo8NDpBbO5VpTH7qNY/NfPbhmaFreCrCO9yyknea2KYYnwjoBZ6ZBkKDvEpka1hFD
         rQ5Df0L5bdRU6olfjTTGr3SDC/TBCSZuLqgKw80dFAwCaRD7c2pNhmQUHFmt+5CQaMhm
         afCHUWb5XdnH+cgpbIBtXjUR4y8FM/GAqn7P9wlMA1ssmIk9fcXrdjIFM7zG3nrCqr4e
         1EAg==
X-Forwarded-Encrypted: i=1; AFNElJ9QXbLNYauFxCEdIgl/EkYKzLQOHuOk2Fea+Z2QJFg0/3HgXq00GN8NH0Yd7oJz+ErQVHHmTUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeTQ533bkki1Zgg2Jn9rh9Bx7bUfQgW0WXs8opoJXA2KCKvd79
	OoZ7t1DfHuIFzhfV4lNERQjbq9PEXZzlpEcCoFzSovPGkFswtLhTE8A=
X-Gm-Gg: Acq92OEXlK1rEZ6ZaykUXVEznnJwaS7XKESHkXPT2x8MaJFnt0xuOYlXQ3Mg5A0Lup9
	51zNfSqompiDH8lHPcIyVnQizNlakNYBAjcqHFQaol+ZSzoK2THvLU3an8vnFHAoI0filSUqimU
	f7q66NSlt0rM53Vxtvv51Z5NnzvbyLzSVzmCRyMaBqB8N1ITgPJ7DPk6sqjq/mryN7vY9s2P/1F
	y8ybalN1TtIxxfKKhAakP3eATDFdNPm9JNU5XmcPlqVvH7UI4/GdIwYoHTbTt/RwLYgWreoeEJd
	6R3Qx17P2dE0Scs/iwJkBQhoXZWCLwk7+O+k9zZKVCcWDaXYcRCntdBuoBnI9HAKEfDFqbho/81
	0Nt0f3qjCKJrIP52J0gdIDnMQmGQ/7dJ5xVZE/owrc7bTwc4bU3abD9BWLzmFIfxtk6LgKjX03C
	g7uLT2iGSvH9qZw5VMqccgs8UW95kN/0wBnsOjhOCMRNbPVjwy6yWzKE1m8N3lXk3ycHmZ/3IHl
	ks=
X-Received: by 2002:a5d:6f1e:0:b0:441:36b7:725f with SMTP id ffacd0b85a97d-45ea38cd40dmr1876006f8f.5.1779344074023;
        Wed, 20 May 2026 23:14:34 -0700 (PDT)
Received: from [192.168.1.3] (p5b05786a.dip0.t-ipconnect.de. [91.5.120.106])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eaa93d29csm85724f8f.37.2026.05.20.23.14.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 23:14:33 -0700 (PDT)
Message-ID: <980e2543-98d5-4e1e-b9e6-04c826e4054e@googlemail.com>
Date: Thu, 21 May 2026 08:14:32 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 000/957] 6.18.32-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260520162134.554764788@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253460-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pschneider1968@googlemail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[googlemail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,googlemail.com:mid,googlemail.com:dkim,peters-netzplatz.de:url]
X-Rspamd-Queue-Id: 233D059F5D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Greg,

Am 20.05.2026 um 18:08 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.18.32 release.

Now I'm severely confused. You released 6.18.32 on May 17th, if I'm not mistaken.

Shouldn't this new 6.18 RC be subversion 33? Did you miss to increment the version number?

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?h=linux-6.18.y&id=b7adc4ce3f26a74d49d3703c6390645cb313e52d


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

