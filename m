Return-Path: <stable+bounces-100789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F459ED61D
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 20:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D535188D372
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 19:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4DA235C4C;
	Wed, 11 Dec 2024 18:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCnVLuhv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D00235C46;
	Wed, 11 Dec 2024 18:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943292; cv=none; b=jyPyY5w2IlFmb3dwT+kSFq+WEADuH7noKQQhHS7/f5gx2EeQBh8VxIDUFALGeD0ZmeWCCx9Du7Q3qrBSnhMHAUkwg73AVj8kUs9mWwzEycE0vJNlmH8Y0cEz6888NG1Dihtmi6JreINTAC8DR5LteUPUpVFDRknvCiuH+YhDuYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943292; c=relaxed/simple;
	bh=3VYmXnMI4su6R0mhdY7vsuCOVCVssqNMN6WEYch34QE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VcOrYJY2Wtji8yS4oq/a7jAMKRN+vxDQwV4AUHTIe+W3GHxbeQ4QfRnewe3TJghrE0IVuM9JDRxE8lSh1nQ08KBbb+zKW/xE8YroIMhUDqjzjDjuFdKJIP4TgoFVZ4+17XetIJzi1nwt7tXjhoIz3fnwKSxQEMsIxQ2ftYtpo3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCnVLuhv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F34C4CED4;
	Wed, 11 Dec 2024 18:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733943291;
	bh=3VYmXnMI4su6R0mhdY7vsuCOVCVssqNMN6WEYch34QE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gCnVLuhveQjxh+uFtEF2FjfHjMlIRh3SrCyC+DZ5D2mwBWmgwE9kT3WiLRNERsl84
	 VX/thGEW6FxgYdPVVguMTKPTiO420xhAByc8l2C9nS5ivJ4ELVcDWMYrwq3i93YDiN
	 4/+XJ29BNPHWVRpi+z9DjJGkq/xogJ6zQcr+fm5/AFqsZ7qH/5K0mjx6oUKobYpLky
	 jDw8BSnNIpZzLSyqvh35dxsa3bdOdvn0kLkyD89DrMJKDq3102gwDD7L9/PzylM58H
	 wPHKSXUzTq9RsWVCgSbG8jI97CBi5KotZJAz7tidnM63dDyqz9Z14Zs3mf79shvlPO
	 6m/5Nad7emUAw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lion Ackermann <nnamrec@gmail.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	cake@lists.bufferbloat.net,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 5/7] net: sched: fix ordering of qlen adjustment
Date: Wed, 11 Dec 2024 13:54:38 -0500
Message-ID: <20241211185442.3843374-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211185442.3843374-1-sashal@kernel.org>
References: <20241211185442.3843374-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.286
Content-Transfer-Encoding: 8bit

From: Lion Ackermann <nnamrec@gmail.com>

[ Upstream commit 5eb7de8cd58e73851cd37ff8d0666517d9926948 ]

Changes to sch->q.qlen around qdisc_tree_reduce_backlog() need to happen
_before_ a call to said function because otherwise it may fail to notify
parent qdiscs when the child is about to become empty.

Signed-off-by: Lion Ackermann <nnamrec@gmail.com>
Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_cake.c  | 2 +-
 net/sched/sch_choke.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 9b4a9bdbeafd9..f2a49bccb5ef5 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1505,7 +1505,6 @@ static unsigned int cake_drop(struct Qdisc *sch, struct sk_buff **to_free)
 	b->backlogs[idx]    -= len;
 	b->tin_backlog      -= len;
 	sch->qstats.backlog -= len;
-	qdisc_tree_reduce_backlog(sch, 1, len);
 
 	flow->dropped++;
 	b->tin_dropped++;
@@ -1516,6 +1515,7 @@ static unsigned int cake_drop(struct Qdisc *sch, struct sk_buff **to_free)
 
 	__qdisc_drop(skb, to_free);
 	sch->q.qlen--;
+	qdisc_tree_reduce_backlog(sch, 1, len);
 
 	cake_heapify(q, 0);
 
diff --git a/net/sched/sch_choke.c b/net/sched/sch_choke.c
index e54f6eabfa0c0..2007bc4f96709 100644
--- a/net/sched/sch_choke.c
+++ b/net/sched/sch_choke.c
@@ -124,10 +124,10 @@ static void choke_drop_by_idx(struct Qdisc *sch, unsigned int idx,
 	if (idx == q->tail)
 		choke_zap_tail_holes(q);
 
+	--sch->q.qlen;
 	qdisc_qstats_backlog_dec(sch, skb);
 	qdisc_tree_reduce_backlog(sch, 1, qdisc_pkt_len(skb));
 	qdisc_drop(skb, sch, to_free);
-	--sch->q.qlen;
 }
 
 struct choke_skb_cb {
-- 
2.43.0


