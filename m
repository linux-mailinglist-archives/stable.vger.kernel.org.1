Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7F877AD28
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjHMVsK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbjHMVpj (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:45:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99532D66
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:45:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5872D60B9D
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:45:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EDEFC433C7;
        Sun, 13 Aug 2023 21:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691963137;
        bh=TgbV6GkrhERFHAFmIXihiZSEqANQ+fDJlM3YYkNZomM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dLjoARxAXcolYMtmQcigpD/NS8DmYJmOrZkk34Dibbjc4uWP2ZjRmC7WC0MMoy48R
         YV5c1p05dnQiq6NwobXJ+EhAA8YYZxzKhRYXU0neIQSf0sbDwowgwdHlCISw+d0t97
         nCW0Ck3jKDjRcr3T+ak3ChV2FwK4trXFfsfWkunk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nick Child <nnac123@linux.ibm.com>,
        Simon Horman <horms@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15 67/89] ibmvnic: Enforce stronger sanity checks on login response
Date:   Sun, 13 Aug 2023 23:19:58 +0200
Message-ID: <20230813211712.791795450@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211710.787645394@linuxfoundation.org>
References: <20230813211710.787645394@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Nick Child <nnac123@linux.ibm.com>

commit db17ba719bceb52f0ae4ebca0e4c17d9a3bebf05 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/ibm/ibmvnic.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -4788,6 +4788,7 @@ static int handle_login_rsp(union ibmvni
 	int num_tx_pools;
 	int num_rx_pools;
 	u64 *size_array;
+	u32 rsp_len;
 	int i;
 
 	/* CHECK: Test/set of login_pending does not need to be atomic
@@ -4839,6 +4840,23 @@ static int handle_login_rsp(union ibmvni
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


