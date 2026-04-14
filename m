Return-Path: <stable+bounces-237943-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMfHBup83mm/EwAAu9opvQ
	(envelope-from <stable+bounces-237943-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 19:44:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF353FD363
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 19:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4E9FA3020BAD
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 17:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE61B3F0A88;
	Tue, 14 Apr 2026 17:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bo7Dhxyn"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE943DD524
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 17:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776188587; cv=none; b=mi7XgHFM7ptMEfkbW3+bJqh8YK33cDgHaLWiyA5BU8Vn8sXaT2uRhMyQJD9ddUMsS4YwXygLDcGlc/0CsoB5YXSrVgPkdPs0y68R8F2sgD6QkJg1YOV+Y96qlvP7uwGzTsW4/two7E5N9RozoPwcUZ3e9dzhrjwqUufELyXCHQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776188587; c=relaxed/simple;
	bh=q80Y8P4sULfv+4YLiooFnrEYwgToO4LQ4u9beuChQtQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YyxplhkO7SFh068AhiuJBmMwFZePPHoXDDo1aRRg0cgWTS72uJ7lEOClN7Tb9f1WnXwx3gZWsMT+/oT4OftpGvUj79ySHifrs34FwcDBMEZtnruTLQEQwtJdrXXj1CnwFM/VcSTrOoqy0E3QnUnrMy+Gz8v+SOPG1rky2h5HnzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bo7Dhxyn; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-4138136f02eso3643103fac.2
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 10:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1776188585; x=1776793385; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HJSheWUUr4b3jsPKJtA1yhlnsQpQ94Oy3AOCaPKGFxE=;
        b=Bo7DhxyncP/gUKzL7QeI8PLMXB5DwZ01uTGWWbShWT9171TM8yrD20WmVIGuC5/t1s
         VD8qYwNQH/3DCxnxV+KUzpoHxiRuUd/t6rEz76xTa9K1l4ZWbOffFxEWlzxwk9TZ/2ed
         SJ72mRxtVYyWNbsBzDL75mVNlObZHU4gFSOpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776188585; x=1776793385;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HJSheWUUr4b3jsPKJtA1yhlnsQpQ94Oy3AOCaPKGFxE=;
        b=Dmj8VunimOsNXEEWPfbnxa7baHjWfTo5jIPRNQGDge8CPs7WYY+5aP/+0pS6cuXyb2
         Im1ZvTUnl8moNb+JHLL+A+HIW5q9qUQ6ltVy82k6T3vQENHf3A0WyCZAPQwEjK2HsVel
         rl/i5GgNKB2s2iZVPqjNDek+vKYaHsRWv1Ok0fzg+4DWj7P1neVbP26rPfela2VulP9O
         9BCcnsbRiDu6XAbOnZ85QDGbKOhc+QpUpcGzpQZcSUrs+Z2JH7VBqXoCPlIFdkQDKHMB
         6vL/HDmEwVkn2PYlIQfjPZFO2l3cLTVkGchagxanyQQVETH5l/JUQ1jcKOkaZAcPTAdN
         Hnvw==
X-Forwarded-Encrypted: i=1; AFNElJ+1XFL5hAOl4EvBGm7HxqUwdxLINTGgcfqWhVBtC60b3AUWnwj3MzYTwoF6/uwya58IMwWa/eI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8AM4XCkGy2KfjjVFlqshmHlFCquhSI0T7ZlZ/b5a15vELFzUE
	eLv9+BAcMiwnOnkhCyrpcAiyZWr3Pbnc6hiERvCfziT8voFNte+7wSYZmExZBVbLuiM=
X-Gm-Gg: AeBDietxynrJb2kPLbusDXV8dZRMHZRh0O6SSSZSMw5fYsv9xFC/sM0zaS72QUczKsq
	axa8SPMvfWtU6AHFpqjmtjnPA9Jyq1+XKtCVG8/b0k13tweHHEoIT8VEDs2XMNiBX8zkmMg5gDA
	V+Ps5vH9Lvm/X60J5O46FUNAZYSDnAB9ycqAIsL7JdwfSr0ZXVFJSEAjM/i/UjZin7CiANSDsdd
	7ZYl5XTgiEsUmYS56wqFvP+TvsB07kEcFGFCxqErYSkOXDjSCiadc6/0SoHH51NFH0CSucVL5hd
	17o5+LxSgJPaKovEj7caEZ5f/5A0NBFeXCjxFZbah7Z6G1/PjrDth3y0WPY0W/HVNh2lDQSVu1g
	iA2fsc4YNNWUa9m5TX1m2dlBm921Oq6bXlvmHSXU2fcaNV+OMRxCpgcWUvq5UCjWRH565uvIy7w
	v/Y02nhoPh+wAHK7chtDlTMz5sEp7cGnY8HHD5cTuY2Q==
X-Received: by 2002:a05:6870:b621:b0:423:e06:745e with SMTP id 586e51a60fabf-423e1128505mr9110158fac.34.1776188585315;
        Tue, 14 Apr 2026 10:43:05 -0700 (PDT)
Received: from [192.168.1.14] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-423dcf9726fsm12270998fac.0.2026.04.14.10.43.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 10:43:04 -0700 (PDT)
Message-ID: <b66bcd0a-2fbc-4a0f-9e30-96e819839bcc@linuxfoundation.org>
Date: Tue, 14 Apr 2026 11:43:03 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 00/70] 6.12.82-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260413155728.181580293@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260413155728.181580293@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-237943-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhan@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 1EF353FD363
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/13/26 09:59, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.82 release.
> There are 70 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 15 Apr 2026 15:57:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.82-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

