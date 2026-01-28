Return-Path: <stable+bounces-212667-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEYQGZVqemkm6AEAu9opvQ
	(envelope-from <stable+bounces-212667-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 20:59:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA1DA8579
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 20:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31D563024A23
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 19:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0419372B45;
	Wed, 28 Jan 2026 19:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDm6aFWG"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8EC374747
	for <stable@vger.kernel.org>; Wed, 28 Jan 2026 19:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769630332; cv=none; b=S0yf+xqahyG6c8Hx0HLTpPkdjSNl65Z2XDxdqUx8tuAHdCePJg/aR8R8W559n7jUJjkDYyO/E2hagavM1GWsW5CEQjNXcpvasKPjEaHEFTgxtmSyrTE8UskH199sKN0OxM7dxx+4J9rYQ1o0XmmYza9wmSeWjHUaspVe0mTLGms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769630332; c=relaxed/simple;
	bh=SkBfThcnAxPNUJ+YE5E7BDTixCjNonkAOYu7XIATugE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=APw/O2VC8gCL9pWvZUrx2ChDpYMuGq6rc3T84mQHd1v+XdqlmAmj+rQ5675Gy15fjM/h3Vbwnc80cvnfy9ap4Kpb0mxWdXAbFa26FfmLaGrfDsmcihIi94nW65hZbfdPcKxTEoGvKlvm4KjPZExsIb600MlKUfm90Tqpg8Yxom8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDm6aFWG; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2b720bb90d0so278343eec.0
        for <stable@vger.kernel.org>; Wed, 28 Jan 2026 11:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769630330; x=1770235130; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oR1WIC8OivmdFh8o5Yi+JuAasxytY/KAwOdHEBcQkkU=;
        b=mDm6aFWGKLyfdDCP8h+Yr1gJJjERcmCsGQ6jhfDHBhx4t2Zl/Jcyg/0c8yWioJwaVA
         AmVdraVKcLN3kyobBjfT2AmGD403tcxf29PERWRA2nWiO1vjwvZrrPbVs34c/XPy30Y6
         QAHSPYOd3/zUMkn8x0Sfhzj2s+zS+MaU67oOp+NTVSy1AkHqykUEB3rezFp+uKu1YkxA
         jGrCuW1yE3/YigDveF14NH137bsCUpAj4TNOC5jYT7LjBjDW086zhwYu4B4F68E8d/z4
         uyWW2DDUwchISH22wwY9SAj+He5VxF4AZ8jTMNkiAs9W635R6EYHL66twdYyMv4PSZhd
         Z5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769630330; x=1770235130;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oR1WIC8OivmdFh8o5Yi+JuAasxytY/KAwOdHEBcQkkU=;
        b=j2vo4e6sebnNY+N1C5MLjms+vxloqMI8d+tAr0+bCZQ46NKaCFkOIoC8qQcjKC0IzM
         jv+A509fK+4zmgH3PDPwAehNpeE2QK4DE/VgSOL0n87E1x1lfoYyIZFtmM7OatVRVUq/
         qsYsiW/WtVdp1Olcy2wQWXoESGzcbW1s+m0IkA4dKb2/pUGgcL8BDg3LNRpvc5wQaHx8
         jWkBzYCmErak7y8jlaMMbPy1M06gyHcA3QpXek0Az7oOXMKn8prk+yh8yLazXXtfRgCm
         KN5RrC7W/V+8reUOb4oic89MPs65sIkqzKH1mtYb+YZLJTxn6wCv1pCBf878FbsE/4WN
         zgdw==
X-Forwarded-Encrypted: i=1; AJvYcCW1wQyz0BSyC8u9FYQQF73+kJpDs2HqJh3ZX5LHH8LT7qBs1XBGjhHR92w+DOzITaqef3cpfzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YziaiE9bogwBnV21aQsdscLgbb42que7+D8a9kBa/EpgRI/7h3j
	zXfgiFCHlCq5PJR20oTDka9M+xINzm/bkKTwcmdX+S2K3rw+kwQi7hpa
X-Gm-Gg: AZuq6aK41/4kZBOPXr6poagisSbgsKDPkwmvdmTYwdTE289MUY2XNU91DQ96hfBSdD2
	L22aY+k/ci5+WiOPEEdIxhm46hkPszVn9CrABVUDaMcd6E5GmEib6S6H63bMbAs2LqxvwOma3CS
	Ck4Lohub3QnxZpEdJKmf8GMc1BZ1g8pvuMTNxP4AEr29D7YyuScomtJPR2cFt4Bv668OT5nFEzR
	fxORjFHnWLPXgGUkRkAu2ICfu+FIuRSQm+IrirYS5gm3Z0OtT7L09gYp0f06ZPdjTTN8mXeO/zJ
	6E74YcUVxjs0rOr9/u5tv3mkRDyY96d4+KoJ2X4DG6ijDi06+If0auC2Cx2WSvG8b5ozk77wUot
	Q5PTRk9lva7m2IP2ASXGbYVbAGjloUgdd7x7Ynmuns1PhKoJlKn0iEz5V4xTFZ9+QT7TjyV/kGa
	jg0/TW8aMBpBX7Pvj8L9WkT/ZhtQKZ3rbmjEemzQ==
X-Received: by 2002:a05:7300:bc8e:b0:2ae:60fd:6f18 with SMTP id 5a478bee46e88-2b78d9f1bc8mr3966294eec.22.1769630330118;
        Wed, 28 Jan 2026 11:58:50 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1af88dasm4456562eec.32.2026.01.28.11.58.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 11:58:49 -0800 (PST)
Message-ID: <276cc8fc-b909-44ff-9f94-1abdcc33631b@gmail.com>
Date: Wed, 28 Jan 2026 11:58:47 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/254] 6.6.122-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260128145344.698118637@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260128145344.698118637@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212667-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,denx.de,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DEA1DA8579
X-Rspamd-Action: no action

On 1/28/26 07:19, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.122 release.
> There are 254 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 30 Jan 2026 14:53:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.122-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

