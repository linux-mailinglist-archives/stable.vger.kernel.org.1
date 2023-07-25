Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086D8761561
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbjGYL2X (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234748AbjGYL2R (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:28:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF11F2
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:28:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 101CA6168F
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:28:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DCBEC433C8;
        Tue, 25 Jul 2023 11:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284495;
        bh=VCStJtW9b0/acHdgV8GYOy+SIhK3ubEeYm2cwOIX8OU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tIZ84hx3GC74SQaX3d1wCTjlkwAwVpCSdw6hzZKs9+rEEgovCTUJPkIywmBfdoyWb
         vQqFTuNYMfnk0hQFGHj+OAwPF8YCocMQ+YKBUINJJtzNXJ3Qk6gwDilY49aa4cwIc9
         z7L4333y13muqUMT0ovTuGeBGuZEeAhqlIjkLs+g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nitya Sunkad <nitya.sunkad@amd.com>,
        Shannon Nelson <shannon.nelson@amd.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 347/509] ionic: remove WARN_ON to prevent panic_on_warn
Date:   Tue, 25 Jul 2023 12:44:46 +0200
Message-ID: <20230725104609.623441745@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
index fcd4213c99b83..098772601df8c 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -433,11 +433,6 @@ static void ionic_qcqs_free(struct ionic_lif *lif)
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
 }
-- 
2.39.2



