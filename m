Return-Path: <stable+bounces-224550-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCBgD3hssGmNjAIAu9opvQ
	(envelope-from <stable+bounces-224550-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 20:09:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C74B0256DD2
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 20:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 634C0307A560
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 19:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F783CE4A5;
	Tue, 10 Mar 2026 19:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5ud4Uyw"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D673C870A
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 19:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773169780; cv=none; b=DtC6I8q7832iR8IODP4D76hL4tSOv3utV6MKq5PLbYSrCzAx+1G4Edvgq2A+PauwCDlVPUQdASkZWKOZ1L2JUPcsR96XCVawBJTumrojxRW1M0RVQN9ti7RUucvnG1totcUHYsr6nbuRVQWDNOJtKQm1u9qkItolqIbvxM3IkQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773169780; c=relaxed/simple;
	bh=d749lpuLw4bRFZtFGAI8iFScaeeBX4y/IVQTaRR9eoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HKCk+FJNfhLbSQT0hYMrMcyMMTP8cX4GIeLsHpehcUlMgOkeap7lBHDEi8PTTiOkxNpNMPRvLNLrCOMpJwprzACS9lMl32VB5hyYSZpQfjJNfXpkaAkO2/nWIyxoYcvnWiUysVgXfDy6ue0F/yn5ksaGKEtsbRfgWYEbhN578fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5ud4Uyw; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-505a1789a27so78173841cf.3
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 12:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773169777; x=1773774577; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NAykrKz2PIIorfI6OwgxhSO9QOnVj+7F9gFJJXy6oVw=;
        b=Q5ud4UywHMM2SGA7nb3Q6VjGv1myD0zHLdPFqhQOu1NVtDYv5eRK4OdbGvkdv6LIFG
         ItiK7F91W48CPltrdr4qZvk6dC6ViVXF0YAkz4jJT6u3jmVYdB8AJM9mOQzdc3vyDMZ4
         RY7k0BHQtiEARZTYVkJhosUyc/peind19rqIO8A/n6N9B4nJK0zm54TUR4/EZk6w0o7k
         yVvxlsWFCJN+Jh7YTBviS2Kol+lVHSQ/qVml43EQ6h0/FkqBckxcDozaJaMUpH613nbP
         Dwkrytf0sac1PdaVrDpJTnRFEwdIETJlLKr2/WvkLkfuTWsLhneIQNjLR+sNI7JnMsHp
         7lcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773169777; x=1773774577;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NAykrKz2PIIorfI6OwgxhSO9QOnVj+7F9gFJJXy6oVw=;
        b=RhLYjROoZEoWKI6DddxbpAATzgtsCUYV1GaDCgETGbME6rTLpyqajT0cz/bUNtpSkQ
         a/TH9ZNvTJZPbzCetk32atzW76H/I1iX8nZOv6AGGCN3jKfL+fzD8kkuMbd/T2U1kaB+
         M2hmIMLMPg0frhjkTOT+zHxx8NRWdeRWe7u9xYX38gm9F6aD/iW5t+GEnIo4Nc6hRsC3
         pCWGD94l9lEeQUKb/tQYPfT9oBSgyCMiEG92sRjaz3HbqzB2bsux4lP7/mMS/QDwDjhZ
         EjBOsvuCVKvfqSxvQDcTxRSa0rEGqeJ7LNrY622of3Uq/81ik+k7Ear6/T/hAuHE1tW1
         UlgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYv/gtGm6rGoJgPVKqcJKjC5c4G18Am5eT38QrxrDVIwi4AMkkihalvuNB+8SNcCfxm+Tghyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNaanRF0ngGfRBgb02tf5Sls+nq5ApdSnH1JxQz/Wr3v0nvPi9
	aZpjxkYrwkvmakRhHKtUArbU4iZN7gIqJNzgNLw5ua/5NpYwb7GQ2044
X-Gm-Gg: ATEYQzxphpT+zd5cU/j1wwuwZ5LBscutAv2QNH1IeYU7dc69ts2dYar2SeJNEDdVbNg
	ZYIDhkBXlByK7ECO050O8d6uo0nO1aUvGjclXN+BO6kdCfY6nksW93GMityMOcCge3n+u9pUl8w
	XMl2h9BAPI08CkUGI+rOYIm55VTwB1Sv4oK1fn4dYpykXt81HoEp6aaHr2c+gItNPQd290H6d7W
	L5TblKNt9btsPPaes3dsiCfapgDcVx4YsnQanuElQC3fQJODtBVHW83/BwG5WDGKnp7mNOvuICw
	a1PHcRBFKMk4eoqjMqjw+jyjkiXrTbE/U10QcYKgjFFltJdd+Tg7GwgfNUWjk3d1k60Dj5RYs/6
	U7zjHCZZ5nny2j1Ws9VmDMfcvNTUjKneH5+RRVa0mGOVfpHmhBdNY13PNm2TutYOILFKiMICrXy
	bAXHoz/tDKIDwEJFzOxqjV7F7qDLR2FAqF5Hor4AGbv8hvqPuWaQ==
X-Received: by 2002:ac8:5fc3:0:b0:509:3025:ff4f with SMTP id d75a77b69052e-5093026145fmr28324041cf.16.1773169776820;
        Tue, 10 Mar 2026 12:09:36 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5093862bbc9sm1602901cf.5.2026.03.10.12.09.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 12:09:36 -0700 (PDT)
Message-ID: <75302bf4-3f06-4e9a-8d05-1706d60f44c6@gmail.com>
Date: Tue, 10 Mar 2026 12:09:32 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.19 000/311] 6.19.7-rc1 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, patches@lists.linux.dev,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <cover.1773140654.git.sashal@kernel.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C74B0256DD2
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
	TAGGED_FROM(0.00)[bounces-224550-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/10/26 04:05, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 6.19.7 release.
> There are 311 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Mar 12 11:04:16 AM UTC 2026.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/rawdiff/?id=linux-6.19.y&id2=v6.19.6
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.19.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha
> 
> -------------
perf fails to build the pmu-events for all of the freescale SoCs, I am 
not sure yet whether this is a build environment issue or a genuine perf 
build system failure:

cp: cannot stat 
'pmu-events/arch/arm64/freescale/imx8mm/sys/metrics.json': No such file 
or directory
   CC 
/local/users/fainelli/buildroot/output/arm64/build/linux-custom/tools/perf/util/maps.o
cp: cannot stat 'pmu-events/arch/arm64/freescale/imx8mm/sys/ddrc.json': 
No such file or directory
cp: cannot stat 
'pmu-events/arch/arm64/freescale/imx94/sys/metrics.json': No such file 
or directory
cp: cannot stat 'pmu-events/arch/arm64/freescale/imx94/sys/ddrc.json': 
No such file or directory
   CC 
/local/users/fainelli/buildroot/output/arm64/build/linux-custom/tools/perf/util/pstack.o
   GEN 
/local/users/fainelli/buildroot/output/arm64/build/linux-custom/tools/perf/pmu-events/arch/arm64/freescale/imx91/sys/metrics.json
   CC 
/local/users/fainelli/buildroot/output/arm64/build/linux-custom/tools/perf/util/session.o
make[5]: *** [pmu-events/Build:44: 
/local/users/fainelli/buildroot/output/arm64/build/linux-custom/tools/perf/pmu-events/arch/arm64/freescale/imx8mm/sys/metrics.json] 
Error 1
make[5]: *** Waiting for unfinished jobs....
   GEN 
/local/users/fainelli/buildroot/output/arm64/build/linux-custom/tools/perf/pmu-events/arch/arm64/freescale/imx91/sys/ddrc.json
make[5]: *** [pmu-events/Build:44: 
/local/users/fainelli/buildroot/output/arm64/build/linux-custom/tools/perf/pmu-events/arch/arm64/freescale/imx8mm/sys/ddrc.json] 
Error 1
make[5]: *** [pmu-events/Build:44: 
/local/users/fainelli/buildroot/output/arm64/build/linux-custom/tools/perf/pmu-events/arch/arm64/freescale/imx94/sys/metrics.json] 
Error 1
make[5]: *** [pmu-events/Build:44: 
/local/users/fainelli/buildroot/output/arm64/build/linux-custom/tools/perf/pmu-events/arch/arm64/freescale/imx94/sys/ddrc.json] 
Error 1

...

cp: cannot stat 
'pmu-events/arch/arm64/freescale/imx8mm/sys/metrics.json': No such file 
or directory
make[5]: *** [pmu-events/Build:44: 
/local/users/fainelli/buildroot/output/arm64/build/linux-custom/tools/perf/pmu-events/arch/arm64/freescale/imx8mm/sys/metrics.json] 
Error 1
make[4]: *** [Makefile.perf:770: 
/local/users/fainelli/buildroot/output/arm64/build/linux-custom/tools/perf/pmu-events/pmu-events-in.o] 
Error 2
make[4]: *** Waiting for unfinished jobs....

-- 
Florian

