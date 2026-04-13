Return-Path: <stable+bounces-237645-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFa2Av1E3WkJbwkAu9opvQ
	(envelope-from <stable+bounces-237645-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 21:33:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1E23F2C88
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 21:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7CE6F30364C4
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A9A3624C4;
	Mon, 13 Apr 2026 19:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9At+txp"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54A52E8DFC
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 19:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776108788; cv=none; b=daGHpJGgcMP7xTbxpqHAvRQJ1PHR4IFrm5Xb33z6eoGCnDwUPBuujXNiuU9snWj7PO166efMgxSiKmZu0F8hSrzk5YwdS1n226PKXWBZBDttVbsvPg00GKkgaH/MlNgk6EJVirWzkWeW2Hrqni2ds5FF2OFlh46Ib/lGo4tLL+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776108788; c=relaxed/simple;
	bh=dw6/S+pybKNs6YM+wHbLiB5CP9qlU7fUUzKnUQM/cak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lljk7O5+ShUfcoZXEejNnBcemK6/pZbDbKH40/L2MXsdhGLYew196jg7l4YRWNHip9C8DCAYQoNdnoiM0NwuvVsSHUywAyQnfOGSvNdpY3VPqSOuBEU18MLwyGYlMYqBnk5oSrPqHGxAzuNCdaaUa8UUJdQoeBVNpGFsWPaEETk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9At+txp; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2d8ffdc31d0so2748918eec.0
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 12:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776108786; x=1776713586; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pB1WC5VZ3UmOcbYYu69pLbuIrjUmXkdAsvSHYdPWbyo=;
        b=a9At+txpfxmy0uqPSE01qHkywM7gG7ugCqQZp98LJg5aN6TgSAomEbNP1+6KS7ZOKV
         iAPQuxDWeV8+tj3vGogpmtuK446VOwsWTIc6eY/Y4MlwC9QOrh3TN5XgF0IZ/iyX8xcx
         LBqG7TAPy0jS9lysFXkb2/cNip7ADJeYs/WhIUE9btWOJ7C3wNx28LHFoUdAtYzfSfGZ
         8/EhUfbmmFZ3ZFeKMr4WQ3dgg9d+TafYWH0W9p3ABMYgGiQVQinQkYE6UI1gSSyhupUS
         L7gA0TlM/rgmfdtZ+5a2OkrvTWw3oVwIj+fa3rT2IONDbms6ekM2YgtgdThhCkX87AAs
         GOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776108786; x=1776713586;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pB1WC5VZ3UmOcbYYu69pLbuIrjUmXkdAsvSHYdPWbyo=;
        b=gfHZ/PBul0gkOcOiuWOHhCIYsaTthtbkcsi+lnnaXyadJ8Iiwtwvca+hOTmdXWlmma
         b8HFSYLRXVAG1ev3VUweRnl0UBN6Irzx0cztOdHjGnAtksngwc+KtQDqjwWBDHmloAX7
         996YfUIrCLf7iZJhzleCHw6WhzfwuB1NgOiZU3nyKbOYEGcOgsVbo+kMpuhJ5VURzBx1
         iaw2Wi3yCiW85IIYmS7EnQ0e9lz55Zdnf0IFLkFqAFsma4uddgF9afRQSo6csL48pSmC
         WKJYSb+1fV1OiSTkZDQY7QzaUjJc8Y5/6WDm7ZzT1DvuP1rFFK1RHNRCC8Ck4qv4vP0z
         DHQA==
X-Forwarded-Encrypted: i=1; AFNElJ/Nm/Iy8RBrPbZtazGwi69EUebok5bZZWO0R0RpESrYXCOm4kKj5Wd6LbT8LSbcMCm5hpIo4MY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya/jlB1ZCddshTxX/CXmg5B6eEHK0AY43fxcJeTtj9Wg2fAs1+
	YKzxeuhbIsi+/R08VngJJFiarucrFdJVPttE+F0ClGgmgeYs9VBB1d2J
X-Gm-Gg: AeBDieuIldWmQIe7tRIX785AFQgHe2YZ3U0lwkO+Lsk40TuzzcSxgJKv011XB2ATS6f
	pEHe79zc4sfH8xgyxmRQMzCEDiGBivcGPTUL8+mSq9RddEUFSuy/WNT+guXs/0gGrqo4DB2g8HX
	65Sw6TeTxaxjcBpP79+G2C3zGjQ8htX8pWMrNpbHIs7UlTeqTvpJJT3KGQo3mcQdwzFmXCzaWIi
	HoHB90aFK5sz7QxHnHfmhwUgcHQRIHDPuvX12YJkoZgXEJIVNoPSnDRVpaMyIwCmjtxiZpyU6BG
	njScaRrehoq9TEZxw11cNot1tPQjqzRBeDAKr7DlKOdx/YLqz/HoFQlJKeWQKbLe5B6Ji1SWNmO
	/fW15kERGhs9egrUaR6odLkhDFUEMgZjnMHtJ2JMIAdOXHlNVuaHmyKGspckVEL/i2mmpzIqvL0
	HJ8orct9FySMu57uK2JS84RGrobU+F7XBxmVXI+CLxp3WLQ8zbiQ==
X-Received: by 2002:a05:7301:4586:b0:2c5:220c:5673 with SMTP id 5a478bee46e88-2d586380bf9mr7664988eec.5.1776108786075;
        Mon, 13 Apr 2026 12:33:06 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d561cd2c09sm20692000eec.18.2026.04.13.12.33.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 12:33:05 -0700 (PDT)
Message-ID: <711b65c4-d030-4ec4-8248-99b8b979ad3e@gmail.com>
Date: Mon, 13 Apr 2026 12:33:03 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 00/83] 6.18.23-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260413155731.019638460@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260413155731.019638460@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237645-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Queue-Id: 9C1E23F2C88
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/13/26 08:59, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.23 release.
> There are 83 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 15 Apr 2026 15:57:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.23-rc1.gz
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

