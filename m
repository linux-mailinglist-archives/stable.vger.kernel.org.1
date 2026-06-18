Return-Path: <stable+bounces-266982-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HveGKG5pM2ppAgYAu9opvQ
	(envelope-from <stable+bounces-266982-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 05:43:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1240269D5B4
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 05:43:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b=SSwrIDX7;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266982-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266982-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=uniontech.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E76D8302773C
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 03:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E7E30E827;
	Thu, 18 Jun 2026 03:43:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD6335898
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 03:43:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781754218; cv=none; b=i0rCIarQeQSII/xwOG8ZcRdO7QeZGkM24PJ12rHFUGECAuCN96IhmlJzyZS18ibYBMJxQpTysd3jsywSziyweYBBR3Dtja/70gL5In1CUMmmpHJGmdTiuaTOjjPeAZmDWZfGFu66va/gBGX13cj14dkVEd5usNHAe/lTZqmIOQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781754218; c=relaxed/simple;
	bh=W4N/TjmR5MyPKodpCoBlR1kTR/1FRoEywPJJ/r7ViNM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cOULANpkGXUFFZuGMWHaqNPRoP7Spg2V35/F1QayumZAYRu8bFrDzOaikWZX3UNgN9/HxUltAa38IL5o2uWQVkhTBub37ksHjmhg/lavM6Q2wlwLfr6TqGUj98YUXxv3TdK+JGzHfoePAS3S850uloDrAbh9BnnvdrmTGmLqn7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=SSwrIDX7; arc=none smtp.client-ip=54.206.16.166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781754193;
	bh=V3mr7nCW14T/Q9/Y6j4Qfbup0+7+i+wKh0KUPK0EIAk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=SSwrIDX7RaO468TyzTcoXgkU1xnoPEsbPwGHFOFPmVBPfSa/VZhWXmoBIQIAB7lHS
	 X3qHioflOHAKmxwVaHl841x0An3CHIrNEVx3ZgFG2rwjudhZbQYebmX0JzdNKAb3x7
	 /NhLgHlVmMIptHeplxHg7mcZB/06Liev2rGrG6f0=
X-QQ-mid: esmtpsz16t1781754188t105963c7
X-QQ-Originating-IP: lV6tPUQXbWx/rjwWQVApl5IxbNe0B8likL0d2O2BVN0=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Jun 2026 11:43:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4758575730573682470
EX-QQ-RecipientCnt: 14
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org,
	gregkh@linuxfoundation.org,
	guanwentao@uniontech.com
Cc: stable@vger.kernel.org,
	2045gemini@gmail.com,
	dcaratti@redhat.com,
	jhs@mojatatu.com,
	keenanat2000@gmail.com,
	kuba@kernel.org,
	rajat.gupta@oss.qualcomm.com,
	rollkingzzc@gmail.com,
	toke@redhat.com,
	victor@mojatatu.com,
	yimingqian591@gmail.com
Subject: [PATCH 6.1.y 3/3] net/sched: fix pedit partial COW leading to page cache corruption
Date: Thu, 18 Jun 2026 11:42:50 +0800
Message-Id: <20260618034250.1525454-3-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260618034250.1525454-1-guanwentao@uniontech.com>
References: <20260618034034.1525175-1-guanwentao@uniontech.com>
 <20260618034250.1525454-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OSDz5q8BMznT+pjvFiBLZLrrzdGOrskrEeISfPYRyYKzUspE/B7sb+IP
	HcPrmCUSKVSyktMXU0YhMm4Lhv13gvR699Gqh4Ztqp4oP3JLAW6G7V6uUxsXlfHZNnMlBNA
	6GsLJUv2aKdjG/n4ATgnE+pce75IIjcoKyMS42JKPBHLwa51Ps/QvSrO0/GhsykdC71Y4ko
	j31aCn7dRz+Zqpzb/76VxqyCTZhX57XflLptXnf8eBQSRi/96DHXag13ciPTbvzLHtAPN+l
	Ws1lJ5TFTM9yjALeJzQEnfaqPmeNGNDOSGwABHKSR3k6xbnZZp0A3jH6bLpNMbHPCRnvvzN
	fFoRFmLZHiPfrJz2HlyOmM+skKWGDn49IUfEbZq5mLgr+A5iMDZJXDTPrxBgU/IHisUq1D1
	/nlC3Cvy967KCeBN8DBJTwn0D+PHAHR0S+ogUikeaAs5tTPQgyiFfthzBdCYs9kZuItd724
	9TIf94R525o5xUr4mvZBB+n21tbw1Q6KlQ18ggKT+6QJ9vMnyMJX8ntKuc7DUstEljsF7Jp
	V+BYXIN5mJlAyTJpOpJspJVhcu8Ahp0xsSK1HjDgmDm5zIBhDVVt+DyCeU8ingCB4Bt8Dro
	zfU51xGsPQ3krtvXwif32WBbOFzVQW3oU03AiMGbm9XzYkDE3vxx2EsUM4EKv/jyuatuLQc
	lPIPej5CacNjGpZgU9aBQa0fPYBxY5qF5UARtgFSghCDaJ8mbJ084/8R7bwIXthciLhFwwN
	58lMfuOyMaz8VICNS6tj/uZB+xyJWqsATrb2X2wcEBIivYz4eyCFg5DWniT+Ku/SYcopAbR
	tde0PHS9KO71eY2DhsvidIfbAxJY7AOT3Lvlt/nfqBXwuD1JBMi+ScqKs+l0t9eBnvGPfzY
	P29rSlCKq27eOsLcMkJkVenp2T86AQ2+OmyKhcsm8222NVN38FnehOoIwPsioZc5eRlkp7j
	TcjPim4U/jkL6nuFjVNCKllsi6qw+iYXzD7m8r5FocE1KtA8ZYADC+V2/A+7Em0CBwgCozH
	h+KZtHlCC9IGwiPCzm1PHqOZir0EJF3/gEGOZ8nOrQXgN6TgNB/r4PAV6BzIKtQ9EyLodjf
	SBN6kWeijpIUw6df5Tnzq56Z9iAHz+qyUWJkpiLNAEnlCopJi/O86E=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,redhat.com,mojatatu.com,kernel.org,oss.qualcomm.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266982-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sashal@kernel.org,m:gregkh@linuxfoundation.org,m:guanwentao@uniontech.com,m:stable@vger.kernel.org,m:2045gemini@gmail.com,m:dcaratti@redhat.com,m:jhs@mojatatu.com,m:keenanat2000@gmail.com,m:kuba@kernel.org,m:rajat.gupta@oss.qualcomm.com,m:rollkingzzc@gmail.com,m:toke@redhat.com,m:victor@mojatatu.com,m:yimingqian591@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[uniontech.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,uniontech.com:dkim,uniontech.com:email,uniontech.com:mid,uniontech.com:from_mime,qualcomm.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1240269D5B4

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
---
 include/net/tc_act/tc_pedit.h |  1 -
 net/sched/act_pedit.c         | 77 +++++++++++++++++++----------------
 2 files changed, 41 insertions(+), 37 deletions(-)

diff --git a/include/net/tc_act/tc_pedit.h b/include/net/tc_act/tc_pedit.h
index 83fe399317818..a26d4cd3b8d6f 100644
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
index 7ba460fda1f4e..1b076c4f2d1af 100644
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
2.30.2


