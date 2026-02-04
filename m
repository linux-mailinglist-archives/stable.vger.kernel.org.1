Return-Path: <stable+bounces-214361-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKQvAyeqg2m6sQMAu9opvQ
	(envelope-from <stable+bounces-214361-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 21:20:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60121EC694
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 21:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D90E9301B93D
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 20:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0043742B748;
	Wed,  4 Feb 2026 20:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="go27dGMk"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8316142B72F
	for <stable@vger.kernel.org>; Wed,  4 Feb 2026 20:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770236448; cv=none; b=ddiZon73ksF8U4aaS0X5mI+2AvdkhfwlyK7QMUxG635hFZWdXbLqdN8+uCH5MsisBkFfkibEUmnCQXftGutHBMTZ6tWrcfDwEqjUD+yyKwapP3gUuF5zwN7/E/2GM5hrSEjE5BeIWPWBMK9Tbp+kDudY2OEj9gmV4PJcjuvUxpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770236448; c=relaxed/simple;
	bh=Z6g8ttM+QPeOoNeS/k8nhyL8ZlVQ/Yxv8xokbhjv0aI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Aq2h2MCywz8S9/Ge8Z9auz4qPiSCDpi7DvgFtBWgami9Vn2wLhd06FGWZSTxF1O7nC7tSEMF7XplcSOwMb32mBeZWJH0u6qwE7OpwYecS8W2sw8VdsCSYTiWWvevYuoXrTYsj61cdp4Q65eiywxe2zOLy1Vv4lHUQ+14jcBqv0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=go27dGMk; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-4042cd2a336so163790fac.0
        for <stable@vger.kernel.org>; Wed, 04 Feb 2026 12:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770236447; x=1770841247; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oW7X13HpDT+eecT2ERTjNTs1FBfgPMvDToXP+QNG8Zo=;
        b=go27dGMkDhLoKGRTEZczdZNg+oiFo+AmAS0SiLXOYyvoeM0chFHzxbLYCgaoqDPckg
         pnxaKfqFrpGTwtB4jCBPfhXcm/3Fm8DvkS77Qj5AJzLqwIOnURTXAZ72TYAl22wSgc98
         EWmPtlMzoZzw0pm9+y4pPlXNJt8PmrPv9PCR82csSfv8zhOosWGNZ8thecDVAZra1/D5
         oJuurt3rEOGlcj7+lAW7JeFCCZj6UCktGjstZzTx22B3AJeFHjoOUXCuB3uo28BypnJh
         bemc5RU/AdupfhpXC3Xhh88jbKpzVXmjAPP2spTpNQKCAJ5zZ4w5ZSEIxHvum424/KTH
         4bbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770236447; x=1770841247;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oW7X13HpDT+eecT2ERTjNTs1FBfgPMvDToXP+QNG8Zo=;
        b=iAPn5TP9fWUD6lD4rU17swPlkUd/8LExIU44+UpXpwtDQswgB/VUrOkfDGbaWiyo/Q
         +FqUFyEEu/Z/glaKUv9jQ+wcvGfQh//SWG37ebeJtg/JWkCX9f3rrU5LICMvhb4bVg1W
         t2DlV688Ws8bB6ZS+J85hNosVUx5T6QhimsM18h259yUBQJy7y9iBdhdiKCQUFH1b9F5
         B71I9WVAhtWepFfi1QK814cN1jTo1c2uu429bpWWOrFePhFlR9gApwVqOyMQ4ga1nYaF
         vSLthWqEpm2csYJJeS7JXaxupabjcTN+qG1BqBPcUbyTWGT5+aRuLUe/Z+mWTM+EJliv
         HfnA==
X-Forwarded-Encrypted: i=1; AJvYcCWWL4X+Uu+VLJZPnOksn963ET2zaV8p7XNwvLeRih36amrGvBj5ct2qgBLyLss/DSEHUdd1EHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVD6e6PV5ustBsS60LRHLSBiB7TbVhTPVwGAIw6qOWWzXixSjw
	zu/CSRIxmgj6OL+KdhjD52eDUuFXKDFGRNilch+30bFVGxuNFfRI3uYr
X-Gm-Gg: AZuq6aIuqKVVHmNdehQ0FvEF3C6tZLHZPn4NLdXf8VGU3IIH1i5AZc2UxzGcSWmxXW3
	bDwEsc9xUtjUBeBNo5+vZquyegMN4cSUw2LCMrZ/PgQX6u2WyD9PiVQuZRilMa/b2Bgf5FwQf3G
	AsValXltevm1vzmDJ9S3RomuJvMEXo5Kw/X8oQuunQUWpETzQwIlM7gmEF0VMeDPbeVcXqkJOSF
	raX0x2hrAW9QM1fE+RKE5j4GokrT1tmll5urhYgNP14W00sRTY2+DQknfXTDRmVlYlJTrR4UQdr
	hGQxiMTm2NQ3R6+HZfrHAId3iEQCqtgAa9LRdWAmdOdOmG7SGonXziT+zk1MW0Q6d19Yvp4Z2yb
	ckLzvuDESDCj7ZImnvTxSpikjgxvYtaf/Dw3isPBGsj3Xsh3MrqfPeemIYKA2QACZeMXg4n9gj+
	B+1EXENIzrhSjgPVkQWFbY9lAYxpG5l7tPaNeRHw==
X-Received: by 2002:a05:6870:4194:b0:404:38a3:9695 with SMTP id 586e51a60fabf-40a53d3b11dmr2382418fac.22.1770236447363;
        Wed, 04 Feb 2026 12:20:47 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40a54489544sm2337660fac.16.2026.02.04.12.20.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 12:20:46 -0800 (PST)
Message-ID: <67a8595b-79cc-4ba5-9ee2-c139b14dc88e@gmail.com>
Date: Wed, 4 Feb 2026 12:20:44 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/122] 6.18.9-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260204143851.857060534@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260204143851.857060534@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214361-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,denx.de,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 60121EC694
X-Rspamd-Action: no action

On 2/4/26 06:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.9 release.
> There are 122 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 06 Feb 2026 14:38:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.9-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
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

