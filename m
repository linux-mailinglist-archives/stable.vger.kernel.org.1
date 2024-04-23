Return-Path: <stable+bounces-41242-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FC58AFADF
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 23:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE8C11C235A2
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 21:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA69F14AD31;
	Tue, 23 Apr 2024 21:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z7XYEAWV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D8414389D;
	Tue, 23 Apr 2024 21:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908774; cv=none; b=jxmSBg1ttdLP0pd9lCl3a/x+L4LVMhusL7TFaDbclugLpm7zEfbBa3nh5bDWDk4Got43hZ6CEIVqS0+7WFWVlHmz9fRKfpj1/iqtR3mG2x+wAkXsSf7ad+9rcSb65hXMp1NMdk38DxZwJz3c3Rhb92+BmOuFw2VGrACT4DjGC88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908774; c=relaxed/simple;
	bh=H1mZliqvHiSFpcmjzFSB5uXV3XIaf0kGbt0h+Rn2Sgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fsF+O7itOCei3IV+OqJ4wKEMQIqbElZ/6nvp8Iembkp1xJ67YkzrTir72Q70Dp3MTPi6JkDdZUmPVzi1QXRryYqX3FET3/lYBBYtlnTxzgU7swI7TPEMU5i3MVZOPBhn72IrjkRIxIyw33QIFVyHrpXTdQmOErLEM8FZayJ1bT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z7XYEAWV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B753C116B1;
	Tue, 23 Apr 2024 21:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713908774;
	bh=H1mZliqvHiSFpcmjzFSB5uXV3XIaf0kGbt0h+Rn2Sgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z7XYEAWVEPeXnTXgzf+/rliDz90D0co0TqxHU1Dg7Uw0gce8UZ5JZhTYJP8V6oOcs
	 Pb1QgzqFby2DBLoRqtv/P57hGGUhe1mDNhnpL76uTRIYkCNZq2p5S1/SF4ntB6DNf7
	 VdlHH+2JROEn1iEi4emQUrdQA5KJbtaK15s9Y2aY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vlad Buslov <vladbu@nvidia.com>,
	Oz Shlomo <ozsh@nvidia.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 19/71] netfilter: nf_flow_table: count pending offload workqueue tasks
Date: Tue, 23 Apr 2024 14:39:32 -0700
Message-ID: <20240423213844.781925919@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423213844.122920086@linuxfoundation.org>
References: <20240423213844.122920086@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vlad Buslov <vladbu@nvidia.com>

[ Upstream commit b038177636f83bbf87c2b238706474145dd2cd04 ]

To improve hardware offload debuggability count pending 'add', 'del' and
'stats' flow_table offload workqueue tasks. Counters are incremented before
scheduling new task and decremented when workqueue handler finishes
executing. These counters allow user to diagnose congestion on hardware
offload workqueues that can happen when either CPU is starved and workqueue
jobs are executed at lower rate than new ones are added or when
hardware/driver can't keep up with the rate.

Implement the described counters as percpu counters inside new struct
netns_ft which is stored inside struct net. Expose them via new procfs file
'/proc/net/stats/nf_flowtable' that is similar to existing 'nf_conntrack'
file.

Signed-off-by: Vlad Buslov <vladbu@nvidia.com>
Signed-off-by: Oz Shlomo <ozsh@nvidia.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Stable-dep-of: 87b3593bed18 ("netfilter: flowtable: validate pppoe header")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/net_namespace.h           |  6 ++
 include/net/netfilter/nf_flow_table.h | 21 +++++++
 include/net/netns/flow_table.h        | 14 +++++
 net/netfilter/Kconfig                 |  9 +++
 net/netfilter/Makefile                |  1 +
 net/netfilter/nf_flow_table_core.c    | 62 ++++++++++++++++++++-
 net/netfilter/nf_flow_table_offload.c | 17 +++++-
 net/netfilter/nf_flow_table_procfs.c  | 80 +++++++++++++++++++++++++++
 8 files changed, 206 insertions(+), 4 deletions(-)
 create mode 100644 include/net/netns/flow_table.h
 create mode 100644 net/netfilter/nf_flow_table_procfs.c

diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 2ba326f9e004d..c47baa623ba58 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -26,6 +26,9 @@
 #if defined(CONFIG_NF_CONNTRACK) || defined(CONFIG_NF_CONNTRACK_MODULE)
 #include <net/netns/conntrack.h>
 #endif
+#if IS_ENABLED(CONFIG_NF_FLOW_TABLE)
+#include <net/netns/flow_table.h>
+#endif
 #include <net/netns/nftables.h>
 #include <net/netns/xfrm.h>
 #include <net/netns/mpls.h>
@@ -138,6 +141,9 @@ struct net {
 #if defined(CONFIG_NF_TABLES) || defined(CONFIG_NF_TABLES_MODULE)
 	struct netns_nftables	nft;
 #endif
+#if IS_ENABLED(CONFIG_NF_FLOW_TABLE)
+	struct netns_ft ft;
+#endif
 #endif
 #ifdef CONFIG_WEXT_CORE
 	struct sk_buff_head	wext_nlevents;
diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
index dabd84fa3fd36..6cc0cfbf69b86 100644
--- a/include/net/netfilter/nf_flow_table.h
+++ b/include/net/netfilter/nf_flow_table.h
@@ -334,4 +334,25 @@ static inline __be16 nf_flow_pppoe_proto(const struct sk_buff *skb)
 	return 0;
 }
 
+#define NF_FLOW_TABLE_STAT_INC(net, count) __this_cpu_inc((net)->ft.stat->count)
+#define NF_FLOW_TABLE_STAT_DEC(net, count) __this_cpu_dec((net)->ft.stat->count)
+#define NF_FLOW_TABLE_STAT_INC_ATOMIC(net, count)	\
+	this_cpu_inc((net)->ft.stat->count)
+#define NF_FLOW_TABLE_STAT_DEC_ATOMIC(net, count)	\
+	this_cpu_dec((net)->ft.stat->count)
+
+#ifdef CONFIG_NF_FLOW_TABLE_PROCFS
+int nf_flow_table_init_proc(struct net *net);
+void nf_flow_table_fini_proc(struct net *net);
+#else
+static inline int nf_flow_table_init_proc(struct net *net)
+{
+	return 0;
+}
+
+static inline void nf_flow_table_fini_proc(struct net *net)
+{
+}
+#endif /* CONFIG_NF_FLOW_TABLE_PROCFS */
+
 #endif /* _NF_FLOW_TABLE_H */
diff --git a/include/net/netns/flow_table.h b/include/net/netns/flow_table.h
new file mode 100644
index 0000000000000..1c5fc657e2675
--- /dev/null
+++ b/include/net/netns/flow_table.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __NETNS_FLOW_TABLE_H
+#define __NETNS_FLOW_TABLE_H
+
+struct nf_flow_table_stat {
+	unsigned int count_wq_add;
+	unsigned int count_wq_del;
+	unsigned int count_wq_stats;
+};
+
+struct netns_ft {
+	struct nf_flow_table_stat __percpu *stat;
+};
+#endif
diff --git a/net/netfilter/Kconfig b/net/netfilter/Kconfig
index 4f645d51c2573..f02ebe4609650 100644
--- a/net/netfilter/Kconfig
+++ b/net/netfilter/Kconfig
@@ -728,6 +728,15 @@ config NF_FLOW_TABLE
 
 	  To compile it as a module, choose M here.
 
+config NF_FLOW_TABLE_PROCFS
+	bool "Supply flow table statistics in procfs"
+	default y
+	depends on PROC_FS
+	depends on SYSCTL
+	help
+	  This option enables for the flow table offload statistics
+	  to be shown in procfs under net/netfilter/nf_flowtable.
+
 config NETFILTER_XTABLES
 	tristate "Netfilter Xtables support (required for ip_tables)"
 	default m if NETFILTER_ADVANCED=n
diff --git a/net/netfilter/Makefile b/net/netfilter/Makefile
index aab20e575ecd8..3f77f20ae39e4 100644
--- a/net/netfilter/Makefile
+++ b/net/netfilter/Makefile
@@ -124,6 +124,7 @@ obj-$(CONFIG_NFT_FWD_NETDEV)	+= nft_fwd_netdev.o
 obj-$(CONFIG_NF_FLOW_TABLE)	+= nf_flow_table.o
 nf_flow_table-objs		:= nf_flow_table_core.o nf_flow_table_ip.o \
 				   nf_flow_table_offload.o
+nf_flow_table-$(CONFIG_NF_FLOW_TABLE_PROCFS) += nf_flow_table_procfs.o
 
 obj-$(CONFIG_NF_FLOW_TABLE_INET) += nf_flow_table_inet.o
 
diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
index e78cdd73ef628..beb0e84b5f427 100644
--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -606,14 +606,74 @@ void nf_flow_table_free(struct nf_flowtable *flow_table)
 }
 EXPORT_SYMBOL_GPL(nf_flow_table_free);
 
+static int nf_flow_table_init_net(struct net *net)
+{
+	net->ft.stat = alloc_percpu(struct nf_flow_table_stat);
+	return net->ft.stat ? 0 : -ENOMEM;
+}
+
+static void nf_flow_table_fini_net(struct net *net)
+{
+	free_percpu(net->ft.stat);
+}
+
+static int nf_flow_table_pernet_init(struct net *net)
+{
+	int ret;
+
+	ret = nf_flow_table_init_net(net);
+	if (ret < 0)
+		return ret;
+
+	ret = nf_flow_table_init_proc(net);
+	if (ret < 0)
+		goto out_proc;
+
+	return 0;
+
+out_proc:
+	nf_flow_table_fini_net(net);
+	return ret;
+}
+
+static void nf_flow_table_pernet_exit(struct list_head *net_exit_list)
+{
+	struct net *net;
+
+	list_for_each_entry(net, net_exit_list, exit_list) {
+		nf_flow_table_fini_proc(net);
+		nf_flow_table_fini_net(net);
+	}
+}
+
+static struct pernet_operations nf_flow_table_net_ops = {
+	.init = nf_flow_table_pernet_init,
+	.exit_batch = nf_flow_table_pernet_exit,
+};
+
 static int __init nf_flow_table_module_init(void)
 {
-	return nf_flow_table_offload_init();
+	int ret;
+
+	ret = register_pernet_subsys(&nf_flow_table_net_ops);
+	if (ret < 0)
+		return ret;
+
+	ret = nf_flow_table_offload_init();
+	if (ret)
+		goto out_offload;
+
+	return 0;
+
+out_offload:
+	unregister_pernet_subsys(&nf_flow_table_net_ops);
+	return ret;
 }
 
 static void __exit nf_flow_table_module_exit(void)
 {
 	nf_flow_table_offload_exit();
+	unregister_pernet_subsys(&nf_flow_table_net_ops);
 }
 
 module_init(nf_flow_table_module_init);
diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flow_table_offload.c
index 336f282a221fd..6ac1ebe17456d 100644
--- a/net/netfilter/nf_flow_table_offload.c
+++ b/net/netfilter/nf_flow_table_offload.c
@@ -953,17 +953,22 @@ static void flow_offload_work_stats(struct flow_offload_work *offload)
 static void flow_offload_work_handler(struct work_struct *work)
 {
 	struct flow_offload_work *offload;
+	struct net *net;
 
 	offload = container_of(work, struct flow_offload_work, work);
+	net = read_pnet(&offload->flowtable->net);
 	switch (offload->cmd) {
 		case FLOW_CLS_REPLACE:
 			flow_offload_work_add(offload);
+			NF_FLOW_TABLE_STAT_DEC_ATOMIC(net, count_wq_add);
 			break;
 		case FLOW_CLS_DESTROY:
 			flow_offload_work_del(offload);
+			NF_FLOW_TABLE_STAT_DEC_ATOMIC(net, count_wq_del);
 			break;
 		case FLOW_CLS_STATS:
 			flow_offload_work_stats(offload);
+			NF_FLOW_TABLE_STAT_DEC_ATOMIC(net, count_wq_stats);
 			break;
 		default:
 			WARN_ON_ONCE(1);
@@ -975,12 +980,18 @@ static void flow_offload_work_handler(struct work_struct *work)
 
 static void flow_offload_queue_work(struct flow_offload_work *offload)
 {
-	if (offload->cmd == FLOW_CLS_REPLACE)
+	struct net *net = read_pnet(&offload->flowtable->net);
+
+	if (offload->cmd == FLOW_CLS_REPLACE) {
+		NF_FLOW_TABLE_STAT_INC(net, count_wq_add);
 		queue_work(nf_flow_offload_add_wq, &offload->work);
-	else if (offload->cmd == FLOW_CLS_DESTROY)
+	} else if (offload->cmd == FLOW_CLS_DESTROY) {
+		NF_FLOW_TABLE_STAT_INC(net, count_wq_del);
 		queue_work(nf_flow_offload_del_wq, &offload->work);
-	else
+	} else {
+		NF_FLOW_TABLE_STAT_INC(net, count_wq_stats);
 		queue_work(nf_flow_offload_stats_wq, &offload->work);
+	}
 }
 
 static struct flow_offload_work *
diff --git a/net/netfilter/nf_flow_table_procfs.c b/net/netfilter/nf_flow_table_procfs.c
new file mode 100644
index 0000000000000..159b033a43e60
--- /dev/null
+++ b/net/netfilter/nf_flow_table_procfs.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/kernel.h>
+#include <linux/proc_fs.h>
+#include <net/netfilter/nf_flow_table.h>
+
+static void *nf_flow_table_cpu_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	struct net *net = seq_file_net(seq);
+	int cpu;
+
+	if (*pos == 0)
+		return SEQ_START_TOKEN;
+
+	for (cpu = *pos - 1; cpu < nr_cpu_ids; ++cpu) {
+		if (!cpu_possible(cpu))
+			continue;
+		*pos = cpu + 1;
+		return per_cpu_ptr(net->ft.stat, cpu);
+	}
+
+	return NULL;
+}
+
+static void *nf_flow_table_cpu_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	struct net *net = seq_file_net(seq);
+	int cpu;
+
+	for (cpu = *pos; cpu < nr_cpu_ids; ++cpu) {
+		if (!cpu_possible(cpu))
+			continue;
+		*pos = cpu + 1;
+		return per_cpu_ptr(net->ft.stat, cpu);
+	}
+	(*pos)++;
+	return NULL;
+}
+
+static void nf_flow_table_cpu_seq_stop(struct seq_file *seq, void *v)
+{
+}
+
+static int nf_flow_table_cpu_seq_show(struct seq_file *seq, void *v)
+{
+	const struct nf_flow_table_stat *st = v;
+
+	if (v == SEQ_START_TOKEN) {
+		seq_puts(seq, "wq_add   wq_del   wq_stats\n");
+		return 0;
+	}
+
+	seq_printf(seq, "%8d %8d %8d\n",
+		   st->count_wq_add,
+		   st->count_wq_del,
+		   st->count_wq_stats
+		);
+	return 0;
+}
+
+static const struct seq_operations nf_flow_table_cpu_seq_ops = {
+	.start	= nf_flow_table_cpu_seq_start,
+	.next	= nf_flow_table_cpu_seq_next,
+	.stop	= nf_flow_table_cpu_seq_stop,
+	.show	= nf_flow_table_cpu_seq_show,
+};
+
+int nf_flow_table_init_proc(struct net *net)
+{
+	struct proc_dir_entry *pde;
+
+	pde = proc_create_net("nf_flowtable", 0444, net->proc_net_stat,
+			      &nf_flow_table_cpu_seq_ops,
+			      sizeof(struct seq_net_private));
+	return pde ? 0 : -ENOMEM;
+}
+
+void nf_flow_table_fini_proc(struct net *net)
+{
+	remove_proc_entry("nf_flowtable", net->proc_net_stat);
+}
-- 
2.43.0




