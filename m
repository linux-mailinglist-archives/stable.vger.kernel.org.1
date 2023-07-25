Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5FB7616DE
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjGYLod (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233115AbjGYLoV (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:44:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A50F1BE9
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:44:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8F7C61654
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:44:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2E8C433C8;
        Tue, 25 Jul 2023 11:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690285443;
        bh=p5QsjKC+cpuRZIC25h8xVJBXEs+Dpw6qX/zwwWM42yM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iZ+BOVHImDMBXGwGWiZyPbHjbzZfLhg3YWvLhGZ/rQfEihK8oD+AdK7LPiocynjeY
         ueRbKbkhfejW5dA+3kiNn7k0Az0FgKSdS0hGvxLunvSbqePiuOntoqC/4zJZhcCI6K
         YwKeZYelYmYUuoM5On3iVSwkLiZTNY4LdHfzAOHI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shannon Nelson <snelson@pensando.io>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 206/313] ionic: ionic_intr_free parameter change
Date:   Tue, 25 Jul 2023 12:45:59 +0200
Message-ID: <20230725104529.920849403@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Shannon Nelson <snelson@pensando.io>

[ Upstream commit 36ac2c50924892a28e17ff463e354fec7650ee19 ]

Change the ionic_intr_free parameter from struct ionic_lif to
struct ionic since that's what it actually cares about.

Signed-off-by: Shannon Nelson <snelson@pensando.io>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: abfb2a58a537 ("ionic: remove WARN_ON to prevent panic_on_warn")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/pensando/ionic/ionic_lif.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 3fc9ac1e8b7b7..52d291383c233 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -167,10 +167,10 @@ static int ionic_intr_alloc(struct ionic_lif *lif, struct ionic_intr_info *intr)
 	return 0;
 }
 
-static void ionic_intr_free(struct ionic_lif *lif, int index)
+static void ionic_intr_free(struct ionic *ionic, int index)
 {
-	if (index != INTR_INDEX_NOT_ASSIGNED && index < lif->ionic->nintrs)
-		clear_bit(index, lif->ionic->intrs);
+	if (index != INTR_INDEX_NOT_ASSIGNED && index < ionic->nintrs)
+		clear_bit(index, ionic->intrs);
 }
 
 static int ionic_qcq_enable(struct ionic_qcq *qcq)
@@ -289,7 +289,7 @@ static void ionic_qcq_free(struct ionic_lif *lif, struct ionic_qcq *qcq)
 		irq_set_affinity_hint(qcq->intr.vector, NULL);
 		devm_free_irq(dev, qcq->intr.vector, &qcq->napi);
 		qcq->intr.vector = 0;
-		ionic_intr_free(lif, qcq->intr.index);
+		ionic_intr_free(lif->ionic, qcq->intr.index);
 	}
 
 	devm_kfree(dev, qcq->cq.info);
@@ -333,7 +333,7 @@ static void ionic_link_qcq_interrupts(struct ionic_qcq *src_qcq,
 				      struct ionic_qcq *n_qcq)
 {
 	if (WARN_ON(n_qcq->flags & IONIC_QCQ_F_INTR)) {
-		ionic_intr_free(n_qcq->cq.lif, n_qcq->intr.index);
+		ionic_intr_free(n_qcq->cq.lif->ionic, n_qcq->intr.index);
 		n_qcq->flags &= ~IONIC_QCQ_F_INTR;
 	}
 
@@ -485,7 +485,7 @@ static int ionic_qcq_alloc(struct ionic_lif *lif, unsigned int type,
 		devm_free_irq(dev, new->intr.vector, &new->napi);
 err_out_free_intr:
 	if (flags & IONIC_QCQ_F_INTR)
-		ionic_intr_free(lif, new->intr.index);
+		ionic_intr_free(lif->ionic, new->intr.index);
 err_out:
 	dev_err(dev, "qcq alloc of %s%d failed %d\n", name, index, err);
 	return err;
-- 
2.39.2



