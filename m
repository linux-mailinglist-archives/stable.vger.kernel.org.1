Return-Path: <stable+bounces-270717-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 58eKAvOeRmpeaQsAu9opvQ
	(envelope-from <stable+bounces-270717-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:25:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD076FB4E7
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:25:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=u4zOlngi;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270717-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270717-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51510326A762
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21D73D9556;
	Thu,  2 Jul 2026 16:27:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C858B3A254B;
	Thu,  2 Jul 2026 16:27:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783009669; cv=none; b=J7U2rlPLwG/2utwI660xe3VWMwztbwCxr81q2YYM3aHn999VxE65vsgEkP2sSPwouWPvZfyGvPGJHmYIA+p443NPFn36nlsW2KdvylyqJvzedcwtGjeYOPND15uccknhDVjOmwq8jWfahKs6A5JmCzhzfEvGaRAl8lLyvuuUq20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783009669; c=relaxed/simple;
	bh=VgMctFi/jpmUGL6z1m0JlxgoYAls+vQFUSuG6Ejm7q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ikxJb5adtTw/Sx+gWfdBsS79TO00TJ3ncyzXlh8Y+MeDKYT0iJtzX7QVTP2/810/exsQNhnvh7jcUvUo+jpCimUgJlQ7EoVu3ceIUCQ5l1ez0YGNehZyiDy1J1/i0Clzm1LNLroBOOkQygfcbVGd4Y74n/nJZ/HCA6dQHnB2hIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u4zOlngi; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 792621F00A3D;
	Thu,  2 Jul 2026 16:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783009664;
	bh=qhtu752bfu6yeATL9sNox8MQZtXfyoD6oFax+sZKUhU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=u4zOlngi9bupy5bO6SBELBKXpuIudi1VX2iwP4DityMKllNmlxgu4LYBedMWmKvwK
	 6f99gNH10OEMgvk7lSMLjOyXtLLAet8OtSgdyXEVoL9Ck5I0X7OdMyrOiiD+D4yNzn
	 T19naveKK2Qbuaz1cC2YoxeAkq3ctENqW75lVaxI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yiming Qian <yimingqian591@gmail.com>,
	Keenan Dong <keenanat2000@gmail.com>,
	Han Guidong <2045gemini@gmail.com>,
	Zhang Cen <rollkingzzc@gmail.com>,
	Davide Caratti <dcaratti@redhat.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Rajat Gupta <rajat.gupta@oss.qualcomm.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Wentao Guan <guanwentao@uniontech.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 04/95] net/sched: fix pedit partial COW leading to page cache corruption
Date: Thu,  2 Jul 2026 18:19:07 +0200
Message-ID: <20260702155109.298682476@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155109.196223802@linuxfoundation.org>
References: <20260702155109.196223802@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270717-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:yimingqian591@gmail.com,m:keenanat2000@gmail.com,m:2045gemini@gmail.com,m:rollkingzzc@gmail.com,m:dcaratti@redhat.com,m:toke@redhat.com,m:victor@mojatatu.com,m:jhs@mojatatu.com,m:rajat.gupta@oss.qualcomm.com,m:kuba@kernel.org,m:guanwentao@uniontech.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,redhat.com,mojatatu.com,oss.qualcomm.com,kernel.org,uniontech.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,uniontech.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,mojatatu.com:email,qualcomm.com:email,vger.kernel.org:from_smtp,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7AD076FB4E7

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rajat Gupta <rajat.gupta@oss.qualcomm.com>

[ Upstream commit 899ee91156e57784090c5565e4f31bd7dbffbc5a ]

tcf_pedit_act() computes the COW range for skb_ensure_writable()
once before the key loop using tcfp_off_max_hint, but the hint does
not account for the runtime header offset added by typed keys. This
can leave part of the write region un-COW'd.

Fix by moving skb_ensure_writable() inside the per-key loop where
the actual write offset is known, and add overflow checking on the
offset arithmetic. For negative offsets (e.g. Ethernet header edits
at ingress), use skb_cow() to COW the headroom instead. Guard
offset_valid() against INT_MIN, where negation is undefined.

Fixes: 8b796475fd78 ("net/sched: act_pedit: really ensure the skb is writable")
Reported-by: Yiming Qian <yimingqian591@gmail.com>
Reported-by: Keenan Dong <keenanat2000@gmail.com>
Reported-by: Han Guidong <2045gemini@gmail.com>
Reported-by: Zhang Cen <rollkingzzc@gmail.com>
Reviewed-by: Han Guidong <2045gemini@gmail.com>
Tested-by: Han Guidong <2045gemini@gmail.com>
Reviewed-by: Davide Caratti <dcaratti@redhat.com>
Tested-by: Davide Caratti <dcaratti@redhat.com>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Tested-by: Toke Høiland-Jørgensen <toke@redhat.com>
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Tested-by: Victor Nogueira <victor@mojatatu.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
Link: https://patch.msgid.link/20260531123221.48732-1-jhs@mojatatu.com
[rename include file from linux/unaligned.h to asm/unaligned.h]
Conflicts:
	include/net/tc_act/tc_pedit.h
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/tc_act/tc_pedit.h |  1 -
 net/sched/act_pedit.c         | 77 +++++++++++++++++++----------------
 2 files changed, 41 insertions(+), 37 deletions(-)

diff --git a/include/net/tc_act/tc_pedit.h b/include/net/tc_act/tc_pedit.h
index 83fe3993178180..a26d4cd3b8d6f3 100644
--- a/include/net/tc_act/tc_pedit.h
+++ b/include/net/tc_act/tc_pedit.h
@@ -14,7 +14,6 @@ struct tcf_pedit_key_ex {
 struct tcf_pedit_parms {
 	struct tc_pedit_key	*tcfp_keys;
 	struct tcf_pedit_key_ex	*tcfp_keys_ex;
-	u32 tcfp_off_max_hint;
 	unsigned char tcfp_nkeys;
 	unsigned char tcfp_flags;
 	struct rcu_head rcu;
diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index 345fd5645e1dd2..f5b3b6e78b7a6b 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -16,6 +16,8 @@
 #include <linux/ip.h>
 #include <linux/ipv6.h>
 #include <linux/slab.h>
+#include <linux/overflow.h>
+#include <asm/unaligned.h>
 #include <net/ipv6.h>
 #include <net/netlink.h>
 #include <net/pkt_sched.h>
@@ -237,7 +239,6 @@ static int tcf_pedit_init(struct net *net, struct nlattr *nla,
 		goto out_free_ex;
 	}
 
-	nparms->tcfp_off_max_hint = 0;
 	nparms->tcfp_flags = parm->flags;
 	nparms->tcfp_nkeys = parm->nkeys;
 
@@ -265,14 +266,6 @@ static int tcf_pedit_init(struct net *net, struct nlattr *nla,
 						   BITS_PER_TYPE(int) - 1,
 						   nparms->tcfp_keys[i].shift);
 
-		/* The AT option can read a single byte, we can bound the actual
-		 * value with uchar max.
-		 */
-		cur += (0xff & offmask) >> nparms->tcfp_keys[i].shift;
-
-		/* Each key touches 4 bytes starting from the computed offset */
-		nparms->tcfp_off_max_hint =
-			max(nparms->tcfp_off_max_hint, cur + 4);
 	}
 
 	p = to_pedit(*a);
@@ -313,15 +306,12 @@ static void tcf_pedit_cleanup(struct tc_action *a)
 		call_rcu(&parms->rcu, tcf_pedit_cleanup_rcu);
 }
 
-static bool offset_valid(struct sk_buff *skb, int offset)
+static bool offset_valid(struct sk_buff *skb, int offset, int len)
 {
-	if (offset > 0 && offset > skb->len)
-		return false;
-
-	if  (offset < 0 && -offset > skb_headroom(skb))
+	if (offset < -(int)skb_headroom(skb))
 		return false;
 
-	return true;
+	return offset <= (int)skb->len - len;
 }
 
 static int pedit_l4_skb_offset(struct sk_buff *skb, int *hoffset, const int header_type)
@@ -387,18 +377,10 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
 	struct tcf_pedit_key_ex *tkey_ex;
 	struct tcf_pedit_parms *parms;
 	struct tc_pedit_key *tkey;
-	u32 max_offset;
 	int i;
 
 	parms = rcu_dereference_bh(p->parms);
 
-	max_offset = (skb_transport_header_was_set(skb) ?
-		      skb_transport_offset(skb) :
-		      skb_network_offset(skb)) +
-		     parms->tcfp_off_max_hint;
-	if (skb_ensure_writable(skb, min(skb->len, max_offset)))
-		goto done;
-
 	tcf_lastuse_update(&p->tcf_tm);
 	tcf_action_update_bstats(&p->common, skb);
 
@@ -406,10 +388,11 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
 	tkey_ex = parms->tcfp_keys_ex;
 
 	for (i = parms->tcfp_nkeys; i > 0; i--, tkey++) {
+		int write_offset, write_len;
 		int offset = tkey->off;
 		int hoffset = 0;
-		u32 *ptr, hdata;
-		u32 val;
+		u32 cur_val, val;
+		u32 *ptr;
 		int rc;
 
 		if (tkey_ex) {
@@ -427,13 +410,15 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
 
 		if (tkey->offmask) {
 			u8 *d, _d;
+			int at_offset;
 
-			if (!offset_valid(skb, hoffset + tkey->at)) {
+			if (check_add_overflow(hoffset, (int)tkey->at, &at_offset) ||
+			    !offset_valid(skb, at_offset, sizeof(_d))) {
 				pr_info_ratelimited("tc action pedit 'at' offset %d out of bounds\n",
 						    hoffset + tkey->at);
 				goto bad;
 			}
-			d = skb_header_pointer(skb, hoffset + tkey->at,
+			d = skb_header_pointer(skb, at_offset,
 					       sizeof(_d), &_d);
 			if (!d)
 				goto bad;
@@ -445,31 +430,51 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
 			}
 		}
 
-		if (!offset_valid(skb, hoffset + offset)) {
-			pr_info_ratelimited("tc action pedit offset %d out of bounds\n", hoffset + offset);
+		if (check_add_overflow(hoffset, offset, &write_offset)) {
+			pr_info_ratelimited("tc action pedit offset overflow\n");
 			goto bad;
 		}
 
-		ptr = skb_header_pointer(skb, hoffset + offset,
-					 sizeof(hdata), &hdata);
-		if (!ptr)
+		if (!offset_valid(skb, write_offset, sizeof(*ptr))) {
+			pr_info_ratelimited("tc action pedit offset %d out of bounds\n",
+					    write_offset);
 			goto bad;
+		}
+
+		if (write_offset < 0) {
+			if (skb_cow(skb, -write_offset))
+				goto bad;
+			if (write_offset + (int)sizeof(*ptr) > 0) {
+				if (skb_ensure_writable(skb,
+							min_t(int, skb->len,
+							      write_offset + (int)sizeof(*ptr))))
+					goto bad;
+			}
+		} else {
+			if (check_add_overflow(write_offset, (int)sizeof(*ptr),
+					       &write_len))
+				goto bad;
+			if (skb_ensure_writable(skb, min_t(int, skb->len,
+							   write_len)))
+				goto bad;
+		}
+
+		ptr = (u32 *)(skb->data + write_offset);
+		cur_val = get_unaligned(ptr);
 		/* just do it, baby */
 		switch (cmd) {
 		case TCA_PEDIT_KEY_EX_CMD_SET:
 			val = tkey->val;
 			break;
 		case TCA_PEDIT_KEY_EX_CMD_ADD:
-			val = (*ptr + tkey->val) & ~tkey->mask;
+			val = (cur_val + tkey->val) & ~tkey->mask;
 			break;
 		default:
 			pr_info_ratelimited("tc action pedit bad command (%d)\n", cmd);
 			goto bad;
 		}
 
-		*ptr = ((*ptr & tkey->mask) ^ val);
-		if (ptr == &hdata)
-			skb_store_bits(skb, hoffset + offset, ptr, 4);
+		put_unaligned((cur_val & tkey->mask) ^ val, ptr);
 	}
 
 	goto done;
-- 
2.53.0




