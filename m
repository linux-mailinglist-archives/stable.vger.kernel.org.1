Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A813F7BE0EB
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377516AbjJINpL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377509AbjJINo5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:44:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4173DDE
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:44:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81097C433C9;
        Mon,  9 Oct 2023 13:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696859095;
        bh=WYfYTr5wHeLqzIxJdcGieXFyV8Kv8neQD4t+duE3EI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1OLuozTNjOb8IxHnLEHQrtz7cmekGbgMtx55dytQD1hBzlm+lmVy/Q8/gU3+8X8+P
         +/BZE6bKc0TOsDfQyC+hn9onAoOOCXuZqVlfF8IV3q7EIBLcK3d0iQpinsjWw9stJG
         ZQuav42/uv9kQTt42de35uqTxBakQQ5xa7aW9OIA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Simon Horman <horms@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.10 180/226] qed/red_ll2: Fix undefined behavior bug in struct qed_ll2_info
Date:   Mon,  9 Oct 2023 15:02:21 +0200
Message-ID: <20231009130131.341566069@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130126.697995596@linuxfoundation.org>
References: <20231009130126.697995596@linuxfoundation.org>
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

From: Gustavo A. R. Silva <gustavoars@kernel.org>

commit eea03d18af9c44235865a4bc9bec4d780ef6cf21 upstream.

The flexible structure (a structure that contains a flexible-array member
at the end) `qed_ll2_tx_packet` is nested within the second layer of
`struct qed_ll2_info`:

struct qed_ll2_tx_packet {
	...
        /* Flexible Array of bds_set determined by max_bds_per_packet */
        struct {
                struct core_tx_bd *txq_bd;
                dma_addr_t tx_frag;
                u16 frag_len;
        } bds_set[];
};

struct qed_ll2_tx_queue {
	...
	struct qed_ll2_tx_packet cur_completing_packet;
};

struct qed_ll2_info {
	...
	struct qed_ll2_tx_queue tx_queue;
        struct qed_ll2_cbs cbs;
};

The problem is that member `cbs` in `struct qed_ll2_info` is placed just
after an object of type `struct qed_ll2_tx_queue`, which is in itself
an implicit flexible structure, which by definition ends in a flexible
array member, in this case `bds_set`. This causes an undefined behavior
bug at run-time when dynamic memory is allocated for `bds_set`, which
could lead to a serious issue if `cbs` in `struct qed_ll2_info` is
overwritten by the contents of `bds_set`. Notice that the type of `cbs`
is a structure full of function pointers (and a cookie :) ):

include/linux/qed/qed_ll2_if.h:
107 typedef
108 void (*qed_ll2_complete_rx_packet_cb)(void *cxt,
109                                       struct qed_ll2_comp_rx_data *data);
110
111 typedef
112 void (*qed_ll2_release_rx_packet_cb)(void *cxt,
113                                      u8 connection_handle,
114                                      void *cookie,
115                                      dma_addr_t rx_buf_addr,
116                                      bool b_last_packet);
117
118 typedef
119 void (*qed_ll2_complete_tx_packet_cb)(void *cxt,
120                                       u8 connection_handle,
121                                       void *cookie,
122                                       dma_addr_t first_frag_addr,
123                                       bool b_last_fragment,
124                                       bool b_last_packet);
125
126 typedef
127 void (*qed_ll2_release_tx_packet_cb)(void *cxt,
128                                      u8 connection_handle,
129                                      void *cookie,
130                                      dma_addr_t first_frag_addr,
131                                      bool b_last_fragment, bool b_last_packet);
132
133 typedef
134 void (*qed_ll2_slowpath_cb)(void *cxt, u8 connection_handle,
135                             u32 opaque_data_0, u32 opaque_data_1);
136
137 struct qed_ll2_cbs {
138         qed_ll2_complete_rx_packet_cb rx_comp_cb;
139         qed_ll2_release_rx_packet_cb rx_release_cb;
140         qed_ll2_complete_tx_packet_cb tx_comp_cb;
141         qed_ll2_release_tx_packet_cb tx_release_cb;
142         qed_ll2_slowpath_cb slowpath_cb;
143         void *cookie;
144 };

Fix this by moving the declaration of `cbs` to the  middle of its
containing structure `qed_ll2_info`, preventing it from being
overwritten by the contents of `bds_set` at run-time.

This bug was introduced in 2017, when `bds_set` was converted to a
one-element array, and started to be used as a Variable Length Object
(VLO) at run-time.

Fixes: f5823fe6897c ("qed: Add ll2 option to limit the number of bds per packet")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/ZQ+Nz8DfPg56pIzr@work
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qlogic/qed/qed_ll2.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/qlogic/qed/qed_ll2.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_ll2.h
@@ -111,9 +111,9 @@ struct qed_ll2_info {
 	enum core_tx_dest tx_dest;
 	u8 tx_stats_en;
 	bool main_func_queue;
+	struct qed_ll2_cbs cbs;
 	struct qed_ll2_rx_queue rx_queue;
 	struct qed_ll2_tx_queue tx_queue;
-	struct qed_ll2_cbs cbs;
 };
 
 extern const struct qed_ll2_ops qed_ll2_ops_pass;


