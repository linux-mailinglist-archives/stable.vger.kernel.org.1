Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6B67553FD
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbjGPUZT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbjGPUZS (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:25:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA35B9F
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:25:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F35760EBB
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:25:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E805C433C8;
        Sun, 16 Jul 2023 20:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539116;
        bh=RvsSW1Hi0DPTSBPotzP+Ctk/PhA7L6l5Q7zy7Y8LtK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HN1kGbdnT99Dh8Gjw80Ut6oXrn2hX0pe4zgI8oIotpVlbZcxE9jJM+M9Sh6fZsNVt
         2xlnSt/d6owUXCz9I6O6iuQYhqHV8ii2xZnMU9bbYhQV9wKQkYkla3/ToMlxC8I7F5
         4FWdtb3IsZ2X4eGfn2BKJBBvbSlN6c9tA9dclDDY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Florian Westphal <fw@strlen.de>,
        Simon Horman <simon.horman@corigine.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 664/800] net/sched: act_ipt: zero skb->cb before calling target
Date:   Sun, 16 Jul 2023 21:48:37 +0200
Message-ID: <20230716195004.535273361@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 93d75d475c5dc3404292976147d063ee4d808592 ]

xtables relies on skb being owned by ip stack, i.e. with ipv4
check in place skb->cb is supposed to be IPCB.

I don't see an immediate problem (REJECT target cannot be used anymore
now that PRE/POSTROUTING hook validation has been fixed), but better be
safe than sorry.

A much better patch would be to either mark act_ipt as
"depends on BROKEN" or remove it altogether. I plan to do this
for -next in the near future.

This tc extension is broken in the sense that tc lacks an
equivalent of NF_STOLEN verdict.

With NF_STOLEN, target function takes complete ownership of skb, caller
cannot dereference it anymore.

ACT_STOLEN cannot be used for this: it has a different meaning, caller
is allowed to dereference the skb.

At this time NF_STOLEN won't be returned by any targets as far as I can
see, but this may change in the future.

It might be possible to work around this via list of allowed
target extensions known to only return DROP or ACCEPT verdicts, but this
is error prone/fragile.

Existing selftest only validates xt_LOG and act_ipt is restricted
to ipv4 so I don't think this action is used widely.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Florian Westphal <fw@strlen.de>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/act_ipt.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/sched/act_ipt.c b/net/sched/act_ipt.c
index a6b522b512dc3..598d6e299152a 100644
--- a/net/sched/act_ipt.c
+++ b/net/sched/act_ipt.c
@@ -21,6 +21,7 @@
 #include <linux/tc_act/tc_ipt.h>
 #include <net/tc_act/tc_ipt.h>
 #include <net/tc_wrapper.h>
+#include <net/ip.h>
 
 #include <linux/netfilter_ipv4/ip_tables.h>
 
@@ -254,6 +255,7 @@ TC_INDIRECT_SCOPE int tcf_ipt_act(struct sk_buff *skb,
 				  const struct tc_action *a,
 				  struct tcf_result *res)
 {
+	char saved_cb[sizeof_field(struct sk_buff, cb)];
 	int ret = 0, result = 0;
 	struct tcf_ipt *ipt = to_ipt(a);
 	struct xt_action_param par;
@@ -280,6 +282,8 @@ TC_INDIRECT_SCOPE int tcf_ipt_act(struct sk_buff *skb,
 		state.out = skb->dev;
 	}
 
+	memcpy(saved_cb, skb->cb, sizeof(saved_cb));
+
 	spin_lock(&ipt->tcf_lock);
 
 	tcf_lastuse_update(&ipt->tcf_tm);
@@ -292,6 +296,9 @@ TC_INDIRECT_SCOPE int tcf_ipt_act(struct sk_buff *skb,
 	par.state    = &state;
 	par.target   = ipt->tcfi_t->u.kernel.target;
 	par.targinfo = ipt->tcfi_t->data;
+
+	memset(IPCB(skb), 0, sizeof(struct inet_skb_parm));
+
 	ret = par.target->target(skb, &par);
 
 	switch (ret) {
@@ -312,6 +319,9 @@ TC_INDIRECT_SCOPE int tcf_ipt_act(struct sk_buff *skb,
 		break;
 	}
 	spin_unlock(&ipt->tcf_lock);
+
+	memcpy(skb->cb, saved_cb, sizeof(skb->cb));
+
 	return result;
 
 }
-- 
2.39.2



