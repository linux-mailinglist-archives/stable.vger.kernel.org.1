Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09427BE0F6
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377495AbjJINpy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377635AbjJINpi (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:45:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD8BD51
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:45:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33483C433C9;
        Mon,  9 Oct 2023 13:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696859127;
        bh=p0nesgjnWD173mzZMElQNgETYcRaABcQV+2r0Uy0n/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WlWp4CgRFLrHVZcjIrGoislPJqk8cuB6RxEkUmtLMRN0iykCvv9aLA6bW7pyVPmdM
         Z7mm/C//VdQpgaNRGdfpVisrW08e+B0yuW3iCIlD33rWFOw+UgpcQXoXjv9wKkUUlw
         8A2vzVMaTbQcJeaUFrGa1nw1ESYE/Mu9qa87ZNhA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chengfeng Ye <dg573847474@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jon Maloy <jmaloy@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 207/226] tipc: fix a potential deadlock on &tx->lock
Date:   Mon,  9 Oct 2023 15:02:48 +0200
Message-ID: <20231009130131.973443889@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130126.697995596@linuxfoundation.org>
References: <20231009130126.697995596@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chengfeng Ye <dg573847474@gmail.com>

[ Upstream commit 08e50cf071847323414df0835109b6f3560d44f5 ]

It seems that tipc_crypto_key_revoke() could be be invoked by
wokequeue tipc_crypto_work_rx() under process context and
timer/rx callback under softirq context, thus the lock acquisition
on &tx->lock seems better use spin_lock_bh() to prevent possible
deadlock.

This flaw was found by an experimental static analysis tool I am
developing for irq-related deadlock.

tipc_crypto_work_rx() <workqueue>
--> tipc_crypto_key_distr()
--> tipc_bcast_xmit()
--> tipc_bcbase_xmit()
--> tipc_bearer_bc_xmit()
--> tipc_crypto_xmit()
--> tipc_ehdr_build()
--> tipc_crypto_key_revoke()
--> spin_lock(&tx->lock)
<timer interrupt>
   --> tipc_disc_timeout()
   --> tipc_bearer_xmit_skb()
   --> tipc_crypto_xmit()
   --> tipc_ehdr_build()
   --> tipc_crypto_key_revoke()
   --> spin_lock(&tx->lock) <deadlock here>

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Acked-by: Jon Maloy <jmaloy@redhat.com>
Fixes: fc1b6d6de220 ("tipc: introduce TIPC encryption & authentication")
Link: https://lore.kernel.org/r/20230927181414.59928-1-dg573847474@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tipc/crypto.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
index 2784d69892117..b5aa0a835bced 100644
--- a/net/tipc/crypto.c
+++ b/net/tipc/crypto.c
@@ -1445,14 +1445,14 @@ static int tipc_crypto_key_revoke(struct net *net, u8 tx_key)
 	struct tipc_crypto *tx = tipc_net(net)->crypto_tx;
 	struct tipc_key key;
 
-	spin_lock(&tx->lock);
+	spin_lock_bh(&tx->lock);
 	key = tx->key;
 	WARN_ON(!key.active || tx_key != key.active);
 
 	/* Free the active key */
 	tipc_crypto_key_set_state(tx, key.passive, 0, key.pending);
 	tipc_crypto_key_detach(tx->aead[key.active], &tx->lock);
-	spin_unlock(&tx->lock);
+	spin_unlock_bh(&tx->lock);
 
 	pr_warn("%s: key is revoked\n", tx->name);
 	return -EKEYREVOKED;
-- 
2.40.1



