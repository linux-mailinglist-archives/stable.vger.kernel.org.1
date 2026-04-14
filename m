Return-Path: <stable+bounces-237941-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIxyKVp93mm/EwAAu9opvQ
	(envelope-from <stable+bounces-237941-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 19:46:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8023FD39C
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 19:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 978F93080E8C
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 17:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6903F0761;
	Tue, 14 Apr 2026 17:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Py+iTtSw"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF233F076F
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 17:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776188527; cv=none; b=nxDmdBKYysLgGxVnijaXm++eUUkCYhZY+YCOTJDJ58QztEVdLyQlQYIKzUiuWRF97nZkYqtTZGbnSeEcnj7WCQV8/r1zcQafd0bjCyMwCMAJsoMsZtH/2uVxYUDRCoQ8BG9iCPxo3TShss17n4SPGyPiGfiAi8M714BxfYrBse4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776188527; c=relaxed/simple;
	bh=Bp6eaNxoewJtAQFg/X6hjacBGtmbdo5PVWTDgDpoBFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lYk1qZhswiHpWUY02WFidQcCVRp4sch3uTAHpm+VXdzpYJhmFg8gqBjguWfUUOGGXWajoSS8zCFMuV9wnDF5XUBPjS2xEpM5JEyDytRZ2t9ZNBP8hhtxf6FwduERcgAYbeirgzmjVXTednK4o/cOK3J4oVDA6/J/EAJaVoW+6RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Py+iTtSw; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-467e8aaa865so3372235b6e.2
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 10:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1776188525; x=1776793325; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xjTabAmVI+AtQfTyXgIF3cCFT6B6B6zpltEOeURiNWE=;
        b=Py+iTtSwflp1UMen12IJyvlNeemMQ5VV0Apf0pxTyPtkXY5udOCk/KVcIJ7NHpA/83
         h/YAEKp6uLsTIPZgu5Z6L8xh46LUmmCwYjJHRGgOEhytElGEgeChmqb7hxL6y8nfpK0t
         PW3/64oL7unNbqijI74VyM5NFup3Ho1gkAapc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776188525; x=1776793325;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xjTabAmVI+AtQfTyXgIF3cCFT6B6B6zpltEOeURiNWE=;
        b=ltOPsEllzjPq31saDZ0rctuG+0c1HDRuT0Cvw3TzsXm9ddqo+EfOwfAFMARqSdaNux
         1p9b/SDBX2XTneFXXDzqrYGOEqhqmZX5Don+rbA6xM/wrw0vgASw/RFbMaU+tmyVlA0R
         rXGcOnj30VeoQWhKxIb8Z9O/gwh4rB56Tf70PveWw1I9R8gw4o9WDJ4kUXbWTQiYUeJR
         h3B/ENOhi5DruWimRZpkdLK/rjl4s0Oh6d9yS46rB+CkEMdmncX/Ho6z9HIuW+JEJ+zu
         wQVMJsH+e3D78zJ7+ubrkfMGN4Y5lr2mjjt4GX60ImXPBiZa229BepPuIF+2Gcu9GD3n
         ItBg==
X-Forwarded-Encrypted: i=1; AFNElJ+Ca2S2gOF99IpEGztKgvOSF1KDMGp8dIuMINFYiJEWZKLggbDki/YdPeAKY/TuO8vRsTIRv1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhXocS80QwUE+Nx4zblOkMd/ic0EPJYBI3alL9mQWtSPSSeBZm
	iipHcB0NSde6nWahtIJsbVqu9jMlnCrISBT75WS8aTwDYIva4XAnR7GOifNin/pcCY0=
X-Gm-Gg: AeBDieu7imnCMIFxtZepBT0gTlXqOh0IX7eqdH5GbD2zTcIQDMrQFF4JOH3ftPW+fhz
	U9X6AwN8wSfsbTizalbEkstD2apeat3new3ROJq36wb9xjSz8hDZkGhm+TSv8GHJlRapeLqCbSN
	6PMHn+1rv2ywMqQrW/KESvha4G/0eQsUUEJ+8tQZWttsL6+s4pKDI+Laluffn5bc89IHI+4kudd
	5oVqWho1cz3ZUaLAmCKJjSBiztDu7SHcCYBZWZZvmmA+5qbj3uxV1a4gh2JA+g6ndEyo5IAuhYv
	MBFyLhssJS77ttXHLDgW2Y3W7luJVVSG1f9e4OBUpwIjgiF5hTnwN3LGujcTNOM1AkBoyZ9dfUk
	1SuyBtooVAjFKvWRvN4m1f5fFuM1aNA2BQthCn0beYSw9GcnpVv/H5b2DjYzjow7N1lNtNFPi8z
	qzd9RVcMLd/YJjlYyjMGpLhaVApRK/0qY=
X-Received: by 2002:a05:6808:1902:b0:474:2be5:ad4d with SMTP id 5614622812f47-478a1414bacmr9008978b6e.43.1776188524821;
        Tue, 14 Apr 2026 10:42:04 -0700 (PDT)
Received: from [192.168.1.14] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-478a2f557b5sm8549461b6e.11.2026.04.14.10.42.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 10:42:04 -0700 (PDT)
Message-ID: <011e9865-a1b6-456d-b6af-c6cc987ea0e9@linuxfoundation.org>
Date: Tue, 14 Apr 2026 11:42:01 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.19 00/86] 6.19.13-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260413155731.568515178@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260413155731.568515178@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-237941-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhan@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 0B8023FD39C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/13/26 09:59, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.19.13 release.
> There are 86 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 15 Apr 2026 15:57:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.19.13-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

