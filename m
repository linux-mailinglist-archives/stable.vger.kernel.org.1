Return-Path: <stable+bounces-4808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B2B806694
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 06:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D62BC1F210A0
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 05:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA67F9E6;
	Wed,  6 Dec 2023 05:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="DpJhC03W"
X-Original-To: stable@vger.kernel.org
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8307A18F
	for <stable@vger.kernel.org>; Tue,  5 Dec 2023 21:27:13 -0800 (PST)
Received: from eig-obgw-6004a.ext.cloudfilter.net ([10.0.30.197])
	by cmsmtp with ESMTPS
	id AfBvrvonzhqFdAkRFrsbNW; Wed, 06 Dec 2023 05:27:13 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id AkRDr2pUtRGmSAkRErnxXR; Wed, 06 Dec 2023 05:27:12 +0000
X-Authority-Analysis: v=2.4 cv=efcuwpIH c=1 sm=1 tr=0 ts=65700630
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=e2cXIFwxEfEA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=ATLCLyqtdEkl7mCwK7IA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pO2xW5L49dy/9Rm9TCjtjs18xcEcAAzsBvc2XH40lcU=; b=DpJhC03WIoAybqnuvai09deB+8
	AqUVbKkWCkjcU46iH+HBSQtc2xIEsUPH3p+i1Spx+90SVkwM+VqJwexEQQG6ZipYbMy9Jsu/BmSmF
	jwxREaPEA1vaVYq9lVQ9CzDq+88s1XQf/WOHO6VNHYX2b1GRh42qDtIvYJyWu+QVSeiaoKx7REIeb
	ox2GRIwLpUF/zNXIY9ktwhtCsEmX7E41n7iMuxqsNziRQEXJACMI74sKcCFZcAk3xvkksgHPxkUpo
	eXKnV7iwEonittTapNEJ/5LUu59XDn8hHfzWuz6oIrU+LE3sXIUTIlGkEuW1jHbIdi01QOBxZ4Sq+
	gAV39K+Q==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:58548 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rAkRB-003bzr-17;
	Tue, 05 Dec 2023 22:27:09 -0700
Subject: Re: [PATCH 6.1 000/105] 6.1.66-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
References: <20231205183248.388576393@linuxfoundation.org>
In-Reply-To: <20231205183248.388576393@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <841ea761-414a-cbf0-fb50-1459d8e3ca5b@w6rz.net>
Date: Tue, 5 Dec 2023 21:27:06 -0800
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
X-Source-IP: 98.207.139.8
X-Source-L: No
X-Exim-ID: 1rAkRB-003bzr-17
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:58548
X-Source-Auth: re@w6rz.net
X-Email-Count: 2
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBlQPn6RPymOxLfo80LhIseM8jYVx0EdErnSCFCCOyJo6VjJGjHWLYnwEmAVUIDtcNMlXarjuwvNMqONHkFOS6vtaiKS+cUnS4c3Gp1fMuKVl3BdLzeM
 Rl33LNcBhP3+G5+lqWZyfaEk5PQR3WbCXZPLzzcr17ytsyLvzzntZYSe5lBax3uy6NY/w/ZK5Mt77A==

On 12/5/23 11:22 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.66 release.
> There are 105 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 07 Dec 2023 18:32:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.66-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


