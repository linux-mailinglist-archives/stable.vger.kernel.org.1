Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689097BDF2E
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376766AbjJIN1R (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376756AbjJIN1R (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:27:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB19A3
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:27:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC63C433C8;
        Mon,  9 Oct 2023 13:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858036;
        bh=p5Ri6Pno4d/5wMa0qmXL35T9tdeWAAJlvb5UNaZpFTA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sxg/NCc+lv3QSFwRWLQTPykl+6Gy1BVrAoVgxmXJa5XP/acn6xww9OLtXt01l4hor
         OC73LIDw0dH5MNy54LGlkUVC466m0HchZLAfqVuAQdFJKqNTxPHi9qLybONTZKHIOt
         5DyuAaU2+45++EGWHrTMxQtVgocK8gm1iSqOVNuE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bernard Metzler <bmt@zurich.ibm.com>,
        Leon Romanovsky <leon@kernel.org>
Subject: [PATCH 5.15 72/75] RDMA/siw: Fix connection failure handling
Date:   Mon,  9 Oct 2023 15:02:34 +0200
Message-ID: <20231009130113.791149698@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130111.200710898@linuxfoundation.org>
References: <20231009130111.200710898@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bernard Metzler <bmt@zurich.ibm.com>

commit 53a3f777049771496f791504e7dc8ef017cba590 upstream.

In case immediate MPA request processing fails, the newly
created endpoint unlinks the listening endpoint and is
ready to be dropped. This special case was not handled
correctly by the code handling the later TCP socket close,
causing a NULL dereference crash in siw_cm_work_handler()
when dereferencing a NULL listener. We now also cancel
the useless MPA timeout, if immediate MPA request
processing fails.

This patch furthermore simplifies MPA processing in general:
Scheduling a useless TCP socket read in sk_data_ready() upcall
is now surpressed, if the socket is already moved out of
TCP_ESTABLISHED state.

Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
Link: https://lore.kernel.org/r/20230905145822.446263-1-bmt@zurich.ibm.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/sw/siw/siw_cm.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -973,6 +973,7 @@ static void siw_accept_newconn(struct si
 			siw_cep_put(cep);
 			new_cep->listen_cep = NULL;
 			if (rv) {
+				siw_cancel_mpatimer(new_cep);
 				siw_cep_set_free(new_cep);
 				goto error;
 			}
@@ -1097,9 +1098,12 @@ static void siw_cm_work_handler(struct w
 				/*
 				 * Socket close before MPA request received.
 				 */
-				siw_dbg_cep(cep, "no mpareq: drop listener\n");
-				siw_cep_put(cep->listen_cep);
-				cep->listen_cep = NULL;
+				if (cep->listen_cep) {
+					siw_dbg_cep(cep,
+						"no mpareq: drop listener\n");
+					siw_cep_put(cep->listen_cep);
+					cep->listen_cep = NULL;
+				}
 			}
 		}
 		release_cep = 1;
@@ -1222,7 +1226,11 @@ static void siw_cm_llp_data_ready(struct
 	if (!cep)
 		goto out;
 
-	siw_dbg_cep(cep, "state: %d\n", cep->state);
+	siw_dbg_cep(cep, "cep state: %d, socket state %d\n",
+		    cep->state, sk->sk_state);
+
+	if (sk->sk_state != TCP_ESTABLISHED)
+		goto out;
 
 	switch (cep->state) {
 	case SIW_EPSTATE_RDMA_MODE:


