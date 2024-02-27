Return-Path: <stable+bounces-24850-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E261E86968A
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 15:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0296D1C22B44
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC84713F016;
	Tue, 27 Feb 2024 14:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fQ0rxChb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8937A13DBB3;
	Tue, 27 Feb 2024 14:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709043160; cv=none; b=IMpZLtD+5VwB7adihxTdyZlXyx5mRtByh3WOmNqAjBAUylHE0OX9iXCq6TWAMTPvq1TEn87ocF1fnvUyaQkuYKL6eWdOOBHBHmMQvz4tvlnYlRbAzsQcFh8//CWOrxjbpE/Cs+27rwmJkRoKBCDTA2p8HNqSVko3rNzpS1wtODk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709043160; c=relaxed/simple;
	bh=AQF0FO0/ax8LPFjydTHr16hVJelo+Jbas5rFeB0Mt3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JMUKjnwAnCSIH8eHe5MDpeqGMSgViVzvavOh+C3w/gHonJqZoErplS0KC6C4s5+ESbCpcM4wK0MFRtIXiHfg0ZMJew7YO6292Nw0KsRRjSjauVcNHQ11VyduPcNPq2KHwKZNRwtRD8klhJgkIVDTA4n0s86TtT3TKbOnKzfVu8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fQ0rxChb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC414C433F1;
	Tue, 27 Feb 2024 14:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709043160;
	bh=AQF0FO0/ax8LPFjydTHr16hVJelo+Jbas5rFeB0Mt3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fQ0rxChbOkxwSMeddZA8oGfHkuPd0tSbRbp+ehMHYDAeVdgCuZyupS2JNGhUeCsli
	 0udLxlq3XuNAabJL+r0JHQ1W3+FPSuU2T6FAepyTAt3k4tv2TDVdbjlKFUmrgrYOUw
	 zvdlCj2ufIo8gFZXSxuW0TV5mQiDG5+clsNYt55Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.1 002/195] net/sched: Retire ATM qdisc
Date: Tue, 27 Feb 2024 14:24:23 +0100
Message-ID: <20240227131610.477881455@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131610.391465389@linuxfoundation.org>
References: <20240227131610.391465389@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jamal Hadi Salim <jhs@mojatatu.com>

commit fb38306ceb9e770adfb5ffa6e3c64047b55f7a07 upstream.

The ATM qdisc has served us well over the years but has not been getting much
TLC due to lack of known users. Most recently it has become a shooting target
for syzkaller. For this reason, we are retiring it.

Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Acked-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/Kconfig                                           |   14 
 net/sched/Makefile                                          |    1 
 net/sched/sch_atm.c                                         |  706 ------------
 tools/testing/selftests/tc-testing/tc-tests/qdiscs/atm.json |   94 -
 4 files changed, 815 deletions(-)
 delete mode 100644 net/sched/sch_atm.c
 delete mode 100644 tools/testing/selftests/tc-testing/tc-tests/qdiscs/atm.json

--- a/net/sched/Kconfig
+++ b/net/sched/Kconfig
@@ -68,20 +68,6 @@ config NET_SCH_HFSC
 	  To compile this code as a module, choose M here: the
 	  module will be called sch_hfsc.
 
-config NET_SCH_ATM
-	tristate "ATM Virtual Circuits (ATM)"
-	depends on ATM
-	help
-	  Say Y here if you want to use the ATM pseudo-scheduler.  This
-	  provides a framework for invoking classifiers, which in turn
-	  select classes of this queuing discipline.  Each class maps
-	  the flow(s) it is handling to a given virtual circuit.
-
-	  See the top of <file:net/sched/sch_atm.c> for more details.
-
-	  To compile this code as a module, choose M here: the
-	  module will be called sch_atm.
-
 config NET_SCH_PRIO
 	tristate "Multi Band Priority Queueing (PRIO)"
 	help
--- a/net/sched/Makefile
+++ b/net/sched/Makefile
@@ -45,7 +45,6 @@ obj-$(CONFIG_NET_SCH_TBF)	+= sch_tbf.o
 obj-$(CONFIG_NET_SCH_TEQL)	+= sch_teql.o
 obj-$(CONFIG_NET_SCH_PRIO)	+= sch_prio.o
 obj-$(CONFIG_NET_SCH_MULTIQ)	+= sch_multiq.o
-obj-$(CONFIG_NET_SCH_ATM)	+= sch_atm.o
 obj-$(CONFIG_NET_SCH_NETEM)	+= sch_netem.o
 obj-$(CONFIG_NET_SCH_DRR)	+= sch_drr.o
 obj-$(CONFIG_NET_SCH_PLUG)	+= sch_plug.o
--- a/net/sched/sch_atm.c
+++ /dev/null
@@ -1,706 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/* net/sched/sch_atm.c - ATM VC selection "queueing discipline" */
-
-/* Written 1998-2000 by Werner Almesberger, EPFL ICA */
-
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/string.h>
-#include <linux/errno.h>
-#include <linux/skbuff.h>
-#include <linux/atmdev.h>
-#include <linux/atmclip.h>
-#include <linux/rtnetlink.h>
-#include <linux/file.h>		/* for fput */
-#include <net/netlink.h>
-#include <net/pkt_sched.h>
-#include <net/pkt_cls.h>
-
-/*
- * The ATM queuing discipline provides a framework for invoking classifiers
- * (aka "filters"), which in turn select classes of this queuing discipline.
- * Each class maps the flow(s) it is handling to a given VC. Multiple classes
- * may share the same VC.
- *
- * When creating a class, VCs are specified by passing the number of the open
- * socket descriptor by which the calling process references the VC. The kernel
- * keeps the VC open at least until all classes using it are removed.
- *
- * In this file, most functions are named atm_tc_* to avoid confusion with all
- * the atm_* in net/atm. This naming convention differs from what's used in the
- * rest of net/sched.
- *
- * Known bugs:
- *  - sometimes messes up the IP stack
- *  - any manipulations besides the few operations described in the README, are
- *    untested and likely to crash the system
- *  - should lock the flow while there is data in the queue (?)
- */
-
-#define VCC2FLOW(vcc) ((struct atm_flow_data *) ((vcc)->user_back))
-
-struct atm_flow_data {
-	struct Qdisc_class_common common;
-	struct Qdisc		*q;	/* FIFO, TBF, etc. */
-	struct tcf_proto __rcu	*filter_list;
-	struct tcf_block	*block;
-	struct atm_vcc		*vcc;	/* VCC; NULL if VCC is closed */
-	void			(*old_pop)(struct atm_vcc *vcc,
-					   struct sk_buff *skb); /* chaining */
-	struct atm_qdisc_data	*parent;	/* parent qdisc */
-	struct socket		*sock;		/* for closing */
-	int			ref;		/* reference count */
-	struct gnet_stats_basic_sync	bstats;
-	struct gnet_stats_queue	qstats;
-	struct list_head	list;
-	struct atm_flow_data	*excess;	/* flow for excess traffic;
-						   NULL to set CLP instead */
-	int			hdr_len;
-	unsigned char		hdr[];		/* header data; MUST BE LAST */
-};
-
-struct atm_qdisc_data {
-	struct atm_flow_data	link;		/* unclassified skbs go here */
-	struct list_head	flows;		/* NB: "link" is also on this
-						   list */
-	struct tasklet_struct	task;		/* dequeue tasklet */
-};
-
-/* ------------------------- Class/flow operations ------------------------- */
-
-static inline struct atm_flow_data *lookup_flow(struct Qdisc *sch, u32 classid)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-	struct atm_flow_data *flow;
-
-	list_for_each_entry(flow, &p->flows, list) {
-		if (flow->common.classid == classid)
-			return flow;
-	}
-	return NULL;
-}
-
-static int atm_tc_graft(struct Qdisc *sch, unsigned long arg,
-			struct Qdisc *new, struct Qdisc **old,
-			struct netlink_ext_ack *extack)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-	struct atm_flow_data *flow = (struct atm_flow_data *)arg;
-
-	pr_debug("atm_tc_graft(sch %p,[qdisc %p],flow %p,new %p,old %p)\n",
-		sch, p, flow, new, old);
-	if (list_empty(&flow->list))
-		return -EINVAL;
-	if (!new)
-		new = &noop_qdisc;
-	*old = flow->q;
-	flow->q = new;
-	if (*old)
-		qdisc_reset(*old);
-	return 0;
-}
-
-static struct Qdisc *atm_tc_leaf(struct Qdisc *sch, unsigned long cl)
-{
-	struct atm_flow_data *flow = (struct atm_flow_data *)cl;
-
-	pr_debug("atm_tc_leaf(sch %p,flow %p)\n", sch, flow);
-	return flow ? flow->q : NULL;
-}
-
-static unsigned long atm_tc_find(struct Qdisc *sch, u32 classid)
-{
-	struct atm_qdisc_data *p __maybe_unused = qdisc_priv(sch);
-	struct atm_flow_data *flow;
-
-	pr_debug("%s(sch %p,[qdisc %p],classid %x)\n", __func__, sch, p, classid);
-	flow = lookup_flow(sch, classid);
-	pr_debug("%s: flow %p\n", __func__, flow);
-	return (unsigned long)flow;
-}
-
-static unsigned long atm_tc_bind_filter(struct Qdisc *sch,
-					unsigned long parent, u32 classid)
-{
-	struct atm_qdisc_data *p __maybe_unused = qdisc_priv(sch);
-	struct atm_flow_data *flow;
-
-	pr_debug("%s(sch %p,[qdisc %p],classid %x)\n", __func__, sch, p, classid);
-	flow = lookup_flow(sch, classid);
-	if (flow)
-		flow->ref++;
-	pr_debug("%s: flow %p\n", __func__, flow);
-	return (unsigned long)flow;
-}
-
-/*
- * atm_tc_put handles all destructions, including the ones that are explicitly
- * requested (atm_tc_destroy, etc.). The assumption here is that we never drop
- * anything that still seems to be in use.
- */
-static void atm_tc_put(struct Qdisc *sch, unsigned long cl)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-	struct atm_flow_data *flow = (struct atm_flow_data *)cl;
-
-	pr_debug("atm_tc_put(sch %p,[qdisc %p],flow %p)\n", sch, p, flow);
-	if (--flow->ref)
-		return;
-	pr_debug("atm_tc_put: destroying\n");
-	list_del_init(&flow->list);
-	pr_debug("atm_tc_put: qdisc %p\n", flow->q);
-	qdisc_put(flow->q);
-	tcf_block_put(flow->block);
-	if (flow->sock) {
-		pr_debug("atm_tc_put: f_count %ld\n",
-			file_count(flow->sock->file));
-		flow->vcc->pop = flow->old_pop;
-		sockfd_put(flow->sock);
-	}
-	if (flow->excess)
-		atm_tc_put(sch, (unsigned long)flow->excess);
-	if (flow != &p->link)
-		kfree(flow);
-	/*
-	 * If flow == &p->link, the qdisc no longer works at this point and
-	 * needs to be removed. (By the caller of atm_tc_put.)
-	 */
-}
-
-static void sch_atm_pop(struct atm_vcc *vcc, struct sk_buff *skb)
-{
-	struct atm_qdisc_data *p = VCC2FLOW(vcc)->parent;
-
-	pr_debug("sch_atm_pop(vcc %p,skb %p,[qdisc %p])\n", vcc, skb, p);
-	VCC2FLOW(vcc)->old_pop(vcc, skb);
-	tasklet_schedule(&p->task);
-}
-
-static const u8 llc_oui_ip[] = {
-	0xaa,			/* DSAP: non-ISO */
-	0xaa,			/* SSAP: non-ISO */
-	0x03,			/* Ctrl: Unnumbered Information Command PDU */
-	0x00,			/* OUI: EtherType */
-	0x00, 0x00,
-	0x08, 0x00
-};				/* Ethertype IP (0800) */
-
-static const struct nla_policy atm_policy[TCA_ATM_MAX + 1] = {
-	[TCA_ATM_FD]		= { .type = NLA_U32 },
-	[TCA_ATM_EXCESS]	= { .type = NLA_U32 },
-};
-
-static int atm_tc_change(struct Qdisc *sch, u32 classid, u32 parent,
-			 struct nlattr **tca, unsigned long *arg,
-			 struct netlink_ext_ack *extack)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-	struct atm_flow_data *flow = (struct atm_flow_data *)*arg;
-	struct atm_flow_data *excess = NULL;
-	struct nlattr *opt = tca[TCA_OPTIONS];
-	struct nlattr *tb[TCA_ATM_MAX + 1];
-	struct socket *sock;
-	int fd, error, hdr_len;
-	void *hdr;
-
-	pr_debug("atm_tc_change(sch %p,[qdisc %p],classid %x,parent %x,"
-		"flow %p,opt %p)\n", sch, p, classid, parent, flow, opt);
-	/*
-	 * The concept of parents doesn't apply for this qdisc.
-	 */
-	if (parent && parent != TC_H_ROOT && parent != sch->handle)
-		return -EINVAL;
-	/*
-	 * ATM classes cannot be changed. In order to change properties of the
-	 * ATM connection, that socket needs to be modified directly (via the
-	 * native ATM API. In order to send a flow to a different VC, the old
-	 * class needs to be removed and a new one added. (This may be changed
-	 * later.)
-	 */
-	if (flow)
-		return -EBUSY;
-	if (opt == NULL)
-		return -EINVAL;
-
-	error = nla_parse_nested_deprecated(tb, TCA_ATM_MAX, opt, atm_policy,
-					    NULL);
-	if (error < 0)
-		return error;
-
-	if (!tb[TCA_ATM_FD])
-		return -EINVAL;
-	fd = nla_get_u32(tb[TCA_ATM_FD]);
-	pr_debug("atm_tc_change: fd %d\n", fd);
-	if (tb[TCA_ATM_HDR]) {
-		hdr_len = nla_len(tb[TCA_ATM_HDR]);
-		hdr = nla_data(tb[TCA_ATM_HDR]);
-	} else {
-		hdr_len = RFC1483LLC_LEN;
-		hdr = NULL;	/* default LLC/SNAP for IP */
-	}
-	if (!tb[TCA_ATM_EXCESS])
-		excess = NULL;
-	else {
-		excess = (struct atm_flow_data *)
-			atm_tc_find(sch, nla_get_u32(tb[TCA_ATM_EXCESS]));
-		if (!excess)
-			return -ENOENT;
-	}
-	pr_debug("atm_tc_change: type %d, payload %d, hdr_len %d\n",
-		 opt->nla_type, nla_len(opt), hdr_len);
-	sock = sockfd_lookup(fd, &error);
-	if (!sock)
-		return error;	/* f_count++ */
-	pr_debug("atm_tc_change: f_count %ld\n", file_count(sock->file));
-	if (sock->ops->family != PF_ATMSVC && sock->ops->family != PF_ATMPVC) {
-		error = -EPROTOTYPE;
-		goto err_out;
-	}
-	/* @@@ should check if the socket is really operational or we'll crash
-	   on vcc->send */
-	if (classid) {
-		if (TC_H_MAJ(classid ^ sch->handle)) {
-			pr_debug("atm_tc_change: classid mismatch\n");
-			error = -EINVAL;
-			goto err_out;
-		}
-	} else {
-		int i;
-		unsigned long cl;
-
-		for (i = 1; i < 0x8000; i++) {
-			classid = TC_H_MAKE(sch->handle, 0x8000 | i);
-			cl = atm_tc_find(sch, classid);
-			if (!cl)
-				break;
-		}
-	}
-	pr_debug("atm_tc_change: new id %x\n", classid);
-	flow = kzalloc(sizeof(struct atm_flow_data) + hdr_len, GFP_KERNEL);
-	pr_debug("atm_tc_change: flow %p\n", flow);
-	if (!flow) {
-		error = -ENOBUFS;
-		goto err_out;
-	}
-
-	error = tcf_block_get(&flow->block, &flow->filter_list, sch,
-			      extack);
-	if (error) {
-		kfree(flow);
-		goto err_out;
-	}
-
-	flow->q = qdisc_create_dflt(sch->dev_queue, &pfifo_qdisc_ops, classid,
-				    extack);
-	if (!flow->q)
-		flow->q = &noop_qdisc;
-	pr_debug("atm_tc_change: qdisc %p\n", flow->q);
-	flow->sock = sock;
-	flow->vcc = ATM_SD(sock);	/* speedup */
-	flow->vcc->user_back = flow;
-	pr_debug("atm_tc_change: vcc %p\n", flow->vcc);
-	flow->old_pop = flow->vcc->pop;
-	flow->parent = p;
-	flow->vcc->pop = sch_atm_pop;
-	flow->common.classid = classid;
-	flow->ref = 1;
-	flow->excess = excess;
-	list_add(&flow->list, &p->link.list);
-	flow->hdr_len = hdr_len;
-	if (hdr)
-		memcpy(flow->hdr, hdr, hdr_len);
-	else
-		memcpy(flow->hdr, llc_oui_ip, sizeof(llc_oui_ip));
-	*arg = (unsigned long)flow;
-	return 0;
-err_out:
-	sockfd_put(sock);
-	return error;
-}
-
-static int atm_tc_delete(struct Qdisc *sch, unsigned long arg,
-			 struct netlink_ext_ack *extack)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-	struct atm_flow_data *flow = (struct atm_flow_data *)arg;
-
-	pr_debug("atm_tc_delete(sch %p,[qdisc %p],flow %p)\n", sch, p, flow);
-	if (list_empty(&flow->list))
-		return -EINVAL;
-	if (rcu_access_pointer(flow->filter_list) || flow == &p->link)
-		return -EBUSY;
-	/*
-	 * Reference count must be 2: one for "keepalive" (set at class
-	 * creation), and one for the reference held when calling delete.
-	 */
-	if (flow->ref < 2) {
-		pr_err("atm_tc_delete: flow->ref == %d\n", flow->ref);
-		return -EINVAL;
-	}
-	if (flow->ref > 2)
-		return -EBUSY;	/* catch references via excess, etc. */
-	atm_tc_put(sch, arg);
-	return 0;
-}
-
-static void atm_tc_walk(struct Qdisc *sch, struct qdisc_walker *walker)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-	struct atm_flow_data *flow;
-
-	pr_debug("atm_tc_walk(sch %p,[qdisc %p],walker %p)\n", sch, p, walker);
-	if (walker->stop)
-		return;
-	list_for_each_entry(flow, &p->flows, list) {
-		if (!tc_qdisc_stats_dump(sch, (unsigned long)flow, walker))
-			break;
-	}
-}
-
-static struct tcf_block *atm_tc_tcf_block(struct Qdisc *sch, unsigned long cl,
-					  struct netlink_ext_ack *extack)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-	struct atm_flow_data *flow = (struct atm_flow_data *)cl;
-
-	pr_debug("atm_tc_find_tcf(sch %p,[qdisc %p],flow %p)\n", sch, p, flow);
-	return flow ? flow->block : p->link.block;
-}
-
-/* --------------------------- Qdisc operations ---------------------------- */
-
-static int atm_tc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
-			  struct sk_buff **to_free)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-	struct atm_flow_data *flow;
-	struct tcf_result res;
-	int result;
-	int ret = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
-
-	pr_debug("atm_tc_enqueue(skb %p,sch %p,[qdisc %p])\n", skb, sch, p);
-	result = TC_ACT_OK;	/* be nice to gcc */
-	flow = NULL;
-	if (TC_H_MAJ(skb->priority) != sch->handle ||
-	    !(flow = (struct atm_flow_data *)atm_tc_find(sch, skb->priority))) {
-		struct tcf_proto *fl;
-
-		list_for_each_entry(flow, &p->flows, list) {
-			fl = rcu_dereference_bh(flow->filter_list);
-			if (fl) {
-				result = tcf_classify(skb, NULL, fl, &res, true);
-				if (result < 0)
-					continue;
-				if (result == TC_ACT_SHOT)
-					goto done;
-
-				flow = (struct atm_flow_data *)res.class;
-				if (!flow)
-					flow = lookup_flow(sch, res.classid);
-				goto drop;
-			}
-		}
-		flow = NULL;
-done:
-		;
-	}
-	if (!flow) {
-		flow = &p->link;
-	} else {
-		if (flow->vcc)
-			ATM_SKB(skb)->atm_options = flow->vcc->atm_options;
-		/*@@@ looks good ... but it's not supposed to work :-) */
-#ifdef CONFIG_NET_CLS_ACT
-		switch (result) {
-		case TC_ACT_QUEUED:
-		case TC_ACT_STOLEN:
-		case TC_ACT_TRAP:
-			__qdisc_drop(skb, to_free);
-			return NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
-		case TC_ACT_SHOT:
-			__qdisc_drop(skb, to_free);
-			goto drop;
-		case TC_ACT_RECLASSIFY:
-			if (flow->excess)
-				flow = flow->excess;
-			else
-				ATM_SKB(skb)->atm_options |= ATM_ATMOPT_CLP;
-			break;
-		}
-#endif
-	}
-
-	ret = qdisc_enqueue(skb, flow->q, to_free);
-	if (ret != NET_XMIT_SUCCESS) {
-drop: __maybe_unused
-		if (net_xmit_drop_count(ret)) {
-			qdisc_qstats_drop(sch);
-			if (flow)
-				flow->qstats.drops++;
-		}
-		return ret;
-	}
-	/*
-	 * Okay, this may seem weird. We pretend we've dropped the packet if
-	 * it goes via ATM. The reason for this is that the outer qdisc
-	 * expects to be able to q->dequeue the packet later on if we return
-	 * success at this place. Also, sch->q.qdisc needs to reflect whether
-	 * there is a packet egligible for dequeuing or not. Note that the
-	 * statistics of the outer qdisc are necessarily wrong because of all
-	 * this. There's currently no correct solution for this.
-	 */
-	if (flow == &p->link) {
-		sch->q.qlen++;
-		return NET_XMIT_SUCCESS;
-	}
-	tasklet_schedule(&p->task);
-	return NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
-}
-
-/*
- * Dequeue packets and send them over ATM. Note that we quite deliberately
- * avoid checking net_device's flow control here, simply because sch_atm
- * uses its own channels, which have nothing to do with any CLIP/LANE/or
- * non-ATM interfaces.
- */
-
-static void sch_atm_dequeue(struct tasklet_struct *t)
-{
-	struct atm_qdisc_data *p = from_tasklet(p, t, task);
-	struct Qdisc *sch = qdisc_from_priv(p);
-	struct atm_flow_data *flow;
-	struct sk_buff *skb;
-
-	pr_debug("sch_atm_dequeue(sch %p,[qdisc %p])\n", sch, p);
-	list_for_each_entry(flow, &p->flows, list) {
-		if (flow == &p->link)
-			continue;
-		/*
-		 * If traffic is properly shaped, this won't generate nasty
-		 * little bursts. Otherwise, it may ... (but that's okay)
-		 */
-		while ((skb = flow->q->ops->peek(flow->q))) {
-			if (!atm_may_send(flow->vcc, skb->truesize))
-				break;
-
-			skb = qdisc_dequeue_peeked(flow->q);
-			if (unlikely(!skb))
-				break;
-
-			qdisc_bstats_update(sch, skb);
-			bstats_update(&flow->bstats, skb);
-			pr_debug("atm_tc_dequeue: sending on class %p\n", flow);
-			/* remove any LL header somebody else has attached */
-			skb_pull(skb, skb_network_offset(skb));
-			if (skb_headroom(skb) < flow->hdr_len) {
-				struct sk_buff *new;
-
-				new = skb_realloc_headroom(skb, flow->hdr_len);
-				dev_kfree_skb(skb);
-				if (!new)
-					continue;
-				skb = new;
-			}
-			pr_debug("sch_atm_dequeue: ip %p, data %p\n",
-				 skb_network_header(skb), skb->data);
-			ATM_SKB(skb)->vcc = flow->vcc;
-			memcpy(skb_push(skb, flow->hdr_len), flow->hdr,
-			       flow->hdr_len);
-			refcount_add(skb->truesize,
-				   &sk_atm(flow->vcc)->sk_wmem_alloc);
-			/* atm.atm_options are already set by atm_tc_enqueue */
-			flow->vcc->send(flow->vcc, skb);
-		}
-	}
-}
-
-static struct sk_buff *atm_tc_dequeue(struct Qdisc *sch)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-	struct sk_buff *skb;
-
-	pr_debug("atm_tc_dequeue(sch %p,[qdisc %p])\n", sch, p);
-	tasklet_schedule(&p->task);
-	skb = qdisc_dequeue_peeked(p->link.q);
-	if (skb)
-		sch->q.qlen--;
-	return skb;
-}
-
-static struct sk_buff *atm_tc_peek(struct Qdisc *sch)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-
-	pr_debug("atm_tc_peek(sch %p,[qdisc %p])\n", sch, p);
-
-	return p->link.q->ops->peek(p->link.q);
-}
-
-static int atm_tc_init(struct Qdisc *sch, struct nlattr *opt,
-		       struct netlink_ext_ack *extack)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-	int err;
-
-	pr_debug("atm_tc_init(sch %p,[qdisc %p],opt %p)\n", sch, p, opt);
-	INIT_LIST_HEAD(&p->flows);
-	INIT_LIST_HEAD(&p->link.list);
-	gnet_stats_basic_sync_init(&p->link.bstats);
-	list_add(&p->link.list, &p->flows);
-	p->link.q = qdisc_create_dflt(sch->dev_queue,
-				      &pfifo_qdisc_ops, sch->handle, extack);
-	if (!p->link.q)
-		p->link.q = &noop_qdisc;
-	pr_debug("atm_tc_init: link (%p) qdisc %p\n", &p->link, p->link.q);
-	p->link.vcc = NULL;
-	p->link.sock = NULL;
-	p->link.common.classid = sch->handle;
-	p->link.ref = 1;
-
-	err = tcf_block_get(&p->link.block, &p->link.filter_list, sch,
-			    extack);
-	if (err)
-		return err;
-
-	tasklet_setup(&p->task, sch_atm_dequeue);
-	return 0;
-}
-
-static void atm_tc_reset(struct Qdisc *sch)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-	struct atm_flow_data *flow;
-
-	pr_debug("atm_tc_reset(sch %p,[qdisc %p])\n", sch, p);
-	list_for_each_entry(flow, &p->flows, list)
-		qdisc_reset(flow->q);
-}
-
-static void atm_tc_destroy(struct Qdisc *sch)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-	struct atm_flow_data *flow, *tmp;
-
-	pr_debug("atm_tc_destroy(sch %p,[qdisc %p])\n", sch, p);
-	list_for_each_entry(flow, &p->flows, list) {
-		tcf_block_put(flow->block);
-		flow->block = NULL;
-	}
-
-	list_for_each_entry_safe(flow, tmp, &p->flows, list) {
-		if (flow->ref > 1)
-			pr_err("atm_destroy: %p->ref = %d\n", flow, flow->ref);
-		atm_tc_put(sch, (unsigned long)flow);
-	}
-	tasklet_kill(&p->task);
-}
-
-static int atm_tc_dump_class(struct Qdisc *sch, unsigned long cl,
-			     struct sk_buff *skb, struct tcmsg *tcm)
-{
-	struct atm_qdisc_data *p = qdisc_priv(sch);
-	struct atm_flow_data *flow = (struct atm_flow_data *)cl;
-	struct nlattr *nest;
-
-	pr_debug("atm_tc_dump_class(sch %p,[qdisc %p],flow %p,skb %p,tcm %p)\n",
-		sch, p, flow, skb, tcm);
-	if (list_empty(&flow->list))
-		return -EINVAL;
-	tcm->tcm_handle = flow->common.classid;
-	tcm->tcm_info = flow->q->handle;
-
-	nest = nla_nest_start_noflag(skb, TCA_OPTIONS);
-	if (nest == NULL)
-		goto nla_put_failure;
-
-	if (nla_put(skb, TCA_ATM_HDR, flow->hdr_len, flow->hdr))
-		goto nla_put_failure;
-	if (flow->vcc) {
-		struct sockaddr_atmpvc pvc;
-		int state;
-
-		memset(&pvc, 0, sizeof(pvc));
-		pvc.sap_family = AF_ATMPVC;
-		pvc.sap_addr.itf = flow->vcc->dev ? flow->vcc->dev->number : -1;
-		pvc.sap_addr.vpi = flow->vcc->vpi;
-		pvc.sap_addr.vci = flow->vcc->vci;
-		if (nla_put(skb, TCA_ATM_ADDR, sizeof(pvc), &pvc))
-			goto nla_put_failure;
-		state = ATM_VF2VS(flow->vcc->flags);
-		if (nla_put_u32(skb, TCA_ATM_STATE, state))
-			goto nla_put_failure;
-	}
-	if (flow->excess) {
-		if (nla_put_u32(skb, TCA_ATM_EXCESS, flow->common.classid))
-			goto nla_put_failure;
-	} else {
-		if (nla_put_u32(skb, TCA_ATM_EXCESS, 0))
-			goto nla_put_failure;
-	}
-	return nla_nest_end(skb, nest);
-
-nla_put_failure:
-	nla_nest_cancel(skb, nest);
-	return -1;
-}
-static int
-atm_tc_dump_class_stats(struct Qdisc *sch, unsigned long arg,
-			struct gnet_dump *d)
-{
-	struct atm_flow_data *flow = (struct atm_flow_data *)arg;
-
-	if (gnet_stats_copy_basic(d, NULL, &flow->bstats, true) < 0 ||
-	    gnet_stats_copy_queue(d, NULL, &flow->qstats, flow->q->q.qlen) < 0)
-		return -1;
-
-	return 0;
-}
-
-static int atm_tc_dump(struct Qdisc *sch, struct sk_buff *skb)
-{
-	return 0;
-}
-
-static const struct Qdisc_class_ops atm_class_ops = {
-	.graft		= atm_tc_graft,
-	.leaf		= atm_tc_leaf,
-	.find		= atm_tc_find,
-	.change		= atm_tc_change,
-	.delete		= atm_tc_delete,
-	.walk		= atm_tc_walk,
-	.tcf_block	= atm_tc_tcf_block,
-	.bind_tcf	= atm_tc_bind_filter,
-	.unbind_tcf	= atm_tc_put,
-	.dump		= atm_tc_dump_class,
-	.dump_stats	= atm_tc_dump_class_stats,
-};
-
-static struct Qdisc_ops atm_qdisc_ops __read_mostly = {
-	.cl_ops		= &atm_class_ops,
-	.id		= "atm",
-	.priv_size	= sizeof(struct atm_qdisc_data),
-	.enqueue	= atm_tc_enqueue,
-	.dequeue	= atm_tc_dequeue,
-	.peek		= atm_tc_peek,
-	.init		= atm_tc_init,
-	.reset		= atm_tc_reset,
-	.destroy	= atm_tc_destroy,
-	.dump		= atm_tc_dump,
-	.owner		= THIS_MODULE,
-};
-
-static int __init atm_init(void)
-{
-	return register_qdisc(&atm_qdisc_ops);
-}
-
-static void __exit atm_exit(void)
-{
-	unregister_qdisc(&atm_qdisc_ops);
-}
-
-module_init(atm_init)
-module_exit(atm_exit)
-MODULE_LICENSE("GPL");
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/atm.json
+++ /dev/null
@@ -1,94 +0,0 @@
-[
-    {
-        "id": "7628",
-        "name": "Create ATM with default setting",
-        "category": [
-            "qdisc",
-            "atm"
-        ],
-        "plugins": {
-            "requires": "nsPlugin"
-        },
-        "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
-        ],
-        "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root atm",
-        "expExitCode": "0",
-        "verifyCmd": "$TC qdisc show dev $DUMMY",
-        "matchPattern": "qdisc atm 1: root refcnt",
-        "matchCount": "1",
-        "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
-        ]
-    },
-    {
-        "id": "390a",
-        "name": "Delete ATM with valid handle",
-        "category": [
-            "qdisc",
-            "atm"
-        ],
-        "plugins": {
-            "requires": "nsPlugin"
-        },
-        "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true",
-            "$TC qdisc add dev $DUMMY handle 1: root atm"
-        ],
-        "cmdUnderTest": "$TC qdisc del dev $DUMMY handle 1: root",
-        "expExitCode": "0",
-        "verifyCmd": "$TC qdisc show dev $DUMMY",
-        "matchPattern": "qdisc atm 1: root refcnt",
-        "matchCount": "0",
-        "teardown": [
-            "$IP link del dev $DUMMY type dummy"
-        ]
-    },
-    {
-        "id": "32a0",
-        "name": "Show ATM class",
-        "category": [
-            "qdisc",
-            "atm"
-        ],
-        "plugins": {
-            "requires": "nsPlugin"
-        },
-        "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
-        ],
-        "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root atm",
-        "expExitCode": "0",
-        "verifyCmd": "$TC class show dev $DUMMY",
-        "matchPattern": "class atm 1: parent 1:",
-        "matchCount": "1",
-        "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
-        ]
-    },
-    {
-        "id": "6310",
-        "name": "Dump ATM stats",
-        "category": [
-            "qdisc",
-            "atm"
-        ],
-        "plugins": {
-            "requires": "nsPlugin"
-        },
-        "setup": [
-            "$IP link add dev $DUMMY type dummy || /bin/true"
-        ],
-        "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root atm",
-        "expExitCode": "0",
-        "verifyCmd": "$TC -s qdisc show dev $DUMMY",
-        "matchPattern": "qdisc atm 1: root refcnt",
-        "matchCount": "1",
-        "teardown": [
-            "$TC qdisc del dev $DUMMY handle 1: root",
-            "$IP link del dev $DUMMY type dummy"
-        ]
-    }
-]



