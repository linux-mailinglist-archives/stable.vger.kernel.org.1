Return-Path: <stable+bounces-248909-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLL/A/CAB2qQ5gIAu9opvQ
	(envelope-from <stable+bounces-248909-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 22:24:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AAADF557657
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 22:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 172B1300A335
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 20:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280CC413D80;
	Fri, 15 May 2026 20:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCeMrfSQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4C0392C28
	for <stable@vger.kernel.org>; Fri, 15 May 2026 20:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778876653; cv=none; b=nCS/gnHLTFwA+66FqtraYEBbRlg+W3Yk0xgPIXMyu+TmjIyktt/naVgJ9PEz6WypCVBFLlfDbxi1MMkiebY/AGA/F8eF52q3RBctIG2vyVEOcbeXViYSnAleoR2iaemaoTLbrFel51HzN9VxXqwZRNlw23/Nj+KNARLddTI0KEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778876653; c=relaxed/simple;
	bh=2EfSqqEG3Fz2+psCHccxGbWRmL3fAYGdlfh0z5C/l8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C0OLUB23IFhjFeGkAOPBdqUPQoJqTUi8lYbiHblmGuxaEWKmNOn0YNq+YdIuLOSjJ0JNxJTcX+ZEFYyy/Be4IJHR93nYmIpvLOmprbD3yGrWKMhHXn0gAbUXq/tImhxJ+DNP90e+pY8NuwNelaM1XkxUocfTQj/02xL6LEpopuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OCeMrfSQ; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8c7154725easo3089756d6.0
        for <stable@vger.kernel.org>; Fri, 15 May 2026 13:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778876652; x=1779481452; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5iTrJvmIZEOAFJlzqY6SOA6UlAvDU1qENTjhrg7LHv8=;
        b=OCeMrfSQmTplsyj0cYGaNwRI827FlF2WySxBBrC+25n3T6CFOnaytGbIjaVekEqjIl
         +xCQ1uJLBydtmQa9BhyOeHhpFsx6YSfYMroO6Sk8yq7z1PqTRezZYLt1MaIuTOwOyMvy
         oNJH/ZI6UM3s4w4s9vDVFbtWmWr/ztabx7sbRZGFSnB6faXLKTSqvaKEgSp2Iv78SnRx
         D8IqgTKEH9jD1Pk6ncgyXk5NO5J8U+fWEsHgD53QFaYEAYE0JwqoclTSbZz0PkIDbycd
         TGzEvnhYjtJ5E4aBmDpO8h5LiiIlLzHSng8ewsVrrmsCpefv0VNOkvKwGvIT4Ly3Igr8
         /IAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778876652; x=1779481452;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5iTrJvmIZEOAFJlzqY6SOA6UlAvDU1qENTjhrg7LHv8=;
        b=cRhRp/Ri7pXvF5sYS0mSdHBEtUwblbbMaZALG6E1MeSD+p1AEUpdN6qmgT3djhY+Os
         UUeM1isrQsaPPseiRks8M0+kZt0pczhPmKeNhN7uOR+FmMKSgxdkyauyWOg0bajJ6xPX
         oQyjuFA0bUGINKxhPccQjvka6pW1gfsuU9tZTt20MTxgwge78m8fK1dqRUa3GtRNFX+S
         BETYt+MB53ZlsuL0ipx5vu++YJ5ctA7P3oaPigdLGbU2o5NF6XjylmECdi5RG6Sqvy9Y
         0rNV2CT7LQnj/Dsju7ozP6+RWPtVYlueGMOoxMSeml5J8NIRtRGz2v9trewaEnGAKTiX
         ekkA==
X-Forwarded-Encrypted: i=1; AFNElJ/qZSc0dESc1DF/HmqlXBEOYUyd7zabgnI+A1XjWdyq70dG8KlT+3GXS4yxSTqvxb0cFBGNMeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVVyBbFSFQo4J1exQUkw9Hqd7rrJ/4yXbg3DUanXgKixm7IQr3
	tSQXCSkICCVp0Tk8EoiZTI5Zf7IpOFClhf4CA3NGEug32D4YtT4UjXSt
X-Gm-Gg: Acq92OH2RCPZ7CYscSJewmRzM7rbXJdeOh+hs2G1FPLsn/esFzohpFQLzxLectcXb4N
	QGxTdB4PvqNR6nCTKi7l70dXywnp57VZtfG0DX92N640+VaQ9UGeD0Aj6fmgE1l7qit+qsObRXh
	MG9TGodezyLBGUzWgdT+yvdnXhmUNggaFosDBFQbwSqSLLtNvhhZ1IA+ZDkm/d1UErpHtr7bC0o
	Pcq5vzUw0aKCzLY9fq1kyWUAamtv9sGrerwga3oqA/9NPloijY6g81sGakWa/+fKdKJ5IOr2zvz
	pJZryIG0m0XG5IGklZ5zk8siMsoP/riACvBoNI1xLP5Wf0o14nQctm22xbJrp7NNsDjdR80Ogjw
	7hushJockVIK/Zx2yy5nq9N/xLoBoyU/3SPh9EwxfmGKt5+68QZy9YBCFLeTwfCXH6xi3QUKwf1
	x+Yn1cfAEROUZSuQqfAKU+pQzxC4OOO3VY24zpwSgG6uj5JBlXK9SGSLS3Wcb0
X-Received: by 2002:a05:6214:4521:b0:8b0:3904:596e with SMTP id 6a1803df08f44-8ca0f69e77fmr95208156d6.25.1778876651591;
        Fri, 15 May 2026 13:24:11 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90b3d0bdbsm60408486d6.24.2026.05.15.13.24.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 13:24:10 -0700 (PDT)
Message-ID: <45bce069-654c-4970-ad54-f07e6f649846@gmail.com>
Date: Fri, 15 May 2026 13:24:08 -0700
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
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260515154657.309489048@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260515154657.309489048@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: AAADF557657
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-248909-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/15/26 08:46, Greg Kroah-Hartman wrote:
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

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

