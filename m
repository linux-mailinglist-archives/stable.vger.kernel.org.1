Return-Path: <stable+bounces-72769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D99B4969596
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 09:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E68F1F2498D
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 07:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B311DAC7D;
	Tue,  3 Sep 2024 07:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="PbKTKQVW"
X-Original-To: stable@vger.kernel.org
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DF7201244
	for <stable@vger.kernel.org>; Tue,  3 Sep 2024 07:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725348712; cv=none; b=Ti75r8/bvjd2iy/jVFwqfnbjeaLdNuGkhEDrTfCLLzfEkl0wIzXNUxCGBIwQbn8KTAJSaJMJWCwdVcgxCxdsAbnTxppzdzLgoipHGNLFyKb2NvWRYJSaMlqagFfqx1lkUiPvNQ9v/ixyjnO+ZFj+bW6nOvYtcOJixYN2j23Vgiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725348712; c=relaxed/simple;
	bh=oaOtF3mnOGhPPknWuchy+VG4R9Md2oOdD/wELS/3P+0=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=QF3IJoRgSI/pI2bj5kR+6XJTqX41DHkyL9YMNIGp62B4JHVRzKh8ve5TVJMPd2Y3GlMl5Zafu9dBlEUZcVRN41T3Lf83EMdI/vtIoLBtQrKtldyQ23YfTwvPyrzQ5Q8orcXdl0Yx5lP9G824h7uCUyL67o5tvJIajABHLXpiw8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=PbKTKQVW; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6003a.ext.cloudfilter.net ([10.0.30.151])
	by cmsmtp with ESMTPS
	id lGL7sYgdfvH7llO10sa4Hu; Tue, 03 Sep 2024 07:31:50 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id lO0zsqTyFV2ivlO0zsSk0d; Tue, 03 Sep 2024 07:31:50 +0000
X-Authority-Analysis: v=2.4 cv=OLns3jaB c=1 sm=1 tr=0 ts=66d6bb66
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
	bh=/JdGR1ElBqWoLMmUPKNOcI9zGa/tpf3safM59qtOubc=; b=PbKTKQVWWrpyNlg6JS12ZJwKHc
	bZ7Ts9OADmy3Z/xGnnnRsYDdEYhm2ttsflpkGgs4DySgvOFE7H7zLJ6lpGLETl5yW4yiprZAf9w7E
	g0O4ymuIBptQBScNGlCYtKjclHDZhpE7XT3v7Yctgc28q12s7JQSga5kiqh9kaggzOrzXsHY325OJ
	cdV3gE3W+ZFWIYaDRz8rcOjLVOcy63KszVjA2gQcyE0G7X2mLgHW7Snw2PfcpnBHTLB5ivSAUnoMf
	lqvqY0zVvzDRQHQT+jkstvYrKkAJ2hgccjiB7LsMNEYkqgbthwtzZZwQgu9n5YmSdENhjARrsFHs0
	vDKsJKCQ==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:38110 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1slO0x-003tmn-1Z;
	Tue, 03 Sep 2024 01:31:47 -0600
Subject: Re: [PATCH 5.15 000/215] 5.15.166-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240901160823.230213148@linuxfoundation.org>
In-Reply-To: <20240901160823.230213148@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <4fbb6c1d-bb54-778f-810d-8c6816ee01d7@w6rz.net>
Date: Tue, 3 Sep 2024 00:31:45 -0700
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
X-Exim-ID: 1slO0x-003tmn-1Z
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:38110
X-Source-Auth: re@w6rz.net
X-Email-Count: 59
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBRnJHE/+ZgUcoU0pwnsUkizGQdGvh8+qC32GcVUese/HpeZHscYhIqlH2uWONGrvrrkpUtrtj9fuzwaKlvo4mnf7BhYWxvyRve+hEVfb1/8JaXYHp2d
 IyEeUKPaI+/H3SbitZtO75XrPDNfHZt4WPk+p1yaOgtw0vuNYTCN/JneREPrfdoqaf+Cq5ukJD3t/Q==

On 9/1/24 9:15 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.166 release.
> There are 215 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 03 Sep 2024 16:07:34 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.166-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


