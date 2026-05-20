Return-Path: <stable+bounces-253267-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPz0ESQGDmp25gUAu9opvQ
	(envelope-from <stable+bounces-253267-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:06:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C154E597BFA
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD25C32DA10B
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F21A400E13;
	Wed, 20 May 2026 18:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yOLI9xe3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54D8400E05;
	Wed, 20 May 2026 18:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302831; cv=none; b=co8Xbmq/q6cFkKv/9u2i5ohYEQaSh+r+lcso8ukrSF3AosHoFlIOK1dV1m56ZrHn4517t5Da4BD+wV2kP7Y8lsYIYFUycun+6GGtF1FgKXw3vALpTMHS40MAeSQF1RqmpJWY8j+MkYxxugPeOFQEcMdMtfZL3ia5RBXu7bddZXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302831; c=relaxed/simple;
	bh=Rwk4Sz7Mci7yEIRMYIh2BKuc7WbLuY09MDvScpeV5y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d9/d3j/ILXNYU10CMmWu+qXjsIOS8Fy61Cj7IntweAX2c45q05KYIX1xAUbwOewWqYcZOJbRcMxop10K3cdvTcVHVs6chs/BzXefiFSZqtPoEJSDZ0FVFGS+PcHF4cG21tUDKvAKrzkTZHUpijKbKl7UbTVNHzz7EiKI8QOohds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yOLI9xe3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0281F000E9;
	Wed, 20 May 2026 18:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779302830;
	bh=OzOEujIx4LcoqGsiGt6+NHSXhnUdxIh5Ds+MY7N9E6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=yOLI9xe3nydNVbn6fLGygIbjHMUYunjFPN8aOmUIlaqWhHwuF+GUfLd1+c4W20dwI
	 eQPsthOZ7riENgZlx3HukkehEkDBhcdt3fHxvS/AlyK2qu6FqYzMcFqSxVxqL29dBh
	 yNlXT9hSa5iiv7eP0uFZ1gBAkPSbq9t2J+RaJme0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 416/508] net/sched: sch_cake: annotate data-races in cake_dump_stats() (V)
Date: Wed, 20 May 2026 18:23:59 +0200
Message-ID: <20260520162107.622156543@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162058.573354582@linuxfoundation.org>
References: <20260520162058.573354582@linuxfoundation.org>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253267-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[toke.dk:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: C154E597BFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit a6c95b833dc17e84d16a8ac0f40fd0931616a52d ]

cake_dump_stats() runs without qdisc spinlock being held.

In this final patch, I add READ_ONCE()/WRITE_ONCE() annotations
for cparams.target and cparams.interval.

Fixes: 046f6fd5daef ("sched: Add Common Applications Kept Enhanced (cake) qdisc")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: "Toke Høiland-Jørgensen" <toke@toke.dk>
Link: https://patch.msgid.link/20260427083606.459355-6-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_cake.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 55e8b682ec14c..0b85971165d2a 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -2314,10 +2314,11 @@ static void cake_set_rate(struct cake_tin_data *b, u64 rate, u32 mtu,
 
 	byte_target_ns = (byte_target * rate_ns) >> rate_shft;
 
-	b->cparams.target = max((byte_target_ns * 3) / 2, target_ns);
-	b->cparams.interval = max(rtt_est_ns +
-				     b->cparams.target - target_ns,
-				     b->cparams.target * 2);
+	WRITE_ONCE(b->cparams.target,
+		   max((byte_target_ns * 3) / 2, target_ns));
+	WRITE_ONCE(b->cparams.interval,
+		   max(rtt_est_ns + b->cparams.target - target_ns,
+		       b->cparams.target * 2));
 	b->cparams.mtu_time = byte_target_ns;
 	b->cparams.p_inc = 1 << 24; /* 1/256 */
 	b->cparams.p_dec = 1 << 20; /* 1/4096 */
@@ -2931,9 +2932,9 @@ static int cake_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
 		PUT_TSTAT_U32(BACKLOG_BYTES, b->tin_backlog);
 
 		PUT_TSTAT_U32(TARGET_US,
-			      ktime_to_us(ns_to_ktime(b->cparams.target)));
+			      ktime_to_us(ns_to_ktime(READ_ONCE(b->cparams.target))));
 		PUT_TSTAT_U32(INTERVAL_US,
-			      ktime_to_us(ns_to_ktime(b->cparams.interval)));
+			      ktime_to_us(ns_to_ktime(READ_ONCE(b->cparams.interval))));
 
 		PUT_TSTAT_U32(SENT_PACKETS, b->packets);
 		PUT_TSTAT_U32(DROPPED_PACKETS, b->tin_dropped);
-- 
2.53.0




