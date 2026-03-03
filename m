Return-Path: <stable+bounces-222785-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LCZH6lwpml2PwAAu9opvQ
	(envelope-from <stable+bounces-222785-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 06:24:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A25D1E9379
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 06:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5AC843021B9E
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 05:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B523019A4;
	Tue,  3 Mar 2026 05:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWacsPrk"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02417263B
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 05:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772515494; cv=none; b=JyqX8KAXaeQpwpZLTZIB72vo1XpFA7GRGzpZp032IY/gqtsTESr2J2VCOaVP3WJy9mbHigE4bU1x8vH+nq2hpZ+dt4OtZvsOgkz5wfWMNhvJaY3oFRyb9THpAYy0hM0n8Ppd4NbtWjgzHRJE0vAhn2FwFGaL3Z1ArYK443bb+mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772515494; c=relaxed/simple;
	bh=OmgczhLsscjudCIyHZjfg8ToxzB9uU+YWccAwDwgMt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sgX/ZibTnwL6m+REtG/U/BqYEL92P4J/KwchWbm0llSdfGauuusNcPhAStP7+6sWjvMcy4fz6rabo1xvnRXP85DE2eddtEEC+Lo7V09S+efwyxwCrxRrQFHyHYZlS6Fr/Lm5WgAOH0xXeKYg4rSwhCfvjhDLK7akxs01VuDuPfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jWacsPrk; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1279eced0b9so2479575c88.0
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 21:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772515492; x=1773120292; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G/yAR5+sTAGjfJDr9FUPTs2m0JPIoNox9adcSPKnJL8=;
        b=jWacsPrkhwzkmPfZUD3wZGclfgkxeBeHWOmQicjNFLdcGwmR/q3YhFsE727BvotKaV
         yIXEdPc5NrsXuuXWAwDNNnpNBRKIe3lS+D/nZvCccaSs77JMF03Q/FNHz5Loo0LVGZXg
         XwEBlTEUBAGe5OJYObkq1totPbACzctCZJ9eTISYWPghhTT0IzFzP4bWJtUx7/Grm9FB
         UIMz3pctgz83gQfznkBLZS/rUiI1NyFiWwEPRlQkcpGhG++dEVSuzzMw2nPJIv6QILb3
         WKFxaqbYfvOnpe5eTyF+ahPqFk9X+L2M36ys1Kaqg1WmvoFNdh2/JmhUg9vUtIgs6N3G
         cKTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772515492; x=1773120292;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G/yAR5+sTAGjfJDr9FUPTs2m0JPIoNox9adcSPKnJL8=;
        b=Xflun7yF/0lJ9QF6O/tI/U3tBv7tj4cOwmwkFh1n7Du6XqCqa95sbhMZWQ5iiG2Ulf
         HMdtLa7TlxFxUD1PDg3QkiK51HO+I17hrq5ULyoaBSmPDnNkcU8NHpBg4tW7VDpELHAX
         hLh12mwmYxRC0u76LuPP9LikfSj/1Rs3+ieq6l0AVAlxmNyChROuZSDaKl490gIW0FBH
         o8f3z2aD2pKL9MbpI0k4PLisDrE58CAOwQyUd1qPsbLcaCjJlVBJ90bapUEgNgtAVoR/
         S8pG7hFti2R4Ph3u/bbPgVjarev9WzWtWxydCzpSZDJsm8Gdvy5aY0GzgQq6okD3EqrV
         9PZg==
X-Forwarded-Encrypted: i=1; AJvYcCWBjFbujFi0MCk5VVKWInOAS5GpvKdXztqTroXvddIB3aCiqAXis0CLUGyzl7c7deaF46WNb1o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0ZihyV3AInS28oHrjhWDRymlvmU1jtYGzMGN9TFY8Rp7lmqwd
	jZ7IlsLzXYPcVcqBWQM+WYuTCkSOtF/I8WxRp2s3w7g5KxFq8i1z8XFT
X-Gm-Gg: ATEYQzxM6TTzwz+XL2YEyd1t/IqfyupoOpNIqeNcmoucc6d5Wttd5g9sx1R6UnRjKuL
	2fOFjKWeUOlRdpy8R3wIIl9EIkCo9LTJ7ooCjYSB1MGUDPT3wbDueoKS4D4ZVT+IcqhGAnfwL98
	f/+VCIBs8gs115FFhc1NzwIbbDmi6YvZ9WcmQG4T6qaoe2objgjYcMIU/EdIiqL0iEflvZ0vG07
	dZGcRiurOUUQcvgdE0RjySOkWAmVUUEAt7WJNA992l0jx+bYQ0d4fbFA0TuK2+FL8x93UuIeq5w
	BPgqUtlXJ4edCtQtO5d9Xbs7QkjpoWpuS2yjtbiIU3aaoI8LoT77fIgWzYrNkihQAAzvhdEq41L
	8Y2i+A9m0K/ZsTctZ5xpqVpWmlVT0dB15C+eSkQdQe6wxKzUa4Gw/zvGOe6LqL2fOyCrjjIsywt
	KG1ND0N0mpMqzMPKJLiTDq/AMXBD+4an4yb3lszIM6rDKlGggEVqqbl8F4VvxLrpyFNpxPI686O
	cM=
X-Received: by 2002:a05:7022:51e:b0:127:5cda:aaf2 with SMTP id a92af1059eb24-1278fb77ea5mr7022543c88.10.1772515491832;
        Mon, 02 Mar 2026 21:24:51 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1a45a58sm11959744eec.0.2026.03.02.21.24.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 21:24:51 -0800 (PST)
Message-ID: <cfbc3f02-863e-4af2-b402-af80185d5e58@gmail.com>
Date: Mon, 2 Mar 2026 21:24:51 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/757] 6.18.16-rc2 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, patches@lists.linux.dev,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260302160853.2519610-1-sashal@kernel.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260302160853.2519610-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2A25D1E9379
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222785-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ffainelli@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action



On 3/2/2026 8:08 AM, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 6.18.16 release.
> There are 757 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar  4 04:08:47 PM UTC 2026.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.18.y&id2=v6.18.15
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha
> 
> -------------

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


