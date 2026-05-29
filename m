Return-Path: <stable+bounces-256728-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLirE6vnGWpDzwgAu9opvQ
	(envelope-from <stable+bounces-256728-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 21:23:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE497607CB6
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 21:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4688B3006F31
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 19:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1082423160;
	Fri, 29 May 2026 19:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qbmtq98i"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6AE40C5B0
	for <stable@vger.kernel.org>; Fri, 29 May 2026 19:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780081854; cv=none; b=kFtyiNCwoIPFfn45PmGkezKBMsNq4XzDwHuweGXO4H5+vjX/BU/dvU52A4m3yeCT0nMwJ1zYat047f23Gp7HzuKhX7cbcmnKuURjwGA45o5NP/5n97uljDp56R4W3yut/Ve8Mlo853EhY1Hk2m1pnQG5ToAVv36XRAVpj2/rzwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780081854; c=relaxed/simple;
	bh=bUqLiUwLNRopnD0xzDZ41C0p/bad3TA53AJ1s780NGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QiAjmWBdq83Z/61zQT4lXkt0S8b0D3Hra9a5+D6lV8sXyiziF5O2f7aQPRZWwbi/MS9YqSV/r9TMpMbXHI/AtijLWRNj6HUir563g651II3PVRInXihq/SDHqRniP3jE0FVbcDoW5faX7n8Lw2pe8V/k3CghxL/zhXWlc6KFQVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qbmtq98i; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-304d0ac5e3cso1196631eec.0
        for <stable@vger.kernel.org>; Fri, 29 May 2026 12:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780081852; x=1780686652; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5xPyKg7zaP0pBO+1bpwdD/4KkNA7AX3vtVBNKv+C98Y=;
        b=qbmtq98iIfHG2F7VpwjhQL+LvgW/ccpSb9m3KyUMYb/jRJVaTk+OIFEtHXbYzlD6eJ
         g2n8//T1IBBfq8Ta/xUXEvI+ttsEZn5ExzDDvJLrCwCMEKbBr5zrsT28Z0vgCGcZEp2M
         qIxX/xYsYKXAQALLGmM4E1k5YF3sK8/0ukMd4bGbfuvzG8b9APACCxlciy3mzwkNohHV
         t8aQbLzZwLzUxbrR2FbEyKn5MAqOoe1ph+KnWuCIQiLu3kWTrWO/gY0HBJKIc+N7/bJc
         ku71/75RJsrlL6bM/eAzHWER1Mz2PQAQLLYVjOCt0t2t+yFdWNn0oKnUhnWEbDkfUhrx
         Ztog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780081852; x=1780686652;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5xPyKg7zaP0pBO+1bpwdD/4KkNA7AX3vtVBNKv+C98Y=;
        b=FdQCVnbrL/2h0gBOlyO0jKQdK5ayGe/JlVrAOrGBObUbiJ/XDtas7a0xCrRdud1gft
         haQtbMH7k9exNxfV9aNdbt4867Z1zv++ILJa5cbmaCdDel3Lb9keUhLyHuqmBFdAJyx0
         4SdmHx0wFd4DCTxpHnXwQ1Ln+84zah7eouXdc+KPRbD/a6hgOpsfSoKq0DmnfnsP5o3G
         EZMWb4kYC/EPv/IXg5ugYEPY9g/2bXD8bq77iTrrlfse2w0RgkMt45476rwxgPm4MUeQ
         4J/Dks/+yZBjoRJYSdrQKiTwlwhMgjkdruXrRUZqMH7pDKDr29/YIfn3IZYHkfLzABdb
         jkCQ==
X-Forwarded-Encrypted: i=1; AFNElJ+2aLmKisV17E16wge7AcEeRK6aaklqoqdpfoWL5TzhS7PFWZ9s7gWfJTqxcj3A712dYiQ4CmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF0pldIsaoBlif8LQcOi/6a+9qhL0MIFPW3QhvMDFYLhswtvCm
	t8L7QHQ09GQ/kLvr3Scr+berq0Ul9Og34DT+MkQg/uEIGHFXeaEd1jkS
X-Gm-Gg: Acq92OGi/BtU1RROvhszBH3Gu0ZakFvaySu2YzHIz2n7GSBwQUk7Oki+8u+4Q1lLg7V
	2VIBZwHvzTZbNUaiRCCfCDxUHPvlzjbePT3JbAsyz8E+OYaVUM9x0G9E0KPdqJ7Rz/BX+ti+Xil
	d/se2FKxIFFti9sGSCqlaKo3NGB+rCi9vQrxvA1rW1YP4HptKRRV3jpO9741SmLbvo3H8ex7ZEl
	O+3+rqk5yCBwxb3yT9YLqcwxZzTUgzUwgYjn82owQzWDUr7w2kvxDNhrZC84J0wLb5voBbCIgMP
	RY/r4IyrbtwOvU9VTAY/nqGuXjV6AvS22EPhiA6InHwpYcILRCwcT+M2xa0XyaQELJJhs0PbwAY
	y4ltlXSKNpgTrzKlTxknIV0dD3KcQNJ61GdsdSkuPwy09dRsf+BlyjOkBToyosDxGfijH9Ri5f2
	PK4SHOu/9q8evX9VNQNcSdRvh7DFJR9mxPOOkMk9LcjGDzjxBeKR4RFGSEJSDT
X-Received: by 2002:a05:7301:1293:b0:304:d14b:b706 with SMTP id 5a478bee46e88-304fa751469mr465104eec.27.1780081851952;
        Fri, 29 May 2026 12:10:51 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed53f002sm2208243eec.18.2026.05.29.12.10.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 12:10:50 -0700 (PDT)
Message-ID: <33ef286c-5e24-4dbd-96ba-c95b00c3b2dc@gmail.com>
Date: Fri, 29 May 2026 12:10:48 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/186] 6.6.142-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260528194928.941004471@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260528194928.941004471@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256728-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,broadcom.com:email]
X-Rspamd-Queue-Id: BE497607CB6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/28/26 12:48, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.142 release.
> There are 186 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 30 May 2026 19:48:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.142-rc1.gz
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

