Return-Path: <stable+bounces-222784-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCWNN11upmkaPwAAu9opvQ
	(envelope-from <stable+bounces-222784-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 06:15:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC201E9266
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 06:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0111030406B3
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 05:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62352FF641;
	Tue,  3 Mar 2026 05:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEZOojRE"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FE03019A4
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 05:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772514897; cv=none; b=ZOMg2iZ/HddXj/nzMJF89J+uPCRUGVOQEBcK2ItiMqYIhKi2A88ZPxppp4sTM4jW8Hwvs7QyHMwTqA+8BhgsKx+/aD1/Ognad5bvBxwDDTk010NCqsL1de3nVkXUR3m2O/RclFLSyWbG589G0rAWLBBtHXf+wZqEp4gEzpuLDxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772514897; c=relaxed/simple;
	bh=vk9qZCYAhn6+MzhJrnJMYcWMNS2Q3wjEbZOhACThAOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g4FSar0ya6VU38x+McbrHTUklTKsFvG7Q8S+YxE4EjVgBiLaoj8SpblI+a0nP6VN3SSwS/bgTxhz97Hsl/n1VTbpPk8JUKBELd3QJBvo3Q73vkMjEf6umfyg7XODyOVTcTocqqH7aCCTkVqyMA97a4j/2sgTZkXZpetKBhHCStU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEZOojRE; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2be1b5fe11cso1394045eec.0
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 21:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772514896; x=1773119696; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gAXxhZD66BOd5+I9IRvOirVw8kWuRRHbq9SiuFrJiWQ=;
        b=QEZOojREgYvpO0Fp/ByGZ2XiyGfs3VFdp2elpYgZnoCH5JdCxJGstaOekZhAasdtbw
         WNLlDClk3tgGAEwRCqs925pEIDIw4rCoAuiqmVdLaU2vCrCP1lIGZ02VbuZjFgR0JUQX
         vaKclwNi104N72L0Q+bwWuVpnHpTPwT2vNXO/fPcLY9mj6VIIHU7ySsoVDhBPfi0eVe8
         /gNVR8zjKS2je6/37yYKQQ3l7m6AS2k40nisVpwWPNjSWzQ2VmtxEGzSPKbn/ELET4RV
         LspnWMWCOBOaAelRNDyWlRFnSTEZMXIrPzLbdlQbH54B8MYipzMjdUHEke1X2blbA7IK
         4L3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772514896; x=1773119696;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gAXxhZD66BOd5+I9IRvOirVw8kWuRRHbq9SiuFrJiWQ=;
        b=ZuSzcxqavnBDYS44e8tNaaF6vB0oUSHndPcRgNwgLf/J2DxIQTYJ6kI0JKh012yzwe
         0hYvxd3YFmsSOjqpSj0+/jtoX5GPRzjgKLEf+KhxQvjPXd9ukHCNd2TMcp4NJrzosLXA
         8LwDzWXchDFkH5A3l3dyLTKn04fkb5dOfZfA8wijZh2DZMNBG2WfQGWB4NIKNMUk4yfS
         P+j/1qw+cSAgsxggAD9a0swOoJu8JVrqxj7aXxZJ+EYVWg1sYnaKlwiNPjdDqWUfphfM
         JSZGjQNCPD92U3nINkRg7HkejpX7Rwa+VVLv818RCZGtJK24LaCc9pWpemSja/Q3+kPT
         otug==
X-Forwarded-Encrypted: i=1; AJvYcCXynOp1hdZjlPhWfWWtDsmDNkpvqivNEP3XOsyXsPbvgG0IbVuT64b0HMOuSuRx4Z9J9+4RaXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYFIQM9TGgxpR+qTG79RNl0nPchUcWbb9mqCzuup1opUhVF5Ak
	Axj915tk3xMgmfhICZnQDrIBVMDI1BpgFDcxuZy5w5zs/efD4fLKwoBo
X-Gm-Gg: ATEYQzw+KgxlUGpz6GG9T1ck6vq2VBzKfL+putXoj9XNauna8Q0qa7ji8rJ1gNgOSOX
	uqDfZKgf1yOc9tQoEpIyZKRx1ZQwi6p9ULCDMluxgyr1kwdSizJrctBtzIQcmc5i4xy3W4+AOBj
	5o6/jz3HbxPQxtRCY89eNmCNSKpEnEZ5MOznMZMVL9byF+dSZfZLrvwYUDTM4ZR6eqVHT6Ro54C
	7jhc89X09/AbxMfCuy3TkWPVxhe+zZeTNMatgNPR6MqK3aul/eJIVDLnu/Zb+zlKhKndPNayYQe
	Vw0ojyxftvtTgfn2wENPM09JX8VAMuI1DQ83bBLZeJZXuZL7/j4tOX1tOGSNipdAv/Aw+Bb2Y88
	1AyE+PnUHRlbvCh7LVenO5iU91R8+I+vDO71Bih1HD7yJnbfl1EBE7EboN+VPuFAZDg2p9Pv8Cn
	oySr9NMwoSbguisJC0kD7q3KSz8+UdoC0TYg0DauMF5dVMkoo4D+ShGLyGzjTkEhHa5so9eBP7+
	+Y=
X-Received: by 2002:a05:7300:3213:b0:2b7:f809:9c31 with SMTP id 5a478bee46e88-2bde1e77f87mr5650134eec.34.1772514895549;
        Mon, 02 Mar 2026 21:14:55 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1f7e955sm12378567eec.32.2026.03.02.21.14.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 21:14:54 -0800 (PST)
Message-ID: <1ca6d1ef-7c2f-44c3-bbd3-a69ef2989e3e@gmail.com>
Date: Mon, 2 Mar 2026 21:14:54 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/956] 6.12.75-rc2 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, patches@lists.linux.dev,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260302160918.2520730-1-sashal@kernel.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260302160918.2520730-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5CC201E9266
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222784-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action



On 3/2/2026 8:09 AM, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 6.12.75 release.
> There are 956 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar  4 04:09:04 PM UTC 2026.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.12.y&id2=v6.12.74
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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


