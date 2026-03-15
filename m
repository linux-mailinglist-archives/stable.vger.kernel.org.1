Return-Path: <stable+bounces-225454-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HIrI5r6tWkI8AAAu9opvQ
	(envelope-from <stable+bounces-225454-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 01:17:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DA428FA01
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 01:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26FF6305562A
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 00:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE1D189BB6;
	Sun, 15 Mar 2026 00:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="HXJGz4yu"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A1B18BC3B
	for <stable@vger.kernel.org>; Sun, 15 Mar 2026 00:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773533826; cv=none; b=T32SGaxFkhc0Xo4juMC8zDFdrXW/Y5yUXu0DQVI3yZPgg2bxhgPBVNDmtjXq2bik9r73e+syk7/j79eS51J+TZZCkGYY9iq7SxPsVZQh5fmMzr30CrJpa0vRAE6tPVjJBnmffxj82zGjtNAdzD9fduKE4lWTmLVJeMMzydU5FTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773533826; c=relaxed/simple;
	bh=DLuRUgUbq6hEa68nv+TpNPOWo/SRn0zHG2x4Fa9R+ZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PjHCTl1IP6T656HnLBy9ooV0EeVU28+MgO6uYL0+1ik3oLlN943aipVnAr30zCdAlD+8mbLsSugB9l4L8Pt+adYI6wmDP2XtDho5I2+4M8ouJLHOz2hQGaOd9CQkLEZY5jJZCC2bexgRcR/W/0QyMW6kyKW1kYg0htRb+KJJOK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=HXJGz4yu; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b04e6a989eso1298265ad.3
        for <stable@vger.kernel.org>; Sat, 14 Mar 2026 17:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773533824; x=1774138624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgeOHZnCUQ0UMbyKSrvMETMddysqYMYVIqRv2/Q1+lw=;
        b=HXJGz4yu0DlIkyvydjsWTbEDduFNCI9A7mkDF/NQ6S50hsv1Ls6btKDGui12lXsFA9
         JVSwcJcIpJzzxiQak0C//lIWAlCrwFwQFl/w2ezd+aDVOilMpVyGyopUk8EsjaSLLGAU
         eUGt3DmUBVFs0/I/SQFLZb9A4XpanA1I3gj43ihI8swtdTiRwqtDqEOjYEjVwyFFDqy9
         NLgSek2vff6Oc5s7Jfdj0frJSp7FsKu2ia6V/QtdUKbYpVWsw4v/yk6Lqm1FMgyU5fLP
         PbMHlWrk7yIUqb18SiYlCeTvp43opCYZ7c454maPS52WvXf0qSVIEl2+k29UwDJOSjTV
         Y1vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773533824; x=1774138624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GgeOHZnCUQ0UMbyKSrvMETMddysqYMYVIqRv2/Q1+lw=;
        b=ZWZSqgnB1BIKnM2/Z0xYDyq5FYQWh3smA08yR2w+bw2g48wwhExFEZd6FWlXc2Gl+8
         wSqF/z8hvW4TxGr2JEY8LJ3pz8jvll0S2HYsjcUW8m+2YtBu+F7dN/VJpRINwayl/u/2
         eGGb+mdM64P4TP/qKE/6p8APueiALGin4HvQVbiGwefsafcxoL1Iga2MaXdU4Cg46wCN
         QgwQ3KJKSBAuxKoAvDj5GgXPhNtEnMriT9wzzqEWJmWnoW4KfWfXg7O7QaM3QedlcVxr
         dqBJx9fSHd40WH1iM+NiWtlo7lAN8Wg147b4oPSd+j6/CwyvO6lri6QCnE1pfVSlgbS8
         eCpw==
X-Forwarded-Encrypted: i=1; AJvYcCUnEE6eHHDxyFPwRW8zacSU7udZR5IlNXoVQ/qs9OgVeN7yO/Of6BO4ojolHXdscGDXGdu03dM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxzSdVQpj8q97rFpySVjieD4IUC2a/ADqxSDNCGd1Q3uUoOX5+
	xOIEAtix8+LrTPaJdIRa1wnj/S6Nt/txcH9ZvxYvKrG18g7slneXZ1VSZf8+5DQSI9w=
X-Gm-Gg: ATEYQzzELXotmWX1NsMYmm5uL2kbrD2njHlKjTbo+JSWNXdP/cFhc6R8qhFllrroLgs
	7dt1eueXV9QC2pIXHtzYzJvoUzuxAM/mJAzA9J7CVkkVk47qhCOPTlR/0CAvL+RCwC+Q+K0P0mK
	sDciC97mh8AHXNTU19zK8VEbwZl/xqm5k1/PHCP6cYrODPP7sHNwphY5aPPpC5SOfn9nck6cIDt
	IHKlODbzk5mWhZwA07ICxdzwXjHPa0wbDRjVxyd11NPjOMVg+9318ooA5K3RIGwTiTkVjxlK4t5
	n76W4hgSksU3ice3dgDDkVWv3NT9NM0041r1DJl6FDR4XPVMc1C7sdkMU3Fykhhyy8RC8cVGB2N
	zhOw8Or2Pfzh7WgVP7wxbavaLzi0S9gLlbHhkN0I90q0zbwxYnlTAhKPajJWWXp1thDlzQQCRX5
	K3xeiEIH6Zn+GuOdFt3CQj5KdCmMOR9CZn
X-Received: by 2002:a17:903:2ec6:b0:2ae:c9be:5f2c with SMTP id d9443c01a7336-2aecaa15da9mr81894805ad.21.1773533824514;
        Sat, 14 Mar 2026 17:17:04 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece86b12bsm74252425ad.91.2026.03.14.17.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 17:17:04 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@vger.kernel.org,
	William Liu <will@willsroot.io>,
	Savino Dicanosa <savy@syst3mfailure.io>
Subject: [PATCH net v2 02/10] net/sched: netem: add per-CPU recursion guard for duplication
Date: Sat, 14 Mar 2026 17:14:06 -0700
Message-ID: <20260315001649.23931-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260315001649.23931-1-stephen@networkplumber.org>
References: <20260315001649.23931-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-225454-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:email,networkplumber.org:mid,willsroot.io:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber-org.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: E4DA428FA01
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a per-CPU recursion depth counter to netem_enqueue(). When netem
duplicates a packet, the clone is re-enqueued at the root qdisc. If
the tree contains other netem instances, this can recurse without
bound, causing soft lockups and OOM.

This approach was previously considered but rejected on the grounds
that netem_dequeue calling enqueue on a child netem could bypass the
depth check. That concern does not apply: the child netem's
netem_enqueue() increments the same per-CPU counter, so the total
nesting depth across all netem instances in the call chain is tracked
correctly.

A depth limit of 4 is generous for any legitimate configuration.

Fixes: 0afb51e72855 ("[PKT_SCHED]: netem: reinsert for duplication")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=220774
Cc: stable@vger.kernel.org
Reported-by: William Liu <will@willsroot.io>
Reported-by: Savino Dicanosa <savy@syst3mfailure.io>

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 0ccf74a9cb82..085fa3ad6f83 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -21,6 +21,7 @@
 #include <linux/rtnetlink.h>
 #include <linux/reciprocal_div.h>
 #include <linux/rbtree.h>
+#include <linux/percpu.h>
 
 #include <net/gso.h>
 #include <net/netlink.h>
@@ -29,6 +30,15 @@
 
 #define VERSION "1.3"
 
+/*
+ * Limit for recursion from duplication.
+ * Duplicated packets are re-enqueued at the root qdisc, which may
+ * reach this or another netem instance, causing nested calls to
+ * netem_enqueue(). This per-CPU counter limits the total depth.
+ */
+static DEFINE_PER_CPU(unsigned int, netem_enqueue_depth);
+#define NETEM_RECURSION_LIMIT	4
+
 /*	Network Emulation Queuing algorithm.
 	====================================
 
@@ -460,6 +470,14 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	/* Do not fool qdisc_drop_all() */
 	skb->prev = NULL;
 
+	/* Guard against recursion from duplication re-injection. */
+	if (unlikely(this_cpu_inc_return(netem_enqueue_depth) >
+		     NETEM_RECURSION_LIMIT)) {
+		this_cpu_dec(netem_enqueue_depth);
+		qdisc_drop(skb, sch, to_free);
+		return NET_XMIT_DROP;
+	}
+
 	/* Random duplication */
 	if (q->duplicate && q->duplicate >= get_crandom(&q->dup_cor, &q->prng))
 		++count;
@@ -474,6 +492,7 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	if (count == 0) {
 		qdisc_qstats_drop(sch);
 		__qdisc_drop(skb, to_free);
+		this_cpu_dec(netem_enqueue_depth);
 		return NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
 	}
 
@@ -529,6 +548,7 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		qdisc_drop_all(skb, sch, to_free);
 		if (skb2)
 			__qdisc_drop(skb2, to_free);
+		this_cpu_dec(netem_enqueue_depth);
 		return NET_XMIT_DROP;
 	}
 
@@ -643,8 +663,10 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		/* Parent qdiscs accounted for 1 skb of size @prev_len */
 		qdisc_tree_reduce_backlog(sch, -(nb - 1), -(len - prev_len));
 	} else if (!skb) {
+		this_cpu_dec(netem_enqueue_depth);
 		return NET_XMIT_DROP;
 	}
+	this_cpu_dec(netem_enqueue_depth);
 	return NET_XMIT_SUCCESS;
 }
 
-- 
2.51.0


