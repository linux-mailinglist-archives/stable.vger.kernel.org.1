Return-Path: <stable+bounces-249528-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLYzN64/DGqqawUAu9opvQ
	(envelope-from <stable+bounces-249528-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 12:47:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 317E757CC07
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 12:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BDE5A3096E5A
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 10:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600B73A0EA5;
	Tue, 19 May 2026 10:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z5zZ+h6B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C7C371D10
	for <stable@vger.kernel.org>; Tue, 19 May 2026 10:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779185941; cv=none; b=ROmU8NdjGKOu6mB7OlVgDjsHgwAiGbjpBOiYTfkmLu4P6v0w7G3ABtWps5x3wloQIIni0qo5hm8Td0QEY3intjjbOAkPHsQ6dr9Qqs6t4KlsD8w6V7I3LtdrxkT957a3ktkXjxKo2e0LKGAvVpIPg5ZX46H/oFwM03/5Zu/ZGp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779185941; c=relaxed/simple;
	bh=gBZ9ECe89luPl9QUeKUns4Rzc/xQz52EiTNrAJNzo0w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bhiKoM6g6WDkcJhLs0+/c6OfKjsTCaYjz+Bs1n3aCHEhZpOPaiZVdjtAV88v1Q/RymN2Fubbfy/fatWI1/uWXNomKR7XWgXUJOmB5fC8kmXLgAJL0+qqKp0NEA1zCgY+Uzif/xJnnsF008azsmQ5+mFlEavWpmgFAHg03kbzmys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z5zZ+h6B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 496B9C2BCB3;
	Tue, 19 May 2026 10:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1779185940;
	bh=gBZ9ECe89luPl9QUeKUns4Rzc/xQz52EiTNrAJNzo0w=;
	h=Subject:To:Cc:From:Date:From;
	b=z5zZ+h6BL/JTL6cTjRDe73cL0H0ba+ZS+Fgl15MFgXY9I3H6cKwgCOXJLkurGoyhl
	 dzs7jYmhKWP3zEfc7nUed8CYyKU3AbbIW7JPOmwZZdr6tncT73PWao+MAJ1l+FY3qr
	 O1EmdS4B7Qf1yU86G+XS3Hk43k8snWj3GEEU1VU0=
Subject: FAILED: patch "[PATCH] ipv6: flowlabel: enforce per-netns limit for unprivileged" failed to apply to 6.1-stable tree
To: maoyi.xie@ntu.edu.sg,kuba@kernel.org,willemb@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 19 May 2026 12:18:03 +0200
Message-ID: <2026051903-rash-moody-9c20@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249528-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ntu.edu.sg:email,linuxfoundation.org:dkim,gregkh:email,msgid.link:url]
X-Rspamd-Queue-Id: 317E757CC07
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x e68eadffb724b36ffd3d5619e0efcaf29ec2a175
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051903-rash-moody-9c20@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e68eadffb724b36ffd3d5619e0efcaf29ec2a175 Mon Sep 17 00:00:00 2001
From: Maoyi Xie <maoyi.xie@ntu.edu.sg>
Date: Wed, 6 May 2026 16:24:16 +0800
Subject: [PATCH] ipv6: flowlabel: enforce per-netns limit for unprivileged
 callers

fl_size, fl_ht and ip6_fl_lock in net/ipv6/ip6_flowlabel.c are
file scope and shared across netns. mem_check() reads fl_size to
decide whether to deny non-CAP_NET_ADMIN callers. capable() runs
against init_user_ns, so an unprivileged user in any non-init
userns can push fl_size past FL_MAX_SIZE - FL_MAX_SIZE / 4 and
starve every other unprivileged userns on the host.

Add struct netns_ipv6::flowlabel_count, bumped and decremented
next to fl_size in fl_intern, ip6_fl_gc and ip6_fl_purge. The new
field fills the existing 4-byte hole after ipmr_seq, so struct
netns_ipv6 stays the same size on 64-bit builds.

Bump FL_MAX_SIZE from 4096 to 8192. It has been 4096 since the
file was added. Machines and connection counts have grown.

mem_check() folds an extra per-netns ceiling into the existing
non-CAP_NET_ADMIN conditional. The ceiling is half of the total
budget that unprivileged callers have ever been able to use, i.e.
(FL_MAX_SIZE - FL_MAX_SIZE / 4) / 2 = 3072 entries. With
FL_MAX_SIZE doubled, this preserves the original per-user reach
of 3K (what an unprivileged caller could already obtain before
this change), while forcing an attacker to spread allocations
across at least two netns to exhaust the global non-CAP_NET_ADMIN
budget.

CAP_NET_ADMIN against init_user_ns still bypasses both caps.

The previous patch took ip6_fl_lock across mem_check and
fl_intern, so the new flowlabel_count read in mem_check and the
new flowlabel_count++ in fl_intern run under the same critical
section. flowlabel_count is therefore plain int, like fl_size.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Suggested-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Cc: stable@vger.kernel.org # v5.15+
Signed-off-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>
Link: https://patch.msgid.link/20260506082416.2259567-3-maoyixie.tju@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
index 499e4288170f..875916d60bfe 100644
--- a/include/net/netns/ipv6.h
+++ b/include/net/netns/ipv6.h
@@ -119,6 +119,7 @@ struct netns_ipv6 {
 	struct fib_notifier_ops	*notifier_ops;
 	struct fib_notifier_ops	*ip6mr_notifier_ops;
 	atomic_t		ipmr_seq;
+	int			flowlabel_count;
 	struct {
 		struct hlist_head head;
 		spinlock_t	lock;
diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
index a8974643195a..b1ccdf0dc646 100644
--- a/net/ipv6/ip6_flowlabel.c
+++ b/net/ipv6/ip6_flowlabel.c
@@ -36,7 +36,7 @@
 /* FL hash table */
 
 #define FL_MAX_PER_SOCK	32
-#define FL_MAX_SIZE	4096
+#define FL_MAX_SIZE	8192
 #define FL_HASH_MASK	255
 #define FL_HASH(l)	(ntohl(l)&FL_HASH_MASK)
 
@@ -162,8 +162,9 @@ static void ip6_fl_gc(struct timer_list *unused)
 				ttd = fl->expires;
 				if (time_after_eq(now, ttd)) {
 					*flp = fl->next;
-					fl_free(fl);
 					fl_size--;
+					fl->fl_net->ipv6.flowlabel_count--;
+					fl_free(fl);
 					continue;
 				}
 				if (!sched || time_before(ttd, sched))
@@ -197,6 +198,7 @@ static void __net_exit ip6_fl_purge(struct net *net)
 				*flp = fl->next;
 				fl_free(fl);
 				fl_size--;
+				net->ipv6.flowlabel_count--;
 				continue;
 			}
 			flp = &fl->next;
@@ -243,6 +245,7 @@ static struct ip6_flowlabel *fl_intern(struct net *net,
 	fl->next = fl_ht[FL_HASH(fl->label)];
 	rcu_assign_pointer(fl_ht[FL_HASH(fl->label)], fl);
 	fl_size++;
+	net->ipv6.flowlabel_count++;
 	return NULL;
 }
 
@@ -460,6 +463,9 @@ fl_create(struct net *net, struct sock *sk, struct in6_flowlabel_req *freq,
 
 static int mem_check(struct sock *sk)
 {
+	const int unpriv_total_limit = FL_MAX_SIZE - (FL_MAX_SIZE / 4);
+	const int unpriv_user_limit = unpriv_total_limit / 2;
+	struct net *net = sock_net(sk);
 	int room;
 	struct ipv6_fl_socklist *sfl;
 	int count = 0;
@@ -478,7 +484,9 @@ static int mem_check(struct sock *sk)
 
 	if (room <= 0 ||
 	    ((count >= FL_MAX_PER_SOCK ||
-	      (count > 0 && room < FL_MAX_SIZE/2) || room < FL_MAX_SIZE/4) &&
+	      (count > 0 && room < FL_MAX_SIZE / 2) ||
+	      room < FL_MAX_SIZE / 4 ||
+	      net->ipv6.flowlabel_count >= unpriv_user_limit) &&
 	     !capable(CAP_NET_ADMIN)))
 		return -ENOBUFS;
 


