Return-Path: <stable+bounces-230011-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHiwKbKnwWlwUQQAu9opvQ
	(envelope-from <stable+bounces-230011-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 21:50:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 143EC2FD722
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 21:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32EDD3014C15
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 20:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4091B86C7;
	Mon, 23 Mar 2026 20:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NT+OTdwE"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50B53E51E0
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 20:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774298989; cv=none; b=MObrRXN1us2jtrabdc4KvvGXmVbUOVQep6x/uMBNc2Ahcah2CTg/sEOWYxcs8Zfm6xWgPLwAmGGm9L6vujZYikOq9x2hdJmikb/Z7lpI1T7J+3aDFyTPqV0yS/E7BwGNPaUAhiy25Sj64MGTov4uSocADGQkdFfXHIay80OGXns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774298989; c=relaxed/simple;
	bh=auYP9MYJSyjhBF1N6WFP+akNUhkZr9dHIIxbAvkDctM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FF7tNr7LcdPaf/kQpA4Peg6eF9j4ayGR1WRnlRRk3XSrLrABAb8HbVIHuLjfI11CKZWy++EFFmMdf5mEhYEsU+DsE0YazSzIj81+/3h8YwCN8lCDxWk9Q45y18HwykT6zu3Un3DBMcsbnptkfZ3GHi+vxl9fFsbugm5lOQkDWI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NT+OTdwE; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12732165d1eso956355c88.1
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 13:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774298985; x=1774903785; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i3HLWnZfbLleA1cQWw+AwRBY910esrohV/DArv1HLfU=;
        b=NT+OTdwEnJnXW8hzx0x88cNx0mguiR818x+LlTKeJ/Y2N3f5qa7KOybv3IgQSiPuDZ
         Xe9tL05MCC6blu8avomA0Eon1iI48dtkkl3B4hc6cY5OUbSs1RcXdHn1/jB6JvrNOvdc
         +ZD7X1pMIgzSa49NCRwWRpexozHoQL58osqvMEyALOYRXfKKfByqeY4WiDbSAIyzdS17
         AwSMwxeyX0TIwXIQrOJjYGk9jt3JZ/DJ3oaoAIO5G912bjSAMMPaFFr4J5q2WHrLfIws
         XtZLhaR8vrklJ4isPLTwcNLf+3un6l41ZS18X3AvAhLlBU/1qGP3BJsnDLgxILNQa8Zo
         6cnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774298985; x=1774903785;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i3HLWnZfbLleA1cQWw+AwRBY910esrohV/DArv1HLfU=;
        b=EPHpbFoNOspAFSP0Tiq/VgnZeg9KIIChgVm/QxZ/LZwfKeNsF7fpXKuYknzvyHcLY3
         1Yq4UmYqS8haLHG9zwdzA3btysezhM9Ci1oIrr2ABT9OQl6wKsIPSW2QDPjbwUGMUVXI
         doOhg+acvAIKZmmflQOXo2d/i8hYSVQNenip7URM/78Yeyne5WmnGlnfcAfpGe3AvOXg
         xmhHtMKHiy5PpLnuKGoEYXtze5qgXjxuqHFlzcE/V/9eOTuyx06zHq1LldKA3iHtkj/S
         PrGkLZ8wR6LfRybPCB0BEDusji7wEMmCIz0U9K74CrFmAMdZ3jwDWeLFKWUUQOYEdJox
         ZvNw==
X-Forwarded-Encrypted: i=1; AJvYcCV4IlcC/1LABuLq1ZFcu2ZcjEFl73p6vuZ289bYGsRn5yAGZuF00nrjTrmpEBNtgBLQA9ctw2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YywddHWjTCGG7R8k9C1SwPlDWpLljWQGxN2drY+hBnuGNb2W0CF
	8xaV1bj7U/vDTJ6SoHtKkTjil1W5fD58POgjEqQhjD18eHViBtnJYsov
X-Gm-Gg: ATEYQzzZ9i8YODNNuV3ByuDKeszjZQM9y80tp8+Yb3OkqE+k0mW1equVcQ7VQCzqSfn
	2sq7AZj2uwBfj7JrHjK5x5YdVsfdEk1ln9jT1XCT24dlLFoaj5oPCIF840yGszC/E79Cfs6Z2eh
	BmjXmCL3c+7y5dFhflUWKrgV2aL4XxVfgXPgUl7OM4aXKSNIILaoUsyc9U3g0u5vk2MONHeC+9L
	ueMdvkWastMYi5soJbDxTAPLPbMmV9B7wffjOHeX5xFiMPr6azVeQB+UHdj+0yzlpkv3YtfwxlL
	HbIwzGNKDXph5ud86o5/I6naOCv+W+UEO3pniaimamcNrTQXRngarnelYDLYfL9PoWAmdy7bP8+
	+hVQL70/25Nipo7VHTzM8WfscwOFm+XKcEaPOT8HR6m7BNlJfmXODfS4sUYCdr3E+28eEqVZx9s
	e3kVv/6wkXiyQTTxKKTO4ZX26YwgMifT/hcyluDaLDOmjBmgEi9g==
X-Received: by 2002:a05:7022:ec9:b0:119:e56b:98a0 with SMTP id a92af1059eb24-12a7263dd7fmr6366754c88.7.1774298984563;
        Mon, 23 Mar 2026 13:49:44 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12a733fe80esm12185190c88.7.2026.03.23.13.49.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 13:49:43 -0700 (PDT)
Message-ID: <e3907e0e-16e7-417f-a1fb-50f7fc87e610@gmail.com>
Date: Mon, 23 Mar 2026 13:49:41 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/212] 6.18.20-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260323134503.770111826@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260323134503.770111826@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-230011-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 143EC2FD722
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/23/26 06:43, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.20 release.
> There are 212 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Mar 2026 13:44:33 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.20-rc1.gz
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

