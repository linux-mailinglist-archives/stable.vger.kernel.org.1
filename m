Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B764B7ED055
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235556AbjKOTyV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235558AbjKOTyU (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:54:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37F8B9
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:54:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C38CC433CB;
        Wed, 15 Nov 2023 19:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078057;
        bh=btoX9u65sHIbT5Pka8iV+T1awYhrOhi+VfrSpmyapOg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M8EAcPfwHHs2XsEUB6/Xq/UbwRRk6xi02jUwwR0KtVJ+isYgbpS4CP0lG98bYjK5U
         2p7njj7YuMKQ9vDVkPrgbBL5GmPOHjG3TvvCa4ousf1w9i8YDISAMBbdadio+732B0
         jaCPLwwYeec1Y2JUtjH+98mKkmkBfj2B/7Or0UKA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Phil Sutter <phil@nwl.cc>,
        Florian Westphal <fw@strlen.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 059/379] netfilter: nf_tables: Drop pointless memset when dumping rules
Date:   Wed, 15 Nov 2023 14:22:14 -0500
Message-ID: <20231115192648.647189251@linuxfoundation.org>
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

From: Phil Sutter <phil@nwl.cc>

[ Upstream commit 30fa41a0f6df4c85790cc6499ddc4a926a113bfa ]

None of the dump callbacks uses netlink_callback::args beyond the first
element, no need to zero the data.

Fixes: 96518518cc41 ("netfilter: add nftables")
Signed-off-by: Phil Sutter <phil@nwl.cc>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 5c783199b4999..d6d59e36d17a7 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3279,10 +3279,6 @@ static int __nf_tables_dump_rules(struct sk_buff *skb,
 			goto cont_skip;
 		if (*idx < s_idx)
 			goto cont;
-		if (*idx > s_idx) {
-			memset(&cb->args[1], 0,
-					sizeof(cb->args) - sizeof(cb->args[0]));
-		}
 		if (prule)
 			handle = prule->handle;
 		else
-- 
2.42.0



