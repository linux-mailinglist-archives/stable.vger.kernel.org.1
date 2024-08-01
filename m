Return-Path: <stable+bounces-65002-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12441943D6E
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0555285677
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BAE16EB5A;
	Thu,  1 Aug 2024 00:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/yBui5c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E6616EB4F;
	Thu,  1 Aug 2024 00:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471905; cv=none; b=KYhit5yBRmK7x2fiAQJW3FX7V6DK8JJJgTLy6AiPQBXeDSabLHPq/KbiUZNy1YgJFvwbd0eOU4IRIA02CAaeSlolJuAKY1/CmIA7CouxTKv5dKaFYzCTzH3/PMup+N7yDiyGneUrbMVLIEumV2yAprchYUZ1it5zzN223BYW20M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471905; c=relaxed/simple;
	bh=+QpAmqjnYOgWFxa6jUpWMMf8hr+bwACzF5SP7F0f/fQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZO/9ZzyzhcMQRZK+T+bHFwvCMwSeIBEk3Qh5LeXvnSuHlaHGt2YBOq0ed/durw46NhQywxJGvD/7NxqKmVxegJq89JFzIPDlfeWZlKHfRiowKaeY7a+qvhuaeUAHFvRK8oWS/9m0dRrBGoZgT8+dyfPz6M41ylS/G2r7d/x29SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/yBui5c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFFC9C4AF0C;
	Thu,  1 Aug 2024 00:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471905;
	bh=+QpAmqjnYOgWFxa6jUpWMMf8hr+bwACzF5SP7F0f/fQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q/yBui5cLNS5dnR523UYBoHbybcWN+6eK9qQmrEfnBO/gmG5ixZSDwtUJpbyk7+wW
	 iVH584bAMoT8NeL0PQRZ7oi2FVRTFEUQlYUF35D8Q3vGWn7Y/pGFmJ7GSsI6NvbEXe
	 i4qkZJlziSxk2WW37o+t83qU2o4zD+ZxakvSJE8/JXvUHpjpwturqTwkq13QiO6aXg
	 jpKw7KvLbg267lLAKaAEZ9i60BxiAQpm2LmbkicC76YY+IIiz8afM4BXUymdSGbfQ8
	 b6EMcBeQKtGWU5j7IcnBxtK729jZcH6jCsklHfjIvoc9fH172EFr5xp/DoVkMtvqjl
	 vvpBCWIPIZChQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	dsahern@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 56/83] fou: remove warn in gue_gro_receive on unsupported protocol
Date: Wed, 31 Jul 2024 20:18:11 -0400
Message-ID: <20240801002107.3934037-56-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002107.3934037-1-sashal@kernel.org>
References: <20240801002107.3934037-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

[ Upstream commit dd89a81d850fa9a65f67b4527c0e420d15bf836c ]

Drop the WARN_ON_ONCE inn gue_gro_receive if the encapsulated type is
not known or does not have a GRO handler.

Such a packet is easily constructed. Syzbot generates them and sets
off this warning.

Remove the warning as it is expected and not actionable.

The warning was previously reduced from WARN_ON to WARN_ON_ONCE in
commit 270136613bf7 ("fou: Do WARN_ON_ONCE in gue_gro_receive for bad
proto callbacks").

Signed-off-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20240614122552.1649044-1-willemdebruijn.kernel@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/fou_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/fou_core.c b/net/ipv4/fou_core.c
index 0c41076e31eda..b38b82ae903de 100644
--- a/net/ipv4/fou_core.c
+++ b/net/ipv4/fou_core.c
@@ -433,7 +433,7 @@ static struct sk_buff *gue_gro_receive(struct sock *sk,
 
 	offloads = NAPI_GRO_CB(skb)->is_ipv6 ? inet6_offloads : inet_offloads;
 	ops = rcu_dereference(offloads[proto]);
-	if (WARN_ON_ONCE(!ops || !ops->callbacks.gro_receive))
+	if (!ops || !ops->callbacks.gro_receive)
 		goto out;
 
 	pp = call_gro_receive(ops->callbacks.gro_receive, head, skb);
-- 
2.43.0


