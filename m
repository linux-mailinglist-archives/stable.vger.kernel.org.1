Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B907ECC81
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbjKOTa4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234029AbjKOTay (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:30:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85912D49
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:30:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A63C433C8;
        Wed, 15 Nov 2023 19:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076650;
        bh=HIHrYZ10IEElxA2qz3NgSwkNu3lh9kFTeKT5uZTn2Us=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NbPzJCAkPRvSzzBy+gY30Ndeoq7LW+pOM56gyQ0EI5n06yhKaQwWtpYLVp+uNgsYt
         oiuIoc7MFwVtjIvUS4HWKNfVEeOuxSuf9Hk/pYj0AnRkK/5lCBKicHbisbS3Z1fOvZ
         ljoVrkqmkKl7F/hcU9EznmZwwnLF5fUJSgvxo/yE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mikulas Patocka <mpatocka@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 362/550] crypto: qat - fix deadlock in backlog processing
Date:   Wed, 15 Nov 2023 14:15:46 -0500
Message-ID: <20231115191625.907822351@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

[ Upstream commit 203b01001c4d741205b9c329acddc5193ed56fbd ]

If a request has the flag CRYPTO_TFM_REQ_MAY_BACKLOG set, the function
qat_alg_send_message_maybacklog(), enqueues it in a backlog list if
either (1) there is already at least one request in the backlog list, or
(2) the HW ring is nearly full or (3) the enqueue to the HW ring fails.
If an interrupt occurs right before the lock in qat_alg_backlog_req() is
taken and the backlog queue is being emptied, then there is no request
in the HW queues that can trigger a subsequent interrupt that can clear
the backlog queue. In addition subsequent requests are enqueued to the
backlog list and not sent to the hardware.

Fix it by holding the lock while taking the decision if the request
needs to be included in the backlog queue or not. This synchronizes the
flow with the interrupt handler that drains the backlog queue.

For performance reasons, the logic has been changed to try to enqueue
first without holding the lock.

Fixes: 386823839732 ("crypto: qat - add backlog mechanism")
Reported-by: Mikulas Patocka <mpatocka@redhat.com>
Closes: https://lore.kernel.org/all/af9581e2-58f9-cc19-428f-6f18f1f83d54@redhat.com/T/
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../intel/qat/qat_common/qat_algs_send.c      | 46 ++++++++++---------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/drivers/crypto/intel/qat/qat_common/qat_algs_send.c b/drivers/crypto/intel/qat/qat_common/qat_algs_send.c
index bb80455b3e81e..b97b678823a97 100644
--- a/drivers/crypto/intel/qat/qat_common/qat_algs_send.c
+++ b/drivers/crypto/intel/qat/qat_common/qat_algs_send.c
@@ -40,40 +40,44 @@ void qat_alg_send_backlog(struct qat_instance_backlog *backlog)
 	spin_unlock_bh(&backlog->lock);
 }
 
-static void qat_alg_backlog_req(struct qat_alg_req *req,
-				struct qat_instance_backlog *backlog)
-{
-	INIT_LIST_HEAD(&req->list);
-
-	spin_lock_bh(&backlog->lock);
-	list_add_tail(&req->list, &backlog->list);
-	spin_unlock_bh(&backlog->lock);
-}
-
-static int qat_alg_send_message_maybacklog(struct qat_alg_req *req)
+static bool qat_alg_try_enqueue(struct qat_alg_req *req)
 {
 	struct qat_instance_backlog *backlog = req->backlog;
 	struct adf_etr_ring_data *tx_ring = req->tx_ring;
 	u32 *fw_req = req->fw_req;
 
-	/* If any request is already backlogged, then add to backlog list */
+	/* Check if any request is already backlogged */
 	if (!list_empty(&backlog->list))
-		goto enqueue;
+		return false;
 
-	/* If ring is nearly full, then add to backlog list */
+	/* Check if ring is nearly full */
 	if (adf_ring_nearly_full(tx_ring))
-		goto enqueue;
+		return false;
 
-	/* If adding request to HW ring fails, then add to backlog list */
+	/* Try to enqueue to HW ring */
 	if (adf_send_message(tx_ring, fw_req))
-		goto enqueue;
+		return false;
 
-	return -EINPROGRESS;
+	return true;
+}
 
-enqueue:
-	qat_alg_backlog_req(req, backlog);
 
-	return -EBUSY;
+static int qat_alg_send_message_maybacklog(struct qat_alg_req *req)
+{
+	struct qat_instance_backlog *backlog = req->backlog;
+	int ret = -EINPROGRESS;
+
+	if (qat_alg_try_enqueue(req))
+		return ret;
+
+	spin_lock_bh(&backlog->lock);
+	if (!qat_alg_try_enqueue(req)) {
+		list_add_tail(&req->list, &backlog->list);
+		ret = -EBUSY;
+	}
+	spin_unlock_bh(&backlog->lock);
+
+	return ret;
 }
 
 int qat_alg_send_message(struct qat_alg_req *req)
-- 
2.42.0



