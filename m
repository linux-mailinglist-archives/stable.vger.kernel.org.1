Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F881782A95
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 15:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235435AbjHUNdX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 09:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235449AbjHUNdW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 09:33:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9913EFA
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 06:33:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3492663628
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:33:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ACC5C433C7;
        Mon, 21 Aug 2023 13:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692624797;
        bh=SiuLthxQWzEjw7YjbtAddgHQzK5Nb8VeydHC1Ku0bJ4=;
        h=Subject:To:Cc:From:Date:From;
        b=sEewrdu9xhenVUxuSxLSF36vOlCdq24OeH/erQmWqwK9BkKPAjztFXvf3hZRRtgyr
         REy3m6NeaebFb58LlEjd+RLCxj0m3EMtU9CdOML8ht/iefmM8s9kmaVg0jVVKiMMBy
         h1OKvYN72PJIypEEJ6mDJkyzSj2GB6PedhelXVVw=
Subject: FAILED: patch "[PATCH] ipvs: fix racy memcpy in proc_do_sync_threshold" failed to apply to 4.19-stable tree
To:     sishuai.system@gmail.com, fw@strlen.de, horms@kernel.org, ja@ssi.bg
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 21 Aug 2023 15:33:14 +0200
Message-ID: <2023082114-remix-cable-0852@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 5310760af1d4fbea1452bfc77db5f9a680f7ae47
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023082114-remix-cable-0852@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

5310760af1d4 ("ipvs: fix racy memcpy in proc_do_sync_threshold")
1b90af292e71 ("ipvs: Improve robustness to the ipvs sysctl")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5310760af1d4fbea1452bfc77db5f9a680f7ae47 Mon Sep 17 00:00:00 2001
From: Sishuai Gong <sishuai.system@gmail.com>
Date: Thu, 10 Aug 2023 15:12:42 -0400
Subject: [PATCH] ipvs: fix racy memcpy in proc_do_sync_threshold

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

diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index 62606fb44d02..4bb0d90eca1c 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -1876,6 +1876,7 @@ static int
 proc_do_sync_threshold(struct ctl_table *table, int write,
 		       void *buffer, size_t *lenp, loff_t *ppos)
 {
+	struct netns_ipvs *ipvs = table->extra2;
 	int *valp = table->data;
 	int val[2];
 	int rc;
@@ -1885,6 +1886,7 @@ proc_do_sync_threshold(struct ctl_table *table, int write,
 		.mode = table->mode,
 	};
 
+	mutex_lock(&ipvs->sync_mutex);
 	memcpy(val, valp, sizeof(val));
 	rc = proc_dointvec(&tmp, write, buffer, lenp, ppos);
 	if (write) {
@@ -1894,6 +1896,7 @@ proc_do_sync_threshold(struct ctl_table *table, int write,
 		else
 			memcpy(valp, val, sizeof(val));
 	}
+	mutex_unlock(&ipvs->sync_mutex);
 	return rc;
 }
 
@@ -4321,6 +4324,7 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
 	ipvs->sysctl_sync_threshold[0] = DEFAULT_SYNC_THRESHOLD;
 	ipvs->sysctl_sync_threshold[1] = DEFAULT_SYNC_PERIOD;
 	tbl[idx].data = &ipvs->sysctl_sync_threshold;
+	tbl[idx].extra2 = ipvs;
 	tbl[idx++].maxlen = sizeof(ipvs->sysctl_sync_threshold);
 	ipvs->sysctl_sync_refresh_period = DEFAULT_SYNC_REFRESH_PERIOD;
 	tbl[idx++].data = &ipvs->sysctl_sync_refresh_period;

