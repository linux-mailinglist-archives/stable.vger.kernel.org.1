Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A697A75EE
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 10:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbjITIck convert rfc822-to-8bit (ORCPT
        <rfc822;lists+stable@lfdr.de>); Wed, 20 Sep 2023 04:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjITIcj (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 04:32:39 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095389E
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 01:32:33 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 38K8WIZ00869755, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 38K8WIZ00869755
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Sep 2023 16:32:18 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 20 Sep 2023 16:32:18 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 20 Sep 2023 16:32:17 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::9cb8:8d5:b6b3:213b]) by
 RTEXMBS01.realtek.com.tw ([fe80::9cb8:8d5:b6b3:213b%5]) with mapi id
 15.01.2375.007; Wed, 20 Sep 2023 16:32:17 +0800
From:   Ricky WU <ricky_wu@realtek.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Linux regressions mailing list <regressions@lists.linux.dev>,
        "Paul Grandperrin" <paul.grandperrin@gmail.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Wei_wang <wei_wang@realsil.com.cn>,
        Roger Tseng <rogerable@realtek.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: RE: Regression since 6.1.46 (commit 8ee39ec): rtsx_pci from drivers/misc/cardreader breaks NVME power state, preventing system boot
Thread-Topic: Regression since 6.1.46 (commit 8ee39ec): rtsx_pci from
 drivers/misc/cardreader breaks NVME power state, preventing system boot
Thread-Index: AQHZ5XTPQHzxhN3m602gmLzU6tUtJLAYNE4TgAk8SwD//83wgIACG3Pg//9+6YCAAIkp0A==
Date:   Wed, 20 Sep 2023 08:32:17 +0000
Message-ID: <3ddcf5fae0164fbda79081650da79600@realtek.com>
References: <5DHV0S.D0F751ZF65JA1@gmail.com>
 <82469f2f-59e4-49d5-823d-344589cbb119@leemhuis.info>
 <2023091333-fiftieth-trustless-d69d@gregkh>
 <7991b5bd7fb5469c971a2984194e815f@realtek.com>
 <2023091921-unscented-renegade-6495@gregkh>
 <995632624f0e4d26b73fb934a8eeaebc@realtek.com>
 <2023092041-shopper-prozac-0640@gregkh>
In-Reply-To: <2023092041-shopper-prozac-0640@gregkh>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.22.81.100]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

> On Wed, Sep 20, 2023 at 07:30:00AM +0000, Ricky WU wrote:
> > Hi Greg k-h,
> >
> > This patch is our solution for this issue...
> > And now how can I push this?
> 
> Submit it properly like any other patch, what is preventing that from
> happening?
> 

(commit 8ee39ec) some reader no longer force #CLKREQ to low when system need to enter ASPM.
But some platform maybe not implement complete ASPM? I don't know..... it causes problems...

Like in the past Only the platform support L1ss we release the #CLKREQ.
But new patch we move the judgment (L1ss) to probe, because we met some host will clean the config space from S3 or some power saving mode 
And also we think just to read config space one time when the driver start is enough  

> thanks,
> 
> greg k-h
