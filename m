Return-Path: <stable+bounces-214405-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDUvIU9IhGk/2QMAu9opvQ
	(envelope-from <stable+bounces-214405-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 08:35:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E73D5EF770
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 08:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F5883014654
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 07:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40073356A30;
	Thu,  5 Feb 2026 07:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="PT0cKKWN"
X-Original-To: stable@vger.kernel.org
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBE431B11E
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 07:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770276878; cv=none; b=nbtBh+/bjO2q1oOFUO5ogN7vEf6srgFmaMYzsqQWgeQeSG6GWFJgU38p0gTMXH1NJnukcyrbBUaij4u3MaHWSfVyEQ2RBhMn4sj6+4ECSNbkyRCNo1zLPsk5UarBL5EC8EM8G8ftN0oE4H4OVC2h49eJqbQdAfG8mMKQ5OqOoHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770276878; c=relaxed/simple;
	bh=0zjVYBoQPtQ1txu5iltn5GIOXQfuwncEJMvjBs8PUrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sqQchtqsX/VEhfO/87bXDUyFgObA8quX897XRLSxA5mztNAhjav/R+y88K+WyuM8oDG4HD/sltQyhXNPK6vCfbvHnJd6BWOgxlvUsjjmNGbapymlFbW8+nQ4GQX4wIsVvAbgGzfohfWerlk7JxtAzq3ZZSEu0q1xun423pILwew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=PT0cKKWN; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6004b.ext.cloudfilter.net ([10.0.30.210])
	by cmsmtp with ESMTPS
	id noTYvRjZ9CxrGntsqvXQaq; Thu, 05 Feb 2026 07:34:36 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id ntspvXuqlK8vzntspvg7x1; Thu, 05 Feb 2026 07:34:36 +0000
X-Authority-Analysis: v=2.4 cv=cJDgskeN c=1 sm=1 tr=0 ts=6984480c
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qDPJzqd3ahirEYLJiIkMdaPwf95xn2ZVT+tPnLRxOKY=; b=PT0cKKWNZGjZpLdtHTHQJy8ZPL
	5FRY6iPSNA70j3vxwKueoIb9wctFDtmL/beBDMr8cvWr+wsPR9pv60WaOVr820tctlzVt5lelj4u3
	TeWlLx1MoZ9C5grmdx6hXoGc7tpHpo1hBrXq4SmtpN14xa1UdjwiWclKKz/9LIjWy1qJIGXIylf3p
	sqeIZBpOC25YbKRjsrPMFQRpEeGEgIbTe5VQH0cRvtnNbxIl8LcaA5xQO2xKIbj9x4GbxIrQyWmll
	PK3Q1inmznFM3qSgHQetDfZfjsipZ6letjkSHmL76mf2KfmMEL/36Zsjdj9jQ3VHFX/NHLKZW0PF0
	05BKD2cQ==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:33456 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <re@w6rz.net>)
	id 1vntsp-00000004FEH-1St5;
	Thu, 05 Feb 2026 00:34:35 -0700
Message-ID: <0ba223e1-04e7-4374-9d62-643b3b43ed70@w6rz.net>
Date: Wed, 4 Feb 2026 23:34:33 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/122] 6.18.9-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260204143851.857060534@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20260204143851.857060534@linuxfoundation.org>
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
X-Exim-ID: 1vntsp-00000004FEH-1St5
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:33456
X-Source-Auth: re@w6rz.net
X-Email-Count: 19
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfEE6NeplWTnXApj3aX1tGKkkCmZ8fMSNw21j5XgltCdQpQyPdfrgGndR9ioOnEv3PnuhD/R0oh3cAX/99CE0v55T/2enFOwFISUWhlhv/hcQHZWPKliJ
 dZ7swJxHzCndGVSP7KWwBV5LI33MlpvGt0q0j7Xed+RBxvfuA9WTlGt1hydnKX5RGWuCYP8f5G82FA==
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
	TAGGED_FROM(0.00)[bounces-214405-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[w6rz.net];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,denx.de,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_X_SOURCE(0.00)[];
	HAS_X_ANTIABUSE(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[re@w6rz.net,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[w6rz.net:-];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,w6rz.net:mid,w6rz.net:email]
X-Rspamd-Queue-Id: E73D5EF770
X-Rspamd-Action: no action

On 2/4/26 06:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.9 release.
> There are 122 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 06 Feb 2026 14:38:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.9-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


