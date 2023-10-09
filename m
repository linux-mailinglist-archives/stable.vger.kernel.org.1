Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0BA7BE099
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377334AbjJINlz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377378AbjJINly (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:41:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65649D3
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:41:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABFACC433C8;
        Mon,  9 Oct 2023 13:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858912;
        bh=LMp5tPAm9ByF33cVux4M8S2gvUTq9Qqr1e2bJFgdMBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bcchAaR9ZLpyuLY51DuYYYK/raCJ6PIZbd4oMT0ix6Pm8C/4ZeOR3ev/3/QfaHbVq
         1N/1FMQYa9DT4BB0rIYb5S3Z/wFtujOBM1qc8E2R/4qiafqNx6GViBTFDeIjLZK/t2
         QKZ+t0Yzt9zBFblQk2pv6+Yo4heWH1o2vcWmzxBw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 139/226] netfilter: nft_exthdr: Search chunks in SCTP packets only
Date:   Mon,  9 Oct 2023 15:01:40 +0200
Message-ID: <20231009130130.373671698@linuxfoundation.org>
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

From: Phil Sutter <phil@nwl.cc>

[ Upstream commit 5acc44f39458f43dac9724cefa4da29847cfe997 ]

Since user space does not generate a payload dependency, plain sctp
chunk matches cause searching in non-SCTP packets, too. Avoid this
potential mis-interpretation of packet data by checking pkt->tprot.

Fixes: 133dc203d77df ("netfilter: nft_exthdr: Support SCTP chunks")
Signed-off-by: Phil Sutter <phil@nwl.cc>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_exthdr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nft_exthdr.c b/net/netfilter/nft_exthdr.c
index b4682aeabab96..274c5f0085186 100644
--- a/net/netfilter/nft_exthdr.c
+++ b/net/netfilter/nft_exthdr.c
@@ -371,6 +371,9 @@ static void nft_exthdr_sctp_eval(const struct nft_expr *expr,
 	const struct sctp_chunkhdr *sch;
 	struct sctp_chunkhdr _sch;
 
+	if (pkt->tprot != IPPROTO_SCTP)
+		goto err;
+
 	do {
 		sch = skb_header_pointer(pkt->skb, offset, sizeof(_sch), &_sch);
 		if (!sch || !sch->length)
@@ -391,7 +394,7 @@ static void nft_exthdr_sctp_eval(const struct nft_expr *expr,
 		}
 		offset += SCTP_PAD4(ntohs(sch->length));
 	} while (offset < pkt->skb->len);
-
+err:
 	if (priv->flags & NFT_EXTHDR_F_PRESENT)
 		nft_reg_store8(dest, false);
 	else
-- 
2.40.1



