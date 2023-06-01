Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1727271F483
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 23:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjFAVSN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 17:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjFAVSM (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 17:18:12 -0400
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C79A184
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 14:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1685654291; x=1717190291;
  h=message-id:date:mime-version:to:from:subject:
   content-transfer-encoding;
  bh=Vpv3/snaHf1WcNcUBvUReGjUvKQ8+SKeoQ+Ej+i/yEI=;
  b=FRg6esLxHWLUp9nthUTo00QYkauKf91fbHV0ERuZ9Bd82LAOpSqpD4L3
   aowQdJ8f0ik40Y4D7JLYtOKgDybz1T56yRrHfrhNp7EH55SO3/qHZbQsL
   Gri3UCsAkyJDJKrCETS6v+FjP8vjS0w/sXrbmvnA+wy/FhM/xS25jy5uR
   Q=;
X-IronPort-AV: E=Sophos;i="6.00,210,1681171200"; 
   d="scan'208";a="343080998"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-3ef535ca.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 21:18:06 +0000
Received: from EX19MTAUEC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-m6i4x-3ef535ca.us-west-2.amazon.com (Postfix) with ESMTPS id BABE5611D0
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 21:18:05 +0000 (UTC)
Received: from EX19D028UEC003.ant.amazon.com (10.252.137.159) by
 EX19MTAUEC001.ant.amazon.com (10.252.135.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 1 Jun 2023 21:17:57 +0000
Received: from [192.168.209.155] (10.106.239.22) by
 EX19D028UEC003.ant.amazon.com (10.252.137.159) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 1 Jun 2023 21:17:57 +0000
Message-ID: <23bb697e-c965-8321-f648-03f804853cdb@amazon.com>
Date:   Thu, 1 Jun 2023 17:17:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     <stable@vger.kernel.org>
From:   Luiz Capitulino <luizcap@amazon.com>
Subject: [6.1.y] Please apply 98bea253aa28ad8be2ce565a9ca21beb4a9419e5
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.106.239.22]
X-ClientProxiedBy: EX19D032UWB003.ant.amazon.com (10.13.139.165) To
 EX19D028UEC003.ant.amazon.com (10.252.137.159)
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


It fixes CVE-2022-48425 and is applied to 5.15.y and 6.3.y. I quickly tested
the commit by mounting an NTFS partition and building a kernel in it.

"""
commit 98bea253aa28ad8be2ce565a9ca21beb4a9419e5
Author: Edward Lo <edward.lo@ambergroup.io>
Date:   Sat Nov 5 23:39:44 2022 +0800

     fs/ntfs3: Validate MFT flags before replaying logs
"""

Thanks,

- Luiz
