Return-Path: <stable+bounces-83956-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 975D499CD57
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 16:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AF95283225
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 14:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED9724B34;
	Mon, 14 Oct 2024 14:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HMJ0Sldy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D430610B;
	Mon, 14 Oct 2024 14:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728916313; cv=none; b=nrgy+PQWTw1X1jm6Ux4L9hRpQ2pWBxBVmSyldt79wfJcJ+WYvtGCbnsFCPNtLGHF72sKF9ad5UDyrIEsmg1KG9UKe5ju1qx79qbFwswHSugqc2TKFlrKRBpG878EwFHlnJhaUc/wygC+n3ZuSMK35YS9qnMAyObs2Hq6GizzW/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728916313; c=relaxed/simple;
	bh=fTgIZz8/tOaINbyvRH1a6NuUREqFdUZSIxTHtpxguUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jG6eNXo+xXeOfEg11DlUJzCI+y/CERwTWeOi71FnMlDo917iPRuuXq6obNhv3oqVDJnaihLBoOUx8QF6Mvw6LyvFDJP5j1ENpQ0e4tZJ21tmwKTXDwpEzBJaReIf2U8utNyBSsLzC5xviyqi3SQoDkAGiRLYucjqet/1KXvt+AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HMJ0Sldy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1295BC4CED0;
	Mon, 14 Oct 2024 14:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728916313;
	bh=fTgIZz8/tOaINbyvRH1a6NuUREqFdUZSIxTHtpxguUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HMJ0SldymcKeDDJWr6U6QKP/l8brC/71Jbg4by6lElWT1X06kz+XJqUiH5nIO/PzP
	 DkmBWZcMwpRP2z3pJcKhFXzu2GFRQuT/ZKx6iiUAY84QdCnF6h6fIMDFkQIJBQ4Ed+
	 RpmTfDsfe2PaEVeWSky8W8gZhf5iAWbdkhKm3HnU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	=?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <courmisch@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 146/214] phonet: Handle error of rtnl_register_module().
Date: Mon, 14 Oct 2024 16:20:09 +0200
Message-ID: <20241014141050.684530744@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141044.974962104@linuxfoundation.org>
References: <20241014141044.974962104@linuxfoundation.org>
User-Agent: quilt/0.67
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit b5e837c86041bef60f36cf9f20a641a30764379a ]

Before commit addf9b90de22 ("net: rtnetlink: use rcu to free rtnl
message handlers"), once the first rtnl_register_module() allocated
rtnl_msg_handlers[PF_PHONET], the following calls never failed.

However, after the commit, rtnl_register_module() could fail silently
to allocate rtnl_msg_handlers[PF_PHONET][msgtype] and requires error
handling for each call.

Handling the error allows users to view a module as an all-or-nothing
thing in terms of the rtnetlink functionality.  This prevents syzkaller
from reporting spurious errors from its tests, where OOM often occurs
and module is automatically loaded.

Let's use rtnl_register_many() to handle the errors easily.

Fixes: addf9b90de22 ("net: rtnetlink: use rcu to free rtnl message handlers")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Acked-by: Rémi Denis-Courmont <courmisch@gmail.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/phonet/pn_netlink.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/net/phonet/pn_netlink.c b/net/phonet/pn_netlink.c
index 7008d402499d5..894e5c72d6bff 100644
--- a/net/phonet/pn_netlink.c
+++ b/net/phonet/pn_netlink.c
@@ -285,23 +285,17 @@ static int route_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 	return err;
 }
 
+static const struct rtnl_msg_handler phonet_rtnl_msg_handlers[] __initdata_or_module = {
+	{THIS_MODULE, PF_PHONET, RTM_NEWADDR, addr_doit, NULL, 0},
+	{THIS_MODULE, PF_PHONET, RTM_DELADDR, addr_doit, NULL, 0},
+	{THIS_MODULE, PF_PHONET, RTM_GETADDR, NULL, getaddr_dumpit, 0},
+	{THIS_MODULE, PF_PHONET, RTM_NEWROUTE, route_doit, NULL, 0},
+	{THIS_MODULE, PF_PHONET, RTM_DELROUTE, route_doit, NULL, 0},
+	{THIS_MODULE, PF_PHONET, RTM_GETROUTE, NULL, route_dumpit,
+	 RTNL_FLAG_DUMP_UNLOCKED},
+};
+
 int __init phonet_netlink_register(void)
 {
-	int err = rtnl_register_module(THIS_MODULE, PF_PHONET, RTM_NEWADDR,
-				       addr_doit, NULL, 0);
-	if (err)
-		return err;
-
-	/* Further rtnl_register_module() cannot fail */
-	rtnl_register_module(THIS_MODULE, PF_PHONET, RTM_DELADDR,
-			     addr_doit, NULL, 0);
-	rtnl_register_module(THIS_MODULE, PF_PHONET, RTM_GETADDR,
-			     NULL, getaddr_dumpit, 0);
-	rtnl_register_module(THIS_MODULE, PF_PHONET, RTM_NEWROUTE,
-			     route_doit, NULL, 0);
-	rtnl_register_module(THIS_MODULE, PF_PHONET, RTM_DELROUTE,
-			     route_doit, NULL, 0);
-	rtnl_register_module(THIS_MODULE, PF_PHONET, RTM_GETROUTE,
-			     NULL, route_dumpit, RTNL_FLAG_DUMP_UNLOCKED);
-	return 0;
+	return rtnl_register_many(phonet_rtnl_msg_handlers);
 }
-- 
2.43.0




