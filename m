Return-Path: <stable+bounces-237833-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLObIKIq3mmSoQkAu9opvQ
	(envelope-from <stable+bounces-237833-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 13:53:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 271E63F9A0F
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 13:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A218301A7D4
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 11:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2603F3D5640;
	Tue, 14 Apr 2026 11:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="Z0rb9OEW"
X-Original-To: stable@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE727330D28
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 11:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776167361; cv=none; b=Vsy5dqu9y5VKfli+LcIqZeLIz+kkJRxAKe+5dkSzyfwsKFQ0lR3yHfLJHZO6tzUgoM+7u7jMGNvlvR1hPqXJ3SBI5wpksmjn5iTL1KCoS2tAzojx5sqMw74NXkTZABJC6IILonQDnN130R1wkVyg6cLO/Xx2Nnbtr8UKH3VY/do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776167361; c=relaxed/simple;
	bh=delSIIv2LXMuzU0y4BSnjK8jV2/iRKoNDVaAKcFiia4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uIBsVT8ECJEVnD85qcYrle6OBvmKC3iZCc+egCqgiqy7Gym883sV2NjKHwX3tBPbDBbX+6Ypdl5J2HQK3QqdFUbPCVFszBq9vdVbmVXlmrR1HAu1uvlj7YM3MvfW564oPQJ7Ey4GyhzoOYIgkqXoWp0sm18wefCISBEdqRe6HKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=Z0rb9OEW; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6007b.ext.cloudfilter.net ([10.0.30.166])
	by cmsmtp with ESMTPS
	id CPK8wgKDkObRfCcGewTlae; Tue, 14 Apr 2026 11:49:20 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id CcGdwVnde36heCcGdwA0Ij; Tue, 14 Apr 2026 11:49:19 +0000
X-Authority-Analysis: v=2.4 cv=PN8P+eqC c=1 sm=1 tr=0 ts=69de29bf
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wTSOS8ADXbxipXR1RSbIPgpwLNZb94otAdTU+dlNjpA=; b=Z0rb9OEWlt1fzHbIxyTjJocT39
	8bA3T7aDqmWMzePcSwt+Zs66lRTw4MkWsnGBOcyHBIx7iQpnKeqPrlI2uUzeonkMYx+1C6z8D9DHM
	YnUhiCGXnG3GESBGa3vYdzOHO3XXG8TTzFVzJf9FEzGOPr6uw5qrtn0GrljoUwcU9wVZzHyRqbbIL
	BU9m5indvnhUtGwcxeIZEACaRoBd8dzSpFjoL9ZErESdQoWrWWIFaD6IROYzw869la3Z2nmOqVreg
	mHfrTXBHTHDw5BzJQZ3tlsXbHoNb1+plKPocG42W9RxUVnjReQztfUsbZHm6Kh0hsUAaDuBDj2E2R
	EZCvsbEw==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:58892 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <re@w6rz.net>)
	id 1wCcGd-00000002mVQ-02O7;
	Tue, 14 Apr 2026 05:49:19 -0600
Message-ID: <29dfc2bc-d940-4afc-8a3b-7046da4d2ac5@w6rz.net>
Date: Tue, 14 Apr 2026 04:49:17 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/55] 6.1.169-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260413155724.820472494@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20260413155724.820472494@linuxfoundation.org>
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
X-Exim-ID: 1wCcGd-00000002mVQ-02O7
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:58892
X-Source-Auth: re@w6rz.net
X-Email-Count: 99
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCyDZZ7iTIabtzBw4E5o4xiueqKtvjs43eaJjbiSguhFfhWRbBSG276xKoX8NNMSrZBpr0oCKZQ2URsK0aughSwdmRwD4M5BcwTetae6wGPYXIk/7Bqs
 3x8uAP2XtomkPjg+9G8QJDFNlsQE8fod0ffqNJRrC2mKirmBMviHT/7ryWES7yNC8L8qHrzp+177iQ==
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[w6rz.net:s=default];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237833-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.944];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[w6rz.net:email,w6rz.net:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 271E63F9A0F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/13/26 09:00, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.169 release.
> There are 55 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 15 Apr 2026 15:57:08 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.169-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


