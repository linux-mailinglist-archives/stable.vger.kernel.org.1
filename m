Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8AEF790213
	for <lists+stable@lfdr.de>; Fri,  1 Sep 2023 20:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjIASf0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 1 Sep 2023 14:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjIASfZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 1 Sep 2023 14:35:25 -0400
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12712107
        for <stable@vger.kernel.org>; Fri,  1 Sep 2023 11:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1693593324; x=1725129324;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cYtaq5iMz0ESadhzBAILT/+mTDYrPD/8ev09ZQ+hv4M=;
  b=iEKyGr3O9nmd7sXBdh6dG8jBNaP7SbRh/NytZDqcs8KnXcBPhtVAMc+6
   HJs2Xk9za59qkPmMQvnV6znlFARAJ9f4YZ7irw8IiwTQqvLXRfrN1eBtq
   7M7Me4xpWY45+7t9goZYqkA3Ql+/3JFUvT1W9XcSvuoVfj80Ahe6dapNR
   8=;
X-IronPort-AV: E=Sophos;i="6.02,220,1688428800"; 
   d="scan'208";a="302680700"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-25ac6bd5.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 18:35:17 +0000
Received: from EX19MTAUEB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1d-m6i4x-25ac6bd5.us-east-1.amazon.com (Postfix) with ESMTPS id 2262647846;
        Fri,  1 Sep 2023 18:35:14 +0000 (UTC)
Received: from EX19D028UEC003.ant.amazon.com (10.252.137.159) by
 EX19MTAUEB001.ant.amazon.com (10.252.135.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 1 Sep 2023 18:35:14 +0000
Received: from dev-dsk-luizcap-1d-37beaf15.us-east-1.amazon.com (10.39.210.33)
 by EX19D028UEC003.ant.amazon.com (10.252.137.159) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 1 Sep 2023 18:35:13 +0000
From:   Luiz Capitulino <luizcap@amazon.com>
To:     <stable@vger.kernel.org>, <seanjc@google.com>,
        <christophe.jaillet@wanadoo.fr>
CC:     <lcapitulino@gmail.com>, Luiz Capitulino <luizcap@amazon.com>
Subject: [PATH 6.1.y 0/2] Backport KVM's nx_huge_pages=never module parameter
Date:   Fri, 1 Sep 2023 18:34:51 +0000
Message-ID: <cover.1693593288.git.luizcap@amazon.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.39.210.33]
X-ClientProxiedBy: EX19D041UWA001.ant.amazon.com (10.13.139.124) To
 EX19D028UEC003.ant.amazon.com (10.252.137.159)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

As part of the mitigation for the iTLB multihit vulnerability, KVM creates
a worker thread in KVM_CREATE_VM ioctl(). This thread calls
cgroup_attach_task_all() which takes cgroup_threadgroup_rwsem for writing
which may incur 100ms+ latency since upstream commit
6a010a49b63ac8465851a79185d8deff966f8e1a.

However, if the CPU is not vulnerable to iTLB multihit one could just
disable the mitigation (and the worker thread creation) with the
newly added KVM module parameter nx_huge_pages=never. This avoids the issue
altogether.

While there's an alternative solution for this issue already supported
in 6.1-stable (ie. cgroup's favordynmods), disabling the mitigation in
KVM is probably preferable if the workload is not impacted by dynamic
cgroup operations since one doesn't need to decide between the trade-off
in using favordynmods, the thread creation code path is avoided at
KVM_CREATE_VM and you avoid creating a thread which does nothing.

Tests performed:

* Measured KVM_CREATE_VM latency and confirmed it goes down to less than 1ms
* We've been performing latency measurements internally w/ this parameter
  for some weeks now

Christophe JAILLET (1):
  KVM: x86/mmu: Use kstrtobool() instead of strtobool()

Sean Christopherson (1):
  KVM: x86/mmu: Add "never" option to allow sticky disabling of
    nx_huge_pages

 arch/x86/kvm/mmu/mmu.c | 42 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

-- 
2.40.1

