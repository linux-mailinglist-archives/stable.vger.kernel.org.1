Return-Path: <stable+bounces-235471-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAdGEQTn12n8UQgAu9opvQ
	(envelope-from <stable+bounces-235471-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 19:51:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BDF3CE504
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 19:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 867C430086FA
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 17:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD02333E37D;
	Thu,  9 Apr 2026 17:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X817lfVJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD853D16E1
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 17:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775757050; cv=none; b=NxoEesB/F77lm2ndUZQjb4fbkugTJOkq0v264hEpVbxPOTQ2v3cU2DSKz6CHIqJpiG5hp2nAMB7tqkrcC0yAIRbkZ+PDuNCCPw3oIbj/j3PFNONedmKTvtsghADwyxxALaao369HUFfLIbmTohSMQnKxTA2+CviX3EdGpdkBKPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775757050; c=relaxed/simple;
	bh=LKbLNnOmt8llHI2UfSoyKRlTfIDs49SXxwFGHpJHCjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q6dGAnlDMecnfCTwV5TFVDZ226FPDWDdZICL0L184Ot+9Sf/a4H2l7OMoz18ejKryg5t4JK3tqGuIv8AakACa52kECFO6ta6+bw5/eN0Dgf73uE7qs5QQSulOlYKQGWZgtk33TheG2gJ2M4J8X0RjWHqUtDnH5uV73jOZhoiqo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X817lfVJ; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-40974bf7781so883966fac.0
        for <stable@vger.kernel.org>; Thu, 09 Apr 2026 10:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1775757048; x=1776361848; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c7jerJW7kd6kLvB6dfldXiQ314FLu+7l1hxvSLIC6rU=;
        b=X817lfVJQy4ciyIAcp9qof5jueNrIK08qDcd4/eHD+Q4ZNcfr0XeeCP16POqbvoxgo
         1rbwD4XFE4L4RX6zCxHWmYFupggAEqCtu2iiIgQMYcyLlZUOPbPRo9kdlBp7SI5Ta/1T
         BNbfWBOuAZDZ7mRrdDidiijgTL69vHoXOsmGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775757048; x=1776361848;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c7jerJW7kd6kLvB6dfldXiQ314FLu+7l1hxvSLIC6rU=;
        b=lYiivAFUvw4v05agoUZZWXMd3TtRiTnopD7ylOXBSL8ns3RDeysyu+XF4ugRgB6teD
         ceyjUidOFDLCpcdYF3W7aXsqXaiwJAdPry0VtozeXz/mj+cbltrlHKwVfwvRLB7MrbKH
         544wPfSIiCIB20Y4FiveVbyNQgG20huyIOWU9YOQez+JNI8f9LofiKfyQlMcJcmlPQRe
         KKqlw1mWBX7RBT10wy1hf4Kz9O302zJVV5c8v7p4gDf1peE8DOJF9dfQ9xrmFME4uEi8
         m0qLNmGTTYU7oHZ2qRqv3sPArdzJoasTJLnedy0gDh4LWwLBpWMQXA9J1kEq7dp0oLKi
         9e1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUSq/Af4gU4AaIYlUZakaCQpTR7korFsJjn/NrdZIW+AxtrIJECvLO9k5KYNkWWFOOcYpJVi4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpwaJRASeTIWMsnZEq3uZlsUA2degSfhaiakwsbiKLf3rk1FNr
	+qkhRAMUj/HJ56eQHL2giODWMQl/DtPhjeRS+XAwC+shuo6ewdIQBNX8L6gjk00bRk4=
X-Gm-Gg: AeBDietxPxI7v6cE6Se9kzJZLP6vnxFn0NaYkKF6r9jAgxYHWlc2Epl+E9bdcGB5E2L
	ThKjwVOIUc3gwzipbvULicq9/1FuTcoZFYw/vfRCqPbwYtK+VxaKmbLUTNzhphzH1RELvY+K3lW
	SHXjuhR6ON42HFAvwtnlVmICgIF9f/+hdj3K42bSl9szvFJDy2EMQgHO2sZ+7NSPuUWztLYZsNh
	tGr/98XYaevBX8Fa+OMWonQwQV0Cooa4QD9BJLBIHAtlpwfz80JSkeQAHDx2AiPNjrf1YxHv1OD
	DQ2juk866nHhRSxnsOWIpDgaxpVuLOJmuVX46W1pn8ID/J9K+/LLT6XEl8C52dQ/7OIIU9kPdo5
	XgNwcR2CLCfQR509VdLeC/BTWSb49tMfm3YXa8OOnU91X2ZEoaGizB62K4a0oyi6QPIgb1UXz2b
	OlW/nxG0IkMH2umKL2TB4OBEQiPE0E0LZ7JJc=
X-Received: by 2002:a05:6808:4a5c:10b0:472:8b95:f500 with SMTP id 5614622812f47-4772a35e6f0mr1549524b6e.6.1775757048081;
        Thu, 09 Apr 2026 10:50:48 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc2657335csm301347a34.5.2026.04.09.10.50.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 10:50:47 -0700 (PDT)
Message-ID: <b4385149-926f-4b4b-a63c-d79a447c2d0f@linuxfoundation.org>
Date: Thu, 9 Apr 2026 11:50:45 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/277] 6.18.22-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260408175933.836769063@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260408175933.836769063@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com,linuxfoundation.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_FROM(0.00)[bounces-235471-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhan@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 99BDF3CE504
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/8/26 11:59, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.22 release.
> There are 277 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 10 Apr 2026 17:58:42 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.22-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
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

