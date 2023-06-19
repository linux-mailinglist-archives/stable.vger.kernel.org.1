Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A1C73549F
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbjFSK56 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbjFSK53 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:57:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514E93A9D
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:55:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E19D360B4B
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:55:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F31EFC433C8;
        Mon, 19 Jun 2023 10:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687172128;
        bh=vNWqJYZVhPQBTX1FzplyB9TyaipC4shVc9UDbZEvL2o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MXjs8jrjNnKxZwNzexOKt+Ra726xrSNl4cW52uo2kQtMPobAkYn+6QNJuIwLxdxbF
         LbGT3hmd0nhDVdCUm10EORfzeQwD0HJc8sv4oUtPp+zL2Hne4rHD3h1PL+bfBJlS8V
         oIo8h28JL6p9fQ/n5U3bJ8YTf/92dWzI69VvL/uk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 47/89] netfilter: nfnetlink: skip error delivery on batch in case of ENOMEM
Date:   Mon, 19 Jun 2023 12:30:35 +0200
Message-ID: <20230619102140.428334483@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102138.279161276@linuxfoundation.org>
References: <20230619102138.279161276@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit a1a64a151dae8ac3581c1cbde44b672045cb658b ]

If caller reports ENOMEM, then stop iterating over the batch and send a
single netlink message to userspace to report OOM.

Fixes: cbb8125eb40b ("netfilter: nfnetlink: deliver netlink errors on batch completion")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nfnetlink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nfnetlink.c b/net/netfilter/nfnetlink.c
index edf386a020b9e..bec9ac8b8fbef 100644
--- a/net/netfilter/nfnetlink.c
+++ b/net/netfilter/nfnetlink.c
@@ -473,7 +473,8 @@ static void nfnetlink_rcv_batch(struct sk_buff *skb, struct nlmsghdr *nlh,
 			 * processed, this avoids that the same error is
 			 * reported several times when replaying the batch.
 			 */
-			if (nfnl_err_add(&err_list, nlh, err, &extack) < 0) {
+			if (err == -ENOMEM ||
+			    nfnl_err_add(&err_list, nlh, err, &extack) < 0) {
 				/* We failed to enqueue an error, reset the
 				 * list of errors and send OOM to userspace
 				 * pointing to the batch header.
-- 
2.39.2



