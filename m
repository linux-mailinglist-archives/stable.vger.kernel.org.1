Return-Path: <stable+bounces-240204-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KJdENaq52kM/AEAu9opvQ
	(envelope-from <stable+bounces-240204-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 18:50:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD4943D951
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 18:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A530305AAB0
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 16:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC30037C918;
	Tue, 21 Apr 2026 16:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d7ugR5Hx"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC1337BE99
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 16:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776789916; cv=none; b=hwxEIZSpuO469d5RWN/ICQisZq6PGztUfcq9oVmJFSqZek79JhEU8vtz3xMZyDXjfUioTQn0i3JXT4K5TAFBCF5X9bd4hVPAV74miw0K7qkIBHv6w3WM6TTEpgpd0cBhRBzNRsHeGGDrl43rieG17GTYlTleHa6ZjJbczonCixA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776789916; c=relaxed/simple;
	bh=Wg9l0RirddfRVz7clv+4y691T0p8Wcflwic/0H0PxH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dl2lzwa5xqaczknONeuQxWVLso3HSDDNckWdi6tE5tIE9sXsj5ow+Zz44Xyk8M7ynYQpsM9o1djGF5AI0lri3nso7paScIDLc7G7pECBQpjTsyXPojtAVm7BZJf43JSZoENHbJVR4YTKVBvYBDbbftWeSsY1rX+8eVgkcKslIkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d7ugR5Hx; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7dbba5076c8so2479272a34.0
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 09:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1776789913; x=1777394713; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jgVOVvPTrj4x2yPeEdE0VusRagUUHTAZD/Iokvor/7A=;
        b=d7ugR5Hx/0S6vsAqtqJJomtRKtRoj7llkSsyOzP5giBVZIaD3UCJexbkI3ICu6Gl0t
         9ZlbDYwwDXoYhYkBlHZ8SK6oJguWpA1fdbqp1Xy5v7Vn7eUapqdLqtOY9Q4OXSs7dgv8
         BGebBreLlazKfWBuXNhuvWtlUkwPiCUHgqWAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776789913; x=1777394713;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jgVOVvPTrj4x2yPeEdE0VusRagUUHTAZD/Iokvor/7A=;
        b=H2/0MKvDUJQ/QpeBxZD7VoiNsSpNaM47twNONKh3odx+RnSjb7ljpbhz3TpcYXOKTd
         /NhHU5h8DAXibkwGYI8TT2CVY/CXbQba2pjag2y4n9AVEsCi73ikZdcvFmPd+URXRksa
         FJ7yT+yAUThLtlFDdUBiwkKLxjhbjJC6xNh2W42hpA3JLllNZCZ7LAYzkmpVj3iTRgTk
         4NdfGN1uYbgHcfj7IOOKJuBQnRq+NdjyLu2BrHTRozpZo/58BktfnyaTLnpV9BFJnwx1
         +u8uN6Cyf2nyis4l+7eBYKpFnChiGa9fb7a643eC2N3w7T9ULbH4F51mQCbsXYgsQeyj
         8kVw==
X-Forwarded-Encrypted: i=1; AFNElJ8W42L4tcKxiQRiZhiqBmVL+gVmGQszBEB5OJECM2xqB4/MCFs/jjAfASMONlta7vxmEAouuJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuhRI9jr8GkZy3cbyUIe5WPQsYfZ+l864LItuhyIIxf1BhUQR1
	63fe3qXugqwVEUh8sKj32+oB1+Jb8S+Op3yiQH//QYJ7AzZPLle5PYk2Fb8DnQzSVWc2h9K6u0U
	fZWoJwpc=
X-Gm-Gg: AeBDieuhvRL0gCXw6ObF5NIIyP5dXZ4b9o1qnt9eXUPg3XLm3/uHU46H32H+NviQv5z
	pNjZzyk+ojD8RahkOBeiB+k4XippI9bcxph+66VFoJzxkvdU84zTig3XsJhTl4EApHL0LCn7fVR
	F2ogYuS2ezFirePad7m9fBtfOKzVpJNKNvMPJQJbqCYSZnIgj+gc3Xdsvos77D/T7DNA++S/XlZ
	diuIeB3YKY0hoE8MuEGOwK8pJmpweXyKxlEG97qUCE3an4/exlq53Z3j4tIYSvfZI3RPNhC2G3A
	oeoQY2OP819lNB5H/FzFy47sBg24QJW3N+JCwC4JeV7MKO2PtBJyfbsHEi+5NI+ubn5QI56GRx/
	kenRGmm//hLgBckURMHR54yAuLTPrisWoQsWTTHVj4bDMcIyHAbdhzU/qdGZdKNK0ddGy+19sCW
	VtwurK8SRIBRfvXP/hNnSdTp3pWjFvkZDcW/yXaEuAmg==
X-Received: by 2002:a05:6830:6583:b0:7dc:dd58:50c7 with SMTP id 46e09a7af769-7dcdd585530mr1206651a34.18.1776789912610;
        Tue, 21 Apr 2026 09:45:12 -0700 (PDT)
Received: from [192.168.1.14] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcc712b4easm4849766a34.23.2026.04.21.09.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 09:45:11 -0700 (PDT)
Message-ID: <b4743129-adb4-4c40-b1f1-69a833ce46ab@linuxfoundation.org>
Date: Tue, 21 Apr 2026 10:45:09 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.0 00/76] 7.0.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260420153910.810034134@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260420153910.810034134@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-240204-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhan@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: ABD4943D951
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/20/26 09:41, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.0.1 release.
> There are 76 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 22 Apr 2026 15:38:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.0.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.0.y
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

