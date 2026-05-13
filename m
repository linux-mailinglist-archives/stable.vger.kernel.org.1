Return-Path: <stable+bounces-246972-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFkrExy6BGplNQIAu9opvQ
	(envelope-from <stable+bounces-246972-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 19:51:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C5D538533
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 19:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52435305246E
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291264DBD8F;
	Wed, 13 May 2026 17:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grD7cYWf"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE794DBD7D
	for <stable@vger.kernel.org>; Wed, 13 May 2026 17:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778693746; cv=none; b=txp/qTH/LuzWPaSFcM4t7bVZI3mPZzpyTeuLkEeuFox+RjAt41Q98BrWq3W/MoAcz4C+qbNsDatoFrCkWxilXrQJ1jRYI8qnH3czDbTX5DxQWndgGhzWBw20nukhLSV47W/rf7TGd0tpkIGqWYHEpB1mfa9vTtERHjZwEUIxY6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778693746; c=relaxed/simple;
	bh=KCal7kzqZI8+0VK4uQJCVOmFtclj032kNAYQovwtFr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vw7V2Ode2KyOkJ12PeqjUKB/DfvLOVlpJeAp66P6l5uApG3madtVljYyjjU1OnH+RtCcNUQTJONGfybtBEgS5K4Dd0rKV47Z2k8m3bCS5aNYckJKCDWZoj3RTuig/CFRAfnOXWoJT37xoeUApTdIbw3QfsfinTBntDe6SLx0LLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=grD7cYWf; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12c8f9846c8so10521259c88.0
        for <stable@vger.kernel.org>; Wed, 13 May 2026 10:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778693744; x=1779298544; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ul0Nd+LldB2hhhsaIn510nAc6p+u/VtWN9+3RBSesGw=;
        b=grD7cYWf6zhCwpnwfx2juIRzB7lT9Yfxn9auSSUuyPeSSnbM6U0Jbf/jOZR9Fs8C0I
         SsQVJSh6PwjT4rWOUXaEpA5rqFlgXyjtkjQNRsx7o3+MfGw3BOR1YBOLcTibKXttMvyR
         9EtOtedmFCAcA4F1+brsn/TSju4DoEHStt8JEH7ctihRvR0GgKO7fSH3geaTOQogDseR
         wPCiCxG5G4GNkx9sLpXxsOxtA/keWLy947YbCjfoozS+O6wfl7jDyDhLlKhChGNafDz9
         9OV6GKUyjy5caxMVwsX9V47X8Nw7jYttitcc2/es5JtCbHD2srLw+BgMgguLJf1UKfGh
         7W8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778693744; x=1779298544;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ul0Nd+LldB2hhhsaIn510nAc6p+u/VtWN9+3RBSesGw=;
        b=CqHKlTIMExxtM2T6698C1SOuu66reHgL72VoKv98xLaDAFh+KUqt3IkCAN92r/RnJZ
         B1sPk/pjtVI2Gqpd60Y8ZgQheguFgzDTw/66+lvLCwo08337nJoc7gZ56H+uiJujd0w1
         HqaP0rM8HtMsn/AYG04j5BciTwyE+tflQZ+MYzgx78IlKPMiISUbkyRp4kErJWdSeH92
         TsUvpUjBDm3Nl4dk7G+XKOFenJDM4F54jP1YGgkWoJOeCv0lH7FWsyAPB7t62U+e7T8F
         bZgI1jo0DFxhk5n190CVoMAVLdMbaDmf240442SIBz757KmYSH703f6zo19p2moQlqP/
         p6oQ==
X-Forwarded-Encrypted: i=1; AFNElJ+5kyZalTlE7ti/TXg+aFIJ9iX9mjvhLzRtx6q6b8Ddu7tR4+yLun0/OUP89g6soweBVWk5YeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtdxWUTUsrEx3ahxz1VMZVJOiApS0cMG+taM4qo9jdfs269hkK
	SU9zFrOPzoU3jFD8fn8sHvDd0V2XtRTUZ5SLqVQsV/Gr7UNSy8+N0vmG
X-Gm-Gg: Acq92OH+n3VpDi7WbhshE07BoHiL+NWb8w6nXB9yK8DBIbQ0/TdLGCOZltq+HMYcgZE
	xjih/QOAvP8L0AERSU5YqsAQOcpJ+WY5elYtBN7+TqFaphplIDe5p4OeSh0KZ1Vs3UeY7SOfZJJ
	fMllI55T1CNsXyaMbE2a80IV/6Pj7443/PlXZSLUGn++YUcVbYYTwVS92J1BBuvta0stN4gOsQy
	jJjUDTztX6ynKOWMkPcQWBAU61gjuWBAu8hx/d01pEvJGrbHHiKBe80Tsws1NMorGujnstdDyTz
	NbYKZYrLKDbdiUx8lI4Q3L3p5GbyA6uaESwKymFwyOiVCTDQzLMKoIx+/VT14Px1PXka8qLy3xD
	HiSfIMUZdvA106dvvpeFLcVwbw24U3fsGxPONil+u1yaw7nzbhGLetGRWcOzQHvValfDsPp3+Y8
	BppV5SsOYEUDlbV544AK3LaZYi3gWe2SSLgc2w0eNBWXj1fcOMynxNVawSRfANrJh1
X-Received: by 2002:a05:7022:21e:b0:12c:34b9:61bc with SMTP id a92af1059eb24-1342ee3a02emr2676237c88.5.1778693743835;
        Wed, 13 May 2026 10:35:43 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc33aac9sm51967c88.14.2026.05.13.10.35.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 10:35:43 -0700 (PDT)
Message-ID: <199abc0a-e5b0-44c4-a0f2-11d1f959e606@gmail.com>
Date: Wed, 13 May 2026 10:35:42 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/268] 6.18.30-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260513153744.746440810@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260513153744.746440810@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: F3C5D538533
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246972-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Action: no action



On 5/13/2026 9:17 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.30 release.
> There are 268 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 15 May 2026 15:37:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.30-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


