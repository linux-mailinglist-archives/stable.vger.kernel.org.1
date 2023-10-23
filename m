Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3C37D3114
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbjJWLFT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233247AbjJWLFR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:05:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7799D7B
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:05:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5FB0C433C9;
        Mon, 23 Oct 2023 11:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059115;
        bh=ly+FwnJsXK6aE7n0TagRNVBdQPqpMCoVSJrptp6pbiQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kcq0O5EoZe3J715UhTyzbzXIeQFEUP1uA8d8JPrdbU873cOCnwiGFe/WLY3KkhoxC
         xepp7qImfRU99KrW734G3BGfGtIlm6hCqV+VefnJiCv+Z9Y6QkDN72Fn6HAfO5VaHd
         Sn+gFOAE0BuDyNxmsiOeFggI5qTqaj2WRdsRxwtI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shailend Chand <shailend@google.com>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.5 069/241] gve: Do not fully free QPL pages on prefill errors
Date:   Mon, 23 Oct 2023 12:54:15 +0200
Message-ID: <20231023104835.581440837@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shailend Chand <shailend@google.com>

commit 95535e37e8959f50e7aee365a5bdc9e5ed720443 upstream.

The prefill function should have only removed the page count bias it
added. Fully freeing the page will cause gve_free_queue_page_list to
free a page the driver no longer owns.

Fixes: 82fd151d38d9 ("gve: Reduce alloc and copy costs in the GQ rx path")
Signed-off-by: Shailend Chand <shailend@google.com>
Link: https://lore.kernel.org/r/20231014014121.2843922-1-shailend@google.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/google/gve/gve_rx.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_rx.c b/drivers/net/ethernet/google/gve/gve_rx.c
index d1da7413dc4d..e84a066aa1a4 100644
--- a/drivers/net/ethernet/google/gve/gve_rx.c
+++ b/drivers/net/ethernet/google/gve/gve_rx.c
@@ -146,7 +146,7 @@ static int gve_prefill_rx_pages(struct gve_rx_ring *rx)
 		err = gve_rx_alloc_buffer(priv, &priv->pdev->dev, &rx->data.page_info[i],
 					  &rx->data.data_ring[i]);
 		if (err)
-			goto alloc_err;
+			goto alloc_err_rda;
 	}
 
 	if (!rx->data.raw_addressing) {
@@ -171,12 +171,26 @@ static int gve_prefill_rx_pages(struct gve_rx_ring *rx)
 	return slots;
 
 alloc_err_qpl:
+	/* Fully free the copy pool pages. */
 	while (j--) {
 		page_ref_sub(rx->qpl_copy_pool[j].page,
 			     rx->qpl_copy_pool[j].pagecnt_bias - 1);
 		put_page(rx->qpl_copy_pool[j].page);
 	}
-alloc_err:
+
+	/* Do not fully free QPL pages - only remove the bias added in this
+	 * function with gve_setup_rx_buffer.
+	 */
+	while (i--)
+		page_ref_sub(rx->data.page_info[i].page,
+			     rx->data.page_info[i].pagecnt_bias - 1);
+
+	gve_unassign_qpl(priv, rx->data.qpl->id);
+	rx->data.qpl = NULL;
+
+	return err;
+
+alloc_err_rda:
 	while (i--)
 		gve_rx_free_buffer(&priv->pdev->dev,
 				   &rx->data.page_info[i],
-- 
2.42.0



