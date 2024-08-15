Return-Path: <stable+bounces-67865-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D721F952F75
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 15:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34B84B243D8
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 13:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E887D19E825;
	Thu, 15 Aug 2024 13:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ynrfntop"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69ED19FA93;
	Thu, 15 Aug 2024 13:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723728765; cv=none; b=FVFepwEChGQihnWMUlZPenb1Utr2HUAKLeAJ+YkBs0FQpXGylps1AMQrKC5eurFW3h/aiDfIGEAxQC4X224qrweq5j+ScVNl5ln7L/DE/Zs7gdXV1gZob1Nz2WRCI2J+/0VDu/u0h6ZDYjPJ5oieQ1ZqV26eEbClFwR6D8Ouas8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723728765; c=relaxed/simple;
	bh=Z55djPb7pFvSNNY7rv7rWqjBGU0VXtR35y/99bQGP3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B/ysRWNQZzPnTyllFefwXEEBIY8VLMNyxy7ebdT7CjY7XP46J5I2888GUi9fLvWjZQeFz98RbwrKxIQMhMYytnhp0N+7lkIeFFHotbotcXjau3MsYs88R+vTrE887zBTPXvo5Qp6fj9eJ6+yKbF4U5gAhX6q8LNTtfGYy+Kambc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ynrfntop; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22CD0C4AF0D;
	Thu, 15 Aug 2024 13:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723728765;
	bh=Z55djPb7pFvSNNY7rv7rWqjBGU0VXtR35y/99bQGP3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YnrfntopPcHp3PGaNBuOoHXzdaQigh+PC8yTJbMLR1GXqlQbnYySTwIfvHlaPKQjs
	 G6xoPfi01efwemu5HyaXuLNtFwI5ObTbECVC3wtStPKX7K0O+T7qtzua6qKg++hpDN
	 nH+jk3pN7MxuHdqHpS4OlaikBMZ5ilYtD5LvVOD8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ido Schimmel <idosch@nvidia.com>,
	Guillaume Nault <gnault@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 102/196] ipv4: Fix incorrect source address in Record Route option
Date: Thu, 15 Aug 2024 15:23:39 +0200
Message-ID: <20240815131855.986342756@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131852.063866671@linuxfoundation.org>
References: <20240815131852.063866671@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ido Schimmel <idosch@nvidia.com>

[ Upstream commit cc73bbab4b1fb8a4f53a24645871dafa5f81266a ]

The Record Route IP option records the addresses of the routers that
routed the packet. In the case of forwarded packets, the kernel performs
a route lookup via fib_lookup() and fills in the preferred source
address of the matched route.

The lookup is performed with the DS field of the forwarded packet, but
using the RT_TOS() macro which only masks one of the two ECN bits. If
the packet is ECT(0) or CE, the matched route might be different than
the route via which the packet was forwarded as the input path masks
both of the ECN bits, resulting in the wrong address being filled in the
Record Route option.

Fix by masking both of the ECN bits.

Fixes: 8e36360ae876 ("ipv4: Remove route key identity dependencies in ip_rt_get_source().")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Guillaume Nault <gnault@redhat.com>
Link: https://patch.msgid.link/20240718123407.434778-1-idosch@nvidia.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 1aac0d77a3aa1..437960825ec2f 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1277,7 +1277,7 @@ void ip_rt_get_source(u8 *addr, struct sk_buff *skb, struct rtable *rt)
 		struct flowi4 fl4 = {
 			.daddr = iph->daddr,
 			.saddr = iph->saddr,
-			.flowi4_tos = RT_TOS(iph->tos),
+			.flowi4_tos = iph->tos & IPTOS_RT_MASK,
 			.flowi4_oif = rt->dst.dev->ifindex,
 			.flowi4_iif = skb->dev->ifindex,
 			.flowi4_mark = skb->mark,
-- 
2.43.0




