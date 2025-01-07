Return-Path: <stable+bounces-107785-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8A5A03497
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 02:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F384163C2A
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 01:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B704B2AEF1;
	Tue,  7 Jan 2025 01:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="CqT2qCz0"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AD94C97;
	Tue,  7 Jan 2025 01:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736214007; cv=none; b=gjIT0xz22qZaVuYmoBF2SnVN6rFfISqSr8ZSKJtzEIzQeA7hGKdaVzrIss5Btzfqwx/0YJj3gzqO1nvmkX/sHN0vdSnOkbo2PjeBQq818F2Dn9IOLWdwWDh1ab2ERpD2So2HZUfOO5cSISXvtqfHxWyl033FhplyV8eJx8A5Vzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736214007; c=relaxed/simple;
	bh=OF+J7g0eFvi55KwHOIgcuXCNICVmb1rqH16nwsgqHRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xmx4pvLEkU40j+kYkQqfH6bidzpSw5seFMiS9NO62ZHfFLgPSgNrv/Xp6puA3bQxJi1PKrMookbtoq7b9782fypWdRyRlFqPkcqscz1PMkjxNgh2kQUEqyMiQt0+VU/+OnnScL8mlYuqrEomJ8vLY8B+JCal8CmQUADVulWl/Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=CqT2qCz0; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d3e6274015so26624249a12.0;
        Mon, 06 Jan 2025 17:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1736214003; x=1736818803; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/9YvSvr9lvlL1SrVAn2MD16XQSwHxJWkO99vjoXy7W4=;
        b=CqT2qCz07ISuw608DaIBLgsMn7Bs8MpdZ6IKZ2rPEuzRpbn8L1bZkdRswaOr2BpFtF
         EcUb5jHMYbKcHIVIzvGyhqUsNI8awzKgqw1OGvgeJQ2y/7I/kT5ZatPtp6OpQY2HKAq2
         sLQI89VENzppRYImKvQeNpoD3gIPUoiqc868m668wxbR7OikYhtMD55EdhnNYaIID3DY
         VWhUV8XwKyP0a6lxCYsZjlsLXYCBxtpvl/jFikEBHiXeFuNvdsUKUgQWueS4OGbSh/rB
         q912cwyxy7mOUjzb6d1jhY3RPpFN+mfPadxzhAKLMSqRo2qsqG7psEVudt+1XW/xtKLl
         QsJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736214003; x=1736818803;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/9YvSvr9lvlL1SrVAn2MD16XQSwHxJWkO99vjoXy7W4=;
        b=itCfdAmjo6hKS152kFhmcoTxqOmsfWE5qNl5PiuEuzZdsnbAhC/y27Znymvhi+SbMR
         +lLv+8ak6bhaTvaHi22tEU91hJfwYfdhpUnpiWPhUnPzWBxVdXl1aKheXKpTMu5Iyu6V
         yoN5NUTilWN4Pa22kGYhkJ0S/1JnrvuhwKvSDlbfKIWbXsn5LVqNP8MUvxwR2RbTl2ex
         SJwI7nAcR8lOoC/PJ7gFxvjqUa7QC3wqjJ9LXz3vcnB9HUSh5ZV4qI5kY+osebxes+uL
         WMko39oJBcX9M07StlG+2gP+e4yb7cL1hvgeAQm8Dxt/G61i2cZy551jgvGRJYsHefnE
         qynw==
X-Forwarded-Encrypted: i=1; AJvYcCVcw7/+soAits57w1mXBxndcd66TfHewJgaGab6h9k7d/5n73MXysGqpFjnDxGSZhmV5E4UgEwB@vger.kernel.org, AJvYcCWQPD3yyvvJWE0Xl1SR3AMgdn+ttgjgShWEHwO/lIfClwl41fQEmkBCMIvPUXaTkX2IYAfSUYEnHbuuyNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpUPT4EnVOg9r1UkQb5PaJSpl4N2nnH7WlpbE0pdG7BB8S9PWO
	nr+jgSlbaYiTWgbcy0kCEM1c+9CfNolkSux1z2r8h9umnrt7vlM=
X-Gm-Gg: ASbGncs4pMDteA94YryjWer71x8WHfaXDFtRYy4OZqo2JfXRRd3yPKS5pz30Zl26/Y7
	G929Yb7vAWRcrSOkUItSYew1Rs5NpmvRBZnryw2ebKk2NvS5qB1yhcOAwuUqnZVSlGbVAT8E0Rn
	sSndY4cN8CLNf4fgdbfB3C3480nJCVHY5j4TT/DIhxsi2HuA/VhstCssHPssALPHvP1+hUIanW/
	Yhv17p0Qeq0DlqotY4Ipl6R8xNZDbeNh4VqFZx7JqBg8uM2aI4QtQIuNqCFL83VW7/8zNB3R33F
	FuZYSE0SFnFdBVJtEukOuuflzNuI2yhx
X-Google-Smtp-Source: AGHT+IFbafhfUykgIwrlGa0j1wLPfIKEiPAMneKWEdjawIrQPwGm191CuoAuWlTu+ZSrL5VsJzb0PQ==
X-Received: by 2002:a17:907:2cc2:b0:aa6:a501:9b3b with SMTP id a640c23a62f3a-aac2b28ee13mr4447377266b.19.1736214002473;
        Mon, 06 Jan 2025 17:40:02 -0800 (PST)
Received: from [192.168.1.3] (p5b2b4110.dip0.t-ipconnect.de. [91.43.65.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e89598csm2305748466b.56.2025.01.06.17.39.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 17:40:00 -0800 (PST)
Message-ID: <25e03704-e05c-46c8-be75-de4b784e4d31@googlemail.com>
Date: Tue, 7 Jan 2025 02:39:59 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/156] 6.12.9-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250106151141.738050441@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250106151141.738050441@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 06.01.2025 um 16:14 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.9 release.
> There are 156 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg 
oddities or regressions found.

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

