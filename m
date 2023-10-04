Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A604A7B8807
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243938AbjJDSMJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243932AbjJDSMH (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:12:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A86FF
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:11:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A3F3C433C7;
        Wed,  4 Oct 2023 18:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443118;
        bh=+EbdwY0676tyVMWyFSwMWq0hLBGrjHtVenbTJSlz/+k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eVDfuqrh9ouNGF7rlZyuXsFx22O4muMOV2+1vdadZxVMbYjPAj01RWCyru+VXAKTx
         LnYYCpo4QaSk6gb/LiLzqudKKJQkcQQAwQCxad7gs8Q/lYJZHjcG6Qehhe2eYJfn/a
         4m5kZszTZQHCu6eGAAvtg/RAXSDMUCSnURT3C8b8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 043/259] netfilter: conntrack: fix extension size table
Date:   Wed,  4 Oct 2023 19:53:36 +0200
Message-ID: <20231004175219.414222139@linuxfoundation.org>
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

[ Upstream commit 4908d5af16676b9d2901830551c2af911e452524 ]

The size table is incorrect due to copypaste error,
this reserves more size than needed.

TSTAMP reserved 32 instead of 16 bytes.
TIMEOUT reserved 16 instead of 8 bytes.

Fixes: 5f31edc0676b ("netfilter: conntrack: move extension sizes into core")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_conntrack_extend.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_conntrack_extend.c b/net/netfilter/nf_conntrack_extend.c
index 0b513f7bf9f39..dd62cc12e7750 100644
--- a/net/netfilter/nf_conntrack_extend.c
+++ b/net/netfilter/nf_conntrack_extend.c
@@ -40,10 +40,10 @@ static const u8 nf_ct_ext_type_len[NF_CT_EXT_NUM] = {
 	[NF_CT_EXT_ECACHE] = sizeof(struct nf_conntrack_ecache),
 #endif
 #ifdef CONFIG_NF_CONNTRACK_TIMESTAMP
-	[NF_CT_EXT_TSTAMP] = sizeof(struct nf_conn_acct),
+	[NF_CT_EXT_TSTAMP] = sizeof(struct nf_conn_tstamp),
 #endif
 #ifdef CONFIG_NF_CONNTRACK_TIMEOUT
-	[NF_CT_EXT_TIMEOUT] = sizeof(struct nf_conn_tstamp),
+	[NF_CT_EXT_TIMEOUT] = sizeof(struct nf_conn_timeout),
 #endif
 #ifdef CONFIG_NF_CONNTRACK_LABELS
 	[NF_CT_EXT_LABELS] = sizeof(struct nf_conn_labels),
-- 
2.40.1



