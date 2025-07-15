Return-Path: <stable+bounces-162739-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9211B05F45
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 16:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95D347BA28B
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAC32E9EA3;
	Tue, 15 Jul 2025 13:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ESpert7f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB6D1A5B9D;
	Tue, 15 Jul 2025 13:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587350; cv=none; b=RiZzMv7em9BVji0L3zastS8PdtPonOJPy4Grtuxr4BW+JJDdERzPM+xYh17NfkiBdeSEZz8bk76NeQF3Kn5hF+FABNUdet4GrMTAnOhFrlB5TfNvq0ssMFp28/1stajr1uLu4jl6dWhbbe2PkODIZxKQei/sQmvIgLHRzsnzcUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587350; c=relaxed/simple;
	bh=qEbZhlCvYbtYpWBSWgU+lrTJil4vaIgzIO+Dt+unE04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vz8WM36v5hxwVU/2USXPwgIeZ1PeJXDiqm6uweLfFYmJ05aZ7jAN0Il+8gDLtfeMW6YMW+XuXACbymstSwjC9FZa44U7hp2ytaRrJulj5d6g8QW3tquRfFpcGbsD7DF4fXXleLXZBGUU6cl9yz6uTY76ek3skTKyG3pegNDEdO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ESpert7f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA59C4CEE3;
	Tue, 15 Jul 2025 13:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752587350;
	bh=qEbZhlCvYbtYpWBSWgU+lrTJil4vaIgzIO+Dt+unE04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ESpert7f5HutJxjl6P2t4JCRfRPgnb3nc1WakjrbXY6x4v9JASfiMCt5ZWLQPmCk0
	 xM6aA+1ZMG+rfay4nVgL3y0rt8gnpL04MT704kaaUy/OpWWpb8AM9m56YUugg86jLT
	 FcHBk/CXxLBqNCK+D19mIlt7mGvcwe9rTRSmiUiI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kito Xu <veritas501@foxmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 66/88] net: appletalk: Fix device refcount leak in atrtr_create()
Date: Tue, 15 Jul 2025 15:14:42 +0200
Message-ID: <20250715130757.221080257@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130754.497128560@linuxfoundation.org>
References: <20250715130754.497128560@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kito Xu <veritas501@foxmail.com>

[ Upstream commit 711c80f7d8b163d3ecd463cd96f07230f488e750 ]

When updating an existing route entry in atrtr_create(), the old device
reference was not being released before assigning the new device,
leading to a device refcount leak. Fix this by calling dev_put() to
release the old device reference before holding the new one.

Fixes: c7f905f0f6d4 ("[ATALK]: Add missing dev_hold() to atrtr_create().")
Signed-off-by: Kito Xu <veritas501@foxmail.com>
Link: https://patch.msgid.link/tencent_E1A26771CDAB389A0396D1681A90A49E5D09@qq.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/appletalk/ddp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c
index f67f14db16334..5c9a9652449d8 100644
--- a/net/appletalk/ddp.c
+++ b/net/appletalk/ddp.c
@@ -563,6 +563,7 @@ static int atrtr_create(struct rtentry *r, struct net_device *devhint)
 
 	/* Fill in the routing entry */
 	rt->target  = ta->sat_addr;
+	dev_put(rt->dev); /* Release old device */
 	dev_hold(devhint);
 	rt->dev     = devhint;
 	rt->flags   = r->rt_flags;
-- 
2.39.5




