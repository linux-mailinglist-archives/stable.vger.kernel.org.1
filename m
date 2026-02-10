Return-Path: <stable+bounces-215638-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIROJpMDi2kMPQAAu9opvQ
	(envelope-from <stable+bounces-215638-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 11:08:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C86191196DE
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 11:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7758930116AF
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 10:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D39F3431E6;
	Tue, 10 Feb 2026 10:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="CprmzF1S"
X-Original-To: stable@vger.kernel.org
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E60347BA5
	for <stable@vger.kernel.org>; Tue, 10 Feb 2026 10:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770718052; cv=none; b=Oey0gsVKhSGbMfHfbwp6nVMU8+O38zt+Fd0FPMvRM4fOWN+ZEJH3H+4ZdCSP4r6SBqOUeMK7C6ooP9x6KCnN6xj1xuZeozeIO+Zb9pejKoVuAY7wSLHnrYy9t8YYWyWzcS6K6CeniZAvF0Cx/ISK+P4uBMfqsHRa4beVc0NdR78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770718052; c=relaxed/simple;
	bh=swbo/Sf54WOt1r7kLvsMt0x+7Lm9qiFagtDXc2yxkOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LZsJBoeTdzkLfos5l4rMhvhAjL1+gfslmJormfspOkVvVQrELrWDnlxq3k3AmAkJrPl7oWEPiHlHRzmlByXqOXnce/D28k/y7KygYM2ktSpdLOjUIPQMYWQAoELdRspX5sVYlr0/RggFQ8BEKxoqYr/AbxQDOd/+9KjOLa8/z2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=CprmzF1S; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5004b.ext.cloudfilter.net ([10.0.29.208])
	by cmsmtp with ESMTPS
	id peb1vRdbsKjfopkeYvVgXE; Tue, 10 Feb 2026 10:07:30 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id pkeYvaq26qfpWpkeYvcgE1; Tue, 10 Feb 2026 10:07:30 +0000
X-Authority-Analysis: v=2.4 cv=A55sP7WG c=1 sm=1 tr=0 ts=698b0362
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=-Qcm0AZxhyoZnww38z8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SRJEKlgf1cU8u7kDgnrAbTXG2Eipl6g3LX3Q0whDiAk=; b=CprmzF1SlTN2TWExz1yYUvPO1B
	WbCSBnXc0LfK6FXzgvMatFDecj+4Ku2yhp9WNP3+IliSxAyWmZ5bjLMWmWPB38tm+8ujNFt30buCn
	aG8CgUD/N8bCpuxGhCdwNAzhP6c/RYAxyONpn/qMc6EOQi8DLiMyhYb2FP2LR2C1qhA8SxP5fioRY
	qxOf/zuhhB68US/2klfhX515+x6v5Z+UzXSoX0wd2BvI6L1VOox/IFbI0idHMWuk4+Cqf/HrnR+YC
	AwHqWLTw1kKMIXvelUjCoM3+UeOzUUwv2CVOHF4s/FgMtBf5+vk7bq/s/sbft4NAoyatRDlahCOK6
	/eQTqaEQ==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:52582 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <re@w6rz.net>)
	id 1vpkeX-00000000pLb-2Zfh;
	Tue, 10 Feb 2026 03:07:29 -0700
Message-ID: <0fefff6f-127a-4be8-a479-fc52b6e1d590@w6rz.net>
Date: Tue, 10 Feb 2026 02:07:27 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/75] 5.15.200-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260209142301.830618238@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20260209142301.830618238@linuxfoundation.org>
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
X-Exim-ID: 1vpkeX-00000000pLb-2Zfh
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:52582
X-Source-Auth: re@w6rz.net
X-Email-Count: 24
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGPO81KgHBUs6Bqk9GmsYMFTZ/XWcEgaOcMK6k/168xZ848VObyDWB7zd3XAr8hPH/h+IR1RloFywJgCenORCoK8OPla3hdtv9XSw5rNIwQskGLI143p
 Ac3DlCAx8sFubffV5EbGG/jufhG1pOLJugJ5/e9E1B5wynuRBCNizMv5ovdajhvywCTCsOA0i8ClXw==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[w6rz.net:s=default];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-215638-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[w6rz.net];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	HAS_X_ANTIABUSE(0.00)[];
	DKIM_TRACE(0.00)[w6rz.net:-];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[re@w6rz.net,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	HAS_X_SOURCE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,w6rz.net:mid]
X-Rspamd-Queue-Id: C86191196DE
X-Rspamd-Action: no action

On 2/9/26 06:23, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.200 release.
> There are 75 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 11 Feb 2026 14:22:44 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.200-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

There's a build warning on RISC-V.

arch/riscv/kernel/probes/uprobes.c: In function 'arch_uprobe_copy_ixol':
arch/riscv/kernel/probes/uprobes.c:164:23: warning: unused variable 'start' [-Wunused-variable]
   164 |         unsigned long start = (unsigned long)dst;
       |                       ^~~~~

I've sent a fixup patch.

https://lore.kernel.org/lkml/20260210100148.3674334-1-re@w6rz.net/T/#u


