Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95CEC7612DA
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbjGYLGD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbjGYLFn (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:05:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA9A3C1E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:03:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC3A361656
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:03:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA88CC433C8;
        Tue, 25 Jul 2023 11:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283027;
        bh=WPKxH0RwzkDkinxA4WNapnX8of9SXacRmD1CkK/etOA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=blNao8g4WuhBPixps6S2HiCFwzRW7XcDD6+5PtB408hTtAPRHVDX88Hh3WzlwXNKA
         ThK7ySSXdXFwOxNh1HasjkxO9kOEwdyOFBVb8dFXSTi2mIxArNIvzhG9u0upftAJoZ
         F0LuMyZb3nKvuc96e+veUCSahevoVbHGBJpKC5yI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Victor Nogueira <victor@mojatatu.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        Simon Horman <simon.horman@corigine.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 112/183] net: sched: cls_u32: Undo refcount decrement in case update failed
Date:   Tue, 25 Jul 2023 12:45:40 +0200
Message-ID: <20230725104511.997330088@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104507.756981058@linuxfoundation.org>
References: <20230725104507.756981058@linuxfoundation.org>
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

From: Victor Nogueira <victor@mojatatu.com>

[ Upstream commit e8d3d78c19be0264a5692bed477c303523aead31 ]

In the case of an update, when TCA_U32_LINK is set, u32_set_parms will
decrement the refcount of the ht_down (struct tc_u_hnode) pointer
present in the older u32 filter which we are replacing. However, if
u32_replace_hw_knode errors out, the update command fails and that
ht_down pointer continues decremented. To fix that, when
u32_replace_hw_knode fails, check if ht_down's refcount was decremented
and undo the decrement.

Fixes: d34e3e181395 ("net: cls_u32: Add support for skip-sw flag to tc u32 classifier.")
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/cls_u32.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index 7cfbcd5180841..1280736a7b92e 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -926,6 +926,13 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 		if (err) {
 			u32_unbind_filter(tp, new, tb);
 
+			if (tb[TCA_U32_LINK]) {
+				struct tc_u_hnode *ht_old;
+
+				ht_old = rtnl_dereference(n->ht_down);
+				if (ht_old)
+					ht_old->refcnt++;
+			}
 			__u32_destroy_key(new);
 			return err;
 		}
-- 
2.39.2



