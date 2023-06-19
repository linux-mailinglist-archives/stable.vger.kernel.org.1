Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E82E735445
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbjFSKyR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbjFSKyB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:54:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD462713
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:52:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0844760B85
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:52:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE37C433C9;
        Mon, 19 Jun 2023 10:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171953;
        bh=9zC6zB+wZ1N/07qdosmEqmUCaeaPV3gAFT5FxSa3CD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e2bLU4IINZfyI8jJx1ydcakS8eTrPAtoDBBBj4WcOUrPB7JNyQ3TgRKp+Csz193ZB
         hSlcp9MxZLvPauIeHhlvfGj2f03TRTvYB0wBosT7syoU3JTXn5NXXA2Icw+FWEBYko
         smdHTrxkRj4R2As3s25LCq1si8ko7ycW/Auc2c5k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sagi Grimberg <sagi@grimberg.me>,
        Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 48/64] IB/isert: Fix incorrect release of isert connection
Date:   Mon, 19 Jun 2023 12:30:44 +0200
Message-ID: <20230619102135.380115097@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102132.808972458@linuxfoundation.org>
References: <20230619102132.808972458@linuxfoundation.org>
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

[ Upstream commit 699826f4e30ab76a62c238c86fbef7e826639c8d ]

The ib_isert module is releasing the isert connection both in
isert_wait_conn() handler as well as isert_free_conn() handler.
In isert_wait_conn() handler, it is expected to wait for iSCSI
session logout operation to complete. It should free the isert
connection only in isert_free_conn() handler.

When a bunch of iSER target is cleared, this issue can lead to
use-after-free memory issue as isert conn is twice released

Fixes: b02efbfc9a05 ("iser-target: Fix implicit termination of connections")
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Link: https://lore.kernel.org/r/20230606102531.162967-4-saravanan.vajravel@broadcom.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/ulp/isert/ib_isert.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index 6ff92dca2898c..5bb1fc7fd79c9 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -2646,8 +2646,6 @@ static void isert_wait_conn(struct iscsi_conn *conn)
 	isert_put_unsol_pending_cmds(conn);
 	isert_wait4cmds(conn);
 	isert_wait4logout(isert_conn);
-
-	queue_work(isert_release_wq, &isert_conn->release_work);
 }
 
 static void isert_free_conn(struct iscsi_conn *conn)
-- 
2.39.2



