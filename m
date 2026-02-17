Return-Path: <stable+bounces-217190-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFoKGRvqlGm7IwIAu9opvQ
	(envelope-from <stable+bounces-217190-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 23:22:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F0A1516A6
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 23:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A21130451CC
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 22:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D095308F2E;
	Tue, 17 Feb 2026 22:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVvfIfic"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BE519A288
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 22:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771366935; cv=none; b=U9HQ88U204dgfwhwQn2wem/aH2nvmBZ2hxStCf58LcCiw5IjNp3iq7ILucCLg1LfIsRcV941aovl6KkXEWplV1TE8ctQ2HNNek0Zmfb5Jaz2KZAk6K3JJiLNhA6JdudHzL/b/J+5eM3vhNO0etKLQ/78yjwKwEySNttpLyHGUhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771366935; c=relaxed/simple;
	bh=4pSsJQI5kK7F9RTBEsjVvW4cGYa2TNW9h6ZRUVNEcj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V7WziZnozAFeFPYxshpTEeBcoQPynxcK/ViJpQkJPqccnT7geDmfmJnbjjLHavW4iqmz9/alfhEeuNQ9C7ZoD/4LFNoOPRo6yfWgnyt9+gw79e63LnwBResUDs871vOGnFKiLdfMRzOi5ljmhpT7uUJzDLV4Mysn7TjGEmGTvo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVvfIfic; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-126ea4e9694so814783c88.1
        for <stable@vger.kernel.org>; Tue, 17 Feb 2026 14:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771366932; x=1771971732; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6lAc0oYjOpDfV76/LRGYzzkMGR3mISHKce2UjflqzxQ=;
        b=jVvfIficGD9E1tutvdg6t2dTUxuwMR5eJwsBagevIjAg/lYAyzujmgHDOsPYTa05nv
         mJruA1/7uo4sWIZQKLIg6oZ5uFc3sZwSItH9QAiwvgHwkh/kXN675vfyaKF9JckyQ3qD
         vUoWX7E2YstSW3eljLPBAXs+WDpc9FCegrI+Qjn4PrvLQ5RKwm5BIfsy8uw1vUvsfTJk
         jQOonvZXjKQP+7akidcrP2V1ip474uA06mpXE7y6YXobj8JVp2eMjsoVgcB5ad3KuECL
         jblL2GEYX4euZ9red6zRPgJCQSvPfXjJn3SHGjoHqJruvH0PQHB3l1COZ722I2+rCV/j
         QCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771366932; x=1771971732;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6lAc0oYjOpDfV76/LRGYzzkMGR3mISHKce2UjflqzxQ=;
        b=flgqcNg2s277mFfis+tbmDMLmKQws2FPebXhNFvtQ0D+BNCiEtycQZrMOiu2+Chxb8
         fMqlky8LC5X9+mR+jTRXq6pDLhp34uDdzp12hfbVHWMN0o1Z7xZMCZvMiedD/jjMcRVG
         BLb9THKv0kd44UtagzdUKC2xu49HUC5QIEKc6z7ybiRn917ZntygLEZFJ3+dKIw5WRZp
         BwAhB01UxFM5dlVJz/JdwC4sBkdhMvpdcqd3cWS1DsUJWIYpHjPGdq7Wjk27jV10w3sF
         QKXzD+DDMS1rUFCh/SlOEv1fHgMOXRG/o/3l2Ke1IheUtXKrElHByh0kwaV1GfVU3te5
         OVPA==
X-Forwarded-Encrypted: i=1; AJvYcCXWUbeGSNMgpBMw1tqapDPOZs3JgNjefDlkhDc5Di3hWiScC/X9CFp2aTe+/AgURDUu7U3uKyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmJbyTz/RHVp4slBBSYUQzpgTcPSNx2Z2FhHIigU3ONZ4M5s8X
	ZrXHCDH0olhpoGn5aLfJgfdZ2vF0/iCe2NwBgmPD/W+YbgfeYFqEI5FN
X-Gm-Gg: AZuq6aID7LxuTcstdrJU1AxIok4AZoHPhMwqvv7CWlXr3cEGk5y4oIWW0SWu0DUxkad
	uIW6YKLi2l4ROVrFTL+MPQldpxu9/9DkFgG65HavHBnVXYxus74ulfGtgTR5QtMjnSslA/vE9BD
	hiGe40MlX8qGAsiFgCk04FemQfyAMGYm1SDsof1DWD3xyp7tRgY+rtIVmmEdXfI1IUIGMcfzBTJ
	F1RLIiFTnd4jjY9MawaWJEUaVa/FFkDKxNeS32huCVnyrH6QPQbFbUD8tjp77spjzKxj7uY4RII
	ry4V+0g5mblnSIBsd40tOCoVo9Ij/Jc/HokQBBfvj+bomxOD6TfFQRxwnw3IAPzMB1BSvbFsVuL
	SlbM76F0l7r4blxzvXYWAYYv/HyPHCOjEXNLNEdEkHOrky0VtK7gyx1gOtOLJ1BggyyH5BeQS8t
	pQHQ1Hd1hh4uLgZy3vSnqfro2T8fLonCSKe2CplzF9ZH2RwuFoIbMYCc+pflyk
X-Received: by 2002:a05:7301:2f99:b0:2ba:7033:533b with SMTP id 5a478bee46e88-2babc47ff16mr6278958eec.32.1771366931836;
        Tue, 17 Feb 2026 14:22:11 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb67b638sm16215305eec.31.2026.02.17.14.22.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 14:22:11 -0800 (PST)
Message-ID: <9e904b11-7064-4a3d-9dd5-473e892fbf38@gmail.com>
Date: Tue, 17 Feb 2026 14:22:09 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/39] 5.15.201-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260217200002.929083107@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260217200002.929083107@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-217190-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Queue-Id: D0F0A1516A6
X-Rspamd-Action: no action

On 2/17/26 12:31, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.201 release.
> There are 39 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 19 Feb 2026 19:59:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.201-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

