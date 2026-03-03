Return-Path: <stable+bounces-222780-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5qW3FzBppmkbPgAAu9opvQ
	(envelope-from <stable+bounces-222780-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 05:53:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9669A1E9129
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 05:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6C8C3059F2F
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 04:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00AE285C8B;
	Tue,  3 Mar 2026 04:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="joyJiSpL"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ABA33D6E1
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 04:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772513578; cv=none; b=XXcRpq0pU/PHqj94XbSjzWKW2svhnoL4lxV4epFzprgvsgfcK6Ia9uDPJZqkE8yAi/GmlYnbnoMhlUEgf/cK+YEaji/pHtg4x10IM2pFe13zQgNvMOdfCuO2Yth+/arSiJnRT4IRiCfE5NdG83IjEE/0mHdYJ17oUSUssfluTxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772513578; c=relaxed/simple;
	bh=76pU4yOTUlCEB4N6xjQe2L4sGaw5m/1Efw2KjH0jUE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gBhlXaSNuhCjtXj6NRZrZZm3mCkozguAxmAzX0lCACfVtZp7GS5btq+iAVz7LP8ztE8zUaMvkNVaqk7w+Vu8GXWQFX8tvKvr+gpkGOrfvyCxBLPS92AYIAu+7sa0+OtNCnPtIF4/boylBXVuKS/6tYmxHnmd9LHZMUrlxgIx2bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=joyJiSpL; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2ba895adfeaso4542724eec.0
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 20:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772513576; x=1773118376; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q6gtj2vVqjmj8s6qx/7E7Q2PARo70h++X7UZ1hY8M7w=;
        b=joyJiSpLzNZLqT0Y5U8OBeVehPUpLqEquBJ4hoO5DrSABhz9yb6kphwSZQWLvhZ/Ro
         s9xQMNLJ+6Yaed7CrLVZIvZ2yYaOkopTCBhGRZCcwV4FQ0ldtFWLNRLLVK201LtYzRxf
         huDNS7zJgTEjEng7IsHXGNnzTBIvRDV0Fh8t5szGhn2gYAWe8tQnRLcUlUP/i70Eh3sp
         1eQ5FiQL7M4jgGCbUDQie2rJwbD4U3vg6d6A4aIdBag9H3ZJ+VYi67MdZQdIL/hXJZfa
         /bsY+OLfaoGM20NwyciUa2cze1O/yFadUemw3W5ukyHzp6p8OCdUGevOPtZYHBQAfEWn
         7fSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772513576; x=1773118376;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q6gtj2vVqjmj8s6qx/7E7Q2PARo70h++X7UZ1hY8M7w=;
        b=nwBnnAkhvhRoDdY6iIOY1Uance3yYlwRGKktJD3WTKupZ4q9YmgU28PbiDed8RjzI+
         /UMNLYStezh1BlCHTIXKLA/U3yxbKB/oEND+A9W2nivIC9udB7R/I2R3uVlub4deZ3di
         biHLHUp4QuD6fmw34ip9vaCAiSkrT8lOcTFLQdMiT+JT327E5OfTsreysLvzx25vm5m1
         2QYW1rjA9yeILIyhQhfQQxnYy4fp4IB7LO+uF8tii2G/RLcGTsWQdzocC/ToVNEBLL9V
         qtr5kjKeIF+5rKA775lKOxHWUH3Ya00Bb+C7lAwrQfW9Amn6aEIjaq+euvW3pcTW8w9k
         kl4w==
X-Forwarded-Encrypted: i=1; AJvYcCWAaeFCZKHM3kKTRieCICqevZ6ytiwAV+aS3auPXLwqWV/2VCm0pZamB3vVzKuLDLYZm/b5RD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjFwAwg+qKlthDLx5agOeL5pPpcZBDF7ECZy7pS3osJaRHUD/4
	pJSMLyodRInrYOARntwX7fsYvvjMkHENsLsvMyW0rwBW3Mofs0kPEGDu
X-Gm-Gg: ATEYQzzWnYkN4gWzLEHXjjarIqBCkEmBKMPoh3mMen6CyC+rMSTj3WXn9LWn0r/DcYc
	RITDe3RRICiDVBHWi8VThHaV9MQt/wIX9q4QsHDEG031zODcLNKhTeTdFf/JT0ef357ezEXYHiN
	42RQSmqGagox9h7bVZyevT9ViV7u14TpDxBXyiH55HXS7xoAAHXnXoQL2FU5h4SOWG9JozhIXkf
	FgwEXw/wXHEkHCPIWNHEIRkKK5pbtMnaX2vP8ZriaFHt2OUYpGWYWYOJrraLRncW7nUvkn+uMP2
	3+NJKz8lwfozKQyZO5X1Y+bq1GMMNs8JFWUnPvmCIIMfL0E/MTYVJEbwEuaNhtE9bdLchtRXUGN
	ihnDKsg4vGQAj/40KcAGabd8yN/QI57fK6kx+RUIK7Z1BLdLDICa+//OSmJo2nhRKlmSmOujSMd
	rO1kHWexgTQ3yX7EDcSOi5db36qpKAZ3zBmHwX0amtlfyE9ZZyIXjyYGPy9eFuB+hA
X-Received: by 2002:a05:7300:6da6:b0:2be:1f58:329c with SMTP id 5a478bee46e88-2be1f584074mr939914eec.11.1772513576371;
        Mon, 02 Mar 2026 20:52:56 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be002ee839sm7755255eec.8.2026.03.02.20.52.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 20:52:55 -0800 (PST)
Message-ID: <5a7d24f1-bb84-4dfe-a979-f7f8fe2ed54c@gmail.com>
Date: Mon, 2 Mar 2026 20:52:55 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/533] 6.1.165-rc2 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, patches@lists.linux.dev,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260302160943.2522184-1-sashal@kernel.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260302160943.2522184-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9669A1E9129
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222780-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,broadcom.com:email]
X-Rspamd-Action: no action



On 3/2/2026 8:09 AM, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 6.1.165 release.
> There are 533 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar  4 04:09:42 PM UTC 2026.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.1.y&id2=v6.1.164
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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


