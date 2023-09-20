Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4877A7CE1
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbjITMF0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235227AbjITMEv (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:04:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1AC93
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:04:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50E3C433C8;
        Wed, 20 Sep 2023 12:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211485;
        bh=K6IlsdM94XeDfd488GHJd1GGtqt51nohnYhbhFRn6zU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KVTnoImLn9xvmo/yauruqvXORFL6YJJslAKBHbXUOZ0yZG10NiORoXKp0+CgxlUbq
         iFC0bmvWzxsKqzlDDFQUBb1xPiH4ZoA2JfJzjKlT9QDFHe17fwnwAQk3MYiM8yl7TF
         CyDAm0/4GMB0NLAApmOBqmApFr2UKBJ1xEwecPH4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Logan Gunthorpe <logang@deltatee.com>,
        renlonglong <ren.longlong@h3c.com>,
        Dave Jiang <dave.jiang@intel.com>, Jon Mason <jdmason@kudzu.us>
Subject: [PATCH 4.14 111/186] ntb: Fix calculation ntb_transport_tx_free_entry()
Date:   Wed, 20 Sep 2023 13:30:14 +0200
Message-ID: <20230920112841.040399297@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112836.799946261@linuxfoundation.org>
References: <20230920112836.799946261@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Jiang <dave.jiang@intel.com>

commit 5a7693e6bbf19b22fd6c1d2c4b7beb0a03969e2c upstream.

ntb_transport_tx_free_entry() never returns 0 with the current
calculation. If head == tail, then it would return qp->tx_max_entry.
Change compare to tail >= head and when they are equal, a 0 would be
returned.

Fixes: e74bfeedad08 ("NTB: Add flow control to the ntb_netdev")
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: renlonglong <ren.longlong@h3c.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ntb/ntb_transport.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -2199,7 +2199,7 @@ unsigned int ntb_transport_tx_free_entry
 	unsigned int head = qp->tx_index;
 	unsigned int tail = qp->remote_rx_info->entry;
 
-	return tail > head ? tail - head : qp->tx_max_entry + tail - head;
+	return tail >= head ? tail - head : qp->tx_max_entry + tail - head;
 }
 EXPORT_SYMBOL_GPL(ntb_transport_tx_free_entry);
 


