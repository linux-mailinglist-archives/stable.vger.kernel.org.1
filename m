Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7C47D31A1
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbjJWLLX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbjJWLLV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:11:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D1899
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:11:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1016DC433C8;
        Mon, 23 Oct 2023 11:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059477;
        bh=DJvWFvMBXmJRI0MMUDef3j+7pPZaUZL7xVLJe0SBIak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lLjxx+TmPGJePcN8xI9ONR/bSr4xrtGNKwKs+kj3XN5kN4sdWNU7ir+yN+4iSjAbh
         tofkE8X3wPhkJpTWQOWOo+kBTH3UEDICinZ9SwuiTDtgi67kwNHdmD1q/II5Xe37kC
         d300YzLX16I9tntBazd/7xvO/3DCR/K2BSadQc6k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Martin Wilck <mwilck@suse.com>,
        Daniel Wagner <dwagner@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH 6.5 191/241] nvme-auth: use chap->s2 to indicate bidirectional authentication
Date:   Mon, 23 Oct 2023 12:56:17 +0200
Message-ID: <20231023104838.533497316@linuxfoundation.org>
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

From: Martin Wilck <mwilck@suse.com>

commit 4ae55a7dce04989f289d5c5c8c8e5c37adc36c71 upstream.

Commit 546dea18c999 ("nvme-auth: check chap ctrl_key once constructed")
replaced the condition "if (ctrl->ctrl_key)" (indicating bidirectional
auth) by "if (chap->ctrl_key)", because ctrl->ctrl_key is a resource shared
with sysfs. But chap->ctrl_key is set in
nvme_auth_process_dhchap_challenge() depending on the DHVLEN in the
DH-HMAC-CHAP Challenge message received from the controller, and will thus
be non-NULL for every DH-HMAC-CHAP exchange, even if unidirectional auth
was requested. This will lead to a protocol violation by sending a Success2
message in the unidirectional case (per NVMe base spec 2.0, the
authentication transaction ends after the Success1 message for
unidirectional auth). Use chap->s2 instead, which is non-zero if and only
if the host requested bi-directional authentication from the controller.

Fixes: 546dea18c999 ("nvme-auth: check chap ctrl_key once constructed")
Signed-off-by: Martin Wilck <mwilck@suse.com>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/host/auth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index daf5d144a8ea..064592a5d546 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -341,7 +341,7 @@ static int nvme_auth_process_dhchap_success1(struct nvme_ctrl *ctrl,
 	struct nvmf_auth_dhchap_success1_data *data = chap->buf;
 	size_t size = sizeof(*data);
 
-	if (chap->ctrl_key)
+	if (chap->s2)
 		size += chap->hash_len;
 
 	if (size > CHAP_BUF_SIZE) {
@@ -825,7 +825,7 @@ static void nvme_queue_auth_work(struct work_struct *work)
 		goto fail2;
 	}
 
-	if (chap->ctrl_key) {
+	if (chap->s2) {
 		/* DH-HMAC-CHAP Step 5: send success2 */
 		dev_dbg(ctrl->device, "%s: qid %d send success2\n",
 			__func__, chap->qid);
-- 
2.42.0



