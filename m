Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E1E7A51BC
	for <lists+stable@lfdr.de>; Mon, 18 Sep 2023 20:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjIRSJ3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 18 Sep 2023 14:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjIRSJ3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 18 Sep 2023 14:09:29 -0400
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B75115
        for <stable@vger.kernel.org>; Mon, 18 Sep 2023 11:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1695060564; x=1726596564;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mGVD83ek5ThwcMZR9IY+TwFuTT5gBh13JZXfxw80e9o=;
  b=X1auLxDfy18TbuYesgoEKT+9Ul63niuyCWZJs1WpugLN3PVYQdE5wsdl
   ows5Aw03S5dFXPgKk+ASHHoJRN46IyAXEshNuXshOoYQQr2rc5VB0ix9X
   yp0aALrBw5ewm3N/KjRRZ65wJzCCWqRIFvvTc9gd77r4/h36uMwlq4loz
   E=;
X-IronPort-AV: E=Sophos;i="6.02,157,1688428800"; 
   d="scan'208";a="155039045"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-b538c141.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 18:09:22 +0000
Received: from EX19MTAUEC002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1e-m6i4x-b538c141.us-east-1.amazon.com (Postfix) with ESMTPS id 846C4A09D9;
        Mon, 18 Sep 2023 18:09:19 +0000 (UTC)
Received: from EX19D028UEC003.ant.amazon.com (10.252.137.159) by
 EX19MTAUEC002.ant.amazon.com (10.252.135.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Mon, 18 Sep 2023 18:09:19 +0000
Received: from dev-dsk-luizcap-1d-37beaf15.us-east-1.amazon.com (10.39.210.33)
 by EX19D028UEC003.ant.amazon.com (10.252.137.159) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Mon, 18 Sep 2023 18:09:17 +0000
From:   Luiz Capitulino <luizcap@amazon.com>
To:     <stable@vger.kernel.org>, <sec@valis.email>
CC:     Bing-Jhong Billy Jheng <billy@starlabs.sg>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Victor Nogueira <victor@mojatatu.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        M A Ramdhan <ramdhan@starlabs.sg>,
        Jakub Kicinski <kuba@kernel.org>,
        Luiz Capitulino <luizcap@amazon.com>
Subject: [PATH 4.14.y] net/sched: cls_fw: No longer copy tcf_result on update to avoid use-after-free
Date:   Mon, 18 Sep 2023 18:08:59 +0000
Message-ID: <20230918180859.24397-1-luizcap@amazon.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.39.210.33]
X-ClientProxiedBy: EX19D043UWC002.ant.amazon.com (10.13.139.222) To
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

From: valis <sec@valis.email>

Commit 76e42ae831991c828cffa8c37736ebfb831ad5ec upstream.

[ Fixed small conflict as 'fnew->ifindex' assignment is not protected by
  CONFIG_NET_CLS_IND on upstream since a51486266c3 ]

When fw_change() is called on an existing filter, the whole
tcf_result struct is always copied into the new instance of the filter.

This causes a problem when updating a filter bound to a class,
as tcf_unbind_filter() is always called on the old instance in the
success path, decreasing filter_cnt of the still referenced class
and allowing it to be deleted, leading to a use-after-free.

Fix this by no longer copying the tcf_result struct from the old filter.

Fixes: e35a8ee5993b ("net: sched: fw use RCU")
Reported-by: valis <sec@valis.email>
Reported-by: Bing-Jhong Billy Jheng <billy@starlabs.sg>
Signed-off-by: valis <sec@valis.email>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
Reviewed-by: M A Ramdhan <ramdhan@starlabs.sg>
Link: https://lore.kernel.org/r/20230729123202.72406-3-jhs@mojatatu.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Luiz Capitulino <luizcap@amazon.com>
---
 net/sched/cls_fw.c | 1 -
 1 file changed, 1 deletion(-)

Valis, Greg,

I noticed that 4.14 is missing this fix while we backported all three fixes
from this series to all stable kernels:

https://lore.kernel.org/all/20230729123202.72406-1-jhs@mojatatu.com

Is there a reason to have skipped 4.14 for this fix? It seems we need it.

This is only compiled-tested though, would be good to have a confirmation
from Valis that the issue is present on 4.14 before applying.

- Luiz

diff --git a/net/sched/cls_fw.c b/net/sched/cls_fw.c
index e63f9c2e37e5..7b04b315b2bd 100644
--- a/net/sched/cls_fw.c
+++ b/net/sched/cls_fw.c
@@ -281,7 +281,6 @@ static int fw_change(struct net *net, struct sk_buff *in_skb,
 			return -ENOBUFS;
 
 		fnew->id = f->id;
-		fnew->res = f->res;
 #ifdef CONFIG_NET_CLS_IND
 		fnew->ifindex = f->ifindex;
 #endif /* CONFIG_NET_CLS_IND */
-- 
2.40.1

