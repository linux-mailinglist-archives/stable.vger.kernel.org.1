Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A3F77AD7C
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbjHMVsz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjHMVsZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:48:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B87F2116
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:42:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A85060F71
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:42:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F20C433C7;
        Sun, 13 Aug 2023 21:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962976;
        bh=xsZQXSASeWOJycZBZIM83YWdCuNhim0xSWHvJRqhuLk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=buWEcANUKBdBYyMzPhWVx4qjtlVapFyH3nsOiv1As8Ibo7hGWWLWOEYu/fsIH3F6b
         +biusX7VLXAMLP6sXkdRIk5JUxB1wy3qUd5le1Zy9KurgopExTjxinAmi5ouKNp2a4
         MYp6saVGUd2oHWsewqD31lA6nsdkWpqoIgm6BtbM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nick Child <nnac123@linux.ibm.com>,
        Simon Horman <horms@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.10 52/68] ibmvnic: Enforce stronger sanity checks on login response
Date:   Sun, 13 Aug 2023 23:19:53 +0200
Message-ID: <20230813211709.729604214@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211708.149630011@linuxfoundation.org>
References: <20230813211708.149630011@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
@@ -4430,6 +4430,7 @@ static int handle_login_rsp(union ibmvni
 	int num_tx_pools;
 	int num_rx_pools;
 	u64 *size_array;
+	u32 rsp_len;
 	int i;
 
 	/* CHECK: Test/set of login_pending does not need to be atomic
@@ -4481,6 +4482,23 @@ static int handle_login_rsp(union ibmvni
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


