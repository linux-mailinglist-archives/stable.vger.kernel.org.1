Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B04C73543A
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbjFSKx7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbjFSKxX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:53:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A1F1FCD
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:52:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 919F860A4D
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:52:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85DD1C433C0;
        Mon, 19 Jun 2023 10:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171922;
        bh=cBs5mgiSJBTqUoNHI2zw+vsGz1CvcJ6N3V0VsS9UuJQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eoXfDZXcmacyhLQ+e0ff4LjptNGiDbHN4kgR3yA8pF2ImiDMU3LKnoa7iZ4ncdn5r
         PajKcxsmGRzbFgfZlb2/GqN+2N9dJbvU5pDa6CqP3onw02jhUMdE7IvBlJmBKSIfU/
         KKyyfZy9BHj2aWHigMpUqEYalpr7a+yoWSdP1a2Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 38/64] netfilter: nfnetlink: skip error delivery on batch in case of ENOMEM
Date:   Mon, 19 Jun 2023 12:30:34 +0200
Message-ID: <20230619102134.908883424@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102132.808972458@linuxfoundation.org>
References: <20230619102132.808972458@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
index e3f6e27a9a06d..3cff23c814c37 100644
--- a/net/netfilter/nfnetlink.c
+++ b/net/netfilter/nfnetlink.c
@@ -455,7 +455,8 @@ static void nfnetlink_rcv_batch(struct sk_buff *skb, struct nlmsghdr *nlh,
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



