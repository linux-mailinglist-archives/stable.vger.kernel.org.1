Return-Path: <stable+bounces-240104-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJsxKX5J52lW6QEAu9opvQ
	(envelope-from <stable+bounces-240104-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 11:55:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C824392D4
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 11:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0960F305A414
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 09:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400C93B0AFA;
	Tue, 21 Apr 2026 09:49:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393923A9D80;
	Tue, 21 Apr 2026 09:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776764965; cv=none; b=lq7AgLHj4cOD9137ncXyzJeYiw7oqs79biHUQwavLheCf+59DBiM52TQSlM3LUOi84YNQp8a17VcNhTmZrtV1VtW3Hwi4CmMgxAaKMlsecPl8Fw0xFJwmdPuf+sGPJk61pC/LhPE9rsXApG1PUQPW4cgiyKTop6H2V7l6jG9ZDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776764965; c=relaxed/simple;
	bh=kWyz7/ZElDxT2upU419ymJDNbLDDMvSaazGSmARl39M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lRWCNCteGozxLyHXRpj9U/emN8isuCBlcUr8LKuuY+c4Dsxe99WrXaE8MNTpWYprCiQauGKrbc1S3HZKNYGRE/fPMf1imM0JiE1XgmsHL8KDSimAgy6gDJTsP1jhRe3fsOI1tTuB7M+iVEbS6gCPR0i8FAPyExK9W3jboI8YQPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; arc=none smtp.client-ip=160.80.4.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from localhost.localdomain ([160.80.103.126])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 63L9m9Um016338;
	Tue, 21 Apr 2026 11:48:15 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
        david.lebrun@uclouvain.be, alex.aring@gmail.com,
        stefano.salsano@uniroma2.it, andrea.mayer@uniroma2.it,
        netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH net] net: ipv6: fix NOREF dst use in seg6 and rpl lwtunnels
Date: Tue, 21 Apr 2026 11:47:35 +0200
Message-Id: <20260421094735.20997-1-andrea.mayer@uniroma2.it>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[uniroma2.it : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linutronix.de,kernel.org,goodmis.org,uclouvain.be,gmail.com,uniroma2.it,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-240104-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.mayer@uniroma2.it,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[stable];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: F2C824392D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

seg6_input_core() and rpl_input() call ip6_route_input() which sets a
NOREF dst on the skb, then pass it to dst_cache_set_ip6() invoking
dst_hold() unconditionally.
On PREEMPT_RT, ksoftirqd is preemptible and a higher-priority task can
release the underlying pcpu_rt between the lookup and the caching
through a concurrent FIB lookup on a shared nexthop.
Simplified race sequence:

  ksoftirqd/X                       higher-prio task (same CPU X)
  -----------                       --------------------------------
  seg6_input_core(,skb)/rpl_input(skb)
    dst_cache_get()
      -> miss
    ip6_route_input(skb)
      -> ip6_pol_route(,skb,flags)
         [RT6_LOOKUP_F_DST_NOREF in flags]
        -> FIB lookup resolves fib6_nh
           [nhid=N route]
        -> rt6_make_pcpu_route()
           [creates pcpu_rt, refcount=1]
             pcpu_rt->sernum = fib6_sernum
             [fib6_sernum=W]
           -> cmpxchg(fib6_nh.rt6i_pcpu,
                      NULL, pcpu_rt)
              [slot was empty, store succeeds]
      -> skb_dst_set_noref(skb, dst)
         [dst is pcpu_rt, refcount still 1]

                                    rt_genid_bump_ipv6()
                                      -> bumps fib6_sernum
                                         [fib6_sernum from W to Z]
                                    ip6_route_output()
                                      -> ip6_pol_route()
                                        -> FIB lookup resolves fib6_nh
                                           [nhid=N]
                                        -> rt6_get_pcpu_route()
                                             pcpu_rt->sernum != fib6_sernum
                                             [W <> Z, stale]
                                          -> prev = xchg(rt6i_pcpu, NULL)
                                          -> dst_release(prev)
                                             [prev is pcpu_rt,
                                              refcount 1->0, dead]

    dst = skb_dst(skb)
    [dst is the dead pcpu_rt]
    dst_cache_set_ip6(dst)
      -> dst_hold() on dead dst
      -> WARN / use-after-free

For the race to occur, ksoftirqd must be preemptible (PREEMPT_RT without
PREEMPT_RT_NEEDS_BH_LOCK) and a concurrent task must be able to release
the pcpu_rt. Shared nexthop objects provide such a path, as two routes
pointing to the same nhid share the same fib6_nh and its rt6i_pcpu
entry.

Fix seg6_input_core() and rpl_input() by calling skb_dst_force() after
ip6_route_input() to force the NOREF dst into a refcounted one before
caching.
The output path is not affected as ip6_route_output() already returns a
refcounted dst.

Fixes: af4a2209b134 ("ipv6: sr: use dst_cache in seg6_input")
Fixes: a7a29f9c361f ("net: ipv6: add rpl sr tunnel")
Cc: stable@vger.kernel.org
Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
---
 net/ipv6/rpl_iptunnel.c  | 9 +++++++++
 net/ipv6/seg6_iptunnel.c | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/net/ipv6/rpl_iptunnel.c b/net/ipv6/rpl_iptunnel.c
index c7942cf65567..4e10adcd70e8 100644
--- a/net/ipv6/rpl_iptunnel.c
+++ b/net/ipv6/rpl_iptunnel.c
@@ -287,7 +287,16 @@ static int rpl_input(struct sk_buff *skb)
 
 	if (!dst) {
 		ip6_route_input(skb);
+
+		/* ip6_route_input() sets a NOREF dst; force a refcount on it
+		 * before caching or further use.
+		 */
+		skb_dst_force(skb);
 		dst = skb_dst(skb);
+		if (unlikely(!dst)) {
+			err = -ENETUNREACH;
+			goto drop;
+		}
 
 		/* cache only if we don't create a dst reference loop */
 		if (!dst->error && lwtst != dst->lwtstate) {
diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index 97b50d9b1365..94284b483be0 100644
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -515,7 +515,16 @@ static int seg6_input_core(struct net *net, struct sock *sk,
 
 	if (!dst) {
 		ip6_route_input(skb);
+
+		/* ip6_route_input() sets a NOREF dst; force a refcount on it
+		 * before caching or further use.
+		 */
+		skb_dst_force(skb);
 		dst = skb_dst(skb);
+		if (unlikely(!dst)) {
+			err = -ENETUNREACH;
+			goto drop;
+		}
 
 		/* cache only if we don't create a dst reference loop */
 		if (!dst->error && lwtst != dst->lwtstate) {
-- 
2.20.1


