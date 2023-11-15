Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82027ED175
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344139AbjKOUBq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344129AbjKOUBp (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:01:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EF1AF
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:01:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91497C433C7;
        Wed, 15 Nov 2023 20:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078501;
        bh=7KfzUZezhK3fzmqqlZ7Fve3nSMSgOfhuUJTlFWdSIUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lG3l364ahvS/x8SxkaVQkJJLL+ac/NPimX+CeL6sUTG68aO8axxXvkEo+ONAnBTKV
         dXciISOp/tz80WLvnH/qTUTTcnMQwfqcFI9Z+HD9d0aNLjqVMQEAsCsSL9dVLHO/o7
         SUWYKqLbgKzf0x7j2VhrXPMms4M0NMwnl3oYAtfA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "D. Wythe" <alibuda@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 353/379] net/smc: allow cdc msg send rather than drop it with NULL sndbuf_desc
Date:   Wed, 15 Nov 2023 14:27:08 -0500
Message-ID: <20231115192706.042882706@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: D. Wythe <alibuda@linux.alibaba.com>

[ Upstream commit c5bf605ba4f9d6fbbb120595ab95002f4716edcb ]

This patch re-fix the issues mentioned by commit 22a825c541d7
("net/smc: fix NULL sndbuf_desc in smc_cdc_tx_handler()").

Blocking sending message do solve the issues though, but it also
prevents the peer to receive the final message. Besides, in logic,
whether the sndbuf_desc is NULL or not have no impact on the processing
of cdc message sending.

Hence that, this patch allows the cdc message sending but to check the
sndbuf_desc with care in smc_cdc_tx_handler().

Fixes: 22a825c541d7 ("net/smc: fix NULL sndbuf_desc in smc_cdc_tx_handler()")
Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/smc/smc_cdc.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
index 01bdb7909a14b..3c06625ceb200 100644
--- a/net/smc/smc_cdc.c
+++ b/net/smc/smc_cdc.c
@@ -28,13 +28,15 @@ static void smc_cdc_tx_handler(struct smc_wr_tx_pend_priv *pnd_snd,
 {
 	struct smc_cdc_tx_pend *cdcpend = (struct smc_cdc_tx_pend *)pnd_snd;
 	struct smc_connection *conn = cdcpend->conn;
+	struct smc_buf_desc *sndbuf_desc;
 	struct smc_sock *smc;
 	int diff;
 
+	sndbuf_desc = conn->sndbuf_desc;
 	smc = container_of(conn, struct smc_sock, conn);
 	bh_lock_sock(&smc->sk);
-	if (!wc_status) {
-		diff = smc_curs_diff(cdcpend->conn->sndbuf_desc->len,
+	if (!wc_status && sndbuf_desc) {
+		diff = smc_curs_diff(sndbuf_desc->len,
 				     &cdcpend->conn->tx_curs_fin,
 				     &cdcpend->cursor);
 		/* sndbuf_space is decreased in smc_sendmsg */
@@ -114,9 +116,6 @@ int smc_cdc_msg_send(struct smc_connection *conn,
 	union smc_host_cursor cfed;
 	int rc;
 
-	if (unlikely(!READ_ONCE(conn->sndbuf_desc)))
-		return -ENOBUFS;
-
 	smc_cdc_add_pending_send(conn, pend);
 
 	conn->tx_cdc_seq++;
-- 
2.42.0



