Return-Path: <stable+bounces-138197-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 714AAAA16F3
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4160A4A630C
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326A32528E8;
	Tue, 29 Apr 2025 17:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZFqBwJ8a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E315E227E95;
	Tue, 29 Apr 2025 17:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745948477; cv=none; b=AwMtg9Cte4tiLesp1StRO2GVV2+vlsABw9vVGP3o8bnAYSmk97a/D8jROWlbhWgSBXFTc5Be4A2UZSJ671j4IDmL6814Pvgk04LrQ2wQLYXMuRDuK3pfMWoPWYONZuhxPLfc2cSMBQvmSX/ZEFOVIXfD6mapXP067PayN3GsRnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745948477; c=relaxed/simple;
	bh=aKfVxZL0hDjm087cwTLJsn8tKCoVn9XoHt7jcJ1pAnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rb0to6HOAKHKC99Rz9+zSHH3/aTexftGJnw35l8z6xtU3MudypErrQVWtEPLAkQLlRudRz//6SohkacKTtY1Ti7R1mj3h3TerPVQAd+60fBEXK7mBnQ21NJnqnGGo35cp74Y+TwGIpLNVFoplIskjPTtIlV+Uj6TSXw1vz0FzYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZFqBwJ8a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F6FC4CEE3;
	Tue, 29 Apr 2025 17:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745948476;
	bh=aKfVxZL0hDjm087cwTLJsn8tKCoVn9XoHt7jcJ1pAnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZFqBwJ8ay6EZEoScFNcd/YGlFbpWgRQJUM7IqSa/C/TZF/SI0GHGpE+PLV8qXg1ev
	 gWd557cgzhavzbPqp42SpVQZeRlj9laTKQzS2ClxoA3CO6ZPOFE/SZEJwAXRwoAMki
	 2Odzjzrg1fQpWkkeLwCBryZ/AhUs0M+kwX/5ST2g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tung Nguyen <tung.quang.nguyen@est.tech>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 002/373] tipc: fix memory leak in tipc_link_xmit
Date: Tue, 29 Apr 2025 18:37:59 +0200
Message-ID: <20250429161123.228252708@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161123.119104857@linuxfoundation.org>
References: <20250429161123.119104857@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index d13a85b9cdb2d..b098b74516d16 100644
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




