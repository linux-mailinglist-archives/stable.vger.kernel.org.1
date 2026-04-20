Return-Path: <stable+bounces-239967-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8L/iCJli5mmavgEAu9opvQ
	(envelope-from <stable+bounces-239967-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:30:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CE00643148D
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 451D830078B1
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 17:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72953A4524;
	Mon, 20 Apr 2026 17:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcZzJkXI"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABA02DC32E
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 17:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776706197; cv=none; b=YYSMOn9c7P4WycUzDfPH1byxcOwembeXslKvPiQnjcU6YZClX440JHxFULQyxC0qVl8MXA1BhlVEawX6gSetgkmZddv7StYgd6tJThfnFcqV+oStlH2Rjl5+Q/62vxXk7hjVMMmKrchswMAvCy/Qa7QYrqqVT4ilBzqj34F8BGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776706197; c=relaxed/simple;
	bh=+zMHH1OuUVOyg54abTRiUwV+WqcpKPdJm1dryC2JxVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d6DbFG1VoRgf28TQupb3l/eEzzYXErxAwejzwzG2g1M/y4qXfQ1gssxNPZmkAIAOPV9zvzeUhxtPpacB9G3P+DmHxFvBefWvbZbl4Fwtbj99gTeRMlza5PFvxvRjrVdMiVHumbhmZAMyj936Qu2M/uPl6SWWyN00MStKoGsjaUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TcZzJkXI; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8d4f78fc9f6so364214685a.3
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 10:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776706195; x=1777310995; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fO+bBXRTOtxPea508BmdvaXLzqp4fRXR45rPWVIOwn4=;
        b=TcZzJkXI4i5PKTHOWbldRV2p79RNGH0yXvFon2rqncS/c4XNBPYPx1T3LPKx5j9yU4
         Z52tOwGhlWgy6XHHFJvoqgHnEsOdIhakicER7foXa5sHuV2fOho4V9zTSxinIZdDuDPs
         EFGh7onP65TKe2QdUCqBzjxetOOB/oWVuXHY4qMDL+cF4tHYQOfORX/6hwi7s/HT5dyT
         KfBQGT8RbOfFQHlUBGwtL7TfrVHvZcpokiTHR+O2cdHJ4y+ejHD32GhUm2xPi10A7unz
         tSIRTtUGINM1SJAIgA7ovjjs8wZBpYlDgL8xPBH8lI4rXinO/h5N3jnT3rW9hiTBv96P
         lT5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776706195; x=1777310995;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fO+bBXRTOtxPea508BmdvaXLzqp4fRXR45rPWVIOwn4=;
        b=OUTfiu37HDK7cKtv43ExeXwE0gnxPJyutDMk0IlNpbR7Rg5phGUMTxIN0CGBuVhP3F
         NO0CJI8dopM+ZfnAqIa6cDnUmKkBeNy63gCtdA4B6FFKZuzbpr+lPeHvlQfE0A1GwmUr
         w+TCZ7JPMMrCILMcaSXJF9nCiFhJ9OA8iMUFpw4e5oWHqTXCn36uxX/j8tx2keEMA4JI
         qm9ghRuw1XaD6VRrB3W8tA1/Z4GEiwYDjr63uKxUpLPJtvdwg4RWqhfNfbuuP/zUAl40
         6kptiVqrE/jyEql8noDpD5pyzgYHVPHMze/mw4K/t5APjoGaDLsRzcFlJ/o9F1IZQJ9N
         lDfQ==
X-Forwarded-Encrypted: i=1; AFNElJ+r0VfzXVWEU2QenKYUpxkrG7bupt93jYMlaJfoRPDkAjFoCg1CyCmTu+vn+QD0MLQnVPiAwZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YweMMb5YLnNOzKK1PFZi2K8sOwVCRMlFkwC4LKw95/TxBqOyrJi
	xhqCAQWBdTQ2U6n4il36lPTpoGP1v4uDVplrZIRQlcieZa8oIfnicUj7
X-Gm-Gg: AeBDies1JSuF4tSQMBnVfz23iW1Len5/T3WarnA6k+5ujAD53k1YmbUQN4ZeOVedDbL
	V5gAbuZsFTWt/c1qKV7KSQ/RGFgV4Rkf2MWZ6YcZgmDnTzHa1poE3kYuoIUdStYNHopQbs1VjCW
	2DjoHOw0sDTCOJxMEjBPj82HbigL1nudN0U+Lw4wV0LRDTj6NlE2R39ooA9cRYLJ3sH7BkjzdKf
	D6KnsYh9VaAzo9Ox4EqXp0wwFKxXNFd0EpP/s1MBoqL2aytcWGDlkV5NKGqqN3GaHXjyZESbXsY
	LaK2sLKROtKWAdMC4GKUpqL9XI1RL5tea7o9vNUVgnoS7CpRID0mqv1S3WgghEnXng3fLFE8GmU
	PWfk+OAb4HWX2RJTI0wd0ETjbDREgTGQ2ARzUSQgAT/9+HwU9hPUih0OjFSco1ztXGRX9V6oRtl
	aBMIN/urCoFFUG3d/+qJ0NnwwC2P937VWbStlP76lq6G/rSoaohaxTTG9uAJT5
X-Received: by 2002:a05:620a:4623:b0:8cb:62c3:3690 with SMTP id af79cd13be357-8e78f443268mr2041220285a.13.1776706195110;
        Mon, 20 Apr 2026 10:29:55 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d64caf37sm836657085a.11.2026.04.20.10.29.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 10:29:54 -0700 (PDT)
Message-ID: <044e7684-2522-404d-8516-63ebb73046e2@gmail.com>
Date: Mon, 20 Apr 2026 10:29:51 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/198] 6.18.24-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260420153935.605963767@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260420153935.605963767@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-239967-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CE00643148D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/20/26 08:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.24 release.
> There are 198 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 22 Apr 2026 15:38:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.24-rc1.gz
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

