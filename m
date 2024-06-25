Return-Path: <stable+bounces-55510-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EBA9163EC
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 11:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 521EB28C37A
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 09:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D609149DEF;
	Tue, 25 Jun 2024 09:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1DZYLX7W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA321487E9;
	Tue, 25 Jun 2024 09:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719309116; cv=none; b=ME+qfwoLcXm7tTk6bVoVn5/ZRaf6n+1uGjULozbG/4Cl4nTAUJvxyqvJAGtlk5N1ASZW5qnjpoev8tRIxgmzka6x/i965w4KJjgHo8u0oc/xpRlVIopfHDNe+IzAa/sTE8sqVWBRaZOJpRYOyVAz+hzDV2CNYaDN7KRand/gV5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719309116; c=relaxed/simple;
	bh=/X7DzCJLSsiiycwPbIW+SI/kn0Q+7xVHS5zTJU8fbDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VtsYK21knYMeiWkev90RFVQsF6zKP24pPWkmeKwU3aNWsoso/mtbkuTSkqX1wMIHUZQj6z6HS6zi/3Mjq1JVneehuAxhdVtLi1/YBEzOHtdpGlWBgHppWZQVk00rIQnMAS7ZNk8i291Jvnm8vhvvoQFN1/kMTQudw2GG8FYw5bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1DZYLX7W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59FAAC32781;
	Tue, 25 Jun 2024 09:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719309115;
	bh=/X7DzCJLSsiiycwPbIW+SI/kn0Q+7xVHS5zTJU8fbDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1DZYLX7WUWofYdImfZ0ndPlSdBqCaIOpOzex2odKJx1oMSRiwOoEhrdJ0cX+Sw10Y
	 Tjf8xtqlNkrUdhjN7cacauMkr0M34CDftWtXOcpuf3IavbYiRD+3SrmSHoQWGSNEHG
	 IpLwrVPYiWh5jURqNGt0AV02QKuC/W08bM/uI6EQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jianguo Wu <wujianguo@chinatelecom.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 100/192] netfilter: move the sysctl nf_hooks_lwtunnel into the netfilter core
Date: Tue, 25 Jun 2024 11:32:52 +0200
Message-ID: <20240625085541.015829898@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240625085537.150087723@linuxfoundation.org>
References: <20240625085537.150087723@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jianguo Wu <wujianguo@chinatelecom.cn>

[ Upstream commit a2225e0250c5fa397dcebf6ce65a9f05a114e0cf ]

Currently, the sysctl net.netfilter.nf_hooks_lwtunnel depends on the
nf_conntrack module, but the nf_conntrack module is not always loaded.
Therefore, accessing net.netfilter.nf_hooks_lwtunnel may have an error.

Move sysctl nf_hooks_lwtunnel into the netfilter core.

Fixes: 7a3f5b0de364 ("netfilter: add netfilter hooks to SRv6 data plane")
Suggested-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netns/netfilter.h           |    3 +
 net/netfilter/core.c                    |   13 +++++-
 net/netfilter/nf_conntrack_standalone.c |   15 -------
 net/netfilter/nf_hooks_lwtunnel.c       |   67 ++++++++++++++++++++++++++++++++
 net/netfilter/nf_internals.h            |    6 ++
 5 files changed, 87 insertions(+), 17 deletions(-)

--- a/include/net/netns/netfilter.h
+++ b/include/net/netns/netfilter.h
@@ -15,6 +15,9 @@ struct netns_nf {
 	const struct nf_logger __rcu *nf_loggers[NFPROTO_NUMPROTO];
 #ifdef CONFIG_SYSCTL
 	struct ctl_table_header *nf_log_dir_header;
+#ifdef CONFIG_LWTUNNEL
+	struct ctl_table_header *nf_lwtnl_dir_header;
+#endif
 #endif
 	struct nf_hook_entries __rcu *hooks_ipv4[NF_INET_NUMHOOKS];
 	struct nf_hook_entries __rcu *hooks_ipv6[NF_INET_NUMHOOKS];
--- a/net/netfilter/core.c
+++ b/net/netfilter/core.c
@@ -815,12 +815,21 @@ int __init netfilter_init(void)
 	if (ret < 0)
 		goto err;
 
+#ifdef CONFIG_LWTUNNEL
+	ret = netfilter_lwtunnel_init();
+	if (ret < 0)
+		goto err_lwtunnel_pernet;
+#endif
 	ret = netfilter_log_init();
 	if (ret < 0)
-		goto err_pernet;
+		goto err_log_pernet;
 
 	return 0;
-err_pernet:
+err_log_pernet:
+#ifdef CONFIG_LWTUNNEL
+	netfilter_lwtunnel_fini();
+err_lwtunnel_pernet:
+#endif
 	unregister_pernet_subsys(&netfilter_net_ops);
 err:
 	return ret;
--- a/net/netfilter/nf_conntrack_standalone.c
+++ b/net/netfilter/nf_conntrack_standalone.c
@@ -22,9 +22,6 @@
 #include <net/netfilter/nf_conntrack_acct.h>
 #include <net/netfilter/nf_conntrack_zones.h>
 #include <net/netfilter/nf_conntrack_timestamp.h>
-#ifdef CONFIG_LWTUNNEL
-#include <net/netfilter/nf_hooks_lwtunnel.h>
-#endif
 #include <linux/rculist_nulls.h>
 
 static bool enable_hooks __read_mostly;
@@ -612,9 +609,6 @@ enum nf_ct_sysctl_index {
 	NF_SYSCTL_CT_PROTO_TIMEOUT_GRE,
 	NF_SYSCTL_CT_PROTO_TIMEOUT_GRE_STREAM,
 #endif
-#ifdef CONFIG_LWTUNNEL
-	NF_SYSCTL_CT_LWTUNNEL,
-#endif
 
 	__NF_SYSCTL_CT_LAST_SYSCTL,
 };
@@ -948,15 +942,6 @@ static struct ctl_table nf_ct_sysctl_tab
 		.proc_handler   = proc_dointvec_jiffies,
 	},
 #endif
-#ifdef CONFIG_LWTUNNEL
-	[NF_SYSCTL_CT_LWTUNNEL] = {
-		.procname	= "nf_hooks_lwtunnel",
-		.data		= NULL,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= nf_hooks_lwtunnel_sysctl_handler,
-	},
-#endif
 	{}
 };
 
--- a/net/netfilter/nf_hooks_lwtunnel.c
+++ b/net/netfilter/nf_hooks_lwtunnel.c
@@ -3,6 +3,9 @@
 #include <linux/sysctl.h>
 #include <net/lwtunnel.h>
 #include <net/netfilter/nf_hooks_lwtunnel.h>
+#include <linux/netfilter.h>
+
+#include "nf_internals.h"
 
 static inline int nf_hooks_lwtunnel_get(void)
 {
@@ -50,4 +53,68 @@ int nf_hooks_lwtunnel_sysctl_handler(str
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nf_hooks_lwtunnel_sysctl_handler);
+
+static struct ctl_table nf_lwtunnel_sysctl_table[] = {
+	{
+		.procname	= "nf_hooks_lwtunnel",
+		.data		= NULL,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= nf_hooks_lwtunnel_sysctl_handler,
+	},
+};
+
+static int __net_init nf_lwtunnel_net_init(struct net *net)
+{
+	struct ctl_table_header *hdr;
+	struct ctl_table *table;
+
+	table = nf_lwtunnel_sysctl_table;
+	if (!net_eq(net, &init_net)) {
+		table = kmemdup(nf_lwtunnel_sysctl_table,
+				sizeof(nf_lwtunnel_sysctl_table),
+				GFP_KERNEL);
+		if (!table)
+			goto err_alloc;
+	}
+
+	hdr = register_net_sysctl_sz(net, "net/netfilter", table,
+				     ARRAY_SIZE(nf_lwtunnel_sysctl_table));
+	if (!hdr)
+		goto err_reg;
+
+	net->nf.nf_lwtnl_dir_header = hdr;
+
+	return 0;
+err_reg:
+	if (!net_eq(net, &init_net))
+		kfree(table);
+err_alloc:
+	return -ENOMEM;
+}
+
+static void __net_exit nf_lwtunnel_net_exit(struct net *net)
+{
+	const struct ctl_table *table;
+
+	table = net->nf.nf_lwtnl_dir_header->ctl_table_arg;
+	unregister_net_sysctl_table(net->nf.nf_lwtnl_dir_header);
+	if (!net_eq(net, &init_net))
+		kfree(table);
+}
+
+static struct pernet_operations nf_lwtunnel_net_ops = {
+	.init = nf_lwtunnel_net_init,
+	.exit = nf_lwtunnel_net_exit,
+};
+
+int __init netfilter_lwtunnel_init(void)
+{
+	return register_pernet_subsys(&nf_lwtunnel_net_ops);
+}
+
+void netfilter_lwtunnel_fini(void)
+{
+	unregister_pernet_subsys(&nf_lwtunnel_net_ops);
+}
 #endif /* CONFIG_SYSCTL */
--- a/net/netfilter/nf_internals.h
+++ b/net/netfilter/nf_internals.h
@@ -29,6 +29,12 @@ void nf_queue_nf_hook_drop(struct net *n
 /* nf_log.c */
 int __init netfilter_log_init(void);
 
+#ifdef CONFIG_LWTUNNEL
+/* nf_hooks_lwtunnel.c */
+int __init netfilter_lwtunnel_init(void);
+void netfilter_lwtunnel_fini(void);
+#endif
+
 /* core.c */
 void nf_hook_entries_delete_raw(struct nf_hook_entries __rcu **pp,
 				const struct nf_hook_ops *reg);



