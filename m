Return-Path: <stable+bounces-239955-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EERhMblx5mlgwgEAu9opvQ
	(envelope-from <stable+bounces-239955-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 20:34:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 318F4432E92
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 20:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF49A30C0FD5
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 17:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676B03815F2;
	Mon, 20 Apr 2026 17:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVWKe7u+"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C323806AD
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 17:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776705186; cv=none; b=osxqDtsNKh9G0HmKUq5Q1ui2hJx1/S4RGr4HEX7HknzskT0y8g0/ikqq/ASwZFkVujNzAM7ggaaMIeALiBFz5g9sXLSFWrYa7WZvV4nbj4AgwAYYUmLqbhRFtomlL14Uktb6vcAOi+sVE5N3bb4e/zi6vUJHUS1yxnIFabH8+10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776705186; c=relaxed/simple;
	bh=sNwBkCu0yCcSfgkhjXDaH72xkksLZyxARQi/uB3xU5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UUTH88ihkvvJ7XEzDzm9KqhR3k/k3WkFWP8Q8HA95a0J9iULG1/EyFsYlI4CUthF1dvQ3AVdQaveYLCRl9kcp2KNPlV26Q4t9gMzlnzS6N5Yn9Xcly8OkcPV2n9pbMEQmgLLqyuisE9aDRT8ORPmOQ1ZDY37ZzDJsX7M+ujaQDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVWKe7u+; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8d68f702851so397470785a.0
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 10:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776705182; x=1777309982; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DScRbgqG1JwMR9u/LCfclB/57bY2SHk8XxzxiX3DR3A=;
        b=BVWKe7u+lGbLmn6MLG3Lj+adwu+A91gScmtuLYliJVzoVUaTEkndllBjs1EYeSBhMy
         /GNRQVSnikx/BmJGylL5pSTpDxO8zojP0RjInl9zdoyh2SwyOeCQmNbR90tIcQfUZTYr
         LpsCFhlLXi0xGT4q/KD5dL/PPSEkVVvvU0i5v39XZLd9fRqbzEjMFtxyUqJ/c7RnNd07
         Pi94yMtvSYv37moaU0JlgPPXLipzMX0Pq1D6NJdmoXgaAo/LlUdqx7lEh5a2e1xEWu78
         3xcGfVya5cSZmbMTgVGbQMn6HW693jwU8n2K7z6Stz8R99EVmQE2L/VAyBTQ08ENCneC
         eOTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776705182; x=1777309982;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DScRbgqG1JwMR9u/LCfclB/57bY2SHk8XxzxiX3DR3A=;
        b=i2hIDkmhb1zYyQQX+J4lVpeCNi82vTvchkAn//BbRE1cCf1j62EQ0MoqWNTEQqjLvw
         S36iuohpcWPRF8sX6TKkU6aT1fq+EuyO20NNXGI/7oWqXEwUFoASmxECCjeNxfWARB9U
         asRrCgHaMU33VuqeIj0r1dymHOgbMXa2eTcj/w0S5kX/9qJOvaOpFt9cMxLt75ZYlwjO
         bTzpCTi+K2R8voeJ2+Id8jKPgVEQa7ccjxnElkIKIimItUyK6La7qqupUVQzi2VVoEVU
         Qbj+JxwWapyRjT5dTFT3MHaK/H0YXxMzlj03WcgPI5o7HXFwh7aDiW8g59c/RrvZlrJ0
         i0lA==
X-Forwarded-Encrypted: i=1; AFNElJ/g6e5oNNUbt9io0xNF5YBgcP8Luj/Leu6uRsOQ6Bx+rleLErBZxQUnkSKvsTwwQlK19JLHbl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUZ9ayXQwJ873//5XdFZOptrZEoNLSNSxYUKXqcmi6ajSqU9TX
	syYr9BqZVFmYs27NHSxsuhd5jIRBq9VPTKdDVM+q71j6IdnWoFumxbTr
X-Gm-Gg: AeBDies1O9X96KMJCntqcTGKpRIY6vvdDybQlQLs2OtMKopFm5yNHi1mdkBJHJqTxew
	fKmSCut9riXT6jjuIXbaOPwlKdxLrPzCKKVVxDn5th6agyCO4xgptNmUuDSBC29g9L8l5AMnS4D
	daN3HHvqrIO1VJR0m/FkSG6/IE4YLJ3egD6B/608gLxi/wnarIOBV5ctEXI8T3VIrDBdPSFqq3Y
	2+ykadWMQOwlB/ilCH+37t/4XGe5On0Qc/oX++aiz4JyhxOY6LdFlJIcSf2qJJJBwOhyD9B2CQP
	MVZrZ4jPAQ2UjT4j2y7GCSx9E5ZPF5c0jpM3WbgWnZjeRkfTji4r+QJBqaw9Oz2/4l9puOjZPJz
	fKjNFZBQtB8gAUaAQjDKGFXNM6F3tGHLre5ARGwcb3jpC2JcxW1iNvyMYThtfBAmdCpSVnO3ACV
	0ezoal+ZloRJlqEDyE2IyT+7EXZSiCu/HMyv1fBXub+I1ZBw==
X-Received: by 2002:a05:620a:4456:b0:8cf:e1c9:b286 with SMTP id af79cd13be357-8e78ed5dd31mr2013867485a.2.1776705182384;
        Mon, 20 Apr 2026 10:13:02 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d5fe90a4sm874099385a.9.2026.04.20.10.12.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 10:13:01 -0700 (PDT)
Message-ID: <d8e99823-9296-4b9c-a26d-acb16d58ad68@gmail.com>
Date: Mon, 20 Apr 2026 10:12:58 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/162] 6.12.83-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260420153927.006696811@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260420153927.006696811@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-239955-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 318F4432E92
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/20/26 08:40, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.83 release.
> There are 162 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 22 Apr 2026 15:38:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.83-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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

