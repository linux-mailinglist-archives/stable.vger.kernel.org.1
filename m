Return-Path: <stable+bounces-248944-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKtBHfaiB2rP/QIAu9opvQ
	(envelope-from <stable+bounces-248944-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 00:49:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2F555910D
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 00:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F5F43010266
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 22:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFC935E1D1;
	Fri, 15 May 2026 22:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V6kBCY9A"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB23340282
	for <stable@vger.kernel.org>; Fri, 15 May 2026 22:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778885169; cv=none; b=iXfNMgaUNVKzLiogZcwevRGF4M4QvX4Rsh4gldbBpx+k3ko1enwc4FLqrSYhTXtuDO87uX9agWsaIzfEPgXdIyzqv308cIHCxpKJAYi7eZgOG57fEmm8YI6t+xO1LQnb3ipZ85x4fBxYMxorI58Sm6PIKugLp+ZVvdcfdYa+Mwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778885169; c=relaxed/simple;
	bh=4VWdYZOeSXPXzHYSybAygONbBj/ffb7fn+UnSWUUdsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cPe0h4yWMXvCrRGGWHIP80/kzuLqkcgDBhxlr/I3ELNUOog7Or96qZtDY8HZcmZyZ9pkeCp1H3ubj2CETfTqU7VOHeK0Tl6aYG8QpbBCYhlmBVPnHnPbKMKF1TiTLQQ7XhtfMev3u2VEuWerewPH+urL07A+T+yfwG4xUwbZNhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V6kBCY9A; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a742b8b72eso394633e87.1
        for <stable@vger.kernel.org>; Fri, 15 May 2026 15:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1778885165; x=1779489965; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=84CRE+I2YfK1j6GPeY5z65m1K/HjZDHpGYmsC5LRKQk=;
        b=V6kBCY9AutjsyZdO8on3+zZUb9q46L7+GYKNA8PCSIqUE3m4MEOxhgq1Cvty7VRPPE
         Ql2S3NKHpUOWCvfkWrP+yI5QSX93xvEHa7jT58r3rt+8I7yG6aCrxXKyMMJIHNSjVQdD
         hLhsebr4qW9pPOYZwZas9hkRc4I72HkaneshM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778885165; x=1779489965;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=84CRE+I2YfK1j6GPeY5z65m1K/HjZDHpGYmsC5LRKQk=;
        b=FGmhLnYeoTqjDa9LfCPVFA4pBToRLb5QA7dCW6v77IzMQiaTQCBu/zyNR7Y06AWkCt
         Rb0MOp3+ZE9g9yEpuuT4RU3nSeMm5M9GdYVCMA4PE2WHbof5sLyYmX6bCTEaKA7dLhOf
         sc5DwqOmd8CoWC+8kUR3EvfHX/uNO7Xquq2qattRvpaYCEHuiNlISXbpm+4s2iDTi4Q+
         Tf/ccKf1E0ltlUnpBC7T9t4S4QHvRzO26bRNm/u9r5Fs7DZHLPhPBJmlr2OjwKPqt455
         EjozJjZ5vlCQDsFKwwf9pr9SntKT5jn963TGdEjKCWUiRS27vBO6sWfPE3KfsJTkf80T
         gEVA==
X-Forwarded-Encrypted: i=1; AFNElJ8fhTg9FEJrqnM7u7EmqDQ6Dza10t2lSiZGImb2QMj4hKwkqi3SpiY230raKGy0FokQdrCa21Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlp+96dIk3OVAkBjvM09JHsqKe6XN5cKVnyjBLRT6scP3GwrqK
	tZKhHRLZb3kfDsmAti5ufIm4UirVO+Qcql03a1+Bx61X6ljT6lbpKFsBuHx9vJoyDeQ=
X-Gm-Gg: Acq92OGzxV4vZFDxce/99DzIkl02TATqIP8O7bhYslW3i9fKSgj6QtTykD1S2bSn230
	Ed8lXy/WrdbxoGm7QtlMjToTVgwZN2TkSEmTiZZBw+7ZcpEfjmtPMbd662H30szJzJUQ8YbuChM
	8CIQ9u+zRbiy3cFIlJZHPmi+8S0nGyTSaGTaPGRB6f/nCzMGZLUzqR1MKdsQJl7bBcxv/jlcQmS
	idbMqYZEF4Z6KGMO5VOh3kRb7S52wJPmklysqGGQvh6NdXG52GyFaOFXUcLDNs0FLzgsHeEFGtz
	bARPPacCYVUiboly/rzoMARJIm8cl7ImBFIz+lXjHugfXibZohHPm0B77meMQlwuUBXN4TiVUX1
	/Hvg5irm4Oxr204x+BJUisqf/m0CLCWKHpDfxBpXC76+faKoVcdhcKRl6IcU/h2BGngw3P1x7HN
	W4DEXYpRBs7WfxMExPg9SRRnYW7ZK11Mc=
X-Received: by 2002:a05:6512:1388:b0:5a4:17a6:9780 with SMTP id 2adb3069b0e04-5aa0e61132dmr1871519e87.14.1778885164759;
        Fri, 15 May 2026 15:46:04 -0700 (PDT)
Received: from [192.168.1.14] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a9164cf003sm1570444e87.73.2026.05.15.15.45.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 15:46:03 -0700 (PDT)
Message-ID: <df624493-c29d-4bdd-aff2-8209d2bd6a9e@linuxfoundation.org>
Date: Fri, 15 May 2026 16:45:56 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/188] 6.18.32-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260515154657.309489048@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260515154657.309489048@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: EC2F555910D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-248944-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com,linuxfoundation.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhan@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/15/26 09:46, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.32 release.
> There are 188 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 17 May 2026 15:46:37 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.32-rc1.gz
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

