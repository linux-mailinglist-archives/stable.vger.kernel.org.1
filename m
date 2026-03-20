Return-Path: <stable+bounces-227600-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCHTBu2KvWnY+wIAu9opvQ
	(envelope-from <stable+bounces-227600-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 18:59:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B83102DF053
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 18:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 46D4E3006F34
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 17:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682FF3DB64E;
	Fri, 20 Mar 2026 17:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVL3Uaoe"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCF63DA7C2
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 17:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774029542; cv=none; b=aq5KPRXZlzjIOxGJgbS+YpPT2QtKm54llrzyacSREn7FLKFBQUMvzaFnmtn038WB691XsK/VKqrnyUj7UxdnIt2vcvr5fqKW/nru0VcxHExpAmJ5twTrTWi3DOR70sXBngQkf3kMlWJUeeKuQI7fLWdOS8FHlnGi8/9DLSLe2L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774029542; c=relaxed/simple;
	bh=yhiJdUN2FxU28TXhrBvA1ERxsv0Vg9I0vpZj6n+I4Dg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oBA1uo/oGJf3Nqq5Ne4x3i61Kpp+ADbtyQLh25uwqYF2Pj0UbHF4vclTEliLJ0xBpeXqgx2guFHpgYbUXtNZAbUZWkkLtjLTMHAU6zCMORKVxYGMd34GpU9zJBzliNU3eK2RtViD9yTnccTPkLnozvla7xHmaFOt4LqXfzLWC3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVL3Uaoe; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8cd7ecedf2cso83886585a.3
        for <stable@vger.kernel.org>; Fri, 20 Mar 2026 10:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774029539; x=1774634339; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+zTfmuzfsBQZHwA56zgqETuUGa6JX1SqvHIJanpZSJI=;
        b=XVL3Uaoee18p99vSE01UjIeQeKpFCfA5OAqEDlwHs96XexWXzoO65ZAkuTTB066Ty/
         IlP8FI425lxbkTLSTEPzFwBwgoUYNQ2wy+HWB1nNk81AM39X4ZJxPdOoF8H2BfMdOoHF
         rCzVcdqxsYFVpLNsR+N6BW5zFOO+2UnVivpewS1dQArGDIa3RFEbsBvNLxVpIytihbiY
         2bpk+hHvBIZXw5+XcYrj7G2zJGio6lZ5OoK7ds/OmEcyqMU/LDgW2H7f0nbfMorFNLdz
         2UmuzosEFIi3Mdeu1WQYNYaeGaubCgYDJzNRQiXpsZvRcOpXDlS7TSBlVOrkvJZ6I5JG
         QLrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774029539; x=1774634339;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+zTfmuzfsBQZHwA56zgqETuUGa6JX1SqvHIJanpZSJI=;
        b=poCd2xpE+RxDSSI76c37kwAdK/m0OYkDo4faqS/uBGJWk3HHkrIY53SZcrABFYVRWm
         0wzC445ebK1jq9FuoonL6E+4Bu2s5yOkeoDpafnosicxkRVtrX42zb9yJygs6wj2cn+/
         K6loB71bd7/A1uSJvZza9zOtMI678SiyOzSs6lgrh6a2nO+qxD0Pd0BTW9P5iBDtogp8
         BX3hIo4yRPczntBGgBHBlqPCHSHorYgYeVCrm0XdhNhhlz30WwDlpV2RDptXN1BlNeuV
         9T1ApiYYeKq69urIc84DGoNJtj4vh5P5pDep4tGVBGlKhw7Qba5MPzbF74P5w+EoPv6f
         fPyg==
X-Forwarded-Encrypted: i=1; AJvYcCWavW+y+iDEc5Lj/TWRHgqycCNYti4pQqomWhCAwhLi4jMwOk7lv+p4RWLwTpWCPSU51JGbq3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMo+3b4d7wAHF3Igpe3XRShGcS+E8sk3PX73DD5AWcOAtkWOj2
	tVuQjDtUKTt7ikI9qMBdCrItRF3asaf/iyANF/+cRC9N3Qsqq0Tr6cA9
X-Gm-Gg: ATEYQzxJyszkzH2RtWJbx9EReyaYSuWz3jBru2MAqif2j9+2fg0/kpagYL+Dm5mScS2
	Es0icobCtwY98FN72SPKseD2euZttB5SlH5Dc9zk2aB6nkGd9k2OCVFqBknMoXyjg863fb+Gocn
	Vqg/xTJuzYtOfhZtqQkBW6fqJJ4oKlwyNdyc/x7i5ZQ4vHS8uQfIWdHKvaDZa6DObvSMH8O83r1
	XYPoEiQhsagmOG5tnLg4g/rsIRFaAxzUmr1hkOJRLCzfM+MR6drfCkCrReJboDpjDBEWM5CXg8z
	4nfLwNT8iIrIf0EjAI7+utYRfGvxXPbWTVLODheIs0CSgFjAKX1FNJffNi492YfwzSvAnLN3RAA
	RaCjvysWjdLWlqsCmxFPaFmhAESSRHx6qhHObXYEhWBqIxhj/w/Cr5/PvqmBl9E6AZwUisz/OLs
	52OYGNmfIcTzSdeSgV6WxSdH0uWGXlphzlGo2p4pe7wBgOPmZzJg==
X-Received: by 2002:a05:620a:a50d:b0:8cf:d1fa:7b3d with SMTP id af79cd13be357-8cfd1fa7c8amr263080485a.10.1774029538860;
        Fri, 20 Mar 2026 10:58:58 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc90e776dsm244807285a.47.2026.03.20.10.58.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 10:58:57 -0700 (PDT)
Message-ID: <f0ece061-13a2-49c8-b4b8-ab57c70952c4@gmail.com>
Date: Fri, 20 Mar 2026 10:58:54 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.19 000/379] 6.19.9-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260318122547.233850204@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260318122547.233850204@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_FROM(0.00)[bounces-227600-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ffainelli@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.925];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B83102DF053
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/18/26 05:28, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.19.9 release.
> There are 379 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 20 Mar 2026 12:24:39 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.19.9-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Same issue as previously reported in 6.19.8-rc1, commit 56111d7a464 
("perf jevents: Handle deleted JSONS in out of source builds") causes 
the following build failure:

cp: cannot stat 
'pmu-events/arch/arm64/freescale/imx8mm/sys/metrics.json': No such file 
or directory
make[5]: *** [pmu-events/Build:44: 
/local/users/fainelli/buildroot/output/arm64/build/linux-custom/tools/perf/pmu-events/arch/arm64/freescale/imx8mm/sys/metrics.json] 
Error 1
make[5]: *** Waiting for unfinished jobs....
-- 
Florian

