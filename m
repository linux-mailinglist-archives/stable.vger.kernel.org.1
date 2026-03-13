Return-Path: <stable+bounces-225390-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HMtJgl/tGmuowAAu9opvQ
	(envelope-from <stable+bounces-225390-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 22:18:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4671028A183
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 22:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5465131C5C38
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 21:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBBD381AEC;
	Fri, 13 Mar 2026 21:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="NhM3/oC0"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8714C36B050
	for <stable@vger.kernel.org>; Fri, 13 Mar 2026 21:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773436628; cv=none; b=GH5k4OVyucbPRngbi72rJ1isn4QMiPi6cAYPQnVRLvHT5wI/AhdITb1Wt5b+3wux+YBuIZb9MEe1WU8K/+uKuFxpLBfcsBvekwu14JwvO71z/Q2t8rDYUDgc3ZclUTdYgsvOMRELXyaYo9TbnzgCHXTAzJgPmQNJ4ToHnbMtJEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773436628; c=relaxed/simple;
	bh=qJvGRypxooCEZzrxu+IeFh/RVpOAqul2XNGK+NN0PS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hhh4wZ7u+j3i4i9ge7qgL9WZOHF6xn6tspNK8gyiRCczUhSQ4yH7/TZG0dqfA37yme5xThnGuE2H53XFrVyRGPTP2sxssVRubKrAQZrFompBG99S/Bxr/6VtFuP3msol9W9pHrRn6XUgFbb523/wSXp4TB1OaFmC9epgqtouWmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=NhM3/oC0; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c739561f0d3so1621148a12.3
        for <stable@vger.kernel.org>; Fri, 13 Mar 2026 14:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773436627; x=1774041427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LSyAnTsYqcKTvS6O/2Ex4exo3xvS2i/hK5q4p87idwc=;
        b=NhM3/oC0EoiuNh/hGDppPwyTcTNhoXPcN9PZ42dkvA77VPTbBTvYZtYXkB/SQT45wE
         VxOlNc3KXbitDGqz+SuxGrlKOmqQssmzycAw90lLGNyVfSKjMh8EVArf3x/uacP6w06D
         Z+1OYGe9YRQkvZD0ncC402TiplOi5hiut6dynNqUyQP/NHFhDt9yxCzPFQDgw8n2hOes
         9hlm28rclYXH6OJoGIuwlkHk5+mkLUEH2GiQK36a6rPOQKRhy1VH7FBNqmLdM/kZRG6L
         fB3Z6LfEZon1bA6cxbRNm0SrOaxG+utLEjRbjKDaRWCvOGUoGiWP5jYWphV948uUcdum
         c0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773436627; x=1774041427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LSyAnTsYqcKTvS6O/2Ex4exo3xvS2i/hK5q4p87idwc=;
        b=r/XT9I+676/ANaYalo8TtOI6vpoLN+N0w76eSLS0JUYmGPFIy/UHEE/ZOdgfhWhv0M
         4YPQSS7VupteCxy0MQgKim+II0Rj8vWfkFQtWot8hbsujyHhhwR3wwGxAEbRcDpcbw6M
         5zPllDNRiImBQCcZBwj4gecz5nruESPpF5cZ6eNzSZUVY8gpE/GW2CB1SeiEOIPNYzuJ
         YwuR22Cj1yptu1r9POfFy+wX7rRGnQk/T4bXnPwdLfV/KPnOZvIuOyovPCrqs0TdEkLx
         J+W4MWICjKs3wB1kNpS3f3BQVKblufE2aUcFaaPnd3LJvW3C7JXXESl5kqFoSK7IsOZV
         A0Ug==
X-Forwarded-Encrypted: i=1; AJvYcCUxTYTNtrrE5f/Ej/2TGVwdcwpEYfP3GGuIyQxEN29cHQsLyuapFW5tKCPnBVTUmjk3CdaYRyE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Fe/Axy1KPOjc25xSnX9yJn/y0rbdxY6BYyfHZCx/JPEVHqXd
	hxYgNPaGq1DWiYAp+GjNekgCNIXkt4HdvnYSUhKLfivWTSWYvcAb1KSfWoKEKst7A+0=
X-Gm-Gg: ATEYQzwgEBsYPSGL3prUVRPOWc/Q/KZTDRy7HUEqMeaKBhsa1Rwl8rN3gMvF2RuldYB
	lhtmSG7az5x17M0xWcQU5xxdbwFT0i9c6zDYr9j2PVgeQKLYSrmK4PbpVygETNfMUGBVQrp03Va
	euFTZAi94Ksk4WM6kRXNe2GIlA0+6NRSGKoxcTE2eEjB4M3xTPSsfJUn+TIAvVDPolHnByTqcV2
	KAcOyy3s0U7pbKw2nfiaCch1K3BPRlHlXIkGwRudWrHfeydduTWzMuxecXVwvwWBX4ktqsjV8fk
	Ru/YRmY0/ItuRLjqxsKksmminshwJPtxTXW+eBTzYPXhXusbB0SPbYO1Qfi7jNVMhf8Jd+miNTE
	rHLNtJH9lbVo3RoYOWR35qkIQc/nLZ7+dNsCe1dZnpphLlwD36KxRW6E5E3k1RroEAiaxggyGsn
	CB4+ZbBn63Tpp/CbUZ9UCpeHckthG19owl
X-Received: by 2002:a17:903:2ace:b0:2ae:ba41:55 with SMTP id d9443c01a7336-2aecab1f315mr47101445ad.26.1773436626809;
        Fri, 13 Mar 2026 14:17:06 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece81afccsm31204195ad.68.2026.03.13.14.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 14:17:06 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@vger.kernel.org
Subject: [PATCH 04/12] net/sched: netem: restructure dequeue to avoid re-entrancy with child qdisc
Date: Fri, 13 Mar 2026 14:15:04 -0700
Message-ID: <20260313211646.12549-5-stephen@networkplumber.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225390-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:email,networkplumber.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber-org.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 4671028A183
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
 net/sched/sch_netem.c | 82 +++++++++++++++++++++++++++++--------------
 1 file changed, 56 insertions(+), 26 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 085fa3ad6f83..08006a60849e 100644
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
@@ -774,34 +777,61 @@ static struct sk_buff *netem_dequeue(struct Qdisc *sch)
 						qdisc_qstats_drop(sch);
 					sch->qstats.backlog -= pkt_len;
 					sch->q.qlen--;
-					qdisc_tree_reduce_backlog(sch, 1, pkt_len);
+					qdisc_tree_reduce_backlog(sch,
+								  1, pkt_len);
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


