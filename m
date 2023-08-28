Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168F478BB0B
	for <lists+stable@lfdr.de>; Tue, 29 Aug 2023 00:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233851AbjH1Wgv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 18:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbjH1WgU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 18:36:20 -0400
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1DAD2
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 15:36:17 -0700 (PDT)
Received: from eig-obgw-5008a.ext.cloudfilter.net ([10.0.29.246])
        by cmsmtp with ESMTP
        id aif9qcXFJDKaKakqGqs5fP; Mon, 28 Aug 2023 22:36:16 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
        by cmsmtp with ESMTPS
        id akqFqkYZY38SbakqGqs50p; Mon, 28 Aug 2023 22:36:16 +0000
X-Authority-Analysis: v=2.4 cv=cdTBE1PM c=1 sm=1 tr=0 ts=64ed2160
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=UttIx32zK-AA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
        s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=o9+P6fCbD8VCllGnyBTCQCE6h4voI3rfT2ANK4Dkumk=; b=Q52wgxSe5zARX6JpCDhU4gh408
        3duq3UaGA66+Fvot4aZ0n2+Cu7BV8rTc7vMXoVr2G8fm+raSO/NrIPBpRWff+axmBIr1KW65j1FU5
        nh8VZTOTfGgStQIVZzWVzL/WJO2WG8wbtH5mrFD3zKVgccdFnMqM9LJ8uBOvTyUlf4JOyp/9pJQct
        90v570wVvXDjuXDnWsrAnUi0rEqxqrR/6ejFQKHI9d6nBNcaDmbUxBDZbTFPfp+PZeLdCl7XKWCNG
        NO9bgEUftXvzUYOAncjHEsbnhA/Jhw9Gye9so59gBOhd0fqlgeXKBMih+Zj6Joky55hIbz5ELrK+X
        C8IEAYAQ==;
Received: from c-73-162-232-9.hsd1.ca.comcast.net ([73.162.232.9]:53442 helo=[10.0.1.47])
        by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <re@w6rz.net>)
        id 1qakqD-000L4C-1u;
        Mon, 28 Aug 2023 16:36:13 -0600
Subject: Re: [PATCH 6.4 000/129] 6.4.13-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
References: <20230828101157.383363777@linuxfoundation.org>
In-Reply-To: <20230828101157.383363777@linuxfoundation.org>
From:   Ron Economos <re@w6rz.net>
Message-ID: <26308695-25e9-34ec-bcf4-5d3df1ab7b90@w6rz.net>
Date:   Mon, 28 Aug 2023 15:36:11 -0700
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
X-Exim-ID: 1qakqD-000L4C-1u
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-232-9.hsd1.ca.comcast.net ([10.0.1.47]) [73.162.232.9]:53442
X-Source-Auth: re@w6rz.net
X-Email-Count: 2
X-Org:  HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKSYSOVQ+VCdBfzNNuuHbGL2LbqwoYybEWMdjIECGwoOLQlfmSbKNdF9y8r+Zk2JdK0Fx8UU9jSP/L2ukm3oH4ISph9iwpglKmvMvNGYsVZnxDqs73hO
 TqLmhju7f+E8tNcC/i1Teuj+cAkrOJ+tSF0952mgc7gTJmni04/oHRhbGdYeo+MjlMsw52WwSrB/gg==
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 8/28/23 3:11 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.13 release.
> There are 129 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.13-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

