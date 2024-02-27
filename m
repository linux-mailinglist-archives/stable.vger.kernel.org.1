Return-Path: <stable+bounces-24270-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B58869394
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E256D290635
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0DE13DBA5;
	Tue, 27 Feb 2024 13:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PC5iK6Y2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AED013DB87;
	Tue, 27 Feb 2024 13:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041512; cv=none; b=oOyq1t9V25f+4FSRoOjKiXMxVEPz1KT9NpwVGz1/zy3M+7+0H7hco02q+9auPnP5wmIlBZMRQePXGobkyFFE4SEJdaZ7oQHuKhIwpGdWHadYZWBnC9/QrWvShGRJ5lE25CLdNPC+l4rD7V626M0wywzp5Aoq5LU1DRIpcz02KAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041512; c=relaxed/simple;
	bh=YoonuYU2mgcgK1BLZmcXRTB88tMc+jUmKch27zP0XQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u1E8MAdHrxkxohwDQca8AYNq0Nh50BpBXdgCmsmHR7oZk86xHslWHtBrvv1T0HPWz4jWRInQS7TTnR4Gn7NOr9QMkFOIoepA/52ExnuMCoJYNKsNoVquwIHXMVcXotkdg8Cf+PwzfriAIQH7zlxSVnyhHHJCoCwaYxFvavedCkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PC5iK6Y2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE44C43394;
	Tue, 27 Feb 2024 13:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709041512;
	bh=YoonuYU2mgcgK1BLZmcXRTB88tMc+jUmKch27zP0XQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PC5iK6Y2To5/P78aO8KWkJmyLymGj9OH8vcvJxofKHWgz+Wh8QMKElV7ZBva1vrsb
	 7FPAYAhNNHnKBRCrqp+c7ryWpN/l/5h+rQdrhQ1ThZELdam3QXg1+jjVLXTER5umym
	 D95tOPlXa+vHzjBcyHrkx1QVuFB8R4/vMwJe/srk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 4.19 03/52] net/sched: Retire dsmark qdisc
Date: Tue, 27 Feb 2024 14:25:50 +0100
Message-ID: <20240227131548.633900429@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131548.514622258@linuxfoundation.org>
References: <20240227131548.514622258@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jamal Hadi Salim <jhs@mojatatu.com>

commit bbe77c14ee6185a61ba6d5e435c1cbb489d2a9ed upstream.

The dsmark qdisc has served us well over the years for diffserv but has not
been getting much attention due to other more popular approaches to do diffserv
services. Most recently it has become a shooting target for syzkaller. For this
reason, we are retiring it.

Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Acked-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/Kconfig      |   11 -
 net/sched/Makefile     |    1 
 net/sched/sch_dsmark.c |  519 -------------------------------------------------
 3 files changed, 531 deletions(-)
 delete mode 100644 net/sched/sch_dsmark.c
 delete mode 100644 tools/testing/selftests/tc-testing/tc-tests/qdiscs/dsmark.json

--- a/net/sched/Kconfig
+++ b/net/sched/Kconfig
@@ -174,17 +174,6 @@ config NET_SCH_GRED
 	  To compile this code as a module, choose M here: the
 	  module will be called sch_gred.
 
-config NET_SCH_DSMARK
-	tristate "Differentiated Services marker (DSMARK)"
-	---help---
-	  Say Y if you want to schedule packets according to the
-	  Differentiated Services architecture proposed in RFC 2475.
-	  Technical information on this method, with pointers to associated
-	  RFCs, is available at <http://www.gta.ufrj.br/diffserv/>.
-
-	  To compile this code as a module, choose M here: the
-	  module will be called sch_dsmark.
-
 config NET_SCH_NETEM
 	tristate "Network emulator (NETEM)"
 	---help---
--- a/net/sched/Makefile
+++ b/net/sched/Makefile
@@ -33,7 +33,6 @@ obj-$(CONFIG_NET_SCH_HFSC)	+= sch_hfsc.o
 obj-$(CONFIG_NET_SCH_RED)	+= sch_red.o
 obj-$(CONFIG_NET_SCH_GRED)	+= sch_gred.o
 obj-$(CONFIG_NET_SCH_INGRESS)	+= sch_ingress.o
-obj-$(CONFIG_NET_SCH_DSMARK)	+= sch_dsmark.o
 obj-$(CONFIG_NET_SCH_SFB)	+= sch_sfb.o
 obj-$(CONFIG_NET_SCH_SFQ)	+= sch_sfq.o
 obj-$(CONFIG_NET_SCH_TBF)	+= sch_tbf.o
--- a/net/sched/sch_dsmark.c
+++ /dev/null
@@ -1,519 +0,0 @@
-/* net/sched/sch_dsmark.c - Differentiated Services field marker */
-
-/* Written 1998-2000 by Werner Almesberger, EPFL ICA */
-
-
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/slab.h>
-#include <linux/types.h>
-#include <linux/string.h>
-#include <linux/errno.h>
-#include <linux/skbuff.h>
-#include <linux/rtnetlink.h>
-#include <linux/bitops.h>
-#include <net/pkt_sched.h>
-#include <net/pkt_cls.h>
-#include <net/dsfield.h>
-#include <net/inet_ecn.h>
-#include <asm/byteorder.h>
-
-/*
- * classid	class		marking
- * -------	-----		-------
- *   n/a	  0		n/a
- *   x:0	  1		use entry [0]
- *   ...	 ...		...
- *   x:y y>0	 y+1		use entry [y]
- *   ...	 ...		...
- * x:indices-1	indices		use entry [indices-1]
- *   ...	 ...		...
- *   x:y	 y+1		use entry [y & (indices-1)]
- *   ...	 ...		...
- * 0xffff	0x10000		use entry [indices-1]
- */
-
-
-#define NO_DEFAULT_INDEX	(1 << 16)
-
-struct mask_value {
-	u8			mask;
-	u8			value;
-};
-
-struct dsmark_qdisc_data {
-	struct Qdisc		*q;
-	struct tcf_proto __rcu	*filter_list;
-	struct tcf_block	*block;
-	struct mask_value	*mv;
-	u16			indices;
-	u8			set_tc_index;
-	u32			default_index;	/* index range is 0...0xffff */
-#define DSMARK_EMBEDDED_SZ	16
-	struct mask_value	embedded[DSMARK_EMBEDDED_SZ];
-};
-
-static inline int dsmark_valid_index(struct dsmark_qdisc_data *p, u16 index)
-{
-	return index <= p->indices && index > 0;
-}
-
-/* ------------------------- Class/flow operations ------------------------- */
-
-static int dsmark_graft(struct Qdisc *sch, unsigned long arg,
-			struct Qdisc *new, struct Qdisc **old,
-			struct netlink_ext_ack *extack)
-{
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-
-	pr_debug("%s(sch %p,[qdisc %p],new %p,old %p)\n",
-		 __func__, sch, p, new, old);
-
-	if (new == NULL) {
-		new = qdisc_create_dflt(sch->dev_queue, &pfifo_qdisc_ops,
-					sch->handle, NULL);
-		if (new == NULL)
-			new = &noop_qdisc;
-	}
-
-	*old = qdisc_replace(sch, new, &p->q);
-	return 0;
-}
-
-static struct Qdisc *dsmark_leaf(struct Qdisc *sch, unsigned long arg)
-{
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-	return p->q;
-}
-
-static unsigned long dsmark_find(struct Qdisc *sch, u32 classid)
-{
-	return TC_H_MIN(classid) + 1;
-}
-
-static unsigned long dsmark_bind_filter(struct Qdisc *sch,
-					unsigned long parent, u32 classid)
-{
-	pr_debug("%s(sch %p,[qdisc %p],classid %x)\n",
-		 __func__, sch, qdisc_priv(sch), classid);
-
-	return dsmark_find(sch, classid);
-}
-
-static void dsmark_unbind_filter(struct Qdisc *sch, unsigned long cl)
-{
-}
-
-static const struct nla_policy dsmark_policy[TCA_DSMARK_MAX + 1] = {
-	[TCA_DSMARK_INDICES]		= { .type = NLA_U16 },
-	[TCA_DSMARK_DEFAULT_INDEX]	= { .type = NLA_U16 },
-	[TCA_DSMARK_SET_TC_INDEX]	= { .type = NLA_FLAG },
-	[TCA_DSMARK_MASK]		= { .type = NLA_U8 },
-	[TCA_DSMARK_VALUE]		= { .type = NLA_U8 },
-};
-
-static int dsmark_change(struct Qdisc *sch, u32 classid, u32 parent,
-			 struct nlattr **tca, unsigned long *arg,
-			 struct netlink_ext_ack *extack)
-{
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-	struct nlattr *opt = tca[TCA_OPTIONS];
-	struct nlattr *tb[TCA_DSMARK_MAX + 1];
-	int err = -EINVAL;
-
-	pr_debug("%s(sch %p,[qdisc %p],classid %x,parent %x), arg 0x%lx\n",
-		 __func__, sch, p, classid, parent, *arg);
-
-	if (!dsmark_valid_index(p, *arg)) {
-		err = -ENOENT;
-		goto errout;
-	}
-
-	if (!opt)
-		goto errout;
-
-	err = nla_parse_nested(tb, TCA_DSMARK_MAX, opt, dsmark_policy, NULL);
-	if (err < 0)
-		goto errout;
-
-	if (tb[TCA_DSMARK_VALUE])
-		p->mv[*arg - 1].value = nla_get_u8(tb[TCA_DSMARK_VALUE]);
-
-	if (tb[TCA_DSMARK_MASK])
-		p->mv[*arg - 1].mask = nla_get_u8(tb[TCA_DSMARK_MASK]);
-
-	err = 0;
-
-errout:
-	return err;
-}
-
-static int dsmark_delete(struct Qdisc *sch, unsigned long arg)
-{
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-
-	if (!dsmark_valid_index(p, arg))
-		return -EINVAL;
-
-	p->mv[arg - 1].mask = 0xff;
-	p->mv[arg - 1].value = 0;
-
-	return 0;
-}
-
-static void dsmark_walk(struct Qdisc *sch, struct qdisc_walker *walker)
-{
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-	int i;
-
-	pr_debug("%s(sch %p,[qdisc %p],walker %p)\n",
-		 __func__, sch, p, walker);
-
-	if (walker->stop)
-		return;
-
-	for (i = 0; i < p->indices; i++) {
-		if (p->mv[i].mask == 0xff && !p->mv[i].value)
-			goto ignore;
-		if (walker->count >= walker->skip) {
-			if (walker->fn(sch, i + 1, walker) < 0) {
-				walker->stop = 1;
-				break;
-			}
-		}
-ignore:
-		walker->count++;
-	}
-}
-
-static struct tcf_block *dsmark_tcf_block(struct Qdisc *sch, unsigned long cl,
-					  struct netlink_ext_ack *extack)
-{
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-
-	return p->block;
-}
-
-/* --------------------------- Qdisc operations ---------------------------- */
-
-static int dsmark_enqueue(struct sk_buff *skb, struct Qdisc *sch,
-			  struct sk_buff **to_free)
-{
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-	int err;
-
-	pr_debug("%s(skb %p,sch %p,[qdisc %p])\n", __func__, skb, sch, p);
-
-	if (p->set_tc_index) {
-		int wlen = skb_network_offset(skb);
-
-		switch (skb_protocol(skb, true)) {
-		case htons(ETH_P_IP):
-			wlen += sizeof(struct iphdr);
-			if (!pskb_may_pull(skb, wlen) ||
-			    skb_try_make_writable(skb, wlen))
-				goto drop;
-
-			skb->tc_index = ipv4_get_dsfield(ip_hdr(skb))
-				& ~INET_ECN_MASK;
-			break;
-
-		case htons(ETH_P_IPV6):
-			wlen += sizeof(struct ipv6hdr);
-			if (!pskb_may_pull(skb, wlen) ||
-			    skb_try_make_writable(skb, wlen))
-				goto drop;
-
-			skb->tc_index = ipv6_get_dsfield(ipv6_hdr(skb))
-				& ~INET_ECN_MASK;
-			break;
-		default:
-			skb->tc_index = 0;
-			break;
-		}
-	}
-
-	if (TC_H_MAJ(skb->priority) == sch->handle)
-		skb->tc_index = TC_H_MIN(skb->priority);
-	else {
-		struct tcf_result res;
-		struct tcf_proto *fl = rcu_dereference_bh(p->filter_list);
-		int result = tcf_classify(skb, fl, &res, false);
-
-		pr_debug("result %d class 0x%04x\n", result, res.classid);
-
-		switch (result) {
-#ifdef CONFIG_NET_CLS_ACT
-		case TC_ACT_QUEUED:
-		case TC_ACT_STOLEN:
-		case TC_ACT_TRAP:
-			__qdisc_drop(skb, to_free);
-			return NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
-
-		case TC_ACT_SHOT:
-			goto drop;
-#endif
-		case TC_ACT_OK:
-			skb->tc_index = TC_H_MIN(res.classid);
-			break;
-
-		default:
-			if (p->default_index != NO_DEFAULT_INDEX)
-				skb->tc_index = p->default_index;
-			break;
-		}
-	}
-
-	err = qdisc_enqueue(skb, p->q, to_free);
-	if (err != NET_XMIT_SUCCESS) {
-		if (net_xmit_drop_count(err))
-			qdisc_qstats_drop(sch);
-		return err;
-	}
-
-	qdisc_qstats_backlog_inc(sch, skb);
-	sch->q.qlen++;
-
-	return NET_XMIT_SUCCESS;
-
-drop:
-	qdisc_drop(skb, sch, to_free);
-	return NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
-}
-
-static struct sk_buff *dsmark_dequeue(struct Qdisc *sch)
-{
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-	struct sk_buff *skb;
-	u32 index;
-
-	pr_debug("%s(sch %p,[qdisc %p])\n", __func__, sch, p);
-
-	skb = qdisc_dequeue_peeked(p->q);
-	if (skb == NULL)
-		return NULL;
-
-	qdisc_bstats_update(sch, skb);
-	qdisc_qstats_backlog_dec(sch, skb);
-	sch->q.qlen--;
-
-	index = skb->tc_index & (p->indices - 1);
-	pr_debug("index %d->%d\n", skb->tc_index, index);
-
-	switch (skb_protocol(skb, true)) {
-	case htons(ETH_P_IP):
-		ipv4_change_dsfield(ip_hdr(skb), p->mv[index].mask,
-				    p->mv[index].value);
-			break;
-	case htons(ETH_P_IPV6):
-		ipv6_change_dsfield(ipv6_hdr(skb), p->mv[index].mask,
-				    p->mv[index].value);
-			break;
-	default:
-		/*
-		 * Only complain if a change was actually attempted.
-		 * This way, we can send non-IP traffic through dsmark
-		 * and don't need yet another qdisc as a bypass.
-		 */
-		if (p->mv[index].mask != 0xff || p->mv[index].value)
-			pr_warn("%s: unsupported protocol %d\n",
-				__func__, ntohs(skb_protocol(skb, true)));
-		break;
-	}
-
-	return skb;
-}
-
-static struct sk_buff *dsmark_peek(struct Qdisc *sch)
-{
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-
-	pr_debug("%s(sch %p,[qdisc %p])\n", __func__, sch, p);
-
-	return p->q->ops->peek(p->q);
-}
-
-static int dsmark_init(struct Qdisc *sch, struct nlattr *opt,
-		       struct netlink_ext_ack *extack)
-{
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-	struct nlattr *tb[TCA_DSMARK_MAX + 1];
-	int err = -EINVAL;
-	u32 default_index = NO_DEFAULT_INDEX;
-	u16 indices;
-	int i;
-
-	pr_debug("%s(sch %p,[qdisc %p],opt %p)\n", __func__, sch, p, opt);
-
-	if (!opt)
-		goto errout;
-
-	err = tcf_block_get(&p->block, &p->filter_list, sch, extack);
-	if (err)
-		return err;
-
-	err = nla_parse_nested(tb, TCA_DSMARK_MAX, opt, dsmark_policy, NULL);
-	if (err < 0)
-		goto errout;
-
-	err = -EINVAL;
-	if (!tb[TCA_DSMARK_INDICES])
-		goto errout;
-	indices = nla_get_u16(tb[TCA_DSMARK_INDICES]);
-
-	if (hweight32(indices) != 1)
-		goto errout;
-
-	if (tb[TCA_DSMARK_DEFAULT_INDEX])
-		default_index = nla_get_u16(tb[TCA_DSMARK_DEFAULT_INDEX]);
-
-	if (indices <= DSMARK_EMBEDDED_SZ)
-		p->mv = p->embedded;
-	else
-		p->mv = kmalloc_array(indices, sizeof(*p->mv), GFP_KERNEL);
-	if (!p->mv) {
-		err = -ENOMEM;
-		goto errout;
-	}
-	for (i = 0; i < indices; i++) {
-		p->mv[i].mask = 0xff;
-		p->mv[i].value = 0;
-	}
-	p->indices = indices;
-	p->default_index = default_index;
-	p->set_tc_index = nla_get_flag(tb[TCA_DSMARK_SET_TC_INDEX]);
-
-	p->q = qdisc_create_dflt(sch->dev_queue, &pfifo_qdisc_ops, sch->handle,
-				 NULL);
-	if (p->q == NULL)
-		p->q = &noop_qdisc;
-	else
-		qdisc_hash_add(p->q, true);
-
-	pr_debug("%s: qdisc %p\n", __func__, p->q);
-
-	err = 0;
-errout:
-	return err;
-}
-
-static void dsmark_reset(struct Qdisc *sch)
-{
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-
-	pr_debug("%s(sch %p,[qdisc %p])\n", __func__, sch, p);
-	if (p->q)
-		qdisc_reset(p->q);
-	sch->qstats.backlog = 0;
-	sch->q.qlen = 0;
-}
-
-static void dsmark_destroy(struct Qdisc *sch)
-{
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-
-	pr_debug("%s(sch %p,[qdisc %p])\n", __func__, sch, p);
-
-	tcf_block_put(p->block);
-	qdisc_put(p->q);
-	if (p->mv != p->embedded)
-		kfree(p->mv);
-}
-
-static int dsmark_dump_class(struct Qdisc *sch, unsigned long cl,
-			     struct sk_buff *skb, struct tcmsg *tcm)
-{
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-	struct nlattr *opts = NULL;
-
-	pr_debug("%s(sch %p,[qdisc %p],class %ld\n", __func__, sch, p, cl);
-
-	if (!dsmark_valid_index(p, cl))
-		return -EINVAL;
-
-	tcm->tcm_handle = TC_H_MAKE(TC_H_MAJ(sch->handle), cl - 1);
-	tcm->tcm_info = p->q->handle;
-
-	opts = nla_nest_start(skb, TCA_OPTIONS);
-	if (opts == NULL)
-		goto nla_put_failure;
-	if (nla_put_u8(skb, TCA_DSMARK_MASK, p->mv[cl - 1].mask) ||
-	    nla_put_u8(skb, TCA_DSMARK_VALUE, p->mv[cl - 1].value))
-		goto nla_put_failure;
-
-	return nla_nest_end(skb, opts);
-
-nla_put_failure:
-	nla_nest_cancel(skb, opts);
-	return -EMSGSIZE;
-}
-
-static int dsmark_dump(struct Qdisc *sch, struct sk_buff *skb)
-{
-	struct dsmark_qdisc_data *p = qdisc_priv(sch);
-	struct nlattr *opts = NULL;
-
-	opts = nla_nest_start(skb, TCA_OPTIONS);
-	if (opts == NULL)
-		goto nla_put_failure;
-	if (nla_put_u16(skb, TCA_DSMARK_INDICES, p->indices))
-		goto nla_put_failure;
-
-	if (p->default_index != NO_DEFAULT_INDEX &&
-	    nla_put_u16(skb, TCA_DSMARK_DEFAULT_INDEX, p->default_index))
-		goto nla_put_failure;
-
-	if (p->set_tc_index &&
-	    nla_put_flag(skb, TCA_DSMARK_SET_TC_INDEX))
-		goto nla_put_failure;
-
-	return nla_nest_end(skb, opts);
-
-nla_put_failure:
-	nla_nest_cancel(skb, opts);
-	return -EMSGSIZE;
-}
-
-static const struct Qdisc_class_ops dsmark_class_ops = {
-	.graft		=	dsmark_graft,
-	.leaf		=	dsmark_leaf,
-	.find		=	dsmark_find,
-	.change		=	dsmark_change,
-	.delete		=	dsmark_delete,
-	.walk		=	dsmark_walk,
-	.tcf_block	=	dsmark_tcf_block,
-	.bind_tcf	=	dsmark_bind_filter,
-	.unbind_tcf	=	dsmark_unbind_filter,
-	.dump		=	dsmark_dump_class,
-};
-
-static struct Qdisc_ops dsmark_qdisc_ops __read_mostly = {
-	.next		=	NULL,
-	.cl_ops		=	&dsmark_class_ops,
-	.id		=	"dsmark",
-	.priv_size	=	sizeof(struct dsmark_qdisc_data),
-	.enqueue	=	dsmark_enqueue,
-	.dequeue	=	dsmark_dequeue,
-	.peek		=	dsmark_peek,
-	.init		=	dsmark_init,
-	.reset		=	dsmark_reset,
-	.destroy	=	dsmark_destroy,
-	.change		=	NULL,
-	.dump		=	dsmark_dump,
-	.owner		=	THIS_MODULE,
-};
-
-static int __init dsmark_module_init(void)
-{
-	return register_qdisc(&dsmark_qdisc_ops);
-}
-
-static void __exit dsmark_module_exit(void)
-{
-	unregister_qdisc(&dsmark_qdisc_ops);
-}
-
-module_init(dsmark_module_init)
-module_exit(dsmark_module_exit)
-
-MODULE_LICENSE("GPL");



