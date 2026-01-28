Return-Path: <stable+bounces-212670-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HmbHxVvemlI6QEAu9opvQ
	(envelope-from <stable+bounces-212670-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 21:18:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0760A86C6
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 21:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2CB0A3007A76
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 20:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF46328634;
	Wed, 28 Jan 2026 20:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6piQs0B"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB112291C3F
	for <stable@vger.kernel.org>; Wed, 28 Jan 2026 20:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769631504; cv=none; b=MlcWFU9WoEIY9CWtJNqD/vvEMBAWYqs6tb8Pku7H/bdqAj9m4bRU1ujvpl7CLHnFATWCynJG0/Riy85rsYn/vYHgthI696pwkFSUCu543+Wh66Vi4e3IgjWzSBwG26h+nn7Bg4uNYP5gqPFllpY7UQJwaGHom3OmlIVnQT201lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769631504; c=relaxed/simple;
	bh=9mph6xTtQkmaNeghWSKq7NNljHdk57mypRBuyUulH3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=scLp7jtpcwHYYNMo1C0xm+/ULQzRwlEigTOoPm+YgtZYXr74hBRMxxO4S9ce/4V8iCNHTrxJ36OWSMxQyWZ5jnT7cQgST00Q7kGH0s9WbQhcd/q37f3xTmEAyDbkON+s1YL6iu0tJTF0aCnjL/HELNVayt+e/RcyhDs8JMJfpz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6piQs0B; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-124a1b4dd40so510152c88.0
        for <stable@vger.kernel.org>; Wed, 28 Jan 2026 12:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769631502; x=1770236302; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jYqawXnHzJ4c9BVq3aW9QguYoXUPSj/Zq7c8p0HJoeM=;
        b=F6piQs0BUrTYUX1P+tBCEePTc50gDwWmfFZDCDE92kgyeWTMH7m+PLvGt1/H9TfZ4v
         leylwaTJfgtBv8N5g2qbSy7rPU44JlKPJSl7ZToqTG0//+Z6rKt0ENPPVRNV87slES8Q
         tCe/mUQWWdixH3/5AGTwfSRgnxLOKOl432k8aW5xTNFpds/n62brlOj3zZaU7vWX2T/j
         pfaC04GynKSm60nWkI2RkHQCb0USVk3+1Sl+6qJrI7CtPt0HI94rEFa8v+B74D6hQuS/
         hM4ft8ZFeJqx05/ywJIr/ZMc4FWNkGxxGqQQj8vABeHVQeiXZa7XnVGhczgmESRFtcUM
         XMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769631502; x=1770236302;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jYqawXnHzJ4c9BVq3aW9QguYoXUPSj/Zq7c8p0HJoeM=;
        b=oiNSfSviRmpcELkSMUvN/7mnVOVLHzYrts3wylImdJdw9kKeC3/jY+BzeUCR5dAAb0
         xuSCyaOj4hMJCNmJn1L18+Iq/N/L/fqJ0ftKUt1/3n3k8Q09gdwkVaG5Sj42IEvQH+tv
         oFV3Pp96EPdIcIxQdCensuhkZdkw3ldeIj8dFqOBt+6q6+EcjERcA2V+Nmw7ZnKmwX47
         n9lMzMOUVmCLoZIvEnTtcf39YAVdDXH+VXNgIa9J8mh5xuyICYTt15/bj9tor5cuMoOW
         6o9OKqtb4Iux3Fh/XoyWNZICXBtYrp0QDs1ROS2iMYsI79a+ZzS76J2f566PxMn8VD6F
         aNvA==
X-Forwarded-Encrypted: i=1; AJvYcCVr+kLxUMlHEoyywDLwomWPxp3IhXLkz/I5yCJHSOnxC7/jy6ESbKrOrxs7gxUPOxVJjnIpvdk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9zNEBmRTT+G8ITDd6YBl/lskjXe7Bilm0lzdOBSXcIuMikaBm
	0rbthDG6hfQ42oUrIFZJYOlxcBDPuXBXTHNAlUzl3mQkRrNCj/bfnvWl2uXaUg==
X-Gm-Gg: AZuq6aKMe4o/pvNlvDjcvPamWuel2IHVDxIni4dYaHorESR8N4x4jGASCg1Nmdpy2NI
	NcfTgiDpIxqqG4xD077BHfpElwBnf5VDjCnBzJ3mL0N+5bXkZir1XThm12ZV8HXfIYXkCAUIO6M
	yln/xXNkwdA76HWSSX2Jb53uCtCzNVHLYEIvNIZofrQPGbhiqUtVz8JeYSfewi9l9/RW9qEHyEh
	tp1g34LRstJ0eklu80VvXrX+WLkE7mUapYLXCaePX/YvXk1tvS1pCQXFzlVbBOgXTB8gRkYp4a/
	efMhpVJe4cCQKDVRXchgwECWxQaN8Ksd2JkjlvZVTUk/OiF8f6nlQApi55gxLf2ePjwOdl9pdQZ
	pzcmnO9bNNbbARr1FtREfmGTlgcSu2d/EUEjILPt+vLnGNnynVuw3aP5wj40IfaD2uF+wWgO5UB
	fRLJmUnyAdR5EvwPCK+zCCglfT6OX61Yk5FoT/EA==
X-Received: by 2002:a05:7300:6ca1:b0:2b7:1d54:87e5 with SMTP id 5a478bee46e88-2b78d90c1camr3872742eec.13.1769631501760;
        Wed, 28 Jan 2026 12:18:21 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1add664sm4200634eec.26.2026.01.28.12.18.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 12:18:21 -0800 (PST)
Message-ID: <aca8894a-518e-4b90-ae92-cf3a24f52ce7@gmail.com>
Date: Wed, 28 Jan 2026 12:18:19 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/227] 6.18.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260128145344.331957407@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260128145344.331957407@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-212670-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: A0760A86C6
X-Rspamd-Action: no action

On 1/28/26 07:20, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.8 release.
> There are 227 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 30 Jan 2026 14:53:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.8-rc1.gz
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

