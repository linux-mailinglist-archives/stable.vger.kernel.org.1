Return-Path: <stable+bounces-268648-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l/FaHFBxPWrJ3AgAu9opvQ
	(envelope-from <stable+bounces-268648-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 20:20:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBA96C8266
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 20:19:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=googlemail.com header.s=20251104 header.b="Z/izyueG";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268648-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-268648-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=gmail.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3235302ADA4
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 18:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31AA2F5321;
	Thu, 25 Jun 2026 18:19:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EEE2F1FEA
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 18:19:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782411595; cv=none; b=sb5ApQluEXSsWawPTQT49fWWntkojrcEMV4JOYPg2j1KwYc2rHTmeIX+AjFgeh5Vw+vt58NaA3gjhkmuEen/2CnpQr6A71MwUMWKiFtj32fRlcfTYV6gESbhRL37r2ZF1x9bWW3lYZeajNtcUQDztRGqX4/4A50C3dnpvEUfnJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782411595; c=relaxed/simple;
	bh=s+oI2GXQ0eVO+G6/VG+wj/0ChWx0Fb1vfvC8e9SCw70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HmuvkItuAReijYapCKC8e3XJE1qFvDa1iXtrCWZg+8PfNiBzKy03lgcCq97ApcNZltjekHrJXUdS5S9EuXe4BYNHrGa1qoXrdJYupcK/LnWYgD/y/Tj7+D+BNuoLY3+SOqFoG4jOCylYEW6MsIYa/yrCMAcTmerpzh33NVSdHBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Z/izyueG; arc=none smtp.client-ip=209.85.221.51
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-463b2f6fc9dso33497f8f.2
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 11:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1782411593; x=1783016393; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G0EWw2t+XHB23CXT8lj21i27NquOnXh7rc/g7nLatCc=;
        b=Z/izyueGSJV3Dp9C8jDSyuNLVGQN7xr8xH0S0VivQYcVpNsQd9RbykMEqqOULspPgt
         zxYzh9k4Q66PHSovry9sYu5FIPGmSYaP9MpDq/9bf6LwZVIDa0qN1STeJ3ldZkjO6gCI
         cB76t9ZMbwFBqd/0V3LvAAm4h1agly3QdiFxTob7r2IL4nGcYyBvTBb5Sgy4sDgq9m2q
         j6CIXlkKUja8s8XKWXbReuOlhQI/W+cIZ/FHV+Dm/pl/xgmPcFHUy+KnItNiGNLwfPl5
         hpP/3dsB6VzJNpsu9GbWpTw3pcC8y+fIPLQGX5vOSUIdNsH8d+M6J/uudRX+NVhTq1Va
         hqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782411593; x=1783016393;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G0EWw2t+XHB23CXT8lj21i27NquOnXh7rc/g7nLatCc=;
        b=W/EkQuiwRLREwrItmISKq3GEr0VwiOvABA4EyOk9GMXWAG/UyASGjWVpFg0UF2R2ki
         DWbndk58AZXT+Jw+fHw53ssOCV0JQKM10e21Y9j5+gF1GAJfCl2iRxHrHj41mJNb0eaA
         A+BKBtbi9Wm0q14304IScQdT/jvEfDBDsDxJrVKOhudtRCk6kpLKd42dIWScTsKCIGrm
         PZMB4qAEBo7ime67gi+CukeCJMjSZxBvqopbBv8KspCz7N5h2B3dKrNXpSFMVPk96WFI
         k/zTIylEcY+V2d+JR63/3JuVsvIVfLKXWl+DsRLPwRXMfhYMaF401wADKk+k6hV8eC8F
         SQbw==
X-Forwarded-Encrypted: i=1; AFNElJ+QbnAFoPTa6GzUkc7tKQgwslO/AvpSyMlX3Dd42ywmIP9VYi+4PEQxQZUO/+Nftnhn44c6Zfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YztdaccWdzBzKncLJxgnFNZtHcA6sZCSb6W4ldj9oNFEfDhKx36
	VlrxxSsZGrRiUqL9uPyZAzc+ZpXi7JbxQOGhnVh/h/ItbQPO0MkJgxHJGI10QzM=
X-Gm-Gg: AfdE7cnOqu+SmdkPn61byyBToR8uPtb8QajPtfMJXNPl0vo/5CsDKeyvV/WvXoYZlM8
	mF1YCRhVrNTX4wtSQowlKtW3GyhN6HJd1F5uOK8vc+izRX1kljUc2o0TfUgk8BQje4YvetFuXY4
	FDLdFBkumiZlX2pSaSr6XqXHPYt/KkiE5FD6EhEPDzTg73MGRvxgSr27f1IA9S5gJPxFmom8WTs
	JWlLH+kABgmNXLsx0V8Qnu1O50C+TcyF2dk/hyjdKNWTtvtZCucFcl6gT/FfCMKSPYZP9qub9Iy
	uMBLWDUOT+un1QYbsdtXyWsVM1oWOw9wb0jDhJQ6biv243B/Ipl1vfFrpZVktgd1BCl9sYHtZfT
	ViClO5qDwZK39A1OkENNW1JvKJpywyXAWbX4aHj4J0nRB3d521PKMC2OTBS3OJmxDjbe/BGPJ5D
	aw7XNyZHM7gmtwD5iZWz6bi4+4lR8BYzIoM1BSVLt9BTvxG9bxR+l2Qkn2bE/zN7jV
X-Received: by 2002:a05:600c:1910:b0:492:3dce:f6ef with SMTP id 5b1f17b1804b1-492668932f7mr52131135e9.28.1782411592837;
        Thu, 25 Jun 2026 11:19:52 -0700 (PDT)
Received: from [192.168.1.3] (p5b0572d8.dip0.t-ipconnect.de. [91.5.114.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492697a22f2sm5125575e9.0.2026.06.25.11.19.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 11:19:52 -0700 (PDT)
Message-ID: <fbf86bb8-e85e-4f95-8e11-ae731b52d19f@googlemail.com>
Date: Thu, 25 Jun 2026 20:19:51 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 7.1 00/21] 7.1.2-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260625125613.243729608@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260625125613.243729608@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.05 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[gmail.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:torvalds@linux-foundation.org,m:akpm@linux-foundation.org,m:linux@roeck-us.net,m:shuah@kernel.org,m:patches@kernelci.org,m:lkft-triage@lists.linaro.org,m:pavel@nabladev.com,m:jonathanh@nvidia.com,m:f.fainelli@gmail.com,m:sudipm.mukherjee@gmail.com,m:rwarsow@gmx.de,m:conor@kernel.org,m:hargar@microsoft.com,m:broonie@kernel.org,m:achill@achill.org,m:sr@sladewatkins.com,m:ffainelli@gmail.com,m:sudipmmukherjee@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pschneider1968@gmail.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[googlemail.com];
	TAGGED_FROM(0.00)[bounces-268648-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[googlemail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pschneider1968@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailvelope.com:url,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,peters-netzplatz.de:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DCBA96C8266

Am 25.06.2026 um 15:03 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 7.1.2 release.
> There are 21 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

