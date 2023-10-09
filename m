Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C2F7BDDFC
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376792AbjJINOk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376879AbjJINOh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:14:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155609C
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:14:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53761C433C7;
        Mon,  9 Oct 2023 13:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857275;
        bh=oQfRKv8+KSkn+nE80ouzLW+jIE09wE7YNgaLiQJKX80=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ygW4DYOCSpsAUKzAAGMHIGaNzt6lYmknzLH/edZtDmstnVMwET/6QUr1iHd4t0kZI
         zm1jmmvhQxx8JQTdlCbLlhJFzWO7yblDukMQClgHD3cNNSRtLxOgjBGsedNNKhdCSq
         l2LLrtMaU9/uzHuVgLLu5ezoEr6tdTL7WTCb4V4c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Leon Romanovsky <leon@kernel.org>
Subject: [PATCH 6.5 148/163] RDMA/bnxt_re: Fix the handling of control path response data
Date:   Mon,  9 Oct 2023 15:01:52 +0200
Message-ID: <20231009130128.117840862@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
References: <20231009130124.021290599@linuxfoundation.org>
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

From: Selvin Xavier <selvin.xavier@broadcom.com>

commit 9fc5f9a92fe6897dbed7b9295b234cb7e3cc9d11 upstream.

Flag that indicate control path command completion should be cleared
only after copying the command response data. As soon as the is_in_used
flag is clear, the waiting thread can proceed with wrong response
data.  This wrong data is causing multiple issues like wrong lkey
used in data traffic and wrong AH Id etc.

Use a memory barrier to ensure that the response data
is copied and visible to the process waiting on a different
cpu core before clearing the is_in_used flag.

Clear the is_in_used after copying the command response.

Fixes: bcfee4ce3e01 ("RDMA/bnxt_re: remove redundant cmdq_bitmap")
Signed-off-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Link: https://lore.kernel.org/r/1695199280-13520-2-git-send-email-selvin.xavier@broadcom.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -664,7 +664,6 @@ static int bnxt_qplib_process_qp_event(s
 		blocked = cookie & RCFW_CMD_IS_BLOCKING;
 		cookie &= RCFW_MAX_COOKIE_VALUE;
 		crsqe = &rcfw->crsqe_tbl[cookie];
-		crsqe->is_in_used = false;
 
 		if (WARN_ONCE(test_bit(FIRMWARE_STALL_DETECTED,
 				       &rcfw->cmdq.flags),
@@ -680,8 +679,14 @@ static int bnxt_qplib_process_qp_event(s
 			atomic_dec(&rcfw->timeout_send);
 
 		if (crsqe->is_waiter_alive) {
-			if (crsqe->resp)
+			if (crsqe->resp) {
 				memcpy(crsqe->resp, qp_event, sizeof(*qp_event));
+				/* Insert write memory barrier to ensure that
+				 * response data is copied before clearing the
+				 * flags
+				 */
+				smp_wmb();
+			}
 			if (!blocked)
 				wait_cmds++;
 		}
@@ -693,6 +698,8 @@ static int bnxt_qplib_process_qp_event(s
 		if (!is_waiter_alive)
 			crsqe->resp = NULL;
 
+		crsqe->is_in_used = false;
+
 		hwq->cons += req_size;
 
 		/* This is a case to handle below scenario -


