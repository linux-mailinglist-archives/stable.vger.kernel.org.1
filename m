Return-Path: <stable+bounces-225389-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMB/NgV/tGmuowAAu9opvQ
	(envelope-from <stable+bounces-225389-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 22:17:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6CC28A175
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 22:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09C0731A3200
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 21:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89CC382F00;
	Fri, 13 Mar 2026 21:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="ugojGCBW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C3E36B050
	for <stable@vger.kernel.org>; Fri, 13 Mar 2026 21:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773436626; cv=none; b=GgcPKk1K1u5mcbPCLEqwm+1SwY9L6vLpE8374QlisKfCL/s82h8Sy1yASvs3tPrr6hepfMFLhqm2cMHAl1LPQ3bhbB1bnbBjNOKoFWo7kD2LQ36p++kvbjU1XNepEknYDVtzOB33ExiTqnIOt+r6iYl4FuqKvR/bMtZ2nD9+25U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773436626; c=relaxed/simple;
	bh=DLuRUgUbq6hEa68nv+TpNPOWo/SRn0zHG2x4Fa9R+ZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SJKQHFpUuFTEbL7QzO6asXvHuH7sLK4VOzkWcT0jO7H0FQZWQN0hu4UVmxJC80uqGqdE9CxXPDn5v1V6OHjgbyIsM8Dxfsgcy1CvsMY3D8ZB/CaTtDmeAjcJh70g08j/rMZ8REoZxK6q3GIKLQQ9kyrTK78vTKkU6g8XnvATcKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=ugojGCBW; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ab232cc803so13009255ad.3
        for <stable@vger.kernel.org>; Fri, 13 Mar 2026 14:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773436624; x=1774041424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgeOHZnCUQ0UMbyKSrvMETMddysqYMYVIqRv2/Q1+lw=;
        b=ugojGCBWCK21yrpDQGXES6sMrfi4UXDDbgY3i69+XW29UAcqmR8Anex6RNb9yEhUYv
         orC0/Wr5dfkRExoelY4Fq+95ZHDpPSTB6bk4FgbZP1SlBOV+3SiXIOrIXxFQVjTNCFTL
         DNtWOpT2Uq+b6qkhKYwNHT/GiJzuaNRsf1a/nvwQ0UxZFInTGfZuBRfWZ5DugndlKlUS
         /b4cEc+QM6qL66XJCkWrwch+clivL/DlAWsCS3RcGX8suDB+8iFbPY30iynOaQjrkXaT
         di+hkkqplYnKz2eqoL5OloWvVMjx5CsbOUt/o7BHYEPHXxy6Jh91LTyUWBPhnVmaE4aI
         UYCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773436624; x=1774041424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GgeOHZnCUQ0UMbyKSrvMETMddysqYMYVIqRv2/Q1+lw=;
        b=WOtcA0jNihi0I+Qxb/pAjnmChA4QzX40O6oPWUsLQ9JM+MD7YJLHCPYAwPcrMoRQdW
         86hru9JA3Khha5K9QocHOLlGMGfp8vK/lrEPoX5guy5Fe1U8nngqd/a5RlJdYzss+X/S
         B61d7k5i5TzH3zMSTVF5UrKQicPfcNU0MfKhAR1FJTBmpLWDAM4iuqTeUpzYPX8XIBr/
         tTL0RFVq6R+9zi7iNX49xuD8JpMcVkAwZAEk5nnfDJsbUlFG6JjeroN+gljjPnGY8fyB
         6FHxrFiSFM/SiBrHhP6VC20H9blA2bIaGNx0L/O08e7mFMYxdlueJ8FXAVa2sGuOXkaL
         IJ2g==
X-Forwarded-Encrypted: i=1; AJvYcCXzUz7Y7Gxy64C5cMcIKivZ6vUKFxpVTn+ypQq0yFRCpcUhKgBPBQxuejalMNSSBJXByPEy5Jg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbrfL6IsULnU/aWbHSUNnxRSWiO8QF4lhCScQHCx4RCQURYJ8x
	C4dq3gYSeKnQheHTJ2MxXzYQ1WqLiB3TaoZ8sKkUkFqMyZJ88fhjlz5uXu6KEBR7uIY=
X-Gm-Gg: ATEYQzz8llowrDlglcSUqYWDbMfGNHQaqZCITwhBA+u0MS7sIhWn8Lc5WgrbdS99gjT
	RqkshXpLQfHlBnirCdPYIQEOr3idFtJDwD/wdM9emutCXB2gR9hEBANwnUgz90uOgxA9szJkToG
	EawgJFkbYmRz/SB8Mg6l2afnxV/bYl6sbQ0YfY4KbzhWVnJSoHGAdjU3doxt+EpTBpcGtcytHf/
	ztuKqFqbIL7+8+vlc1LUUXvpvIaLYuB7ZsXLJmDukQY0Cx2hc8Vsil3dfuS6HGCznyuwZeAB6+e
	jS3FtKaZQ1fL0wPODyEnBabDJWt3puk+w8hiIaHLj4AWafDvfhrXiU6hE++GACiwAqAKi2NSaXH
	GBe3mHvomhLfyPnNz6Jtu7yAAAJw8zW8FoY3goZpge6G/PFEzs+qaChbZuevU0bRJRPo1tH83H8
	2FGEhJi7gP/KFTIYwKOLskiyaas4ZrWT5y
X-Received: by 2002:a17:903:1b06:b0:2ae:4f6a:d2e6 with SMTP id d9443c01a7336-2aeca9438c3mr53663565ad.20.1773436623944;
        Fri, 13 Mar 2026 14:17:03 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece81afccsm31204195ad.68.2026.03.13.14.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 14:17:03 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@vger.kernel.org,
	William Liu <will@willsroot.io>,
	Savino Dicanosa <savy@syst3mfailure.io>
Subject: [PATCH 03/12] net/sched: netem: add per-CPU recursion guard for duplication
Date: Fri, 13 Mar 2026 14:15:03 -0700
Message-ID: <20260313211646.12549-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260313211646.12549-1-stephen@networkplumber.org>
References: <20260313211646.12549-1-stephen@networkplumber.org>
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
	TAGGED_FROM(0.00)[bounces-225389-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:email,networkplumber.org:mid,networkplumber-org.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,willsroot.io:email]
X-Rspamd-Queue-Id: 3B6CC28A175
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


