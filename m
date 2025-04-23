Return-Path: <stable+bounces-135427-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3878DA98E29
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 16:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CD97447CAD
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 14:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CA7283C87;
	Wed, 23 Apr 2025 14:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ax5sW8d2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74472836A4;
	Wed, 23 Apr 2025 14:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745419895; cv=none; b=FrUklyLWVDrjR8hSWjS/ksr4NHO/4QybLaYjG9ou0e3lngMpP0pRv/H9x+tGL3uxF0PGiehUL/qAovQZKqHgdwfoSOskpEr2Q9z7wmbQ2VxYbYErL6H418yFyHzwPTxueKxSLMc2/pC+rjOZpFlPK5fGczWNgmAI+TTWzOWgyUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745419895; c=relaxed/simple;
	bh=HMGjflM6JY/2cpOk8NwWWQXP+xcaAFpDX3i3PUjLUbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gB9s7Je1lKnMTA0ZBwR6Zv0FBX0qG8lcVdPccVNBT3lgP3idbYy4ey7d122ak3/FQJRZEZs1Pz76x4vsObjivMEmzXnfRcjnrhbNWLKMmu6ErNEgsCfTCpnZsZjR1rcVIljFls0x5T+ZAvGPrFcppfKtmSQ8zsawLm1HJAFgjt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ax5sW8d2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC47C4CEE8;
	Wed, 23 Apr 2025 14:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745419894;
	bh=HMGjflM6JY/2cpOk8NwWWQXP+xcaAFpDX3i3PUjLUbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ax5sW8d2aszj4WYIxwjEi+/n/DObBqoJ2n4Xr37Qn+b3H/pdFmIoZC4YibspD0cq+
	 4riKlM5PgqC1kTGqlXpxqbTs1lQU37b5j+RkmxqYxddJeR+ktP/ceMoy4NhZyGVwKf
	 4j8qLjlzuUjCLxUWfx4CA/47cXSyz0RQqktCgxYM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tung Nguyen <tung.quang.nguyen@est.tech>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 008/393] tipc: fix memory leak in tipc_link_xmit
Date: Wed, 23 Apr 2025 16:38:24 +0200
Message-ID: <20250423142643.607741703@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142643.246005366@linuxfoundation.org>
References: <20250423142643.246005366@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tung Nguyen <tung.quang.nguyen@est.tech>

[ Upstream commit 69ae94725f4fc9e75219d2d69022029c5b24bc9a ]

In case the backlog transmit queue for system-importance messages is overloaded,
tipc_link_xmit() returns -ENOBUFS but the skb list is not purged. This leads to
memory leak and failure when a skb is allocated.

This commit fixes this issue by purging the skb list before tipc_link_xmit()
returns.

Fixes: 365ad353c256 ("tipc: reduce risk of user starvation during link congestion")
Signed-off-by: Tung Nguyen <tung.quang.nguyen@est.tech>
Link: https://patch.msgid.link/20250403092431.514063-1-tung.quang.nguyen@est.tech
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tipc/link.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/tipc/link.c b/net/tipc/link.c
index d0143823658d5..6c6d8546c5786 100644
--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -1068,6 +1068,7 @@ int tipc_link_xmit(struct tipc_link *l, struct sk_buff_head *list,
 	if (unlikely(l->backlog[imp].len >= l->backlog[imp].limit)) {
 		if (imp == TIPC_SYSTEM_IMPORTANCE) {
 			pr_warn("%s<%s>, link overflow", link_rst_msg, l->name);
+			__skb_queue_purge(list);
 			return -ENOBUFS;
 		}
 		rc = link_schedule_user(l, hdr);
-- 
2.39.5




