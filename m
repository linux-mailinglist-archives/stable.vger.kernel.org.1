Return-Path: <stable+bounces-100758-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C90E59ED5B2
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 20:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B40E16A55E
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 19:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F422252464;
	Wed, 11 Dec 2024 18:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqnoNAVC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2C023A193;
	Wed, 11 Dec 2024 18:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943215; cv=none; b=KbBpFRUP/W/8o72FKUHiqzX6soEPhCVTM1SCUlW4IfjJQ8P1D6+eYJChayOLnPiJqFrgcOhoS2eC+HDYMtXvsqrTf0jFRY8uK/vBYHOwd/iBmgPGzwi1C6vGzQvb+DaYCF8Ogji00hAbVaz+lK2hHNv/bmSYQ7JkkqDuCOZxSoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943215; c=relaxed/simple;
	bh=j2wMNToJjGdHIBwnzb8JzZ+mgkI1yv35iQ/gPJEuKM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W/hGHKv/CgqqGqjgKDqaTQHQSgPJSbLlKS02E/i877h2pDivHlTiJ01+LvKByjfpne1tMw7KepeAse0MtzjoVvYsEAqKENeKHBd8iFIAnsKHisi+Xj+QQBhyWsGdY3yXIN0Bn7JbwjWiad1oW2d51xQrSpk0kn9KD+JdVnhSuDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqnoNAVC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016F9C4CED2;
	Wed, 11 Dec 2024 18:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733943215;
	bh=j2wMNToJjGdHIBwnzb8JzZ+mgkI1yv35iQ/gPJEuKM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lqnoNAVCLkc0F6AxPB2DXwiLtjZ2GvCQQoStVMhdDXy3Xu6KA5/5BU9AFZbhj9pIf
	 7sOgnWr912Uft7WMe0sMnrInYCuWbs+Icr2p/v+oyam4NW5LXndEcJE5Jjfs4Wod5F
	 oKrvn3bNtYtwhvWMC/Oquxbuzt6gUcIuBQ00mwK1fmrSeaAwGyy+z2QFKuMxUZ+Pzh
	 T5vwDBc8c6Eph3vN8csMjaXulNcAL7G3CTK36fMx4OGoe3N1s/kEKi7KFdSNtehZh1
	 SMUr0RIG6WZKjyxehB7cjfR5aYDqpmzM7U053OU6iNtmeoA04JLApOakNH7D2L4a1a
	 2qBylK/Zkx9JQ==
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
Subject: [PATCH AUTOSEL 6.1 09/15] net: sched: fix ordering of qlen adjustment
Date: Wed, 11 Dec 2024 13:53:01 -0500
Message-ID: <20241211185316.3842543-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211185316.3842543-1-sashal@kernel.org>
References: <20241211185316.3842543-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.119
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
index 73e8caeffd47e..eee9ebad35a5c 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1541,7 +1541,6 @@ static unsigned int cake_drop(struct Qdisc *sch, struct sk_buff **to_free)
 	b->backlogs[idx]    -= len;
 	b->tin_backlog      -= len;
 	sch->qstats.backlog -= len;
-	qdisc_tree_reduce_backlog(sch, 1, len);
 
 	flow->dropped++;
 	b->tin_dropped++;
@@ -1552,6 +1551,7 @@ static unsigned int cake_drop(struct Qdisc *sch, struct sk_buff **to_free)
 
 	__qdisc_drop(skb, to_free);
 	sch->q.qlen--;
+	qdisc_tree_reduce_backlog(sch, 1, len);
 
 	cake_heapify(q, 0);
 
diff --git a/net/sched/sch_choke.c b/net/sched/sch_choke.c
index 3ac3e5c80b6ff..e38cf34287018 100644
--- a/net/sched/sch_choke.c
+++ b/net/sched/sch_choke.c
@@ -123,10 +123,10 @@ static void choke_drop_by_idx(struct Qdisc *sch, unsigned int idx,
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


