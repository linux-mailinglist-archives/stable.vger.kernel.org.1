Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93FC726F44
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235554AbjFGU5C (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235548AbjFGU5A (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:57:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7B6211C
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:56:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CDF864813
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:56:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21166C433D2;
        Wed,  7 Jun 2023 20:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171411;
        bh=kCfysWGPr0GW7224XhZOKoTWBEDNsdA5cXnN6vUQLJc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n4/oqpnLJ+pn2fQUfIvlVu3mF502ZHDFrMtYHn9J2yQ/1MF83/3wD9UGhCujeLJZP
         7Td2x1MBEIybkc7Yyq0EXdFuvOJ6WW3Ekwh0evffbdmf9OJzrUyVtdp4frPlBq7qmH
         Iyec6HjgG+975v9PkAoXEdVSHLP3kB0LmsyFEzGw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Guillaume Nault <gnault@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 73/99] flow_dissector: work around stack frame size warning
Date:   Wed,  7 Jun 2023 22:17:05 +0200
Message-ID: <20230607200902.517691022@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200900.195572674@linuxfoundation.org>
References: <20230607200900.195572674@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

commit 0af413bd3e2de73bcf0742ed556be4af83c71964 upstream.

The fl_flow_key structure is around 500 bytes, so having two of them
on the stack in one function now exceeds the warning limit after an
otherwise correct change:

net/sched/cls_flower.c:298:12: error: stack frame size of 1056 bytes in function 'fl_classify' [-Werror,-Wframe-larger-than=]

I suspect the fl_classify function could be reworked to only have one
of them on the stack and modify it in place, but I could not work out
how to do that.

As a somewhat hacky workaround, move one of them into an out-of-line
function to reduce its scope. This does not necessarily reduce the stack
usage of the outer function, but at least the second copy is removed
from the stack during most of it and does not add up to whatever is
called from there.

I now see 552 bytes of stack usage for fl_classify(), plus 528 bytes
for fl_mask_lookup().

Fixes: 58cff782cc55 ("flow_dissector: Parse multiple MPLS Label Stack Entries")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Cong Wang <xiyou.wangcong@gmail.com>
Acked-by: Guillaume Nault <gnault@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/cls_flower.c |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -270,14 +270,16 @@ static struct cls_fl_filter *fl_lookup_r
 	return NULL;
 }
 
-static struct cls_fl_filter *fl_lookup(struct fl_flow_mask *mask,
-				       struct fl_flow_key *mkey,
-				       struct fl_flow_key *key)
+static noinline_for_stack
+struct cls_fl_filter *fl_mask_lookup(struct fl_flow_mask *mask, struct fl_flow_key *key)
 {
+	struct fl_flow_key mkey;
+
+	fl_set_masked_key(&mkey, key, mask);
 	if ((mask->flags & TCA_FLOWER_MASK_FLAGS_RANGE))
-		return fl_lookup_range(mask, mkey, key);
+		return fl_lookup_range(mask, &mkey, key);
 
-	return __fl_lookup(mask, mkey);
+	return __fl_lookup(mask, &mkey);
 }
 
 static u16 fl_ct_info_to_flower_map[] = {
@@ -297,7 +299,6 @@ static int fl_classify(struct sk_buff *s
 		       struct tcf_result *res)
 {
 	struct cls_fl_head *head = rcu_dereference_bh(tp->root);
-	struct fl_flow_key skb_mkey;
 	struct fl_flow_key skb_key;
 	struct fl_flow_mask *mask;
 	struct cls_fl_filter *f;
@@ -317,9 +318,7 @@ static int fl_classify(struct sk_buff *s
 				    ARRAY_SIZE(fl_ct_info_to_flower_map));
 		skb_flow_dissect(skb, &mask->dissector, &skb_key, 0);
 
-		fl_set_masked_key(&skb_mkey, &skb_key, mask);
-
-		f = fl_lookup(mask, &skb_mkey, &skb_key);
+		f = fl_mask_lookup(mask, &skb_key);
 		if (f && !tc_skip_sw(f->flags)) {
 			*res = f->res;
 			return tcf_exts_exec(skb, &f->exts, res);


