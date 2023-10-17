Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808407CBC7E
	for <lists+stable@lfdr.de>; Tue, 17 Oct 2023 09:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbjJQHnT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 17 Oct 2023 03:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjJQHnS (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Oct 2023 03:43:18 -0400
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F0B8F
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 00:43:17 -0700 (PDT)
Received: from eig-obgw-6006a.ext.cloudfilter.net ([10.0.30.182])
        by cmsmtp with ESMTPS
        id sXARq392kCRPksejUqFj1B; Tue, 17 Oct 2023 07:43:16 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
        by cmsmtp with ESMTPS
        id sejTqUFQjfDvnsejUqfeYW; Tue, 17 Oct 2023 07:43:16 +0000
X-Authority-Analysis: v=2.4 cv=O7oqATxW c=1 sm=1 tr=0 ts=652e3b14
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=nVRhpLHY2Gk3QZ1Fk7gA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
        s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Wd7NK0HYeGhPO3dpelU4pLoCUWd4bfHnkXYuVipCio4=; b=x30Q0W64DXCyhnWY+jaJPvWZVI
        KvCEzeTaCeC9cCD77n0VYjfEdj9d46aFieT9thrARkGFQNDUIwsHgobc+5RHEudOEMd2DrQCK99+c
        0clppJSDZ0vgEjJVSwKkgxrI8mxRdx01Rtv8oPTy81GbhO0jSdl6tvPJxfXoodjES+59a3V75MVdO
        j6eQh0XduDj9OSTXatQvEvQl+ey3tgv/Zw6RQ+WCoPER/B9beZG+dEj/gwM7HSFhef378lD1o2mZ9
        nboh/DBr3QS+aqiXGLIP9urz9QYH8fMmU6Q5Bk9KI75FXUUMg9lijAt2V5VHIDQj8x8oGSSJ1KM5y
        6I15Ckcg==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:51596 helo=[10.0.1.47])
        by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.1)
        (envelope-from <re@w6rz.net>)
        id 1qsejS-001cnc-0b;
        Tue, 17 Oct 2023 01:43:14 -0600
Subject: Re: [PATCH 5.15 000/102] 5.15.136-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
References: <20231016083953.689300946@linuxfoundation.org>
In-Reply-To: <20231016083953.689300946@linuxfoundation.org>
From:   Ron Economos <re@w6rz.net>
Message-ID: <6faee9ae-7925-06dd-b7d9-815e79d1c6b3@w6rz.net>
Date:   Tue, 17 Oct 2023 00:43:11 -0700
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
X-Exim-ID: 1qsejS-001cnc-0b
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:51596
X-Source-Auth: re@w6rz.net
X-Email-Count: 53
X-Org:  HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJOQX7jndPK3ycSFeqHp6Q0NBWaqUxCkTGYRUTu6iFAm5IRdmTu+srPxS9AVWQGZW6I4ohrX8JY8RFQf8sTaDskcneyhnD8zge5Hujgj626gkhfrHBxh
 BKz/HQZXRomRVSHkpnxMmWAYzeyqeL4dHqnGq4YBgZKXFp2njATgonf0Yjxlv7zCYC3iVae457kOew==
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 10/16/23 1:39 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.136 release.
> There are 102 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 18 Oct 2023 08:39:38 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.136-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

