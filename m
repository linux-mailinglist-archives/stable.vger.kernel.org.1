Return-Path: <stable+bounces-225455-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEgvAbz6tWkI8AAAu9opvQ
	(envelope-from <stable+bounces-225455-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 01:18:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B7328FA1F
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 01:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 982FC3080FA0
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 00:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24751C3BEB;
	Sun, 15 Mar 2026 00:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="sW3izaDS"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF371BBBFC
	for <stable@vger.kernel.org>; Sun, 15 Mar 2026 00:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773533831; cv=none; b=cIunOxwAJQv2LBI+sxKBrZzwRsEeA0NGO+adgSgmRF8SwV5xAIsIVTWDG5Bl6fYP5k7NPGnRZuh1doxRCMkDTA45ftsBzrqSr7HC6Wq3VTHhqRSRYWMSqupwzDy1LQADjq08NXuskBRTS6vnf7Ea/M4osjHIg+pEgkl2qZ+Aink=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773533831; c=relaxed/simple;
	bh=BD7J1zD6k6sE5/zcmQslbwFL3EOcrTmzyHLQZDcEYQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KMk3HPOUIbyROs2yAtW3qNliBZaSnI08RDU3Qy6pYuMvrEYYL/Dw4C0T2sxLiTW52ku6YRAp3AhuhrcVro29Y6nxgLXfZqzR6asvVckv5jrO3Ys6jekmAX7FYgWjdYkkhoJovBp95yTx2RgCsoax9EFJNsojq7k6tKCRk8QT+uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=sW3izaDS; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a8fba3f769so16176795ad.2
        for <stable@vger.kernel.org>; Sat, 14 Mar 2026 17:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773533830; x=1774138630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1kaFouJ1mtue5HX/CeVT6xkibrcOYK9lr4d4C0iKr8=;
        b=sW3izaDSwF0eNpXIcv1BQ8B5dIrUt4/lG9J5ufBu0UtzS1e0WUyDlb1mh7l2RiQdsx
         0oBhfdBHaybs7AOeEsR5sSUp2KAxxeK44+F6eLn6uYdBwBM+J01eNxS/O0y+h93vYLNT
         5+UW6bWl3vIImKJnk+0rJuR6eioLlUal4eymzZj5+TniMWzS0ajjnoGenXhOZiCJOIbH
         fJuoXRR801n4fAo2UsbGuy0zx6IaWvfTWiBaVRi+o/dc3zxQn6pppcA7brZxx+ySobEJ
         hpWxaLcnpHi1PoGlOLu6wmCY3Htxib/3wnc9Jan/PEr4rpBNDOJv8vOjp0ppFBzRmOwA
         7c6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773533830; x=1774138630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m1kaFouJ1mtue5HX/CeVT6xkibrcOYK9lr4d4C0iKr8=;
        b=U5XeQPNchMSOs/zE+X0VCc4GsnvxCoRtVu/uigu96sBELd3VLrZjaSwgSvJHNBciki
         qUcNPID8jYt9ZrizatAKlgJqoFNSYUoS05ZD4Y9Q11qRqQLoGw3c4hMwKQak+8CuzbMl
         yoZlgINEzleSBptvf+vOav4wxSiFye+v7fgvI5mDHLSBNnCvsK0W7o5QN0z07SUOCnnO
         I+zLYEQACsSFMfLik5WTejs6jDErbZDo0Od3hylCH6bhY617pKbwP+vPUv+f6lGjcfOD
         K+zvW/AhzU1GXsdTpkA+ixwI+VTkzlCK1OPaAUm5AMXWqW0pKHGr6ltjxOG8skKrz5OP
         A0RQ==
X-Forwarded-Encrypted: i=1; AJvYcCVa+PWC++mLWdmlC9mkFjNKcMjxiEC3uiqUCMAnYqvfhcldbHxRHPIT+6Nd8JYGAblIZYcEQPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR4vpuDXmLIqcNEHUHpVJr5wiG6YcSi0RKSLYcu13NyfUJdtUA
	4IbNOgy4x8E3CHPVDsIFVuQ0AtFwoH0/+FyPwsKI3DXQmbe84MHznZGlynNBqQC+fWs=
X-Gm-Gg: ATEYQzyKYvrRPrtWlTw0zC6/ImKT2R7FL2a8EoXUE6iwaVXwCd+mWhF5a/MgrOd7Fuv
	xAbCz4YlM6h8kTfNp2mPVkW7rrqT80xoJz6hV+nJzBUvtgMB2bSKXBbr5AYV1AUAEweoa9S7EW/
	5orYRmClKzKIxwmel4xPK9Iyslo28LuQSORsCgg6QE8nK+4mTVXc1N5VBa/eJltfzTP7cQOfsRC
	EnVFgyzsZdePzLaWwy0udItHElAF3raMjnLH1fnuTaRGPCMrGDXbcVP98IPOhmgn0jJeEkRsu7q
	9K3geXwBnN5Z/fVnAfZMXaC3wuR02QAAHYgRtkniCxRKEQftsbL8TI9d4korg+hAUFqdFsCX9St
	pGZxYlmfIIXXFrtcy2w/UlPwr0oGdmXze5EXOS443jUcMYVCA7om9X7SFeMt+oXhpIK8YwcDw7u
	XmOGbcGl2uZJcQX+5OgH/v+PvUzq3Weiqh
X-Received: by 2002:a17:902:f683:b0:2ae:467f:11d8 with SMTP id d9443c01a7336-2aecaa52b09mr87333245ad.30.1773533829962;
        Sat, 14 Mar 2026 17:17:09 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece86b12bsm74252425ad.91.2026.03.14.17.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 17:17:09 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@vger.kernel.org
Subject: [PATCH net v2 04/10] net/sched: netem: restructure dequeue to avoid re-entrancy with child qdisc
Date: Sat, 14 Mar 2026 17:14:08 -0700
Message-ID: <20260315001649.23931-5-stephen@networkplumber.org>
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
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225455-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:email,networkplumber.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber-org.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 91B7328FA1F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

netem_dequeue() currently enqueues time-ready packets into the child
qdisc during the dequeue call path. This creates several problems:

1. Parent qdiscs like HFSC track class active/inactive state based on
   qlen transitions. The child enqueue during netem's dequeue can cause
   qlen to increase while the parent is mid-dequeue, leading to
   double-insertion in HFSC's eltree (CVE-2025-37890, CVE-2025-38001).

2. If the child qdisc is non-work-conserving (e.g., TBF), it may refuse
   to release packets during its dequeue even though they were just
   enqueued. The parent then sees netem returning NULL despite having
   backlog, violating the work-conserving contract and causing stalls
   with parents like DRR that deactivate classes in this case.

Restructure netem_dequeue so that when a child qdisc is present, all
time-ready packets are transferred from the tfifo to the child in a
batch before asking the child for output. This ensures the child only
receives packets whose delay has already elapsed. The no-child path
(tfifo direct dequeue) is unchanged.

Fixes: 50612537e9ab ("netem: fix classful handling")
Cc: stable@vger.kernel.org
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 79 +++++++++++++++++++++++++++++--------------
 1 file changed, 54 insertions(+), 25 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 085fa3ad6f83..7488ff9f2933 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -726,7 +726,6 @@ static struct sk_buff *netem_dequeue(struct Qdisc *sch)
 	struct netem_sched_data *q = qdisc_priv(sch);
 	struct sk_buff *skb;
 
-tfifo_dequeue:
 	skb = __qdisc_dequeue_head(&sch->q);
 	if (skb) {
 deliver:
@@ -734,24 +733,28 @@ static struct sk_buff *netem_dequeue(struct Qdisc *sch)
 		qdisc_bstats_update(sch, skb);
 		return skb;
 	}
-	skb = netem_peek(q);
-	if (skb) {
-		u64 time_to_send;
+
+	/* If we have a child qdisc, transfer all time-ready packets
+	 * from the tfifo into the child, then dequeue from the child.
+	 * This avoids enqueueing into the child during the parent's
+	 * dequeue callback, which can confuse parents that track
+	 * active/inactive state based on qlen transitions (HFSC).
+	 */
+	if (q->qdisc) {
 		u64 now = ktime_get_ns();
 
-		/* if more time remaining? */
-		time_to_send = netem_skb_cb(skb)->time_to_send;
-		if (q->slot.slot_next && q->slot.slot_next < time_to_send)
-			get_slot_next(q, now);
+		while ((skb = netem_peek(q)) != NULL) {
+			u64 t = netem_skb_cb(skb)->time_to_send;
+
+			if (t > now)
+				break;
+			if (q->slot.slot_next && q->slot.slot_next > now)
+				break;
 
-		if (time_to_send <= now && q->slot.slot_next <= now) {
 			netem_erase_head(q, skb);
 			q->t_len--;
 			skb->next = NULL;
 			skb->prev = NULL;
-			/* skb->dev shares skb->rbnode area,
-			 * we need to restore its value.
-			 */
 			skb->dev = qdisc_dev(sch);
 
 			if (q->slot.slot_next) {
@@ -762,7 +765,7 @@ static struct sk_buff *netem_dequeue(struct Qdisc *sch)
 					get_slot_next(q, now);
 			}
 
-			if (q->qdisc) {
+			{
 				unsigned int pkt_len = qdisc_pkt_len(skb);
 				struct sk_buff *to_free = NULL;
 				int err;
@@ -776,32 +779,58 @@ static struct sk_buff *netem_dequeue(struct Qdisc *sch)
 					sch->q.qlen--;
 					qdisc_tree_reduce_backlog(sch, 1, pkt_len);
 				}
-				goto tfifo_dequeue;
 			}
+		}
+
+		skb = q->qdisc->ops->dequeue(q->qdisc);
+		if (skb) {
 			sch->q.qlen--;
 			goto deliver;
 		}
-
-		if (q->qdisc) {
-			skb = q->qdisc->ops->dequeue(q->qdisc);
-			if (skb) {
+	} else {
+		/* No child qdisc: dequeue directly from tfifo */
+		skb = netem_peek(q);
+		if (skb) {
+			u64 time_to_send;
+			u64 now = ktime_get_ns();
+
+			time_to_send = netem_skb_cb(skb)->time_to_send;
+			if (q->slot.slot_next &&
+			    q->slot.slot_next < time_to_send)
+				get_slot_next(q, now);
+
+			if (time_to_send <= now &&
+			    q->slot.slot_next <= now) {
+				netem_erase_head(q, skb);
+				q->t_len--;
+				skb->next = NULL;
+				skb->prev = NULL;
+				skb->dev = qdisc_dev(sch);
+
+				if (q->slot.slot_next) {
+					q->slot.packets_left--;
+					q->slot.bytes_left -=
+						qdisc_pkt_len(skb);
+					if (q->slot.packets_left <= 0 ||
+					    q->slot.bytes_left <= 0)
+						get_slot_next(q, now);
+				}
 				sch->q.qlen--;
 				goto deliver;
 			}
 		}
+	}
+
+	/* Schedule watchdog for next time-ready packet */
+	skb = netem_peek(q);
+	if (skb) {
+		u64 time_to_send = netem_skb_cb(skb)->time_to_send;
 
 		qdisc_watchdog_schedule_ns(&q->watchdog,
 					   max(time_to_send,
 					       q->slot.slot_next));
 	}
 
-	if (q->qdisc) {
-		skb = q->qdisc->ops->dequeue(q->qdisc);
-		if (skb) {
-			sch->q.qlen--;
-			goto deliver;
-		}
-	}
 	return NULL;
 }
 
-- 
2.51.0


