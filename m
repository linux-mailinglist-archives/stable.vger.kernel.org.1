Return-Path: <stable+bounces-217216-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mw+TLNNNlWnIOAIAu9opvQ
	(envelope-from <stable+bounces-217216-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 06:27:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39ABD1531CF
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 06:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 69CB13016ED1
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 05:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1761A2FE076;
	Wed, 18 Feb 2026 05:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="C8V06C8f"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2E01F1513
	for <stable@vger.kernel.org>; Wed, 18 Feb 2026 05:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771392464; cv=none; b=fVzAPjauKWV5wM4ZNxHQZa8fS9ePoOZ0Hqmof13hJ8sbA7k9y1PPSsrnSVdh4MxQPA63Gzx3KIyOPSRhzCuL6JwKamLPVgY9XA30zu+HFGBYMlR+kapKhSt/O68tWSqVabEb4ufHc2BfJHfaZsgjsu2vkIuYVOL4c8JeLRWfliQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771392464; c=relaxed/simple;
	bh=B5FozkfeaeLMGlDnmtXlZiNckvHKetd5T/jIhWcYZqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YJR9mzCaFpr2RbxHKovE875uFbWuZRlQ4D430lrzIK4OIG4kyeWgSpK4E1dXUKY1OrF+amq1FkIzLLTByCmxlFI1ktBh+uVJOW3qkDcPZIaWjyxtYPd6m+YbetRYkN58zICpyM1sURUIMfuQSRvpq+sa9EwakYUk7kI7rdv5L94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=C8V06C8f; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4837584120eso32515015e9.1
        for <stable@vger.kernel.org>; Tue, 17 Feb 2026 21:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1771392462; x=1771997262; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1GVNW12H5IXWe9p/24Eu3pPv9aw4qit0ROPdy8JhWwI=;
        b=C8V06C8fgW0Q3dY+CR1iu0RPEhpARqcPCkOdN3sy65X1Dlu7wN7L2+b+gcOxjRhtip
         DGfiIxfFFH0xIcO+NFKBfdq057O/uQTvtt8jFy3it3IGvOlbGiLj6TX/7Q9THBH6Umnb
         JMe8ysyPWU6SQ8sRp0UgAWg1AzCN+sMwdJTAVY5hGhw6cYo5d2mvtvjnDhvH6tv1Hkjr
         ShSkAhovYCffq1xux4UzCbUjIc27QmIEaGpEKXJbpYMYIMB3e1+VkVyRUpwBFf66zHTl
         tqNROpzCsBTM7MiDiyA40raLYn6QTe5DZ+FKY6bRh+5SZO5Ig9CI31YOVaUrYsgMi8vJ
         QUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771392462; x=1771997262;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1GVNW12H5IXWe9p/24Eu3pPv9aw4qit0ROPdy8JhWwI=;
        b=A6sCB8dl529RApx6MYvKZfRnTkntZVh8+Od325C2DiUcvaAvlnObKogKK5Du+dpn5g
         7Uz2WsNMcBmhj1gjmhWtwnnss5ZCwJAnMC8D5qp9Zk4OEjGx/N731Y5eawxE890zEbjN
         jKOYaDPrSz7x/gfIWqg/nogkb6pV3O9w51y8AFjZV4vu91gozxwkeZ+oKcde5U2h2SKl
         pR+n3CukaUxOcunqMTNRzJPYZqPKarRBjEbAF+YFWWhoe5ii7mo9PdEQng0LGinZKJf1
         fgyTsIy/Rexwq4TGSoj8AiBaEb1SoOhV5s6jin/aAIjJBrSelsTowDaeijJS0qMIF1fQ
         9GHA==
X-Forwarded-Encrypted: i=1; AJvYcCVonQnXbPfpekb4GzXl5E32JmGvgF7vE+1sAYgWEkUNkkyRdgIOwZK92nzj2dmFXZj2aI79EwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG6DdXSo6imTTXX6jLzPFY6TGc63lq4DCefUlSWB6nx78u7MMn
	zmy7ogVcvqqMv5spr7q/G4/7E1IoVYq36kfkwcYJ1AJENJn663vWxYc=
X-Gm-Gg: AZuq6aL08TXh+ObQ/79HZczCGn91EXvvMXxX4fvj2GCpp55MhT8/EyZZYYBvW9GvJmQ
	bsqhbvPQfGFvTwrhoqXEelKuI952imMem/NbmA7Q8eH5XH/z63mry/iE1q7XG98gWGMY/yFnOxf
	tY5hKJcyhLoeEOjx2t8rFQfw5uAoY0ZJc7Vt73Hg3AyT08J3b7aUcW9RM7GbwdILwuH2iGtSgir
	qce1s59v4b/O5eu1xV2lHk5XjBFuHMkpkztBHTizji2FLSWn81KsClzaksxNULDQfppjD7hSeeL
	P1rcvBgtUFTnHPWzEtH7xTnQplfkJkQX5T89aIXk+MxrN9V3aRMIR3O25Fjqll2sp/mw5n74vHI
	62S0O1aahfI9dxmXHO98/qhDn3xW2w7nMRPlZOwkTNRgNNctVVkDe5GdktZdPrOIFeeNvcBmNhm
	1SVnuxQBwVClbZWiZgmeoeFEFyZseHmr78vqslSf6TJcb72B2kOxAPfICvyeYnu72tZrct7UVvN
	7Y=
X-Received: by 2002:a05:600c:1c08:b0:47a:8cce:2940 with SMTP id 5b1f17b1804b1-48379b991c6mr219951295e9.14.1771392462010;
        Tue, 17 Feb 2026 21:27:42 -0800 (PST)
Received: from [192.168.1.3] (p5b0574ca.dip0.t-ipconnect.de. [91.5.116.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835d92267bsm851744885e9.0.2026.02.17.21.27.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 21:27:41 -0800 (PST)
Message-ID: <5f67b793-f229-47cb-b0a3-d7165ac75dcb@googlemail.com>
Date: Wed, 18 Feb 2026 06:27:41 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 00/64] 6.1.164-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260217200007.505931165@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260217200007.505931165@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217216-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pschneider1968@googlemail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[googlemail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,googlemail.com:mid,googlemail.com:dkim,peters-netzplatz.de:url,mailvelope.com:url]
X-Rspamd-Queue-Id: 39ABD1531CF
X-Rspamd-Action: no action

Am 17.02.2026 um 21:30 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.164 release.
> There are 64 patches in this series, all will be posted as a response
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

