Return-Path: <stable+bounces-214347-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMCEHGShg2kLqQMAu9opvQ
	(envelope-from <stable+bounces-214347-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 20:43:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 798DBEC2DC
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 20:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0B5073008CA0
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 19:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE443148C1;
	Wed,  4 Feb 2026 19:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6reZ3mJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A8C42884D
	for <stable@vger.kernel.org>; Wed,  4 Feb 2026 19:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770234191; cv=none; b=LRn8qoG/D0PHv2jlsFxhsO/Y2Gxd4tQkXi5SzvKPblBEyFPG9dafZjTW48tTF9TG8kfPSFt86tC8UuhfdOhEkjbh/batHno1LZUzz0rBcMl8slcmhM8MJEILbWj76vhK6j+aXbKmMGVv0nhCYpHXUonyBlkwBwI9rGlr4mcinPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770234191; c=relaxed/simple;
	bh=Wc5QFMh9Fxml3vOwG6DK6GyG/751AcaAfY2GfpJknkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j9SK75WBQ/wNfjfEE24u1otRdQdq760wxT8ZvE02OCM7xo8TgwhNFsfP4IoMX3tbcPrqmCdF0RAvpsCmdTrEHH81DuywjOy3hGzfco2RrG50BqTC2K0vf8es+4m7QGi39j6emH49plYScBXEMEiufYNU42H15wYiBZ9Np70BWaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6reZ3mJ; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2b740872a01so196831eec.1
        for <stable@vger.kernel.org>; Wed, 04 Feb 2026 11:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770234191; x=1770838991; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xwCXZ4zC7YICxnWnD4euiuGc+15/UPTLhn9e6UNnqZo=;
        b=O6reZ3mJ6wr5HUznNLiyg8qcFvyxngP1tE8WBbrBt4uzTxXp2FJ6fwQFEQ/N31jsTR
         MzDLD0DMSO8hPNGKaXbp0F3S6GiHx4lmu3gBginZZjdzH9zoyQAshfIt1xlSOB1VhCnT
         SC6oESZnWTFRFTxUh1jejUWWm3nXr5VwoJC+YR4up1b9BaUxlWmOXUMNWCk0jDEGc401
         iy7kY+X2+gWgNHByGpTeFitZ/BmL5k6ID1m8f+pKZG36CpVNEpf+XfCj/j0fK/LqP+b6
         X+lRkY1uhmtoprrmlcFfXydmBCX7BA+YZrSguveoXzS34LWmOoIPI6ec7f1eyuKIMpZn
         PEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770234191; x=1770838991;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xwCXZ4zC7YICxnWnD4euiuGc+15/UPTLhn9e6UNnqZo=;
        b=lRzZ5wwaZjP2WD8JROxrJWeDjZLFXfXaiwT5ZST/zRR2Sw9XLekoo6Te9EwZeqPf7y
         akVpnJll0RgXst+LXRTw7eKUn6bwuHczoao6V3/c8PLc4Im8okiMW79MzraYlN90NdXE
         RxseDmcH1DC3vELnMa8NdAnQtzKp9JdSu80t4OfTjz1cGY3n5XWRpvidp2tGBnCdtLi0
         68f/gUQDQrA0LcpGwO5SK/kzxG5heKZdoRJQh/OHwTLQq2TA53+EEsRSjBEGYz4wcmvc
         xDW7HYveMxQJ3QKyr5tfriRMY6uy88yGD787jnEPpHIRj9C/MjpyH61Irdirg1k0WXS/
         2frg==
X-Forwarded-Encrypted: i=1; AJvYcCVuXJ8H1tQ7f2TeUnOdCtWPwQxLq097pfUE26TIZ0sQM7DnqGUeVIjZ8sObVigskp+8lgz6iOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7MEUsrkapQQvORDJ+t6LKrSRmvQvr4Zi8MudnlzZecg7yEIwU
	v/eeG0g6icnnoCu67WLzIfsji26W0o6uCKaOFOkCmN9/Sl/fTDnrlSeUnwut/w==
X-Gm-Gg: AZuq6aJK2mmFQVGai0goxyXkv7m7WtsL96hkJNsSMpIpL/ZtVwah4SAOXvf0V+tWqdE
	EjCQMJaI5c4h9bWxJoIOs5SegdipbxwkQyid5tEU9UmD/FzxMmGaMShdIWUojHFwuFJ4UlJwpkM
	T6jh6YxWBKuFvqdkxEWimEfg+Qp4EUXWd7pt6/YP1E+F/5Zsg12+AIIxwJrLys2DPS99mKE2yYZ
	cVmpxDVfCbpBS1Edh66IAJpz8nKg37XBrxuQk/oK7BKTPUJzks9s11H46qmsyukX0YznRAzm0BU
	mrd7mOgpYwhcEhI8oBsLwWvb8EZQ9Va9k3H5liNxDOIuNLkDiwhl/YrGas5IhlkvhPfWphfdmg0
	2aAFdiGdEI1TejY1xAS2ebVxRm279FPBY3lrAqrL5RMKYhztvYWH+OHkP+Qio6J2IaNF2UL7f87
	TqAbepq9sZY8QZDOKr7bmI2NOsx7DNa6hCccstyg==
X-Received: by 2002:a05:7300:dc08:b0:2b7:fdb6:ccdf with SMTP id 5a478bee46e88-2b83287dcabmr1936382eec.4.1770234190736;
        Wed, 04 Feb 2026 11:43:10 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b832fc1d50sm1945723eec.27.2026.02.04.11.43.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 11:43:10 -0800 (PST)
Message-ID: <3a0bc80c-4144-4c01-a94a-88c36bd9547b@gmail.com>
Date: Wed, 4 Feb 2026 11:43:08 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/206] 5.15.199-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260204143858.193781818@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260204143858.193781818@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
	TAGGED_FROM(0.00)[bounces-214347-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,denx.de,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 798DBEC2DC
X-Rspamd-Action: no action

On 2/4/26 06:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.199 release.
> There are 206 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 06 Feb 2026 14:38:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.199-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

