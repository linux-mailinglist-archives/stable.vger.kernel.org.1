Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D017D331C
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbjJWL0u (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233961AbjJWL0t (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:26:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D14010B
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:26:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C78C433C7;
        Mon, 23 Oct 2023 11:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060406;
        bh=thjgeJWthgqRx/M5+1a5F1fjeYXqkglHLxTT57GK1Uo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QYRhbcgMwk6ppA16s6Yw81M4uyRBMTrjxpBeKLTyk7/LR7lYmMpSOC14mzMtK1CHn
         R1/cVMvlKuzap96sh0EYWs1SgkuWLBYYjFQwKyXb2IdJ99b7eSsGSppDq9Bc36ANod
         th8BEJ9J35NuaiKy3dtjk6QiSsvWAs1/YxZE3WeA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Maurizio Lombardi <mlombard@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 6.1 161/196] nvmet-auth: complete a request only after freeing the dhchap pointers
Date:   Mon, 23 Oct 2023 12:57:06 +0200
Message-ID: <20231023104832.998999339@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104828.488041585@linuxfoundation.org>
References: <20231023104828.488041585@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maurizio Lombardi <mlombard@redhat.com>

commit f965b281fd872b2e18bd82dd97730db9834d0750 upstream.

It may happen that the work to destroy a queue
(for example nvmet_tcp_release_queue_work()) is started while
an auth-send or auth-receive command is still completing.

nvmet_sq_destroy() will block, waiting for all the references
to the sq to be dropped, the last reference is then
dropped when nvmet_req_complete() is called.

When this happens, both nvmet_sq_destroy() and
nvmet_execute_auth_send()/_receive() will free the dhchap pointers by
calling nvmet_auth_sq_free().
Since there isn't any lock, the two threads may race against each other,
causing double frees and memory corruptions, as reported by KASAN.

Reproduced by stress blktests nvme/041 nvme/042 nvme/043

 nvme nvme2: qid 0: authenticated with hash hmac(sha512) dhgroup ffdhe4096
 ==================================================================
 BUG: KASAN: double-free in kfree+0xec/0x4b0

 Call Trace:
  <TASK>
  kfree+0xec/0x4b0
  nvmet_auth_sq_free+0xe1/0x160 [nvmet]
  nvmet_execute_auth_send+0x482/0x16d0 [nvmet]
  process_one_work+0x8e5/0x1510

 Allocated by task 191846:
  __kasan_kmalloc+0x81/0xa0
  nvmet_auth_ctrl_sesskey+0xf6/0x380 [nvmet]
  nvmet_auth_reply+0x119/0x990 [nvmet]

 Freed by task 143270:
  kfree+0xec/0x4b0
  nvmet_auth_sq_free+0xe1/0x160 [nvmet]
  process_one_work+0x8e5/0x1510

Fix this bug by calling nvmet_req_complete() only after freeing the
pointers, so we will prevent the race by holding the sq reference.

V2: remove redundant code

Fixes: db1312dd9548 ("nvmet: implement basic In-Band Authentication")
Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/target/fabrics-cmd-auth.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -337,19 +337,21 @@ done:
 			 __func__, ctrl->cntlid, req->sq->qid,
 			 status, req->error_loc);
 	req->cqe->result.u64 = 0;
-	nvmet_req_complete(req, status);
 	if (req->sq->dhchap_step != NVME_AUTH_DHCHAP_MESSAGE_SUCCESS2 &&
 	    req->sq->dhchap_step != NVME_AUTH_DHCHAP_MESSAGE_FAILURE2) {
 		unsigned long auth_expire_secs = ctrl->kato ? ctrl->kato : 120;
 
 		mod_delayed_work(system_wq, &req->sq->auth_expired_work,
 				 auth_expire_secs * HZ);
-		return;
+		goto complete;
 	}
 	/* Final states, clear up variables */
 	nvmet_auth_sq_free(req->sq);
 	if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_FAILURE2)
 		nvmet_ctrl_fatal_error(ctrl);
+
+complete:
+	nvmet_req_complete(req, status);
 }
 
 static int nvmet_auth_challenge(struct nvmet_req *req, void *d, int al)
@@ -527,11 +529,12 @@ void nvmet_execute_auth_receive(struct n
 	kfree(d);
 done:
 	req->cqe->result.u64 = 0;
-	nvmet_req_complete(req, status);
+
 	if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_SUCCESS2)
 		nvmet_auth_sq_free(req->sq);
 	else if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_FAILURE1) {
 		nvmet_auth_sq_free(req->sq);
 		nvmet_ctrl_fatal_error(ctrl);
 	}
+	nvmet_req_complete(req, status);
 }


