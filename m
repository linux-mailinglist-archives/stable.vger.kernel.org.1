Return-Path: <stable+bounces-215593-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCYpE5qfimniMQAAu9opvQ
	(envelope-from <stable+bounces-215593-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 04:01:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E98D1116A1E
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 04:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 59200300D4D3
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 03:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8406278161;
	Tue, 10 Feb 2026 03:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4Ur/vS3"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CD823BF91
	for <stable@vger.kernel.org>; Tue, 10 Feb 2026 03:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770692501; cv=none; b=N0UXbHw2CqJykwejHWAoLNm0e/QHa4DWFtxze6YJl+mh1imnOw2qkN0SIrXNaPiTnvF/wVs04inu1PTw8Y/VdkeKdGA3EOnS2fXGINRy4HkHOXsrkvqt4hUBU8GvAWknxsehphEyV4CfkU4nY063sjP1KNFdZKSRXcQyYczGuNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770692501; c=relaxed/simple;
	bh=kzYAHJMQFuP5XlBe987OzNYxqmo2rmucgvzJ1A+Zcf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n9PbSfBozl+g9kGMu+z/O763ZRh4XyvHUzlRj7IYz8+M602tnxo3KydReY/DWkPSR8d0KWFPHMaRIF/TtFDQcgRW68I3ru7TvSoeOo2npE5Us1NP59v5DTjOpxhLs35SPq/9bPMkgKzm+9Zdw7qkm/H8DHxXfhdQY6zy1wkLyp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4Ur/vS3; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-126ea4e9694so4228597c88.1
        for <stable@vger.kernel.org>; Mon, 09 Feb 2026 19:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770692499; x=1771297299; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uh4hL2hmMpxCHLYEr45X+FcngLLc9iD1ju5Dym3O4Wk=;
        b=m4Ur/vS3NRwh7Laoh875F/IjAei88fXVu/tjziIXUvbKcfr75plyuLvbqy4s4F05Te
         gM2+JRJvIWrPThsgnM65lPyAXnlIBOD659BjeqViUCFLllmbuBicTfHUL5antQnayKbU
         F6KqI2KMayeqbLyaMUGd1qQxYPo7c6zj7C6UDtglCY3cUuWxWYQQRAba81DSMmkNcF06
         3rBywJr2+nOBXYDwQTnVDc1/vr0bKD4rQJCRmN2DfrorFugpGtevhbzt9a2LQYMCwEjH
         XOjh67WYiD+fXkkh+S4I+GLdI9583FPg8mowVk+KioGbo6YGTv9AW3K8qJiWc8aRK1UZ
         gybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770692499; x=1771297299;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uh4hL2hmMpxCHLYEr45X+FcngLLc9iD1ju5Dym3O4Wk=;
        b=QUT2E9jAKwFQehXpvpTA7T61mfAM6FUdW5l/LqlTij5j7j4qTroYlsQyKkDQikDyzU
         xlBveM2UGHxTTAAOFtC88aNQnMiQ4Vs5U9hP3iNhMTT0EZQZ5fjynr8512ynLU8FyZUc
         LnnhYnDCYiH3/0wDh3b2BATYIqXMKHC+/5V7ga2L+WuW5nR2wn+yZK0+i8F6/FI0+YIW
         IsooYqHWlCR+jLJJLOBSM6WnubZNGdgxJ2ErXigbshC51jAKbhGE4sEVQY6lF9IPkQE3
         I1wcAsWW5u1z960gjt3Giovv08eNWuzjuOdursOfcNrah/tRUwML2YzAjg1CBkGIUzkG
         utqg==
X-Forwarded-Encrypted: i=1; AJvYcCXg1ujpcM7ypOsTYdZ4xhLSLk+2eU4qYhhig8RTOk/2r3MWfr1wYbX0reyoV8bC1RkslHznRLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY0iIa7xewq5YK7ApvWmYnn/AKlEmpFoj2L4nN+olNMEioZckh
	P5bsRj2B+9AYzQmDUVYC4RVJeStCTF9dembJ6Fg6Q93wOWyBlxrAm/O0
X-Gm-Gg: AZuq6aL5c5iixzivubTbmPXRcmWe7+jn1LWGY3Ao5sPM3aih+rMc28CHCdpbQLICyu+
	dOKs619gKodCklRs4ew1rYiEUsba6/tWeDl2Q7ab7bJeGdlPFQrB7F8KyVU6aMWO8BnFyioAEAz
	cmtIodn0lktLL3/5hgcLp7Jj3u+FORQ/eMDsibCIypc45DA/dCpt8GW+r1dkBq13bcnviUo42x2
	8CUBeHCaEAD+9K5aFB+s8Poy84xAddnydmlBtdlqAu/7erGgfXVeqb/w/vQ4i5KTVx5Zul/yaDU
	m6L9owgEz4K7Jm05zQTA4HzAsFj9KGt8CueAbE3N3xLpLXFlYbrgxe/hGOaoJJwIkNkJ1Q1LSxA
	jqnLZUbmt84Eh2Lu4ZdqtuH4tY9embxpnZsw9YHYanB8iYCgT1G1AMAN9iySBbN1krf6ycJlyKz
	LBAluIghIzVVIk3Cs7PuLZ5oS8NOJnf3zlRccYFTe3lGEa3TcNFbUaKqIW8gmLN2GX
X-Received: by 2002:a05:7022:fa9:b0:119:e56b:957b with SMTP id a92af1059eb24-12724285c4bmr365732c88.0.1770692499401;
        Mon, 09 Feb 2026 19:01:39 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba81eab184sm1537855eec.1.2026.02.09.19.01.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 19:01:38 -0800 (PST)
Message-ID: <ff946aad-325e-4c56-96ed-cc7c991bf227@gmail.com>
Date: Mon, 9 Feb 2026 19:01:36 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 00/41] 5.10.250-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260209142256.797267956@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260209142256.797267956@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-215593-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Queue-Id: E98D1116A1E
X-Rspamd-Action: no action



On 2/9/2026 6:24 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.250 release.
> There are 41 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 11 Feb 2026 14:22:44 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.250-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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


