Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0216A7A8AE3
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 19:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjITRwM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 13:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjITRwL (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 13:52:11 -0400
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA1594
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 10:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1695232326; x=1726768326;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=G52RA9Oxwi3Ae8oA2Q20EXNBVX6Kl5t2/hFkYK2oD3o=;
  b=ANnUuYL7VPQIn6ncek9GnRuEYfP5plCw2WNuEUyS5Tm8UMPqz3welzK6
   IW5Wu67lILhE8YrSFS2wR7rJkAy4zPenWwKu8OQcKSuzi90Tt9pBbwW+n
   uyCjjLgmUa+tYoGmsGYSZepfGROaR35VtC5nm+7HyOG6v9zNadooXM0oh
   U=;
X-IronPort-AV: E=Sophos;i="6.03,162,1694736000"; 
   d="scan'208";a="605570610"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-5eae960a.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 17:52:05 +0000
Received: from EX19MTAUWB002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2c-m6i4x-5eae960a.us-west-2.amazon.com (Postfix) with ESMTPS id 0D84F40D90;
        Wed, 20 Sep 2023 17:52:04 +0000 (UTC)
Received: from EX19D046UWB004.ant.amazon.com (10.13.139.164) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 20 Sep 2023 17:52:01 +0000
Received: from dev-dsk-shaoyi-2b-b6ac9e9c.us-west-2.amazon.com (10.189.91.91)
 by EX19D046UWB004.ant.amazon.com (10.13.139.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 20 Sep 2023 17:52:00 +0000
From:   Shaoying Xu <shaoyi@amazon.com>
To:     <stable@vger.kernel.org>, <markovicbudimir@gmail.com>
CC:     <shaoyi@amazon.com>, Jamal Hadi Salim <jhs@mojatatu.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 4.14] net/sched: sch_hfsc: Ensure inner classes have fsc curve
Date:   Wed, 20 Sep 2023 17:51:45 +0000
Message-ID: <20230920175145.23384-1-shaoyi@amazon.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.189.91.91]
X-ClientProxiedBy: EX19D040UWB003.ant.amazon.com (10.13.138.8) To
 EX19D046UWB004.ant.amazon.com (10.13.139.164)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Budimir Markovic <markovicbudimir@gmail.com>

[ Upstream commit b3d26c5702c7d6c45456326e56d2ccf3f103e60f ]

HFSC assumes that inner classes have an fsc curve, but it is currently
possible for classes without an fsc curve to become parents. This leads
to bugs including a use-after-free.

Don't allow non-root classes without HFSC_FSC to become parents.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Budimir Markovic <markovicbudimir@gmail.com>
Signed-off-by: Budimir Markovic <markovicbudimir@gmail.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Link: https://lore.kernel.org/r/20230824084905.422-1-markovicbudimir@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ v4.14: Delete NL_SET_ERR_MSG because extack is not added to hfsc_change_class ]
Cc: <stable@vger.kernel.org> # 4.14 
Signed-off-by: Shaoying Xu <shaoyi@amazon.com>
---
 net/sched/sch_hfsc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index 3f88b75488b0..3a43abe4d9c4 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -1020,6 +1020,8 @@ hfsc_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 		if (parent == NULL)
 			return -ENOENT;
 	}
+	if (!(parent->cl_flags & HFSC_FSC) && parent != &q->root)
+		return -EINVAL;
 
 	if (classid == 0 || TC_H_MAJ(classid ^ sch->handle) != 0)
 		return -EINVAL;
-- 
2.40.1

