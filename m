Return-Path: <stable+bounces-217196-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKCENAb0lGlzJQIAu9opvQ
	(envelope-from <stable+bounces-217196-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 00:04:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 072B1151AEE
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 00:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AD32B3004C88
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 23:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753932FF148;
	Tue, 17 Feb 2026 23:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGFxrx03"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFA52C158D
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 23:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771369468; cv=none; b=tl/Ov8Zyi+a4obsZcuq9lyvvn2VrIybIsvtRxeEHFJ85qanPICRxMRPwz8dbVvARwmVMqYCH/ojJWw9KJ+Cjnw+VyMPmRdQTzJpzaY3gwVzMuxT7loCupfaKbdqbHhTw+6+u9H0VXAue8gxcthSFSRXX/byZSZ37kv34N3fUJ4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771369468; c=relaxed/simple;
	bh=a2X0Mwt7EactACqp9o7cLtVT5VaeguI6k4gKiX1yZ64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oh9ypZNEsb+mrU5+7nLptJkfXz5FHZv0uieRkHv05LNNZFg/QpU9SVIErwFKco8CpM7rnUR+nmF/k/kxnFGhLso0wD4W6okc3zovWUbKcoYDOXgGH/0ym7yvmYwJMnPJH70ZCGLf60So51DEjZn5DYW+zQYksBPKP5Nlotfk7NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGFxrx03; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8c7199e7f79so600674785a.0
        for <stable@vger.kernel.org>; Tue, 17 Feb 2026 15:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771369465; x=1771974265; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kwwSX812i60Q6VmHMvgcgevCWAvi1urqgBHszEXADxg=;
        b=BGFxrx03gObqGGAPYs3a5kMvgDiRw59G6AXwtPIeCzdtpDO3EhJcBAv0/NN/fTasNn
         tYWXQsM+vGkwlCs4nM+W/HaCO7tIcTtihhdLszZDU8Ng4ovjf67jLaXRm85MRui/iAzt
         wepPtI9Smq4S5yUqg7tNkAcMX9MwulWnJBLjEKkmYjGjX97EaLjGu3jJG2OUoY9Iv0GO
         CN4qVhhr7etVJIKgbCh6AZ778tWv8HQStkcbDmsAqjukiuyNJrPnV+AAc+Z9eMiBHPjJ
         wfwLje/9VG9NsSN4Chm0S7h5E6j+mxEeYpcndy8ANQfLOjBgyrzorxJTmlRzl4gtLoeF
         oKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771369465; x=1771974265;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kwwSX812i60Q6VmHMvgcgevCWAvi1urqgBHszEXADxg=;
        b=Z0IrFPF9wY+g+9pozTpL9eHMhjw8yyHtav0E2iESl5cTMmyEVDvtN+kxrVeQ4jB/4X
         t1nTKolmhkBrqH+fp+mh9O5LLLlOtJX7fi9T8p/2QFPTgKxTugclIHs5dCz40pRELTak
         e57UEehwt8CSh+B6CVMYOQzmpsbIKq7hqe/+cBL7W2eMDCOzdr4MDeTATU8D/5Zu/DI5
         0D/NF1AH5+QrjAUbNj7dfvFzIFmhy81jb56D4gfwP3fAnHr6a7K7mdcDdy/A3Qc41V50
         d8x5fUk8bBRH097mEIPdPruCvrlpBwnZH8AxWH5Gvi99lZcujzaK+Grno4XGNshJ8AcD
         cs2w==
X-Forwarded-Encrypted: i=1; AJvYcCVXLps8X780NhZWJP6jtAfbXamdesI/one/QmYuRVDt2lfDM/Ubrm0vmpcY6L7EsouEszcKsG0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7+gAoxxXmdp7ijpK6AbX0HQZbGDnzAXlG43dulNrj5BIhaiCo
	v2v+1gv7B0yLUdyWWGSr3phpQaz86LABzbh76SjaUVahdypCaP3VeYZJ
X-Gm-Gg: AZuq6aKyPynB8dA+DkfMxaZTeAtlURJBjGA6dfFPVDbqZIC8Do/Er3luv58GvOt97H8
	LsjG1x77CmQxoFJUSWfdiu91Ko5OkVik+dtdPnhFwPTa+95gZO/Gz+ILYUZQyTHxSUaVpcV24az
	Ggy8jRfuTqJkNawlKgjOwHrWm9am6oRLAvTisQqB89kE6wjkSTcvishkVNcwaJG4+GOVQA2B3gF
	MQrdRokTnlTp0JsSyhMyp7V3d162zWa0RM9JJo5AG9UyXtxqo/o8yueYhOqVeRpNra8VXqEAqq9
	5id45qPOPoNgi67CNBce6M9Jx5msRnNaqLVN4g4jIkpzGrohe420lRbA2nsguSZGt80ncYMT2de
	JFqIGQjmWrOWb1vW/fZV7/N7gAu78AoojqU9MOAI5ykpQipdHO31W7d5Sl3Qwzlk7j/xxzWHCyS
	mAgNooY80Cwm3aqOLh7zRQ9DxXD3oVP/INNQeLp6r80/uZ152mOQ==
X-Received: by 2002:a05:620a:46a7:b0:8b8:dd7f:f032 with SMTP id af79cd13be357-8cb4c017d66mr1539387185a.78.1771369465302;
        Tue, 17 Feb 2026 15:04:25 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb4ad01f0fsm1036356385a.39.2026.02.17.15.04.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 15:04:24 -0800 (PST)
Message-ID: <da1fcb21-7ccf-433e-8674-88a35b50f617@gmail.com>
Date: Tue, 17 Feb 2026 15:04:21 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 00/43] 6.18.13-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260217200006.470920131@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260217200006.470920131@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-217196-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Queue-Id: 072B1151AEE
X-Rspamd-Action: no action

On 2/17/26 12:31, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.13 release.
> There are 43 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 19 Feb 2026 19:59:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.13-rc1.gz
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

