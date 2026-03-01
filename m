Return-Path: <stable+bounces-222426-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EA5eM6H6o2kaTgUAu9opvQ
	(envelope-from <stable+bounces-222426-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 09:36:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD9C1CED8B
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 09:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 11879301944E
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 08:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C783D3321C2;
	Sun,  1 Mar 2026 08:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="NmeoURiz"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A7032ED55
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 08:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772354180; cv=pass; b=lFAgZZPuzVoVhos8qEewRIZvdyXZzWGbMd4F4RGIi72qtCZSRikSwT91ws+P/DFIg2Ng8k7+ugBfSVeSPt7W1OR/2ozik79fMvdGpgc4jxLXgSudmK4KO2xMCNSRAy/wVdWjuEI/ruB78bdeHj96nDKe6+1lhooG3lezuzAQ5YU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772354180; c=relaxed/simple;
	bh=r2pphhJdINlvzPXll7Wfz0QDJeqbUJhM0Z5EZajYlOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hh0wPfm3PafliaX8eVBDgaLGDwgenEvXspaDQQ1KPeOopXZAptkP867E3LqRtTNesh63+SlbjatRN98LDk4BZgu45PDisaGLzx9t01YxNu3d4X2/XF8dquB4KAuriNXbaQUszht/evTtyFb7lZ/N9VR/qFv0rTqemPtnVMqYAlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=NmeoURiz; arc=pass smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2bdd40d3c61so2628595eec.1
        for <stable@vger.kernel.org>; Sun, 01 Mar 2026 00:36:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772354178; cv=none;
        d=google.com; s=arc-20240605;
        b=ZFwja1nfUBX/W3/LunJLFMIsM8Ka7lQvqP/eFYLfNu2dH0To9MC5GJml+Cuu0gBHr/
         005lcI4ucySBpGX9M/VmtBGfqUHxfr/Hxg0migZGalLLEhUAo7OjIjbwIcq4h5zdX27G
         V6C5RXYVXNoH+IATTdfwBfYaV5fmLs9Bd2ZftGMG8eaX/2RLef9IHvqRsMzLZtlNYKRA
         hmyLqx+g2gx+OhmQBD3XAa0gkgtAX4PNs6F7vJUJOuvm7uIO1DbnUXvLjmQXGpLiWNzS
         hCmt0/nZr5/2ktjkRLi4zpWo4NFijOd/m+Vo45LENn8eFP2FHVH2goy05Zg1OX6flUgh
         2z4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=urH6iFQEulOdg99se0fOOar92YcfJM9z08+hSFrPGZI=;
        fh=AhwNgpjIM/ba2zHFFy+Oep+fyPqvsrcasYKKsQ4RsJU=;
        b=hzB+j8v5EHoKo+SA1rKTHnkxkGSA1uewF0fHRsH09fpdvlPWmgqxaCrVht1nqhphLU
         ykYftAaduGt+WAtnvHm/xp+HZtmWuZv8W6YVhIjvpxY7/w8lh6LqkAtcJPi5DobhNybg
         q1dZOUWUXUM36qeESS6MvUIVFmrsQlBZblC+hKRMem+EDC/sLAtfx2pC4167ACCZtpal
         wWPXVy8e69UgG78MBog7KsX5tKwKR0jY8q+OBZ1p/zUuO9s6qzKvzMZDnh6kwtLDJwyw
         qn/hRHDV4GE9eeVPOaQszpZnLhZahhVfIy6ssnLX/4kEbHXdfvBAuBGp+4BnmVVh20Kz
         dQqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1772354178; x=1772958978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=urH6iFQEulOdg99se0fOOar92YcfJM9z08+hSFrPGZI=;
        b=NmeoURizWlhiNdTTLC7PIO+OL9Hi34eaoTQMw17ZTm7wT7u6r0wqte7ItOeGV4q+p8
         x637l5FU5rNZvZoHR2V8mbVVjZzu0WhW022sfaxRNZwpmy17LCHnvbxuWdPHDRvZoN3V
         cepyeWZ6wXcwhQdOqT7q83BHLkqNsuH//jLlkokM8L2dbFHbEeLFKz+5/yBZ2c2EwION
         UQGOEiEl4OZJIMnSL7VpKo/qzy5WxIcoN7aS+mWXzVn8LuMTCQ8nPrMWBY6YCm926QUz
         +CfmmA+G60Zc4WMA5tU61C7vlNszX0R1q0L0tVLNXxL8ezH6Bf2GroRtLd6KrBwO+OPx
         baaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772354178; x=1772958978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=urH6iFQEulOdg99se0fOOar92YcfJM9z08+hSFrPGZI=;
        b=fetlrgQ+oh0wug+30mWQCaU1Nbv3DqfKRPinikqzOTwSY0KYQPiMDasWNXcDIfgfHv
         tdZPtAFy9KQLB2r2KpNxE9eHxmni8lFLtPE7550qedim3B1GLBpHzdVHpdkQGwpfDBiO
         +Fb+SuoYsBGRZigGNk8ebpSFn6kfNq4OQ+rFufqluO/yhDQG7B4Q64v+nt+/ZBblOkv2
         x2XTWJ3BerBMX0n1o/PCQJYgtX58zxz9xoSTmsDs5bTclSGRvacL/nOWIb+esXYP/UbC
         ObPXENis/dpYh0A2HqnHKyNjmZav4G0RZoU3IXZntTW5HoDfEfUY2/eCq1yJvqBw9aTZ
         /4kQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNvFiMWFb6v94+PU7H1DF2AZmmc1T5tUHHWpIgW6M4dJNnMehtT+ZLSMv4Yh6YaRDm9Ts8OZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKrkekfHIoI3HLjmopnHkLLh8woQmiNufbyLx8IQ1rwmCsmZyZ
	UsemSwWUA6JP1tkOp3Y4xoly0JWCTudShLAkdN7cbuMHtQo6CSlGH7+y8t+x0ta3fjGrvKAgBI5
	LimIu2WLtmuHsDCw03AgLU3/s10+VIXuDYbg9LZQ4ig==
X-Gm-Gg: ATEYQzx2NQdq8AYQcL+dAX5mq2n5pd2FxrmJlOKYm6yuKfZreyYr7/AHj9TLn42RwuC
	MssjJT5zFwyZEFHNmnrbIiGeegeIjashuKPYjobcbMTKu5pYiZdQmX3h8rJDDZnzDf3WlsodZjw
	P5GD0S4YtIXOdhzFJhPNLhGwGSxbymdgfNqMuaj+9oVEComLDmN1izkITl9uTx5SpXuEpBCZpAF
	U9TMV3TEv8fZof+sN/FAdf+hfDX6tkt2zm6l6JbBVa1NNSH4Z4/0VPDZfjsb+n5cgsdo/ymOXrq
	SS7gD7Ef66l1e9zE7JVybk32e+hCxhvni5jtUKHKYft/TgWKRdc=
X-Received: by 2002:a05:7300:5714:b0:2be:e4b:60ca with SMTP id
 5a478bee46e88-2be0e4b64dcmr39449eec.4.1772354178287; Sun, 01 Mar 2026
 00:36:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228173244.1509663-1-sashal@kernel.org>
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Sun, 1 Mar 2026 17:36:02 +0900
X-Gm-Features: AaiRm53InbxY9FB26D-DyQSgtkquYGLoS1vd3enstVkB5_CzVDKTgfLaOE3TzcY
Message-ID: <CAKL4bV6ZxZpVRVLiqgJDrvws4bWB=R9S4cwR0ZAX_SSZpW_88A@mail.gmail.com>
Subject: Re: [PATCH 6.19 000/844] 6.19.6-rc1 review
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	gregkh@linuxfoundation.org, patches@lists.linux.dev, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org, 
	sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[futuring-girl.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[futuring-girl.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222426-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[vger.kernel.org,linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[takeshi.ogasawara@futuring-girl.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[futuring-girl.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[thinkpadx1gen10j0764:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6AD9C1CED8B
X-Rspamd-Action: no action

Hi Sasha

On Sun, Mar 1, 2026 at 2:32=E2=80=AFAM Sasha Levin <sashal@kernel.org> wrot=
e:
>
>
> This is the start of the stable review cycle for the 6.19.6 release.
> There are 844 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon Mar  2 05:32:25 PM UTC 2026.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git/patch/?id=3Dlinux-6.19.y&id2=3Dv6.19.5
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.19.y
> and the diffstat can be found below.
>
> Thanks,
> Sasha
>

6.19.6-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.19.6-rc1rv-gbf28ec292fb6
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20260209, GNU ld (GNU
Binutils) 2.46) #1 SMP PREEMPT_DYNAMIC Sun Mar  1 17:00:33 JST 2026

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

