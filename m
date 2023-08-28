Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628EE78AB2E
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjH1K2k (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbjH1K21 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:28:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE0E136
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:28:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F264263BC6
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:28:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F94C433C7;
        Mon, 28 Aug 2023 10:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218499;
        bh=TcA3HtzEvy/Zs9AGzsS6fGgJUy9zoIlETYhu0bLsgmc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yODpLQy4wKBT9QVgPN/2sJi6+54UjYwyZx2iZetf6M11IqQCAzSl4s4/T0RZjxE7O
         EMx9DwMTsX/k9XPx/53EgknDPbEgPUjqBABjGR6t6ZzN0/DnO9JpLrH2Wcjz34n9AR
         Z/gbKsWhS8BLJ2BLQZo5dPJbjRqnhKj5qPz9KT4g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sishuai Gong <sishuai.system@gmail.com>,
        Simon Horman <horms@kernel.org>, Julian Anastasov <ja@ssi.bg>,
        Florian Westphal <fw@strlen.de>
Subject: [PATCH 4.19 109/129] ipvs: fix racy memcpy in proc_do_sync_threshold
Date:   Mon, 28 Aug 2023 12:13:23 +0200
Message-ID: <20230828101157.232908332@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101153.030066927@linuxfoundation.org>
References: <20230828101153.030066927@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sishuai Gong <sishuai.system@gmail.com>

commit 5310760af1d4fbea1452bfc77db5f9a680f7ae47 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/ipvs/ip_vs_ctl.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -1690,6 +1690,7 @@ static int
 proc_do_sync_threshold(struct ctl_table *table, int write,
 		       void __user *buffer, size_t *lenp, loff_t *ppos)
 {
+	struct netns_ipvs *ipvs = table->extra2;
 	int *valp = table->data;
 	int val[2];
 	int rc;
@@ -1699,6 +1700,7 @@ proc_do_sync_threshold(struct ctl_table
 		.mode = table->mode,
 	};
 
+	mutex_lock(&ipvs->sync_mutex);
 	memcpy(val, valp, sizeof(val));
 	rc = proc_dointvec(&tmp, write, buffer, lenp, ppos);
 	if (write) {
@@ -1708,6 +1710,7 @@ proc_do_sync_threshold(struct ctl_table
 		else
 			memcpy(valp, val, sizeof(val));
 	}
+	mutex_unlock(&ipvs->sync_mutex);
 	return rc;
 }
 
@@ -3944,6 +3947,7 @@ static int __net_init ip_vs_control_net_
 	ipvs->sysctl_sync_threshold[0] = DEFAULT_SYNC_THRESHOLD;
 	ipvs->sysctl_sync_threshold[1] = DEFAULT_SYNC_PERIOD;
 	tbl[idx].data = &ipvs->sysctl_sync_threshold;
+	tbl[idx].extra2 = ipvs;
 	tbl[idx++].maxlen = sizeof(ipvs->sysctl_sync_threshold);
 	ipvs->sysctl_sync_refresh_period = DEFAULT_SYNC_REFRESH_PERIOD;
 	tbl[idx++].data = &ipvs->sysctl_sync_refresh_period;


