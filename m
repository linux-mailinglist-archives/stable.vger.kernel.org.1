Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0290F7BA2A2
	for <lists+stable@lfdr.de>; Thu,  5 Oct 2023 17:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbjJEPnn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 5 Oct 2023 11:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbjJEPnN (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 5 Oct 2023 11:43:13 -0400
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CAE6702
        for <stable@vger.kernel.org>; Thu,  5 Oct 2023 07:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1696517979; x=1728053979;
  h=message-id:date:mime-version:to:cc:from:subject:
   content-transfer-encoding;
  bh=F4DXyzvks4SjCO39rTIRcQaJk8nbyPccC5eJCgdjSQs=;
  b=p8ju+BljMo5mjb0Dnophgy8dJZkzo02Z6cbVHRRhulo3X2bkVPA/tjSz
   16jb/xPNTgOKl/p0idI5ALfD1hdMDWXz6P07UDbKE6XAun7rLwOqVzshi
   B1mvqiHYhdxy3yxgXkjEnvQFDZ8jGleW7UDeXyoTkogAXc7Bn/xhpkjXW
   k=;
X-IronPort-AV: E=Sophos;i="6.03,203,1694736000"; 
   d="scan'208";a="243635462"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-54a853e6.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 14:59:36 +0000
Received: from smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
        by email-inbound-relay-iad-1a-m6i4x-54a853e6.us-east-1.amazon.com (Postfix) with ESMTPS id 9C63A484A9;
        Thu,  5 Oct 2023 14:59:33 +0000 (UTC)
Received: from EX19MTAUEB001.ant.amazon.com [10.0.29.78:19359]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.50.19:2525] with esmtp (Farcaster)
 id ea6e9579-e480-4773-b428-3ff4a08893c4; Thu, 5 Oct 2023 14:59:33 +0000 (UTC)
X-Farcaster-Flow-ID: ea6e9579-e480-4773-b428-3ff4a08893c4
Received: from EX19D028UEC003.ant.amazon.com (10.252.137.159) by
 EX19MTAUEB001.ant.amazon.com (10.252.135.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Thu, 5 Oct 2023 14:59:32 +0000
Received: from [10.136.71.253] (10.136.71.253) by
 EX19D028UEC003.ant.amazon.com (10.252.137.159) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Thu, 5 Oct 2023 14:59:31 +0000
Message-ID: <010edf5a-453d-4c98-9c07-12e75d3f983c@amazon.com>
Date:   Thu, 5 Oct 2023 10:59:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        <krisman@suse.de>, <will@kernel.org>
CC:     Greg KH <gregkh@linuxfoundation.org>, <anshuman.khandual@arm.com>,
        <catalin.marinas@arm.com>
From:   Luiz Capitulino <luizcap@amazon.com>
Subject: [5.15,6.1] Please apply a89c6bcdac22bec1bfbe6e64060b4cf5838d4f47
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.71.253]
X-ClientProxiedBy: EX19D042UWB003.ant.amazon.com (10.13.139.135) To
 EX19D028UEC003.ant.amazon.com (10.252.137.159)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

We found that commits 46bdb4277f98 and 0388f9c74330 (merged in v5.12)
introduced more than 40% performance regression in UnixBench's process
creation benchmark when comparing 5.10 with 5.15 and 6.1 on AWS'
virtualized Graviton instances.

This has been mostly fixed by the following upstream commit:

"""
commit a89c6bcdac22bec1bfbe6e64060b4cf5838d4f47
Author: Gabriel Krisman Bertazi <krisman@suse.de>
Date: Mon Jan 9 12:19:55 2023 -0300

  arm64: Avoid repeated AA64MMFR1_EL1 register read on pagefault path
"""
(This is merged in v6.3 and applies cleanly in 5.15 and 6.1).

We performed functional and performance regression tests on both 5.15
and 6.1 with this patch applied. We can also observe 10% improvement
in system time in other benchmarks.

Just to be transparent, we initially observed 5% degradation in a
benchmark we have with fio randwrite on EBS volumes with our 6.1
downstream kernel but this doesn't seem reproducible and we don't
think this patch would cause it.

Here's some quick UnixBench process creation measurements on
m7gd.16xlarge instance type. All results are the average of 5
consecutive runs with a single process:

* 5.10.197: 9886.68 lps (baseline)
* 6.1.55:   5531.24 lps (unfixed - 44% degradation)
* 5.15.133: 5960.12 lps (unfixed - 39% degradation)
* 5.15.133: 10306.4 lps (fixed - actually better than baseline)
* 6.1.55:   9393.42 lps (fixed - degradation reduced to 5%)

- Luiz
