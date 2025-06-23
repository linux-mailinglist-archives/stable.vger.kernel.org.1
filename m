Return-Path: <stable+bounces-156373-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 204B0AE4F4B
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1CAE189783E
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0476D22069F;
	Mon, 23 Jun 2025 21:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Sz9cJhFT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75ED1DF98B;
	Mon, 23 Jun 2025 21:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750713255; cv=none; b=b/zXNu3U3S1l4Dds3MplP1a8kwbup7+LqaBM6m5HIsA3BRt0sq8jHYcGsK6RtMAWtnq+4+3fQhHd+9RAOGy6a1NCxt5yyU7GBi+D9Ev86hHkyKC9Kc9hPJkD8qBBKgr7f1dknEn93C5Y7ERThhOJaCWI+hmcnEKG0DH4NO4VVOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750713255; c=relaxed/simple;
	bh=OP3T3NAxnOwIKs4PgVfdhSh2bej4YQaeLM8Kxxxz4r8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XULwd+Nb2Y/paLUNYy4rHSVRq2XpLmq4VIPf/hLmnEIqipbvcVTwlLy5AqGyEJyNZQXXiAsu/HrMPOO2jw1I7FFlu6Kc7ifBmWC1tLSBUziXY0KAP6mjMA1STBdQF5YxVZ1oyLDprNJ35aW+Zz/rWAqfiYuzibLdxAdT9Txoz9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Sz9cJhFT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 496EFC4CEEA;
	Mon, 23 Jun 2025 21:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750713255;
	bh=OP3T3NAxnOwIKs4PgVfdhSh2bej4YQaeLM8Kxxxz4r8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sz9cJhFTjRk/VSWyfRcppQIki+Yww3e/dYUNW50X4EN4Qgacoaky5ehH/rn+gCdpm
	 A8YsTzKoDYRfFusv2LKKp+9hQxjs/hfOaa7uanxvRDn4Vv+n/Ecws2WY0XYJly60uQ
	 X8YzkLy6i1fFDHZT6AO/oAEoA59W6ErGjQp+QrRM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gerrard Tai <gerrard.tai@starlabs.sg>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 134/355] net_sched: prio: fix a race in prio_tune()
Date: Mon, 23 Jun 2025 15:05:35 +0200
Message-ID: <20250623130630.760344035@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130626.716971725@linuxfoundation.org>
References: <20250623130626.716971725@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit d35acc1be3480505b5931f17e4ea9b7617fea4d3 ]

Gerrard Tai reported a race condition in PRIO, whenever SFQ perturb timer
fires at the wrong time.

The race is as follows:

CPU 0                                 CPU 1
[1]: lock root
[2]: qdisc_tree_flush_backlog()
[3]: unlock root
 |
 |                                    [5]: lock root
 |                                    [6]: rehash
 |                                    [7]: qdisc_tree_reduce_backlog()
 |
[4]: qdisc_put()

This can be abused to underflow a parent's qlen.

Calling qdisc_purge_queue() instead of qdisc_tree_flush_backlog()
should fix the race, because all packets will be purged from the qdisc
before releasing the lock.

Fixes: 7b8e0b6e6599 ("net: sched: prio: delay destroying child qdiscs on change")
Reported-by: Gerrard Tai <gerrard.tai@starlabs.sg>
Suggested-by: Gerrard Tai <gerrard.tai@starlabs.sg>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20250611111515.1983366-2-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_prio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_prio.c b/net/sched/sch_prio.c
index 1c805fe05b82a..3d92497af01fe 100644
--- a/net/sched/sch_prio.c
+++ b/net/sched/sch_prio.c
@@ -211,7 +211,7 @@ static int prio_tune(struct Qdisc *sch, struct nlattr *opt,
 	memcpy(q->prio2band, qopt->priomap, TC_PRIO_MAX+1);
 
 	for (i = q->bands; i < oldbands; i++)
-		qdisc_tree_flush_backlog(q->queues[i]);
+		qdisc_purge_queue(q->queues[i]);
 
 	for (i = oldbands; i < q->bands; i++) {
 		q->queues[i] = queues[i];
-- 
2.39.5




