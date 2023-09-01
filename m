Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DBE78F86C
	for <lists+stable@lfdr.de>; Fri,  1 Sep 2023 08:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbjIAGNT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 1 Sep 2023 02:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235857AbjIAGNT (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 1 Sep 2023 02:13:19 -0400
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8291B10D1
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 23:13:15 -0700 (PDT)
Received: from eig-obgw-5001a.ext.cloudfilter.net ([10.0.29.139])
        by cmsmtp with ESMTP
        id bfGIqyz80OzKlbxP9qN7Pd; Fri, 01 Sep 2023 06:13:15 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
        by cmsmtp with ESMTPS
        id bxP8qcp3C75x2bxP8qmGls; Fri, 01 Sep 2023 06:13:14 +0000
X-Authority-Analysis: v=2.4 cv=aqGhtAVV c=1 sm=1 tr=0 ts=64f180fa
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=CY-X28npfPn-Uh55j5IA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
        s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=48f3MfdrFy/d0mCrbyJSRiVRCUWHeSkUoOmuXtpD2Ro=; b=CoDFEWGd1N6U/89oWf9Xx+DQIR
        BBwbyMGTARM4Y3iu6MzVOIZIi8ilDfMIyOVXIu8MZ/CNI5M+jUvQiYYSlklVLjz7L0snGvE50Iuij
        q0lZ/xieMSBtRZeiAXLmdj7ouopPJ/texM8Vr52HpWPZbqcrOmQoEtIOv7/axNkYgJ26TqW2aDV1k
        SycNzEsUWM3PeEIzXmtytjbKgqNd5UW1nq97DzWIqlBdRFGusdEdBco+vUe79xSVqOoMtu5v8mlq2
        BChlOB+H5bOC13g27X06YYKt/8bdniz2NPJwePwG1+zu41IhZ/Ybivcgut92Mky2AZCh5VOkbNPw5
        jJQNNvqg==;
Received: from c-73-162-232-9.hsd1.ca.comcast.net ([73.162.232.9]:53812 helo=[10.0.1.47])
        by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <re@w6rz.net>)
        id 1qbxP6-003GWN-0N;
        Fri, 01 Sep 2023 00:13:12 -0600
Subject: Re: [PATCH 6.4 0/9] 6.4.14-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
References: <20230831111127.667900990@linuxfoundation.org>
In-Reply-To: <20230831111127.667900990@linuxfoundation.org>
From:   Ron Economos <re@w6rz.net>
Message-ID: <55aa4afe-c0d9-f581-c123-519f93a2684e@w6rz.net>
Date:   Thu, 31 Aug 2023 23:13:09 -0700
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
X-Exim-ID: 1qbxP6-003GWN-0N
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-232-9.hsd1.ca.comcast.net ([10.0.1.47]) [73.162.232.9]:53812
X-Source-Auth: re@w6rz.net
X-Email-Count: 19
X-Org:  HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJO+enb+IJZx+FUADHBsuBl0QEv8z/zqT9slD+wpTcld71++gOiTaAKBmJo2eZMOfBs1AQZJt8sop00Hdb7I3XHASBEgBVNcyGS3uFyZcq8ESobtT90y
 +4iKKbbalv0L/8rzYG2YS9KyVlouiE09et7QhMy2LQN0OfwjbQJ4WVqnkn1gcWpntkcePdxtTvo6rg==
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 8/31/23 4:11 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.14 release.
> There are 9 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 02 Sep 2023 11:11:18 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.14-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

