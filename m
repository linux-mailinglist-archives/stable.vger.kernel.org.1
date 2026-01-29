Return-Path: <stable+bounces-212733-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFk0OWzsemmE/wEAu9opvQ
	(envelope-from <stable+bounces-212733-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 06:13:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A163ABDB1
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 06:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C96BF3014978
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 05:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9842DA768;
	Thu, 29 Jan 2026 05:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="HFgFIrTk"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7D723EAA1
	for <stable@vger.kernel.org>; Thu, 29 Jan 2026 05:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769663584; cv=none; b=LB+2alC6QQvE24pstM5YHdIa35Ry/6TbsO5LIvWaUcIGZtNkMEA0wodua1HImaZVPvgJQ1Szqmo8VXw53hJikMn5SI5+2bu4NK38/ukc/SAB5lwyUrysdQG7Yoz5oo9sRXpjzuoGCjQEZBVaKBt/1+j6ZMPKIR/1TzM2RFiI+/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769663584; c=relaxed/simple;
	bh=twj9HVXi5JgmZJ/An+Ey9dyRnvp7b80/zScLMvpPeuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lrPSHxwzFI4CT1W47Zhy3pfk73dNBrQixomwHJ1Tp0czE0ETyklUydCCTh9ib6eFym1U1Mdl2t5u+G+wynN8YKJA/pzGxhAFiS6PwhUiluOyM++q1qIeAxCbeVy4RcND/JSLCjOE7xizALSv+NN83vT8JzUSWS+KyjXY8bXhiGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=HFgFIrTk; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4358fb60802so299863f8f.1
        for <stable@vger.kernel.org>; Wed, 28 Jan 2026 21:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1769663581; x=1770268381; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2O4PzWrxGkpRsKO0Gq+hkTx2A2ETtTBfb1xW0BNp1LQ=;
        b=HFgFIrTkIepkmWyYbJAITRCKp8mCg1j0x56Ap3IUuW+rmvR4ym7kS+UKjg+i4IghUx
         3ZCfXQVwu/+qvx3zDttca3DeYUtAb25CYfGrUMFrJAe1juTZxqnNzGvT31VtpI8ew5OC
         qwAaaOtXG3tor9IyOhArs32bZBW97vZa0vBZfMw7X5EXoz5CyOJ6MDiY7YMV6wFVvSLc
         37pg90TqBWRaFe+YRs+PhkWv/zKxoPJeGyBOoETqIL5NL3M3he8fm5rS6Hei+7RVnviL
         o/W9LcOH7EY5hQwcaEk7eFiJs0SjgNmMzIXkBhHkoHdPCNHR0B50JzrkQSidakx0ytBw
         RzUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769663581; x=1770268381;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2O4PzWrxGkpRsKO0Gq+hkTx2A2ETtTBfb1xW0BNp1LQ=;
        b=IMdI6Xrhe0/25OT0fUWwqfvHWq3sEoGnY6I2E9duBy1E2qJQ84fWYq+OK801DYs+oJ
         rf3UUllK74IxQp8mT8Gzhh/+ZTecVbnR5WSROnEka+6VZEuSWbaIuVus8O4WcpIHAxBn
         0w+0UhcXe/IOFoCwHZPogSOVdSe4x4goQ1TkenfVkz1VAdsvT7vRYyppt61DR4LaPWt5
         nRSMuwYcpQlWHWE5wYxTXcp9/jUXQTHxJ7UO4TE9opvGziPSCg5B1ljf6/UrstNsgNi5
         +7BGGOzdMHAn+ade0GmUn31mMdb+UlEObVRh8AhlMwV837aXNvWuBRCiApIsVKEsH/pO
         sjcw==
X-Forwarded-Encrypted: i=1; AJvYcCUpevd9l8LNcYpj3POyhNK0NxKt2AIsTg1+Yt6R3+27YqZBNWbe81tiCbW228vkvZQYK94jAlk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBbkDsHPXdsaAsDSh1cIJFx71ulad6oU++zipjccThe+B7eSYg
	Ev2bSMiKWcqpuQBpvir7Tm7ZA6W9dtZ/nCvzUjaPBXO13CeLJtkQn64=
X-Gm-Gg: AZuq6aLcel77pjuA1QnxplWphB2yma2QEVrfJG8oX2HxolhYQhKHeotB7sbB3KD2Mfb
	wNVGb0B8CFLXNfe89UDjzMivuRHx2V4R6bv6Al/OUW0iDiJIZ03DrEJ4+uNeWgBX3ZKuU39+VBV
	YD9hTWntfsWgSBkvm4Um1dr6OZnoNyw7CvNPkNIede3ODjwfK5h2fxgYvbPnXSU9Xh0IKW/A2gV
	XGzAbeveseaK4JeUnoWLBs099mUZ9ElzxPe2xQfhj87FA2ihh/67eFK7jjZ6XJtqleHFonqvNXj
	HIf40/YRsKvNpopGNbP3+/cL+hcnFXQkN6V6vAhQcZ2yHuIFOnaj4XAiLISgTll5nMmqbk+0Xnf
	TEdG33EuAugaeSsM5UOUNPk4HatwVptNKT1G5/JppYpNqe9Oy19Vp9mGKyyzaF/CyPfj8QOh/Lr
	G8pqRG6mmDO+o+yLUBYr5NYlOcW+ep3YVw8yMBLBTwq8/CsD6PhdEPw+6U4y2ZNA==
X-Received: by 2002:a05:6000:402a:b0:435:932e:f924 with SMTP id ffacd0b85a97d-435ea0645cemr2263027f8f.2.1769663581185;
        Wed, 28 Jan 2026 21:13:01 -0800 (PST)
Received: from [192.168.1.3] (p5b057921.dip0.t-ipconnect.de. [91.5.121.33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e135422csm12005090f8f.40.2026.01.28.21.13.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 21:13:00 -0800 (PST)
Message-ID: <2ff467fa-bfca-46ae-834c-7ad02a23985c@googlemail.com>
Date: Thu, 29 Jan 2026 06:12:59 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/254] 6.6.122-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260128145344.698118637@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260128145344.698118637@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212733-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,denx.de,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,googlemail.com:mid,googlemail.com:dkim]
X-Rspamd-Queue-Id: 3A163ABDB1
X-Rspamd-Action: no action

Am 28.01.2026 um 16:19 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.122 release.
> There are 254 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


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

