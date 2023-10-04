Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8827B8832
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243963AbjJDSNi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243956AbjJDSNh (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:13:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152C49E
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:13:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B963C433CA;
        Wed,  4 Oct 2023 18:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443213;
        bh=1JcdUqcdrg+Btaxs6nnfe0UoBUWjzfs2PHtFxWml1eQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HnHU6GZ2dUVeiw0sENI4AfVUfILQvBlLLoD8Sg9i0cGNEsq4uGO2cEWS6AJm3Fru7
         mN4ev3ht/L8GPudPStrvuIGc7sA3vyMTnrlKZ0QEtjp+tDzcyME2ATOEX0UKJMHhPW
         ADHNkf9Iox54sgNYk6Na5hkGnEdLDRhpsW9cgfTU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Lee, Cherie-Anne" <cherie.lee@starlabs.sg>,
        Bing-Jhong Billy Jheng <billy@starlabs.sg>, info@starlabs.sg,
        Florian Westphal <fw@strlen.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 077/259] netfilter: nf_tables: disable toggling dormant table state more than once
Date:   Wed,  4 Oct 2023 19:54:10 +0200
Message-ID: <20231004175220.911829777@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

[ Upstream commit c9bd26513b3a11b3adb3c2ed8a31a01a87173ff1 ]

nft -f -<<EOF
add table ip t
add table ip t { flags dormant; }
add chain ip t c { type filter hook input priority 0; }
add table ip t
EOF

Triggers a splat from nf core on next table delete because we lose
track of right hook register state:

WARNING: CPU: 2 PID: 1597 at net/netfilter/core.c:501 __nf_unregister_net_hook
RIP: 0010:__nf_unregister_net_hook+0x41b/0x570
 nf_unregister_net_hook+0xb4/0xf0
 __nf_tables_unregister_hook+0x160/0x1d0
[..]

The above should have table in *active* state, but in fact no
hooks were registered.

Reject on/off/on games rather than attempting to fix this.

Fixes: 179d9ba5559a ("netfilter: nf_tables: fix table flag updates")
Reported-by: "Lee, Cherie-Anne" <cherie.lee@starlabs.sg>
Cc: Bing-Jhong Billy Jheng <billy@starlabs.sg>
Cc: info@starlabs.sg
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 521f8c3cb6987..1d6a37430ff6b 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1211,6 +1211,10 @@ static int nf_tables_updtable(struct nft_ctx *ctx)
 	     flags & NFT_TABLE_F_OWNER))
 		return -EOPNOTSUPP;
 
+	/* No dormant off/on/off/on games in single transaction */
+	if (ctx->table->flags & __NFT_TABLE_F_UPDATE)
+		return -EINVAL;
+
 	trans = nft_trans_alloc(ctx, NFT_MSG_NEWTABLE,
 				sizeof(struct nft_trans_table));
 	if (trans == NULL)
-- 
2.40.1



