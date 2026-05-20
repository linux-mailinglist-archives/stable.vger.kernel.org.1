Return-Path: <stable+bounces-251919-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOF0N+78DWoo5QUAu9opvQ
	(envelope-from <stable+bounces-251919-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:26:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 448D15962B6
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C50436F8850
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0505036405A;
	Wed, 20 May 2026 17:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rT3cFQCj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAAC3B0AD6;
	Wed, 20 May 2026 17:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299228; cv=none; b=fVTuqlwH7EEjcoyQBuIcIZhT5n/VFO29FaK3iqUDDiUFubhjhGLplgB6kSw+20w2SoKQ+9chEPyHeilduLGVgJoN/yGzv6y+kbmJxnsqshM5+PD4++uRF0mIDqCkoyycUIhfez87h49PMrBCkHkubHuaiI5gQUcGdLMIFJP5WVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299228; c=relaxed/simple;
	bh=11TwPq0JSmy+6W/eIHOGnkICgMZ8yY2k9GfMbuWUi9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KzAlb2831+I4cj5PXavdZDIKntzndKwpKTCDAKLRi/5nU46xqSBjfUGfurw0UO6Ckr49vOfKo22r69lzq9kI1Tx2o1odmLCVJ+DuROwf/Z4S/iATdrZ3nuXdPzcXm3BpcY3GxVOaLZYOC09C6YL+VSx0udMOTjvfGZJrYt/aPvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rT3cFQCj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FCF01F000E9;
	Wed, 20 May 2026 17:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779299227;
	bh=WO1r7LvNEu5Fz/2/+KmuwR/7cyYILqPy8qXjsVTpbac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rT3cFQCjHmVkjZ74KdrLkVaqaZkLZLYy0qEyz4QO6a6wjsb8IpFyWXfJ9G4o+4QG6
	 KLyU/G/HMSbcENmGHEW5tUudC5URd3Sdicncy47y7bZ5DjsEkORppzQUtXbV8+Ga6n
	 gOX1ggaPafXw36z7lfXdi3OTOnXtzGf7Nwe/0XBg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Kito Xu (veritas501)" <hxzene@gmail.com>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 670/957] net/sched: sch_dualpi2: drain both C-queue and L-queue in dualpi2_change()
Date: Wed, 20 May 2026 18:19:13 +0200
Message-ID: <20260520162149.066051904@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,nokia-bell-labs.com,redhat.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-251919-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,nokia-bell-labs.com:email]
X-Rspamd-Queue-Id: 448D15962B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

[ Upstream commit 478ed6b7d2577439c610f91fa8759a4c878a4264 ]

Fix dualpi2_change() to correctly enforce updated limit and memlimit
values after a configuration change of the dualpi2 qdisc.

Before this patch, dualpi2_change() always attempted to dequeue packets
via the root qdisc (C-queue) when reducing backlog or memory usage, and
unconditionally assumed that a valid skb will be returned. When traffic
classification results in packets being queued in the L-queue while the
C-queue is empty, this leads to a NULL skb dereference during limit or
memlimit enforcement.

This is fixed by first dequeuing from the C-queue path if it is
non-empty. Once the C-queue is empty, packets are dequeued directly from
the L-queue. Return values from qdisc_dequeue_internal() are checked for
both queues. When dequeuing from the L-queue, the parent qdisc qlen and
backlog counters are updated explicitly to keep overall qdisc statistics
consistent.

Fixes: 320d031ad6e4 ("sched: Struct definition and parsing of dualpi2 qdisc")
Reported-by: "Kito Xu (veritas501)" <hxzene@gmail.com>
Closes: https://lore.kernel.org/netdev/20260413075740.2234828-1-hxzene@gmail.com/
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Link: https://patch.msgid.link/20260417152551.71648-1-chia-yu.chang@nokia-bell-labs.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_dualpi2.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
index 4b975feb52b1f..efa32240c5a95 100644
--- a/net/sched/sch_dualpi2.c
+++ b/net/sched/sch_dualpi2.c
@@ -871,11 +871,35 @@ static int dualpi2_change(struct Qdisc *sch, struct nlattr *opt,
 	old_backlog = sch->qstats.backlog;
 	while (qdisc_qlen(sch) > sch->limit ||
 	       q->memory_used > q->memory_limit) {
-		struct sk_buff *skb = qdisc_dequeue_internal(sch, true);
+		struct sk_buff *skb = NULL;
 
-		q->memory_used -= skb->truesize;
-		qdisc_qstats_backlog_dec(sch, skb);
-		rtnl_qdisc_drop(skb, sch);
+		if (qdisc_qlen(sch) > qdisc_qlen(q->l_queue)) {
+			skb = qdisc_dequeue_internal(sch, true);
+			if (unlikely(!skb)) {
+				WARN_ON_ONCE(1);
+				break;
+			}
+			q->memory_used -= skb->truesize;
+			rtnl_qdisc_drop(skb, sch);
+		} else if (qdisc_qlen(q->l_queue)) {
+			skb = qdisc_dequeue_internal(q->l_queue, true);
+			if (unlikely(!skb)) {
+				WARN_ON_ONCE(1);
+				break;
+			}
+			/* L-queue packets are counted in both sch and
+			 * l_queue on enqueue; qdisc_dequeue_internal()
+			 * handled l_queue, so we further account for sch.
+			 */
+			--sch->q.qlen;
+			qdisc_qstats_backlog_dec(sch, skb);
+			q->memory_used -= skb->truesize;
+			rtnl_qdisc_drop(skb, q->l_queue);
+			qdisc_qstats_drop(sch);
+		} else {
+			WARN_ON_ONCE(1);
+			break;
+		}
 	}
 	qdisc_tree_reduce_backlog(sch, old_qlen - qdisc_qlen(sch),
 				  old_backlog - sch->qstats.backlog);
-- 
2.53.0




