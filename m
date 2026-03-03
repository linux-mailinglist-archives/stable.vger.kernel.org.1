Return-Path: <stable+bounces-222862-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKEdKgXPpmnHWgAAu9opvQ
	(envelope-from <stable+bounces-222862-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 13:07:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B341EF00B
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 13:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A3C3E30C1882
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 11:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D2733F8C3;
	Tue,  3 Mar 2026 11:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="PLgXn5uD"
X-Original-To: stable@vger.kernel.org
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC5433E34E
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 11:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772539054; cv=none; b=CPo3qyKRpKYZRRj4MKQAH9NTGMll8Q2oA3kcduO+jBXb5HTyAniA2PH976vSbf+Fio+fcYfFoEcYJTvBjlRTvSAPMZDnenzR7vTmudQM1kkVIY8FvHwpXdM08X/wHzEj0mS9YlSMXip8dQA+CASUmm2ehcssKd+gmUfr5hIKsB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772539054; c=relaxed/simple;
	bh=/iSpQNnqhc6ihuZha1txjP1qLxJBHJJeqdNalIw6w/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cQM4QuFmVnlJ75ER52xqkKY9X97VE3/k80DjMX7W7aXU65TgZWsNXcSPbWpJih1qdO6dqMouUQfw+W9uM4uEj+yIU2yNX7VkijNQoVf6JFYHrGox2qIF/U6wtJxqDaZc4B8crHGO5aLE33bp0ep+bhw4ibvD9yRq8F+T7IvkZ0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=PLgXn5uD; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5003b.ext.cloudfilter.net ([10.0.29.155])
	by cmsmtp with ESMTPS
	id xKxfvioWqCxrGxONTvO4lx; Tue, 03 Mar 2026 11:57:27 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id xONSvriWY2l0kxONTv9v2q; Tue, 03 Mar 2026 11:57:27 +0000
X-Authority-Analysis: v=2.4 cv=UfRRSLSN c=1 sm=1 tr=0 ts=69a6cca7
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yCHH62CRqfgELOSFbphBNXI4bjEFPdRa3Er4H+2CznQ=; b=PLgXn5uDlItdKgFsTy5bPyNefi
	WiuMS245An+tHAQ4wBgyJRPxgLcwQbrsD6pl4lRMAa4SlVcVSK0/MNq1chTloRryxUoXg64ztH4Wh
	X1AKVGjVYp/oNtkRMK/Y3CFZWSLn2vs7QSV6pnoasBTJsOwotrsy1OxxyP7m7eV+Bxoqz3QoxDOM7
	orFZtPR27EN3ado0y9JSuVj79mtpRK0ZG/0THKFACD20KhsMtflVyb2w/9p6zxjO9WEZMjqKsPlyo
	wKavQirelvUguVYwQQd4eMQG5jLOAFY3gyATNSDxMxe4uvOLf0yL59eKU2ig1liyxgP8RY/J1wpBM
	Q/Vyx+XA==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:52398 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <re@w6rz.net>)
	id 1vxONS-00000000Zd9-0xS8;
	Tue, 03 Mar 2026 04:57:26 -0700
Message-ID: <c22b118e-661e-4fb2-8eb8-23f626f25e5f@w6rz.net>
Date: Tue, 3 Mar 2026 03:57:24 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.19 000/850] 6.19.6-rc2 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, patches@lists.linux.dev,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260302160834.2518716-1-sashal@kernel.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20260302160834.2518716-1-sashal@kernel.org>
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
X-Exim-ID: 1vxONS-00000000Zd9-0xS8
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:52398
X-Source-Auth: re@w6rz.net
X-Email-Count: 19
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCaiEPw+uyNzCJ1ja5y8T0HmzqLoFylx/wM8mF0baf51TDCArVu4T2GmuK4eQN8evxoUbnxIk8RKGpiSviSGjGEFwOkCzTzkQsZkbx6hjvTWo2CsauWw
 NAxgmBxmvcxj9xvbP3i74E58bsf1pzwpDYYKq/AldcYi+w+BPmgNlT0tD02yPbsvBzW8gbhctXWdkA==
X-Rspamd-Queue-Id: 54B341EF00B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[w6rz.net:s=default];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222862-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[w6rz.net];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCPT_COUNT_TWELVE(0.00)[21];
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
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,w6rz.net:mid,w6rz.net:email]
X-Rspamd-Action: no action

On 3/2/26 08:08, Sasha Levin wrote:
> This is the start of the stable review cycle for the 6.19.6 release.
> There are 850 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Mar  4 04:07:42 PM UTC 2026.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.19.y&id2=v6.19.5
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.19.y
> and the diffstat can be found below.
>
> Thanks,
> Sasha

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


