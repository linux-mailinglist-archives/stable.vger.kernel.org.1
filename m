Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2AF75CD91
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjGUQNG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbjGUQMe (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:12:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7302230CD
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:12:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED57361D33
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:12:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04CC9C433C7;
        Fri, 21 Jul 2023 16:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689955923;
        bh=gLWNuskCrEmChBfgU+WEFbhj8JOf1/Zk5pHQGSBAOcY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZS/Bt3aor2CQoM49ZpzjQKBLdVms5xzT59mim8KK1ystfz6p+lGxzvd2fV4ormj/A
         Lyy6HB25xiVDg5RwPJhmd9TAz5KzxLhw/S5J5wjzGCDbRKZKFp91ldNqktbIVNeSS7
         eEM7cmi2yqx7ctvLOb5bN/6TWN2CoyN3va/DbjZI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nitya Sunkad <nitya.sunkad@amd.com>,
        Shannon Nelson <shannon.nelson@amd.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 050/292] ionic: remove WARN_ON to prevent panic_on_warn
Date:   Fri, 21 Jul 2023 18:02:39 +0200
Message-ID: <20230721160530.952356759@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Nitya Sunkad <nitya.sunkad@amd.com>

[ Upstream commit abfb2a58a5377ebab717d4362d6180f901b6e5c1 ]

Remove unnecessary early code development check and the WARN_ON
that it uses.  The irq alloc and free paths have long been
cleaned up and this check shouldn't have stuck around so long.

Fixes: 77ceb68e29cc ("ionic: Add notifyq support")
Signed-off-by: Nitya Sunkad <nitya.sunkad@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/pensando/ionic/ionic_lif.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 957027e546b30..e03a94f2469ab 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -474,11 +474,6 @@ static void ionic_qcqs_free(struct ionic_lif *lif)
 static void ionic_link_qcq_interrupts(struct ionic_qcq *src_qcq,
 				      struct ionic_qcq *n_qcq)
 {
-	if (WARN_ON(n_qcq->flags & IONIC_QCQ_F_INTR)) {
-		ionic_intr_free(n_qcq->cq.lif->ionic, n_qcq->intr.index);
-		n_qcq->flags &= ~IONIC_QCQ_F_INTR;
-	}
-
 	n_qcq->intr.vector = src_qcq->intr.vector;
 	n_qcq->intr.index = src_qcq->intr.index;
 	n_qcq->napi_qcq = src_qcq->napi_qcq;
-- 
2.39.2



