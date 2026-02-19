Return-Path: <stable+bounces-217393-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yA3HDQiwlmmejgIAu9opvQ
	(envelope-from <stable+bounces-217393-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 07:39:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E1715C68A
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 07:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28CAC301FA72
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 06:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB4D2F5491;
	Thu, 19 Feb 2026 06:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="iFc1XJxV"
X-Original-To: stable@vger.kernel.org
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438E82EDD40
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 06:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771483141; cv=none; b=IP2pD9K2StD2jeyMH0EyOD54dzgfeHgqNIaOBw8lDLG+5tYzWGl+uJyF+eaHbCt2xSsaXHESlg7S9ZCxOAQIgEjNCfRhjZ5/1QXTexE5PdRCo66CehZMIqIOswzINjNTDpKUUi2XQoX2Ig+bjBn6S8AVCmGvUkf1kMcmV4lVxmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771483141; c=relaxed/simple;
	bh=QgRSWQsSi+qoGC8ouxds55+Fn6GqsoZzXhNs94d+cvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jp9WyVe2PB6fCSNOSMJbcWuXegG46AM9cFgxi9YAZt3OsJT5InlQ9tjdPc6727kLig5PeCzJnWitNuCLW0JALXQYdma+eakbnOgbp6HfBG6YY+IY9NCyylE4LTzm39xCrbrxKqwm1fF0QCth9F9LICHUPFZKYcVrptKIOKsi/Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=iFc1XJxV; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5005b.ext.cloudfilter.net ([10.0.29.189])
	by cmsmtp with ESMTPS
	id sjIvv1XJAaPqLsxghv4b0d; Thu, 19 Feb 2026 06:39:00 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id sxggvuaOujAxusxggvbCtf; Thu, 19 Feb 2026 06:38:59 +0000
X-Authority-Analysis: v=2.4 cv=EoDSrTcA c=1 sm=1 tr=0 ts=6996b003
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=x6Ducos6UYMGwXt6jLcA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8zFJbNiivv0Qq2HFUonDWYQr7YxHWf8EDQUuAxab42s=; b=iFc1XJxVTqTb5JbfnE72DZqfRd
	5NTJX26DVSercO/Z2RGzmiOy0BRVPzcuBcey4s/5LXErEmeodFTrsmuL1Y6ME74yTXvsANrUL0Kk1
	x66/IhpC/KaQCIssK4qlYfseqhgCIEMZ40NuEtJeep0n5yWmDSAUMlzhPWmu5GdqihfdD88dkoyc0
	NuxD2ZBfsWNf5id5XJ5mqy5s4buzFtODzU5+JBx1ioM8MnD+0QAtyxjIF7AtjUIabCNPXKTzVkNWC
	C2hzYJcjB1VkuT6j6aC1jL2I9TzAtC7+BQaaU9Gt/9juDmYeGR+YnFY7+i1uWxWlv7kJg58UduGEz
	xfuPiH1A==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:44772 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <re@w6rz.net>)
	id 1vsxgg-00000002CL4-0gT5;
	Wed, 18 Feb 2026 23:38:58 -0700
Message-ID: <f7775877-fd12-43fb-aabd-65ee13d8e379@w6rz.net>
Date: Wed, 18 Feb 2026 22:38:56 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/39] 6.6.127-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260217200004.221651386@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20260217200004.221651386@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.162.206.103
X-Source-L: No
X-Exim-ID: 1vsxgg-00000002CL4-0gT5
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:44772
X-Source-Auth: re@w6rz.net
X-Email-Count: 79
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfF2VDn+StrBoX0yKHJ0UlDcg3t4fR84rTPOO8ExXo/XqWxrs5EM0Wp2JnN8JCbkmt2x4Ko/5IwSENi8gD7F//kRUO26xv+4mB7LqcFSl2UQgROZVrlha
 4NnTxSjPtvOQ0KTb9ehHX+wVXrasZbhc9R7TNmPPQerQBVHFrOIsRokVfxiXZA7YRujO+jREOpa58Q==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[w6rz.net:s=default];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217393-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[w6rz.net:mid,w6rz.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A6E1715C68A
X-Rspamd-Action: no action

On 2/17/26 12:30, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.127 release.
> There are 39 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 19 Feb 2026 19:59:50 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.127-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


