Return-Path: <stable+bounces-272178-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0NrFHIGJS2ouVAEAu9opvQ
	(envelope-from <stable+bounces-272178-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 12:54:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D97A70F852
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 12:54:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=iyb1G52l;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272178-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272178-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1A59A3010DD9
	for <lists+stable@lfdr.de>; Mon,  6 Jul 2026 10:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094403890F1;
	Mon,  6 Jul 2026 10:29:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5378938AC72
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 10:29:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783333777; cv=none; b=s03L1fP35KzTT/hGZJPsbLcBBOkFHNRlf4KnCTibTDPkRa7OWNpi6rgQoL39B3MAUlQ+dqsBmMH6pKLye7igPzyTcfCFI9o64/N3hOMuvqKcmil/otFcpvlunow1O7oOkQnxVBLOhjBQsnWUdh61JWX3xNVrjQ0jjhNqxg6JCs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783333777; c=relaxed/simple;
	bh=hQGFqx4IJ46LMfGQptkfnFSJjPUglR76Hzn2hDUlyrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pgWRmwbOp0xbKY/43c7q2u1gYglQiK23yvIGUYubF2jsHW0ENxnSLiJ7eTW7ei6U+xmo4d+16fA8E7Fl8/GDztGZj3fTDxdGdJdD7sWfPiT74H1duIFhxgWOh2l+bROgvnKsmvXE9SZpW5MtY3hccNynO8H9B7IcWFtkNeTSx7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyb1G52l; arc=none smtp.client-ip=209.85.221.41
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45fd464d51fso1430464f8f.3
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 03:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783333775; x=1783938575; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DgZGkATc9v6IJyoP0jVfXRsi6k/bycnl80rgTX/hwpQ=;
        b=iyb1G52lQbBs6fBRC3uKy2e0WR/4BbRhHfPZ4m0FYsoFMfXM6+nKgHBP6lLNHDRVw5
         3yYP2/1qWv1BoBgE+ctsLCPPc/y/Kuif0N9Ll83lTlvRh8hw2IcUqI56QytmuV9vzhI3
         JHwW/rwZa9AKvNgXUm/5AKPQ9MHoCWLwm4q9/tCQkaWXzX8n78ZI/dWKxTfy9iXXy/Do
         Kdhnw4AlPCeciQDhzWCxaMdThcPAukPOWNdd/50TAHWMa3tgVSsRSBJ5GGh3G0dEWax1
         4biC8CWJo3ebb6E8Px7ANezHVL7Jt5jhuZmuIFXW/74tD0l9v9cJ/evzAQHXh72Z/oZD
         QYEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783333775; x=1783938575;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DgZGkATc9v6IJyoP0jVfXRsi6k/bycnl80rgTX/hwpQ=;
        b=cNz25Glcy2I+f0KRPTt2tiJ1vRMEHMU/wpILUmylxE8ykGia4fl0nEVfk7sXU8e92s
         slqY57pvsIboKbegraiBHVNDBmRNUFT1iWxrlinFmTyzgBBLaLXYhEkovuaZ4Jg+pGcj
         sHbmMq61UL1NOv7Hu6mXi2vAFi9Uijm0sb3NQVOs5prpvn8BXBhqFmuBkcpLkgJ0TZaj
         8NmD/x46HcarSpTSomH5s+zhbTDxkPJkkvXdvtW/BXzNBktLXFD28P68pb0MidEqgmdh
         4WE5bYnCUzgRX7C64zUiH0/2ov6VBbjjK63jNhjSeCYf56FEu5F1/wNTk7pme4x1NUqX
         cJjQ==
X-Forwarded-Encrypted: i=1; AHgh+RqQdIyeJm3VHzVCizPHFTgXyLJuPP84Dedq6SQqkXSZHeNDUyClVyU70599sCnqpbztTfJluKE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzt7tnJ7ZuE5nDWtKTWyil8uHY4ASQg4thggTRiw38bNZcFbEL
	FyuD4jLT+orytrr8GG5J2k0lMYPA4vdWcxrIJS2L7n8Sj4Tx/kkIpTRm
X-Gm-Gg: AfdE7cmIB7712ZBs72nT152BYvW9KpLadshzTd7Kj+F1t/paH4fvQsf+na2Q8WIAj/C
	NpZUd54KQHZVClAIpkNDxtKTe5j7IWdgw1UWlaC+s6O3k2yaTn95WEYLqVAJPOv7YrX2MZNHdJU
	JqfaVgA1gcI2WnGBMAR5Ho2Qtd/z/IMYnmWBVnFSpiWP91PdFUBmHeP2pjHzIfOPO5hsVUF7oyR
	VXmcXWtcKTb5BdU7986c8w0hL58KIMH4+4KbUzstWC538LmoLGv73l43IuX4FdGnoDmfSaDLOt6
	dp4zespwzSWlD/CokSj+OUjtUZa6ecDqOpbcAIz/9MNDSggDT2iqTDMMap8vq4Ly0kLrSxtQTls
	JbFnjzG3EuASNawEC8FvUCj9NdOMASU6ZpVzO+jwTaMUDuioQ1ql63whosfbDMrR9qD1UkCw0zs
	rzZPIE1t0BnsjaLEdiMlTqRIfWVqUx7w==
X-Received: by 2002:adf:f288:0:b0:475:f100:360d with SMTP id ffacd0b85a97d-47aac5e3774mr9178054f8f.60.1783333774411;
        Mon, 06 Jul 2026 03:29:34 -0700 (PDT)
Received: from [192.168.1.23] ([92.183.46.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9b4d850dsm24605054f8f.0.2026.07.06.03.29.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 03:29:33 -0700 (PDT)
Message-ID: <2728e1ae-dac5-4b6d-9e6b-8948b558a341@gmail.com>
Date: Mon, 6 Jul 2026 12:29:33 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 00/96] 5.10.260-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260702155108.949633242@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260702155108.949633242@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272178-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:torvalds@linux-foundation.org,m:akpm@linux-foundation.org,m:linux@roeck-us.net,m:shuah@kernel.org,m:patches@kernelci.org,m:lkft-triage@lists.linaro.org,m:pavel@nabladev.com,m:jonathanh@nvidia.com,m:sudipm.mukherjee@gmail.com,m:rwarsow@gmx.de,m:conor@kernel.org,m:hargar@microsoft.com,m:broonie@kernel.org,m:achill@achill.org,m:sr@sladewatkins.com,m:sudipmmukherjee@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ffainelli@gmail.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ffainelli@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,broadcom.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6D97A70F852



On 7/2/2026 6:18 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.260 release.
> There are 96 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 04 Jul 2026 15:50:58 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.260-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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


