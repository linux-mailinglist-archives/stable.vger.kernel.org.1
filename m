Return-Path: <stable+bounces-232583-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ONKJUNBzGm+RgYAu9opvQ
	(envelope-from <stable+bounces-232583-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 23:48:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1B93722B4
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 23:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 237AC3031232
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 21:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91CA4657C6;
	Tue, 31 Mar 2026 21:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEocHLwH"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3704611F9
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 21:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774993694; cv=none; b=dpV965zcu1SdoAhyWesDWWkrcn/U/dpUn3fYgD3vPsIP8+VN8vfavnTHSK8QYd/K177zis9DVfx2D1yzJukX3dEqWi1ro/QVyrUiqqkjB3ABECmFXeWM2QVbEmAQ9US3AlrJJGf9c4v8AJnIzpdZgR7jAT1zMhEaorgn8M4dmBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774993694; c=relaxed/simple;
	bh=ZsOzdEAYegoinv4QWqmu4YkGfGvIVGK7ma0jEC5c6/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IIP2VCdmW10I5EWHcvzvSQuHS8a1m/eXCUW+3HRogB/ShbaPyRdTbj0+CicAl4SC0Zrx6ES4E8niCt4ljpvE71EUF2+6HLI1/6+Bl9U0QYRoA0QTf0ANtwmzEvSzmTVCVdx607NsFMSivhC03kBodi533JAHxlLjMx5WUmxqEwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEocHLwH; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2c15849aa2cso6617573eec.0
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 14:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774993693; x=1775598493; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z9XZFrjbE2TprMrLGChRtQlyHiVKoGQiGftbWSi5t+k=;
        b=EEocHLwHGdhCKY5foPGamEg0HLe+lEwUeQAcnWAQZBRuBkBqmU0rvBKkqAn0sgCWOp
         iVbvSLZzVMkMG1JsTm0oNRzfp8uYBmrLs01NClOEeYMkZjOpQin/9d0NhYeqhvv7wHl6
         qSuKyMzovVqaGJSBKFlZBQlx+EUpjE0WLJDVnL7c1Y1aD4F7kD1qokVaLdktdxy4I4eX
         Smm7i4C+0g/jAcOhRp90faTLLYcSMVkh/T50fY3aG+dOgmbWppLnSNXjS0FNZzsZjRYT
         NipexFu0a5goG07wLIqvfwWSzcdCK6EB+2L4JSsdvfhtghmGef1cmG6LEZJ7JMUZn9C8
         TUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774993693; x=1775598493;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z9XZFrjbE2TprMrLGChRtQlyHiVKoGQiGftbWSi5t+k=;
        b=i50QiBuY/1x5A7MKE9/N1opftYgmkMVkZjxrIFpN5Df6spUgSvNvt7CeZYdbrVCXoT
         /YQ2HexQfgrcNzp3sF1DKuVEYACBdM1Z1RW4gXDw0gy5TiogeZf8aNzeQ+q+e988WQsq
         0Xiu0tw43u4Y4DTEfEDhAv97iycZpk9u5V9Wc6irGYz3QKkVSBYr5TBqPimgDKtrEIbl
         6jLAyHHwAbDB2UrhY28PLi+te3ViUC63udPUBMFMI4DJqVXis8eUgvdDz5ag/OsZ3biF
         ggmTycwh0LmekMSu6SsSDQRXEAuXX/IbF48sVS9MQCKsTqBDOGRFCogh25tZBD16npHf
         iNLQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4vFZ6N2crsDWACJkt46wRgIDfRChoufTb1Fiu3zV18XBD7KjC+5qe+EjNvJujfc19Gpr01ZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPL9EZH532vS4bi3t2t2o9yQE4kAFx4Hl6SfJReRvQbuUecwAU
	JiQG1oBbjPAjiPNoHfPmxiqaB/MHTWIFyZJrYstI1iyYQuiRTRgzrp0z
X-Gm-Gg: ATEYQzzTq6P8M/uYngnc9+igrVj2t3uPqnHcUAxpnf3o1wFf7aE7T8hSgIVRYXYFz7+
	ldEWaQvm5yJqRbeBO5vLq7qSZocldVF5cmbJa2EY3zgjSjCaR533s2Hv7BYZLemUDQyQ03NFH7+
	/11ZHeqXkn+kxhhgMuwb9+r8rgVtst/QR8Xp8iVlf0ow9hJLYvQcAjfGyUtxiFecS3CFl1/Rt2M
	afkGPjHdeGbnDes0TqRxCfcEE8Kfj9K5K1ZkE21S4HvuEqAYlPB7uKTDdL44363DuEvENvbTlKO
	etTMiKJNLkbswnusC5hPt7n9M7P0xj5xYI5SqINICeGwl2lWCEpGBUtgfmuAdEBX/oYYfcR6JWz
	gGw2GnnQ87K1C/zqqI/p7zjXfxVF/IH4bbaLS/BLkIAOOCWcLyGkK3c3T8A11nivRJGPZX/tZb0
	/IXybbP72dKfcecpWdo2CGYuasy9k10A+SEcip/NJdO2FQabcfww==
X-Received: by 2002:a05:693c:3118:b0:2c1:60c8:e0ba with SMTP id 5a478bee46e88-2c93138bdd2mr661459eec.15.1774993692362;
        Tue, 31 Mar 2026 14:48:12 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c10361e7sm11365139eec.0.2026.03.31.14.48.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 14:48:11 -0700 (PDT)
Message-ID: <8c3357b3-56be-4f31-bddc-8c6cf76c8683@gmail.com>
Date: Tue, 31 Mar 2026 14:48:09 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/175] 6.6.131-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260331161729.779738837@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260331161729.779738837@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232583-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0A1B93722B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/31/26 09:19, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.131 release.
> There are 175 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Apr 2026 16:16:56 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.131-rc1.gz
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

