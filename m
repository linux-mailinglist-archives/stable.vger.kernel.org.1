Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACC078F86E
	for <lists+stable@lfdr.de>; Fri,  1 Sep 2023 08:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236200AbjIAGPg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 1 Sep 2023 02:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235362AbjIAGPg (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 1 Sep 2023 02:15:36 -0400
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACF9EA
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 23:15:32 -0700 (PDT)
Received: from eig-obgw-5010a.ext.cloudfilter.net ([10.0.29.199])
        by cmsmtp with ESMTP
        id bsjVqEPe8WU1cbxRMqYa3L; Fri, 01 Sep 2023 06:15:32 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
        by cmsmtp with ESMTPS
        id bxRLqLO9PYbrCbxRMqJ9y9; Fri, 01 Sep 2023 06:15:32 +0000
X-Authority-Analysis: v=2.4 cv=e7wV9Il/ c=1 sm=1 tr=0 ts=64f18184
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=ZdJvYIG7m5v28Xnbdu4A:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
        s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5F3GxYxq+ftS1O7/JiQkreRFHqhCT3T3T+56s8HWtUI=; b=Y5amOcN6YbYLZvMsqArr8DmDRD
        cDdy5T2lkTNTGowL3BUQ8LUa0vFeWhpEYHn+HzYj9XgYdHU+8aopHa893laT2Aq6hypJ6MyI0A6E5
        mBaMAmbYMWfxLzfMnMzIHeukpVvGb5zOkoxMBxV+eG9nyfy4xcXq/IuUNzN2URD/9lhRt2fr0AHRw
        yhJcnuoakTHTwbur/pOcdqnGSYBnKQnJhGiuyc+lTLFF0zWBYRmIi5ixpWFkdpDwgFPFhaSj4XYnN
        p1MqD6PyGiH+YT7gBNKYQLTg6BrDFqVe/IMSj2amuBTRu6LuqWiuPPZc5FlW9wZHs49/pd2GQmZ26
        lJ8+quaA==;
Received: from c-73-162-232-9.hsd1.ca.comcast.net ([73.162.232.9]:53820 helo=[10.0.1.47])
        by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <re@w6rz.net>)
        id 1qbxRJ-003HME-2U;
        Fri, 01 Sep 2023 00:15:29 -0600
Subject: Re: [PATCH 6.1 00/10] 6.1.51-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
References: <20230831110831.079963475@linuxfoundation.org>
In-Reply-To: <20230831110831.079963475@linuxfoundation.org>
From:   Ron Economos <re@w6rz.net>
Message-ID: <aa138d03-1c8e-f7f1-cccb-9ca747e53e42@w6rz.net>
Date:   Thu, 31 Aug 2023 23:15:27 -0700
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
X-Exim-ID: 1qbxRJ-003HME-2U
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-232-9.hsd1.ca.comcast.net ([10.0.1.47]) [73.162.232.9]:53820
X-Source-Auth: re@w6rz.net
X-Email-Count: 36
X-Org:  HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCNou5YFjZqSmIe3ejiEz6iNRk1U7SwAmDz8ZwOMGhaF883X6Jxy/9sMO4v3KpSYDtAWfDHPgv8UnfhLj+vY/Lu+uNccSeD+vNWmF7M/C7/QupUqM0eR
 ZDjzNR7PdLlht3IyEEi5SyvZ+zYP8SA9QFKUlSJGZqd7a44PvsANU/sIzedutrQNvaeWknaYyH2D5w==
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 8/31/23 4:10 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.51 release.
> There are 10 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 02 Sep 2023 11:08:22 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.51-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

