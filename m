Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044527556A1
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbjGPUw2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbjGPUw1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:52:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69DA109
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:52:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CF8E60DFD
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:52:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508CDC433C8;
        Sun, 16 Jul 2023 20:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540745;
        bh=VxWXYK5W+H+kk+CJD8Av1oPIjEv2yvNZrh4WyIRiZnM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ObEsw2R0eIodEHkVhGO6K5pWCtM/XmcK+TaosKmOTmq+POEMVHsOqRaUIaUxry0xY
         fE0cACwhjhvOY0svJw6xKAwMYzMz5siOPSYALPdOXHM5cTBYuLhEDoTTIZH6PaRnt6
         YwqaSn1tGO+WrLrm+jqq7fusjbhFAZJloxWg6QZk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Florian Westphal <fw@strlen.de>,
        Simon Horman <simon.horman@corigine.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 473/591] net/sched: act_ipt: add sanity checks on skb before calling target
Date:   Sun, 16 Jul 2023 21:50:12 +0200
Message-ID: <20230716194936.144494329@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
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

[ Upstream commit b2dc32dcba08bf55cec600caa76f4afd2e3614df ]

Netfilter targets make assumptions on the skb state, for example
iphdr is supposed to be in the linear area.

This is normally done by IP stack, but in act_ipt case no
such checks are made.

Some targets can even assume that skb_dst will be valid.
Make a minimum effort to check for this:

- Don't call the targets eval function for non-ipv4 skbs.
- Don't call the targets eval function for POSTROUTING
  emulation when the skb has no dst set.

v3: use skb_protocol helper (Davide Caratti)

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Florian Westphal <fw@strlen.de>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/act_ipt.c |   33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

--- a/net/sched/act_ipt.c
+++ b/net/sched/act_ipt.c
@@ -229,6 +229,26 @@ static int tcf_xt_init(struct net *net,
 			      a, &act_xt_ops, tp, flags);
 }
 
+static bool tcf_ipt_act_check(struct sk_buff *skb)
+{
+	const struct iphdr *iph;
+	unsigned int nhoff, len;
+
+	if (!pskb_may_pull(skb, sizeof(struct iphdr)))
+		return false;
+
+	nhoff = skb_network_offset(skb);
+	iph = ip_hdr(skb);
+	if (iph->ihl < 5 || iph->version != 4)
+		return false;
+
+	len = skb_ip_totlen(skb);
+	if (skb->len < nhoff + len || len < (iph->ihl * 4u))
+		return false;
+
+	return pskb_may_pull(skb, iph->ihl * 4u);
+}
+
 static int tcf_ipt_act(struct sk_buff *skb, const struct tc_action *a,
 		       struct tcf_result *res)
 {
@@ -242,9 +262,22 @@ static int tcf_ipt_act(struct sk_buff *s
 		.pf	= NFPROTO_IPV4,
 	};
 
+	if (skb_protocol(skb, false) != htons(ETH_P_IP))
+		return TC_ACT_UNSPEC;
+
 	if (skb_unclone(skb, GFP_ATOMIC))
 		return TC_ACT_UNSPEC;
 
+	if (!tcf_ipt_act_check(skb))
+		return TC_ACT_UNSPEC;
+
+	if (state.hook == NF_INET_POST_ROUTING) {
+		if (!skb_dst(skb))
+			return TC_ACT_UNSPEC;
+
+		state.out = skb->dev;
+	}
+
 	spin_lock(&ipt->tcf_lock);
 
 	tcf_lastuse_update(&ipt->tcf_tm);


