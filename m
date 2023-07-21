Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FB175CD74
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbjGUQLY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbjGUQLA (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:11:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702A535BF
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:10:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D697061D2B
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:10:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E37A8C433C7;
        Fri, 21 Jul 2023 16:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689955855;
        bh=m1jRmP/X+sjq2Vr2SGOPIrFuA6zf9N5KECFmGmsH2S4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k39DZiwrEYu9uUNucUjmcTucuG9w6+JP823wN2HHtONNuUA0jzUja1s8FejUAdvyx
         sByWW0LJs5mDulkPHB7W4hXWiEb4raOBaPgTjNrcXRpAY79HEQVic3OySqz6NgPPCL
         StSo4QhezZP0b03KzMzRDXhZWotbuTmYUDW4lUSE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Niklas Schnelle <schnelle@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 054/292] s390/ism: Fix locking for forwarding of IRQs and events to clients
Date:   Fri, 21 Jul 2023 18:02:43 +0200
Message-ID: <20230721160531.121345804@linuxfoundation.org>
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

From: Niklas Schnelle <schnelle@linux.ibm.com>

[ Upstream commit 6b5c13b591d753c6022fbd12f8c0c0a9a07fc065 ]

The clients array references all registered clients and is protected by
the clients_lock. Besides its use as general list of clients the clients
array is accessed in ism_handle_irq() to forward ISM device events to
clients.

While the clients_lock is taken in the IRQ handler when calling
handle_event() it is however incorrectly not held during the
client->handle_irq() call and for the preceding clients[] access leaving
it unprotected against concurrent client (un-)registration.

Furthermore the accesses to ism->sba_client_arr[] in ism_register_dmb()
and ism_unregister_dmb() are not protected by any lock. This is
especially problematic as the client ID from the ism->sba_client_arr[]
is not checked against NO_CLIENT and neither is the client pointer
checked.

Instead of expanding the use of the clients_lock further add a separate
array in struct ism_dev which references clients subscribed to the
device's events and IRQs. This array is protected by ism->lock which is
already taken in ism_handle_irq() and can be taken outside the IRQ
handler when adding/removing subscribers or the accessing
ism->sba_client_arr[]. This also means that the clients_lock is no
longer taken in IRQ context.

Fixes: 89e7d2ba61b7 ("net/ism: Add new API for client registration")
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/net/ism_drv.c | 44 +++++++++++++++++++++++++++++++-------
 include/linux/ism.h        |  1 +
 2 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index c2096e4bba319..216eb4b386286 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -47,6 +47,15 @@ static struct ism_dev_list ism_dev_list = {
 	.mutex = __MUTEX_INITIALIZER(ism_dev_list.mutex),
 };
 
+static void ism_setup_forwarding(struct ism_client *client, struct ism_dev *ism)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ism->lock, flags);
+	ism->subs[client->id] = client;
+	spin_unlock_irqrestore(&ism->lock, flags);
+}
+
 int ism_register_client(struct ism_client *client)
 {
 	struct ism_dev *ism;
@@ -71,6 +80,7 @@ int ism_register_client(struct ism_client *client)
 		list_for_each_entry(ism, &ism_dev_list.list, list) {
 			ism->priv[i] = NULL;
 			client->add(ism);
+			ism_setup_forwarding(client, ism);
 		}
 	}
 	mutex_unlock(&ism_dev_list.mutex);
@@ -92,6 +102,9 @@ int ism_unregister_client(struct ism_client *client)
 		max_client--;
 	spin_unlock_irqrestore(&clients_lock, flags);
 	list_for_each_entry(ism, &ism_dev_list.list, list) {
+		spin_lock_irqsave(&ism->lock, flags);
+		/* Stop forwarding IRQs and events */
+		ism->subs[client->id] = NULL;
 		for (int i = 0; i < ISM_NR_DMBS; ++i) {
 			if (ism->sba_client_arr[i] == client->id) {
 				pr_err("%s: attempt to unregister client '%s'"
@@ -101,6 +114,7 @@ int ism_unregister_client(struct ism_client *client)
 				goto out;
 			}
 		}
+		spin_unlock_irqrestore(&ism->lock, flags);
 	}
 out:
 	mutex_unlock(&ism_dev_list.mutex);
@@ -328,6 +342,7 @@ int ism_register_dmb(struct ism_dev *ism, struct ism_dmb *dmb,
 		     struct ism_client *client)
 {
 	union ism_reg_dmb cmd;
+	unsigned long flags;
 	int ret;
 
 	ret = ism_alloc_dmb(ism, dmb);
@@ -351,7 +366,9 @@ int ism_register_dmb(struct ism_dev *ism, struct ism_dmb *dmb,
 		goto out;
 	}
 	dmb->dmb_tok = cmd.response.dmb_tok;
+	spin_lock_irqsave(&ism->lock, flags);
 	ism->sba_client_arr[dmb->sba_idx - ISM_DMB_BIT_OFFSET] = client->id;
+	spin_unlock_irqrestore(&ism->lock, flags);
 out:
 	return ret;
 }
@@ -360,6 +377,7 @@ EXPORT_SYMBOL_GPL(ism_register_dmb);
 int ism_unregister_dmb(struct ism_dev *ism, struct ism_dmb *dmb)
 {
 	union ism_unreg_dmb cmd;
+	unsigned long flags;
 	int ret;
 
 	memset(&cmd, 0, sizeof(cmd));
@@ -368,7 +386,9 @@ int ism_unregister_dmb(struct ism_dev *ism, struct ism_dmb *dmb)
 
 	cmd.request.dmb_tok = dmb->dmb_tok;
 
+	spin_lock_irqsave(&ism->lock, flags);
 	ism->sba_client_arr[dmb->sba_idx - ISM_DMB_BIT_OFFSET] = NO_CLIENT;
+	spin_unlock_irqrestore(&ism->lock, flags);
 
 	ret = ism_cmd(ism, &cmd);
 	if (ret && ret != ISM_ERROR)
@@ -491,6 +511,7 @@ static u16 ism_get_chid(struct ism_dev *ism)
 static void ism_handle_event(struct ism_dev *ism)
 {
 	struct ism_event *entry;
+	struct ism_client *clt;
 	int i;
 
 	while ((ism->ieq_idx + 1) != READ_ONCE(ism->ieq->header.idx)) {
@@ -499,21 +520,21 @@ static void ism_handle_event(struct ism_dev *ism)
 
 		entry = &ism->ieq->entry[ism->ieq_idx];
 		debug_event(ism_debug_info, 2, entry, sizeof(*entry));
-		spin_lock(&clients_lock);
-		for (i = 0; i < max_client; ++i)
-			if (clients[i])
-				clients[i]->handle_event(ism, entry);
-		spin_unlock(&clients_lock);
+		for (i = 0; i < max_client; ++i) {
+			clt = ism->subs[i];
+			if (clt)
+				clt->handle_event(ism, entry);
+		}
 	}
 }
 
 static irqreturn_t ism_handle_irq(int irq, void *data)
 {
 	struct ism_dev *ism = data;
-	struct ism_client *clt;
 	unsigned long bit, end;
 	unsigned long *bv;
 	u16 dmbemask;
+	u8 client_id;
 
 	bv = (void *) &ism->sba->dmb_bits[ISM_DMB_WORD_OFFSET];
 	end = sizeof(ism->sba->dmb_bits) * BITS_PER_BYTE - ISM_DMB_BIT_OFFSET;
@@ -530,8 +551,10 @@ static irqreturn_t ism_handle_irq(int irq, void *data)
 		dmbemask = ism->sba->dmbe_mask[bit + ISM_DMB_BIT_OFFSET];
 		ism->sba->dmbe_mask[bit + ISM_DMB_BIT_OFFSET] = 0;
 		barrier();
-		clt = clients[ism->sba_client_arr[bit]];
-		clt->handle_irq(ism, bit + ISM_DMB_BIT_OFFSET, dmbemask);
+		client_id = ism->sba_client_arr[bit];
+		if (unlikely(client_id == NO_CLIENT || !ism->subs[client_id]))
+			continue;
+		ism->subs[client_id]->handle_irq(ism, bit + ISM_DMB_BIT_OFFSET, dmbemask);
 	}
 
 	if (ism->sba->e) {
@@ -554,6 +577,7 @@ static void ism_dev_add_work_func(struct work_struct *work)
 						 add_work);
 
 	client->add(client->tgt_ism);
+	ism_setup_forwarding(client, client->tgt_ism);
 	atomic_dec(&client->tgt_ism->add_dev_cnt);
 	wake_up(&client->tgt_ism->waitq);
 }
@@ -691,7 +715,11 @@ static void ism_dev_remove_work_func(struct work_struct *work)
 {
 	struct ism_client *client = container_of(work, struct ism_client,
 						 remove_work);
+	unsigned long flags;
 
+	spin_lock_irqsave(&client->tgt_ism->lock, flags);
+	client->tgt_ism->subs[client->id] = NULL;
+	spin_unlock_irqrestore(&client->tgt_ism->lock, flags);
 	client->remove(client->tgt_ism);
 	atomic_dec(&client->tgt_ism->free_clients_cnt);
 	wake_up(&client->tgt_ism->waitq);
diff --git a/include/linux/ism.h b/include/linux/ism.h
index ea2bcdae74012..5160d47e5ea9e 100644
--- a/include/linux/ism.h
+++ b/include/linux/ism.h
@@ -44,6 +44,7 @@ struct ism_dev {
 	u64 local_gid;
 	int ieq_idx;
 
+	struct ism_client *subs[MAX_CLIENTS];
 	atomic_t free_clients_cnt;
 	atomic_t add_dev_cnt;
 	wait_queue_head_t waitq;
-- 
2.39.2



