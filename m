Return-Path: <stable+bounces-64908-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6A6943C2C
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19E651C21E89
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E9C1A6190;
	Thu,  1 Aug 2024 00:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efOXdpyL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA7A1A617F;
	Thu,  1 Aug 2024 00:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471391; cv=none; b=Thr+h9WyFhRiGE4egIuG+xdAwNCjy/wrFBtCh4slsTxEIsYxk/D6vhkSHXhrrkD0tiagbwJT5nnGbHPVgfNe7wL7DQnziM8gIp5GmDryh74+Ayt5dZsKrZ9OOupFBYyNZsqWDZAMcuAOKHTGYtUzPgaicdYGn+UUwLCROv7gdVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471391; c=relaxed/simple;
	bh=fdDOn9fVjJxvncH7SW1w2kwiQySWVycnUyWbBu65FOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hu5yK3w67k3J9LeOaYbgRRsG7bqQxpRbBPuTOzxBmUwPW2zX9D+U7T88iwgBN22LrNOVazDcThgEyr2PGu3/bW8p8v5Gs3l+CnKujlY3YNdtqM8K6L01OB8eZH9TQOqFf4GSmdSuGRoyL64sNlmJa+xjHrSZ+7FzngZX0JU+u9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efOXdpyL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF749C116B1;
	Thu,  1 Aug 2024 00:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471391;
	bh=fdDOn9fVjJxvncH7SW1w2kwiQySWVycnUyWbBu65FOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=efOXdpyLePZ99YthJetslegM4pbW4itsJ91K5jACOxgha3EiMD7gPCDe2azfaNGdd
	 pMkiizYeI3c7nKbY6ICF/Wk1fJorMcp320ocKU4VihheJ1L1Igdmr0I3PmItWP8IMu
	 Z/nxLDScLf1lF05cmPu2SbNv3v+9ey/5JaMFP0W+VIXqvTI3F0N2z0OWi/eRSIOzcW
	 FRHkUTImIVG+PK14Iv7V7eSZJmmRYxO7FhDjSO+K+BwZc1ruv4nrQCKnT6xKiezpay
	 SpeFUQoulUpT8saiBzfrz+mTQQt2zS4GO5vyOTLoNlw8M13ymdDbdWek6OPrSNtTBz
	 DsunxuYqHv+2g==
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
Subject: [PATCH AUTOSEL 6.10 083/121] fou: remove warn in gue_gro_receive on unsupported protocol
Date: Wed, 31 Jul 2024 20:00:21 -0400
Message-ID: <20240801000834.3930818-83-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
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
index a8494f796dca3..0abbc413e0fe5 100644
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


