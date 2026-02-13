Return-Path: <stable+bounces-216294-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKEHKQ53j2lERAEAu9opvQ
	(envelope-from <stable+bounces-216294-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 20:10:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB121391B5
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 20:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01762305DA70
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 19:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E2A27FB1C;
	Fri, 13 Feb 2026 19:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3emZgeH"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ECF274B39
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 19:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771009801; cv=none; b=tz9mXL6BOWdpwuZidfQgKNnHLeB7CzoQBXFZTYbsV9+sEP4/PeolzB8yz7FkuOye0mpUywS16ZwOHb0Wc3k/VinNw+AQwRPkRP1EOpl6xpGB8GAhFdPyxqmYlsFJrYKshtel7iPuYkV4YvQkcbqOGF3kGRptFB1j0AYut5MSjTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771009801; c=relaxed/simple;
	bh=YDYkHQ4dFTARQ400eOIS3YTDh5ioZkbo5w4royLGmpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lQ6wNijGRvMKzSLXU1ivDhPD/9fAZlARVcDt6E/bGswcy4IRaAOVCguCL2BDjgTCtbLXzd75Uoyr7VxEreQ9+5txjRo7w9Cf8SBmbXQTZKALx9LQDd/wkuoR+KbhggD7aMW+VDmGbUabAna1TawEEFYcAGfSWV1OaWVDCvTdJG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3emZgeH; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-897002b7576so15345336d6.3
        for <stable@vger.kernel.org>; Fri, 13 Feb 2026 11:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771009800; x=1771614600; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WzfgVNyF9P3RMxwMGa2DwPmdN3uG/tWGvq951CJ+vsU=;
        b=B3emZgeHqhuo7sSrO5OWKho2NzU+m3e0Efx4wqE+3J7/h5E5gWW2lIFmn+GzRX1IPC
         TqwiYulo0byHs5Uo6GF7fTUGlWxr7QpKRJrAfABskpmocI1aFkQ+zVrzBcBiP7PR8G2R
         ssmb4z5ISCav06A+5mFdGazWordS2c3tZYmJ1Xoy6jCNAJ5uauIulNxl7WavxGvyC8lp
         I9e2IYfKB9oTObhZdvS3xJc8Mbxx9WEx39uWIDxtr6Hu7PUdOLFl9uFhHnQIhTdM8aGU
         15ixLB1JMkNAS0mHzNlCUijbHmyiWRjTM1emfyk6ZP5mgetdQuGzzOSqF0NW27MF1bhe
         IjcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771009800; x=1771614600;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WzfgVNyF9P3RMxwMGa2DwPmdN3uG/tWGvq951CJ+vsU=;
        b=qfh5DFnYrUIRzz7haDOWHK7zX+LUPbiqZnVhUN9wZerd3cvPmgHW48xeG7JocTj7E1
         TBir8jHPkmJGKDuH79LKAbb+oCGfeS0DV+VdFcluWh0/hZeBcFabuFq7hvjF8SK3AybZ
         uWd8QgVFgjELOinnZEf768HtpL4nNasSQMKB6ecSQD9VdKT8mqiMJwCcORzqCGdBxvhz
         ua8XzaKeROaXoxHLlR7GcSMPjJ/B1nSUDyepZ14SCkP5AxO81pHqP250xzkaiSPr8AIR
         +fglPGbink/pKHGUwJ1a5mvTYkq6ovWm6mHo3Tml/Eypw3g6HFwS/F2GlwP1FADa4vRk
         Hx7g==
X-Forwarded-Encrypted: i=1; AJvYcCXKvtlLZzozAAYFRsQENPNRuRFMfK+qS10tjeNuzHBp8tCyPZrORNZPWUPboMpvlaHd9ttrNX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRTePnj1yGrNcUNUtnpbw4JqVjtlGodGGBVFTosbeX71Ll3u2Y
	ZhkthD4lpIH77Qw620Hy2rOJThGrQL5dsHIBArfKdsUSuUe9aQL3zRbm
X-Gm-Gg: AZuq6aLBiWMD3jsr7h7qeu83WzoOwnhYTJFzbqycuAIRjY5hPkbYZcKXensYLF8G9nj
	GoQY6+Qg47QlnfDphQPyfcnYEdvL8RFDPGNlrREV+uiHniyuOneQLyGT6QDijqxVc+fbrZDurC1
	c+1ARt7TLJ1AWdR30OSDvjMPxOtLK+XnJ/HnYpFUpXShnLRPqswnt184uzEJCnZkENMxhwRG875
	NpTWn5SLE+6tfiybnQw00JFLbMS+nhpmdp91D13fwsRVUHKeL1ts5ywAbKRqmmq8S/yPJTqOce1
	8YaJ0OYrsICamkYn+GjwjD6Bhj8uTaKXnofHDrkMMkWyHBu4+if97Rnf/2vkdPn8WD4S5QFPrO6
	b4x+Yj/4y4SLFlTGlmOAG6LTgHN6ITiISwIli6ci4LWFxZq7RMJZ6weuYA5lqSLxKBcBcKaWwp/
	0nxlhwAmUxzdp5H8Zi/KgOQCAXKVJKwhjoz7VnY+VmLdk1Tkzxx5T0PIg3DLa0
X-Received: by 2002:a05:6214:300e:b0:894:230d:bf5d with SMTP id 6a1803df08f44-89736234a0fmr39251006d6.40.1771009799647;
        Fri, 13 Feb 2026 11:09:59 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb2b1c8510sm673358085a.26.2026.02.13.11.09.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 11:09:58 -0800 (PST)
Message-ID: <07cc6fd5-0f07-4a80-a1ae-f9fb484981c9@gmail.com>
Date: Fri, 13 Feb 2026 11:09:55 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 00/24] 6.12.72-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260213134704.728003077@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260213134704.728003077@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216294-lists,stable=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[broadcom.com:server fail,sea.lore.kernel.org:server fail];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ffainelli@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0AB121391B5
X-Rspamd-Action: no action

On 2/13/26 05:48, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.72 release.
> There are 24 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 15 Feb 2026 13:46:52 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.72-rc1.gz
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

