Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65ED97A3877
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239752AbjIQTge (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239747AbjIQTgB (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:36:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A0A12B
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:35:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF82C433C9;
        Sun, 17 Sep 2023 19:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979353;
        bh=f6nZeCjZ4BNTKRE5EmJogPnxQOtMpRTwZs7E5VY2wyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JShghRM8D/Jqz/rrUQDBUvhxv+1yjiuwmf9KjLZZdOzJ9IVnPWTfr4mHFYEGAB1sE
         7hXpB9U5PBimCyfGAsaanremE8acFuf8qFEJ1rJEwQho1cjDwzYtFl03kvzTZrbPFM
         8ol19X+af7DUZEqM4+8R+vMzjbcqK5yCaumEHquM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yuan Y Lu <yuan.y.lu@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Dave Jiang <dave.jiang@intel.com>, Jon Mason <jdmason@kudzu.us>
Subject: [PATCH 5.10 288/406] ntb: Drop packets when qp link is down
Date:   Sun, 17 Sep 2023 21:12:22 +0200
Message-ID: <20230917191108.911170522@linuxfoundation.org>
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
@@ -2278,9 +2278,13 @@ int ntb_transport_tx_enqueue(struct ntb_
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


