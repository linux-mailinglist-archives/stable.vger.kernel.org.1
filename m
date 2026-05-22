Return-Path: <stable+bounces-253654-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HKqHuqlD2ocOQYAu9opvQ
	(envelope-from <stable+bounces-253654-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 02:40:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 014A25AD838
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 02:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17D3B3015E0E
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 00:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0DD268690;
	Fri, 22 May 2026 00:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="rPe6xsc0"
X-Original-To: stable@vger.kernel.org
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FFC25B0B1
	for <stable@vger.kernel.org>; Fri, 22 May 2026 00:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779410351; cv=none; b=n+U4acCq9KARIZEzVedrt3FxMcDRtzTj8IhRgFnBGx8rjb1zuSu66RhajN7rKwW00Hu1NVlv8mvKc46+preuKqV23Davf5/s2FqQ3wl+TJPoojWGhho2EIx9WAJjKPxH4FxBW5Agkc9UURY81genx82eyEM52K+V90WuWD/5DBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779410351; c=relaxed/simple;
	bh=HA0lu46TPZkkKyX7gL71eZEUPNP1Cnh1kYY9gb0Umxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H4cmIxJOMspQ4NzW4Aaj9I1V8f19h8B3EbpxPErjVrS6bl+0xBW8lFF3Myynt8CsIx2UucPcePSvaVHykoqHRsj5/ETKJGErslarnhvPfMZHhiwZDppMCNazPbreckJdaaE/4a7n2LQBR5uXp+Xfk8XwDjOzKq2yy8Uq3ZK0N1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=rPe6xsc0; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5001b.ext.cloudfilter.net ([10.0.29.181])
	by cmsmtp with ESMTPS
	id QArswwPtbKSRRQDupw1Mqv; Fri, 22 May 2026 00:39:03 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id QDuowHx7v5zk0QDupwxbDC; Fri, 22 May 2026 00:39:03 +0000
X-Authority-Analysis: v=2.4 cv=GPEIEvNK c=1 sm=1 tr=0 ts=6a0fa5a7
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=6DW0G_7JeFXAdJWxO3IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dpYSrg3MI3RkOBwNTlhXUYyExx5Ub41YxFB9OiwpRDk=; b=rPe6xsc0v3juKhz5SZE+MOPDfY
	zeJrcWSECQrBvKtO9CuHkonmVDnCGub2f5IMlgnWfgl8IBo7fEe5Lp/F3MgVR5HYoBsPr+XAusEV5
	45WEgPhhD8lSBt/BsAACQagBzESMBIj45K4DAJ2WYXJC4emgo3wBxMj3EfO8uPPrlysyjs8aTIdWM
	y6wH6s/xflKFICk0NngLJmZtWLgxFB0KNy5h9x8zG6SXuZ4GZYU3zY+9AzWmmPJUT1LGOhRSJA5Fp
	RTMugnIWBTkNKo35Ut+T6TS+TBJsNHkULkPGmrIrRqfVX8AHepFxIlYbmowd+07sMRAywp2krkpxn
	0K8eHm/g==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:55894 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.2)
	(envelope-from <re@w6rz.net>)
	id 1wQDun-00000002O38-3Cxx;
	Thu, 21 May 2026 18:39:01 -0600
Message-ID: <1e000a3f-33ff-4352-b864-22b5fd77aa7d@w6rz.net>
Date: Thu, 21 May 2026 17:38:57 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/508] 6.6.141-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260520162058.573354582@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20260520162058.573354582@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.162.206.103
X-Source-L: No
X-Exim-ID: 1wQDun-00000002O38-3Cxx
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:55894
X-Source-Auth: re@w6rz.net
X-Email-Count: 19
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLGZHI9AyTEy0bbrtMmvXo4O/y2ZO+htyLCTP6Q/FOOrMtAnlt6oabYMIgi/WpxbKwPm1jI2wHLJpl86+mxaCe6PzrkEzXxlw+QApp3KxJhQfS6iopiD
 1yxSXpHGFBi1a2Sltpw1xHzGMaXuONhSzeL7M4NWaFbzirzT+FHA8MqHa/ufO5b2vPrkzzDsr677cA==
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[w6rz.net:s=default];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253654-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[w6rz.net];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_X_SOURCE(0.00)[];
	HAS_X_ANTIABUSE(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[re@w6rz.net,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[w6rz.net:-];
	NEURAL_HAM(-0.00)[-0.975];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,w6rz.net:mid]
X-Rspamd-Queue-Id: 014A25AD838
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/20/26 09:17, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.141 release.
> There are 508 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 22 May 2026 16:20:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.141-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The build fails on RISC-V RV64 with:

arch/riscv/net/bpf_jit_comp64.c: In function 'arch_prepare_bpf_trampoline':
arch/riscv/net/bpf_jit_comp64.c:1064:9: error: implicit declaration of function 'bpf_flush_icache' [-Wimplicit-function-declaration]
  1064 |         bpf_flush_icache(ctx.insns, ctx.insns + ctx.ninsns);
       |         ^~~~~~~~~~~~~~~~

Reverting commit "bpf, riscv: Remove redundant bpf_flush_icache() after pack allocator finalize" commit id 
af7b502c916a4950d697b67f5e39c19cfeb5da4b resolves the issue.


