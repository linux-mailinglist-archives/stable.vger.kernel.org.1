Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B01D7155AD
	for <lists+stable@lfdr.de>; Tue, 30 May 2023 08:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjE3Gtd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 30 May 2023 02:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjE3Gtc (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 30 May 2023 02:49:32 -0400
Received: from qproxy3-pub.mail.unifiedlayer.com (qproxy3-pub.mail.unifiedlayer.com [67.222.38.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C903C11C
        for <stable@vger.kernel.org>; Mon, 29 May 2023 23:49:16 -0700 (PDT)
Received: from outbound-ss-761.bluehost.com (outbound-ss-761.bluehost.com [74.220.211.250])
        by qproxy3.mail.unifiedlayer.com (Postfix) with ESMTP id 40768803302B
        for <stable@vger.kernel.org>; Tue, 30 May 2023 06:49:16 +0000 (UTC)
Received: from cmgw11.mail.unifiedlayer.com (unknown [10.0.90.126])
        by progateway8.mail.pro1.eigbox.com (Postfix) with ESMTP id 8183010047D46
        for <stable@vger.kernel.org>; Tue, 30 May 2023 06:49:15 +0000 (UTC)
Received: from box5620.bluehost.com ([162.241.219.59])
        by cmsmtp with ESMTP
        id 3tARqN4XNgJQd3tARq2LwK; Tue, 30 May 2023 06:49:15 +0000
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.4 cv=e/rD9Yl/ c=1 sm=1 tr=0 ts=64759c6b
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10:nop_charset_1
 a=P0xRbXHiH_UA:10:nop_rcvd_month_year
 a=-Ou01B_BuAIA:10:endurance_base64_authed_username_1 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10:nop_charset_2
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
        s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Nt2OwzZRszP/LUy2aUTUdRvLWDJpR8D8eBeU819kHME=; b=gp91556VqlG8dLzEOBa2jYJIiO
        c7/43T8UemkAXVUhxvzB1DfZrLuSS9WWCRY9NTNWhN1NTOGDkvC5jvey+FWa+e2JmhBgK3W0HpIL7
        G6l99kJA/2HAJO11XAhjMs0yUk/z9meAuLR6r6PLB/6UTsM7Hw4AYx+B4YPH9kH8J0s+ATOd9iuZv
        zFeZIEcMxkfXWAQesgietrfx7n6uWyV5OxM/WeIaHHo//pSNSxinV3M50FzaUOHOobvGNrbjey0RX
        juTPCqh5B7kq5LkvriIi++zvMsscxocig+RY7B0GNNArMzBFCXA3MJ0ImcxbDiUjYgQoCREukFdlO
        kdxQ1Qig==;
Received: from c-73-162-232-9.hsd1.ca.comcast.net ([73.162.232.9]:42112 helo=[10.0.1.47])
        by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <re@w6rz.net>)
        id 1q3tAQ-000htZ-Cb;
        Tue, 30 May 2023 00:49:14 -0600
Subject: Re: [PATCH 5.15 00/69] 5.15.114-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
References: <20230528190828.358612414@linuxfoundation.org>
In-Reply-To: <20230528190828.358612414@linuxfoundation.org>
From:   Ron Economos <re@w6rz.net>
Message-ID: <be132458-69db-b4fa-41ee-0cb1ad126b1a@w6rz.net>
Date:   Mon, 29 May 2023 23:49:12 -0700
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
X-Source-IP: 73.162.232.9
X-Source-L: No
X-Exim-ID: 1q3tAQ-000htZ-Cb
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-232-9.hsd1.ca.comcast.net ([10.0.1.47]) [73.162.232.9]:42112
X-Source-Auth: re@w6rz.net
X-Email-Count: 2
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 5/28/23 12:11 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.114 release.
> There are 69 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 30 May 2023 19:08:13 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.114-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

