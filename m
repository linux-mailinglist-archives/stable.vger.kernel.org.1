Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B6B7A386C
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239749AbjIQTfa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239835AbjIQTfU (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:35:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13D6D9
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:35:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E208FC433C8;
        Sun, 17 Sep 2023 19:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979315;
        bh=Nk+uhoeS+GC/gM+xgHH0UlHdEWoYGCSEcCYEi5WJo8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wwbcvT8OCHcrGkaCk+XQm3R9+T0pVHqNYOHYecgGrlHPiqGrnB8r4ZjXLNSrXlyMt
         fj0mU8j4L+ZbHT13/6lCpKHJdXOsObpGAfsUUlix4CUhLGb6Zi0An5W6PaPzmMQ1Xn
         qUvP88P2xZcX75yjNlrdJYRRPsG8008e7L1SlWY4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Guoqing Jiang <guoqing.jiang@linux.dev>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 250/406] RDMA/siw: Balance the reference of cep->kref in the error path
Date:   Sun, 17 Sep 2023 21:11:44 +0200
Message-ID: <20230917191107.767170118@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guoqing Jiang <guoqing.jiang@linux.dev>

[ Upstream commit b056327bee09e6b86683d3f709a438ccd6031d72 ]

The siw_connect can go to err in below after cep is allocated successfully:

1. If siw_cm_alloc_work returns failure. In this case socket is not
assoicated with cep so siw_cep_put can't be called by siw_socket_disassoc.
We need to call siw_cep_put twice since cep->kref is increased once after
it was initialized.

2. If siw_cm_queue_work can't find a work, which means siw_cep_get is not
called in siw_cm_queue_work, so cep->kref is increased twice by siw_cep_get
and when associate socket with cep after it was initialized. So we need to
call siw_cep_put three times (one in siw_socket_disassoc).

3. siw_send_mpareqrep returns error, this scenario is similar as 2.

So we need to remove one siw_cep_put in the error path.

Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
Link: https://lore.kernel.org/r/20230821133255.31111-2-guoqing.jiang@linux.dev
Acked-by: Bernard Metzler <bmt@zurich.ibm.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/sw/siw/siw_cm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index b87ba4c9fccf1..de5ab282ac748 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1490,7 +1490,6 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 
 		cep->cm_id = NULL;
 		id->rem_ref(id);
-		siw_cep_put(cep);
 
 		qp->cep = NULL;
 		siw_cep_put(cep);
-- 
2.40.1



