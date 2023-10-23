Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4C87D352E
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234456AbjJWLqC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234517AbjJWLpe (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:45:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C141724
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:45:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC383C433C8;
        Mon, 23 Oct 2023 11:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061531;
        bh=vzRLis7/ElrH/3MQK1BZlpwjQLY258Yn8mvMONDQb3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EaNF/Ur7deeGsm/NhjR6qiB5pWhn318VdGQ1A2bkjcXjUylV/YHoNHaTIyhp2IQ3C
         2htHGhTQ/4tjXOKUkswy9tmeF/fapGE70rSFf+wQfAbe9KCqkLUSDBKeQEZoUn/px7
         RsdrefpYPj8hgESKLz8Xo8iPbOTqRZnBmWNI4+Xo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Xiao Yang <yangx.jy@fujitsu.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>
Subject: [PATCH 5.10 079/202] RDMA/srp: Fix srp_abort()
Date:   Mon, 23 Oct 2023 12:56:26 +0200
Message-ID: <20231023104828.857527810@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104826.569169691@linuxfoundation.org>
References: <20231023104826.569169691@linuxfoundation.org>
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

From: Bart Van Assche <bvanassche@acm.org>

commit 6dbe4a8dead84de474483910b02ec9e6a10fc1a9 upstream.

Fix the code for converting a SCSI command pointer into an SRP request
pointer.

Cc: Xiao Yang <yangx.jy@fujitsu.com>
Fixes: ad215aaea4f9 ("RDMA/srp: Make struct scsi_cmnd and struct srp_request adjacent")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Link: https://lore.kernel.org/r/20220908233139.3042628-1-bvanassche@acm.org
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/ulp/srp/ib_srp.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -2778,15 +2778,13 @@ static int srp_send_tsk_mgmt(struct srp_
 static int srp_abort(struct scsi_cmnd *scmnd)
 {
 	struct srp_target_port *target = host_to_target(scmnd->device->host);
-	struct srp_request *req = (struct srp_request *) scmnd->host_scribble;
+	struct srp_request *req = scsi_cmd_priv(scmnd);
 	u32 tag;
 	u16 ch_idx;
 	struct srp_rdma_ch *ch;
 
 	shost_printk(KERN_ERR, target->scsi_host, "SRP abort called\n");
 
-	if (!req)
-		return SUCCESS;
 	tag = blk_mq_unique_tag(scmnd->request);
 	ch_idx = blk_mq_unique_tag_to_hwq(tag);
 	if (WARN_ON_ONCE(ch_idx >= target->ch_count))


