Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CE777A1D5
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 20:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjHLSgV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 14:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjHLSgV (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 14:36:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047B010C2
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 11:36:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9758661E69
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 18:36:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8905C433C7;
        Sat, 12 Aug 2023 18:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691865382;
        bh=0ucyIxdYXf4YJgS77TLooDq/pHqyvqt3cyJEHvK+dKg=;
        h=Subject:To:Cc:From:Date:From;
        b=yGkbk0PcCKzcE8PYlfzMEeBHoxH0lIAYcaosQj7D0BL+HdwYMqjCWD0EgO4SC7sh4
         sDYrCcSRQoSuxSVaVAFVpQxahYKnqZ1w/PLbGY+xlP7OmG1Qg2jDVFYeNIRJHK7yHk
         aRwXo08QFzkNdmWxC/CjoT8GT4VxnMSrGGMKzCsM=
Subject: FAILED: patch "[PATCH] ibmvnic: Enforce stronger sanity checks on login response" failed to apply to 4.19-stable tree
To:     nnac123@linux.ibm.com, horms@kernel.org, kuba@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 12 Aug 2023 20:36:11 +0200
Message-ID: <2023081211-outbreak-unwarlike-3ea6@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x db17ba719bceb52f0ae4ebca0e4c17d9a3bebf05
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023081211-outbreak-unwarlike-3ea6@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

db17ba719bce ("ibmvnic: Enforce stronger sanity checks on login response")
507ebe6444a4 ("ibmvnic: Fix use-after-free of VNIC login response buffer")
f3ae59c0c015 ("ibmvnic: store RX and TX subCRQ handle array in ibmvnic_adapter struct")
7c940b1a5291 ("ibmvnic: Fix unchecked return codes of memory allocations")
e56e2515669a ("ibmvnic: Add device identification to requested IRQs")
94b2bb28dbb4 ("net: ibm: fix return type of ndo_start_xmit function")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From db17ba719bceb52f0ae4ebca0e4c17d9a3bebf05 Mon Sep 17 00:00:00 2001
From: Nick Child <nnac123@linux.ibm.com>
Date: Wed, 9 Aug 2023 17:10:34 -0500
Subject: [PATCH] ibmvnic: Enforce stronger sanity checks on login response

Ensure that all offsets in a login response buffer are within the size
of the allocated response buffer. Any offsets or lengths that surpass
the allocation are likely the result of an incomplete response buffer.
In these cases, a full reset is necessary.

When attempting to login, the ibmvnic device will allocate a response
buffer and pass a reference to the VIOS. The VIOS will then send the
ibmvnic device a LOGIN_RSP CRQ to signal that the buffer has been filled
with data. If the ibmvnic device does not get a response in 20 seconds,
the old buffer is freed and a new login request is sent. With 2
outstanding requests, any LOGIN_RSP CRQ's could be for the older
login request. If this is the case then the login response buffer (which
is for the newer login request) could be incomplete and contain invalid
data. Therefore, we must enforce strict sanity checks on the response
buffer values.

Testing has shown that the `off_rxadd_buff_size` value is filled in last
by the VIOS and will be the smoking gun for these circumstances.

Until VIOS can implement a mechanism for tracking outstanding response
buffers and a method for mapping a LOGIN_RSP CRQ to a particular login
response buffer, the best ibmvnic can do in this situation is perform a
full reset.

Fixes: dff515a3e71d ("ibmvnic: Harden device login requests")
Signed-off-by: Nick Child <nnac123@linux.ibm.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20230809221038.51296-1-nnac123@linux.ibm.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 763d613adbcc..f4bb2c9ab9a4 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -5396,6 +5396,7 @@ static int handle_login_rsp(union ibmvnic_crq *login_rsp_crq,
 	int num_tx_pools;
 	int num_rx_pools;
 	u64 *size_array;
+	u32 rsp_len;
 	int i;
 
 	/* CHECK: Test/set of login_pending does not need to be atomic
@@ -5447,6 +5448,23 @@ static int handle_login_rsp(union ibmvnic_crq *login_rsp_crq,
 		ibmvnic_reset(adapter, VNIC_RESET_FATAL);
 		return -EIO;
 	}
+
+	rsp_len = be32_to_cpu(login_rsp->len);
+	if (be32_to_cpu(login->login_rsp_len) < rsp_len ||
+	    rsp_len <= be32_to_cpu(login_rsp->off_txsubm_subcrqs) ||
+	    rsp_len <= be32_to_cpu(login_rsp->off_rxadd_subcrqs) ||
+	    rsp_len <= be32_to_cpu(login_rsp->off_rxadd_buff_size) ||
+	    rsp_len <= be32_to_cpu(login_rsp->off_supp_tx_desc)) {
+		/* This can happen if a login request times out and there are
+		 * 2 outstanding login requests sent, the LOGIN_RSP crq
+		 * could have been for the older login request. So we are
+		 * parsing the newer response buffer which may be incomplete
+		 */
+		dev_err(dev, "FATAL: Login rsp offsets/lengths invalid\n");
+		ibmvnic_reset(adapter, VNIC_RESET_FATAL);
+		return -EIO;
+	}
+
 	size_array = (u64 *)((u8 *)(adapter->login_rsp_buf) +
 		be32_to_cpu(adapter->login_rsp_buf->off_rxadd_buff_size));
 	/* variable buffer sizes are not supported, so just read the

