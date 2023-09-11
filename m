Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEAC79B980
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238873AbjIKWWY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239559AbjIKOXp (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:23:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EB3DE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:23:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C7BC433C7;
        Mon, 11 Sep 2023 14:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442221;
        bh=Y0MEL2KH2sq47Pqo4hWYrajR1qGVis3ixgKU4t7zaZ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JE2DUsLFDgx+bz/OAOaWxzwd5tm5efI++ip3T8I6G2xsmptf9M0j9f75M4sRervLQ
         sUd1OZivHqwG/jSnF0VluRMQRlFgoZ5STemJcr+4/hJ9C29KM6LBa0fjrcK4lA3vsJ
         gUgbWFnkyZeC/gDffewjgs4BAQA0J0Kv8LQD/qDg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yuan Y Lu <yuan.y.lu@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Dave Jiang <dave.jiang@intel.com>, Jon Mason <jdmason@kudzu.us>
Subject: [PATCH 6.5 688/739] ntb: Drop packets when qp link is down
Date:   Mon, 11 Sep 2023 15:48:07 +0200
Message-ID: <20230911134710.316867211@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Jiang <dave.jiang@intel.com>

commit f195a1a6fe416882984f8bd6c61afc1383171860 upstream.

Currently when the transport receive packets after netdev has closed the
transport returns error and triggers tx errors to be incremented and
carrier to be stopped. There is no reason to return error if the device is
already closed. Drop the packet and return 0.

Fixes: e26a5843f7f5 ("NTB: Split ntb_hw_intel and ntb_transport drivers")
Reported-by: Yuan Y Lu <yuan.y.lu@intel.com>
Tested-by: Yuan Y Lu <yuan.y.lu@intel.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ntb/ntb_transport.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -2276,9 +2276,13 @@ int ntb_transport_tx_enqueue(struct ntb_
 	struct ntb_queue_entry *entry;
 	int rc;
 
-	if (!qp || !qp->link_is_up || !len)
+	if (!qp || !len)
 		return -EINVAL;
 
+	/* If the qp link is down already, just ignore. */
+	if (!qp->link_is_up)
+		return 0;
+
 	entry = ntb_list_rm(&qp->ntb_tx_free_q_lock, &qp->tx_free_q);
 	if (!entry) {
 		qp->tx_err_no_buf++;


