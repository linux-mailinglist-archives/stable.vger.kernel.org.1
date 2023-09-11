Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B57779BC6D
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377920AbjIKW31 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242291AbjIKP1G (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:27:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DA9E4
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:27:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 425B3C433C9;
        Mon, 11 Sep 2023 15:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694446021;
        bh=jJVcHnN4YrU+Lvobqx3lPKrv7UOEV4oj2YeILZVnqzg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vegzcsy8hZ+1sCw5YbcgSInISzlSGk90hANFG0GhGM/z3uprSUAC+fg8ekJhR8OnJ
         vg9/LqpNGaMvCqRINWefRtl/s/J4DnqTojvtatBCZrVxJezftIbY4e3xPHDkkXUrhh
         Kr698X5TwSVg+3AFkucdTeG8CVlO04250f80ZuYk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yuan Y Lu <yuan.y.lu@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Dave Jiang <dave.jiang@intel.com>, Jon Mason <jdmason@kudzu.us>
Subject: [PATCH 6.1 555/600] ntb: Clean up tx tail index on link down
Date:   Mon, 11 Sep 2023 15:49:48 +0200
Message-ID: <20230911134650.000134211@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Jiang <dave.jiang@intel.com>

commit cc79bd2738c2d40aba58b2be6ce47dc0e471df0e upstream.

The tx tail index is not reset when the link goes down. This causes the
tail index to go out of sync when the link goes down and comes back up.
Refactor the ntb_qp_link_down_reset() and reset the tail index as well.

Fixes: 2849b5d70641 ("NTB: Reset transport QP link stats on down")
Reported-by: Yuan Y Lu <yuan.y.lu@intel.com>
Tested-by: Yuan Y Lu <yuan.y.lu@intel.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ntb/ntb_transport.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -909,7 +909,7 @@ static int ntb_set_mw(struct ntb_transpo
 	return 0;
 }
 
-static void ntb_qp_link_down_reset(struct ntb_transport_qp *qp)
+static void ntb_qp_link_context_reset(struct ntb_transport_qp *qp)
 {
 	qp->link_is_up = false;
 	qp->active = false;
@@ -932,6 +932,13 @@ static void ntb_qp_link_down_reset(struc
 	qp->tx_async = 0;
 }
 
+static void ntb_qp_link_down_reset(struct ntb_transport_qp *qp)
+{
+	ntb_qp_link_context_reset(qp);
+	if (qp->remote_rx_info)
+		qp->remote_rx_info->entry = qp->rx_max_entry - 1;
+}
+
 static void ntb_qp_link_cleanup(struct ntb_transport_qp *qp)
 {
 	struct ntb_transport_ctx *nt = qp->transport;
@@ -1174,7 +1181,7 @@ static int ntb_transport_init_queue(stru
 	qp->ndev = nt->ndev;
 	qp->client_ready = false;
 	qp->event_handler = NULL;
-	ntb_qp_link_down_reset(qp);
+	ntb_qp_link_context_reset(qp);
 
 	if (mw_num < qp_count % mw_count)
 		num_qps_mw = qp_count / mw_count + 1;


