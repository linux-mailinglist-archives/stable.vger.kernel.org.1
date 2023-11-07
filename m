Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F557E3702
	for <lists+stable@lfdr.de>; Tue,  7 Nov 2023 09:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbjKGI47 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 7 Nov 2023 03:56:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233172AbjKGI46 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 7 Nov 2023 03:56:58 -0500
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788C3113
        for <stable@vger.kernel.org>; Tue,  7 Nov 2023 00:56:53 -0800 (PST)
Received: from eig-obgw-5006a.ext.cloudfilter.net ([10.0.29.179])
        by cmsmtp with ESMTPS
        id 080XrZy8YhqFd0HtEri2J5; Tue, 07 Nov 2023 08:56:53 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
        by cmsmtp with ESMTPS
        id 0HtEraiq6ULW50HtErVALS; Tue, 07 Nov 2023 08:56:52 +0000
X-Authority-Analysis: v=2.4 cv=Yusc+qUX c=1 sm=1 tr=0 ts=6549fbd4
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=BNY50KLci1gA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
        s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LeRZVWfhQBUx62FjwdSykil5+EjPFUXjfV9K/vHxrOk=; b=25ap56hs221JGp5MqoOVSTgzYa
        SAbGfXMa9f6RKhZGl5G/p37HqBPVOIyehPFz//tfb8vzcnxs+3fhokVanZJjGE+p6wK3AMQmqeo/H
        SkHkKRmFuGjQ1QYibZkRojZNu88HgwTfywNrqa0q6peH/jaitN/NMgavNtwLpTSUUJQTvSxioUZr7
        RsmQHorBW6bwm/JcApB1hxdEj+MFZaA3hmf3x7QPelZrnHoS2AhPcQtmHTIausPCOtp6VQR/IRFfl
        4D3EphMeStX4CMfkfKPHKryChp3Fn734doZr8T77rvWrIeAa2qdgcbxHwy1knz5EkzxMzFbBIVgh3
        w0N4uwrQ==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:54226 helo=[10.0.1.47])
        by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.2)
        (envelope-from <re@w6rz.net>)
        id 1r0HtB-0008Ta-30;
        Tue, 07 Nov 2023 01:56:49 -0700
Subject: Re: [PATCH 5.15 000/128] 5.15.138-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
References: <20231106130309.112650042@linuxfoundation.org>
In-Reply-To: <20231106130309.112650042@linuxfoundation.org>
From:   Ron Economos <re@w6rz.net>
Message-ID: <686bff39-e016-adaa-9d0e-2e7edfb0b21e@w6rz.net>
Date:   Tue, 7 Nov 2023 00:56:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux armv7l; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
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
X-Exim-ID: 1r0HtB-0008Ta-30
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:54226
X-Source-Auth: re@w6rz.net
X-Email-Count: 53
X-Org:  HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPR7MiWNZmvArw7wJrtveINDYje9K948wvub/c4dE2Ga377FcRF/aYs7tlGd4nY/EuOQfNM7XsO6u8/y5vLOfQPXDeSvpNYDI90EvbIkK5u0pqO7+7jt
 pa02DXuOonQrYDkwWAU5YjzTFFw2r8Tr88gV/saq2ObK38S0c65KczFU8ar3Le/c+8DMYUkxlNqcOg==
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 11/6/23 5:02 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.138 release.
> There are 128 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.138-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

