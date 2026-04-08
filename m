Return-Path: <stable+bounces-235024-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QL3qIeGp1mlKHAgAu9opvQ
	(envelope-from <stable+bounces-235024-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:17:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAA23C2B69
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70F14303FDD6
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6896D3D8912;
	Wed,  8 Apr 2026 18:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SlYKgnm8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197F33D890F;
	Wed,  8 Apr 2026 18:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674374; cv=none; b=LsT/nEH8htO00IDqamz+5JikhlY1bq3Rr6DnpijZNXMR+W1jopQfd3UCiITnlexSsK/ODNDwDru5X4EhsIv3joggTiBz9adhqwhushLPNX1RlfipoOJmS7R+UvsnuxkZ+Re/w/R5css4C8BPtsv65HDBGqv9wcRCGsgzzAvC9NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674374; c=relaxed/simple;
	bh=F4bOplnpPkzTBY1AqG0jKhr5BwPnzlrR9E3GsZntRSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y6avb4ZHZ43oTfHWYy476GwtoCORpATUAj1kDXC0Ihbm8mNiaPB9t2NEyI/Tb5aNAietdiUywiXrQKrhDADjJGa/SpnmzMVqLSriShd5bAnqv4Y+JUEamu5XJOV9ZwtsGnaICLB9Y6vY934NspYcjHZu92KclwbQ+5Iw3XjGxYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SlYKgnm8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A02D0C19421;
	Wed,  8 Apr 2026 18:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674374;
	bh=F4bOplnpPkzTBY1AqG0jKhr5BwPnzlrR9E3GsZntRSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SlYKgnm8BB3LySTp6qVNRyfpfB5d9q5NkRq5w2hHJrTQONlrNct61D9rNNZLvvtL8
	 ePR/2hwYmwNdAvblpQg+xCmPf/h/9cnYhm3zPIxBqs/W/L9EwmJJlFtDg3zVdlcgpC
	 Y82zxW80R98P46M3UEP3azm8e95t92wEh7SdSa80=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yuan Tan <tanyuan98@outlook.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 040/311] mpls: add seqcount to protect the platform_label{,s} pair
Date: Wed,  8 Apr 2026 20:00:40 +0200
Message-ID: <20260408175940.911586373@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175939.393281918@linuxfoundation.org>
References: <20260408175939.393281918@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,outlook.com,gmail.com,lzu.edu.cn,queasysnail.net,kernel.org];
	TAGGED_FROM(0.00)[bounces-235024-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,queasysnail.net:email,lzu.edu.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1CAA23C2B69
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit 629ec78ef8608d955ce217880cdc3e1873af3a15 ]

The RCU-protected codepaths (mpls_forward, mpls_dump_routes) can have
an inconsistent view of platform_labels vs platform_label in case of a
concurrent resize (resize_platform_label_table, under
platform_mutex). This can lead to OOB accesses.

This patch adds a seqcount, so that we get a consistent snapshot.

Note that mpls_label_ok is also susceptible to this, so the check
against RTA_DST in rtm_to_route_config, done outside platform_mutex,
is not sufficient. This value gets passed to mpls_label_ok once more
in both mpls_route_add and mpls_route_del, so there is no issue, but
that additional check must not be removed.

Reported-by: Yuan Tan <tanyuan98@outlook.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Fixes: 7720c01f3f590 ("mpls: Add a sysctl to control the size of the mpls label table")
Fixes: dde1b38e873c ("mpls: Convert mpls_dump_routes() to RCU.")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Link: https://patch.msgid.link/cd8fca15e3eb7e212b094064cd83652e20fd9d31.1774284088.git.sd@queasysnail.net
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netns/mpls.h |  1 +
 net/mpls/af_mpls.c       | 29 +++++++++++++++++++++++++----
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/include/net/netns/mpls.h b/include/net/netns/mpls.h
index 6682e51513efa..2073cbac2afb5 100644
--- a/include/net/netns/mpls.h
+++ b/include/net/netns/mpls.h
@@ -17,6 +17,7 @@ struct netns_mpls {
 	size_t platform_labels;
 	struct mpls_route __rcu * __rcu *platform_label;
 	struct mutex platform_mutex;
+	seqcount_mutex_t platform_label_seq;
 
 	struct ctl_table_header *ctl;
 };
diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index c57f10e2ef269..d77bbe4969886 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -83,14 +83,30 @@ static struct mpls_route *mpls_route_input(struct net *net, unsigned int index)
 	return mpls_dereference(net, platform_label[index]);
 }
 
+static struct mpls_route __rcu **mpls_platform_label_rcu(struct net *net, size_t *platform_labels)
+{
+	struct mpls_route __rcu **platform_label;
+	unsigned int sequence;
+
+	do {
+		sequence = read_seqcount_begin(&net->mpls.platform_label_seq);
+		platform_label = rcu_dereference(net->mpls.platform_label);
+		*platform_labels = net->mpls.platform_labels;
+	} while (read_seqcount_retry(&net->mpls.platform_label_seq, sequence));
+
+	return platform_label;
+}
+
 static struct mpls_route *mpls_route_input_rcu(struct net *net, unsigned int index)
 {
 	struct mpls_route __rcu **platform_label;
+	size_t platform_labels;
+
+	platform_label = mpls_platform_label_rcu(net, &platform_labels);
 
-	if (index >= net->mpls.platform_labels)
+	if (index >= platform_labels)
 		return NULL;
 
-	platform_label = rcu_dereference(net->mpls.platform_label);
 	return rcu_dereference(platform_label[index]);
 }
 
@@ -2240,8 +2256,7 @@ static int mpls_dump_routes(struct sk_buff *skb, struct netlink_callback *cb)
 	if (index < MPLS_LABEL_FIRST_UNRESERVED)
 		index = MPLS_LABEL_FIRST_UNRESERVED;
 
-	platform_label = rcu_dereference(net->mpls.platform_label);
-	platform_labels = net->mpls.platform_labels;
+	platform_label = mpls_platform_label_rcu(net, &platform_labels);
 
 	if (filter.filter_set)
 		flags |= NLM_F_DUMP_FILTERED;
@@ -2645,8 +2660,12 @@ static int resize_platform_label_table(struct net *net, size_t limit)
 	}
 
 	/* Update the global pointers */
+	local_bh_disable();
+	write_seqcount_begin(&net->mpls.platform_label_seq);
 	net->mpls.platform_labels = limit;
 	rcu_assign_pointer(net->mpls.platform_label, labels);
+	write_seqcount_end(&net->mpls.platform_label_seq);
+	local_bh_enable();
 
 	mutex_unlock(&net->mpls.platform_mutex);
 
@@ -2728,6 +2747,8 @@ static __net_init int mpls_net_init(struct net *net)
 	int i;
 
 	mutex_init(&net->mpls.platform_mutex);
+	seqcount_mutex_init(&net->mpls.platform_label_seq, &net->mpls.platform_mutex);
+
 	net->mpls.platform_labels = 0;
 	net->mpls.platform_label = NULL;
 	net->mpls.ip_ttl_propagate = 1;
-- 
2.53.0




