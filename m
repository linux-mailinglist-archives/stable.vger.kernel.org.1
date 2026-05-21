Return-Path: <stable+bounces-253647-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLPnK92cD2rBNwYAu9opvQ
	(envelope-from <stable+bounces-253647-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 02:01:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEAF5AD312
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 02:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C26593037885
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 23:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9733A453B;
	Thu, 21 May 2026 23:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="vFMWU/Tq"
X-Original-To: stable@vger.kernel.org
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA34739EF1C
	for <stable@vger.kernel.org>; Thu, 21 May 2026 23:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779407532; cv=none; b=oPpxUj/ux9XElL7E8dQEZLft0owlsf0vcBvYpfE+2J2sOzJLGG8EfSIiCu9yT0Ne2Bumxbeb/8P+mguyLj0+Jt0c3iiW3A5luyhSWGrrmaKe0zRNWFNkCUjAf67EAbVEj7JYYkDjlZUEYqw20NPiFA6CEAk7CjRokcR4a4Ihef8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779407532; c=relaxed/simple;
	bh=5ORcsWI+/o59l2MeWQuQT+6CSuAIRccqf8+EhkqYgrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hpa6hJFf7nXiRO6WLoEhuolvkeLSdgt0uTBnAj68bWfAODWe/kOyJDH71RmTPjeOH50Fd0NuDb5sEPuTYzKii0qf60GwvaDrcs37ehZkPnIdkfnpTmUEecAkC61n6JAUO9GueDaExMc/tpwIwUMXpApfrq4Dy1zkRA12sE4ZzUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=vFMWU/Tq; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5004b.ext.cloudfilter.net ([10.0.29.208])
	by cmsmtp with ESMTPS
	id Q2yiwPRfQjgweQDBEwhI6n; Thu, 21 May 2026 23:51:56 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id QDBDwFtT5nfJUQDBDwAHWw; Thu, 21 May 2026 23:51:55 +0000
X-Authority-Analysis: v=2.4 cv=KajSsRYD c=1 sm=1 tr=0 ts=6a0f9a9b
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=D5Foq0rKzPGK6zS8BC8A:9 a=QEXdDO2ut3YA:10 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/VmwogYc8DQ9QSp5NC0pd4a7yFKP3ImNYVPoNre9uhM=; b=vFMWU/Tqf49bT+71vaJ3wTagSP
	91sDAG4KQ6nFYOEsC1Wt9C8T3GiPpb9vYOuOAB61+wc58XWAoNPOjBV3/GNriG2YWJyVJeUBjYL0G
	iwoa5LcOJKGawPBBxpDhw5BBNb2VI+SBKbE9i0crgdnyp+RvlJ8Fh7yu5w1dNRah8+ocgZi2bSMPq
	h5QT2HvdHn35zjsStwuw1kNsOz90hcl5FN9hopQYZNnJ0HGBtFvHixoOn1gHoGRZgsMydyUW8RRq8
	azM+CzOAmPeCgYHdL2mxgZ2pTlvWAgM/aiRdKNqnqogGms1NYNpuX9ngpKFmPZmO9dXT+WB93PKpD
	pL0fhqCg==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:54898 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.2)
	(envelope-from <re@w6rz.net>)
	id 1wQDBC-00000001xo3-28mN;
	Thu, 21 May 2026 17:51:54 -0600
Message-ID: <a605b3c6-99e9-4cef-b93a-ad4d272ba809@w6rz.net>
Date: Thu, 21 May 2026 16:51:52 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/666] 6.12.91-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260520162111.222830634@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
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
X-Exim-ID: 1wQDBC-00000001xo3-28mN
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:54898
X-Source-Auth: re@w6rz.net
X-Email-Count: 19
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDLGNmuaAf4FVDLSCFBeMBjmO35Aga7RRyTLXIoIx8qpu95Qnmokr9SbEZHqVMaX0hv4Rh1yUo/RgsX3EIv3OduXlUKRV8WqzODH8dYsR/ZTxnTcMjqn
 MMwViiL1W2rJ6yfvtLI7Y+WQeWQoyvCF6ij4C4jQ50t8NgEvVrVb8PSKsDjSsvm8T9QJWBjhn3hFpQ==
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[w6rz.net:s=default];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253647-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.977];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,w6rz.net:mid]
X-Rspamd-Queue-Id: 0FEAF5AD312
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/20/26 09:13, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.91 release.
> There are 666 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 22 May 2026 16:20:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.91-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
The build fails on RISC-V RV64. Reverting commit "
bpf, riscv: Remove redundant bpf_flush_icache() after pack allocator finalize
" commit id fcbec4603139755942d21547774a6b6b390368f3 resolves the issue.

