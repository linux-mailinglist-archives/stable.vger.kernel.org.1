Return-Path: <stable+bounces-215592-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFMxNXufimniMQAAu9opvQ
	(envelope-from <stable+bounces-215592-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 04:01:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50471116A14
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 04:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA5723034335
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 03:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F79E2D879B;
	Tue, 10 Feb 2026 03:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAnPBGCZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263AA78C9C
	for <stable@vger.kernel.org>; Tue, 10 Feb 2026 03:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770692450; cv=none; b=XTdQKz1AWoqsWOEBi43X76KOY3KeW3F+hGGOxIakmVsbGVJqPamDFIlAFuCHZxl4Bek3D+MMpQtG2FTjTXZGYIHbmHjYysIZmyibaXG/+eWxoPbt1wiKkZ24qvzRr/Pcb4cA9QrrdZJrZLS+danTqLLO3vmeRDdPZKdFhlBFV7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770692450; c=relaxed/simple;
	bh=gHhQgf9PyAtpcPBbpopJtodT2yapy0G+zhoW5CJKnq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gvzZ3rRaqCJ9yaE6zP9dku4qL3TBF4z+L9tBJxMX96Bya4akWbDAcEWC0h2tUxTKVt9xRM6C+ty7cWQh59hq0c9PsKUOcGOW8YPSxRt3S4DajRnFOGTKCLQkrA2T6yUKmWUaZTHEXecxYFfN1vFxhIebphu5TBydefFEWevvtfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZAnPBGCZ; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-124a1b4dd40so3790502c88.0
        for <stable@vger.kernel.org>; Mon, 09 Feb 2026 19:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770692447; x=1771297247; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uf3I/gqfE/c8t0SfsmwjhiktVe2dpIYO6SEtzAKK9p4=;
        b=ZAnPBGCZC/BitLO5CHbTGQXsCwA86gjbITeK+2oT4UJ2q6WIexG5rmSMONZ3/8ZLBQ
         zHjghB0nXBQiLJtyW8hvSArjMu2CN/2WGqOqkFJ5L2lq5LhbbRTVcMYGym/lLHxdR9sP
         6A0+6C5t8LlI6oRKA5xmj0Xx5ZVc83S2j6beJUM7TLSgtgEPCvS9XzkAHp0Plxu3bMRA
         uz22Zvj7QCiMAmQDbT8RygZ41lHisK0UxBjCU8eBY2r4R4IpiYCfXWk4lAk2JktszNRQ
         FAtS4s6nCVjkQQHJJoA+V2wRq+w3KbM5qkTdEfE1lvv0CpGANWfmRBzzQXOvW4mkmYUB
         RC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770692447; x=1771297247;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uf3I/gqfE/c8t0SfsmwjhiktVe2dpIYO6SEtzAKK9p4=;
        b=EUtWOF4xN5/SAXuhfPPLpz5XYU4eSFcTN+9HKh2O9z8kzQb2GPSqMZTN9sJTovbMXx
         5YkDLsxHH5P0R7hqifGL0pJXaJld46Wd3QdISzXrfsBL6FP04xHD9U5oFRyq9xZDZafY
         rJNeSTb3GdwRfGnb/1ToWJsSS+ih4nXRl9oO689iDFCVVWgKgsMxXnbqyOBSLer93LS8
         ueJKHXD6iXLbPcUttZH7Ga5VDrH8gOaBD2QNL9qVTlB0iaN5GOzFLmFzp4KUNkwIPY81
         SU/HcNxht5kY41CJdgI67qymHJeov7vw7KXD38hf069ctW0QrCxqX/1H2uB5xMBYiPkL
         +ZVw==
X-Forwarded-Encrypted: i=1; AJvYcCV3e5nAImr9D+8rJIPdh5BAQ0Go6IYZzaSEZyErRWiljC+dWkeuiHjwvOmbosiwEY4jKeLVBZs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+HCN9mj7bBMHU+mxYgH4+rMLCWGBlRTU6aonJEzRE/UKmM3nD
	yicrP0ZlrPgNuJQ9PNTG5PpPLwE1a2gycx2x/wdcGggCKEoYf/Sb+JoM
X-Gm-Gg: AZuq6aI2n3kLmTJGqyCrBCxQJztmc6O+UeAwv30A/AH4a0yaGI91ZIJV2cU/asXHKKd
	4gu49cMievXedPP6J4D/tz2ieV3552qbLIHFupNfBvPKz3ZE0JHQmhMc7gnDGSw1IJedQmYfuMr
	BSuK8kyIthwULr4kzsobSbJQB3uoj6kCgTSZb1lhehATw0pZ0uJ8HMGF8x7zy6nSu/BifHYMBEo
	m5b3E8UPA5dJnUmn1GQ61nwmSzu/8sJfqQGxokt8WnUvsNZ3CeETXVXvMiN7qC+Q2dcOFVkVT6A
	QqsZQjfgxKWwsdLUbmqB2HVm3FAK8Ph4ngXrSZggwJkXaLX9Y596WxviH15CF2Yv2K3HkN/5G7H
	qsQCn6zT/7ha0MfOo2bJOtJZ9BHtJe3qowXYNf/FRe/shcDSUkL07mPmKtTSIYycoY5dSLsAssq
	UxAkbT+doH2Vr/nbH70fVupSGveKLstzAiyI5oTMDlrpKH1/JlGndv/SHRmAuNhgSezimpbP/tf
	PU=
X-Received: by 2002:a05:7300:fd84:b0:2b8:2946:72c5 with SMTP id 5a478bee46e88-2ba8a8ba4e2mr359759eec.39.1770692446899;
        Mon, 09 Feb 2026 19:00:46 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba6baef3aasm4607570eec.25.2026.02.09.19.00.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 19:00:46 -0800 (PST)
Message-ID: <8a99eafb-0382-4fb6-ab4b-e780fe5ff283@gmail.com>
Date: Mon, 9 Feb 2026 19:00:45 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/113] 6.12.70-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260209142310.204833231@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260209142310.204833231@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-215592-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ffainelli@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 50471116A14
X-Rspamd-Action: no action



On 2/9/2026 6:22 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.70 release.
> There are 113 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 11 Feb 2026 14:22:44 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.70-rc1.gz
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


