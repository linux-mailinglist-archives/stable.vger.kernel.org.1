Return-Path: <stable+bounces-76623-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7657E97B5B9
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 00:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CF0E1F23F49
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 22:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D891925A9;
	Tue, 17 Sep 2024 22:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="czMEgfPl"
X-Original-To: stable@vger.kernel.org
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684C0191F95
	for <stable@vger.kernel.org>; Tue, 17 Sep 2024 22:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726612097; cv=none; b=T1r+QlQk+H0Gyl2qY8FH1PUl8Zlm7qeDZXBn2EuepplU4fyOT3pZ8q2S2+AmTzVm5DlRxKo+XpRCsl9MzME3RSU6teGfW28GwPz10encQAJJhyp83n0brxsGNcsBl5HHtfdUbemPQqxsCJeQsUlh6QJtf6I7TQr/dPch8zE8VAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726612097; c=relaxed/simple;
	bh=ITGcAc30GiZ2r9on52mDfrwUHdGvKkm4dpPJI3/8rlc=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=ke/VJbR6SIdc7b2RHeYA94g40nbJQcjRo/06JFWpIceh+FKallem+kTwCKoe37I/I6ZgBAc5Q1sFP5HIGSMYbhnjuzdsnnVNtelIP1bw85WbpgTR5uprBmJC7DPZIoMfU2wwTa3fponc0LX8sVOnaJpn/kYmwVcK36c0lZOCYxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=czMEgfPl; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5001a.ext.cloudfilter.net ([10.0.29.139])
	by cmsmtp with ESMTPS
	id qgXWsYSouvH7lqgg5sPl4e; Tue, 17 Sep 2024 22:28:09 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id qgg4sNi46mqhiqgg4sTmkO; Tue, 17 Sep 2024 22:28:09 +0000
X-Authority-Analysis: v=2.4 cv=NdEt1HD4 c=1 sm=1 tr=0 ts=66ea0279
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HhgWGGqSUKaUXy95pivy0JeC032zQ5e5NLogHgBkqFI=; b=czMEgfPlGR94PnCTB3YbXY5Hq7
	HdtvDOkxgLgRmD4YEHOCme7zVVicM37CW8xwzu4g0BWuBCk5RcQXDzXHpcx8UJjnBP6umTslu4rfD
	KmdplnQgPeP9KQE1qB+9XHhR0rJNq0rZsNAqKC7TfHDwhsdlnvBPdixUWGC1l7tUnXil+gB0iXsgE
	E9ria9wHC82Ooj1yLf3gsRD+7LEvgErB2pCwUz7z2oU1ovHaUjvscxKjuezX0gmvCZ0q2uzLsLkzH
	edNHX7UtNgmnWlhYkqD369E+lzcQTejukjsadYBAGMOcH5bd8tC1cBh62il0iwKvgJmJLfV6ekuRh
	V6zvb9Lg==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:41170 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1sqgg2-001Uoq-1H;
	Tue, 17 Sep 2024 16:28:06 -0600
Subject: Re: [PATCH 6.10 000/121] 6.10.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240916114228.914815055@linuxfoundation.org>
In-Reply-To: <20240916114228.914815055@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <9a7a68d4-845c-6d37-420d-e98d6781df34@w6rz.net>
Date: Tue, 17 Sep 2024 15:28:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux armv7l; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.223.253.157
X-Source-L: No
X-Exim-ID: 1sqgg2-001Uoq-1H
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:41170
X-Source-Auth: re@w6rz.net
X-Email-Count: 2
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHtMNAjL+agazLN8n87ZaE1VnjSioW2j7RIo7wErRdtUYLhv+F0K191byx8zdUQBCU5ArGMklsDLwhelxt64+lrHDtPqz3b81peMtGGkz0lcQeBqK2He
 cFnqUUaYcYrcpC+xLl3jAp8SX0G9WLhrRvry/ogJUoqcKbP6KUQ1zs+Y0FEkBPbzVI5DhGKVXS7IGQ==

On 9/16/24 4:42 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.10.11 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 18 Sep 2024 11:42:05 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


