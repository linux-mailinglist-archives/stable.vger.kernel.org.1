Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA7E7832BB
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjHUTzz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 15:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjHUTzy (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 15:55:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7B712A
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 12:55:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89FD2641D5
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 19:55:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF6CC433C8;
        Mon, 21 Aug 2023 19:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692647743;
        bh=/n9RbwhLuk1NdjMKMZDc+nv73wejL7euPUd27sv06iU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OleqEoFPlzX71RdMdd2JrMVATzXdCbfzlMV9euJNmKNdEUD4fHIO2cQY6uodBNBJF
         r7q3uxUKz456eXMTs2wUCC/+euGDP8H+WoWvmsRAiwX+1gt9eWX0XFXtiXjw6l/uFD
         B6bGyWbjjhQgWr4oio3xTNe8cJo0HiLb7uComLy8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sishuai Gong <sishuai.system@gmail.com>,
        Simon Horman <horms@kernel.org>, Julian Anastasov <ja@ssi.bg>,
        Florian Westphal <fw@strlen.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 122/194] ipvs: fix racy memcpy in proc_do_sync_threshold
Date:   Mon, 21 Aug 2023 21:41:41 +0200
Message-ID: <20230821194128.077291235@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194122.695845670@linuxfoundation.org>
References: <20230821194122.695845670@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Sishuai Gong <sishuai.system@gmail.com>

[ Upstream commit 5310760af1d4fbea1452bfc77db5f9a680f7ae47 ]

When two threads run proc_do_sync_threshold() in parallel,
data races could happen between the two memcpy():

Thread-1			Thread-2
memcpy(val, valp, sizeof(val));
				memcpy(valp, val, sizeof(val));

This race might mess up the (struct ctl_table *) table->data,
so we add a mutex lock to serialize them.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Link: https://lore.kernel.org/netdev/B6988E90-0A1E-4B85-BF26-2DAF6D482433@gmail.com/
Signed-off-by: Sishuai Gong <sishuai.system@gmail.com>
Acked-by: Simon Horman <horms@kernel.org>
Acked-by: Julian Anastasov <ja@ssi.bg>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/ipvs/ip_vs_ctl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index 03af6a2ffd567..17a1b731a76b1 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -1798,6 +1798,7 @@ static int
 proc_do_sync_threshold(struct ctl_table *table, int write,
 		       void *buffer, size_t *lenp, loff_t *ppos)
 {
+	struct netns_ipvs *ipvs = table->extra2;
 	int *valp = table->data;
 	int val[2];
 	int rc;
@@ -1807,6 +1808,7 @@ proc_do_sync_threshold(struct ctl_table *table, int write,
 		.mode = table->mode,
 	};
 
+	mutex_lock(&ipvs->sync_mutex);
 	memcpy(val, valp, sizeof(val));
 	rc = proc_dointvec(&tmp, write, buffer, lenp, ppos);
 	if (write) {
@@ -1816,6 +1818,7 @@ proc_do_sync_threshold(struct ctl_table *table, int write,
 		else
 			memcpy(valp, val, sizeof(val));
 	}
+	mutex_unlock(&ipvs->sync_mutex);
 	return rc;
 }
 
@@ -4080,6 +4083,7 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
 	ipvs->sysctl_sync_threshold[0] = DEFAULT_SYNC_THRESHOLD;
 	ipvs->sysctl_sync_threshold[1] = DEFAULT_SYNC_PERIOD;
 	tbl[idx].data = &ipvs->sysctl_sync_threshold;
+	tbl[idx].extra2 = ipvs;
 	tbl[idx++].maxlen = sizeof(ipvs->sysctl_sync_threshold);
 	ipvs->sysctl_sync_refresh_period = DEFAULT_SYNC_REFRESH_PERIOD;
 	tbl[idx++].data = &ipvs->sysctl_sync_refresh_period;
-- 
2.40.1



