Return-Path: <stable+bounces-224890-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEciMVfmsmktQwAAu9opvQ
	(envelope-from <stable+bounces-224890-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 17:14:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3677E275599
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 17:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AACE13096D80
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 16:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C950F3C5DDB;
	Thu, 12 Mar 2026 16:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Tp3FgcL8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2401F4180
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 16:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773331889; cv=none; b=Ve2zj2MmuAVX9R2VsGXu3zHl9jQ/e7ZGL8y4SoRlC4kaKqBUdxizgwx2IFVm2jzqzhSREsjiWdPeHQrUENOL3D9j1hgbaR1A0l7CFQ6fSknlPaEBRR0gfdKidrl1W9pdr3lHWCEEYsnuGAieUgsibxs4wlFGxcCCp0jO9Wxct1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773331889; c=relaxed/simple;
	bh=BNWPuXAVBpxxfXejg/KfM534UCEfjVDYgUYi1nUJ3SI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YmvFoCc/BAe83kUgeXNQHQY/I2aesxJ3RYUM1x57/WVfML1Q1EXOvfJ9DBEwSTOlkHAEjnN9mat1TdcoMwHnghhJCDw/xcHmXZeBtkmB9s7xEbT+TjekDNRb9Tg3ctYI4L84asM23aIAHnvVkyEdUdhftJ9LyJwW/QHyKS5oMpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Tp3FgcL8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F9DC4CEF7;
	Thu, 12 Mar 2026 16:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773331889;
	bh=BNWPuXAVBpxxfXejg/KfM534UCEfjVDYgUYi1nUJ3SI=;
	h=Subject:To:Cc:From:Date:From;
	b=Tp3FgcL8B+yVG7YOMJ8g1IcAjO1ljyCDZHrAEtSmWf1Tkfy3epw1hNsOIwZ5mFh9y
	 DMpvfFUa5RHDE40rIpzhX3i2/CQqciNPzpk41jQOmlGUZ/sA3ZAlNNpbck4U/fTVV/
	 2hlbJQU9e9rH0BlTOcMxkWy7OBZMFc3v+V/F0SXo=
Subject: FAILED: patch "[PATCH] net/sched: Only allow act_ct to bind to clsact/ingress qdiscs" failed to apply to 6.1-stable tree
To: victor@mojatatu.com,jhs@mojatatu.com,km.kim1503@gmail.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 12 Mar 2026 17:11:21 +0100
Message-ID: <2026031221-tissue-upgrade-f4d3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224890-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[mojatatu.com,gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 3677E275599
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 11cb63b0d1a0685e0831ae3c77223e002ef18189
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031221-tissue-upgrade-f4d3@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 11cb63b0d1a0685e0831ae3c77223e002ef18189 Mon Sep 17 00:00:00 2001
From: Victor Nogueira <victor@mojatatu.com>
Date: Wed, 25 Feb 2026 10:43:48 -0300
Subject: [PATCH] net/sched: Only allow act_ct to bind to clsact/ingress qdiscs
 and shared blocks

As Paolo said earlier [1]:

"Since the blamed commit below, classify can return TC_ACT_CONSUMED while
the current skb being held by the defragmentation engine. As reported by
GangMin Kim, if such packet is that may cause a UaF when the defrag engine
later on tries to tuch again such packet."

act_ct was never meant to be used in the egress path, however some users
are attaching it to egress today [2]. Attempting to reach a middle
ground, we noticed that, while most qdiscs are not handling
TC_ACT_CONSUMED, clsact/ingress qdiscs are. With that in mind, we
address the issue by only allowing act_ct to bind to clsact/ingress
qdiscs and shared blocks. That way it's still possible to attach act_ct to
egress (albeit only with clsact).

[1] https://lore.kernel.org/netdev/674b8cbfc385c6f37fb29a1de08d8fe5c2b0fbee.1771321118.git.pabeni@redhat.com/
[2] https://lore.kernel.org/netdev/cc6bfb4a-4a2b-42d8-b9ce-7ef6644fb22b@ovn.org/

Reported-by: GangMin Kim <km.kim1503@gmail.com>
Fixes: 3f14b377d01d ("net/sched: act_ct: fix skb leak and crash on ooo frags")
CC: stable@vger.kernel.org
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Link: https://patch.msgid.link/20260225134349.1287037-1-victor@mojatatu.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/include/net/act_api.h b/include/net/act_api.h
index e1e8f0f7dacb..d11b79107930 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -70,6 +70,7 @@ struct tc_action {
 #define TCA_ACT_FLAGS_REPLACE	(1U << (TCA_ACT_FLAGS_USER_BITS + 2))
 #define TCA_ACT_FLAGS_NO_RTNL	(1U << (TCA_ACT_FLAGS_USER_BITS + 3))
 #define TCA_ACT_FLAGS_AT_INGRESS	(1U << (TCA_ACT_FLAGS_USER_BITS + 4))
+#define TCA_ACT_FLAGS_AT_INGRESS_OR_CLSACT	(1U << (TCA_ACT_FLAGS_USER_BITS + 5))
 
 /* Update lastuse only if needed, to avoid dirtying a cache line.
  * We use a temp variable to avoid fetching jiffies twice.
diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index bd51522c7953..7d5e50c921a0 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -1360,6 +1360,12 @@ static int tcf_ct_init(struct net *net, struct nlattr *nla,
 		return -EINVAL;
 	}
 
+	if (bind && !(flags & TCA_ACT_FLAGS_AT_INGRESS_OR_CLSACT)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Attaching ct to a non ingress/clsact qdisc is unsupported");
+		return -EOPNOTSUPP;
+	}
+
 	err = nla_parse_nested(tb, TCA_CT_MAX, nla, ct_policy, extack);
 	if (err < 0)
 		return err;
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 343309e9009b..4829c27446e3 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -2228,6 +2228,11 @@ static bool is_qdisc_ingress(__u32 classid)
 	return (TC_H_MIN(classid) == TC_H_MIN(TC_H_MIN_INGRESS));
 }
 
+static bool is_ingress_or_clsact(struct tcf_block *block, struct Qdisc *q)
+{
+	return tcf_block_shared(block) || (q && !!(q->flags & TCQ_F_INGRESS));
+}
+
 static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 			  struct netlink_ext_ack *extack)
 {
@@ -2420,6 +2425,8 @@ static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 		flags |= TCA_ACT_FLAGS_NO_RTNL;
 	if (is_qdisc_ingress(parent))
 		flags |= TCA_ACT_FLAGS_AT_INGRESS;
+	if (is_ingress_or_clsact(block, q))
+		flags |= TCA_ACT_FLAGS_AT_INGRESS_OR_CLSACT;
 	err = tp->ops->change(net, skb, tp, cl, t->tcm_handle, tca, &fh,
 			      flags, extack);
 	if (err == 0) {


