Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5EF7AF989
	for <lists+stable@lfdr.de>; Wed, 27 Sep 2023 06:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjI0Egj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 27 Sep 2023 00:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjI0Efb (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 27 Sep 2023 00:35:31 -0400
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC77830E0
        for <stable@vger.kernel.org>; Tue, 26 Sep 2023 20:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1695784931; x=1727320931;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ALMs96ZLV1lf74jqijLGM86o5suDIQZDXuKzYlxRxG0=;
  b=RbCKzc0iAf0yQNFqbTyWTQcec62l0Qq3Zzdgjl45HhA1OsY6tTtTC67m
   2z7EP5He6/Gj0T46XLfHFKBCrdpA4aTp82dvFpCTT9qQvARg1MFG881vL
   TFTQp1Fpwsi/N7zXFv87S/T5Nu7ZMojL1tN6OWVc0v4EIckCmLgeD2rSG
   w=;
X-IronPort-AV: E=Sophos;i="6.03,179,1694736000"; 
   d="scan'208";a="360881534"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-9694bb9e.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 03:22:10 +0000
Received: from EX19MTAUWC001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1e-m6i4x-9694bb9e.us-east-1.amazon.com (Postfix) with ESMTPS id 762F382B93;
        Wed, 27 Sep 2023 03:22:09 +0000 (UTC)
Received: from EX19D046UWB004.ant.amazon.com (10.13.139.164) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 27 Sep 2023 03:22:08 +0000
Received: from dev-dsk-shaoyi-2b-b6ac9e9c.us-west-2.amazon.com (10.189.91.91)
 by EX19D046UWB004.ant.amazon.com (10.13.139.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 27 Sep 2023 03:22:07 +0000
From:   Shaoying Xu <shaoyi@amazon.com>
To:     <markovicbudimir@gmail.com>, <stable@vger.kernel.org>
CC:     <jhs@mojatatu.com>, <kuba@kernel.org>, <shaoyi@amazon.com>
Subject: Re: [PATCH 4.14] net/sched: sch_hfsc: Ensure inner classes have fsc curve
Date:   Wed, 27 Sep 2023 03:21:52 +0000
Message-ID: <20230927032152.10448-1-shaoyi@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230920175145.23384-1-shaoyi@amazon.com>
References: <20230920175145.23384-1-shaoyi@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.189.91.91]
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D046UWB004.ant.amazon.com (10.13.139.164)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Budimir, Greg,

Sorry to bother again with this patch but it fixes the CVE-2023-4623 and has also been backported to all stable kernels other than v4.14 so I wonder is there a reason to skip v4.14? I removed the NL_SET_ERR_MSG call because extack is not added to hfsc_change_class in 4.14 and hope to get some confirmation if it can be applied to 4.14 tree. 

Thanks,
Shaoying

< On 2023-09-20, 10:52 AM, "Xu, Shaoying" <shaoyi@amazon.com <mailto:shaoyi@amazon.com>> wrote:
< 
< 
< From: Budimir Markovic <markovicbudimir@gmail.com <mailto:markovicbudimir@gmail.com>>
< 
< 
< [ Upstream commit b3d26c5702c7d6c45456326e56d2ccf3f103e60f ]
< 
< 
< HFSC assumes that inner classes have an fsc curve, but it is currently
< possible for classes without an fsc curve to become parents. This leads
< to bugs including a use-after-free.
< 
< 
< Don't allow non-root classes without HFSC_FSC to become parents.
< 
< 
< Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
< Reported-by: Budimir Markovic <markovicbudimir@gmail.com <mailto:markovicbudimir@gmail.com>>
< Signed-off-by: Budimir Markovic <markovicbudimir@gmail.com <mailto:markovicbudimir@gmail.com>>
< Acked-by: Jamal Hadi Salim <jhs@mojatatu.com <mailto:jhs@mojatatu.com>>
< Link: https://lore.kernel.org/r/20230824084905.422-1-markovicbudimir@gmail.com <mailto:20230824084905.422-1-markovicbudimir@gmail.com>
< Signed-off-by: Jakub Kicinski <kuba@kernel.org <mailto:kuba@kernel.org>>
< [ v4.14: Delete NL_SET_ERR_MSG because extack is not added to hfsc_change_class ]
< Cc: <stable@vger.kernel.org <mailto:stable@vger.kernel.org>> # 4.14 
< Signed-off-by: Shaoying Xu <shaoyi@amazon.com <mailto:shaoyi@amazon.com>>
< ---
< net/sched/sch_hfsc.c | 2 ++
< 1 file changed, 2 insertions(+)
< 
< 
< diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
< index 3f88b75488b0..3a43abe4d9c4 100644
< --- a/net/sched/sch_hfsc.c
< +++ b/net/sched/sch_hfsc.c
< @@ -1020,6 +1020,8 @@ hfsc_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
< if (parent == NULL)
< return -ENOENT;
< }
< + if (!(parent->cl_flags & HFSC_FSC) && parent != &q->root)
< + return -EINVAL;
< 
< 
< if (classid == 0 || TC_H_MAJ(classid ^ sch->handle) != 0)
< return -EINVAL;
< -- 
< 2.40.1
< 
