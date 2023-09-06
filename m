Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F196779326A
	for <lists+stable@lfdr.de>; Wed,  6 Sep 2023 01:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236814AbjIEXT5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 5 Sep 2023 19:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235667AbjIEXT5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 5 Sep 2023 19:19:57 -0400
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6A8B0
        for <stable@vger.kernel.org>; Tue,  5 Sep 2023 16:19:49 -0700 (PDT)
Received: from eig-obgw-6004a.ext.cloudfilter.net ([10.0.30.197])
        by cmsmtp with ESMTP
        id dURIqfAG5yYOwdfKmqf0rE; Tue, 05 Sep 2023 23:19:48 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
        by cmsmtp with ESMTPS
        id dfKlqnnDX1K5PdfKmqaoDX; Tue, 05 Sep 2023 23:19:48 +0000
X-Authority-Analysis: v=2.4 cv=Zsf+lv3G c=1 sm=1 tr=0 ts=64f7b794
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
        s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=p7jOmeLXvMC8TC+tQDu9RvHbBiEzuSXvM48zB+Ctpnc=; b=giZh8UMOGxuepkjSEVzaj1hcXR
        3Z2CAaNwldKZxtSo+Gou9TfNdJJ48AJgvvCDS0iOaY1yR7vd4O/vKS2fCzeBzHiGo1wNbThCD/54I
        sooHAjFLGLklOpn18U9+K1LrdD+BYSCVmG5+RVs/zsL4Go7UUhf3wrcS2xVY124UaZ7rohunToeJw
        bPm3hH5/633XWwmrJixFM+pPcKXLhrX9Qx8U4GkLWpFSHOzQ3n54gnHSa1g6CuaNRvkJGJu5NyGk+
        Jl+AbZOBaFXV5jU7b5+kW2XBmXzMlXB1Y3KFW6kWcReZUOVUHUEo8NHVcPKqmeWpOtutNnG9FX4jj
        mr/8NfGQ==;
Received: from c-73-162-232-9.hsd1.ca.comcast.net ([73.162.232.9]:54310 helo=[10.0.1.47])
        by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <re@w6rz.net>)
        id 1qdfKk-002p7k-05;
        Tue, 05 Sep 2023 17:19:46 -0600
Subject: Re: [PATCH 5.15 00/28] 5.15.131-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
References: <20230904182945.178705038@linuxfoundation.org>
In-Reply-To: <20230904182945.178705038@linuxfoundation.org>
From:   Ron Economos <re@w6rz.net>
Message-ID: <a3a98d35-bc3b-2619-c616-c8e74b57ea9b@w6rz.net>
Date:   Tue, 5 Sep 2023 16:19:43 -0700
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
X-Exim-ID: 1qdfKk-002p7k-05
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-232-9.hsd1.ca.comcast.net ([10.0.1.47]) [73.162.232.9]:54310
X-Source-Auth: re@w6rz.net
X-Email-Count: 36
X-Org:  HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHgfQO+M0sBxODwIDT92+KWQajFEYbfVVdy8oBKpDjoGQbrCz4CFTRrsDEa/wtFnyr4ZTYmtFxl20p7IFfYHADmg+WcQYT+SxPHT5ATYDvKFLzoMBLtZ
 esxmi3/80wzR018kSPS8gVsKq2IKbRrQByKaqIenU9Os7yQ0Gtp6wWWLN4x58ijBNnSR3sKQ6tvkbQ==
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 9/4/23 11:30 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.131 release.
> There are 28 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 06 Sep 2023 18:29:29 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.131-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

