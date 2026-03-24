Return-Path: <stable+bounces-230035-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5/66ErDcwWnxXQQAu9opvQ
	(envelope-from <stable+bounces-230035-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 01:37:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5DE2FFC0D
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 01:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6C4F3019506
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 00:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7D02F6918;
	Tue, 24 Mar 2026 00:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="GreAHL9a"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA342C0F91
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 00:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774312277; cv=none; b=nI4KIJ4zxdEi8DXjrQz8bYxshhHHuskGgYpOZHv/1qEqP28qwL4rP+2zxgQo8GqgvodpbEInEdle6gskDusaseL7/naK4ky7jqflmvzYBP4ZBHENxjfdcmb6rmWWcKffMVXoAZiOFMhj+WZovzBfPTL4MjdamVBWK3m6c/NXk3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774312277; c=relaxed/simple;
	bh=wwQLVG4nvC6FHNwJr9P6Q+Xe4txLKqLxx8xKzuJUngo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VioDjtQfqsfl3Aei6/DJTUsugdUv12UNl4YJA9Kohp9tx3rM5bZB3zLgx4i0jEif6dwJGERDr8NJzLzd+CxzL+1P34XYab7lHP7bakOOcUnkJMFlxz13gxZQwt24BfsC5n7E/AkrCC40CjvwkLZn+kLldGcKl8c7IUPfcTofKP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=GreAHL9a; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8cfbfdabf3fso64969185a.3
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 17:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.com; s=google; t=1774312275; x=1774917075; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Zbz4JdRsqTk2Sz0npweFJlvHhK/vxWGjvrdbhc1wjU=;
        b=GreAHL9aCC+bHnawO+Ujbu0y42O5KeFoAA/Qss3gmBz1AdafeLfKxAY1BJ0qDx3e/Y
         JlNgUr2+z9z2kM7lZ8oSe7nPnnlD8Jm4NzxNMYQkplqYC8WvhlL369TfgDiGpGJIXq0n
         0LCTEB8gbl5diu+aZmNvIEr52/mzJLLPJqmsIZpPWJm6XQS+TmNcmdtV9UvGFojq4JkP
         6sgWhTcAsGP0f39N/oqR+1HLWxirCtqW+BT1w44JbV3nwnSw3AmzbK5hR+zpTU5AwEAJ
         79hbgotxcZI4bxYANTP321Qdp6gh4DLkJCKC+5G+UA8oWdRjNdATCXlRMTydOTnCvedZ
         n0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774312275; x=1774917075;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Zbz4JdRsqTk2Sz0npweFJlvHhK/vxWGjvrdbhc1wjU=;
        b=XyrX1QLB0aA35R4bOUQnIA/U7WdnBcFIg+cCwACYAMgKMENvJDHv8iKt++fbXicYTb
         9Aw6pVKOVtcbd4z5lf8EzRwbLxo1x64LLue2b6lBNV5bPv5PHHrOJccMtzvOUIkvKtPp
         9nl+yZrS+ZU04RRCrRedUr1F4jubYmeU7I7eDLjJIVWBFrvWWUwFvsZ8flJQcr2nA0LK
         rCUO69p2PGCi2+FDjLCcLOM/9fTlpantsmnpzvV2YNsdNarbAtLHjOOeBWlfA6UX6x62
         G+OmoWgaqE9gvn9MxQAZI+fB3Ni75VqW2VnLfNEQhPiRSnDNFBF06b/pWixqxTIoOWS4
         epwQ==
X-Gm-Message-State: AOJu0YwtUfpIJSZiZOgPJbNm1QKBivuFnRlYG1UM9A6RwFSjlglBecl3
	/sz2FRnoi/bFK3pkNRzp6EOGICnNmITWRszxcErcR6QNwZsx3jUTlVOJHXxOaSpXpfl9ZpW6Q7n
	qMbSrcEupje+5xjN0svZdDYQgYDJYwiVB3ISfNl1l8ZtmtJ2nDslUbq6uuknjn/CM5BjW/HQ=
X-Gm-Gg: ATEYQzwb2aOAXZkF62YZGUGqdacg+wAfpRbEx0kJzmdKqOARZtiKLr0EmddXcY3kKEN
	Epu4SeTdfdqoTfDNHOfz8JvxpCA4G97nkXdyFi467nVLNCOqZhqzAQc30wRtW0TiMC5B8SabYVT
	x47tlU+7vBUKDsqpfn7KJvISbu/wmBueySMm1N5WXAtK6mlxcsEUnEa6LoTfr8InjFVE/hCYg+W
	Oy4Vhcl6Ra1x9waQesOa/bjvRia98Ku3OzpE9/QaZR5C/VyaaaZFyaL9KEsI/2nXO5EHMedwj7C
	2NiC04QUyRDlqHz81b6kxeAaf3Fk0+koCngr602IbMthfp+yyWTSBWttzdg2zpKQWPtQt79w4XK
	I/asVCXZZiJyCut1WA5kg9+rcy+zvSmgid9viyqnZRZhfnEoLcx1kpztmWBxUGibnHrJ8Y73cIO
	41jTlVm4WL3HndrMAI80w4xCbA3HkZyp87CTQJ2ZXLydExdl6lG06kK99rQAQNEzECHv2xcQibC
	A==
X-Received: by 2002:a0c:f08b:0:b0:89c:a2ad:33a0 with SMTP id 6a1803df08f44-89ca2ad3b29mr89259386d6.45.1774312275171;
        Mon, 23 Mar 2026 17:31:15 -0700 (PDT)
Received: from ?IPV6:2600:2b00:7880:1d00:a5d2:a745:535f:7b72? ([2600:2b00:7880:1d00:a5d2:a745:535f:7b72])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c85335464sm100134796d6.31.2026.03.23.17.31.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 17:31:14 -0700 (PDT)
Message-ID: <c18f06ac-02e3-4377-b013-3867c31b5895@sladewatkins.com>
Date: Mon, 23 Mar 2026 20:31:13 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/481] 6.1.167-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20260323134525.256603107@linuxfoundation.org>
Content-Language: en-US
From: Slade Watkins <sr@sladewatkins.com>
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rogueport-AntispamServ: glowwhale.rogueportmedia.com
X-Rogueport-AntispamVer: Reporting (SpamAssassin 4.0.2-sladew)
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sladewatkins.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sladewatkins.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org];
	TAGGED_FROM(0.00)[bounces-230035-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[sladewatkins.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sr@sladewatkins.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CA5DE2FFC0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/23/26 09:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.167 release.
> There are 481 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Mar 2026 13:44:33 +0000.
> Anything received after that time might be too late.

6.1.167-rc1 built and run on my x86_64 test system (AMD Ryzen 9 9900X, 
System76 thelio-mira-r4-n3). No errors or regressions.

Tested-by: Slade Watkins <sr@sladewatkins.com>

Cheers,
Slade

