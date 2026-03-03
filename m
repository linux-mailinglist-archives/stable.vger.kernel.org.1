Return-Path: <stable+bounces-222790-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMdAA1xzpmkuQAAAu9opvQ
	(envelope-from <stable+bounces-222790-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 06:36:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F40E1E947E
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 06:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D8B203011509
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 05:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B33282F03;
	Tue,  3 Mar 2026 05:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XP1VeXdB"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BD840855
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 05:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772516179; cv=none; b=B6ff3u32K0dIHycR6gdTM6xWMmmq7IJVnNqyTEXAvMqrgVVn140Z9SlXVSN0DC+nicZTaFZ86fCykIsJTdZGVgxIXCio7NoFvS7xVD4asG5o0aorIi4+3oIcD31yjZgx1iT61DrARPABtKQYqSFDYlIXlo5XHo9hXpqkWiBinTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772516179; c=relaxed/simple;
	bh=nfTUl6XfL511CTcdM0JnR/NJoknvfNZI8VA3+qHeMXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CYM/Sl2QQkFVQad0E51F2PrwV/ZqHeEZMYrtXg/9Zni4ZRVwWW/1aay4uk41Rrx+GxUonccWn5Xe2SPUnTL8LN7X98hS8cPZkFRxn7Q+/AWm4SCR1BudXLnXeLkJVn/e39Tz2U6zBy3nNNsa0haNoTMXp/tgVNOikddGd63SsRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XP1VeXdB; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2bded9bf7a7so3414411eec.1
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 21:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772516177; x=1773120977; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KHCCjm8Bm4lkp89j7/3fszuU87OHs/Re7pFoKbSAl48=;
        b=XP1VeXdBthcfXGVubIh19DN/KCBGdW6zgZLy4xo9lFJS2NA1roGduaVihb4QhpHYpy
         ZdDt0ugBXM83OOSdg3llJUsfAIWGt4W4KZD1umOxhdIBnlyW88w7z4VD8OCYUQGrwLmy
         tlYS9cLq9J+/gYUwf7DePvUSdMIQSKbSuG3MMlWpBkZABnr5bwgC+uCgS84aGScMsqN4
         aVerl/W4YJOpcdtzVvpWadRjpRStlc8VwKSjKuVmdbFo4bStvNUrfLJoE7CaGaESwzTW
         YOgthMiSJLtcE3MeF53fQGstEVus1A1f20ADMIBAzK90eL+IG2r7KGU7lDPfNzOlV4n+
         PSgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772516177; x=1773120977;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KHCCjm8Bm4lkp89j7/3fszuU87OHs/Re7pFoKbSAl48=;
        b=P4l0CiOpBTRNHsrw4tgSKVSaCc5Q8GEOMIoJyhSeM8b+mBMCnFg09YI4QJUxihP1R6
         v/dynDeTyjZYwvyYwZL2xT0sO+/dVGpuB07D21tEfYOSTeECT6XVKStAANYuHWWRDDJR
         cDJJBjSSk702RVZcOT94iIU0Hk5e2qTSTIxX5qC1MpLdyijb0ASV9XnbKJNpUXlyYPtn
         FNFMhttIHjiphAM2pcP5gZHGVbxlIUdju/TjoO4VOJb2OnC5AVgOs1sbl5epHK2KQmfH
         wl5ZahQzSYTRHzSTOb9/ijQyASdMr7ozs2J+heaj6MDw+QJ7uzyQHEUzjSVvIu1L8FsD
         OP0g==
X-Forwarded-Encrypted: i=1; AJvYcCV7fvQOhxbqc3vOFy8FcWcny49Gp5ds0/KJ9Sy4fS1q+TVsH6uV7i4VZA8sUmwMDllhj6fYSzk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm1AqWgjP5GXUYt2F7yvuTgg1AKfUEwMvOROsTaFFdHXLPzlUb
	BJYcDEoPMRDf+F6kkdpUAuCSenpDKCceR6Y4uW4b8I9D0zd+VfNAVAaZ
X-Gm-Gg: ATEYQzzuQDRSNFJUhn1BwWB6VpCjSuzzbd0t/0Ga7WXugpawwC45oVBBr6D62AE6bAE
	zTPWuK/M6OpzlRPcF4VhzjZxCfcNreCxyNih/VHqcr+Z+xf28IOGPNWpYodFf0WhRZC7dLP5Fa6
	7W2W1OCu5IbflFjIQzAxuUuiD1I6AF1xpFGRGPmF6Stahb9QKS7C2OXqLxTMbIof0r8OVZ4Elg3
	bGftiF5AzrKiJPeW0PHESPS8ZbxZ1/H2nl3GT1tf9OhHlScjf3Yfj0m5PpBYx1Apq8jxgVL1yrk
	dsDpe9bnJCGDeFMAzrZl/ABWrTHvFSKpy0y60Aqkf7Lx0uIvblPTrN6Zijwfxi21/rnBsEv+8K4
	kvJ4AIKTztNaPKWQXf7lWuRevSmBT1W3xSGCIvkM1CG+1c/wDrl72Uwv9bBye+WLeXJh7zeQ6a3
	r8+2I/jsed7Yht1enUdxyLWs9kAjpPyaSW/UsFgQ0lewQfRuHD9G64MbKASU4ZKOa+
X-Received: by 2002:a05:7300:538e:b0:2ae:5e93:b6d with SMTP id 5a478bee46e88-2bde1fdd68amr4317602eec.38.1772516177484;
        Mon, 02 Mar 2026 21:36:17 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be002ee839sm7810973eec.8.2026.03.02.21.36.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 21:36:16 -0800 (PST)
Message-ID: <8b6aaa08-73db-416a-9288-a1ec9b384247@gmail.com>
Date: Mon, 2 Mar 2026 21:36:14 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.19 000/850] 6.19.6-rc2 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, patches@lists.linux.dev,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260302160834.2518716-1-sashal@kernel.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260302160834.2518716-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0F40E1E947E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222790-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action



On 3/2/2026 8:08 AM, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 6.19.6 release.
> There are 850 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar  4 04:07:42 PM UTC 2026.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.19.y&id2=v6.19.5
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.19.y
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


