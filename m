Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C1D7D0629
	for <lists+stable@lfdr.de>; Fri, 20 Oct 2023 03:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346811AbjJTB1z (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 19 Oct 2023 21:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346768AbjJTB1y (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 19 Oct 2023 21:27:54 -0400
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8C3116
        for <stable@vger.kernel.org>; Thu, 19 Oct 2023 18:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1697765274; x=1729301274;
  h=message-id:date:mime-version:to:from:cc:subject:
   content-transfer-encoding;
  bh=gRHIWGBX70z/DJmBCO4m5ERrAqpwWSa9w8RtpF/7jLg=;
  b=kc1wwwRgpNhdcMZCQ96mZX9YpMOOxVv5iby9yzj3ziBiRcBE7zYS0cp7
   4gXrDWgo0iUN2EKEjS9VlmouE4Rd51f12t3VgGvSpbApDxBQPkAuC1cP3
   MTPmsz94ED2ob86UKwCXYZjHTTVA95Zo1k8mex8UJBhYf9Z1dEuNXfyzo
   A=;
X-IronPort-AV: E=Sophos;i="6.03,238,1694736000"; 
   d="scan'208";a="309451795"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-6e7a78d7.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 01:27:47 +0000
Received: from smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
        by email-inbound-relay-iad-1e-m6i4x-6e7a78d7.us-east-1.amazon.com (Postfix) with ESMTPS id 7387A88416;
        Fri, 20 Oct 2023 01:27:45 +0000 (UTC)
Received: from EX19MTAUEB002.ant.amazon.com [10.0.29.78:56613]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.62.238:2525] with esmtp (Farcaster)
 id bfc3f018-7291-43d7-ab6c-b10fc8d61a6a; Fri, 20 Oct 2023 01:27:44 +0000 (UTC)
X-Farcaster-Flow-ID: bfc3f018-7291-43d7-ab6c-b10fc8d61a6a
Received: from EX19D028UEC003.ant.amazon.com (10.252.137.159) by
 EX19MTAUEB002.ant.amazon.com (10.252.135.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 20 Oct 2023 01:27:40 +0000
Received: from [10.95.211.45] (10.95.211.45) by EX19D028UEC003.ant.amazon.com
 (10.252.137.159) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Fri, 20 Oct
 2023 01:27:39 +0000
Message-ID: <97397e8d-f447-4cf7-84a1-070989d0a7fd@amazon.com>
Date:   Thu, 19 Oct 2023 21:27:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "sashal@kernel.org" <sashal@kernel.org>
From:   Luiz Capitulino <luizcap@amazon.com>
CC:     <42.hyeyoo@gmail.com>
Subject: [6.1] Please apply cc6003916ed46d7a67d91ee32de0f9138047d55f
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.95.211.45]
X-ClientProxiedBy: EX19D044UWA001.ant.amazon.com (10.13.139.100) To
 EX19D028UEC003.ant.amazon.com (10.252.137.159)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

As reported before[1], we found another regression in 6.1 when doing
performance comparisons with 5.10. This one is caused by CONFIG_DEBUG_PREEMPT
being enabled by default by the following upstream commit if you have the
right config dependencies enabled (commit is introduced in v5.16-rc1):

"""
commit c597bfddc9e9e8a63817252b67c3ca0e544ace26
Author: Frederic Weisbecker <frederic@kernel.org>
Date: Tue Sep 14 12:31:34 2021 +0200

sched: Provide Kconfig support for default dynamic preempt mode
"""

We found up to 8% performance improvement with CONFIG_DEBUG_PREEMPT
disabled in different perf benchmarks (including UnixBench process
creation and redis). The root cause is explained in the commit log
below which is merged in 6.3 and applies (almost) clealy on 6.1.59.

"""
commit cc6003916ed46d7a67d91ee32de0f9138047d55f
Author: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date:   Sat Jan 21 12:39:42 2023 +0900

     lib/Kconfig.debug: do not enable DEBUG_PREEMPT by default

     In workloads where this_cpu operations are frequently performed,
     enabling DEBUG_PREEMPT may result in significant increase in
     runtime overhead due to frequent invocation of
     __this_cpu_preempt_check() function.

     This can be demonstrated through benchmarks such as hackbench where this
     configuration results in a 10% reduction in performance, primarily due to
     the added overhead within memcg charging path.
"""

[1] https://lore.kernel.org/stable/010edf5a-453d-4c98-9c07-12e75d3f983c@amazon.com/
