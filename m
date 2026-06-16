Return-Path: <stable+bounces-264102-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MhvuF+5uMWrajAUAu9opvQ
	(envelope-from <stable+bounces-264102-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:42:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E96691504
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:42:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=CQ2ncvlg;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264102-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264102-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38572324F3A6
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112AD44BCB0;
	Tue, 16 Jun 2026 15:35:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A896E43DA2C;
	Tue, 16 Jun 2026 15:35:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624131; cv=none; b=hng1hGqTriyLawQO70BdC86ZO5g8P5hXVkfUN0SnvgHdXEDQDmeytdL+b3WKYQ3YzhYl7vg7j6Dj7PAT8gzjzdERnfaDAsiPryZ6iXTBcBXFriJWeRRIZuhyHY5gAU6oa3315ju9xwfzZEVBF9Iaz9H27sVdS1cbBft2fLFDBAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624131; c=relaxed/simple;
	bh=9Gd019rsNybPUSo2k1RMqvqsc0fxkvZ/yfiFT/fS4EM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ftLpViJeOT0obQ4CjynTXu7uzXRliuOIV+Rb6g6Zhe5UWUaaKkOzZi0O2wy9Qs17UrErZbkP7XJyiFAX9aP3CXYEVL/5VucP00zBXV+HU2TK8Zb/qBxkWG2lb4Q3JdAwjIZWR4hIpWmfO3sgJQtPzVqtA2xrxpQeRiBHGYec0wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CQ2ncvlg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD8A1F000E9;
	Tue, 16 Jun 2026 15:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781624130;
	bh=NT38UhiihVPZgos/IJ43lzbnLFefT2ryXFWJDQbwd7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CQ2ncvlgnG27jYv340ebBWNlDR07oR32ZUEF/JwBAykH9NcpIBtsbQE5oKrcghb2k
	 wPCQUVVaS9CGkLY8kd9tJeiLyWtQjPyKsDxfb9pS1iO2lmBhZTQEfDEEnXLIfjLZqe
	 btQFFiiFuaZIGEZ+u1OVFzy/mvSkx10iCSz2WH+Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Harry Yoo <harry@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Muchun Song <muchun.song@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 7.0 280/378] memcg: use round-robin victim selection in refill_stock
Date: Tue, 16 Jun 2026 20:28:31 +0530
Message-ID: <20260616145124.848793756@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264102-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:shakeel.butt@linux.dev,m:harry@kernel.org,m:mhocko@suse.com,m:hannes@cmpxchg.org,m:muchun.song@linux.dev,m:roman.gushchin@linux.dev,m:akpm@linux-foundation.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,linux.dev:email,suse.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux-foundation.org:email,cmpxchg.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D6E96691504

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shakeel Butt <shakeel.butt@linux.dev>

commit c0cafe24d3f6534294c4b2bc2d47734ff7cbd313 upstream.

Harry Yoo reported that get_random_u32_below() is not safe to call in the
nmi context and memcg charge draining can happen in nmi context.

More specifically get_random_u32_below() is neither reentrant- nor
NMI-safe: it acquires a per-cpu local_lock via local_lock_irqsave() on the
batched_entropy_u32 state.  An NMI that lands on a CPU mid-update of the
ChaCha batch state and recurses into the random subsystem would corrupt
that state.  The memcg_stock local_trylock prevents re-entry on the percpu
stock itself, but cannot protect an unrelated subsystem's per-cpu lock.

Replace the random pick with a per-cpu round-robin counter stored in
memcg_stock_pcp and serialized by the same local_trylock that already
guards cached[] and nr_pages[].  No atomics, no random calls, no extra
locks needed.

Link: https://lore.kernel.org/20260521223751.3794625-1-shakeel.butt@linux.dev
Fixes: f735eebe55f8f ("memcg: multi-memcg percpu charge cache")
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Reported-by: Harry Yoo <harry@kernel.org>
Closes: https://lore.kernel.org/4e20f643-6983-4b6e-b12d-c6c4eb20ae0c@kernel.org/
Acked-by: Harry Yoo (Oracle) <harry@kernel.org>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/memcontrol.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1799,6 +1799,7 @@ struct memcg_stock_pcp {
 
 	struct work_struct work;
 	unsigned long flags;
+	uint8_t drain_idx;
 };
 
 static DEFINE_PER_CPU_ALIGNED(struct memcg_stock_pcp, memcg_stock) = {
@@ -1982,7 +1983,9 @@ static void refill_stock(struct mem_cgro
 	if (!success) {
 		i = empty_slot;
 		if (i == -1) {
-			i = get_random_u32_below(NR_MEMCG_STOCK);
+			i = stock->drain_idx++;
+			if (stock->drain_idx == NR_MEMCG_STOCK)
+				stock->drain_idx = 0;
 			drain_stock(stock, i);
 		}
 		css_get(&memcg->css);



