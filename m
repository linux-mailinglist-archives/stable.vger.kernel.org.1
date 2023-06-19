Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E1A7352CF
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbjFSKi0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbjFSKiP (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:38:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426D8106
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:38:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4A4260B42
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:38:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D03C433C9;
        Mon, 19 Jun 2023 10:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171094;
        bh=lR6rO+UXjo9mM+Qs2jK8/hIHUKKhr3g/CBl9gj72dXc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1nYFJ07eRdK7FGHik/kmUYfqqK6HpY9VYDjw5t85tSp8wf2e8skctdLa82AYT5aCU
         KDSQIgoxCOWVU8V7BCqWD9IZQNR4eXyNYdkvZRmT2gg8/DsjNDqWY98s/4ymWaQRu1
         Dmxq/rAhnoZw/ckTu0hLDdom8koh/Oh4RE5w1j60=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 145/187] IB/isert: Fix possible list corruption in CMA handler
Date:   Mon, 19 Jun 2023 12:29:23 +0200
Message-ID: <20230619102204.674332935@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Saravanan Vajravel <saravanan.vajravel@broadcom.com>

[ Upstream commit 7651e2d6c5b359a28c2d4c904fec6608d1021ca8 ]

When ib_isert module receives connection error event, it is
releasing the isert session and removes corresponding list
node but it doesn't take appropriate mutex lock to remove
the list node.  This can lead to linked  list corruption

Fixes: bd3792205aae ("iser-target: Fix pending connections handling in target stack shutdown sequnce")
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Link: https://lore.kernel.org/r/20230606102531.162967-3-saravanan.vajravel@broadcom.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/ulp/isert/ib_isert.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index b4809d2372506..00a7303c8cc60 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -657,9 +657,13 @@ static int
 isert_connect_error(struct rdma_cm_id *cma_id)
 {
 	struct isert_conn *isert_conn = cma_id->qp->qp_context;
+	struct isert_np *isert_np = cma_id->context;
 
 	ib_drain_qp(isert_conn->qp);
+
+	mutex_lock(&isert_np->mutex);
 	list_del_init(&isert_conn->node);
+	mutex_unlock(&isert_np->mutex);
 	isert_conn->cm_id = NULL;
 	isert_put_conn(isert_conn);
 
-- 
2.39.2



