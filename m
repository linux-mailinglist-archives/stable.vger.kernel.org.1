Return-Path: <stable+bounces-3989-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 113AE804588
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE45B1F213AD
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBF6611E;
	Tue,  5 Dec 2023 03:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LGKUNDqN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1D26AA0;
	Tue,  5 Dec 2023 03:18:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30529C433C8;
	Tue,  5 Dec 2023 03:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701746312;
	bh=U02+spzQUIFtKekhsg6GhsQArr4AOkkjk743FEOXI0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LGKUNDqNFyAaXyy1H9DcJoe9tyxewrAZ5qSI2SgpoExRyqCXZCAnR0yiTyhoXwBTr
	 f2kIR7kAvzDEJlaf0WJYoXP2Z4KS4RsETXHpTXtSbIiZe/+yPznKUREJJ0IXakWsOs
	 uxQBZXCTem/nVYVHHBIsMIpzI7u2uaynpT/Kx3RA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Kunwu Chan <chentao@kylinos.cn>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 05/30] ipv4: Correct/silence an endian warning in __ip_do_redirect
Date: Tue,  5 Dec 2023 12:16:12 +0900
Message-ID: <20231205031511.809764378@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031511.476698159@linuxfoundation.org>
References: <20231205031511.476698159@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kunwu Chan <chentao@kylinos.cn>

[ Upstream commit c0e2926266af3b5acf28df0a8fc6e4d90effe0bb ]

net/ipv4/route.c:783:46: warning: incorrect type in argument 2 (different base types)
net/ipv4/route.c:783:46:    expected unsigned int [usertype] key
net/ipv4/route.c:783:46:    got restricted __be32 [usertype] new_gw

Fixes: 969447f226b4 ("ipv4: use new_gw for redirect neigh lookup")
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Link: https://lore.kernel.org/r/20231119141759.420477-1-chentao@kylinos.cn
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 4a6f4ef369d05..239b54c03a657 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -806,7 +806,7 @@ static void __ip_do_redirect(struct rtable *rt, struct sk_buff *skb, struct flow
 			goto reject_redirect;
 	}
 
-	n = __ipv4_neigh_lookup(rt->dst.dev, new_gw);
+	n = __ipv4_neigh_lookup(rt->dst.dev, (__force u32)new_gw);
 	if (!n)
 		n = neigh_create(&arp_tbl, &new_gw, rt->dst.dev);
 	if (!IS_ERR(n)) {
-- 
2.42.0




