Return-Path: <stable+bounces-75026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD6A973296
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 499E1285CB1
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A973C195FD1;
	Tue, 10 Sep 2024 10:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ejw+sQ4J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694BF172BAE;
	Tue, 10 Sep 2024 10:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725963532; cv=none; b=AcC29SYeFE1hd2v2vaxGa6TNQaq3muTwyNwVzKycH8LqPK601G7r82BIFDMdoFzirHYfQEE3t68pwCExhScrxlKjqiR945Y7W0MTQftrdO5LN029ABnGJdpcqodkZfmwCGkFSAemT0Mejqgia0yP4Lp5i83ZvgZH77RtGkj0Gz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725963532; c=relaxed/simple;
	bh=jp9GRj/Sz1wcYsPm0jkROLYU9zkL3JMb+WvcQcDRR0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LbGuea/Xh4rGV3XwIpquAqjcvLiJC8ak1qBn0dwpkw2iktyMzDES2dkV/VvNbpcdxOUWVEhAXbajCP25WTunJ4d/05SZPRJQHZtJcCDWrrjfBNMKOixlh5kdtotHJnOJUex0Ut21zk8NyhTyjPFflmwHW5LIjwYC+mUSvfA4QzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ejw+sQ4J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D3BC4CEC6;
	Tue, 10 Sep 2024 10:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725963532;
	bh=jp9GRj/Sz1wcYsPm0jkROLYU9zkL3JMb+WvcQcDRR0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ejw+sQ4JRiWSJvVdsFyjm+gJQ69fs31j/Y69fqKkzeCMkLtHBIFSef1YV+qtLrjt1
	 NjHbTQYAw3LFsx9GWX4/pxoUYl4OUzw3YCvwcQT6XvDBMZtu6pZ9SCFDtgNOZzj8Bx
	 dwXc+eDhhy0vRxLhDwBDDY1sP4TSJUT8+QmOo5gQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Budimir Markovic <markovicbudimir@gmail.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15 062/214] sch/netem: fix use after free in netem_dequeue
Date: Tue, 10 Sep 2024 11:31:24 +0200
Message-ID: <20240910092601.302877976@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092558.714365667@linuxfoundation.org>
References: <20240910092558.714365667@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephen Hemminger <stephen@networkplumber.org>

commit 3b3a2a9c6349e25a025d2330f479bc33a6ccb54a upstream.

If netem_dequeue() enqueues packet to inner qdisc and that qdisc
returns __NET_XMIT_STOLEN. The packet is dropped but
qdisc_tree_reduce_backlog() is not called to update the parent's
q.qlen, leading to the similar use-after-free as Commit
e04991a48dbaf382 ("netem: fix return value if duplicate enqueue
fails")

Commands to trigger KASAN UaF:

ip link add type dummy
ip link set lo up
ip link set dummy0 up
tc qdisc add dev lo parent root handle 1: drr
tc filter add dev lo parent 1: basic classid 1:1
tc class add dev lo classid 1:1 drr
tc qdisc add dev lo parent 1:1 handle 2: netem
tc qdisc add dev lo parent 2: handle 3: drr
tc filter add dev lo parent 3: basic classid 3:1 action mirred egress
redirect dev dummy0
tc class add dev lo classid 3:1 drr
ping -c1 -W0.01 localhost # Trigger bug
tc class del dev lo classid 1:1
tc class add dev lo classid 1:1 drr
ping -c1 -W0.01 localhost # UaF

Fixes: 50612537e9ab ("netem: fix classful handling")
Reported-by: Budimir Markovic <markovicbudimir@gmail.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Link: https://patch.msgid.link/20240901182438.4992-1-stephen@networkplumber.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/sch_netem.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -733,11 +733,10 @@ deliver:
 
 				err = qdisc_enqueue(skb, q->qdisc, &to_free);
 				kfree_skb_list(to_free);
-				if (err != NET_XMIT_SUCCESS &&
-				    net_xmit_drop_count(err)) {
-					qdisc_qstats_drop(sch);
-					qdisc_tree_reduce_backlog(sch, 1,
-								  pkt_len);
+				if (err != NET_XMIT_SUCCESS) {
+					if (net_xmit_drop_count(err))
+						qdisc_qstats_drop(sch);
+					qdisc_tree_reduce_backlog(sch, 1, pkt_len);
 				}
 				goto tfifo_dequeue;
 			}



