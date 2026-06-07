Return-Path: <stable+bounces-261306-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zsUqLZFHJWqGFwIAu9opvQ
	(envelope-from <stable+bounces-261306-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:27:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F6D64FAAC
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:27:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="inYLF/Bq";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261306-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-261306-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F01D73002B62
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032083254B3;
	Sun,  7 Jun 2026 10:27:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE52713DBA0;
	Sun,  7 Jun 2026 10:27:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780828044; cv=none; b=n1/5TdayV2Ngs6+/xwNEO+8VmF5PJSpb59zc3c8EN28u2ikT1kFQdGgHL5ueKz9BltTX+dvANoJswVBjpMlJVHIMWpQ626rr2w47QUJIpHCExiTA0YlFzN5sTDkYkCtqg1VxKJ7O1mlp2XlkDzN/UCBqZ7QKP0oS2q5/012pblE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780828044; c=relaxed/simple;
	bh=ZH6vr0a4hDIyD1rfUv1B0mbqreQNZT7RWKVoUOcbPU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DkmInysLYOFosOQxZeZrgAVo4Gryx9qPvrjTuGcyC8NSpWYJR5hevoQ3gkMfxR522dzGFYNyyVl+lOrYgKZezv7ZS+mbIZ7CYFPFTkvPbB4LoCstRmo/yn3MtyPMJ69lIJWdyuX0YY5B5/8lNreuHToySlSJgcgUctg7Ym6hgMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=inYLF/Bq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F6BF1F00893;
	Sun,  7 Jun 2026 10:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780828043;
	bh=rYRO317r3RDvQTX8Lo7TevHbMnCUWUsUFuYCLGEWNvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=inYLF/Bq+aqUoJDJCjvtXFifjqy9cds/Zsf5UVT2wqgxi6g9oWUPDrazsmXO7mZJV
	 zqq5LACkSTo9X0fi74NUQDQvF9t2t6d96IYSsS5KwuEcbCZZfewB+95S3EWYpVqyeM
	 IQZ1LfdPkY+PLyLkpzYkGFIiGXpl/2E4gBSOTh3Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexandre Ghiti <alex@ghiti.fr>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	"Harry Yoo (Oracle)" <harry@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.18 123/315] mm: memcontrol: propagate NMI slab stats to memcg vmstats
Date: Sun,  7 Jun 2026 11:58:30 +0200
Message-ID: <20260607095732.139902805@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.528828913@linuxfoundation.org>
References: <20260607095727.528828913@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261306-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:alex@ghiti.fr,m:shakeel.butt@linux.dev,m:hannes@cmpxchg.org,m:harry@kernel.org,m:mhocko@kernel.org,m:muchun.song@linux.dev,m:roman.gushchin@linux.dev,m:akpm@linux-foundation.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cmpxchg.org:email,linux-foundation.org:email,vger.kernel.org:from_smtp,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:email,ghiti.fr:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B6F6D64FAAC

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexandre Ghiti <alex@ghiti.fr>

commit e16f17a9c5af50221184d1ef4be4056bf3c4209e upstream.

flush_nmi_stats() drains per-node NMI slab atomics into the per-node
lruvec_stats, but does not propagate them to the memcg-level vmstats.

For non NMI case, account_slab_nmi_safe() calls mod_memcg_lruvec_state()
which updates both per-node lruvec_stats and memcg-level vmstats, so
flush_nmi_stats() needs to flush to per-node lruvec_stats as well as
memcg-level vmstats.

So fix this by flushing to the memcg-level vmstats for NMI too.

Link: https://lore.kernel.org/20260518082830.599102-1-alex@ghiti.fr
Fixes: 940b01fc8dc1 ("memcg: nmi safe memcg stats for specific archs")
Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/memcontrol.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4044,6 +4044,9 @@ static void flush_nmi_stats(struct mem_c
 			lstats->state[index] += slab;
 			if (plstats)
 				plstats->state_pending[index] += slab;
+			memcg->vmstats->state[index] += slab;
+			if (parent)
+				parent->vmstats->state_pending[index] += slab;
 		}
 		if (atomic_read(&pn->slab_unreclaimable)) {
 			int slab = atomic_xchg(&pn->slab_unreclaimable, 0);
@@ -4052,6 +4055,9 @@ static void flush_nmi_stats(struct mem_c
 			lstats->state[index] += slab;
 			if (plstats)
 				plstats->state_pending[index] += slab;
+			memcg->vmstats->state[index] += slab;
+			if (parent)
+				parent->vmstats->state_pending[index] += slab;
 		}
 	}
 }



