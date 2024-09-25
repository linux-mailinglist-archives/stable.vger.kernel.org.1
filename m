Return-Path: <stable+bounces-77576-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF1E985EBB
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E4AA1F2522D
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7911D0B84;
	Wed, 25 Sep 2024 12:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPITD/sp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA9818E764;
	Wed, 25 Sep 2024 12:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266363; cv=none; b=lxXtXlhtguRHUr/oxsvxIyLcxG/7xAfh9s9CGPuk/hfT/Wg+r2wmOJbKvQ83i5rStP0NzHm/QEyILVs3dIWHJuFUQOj1amBYduWBz2S9kQy+nIwrJKmH5MScX96GjkSsaClmqExzIKxpqZBFzGO1k6LeuT9cKgB2JTpmnBijjB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266363; c=relaxed/simple;
	bh=TTbWIZdXyMpVuDN8EeQgVRhdDYyXSiHziBvITL0YI6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dsbLvS4/63NGRtKRWEYF2uwYaX6SK1uAHqAiNjTCjZypClusbW8p6+Wy9AsmkcCUUtT6veMD9CFVUQyev/zmBFUpsspZXkt3w5kMKwyKEbS9etYn7kWhYWYLYgq+hLK5D5vrdXUImLlvLqFIKzmNqTj5uSH4I+amTjoPklowQRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPITD/sp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56510C4CECD;
	Wed, 25 Sep 2024 12:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266363;
	bh=TTbWIZdXyMpVuDN8EeQgVRhdDYyXSiHziBvITL0YI6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SPITD/spOFFg8K9BL7N65wss4X8vMvyE6VhSkFaqFOPR9BrlgASLrwsL/ZS1lB4gc
	 PJqg4ZGVvVbHhy+wzh2xivc37j3XAV8taMcRf+LR20sWA8sOiw0CiQ9B0WY2m3kCjT
	 PEcARPpyOskDUbq16bEd03Yzj2HeyKcDeNJQhGldOu1s2ogbM5GI2c9bGHpqaqZEFT
	 oQLnAXDdp09qi/Lm0KdTi5EDfCLzK3stoY/6Ge0zU37VJkWepl68QPQAi6ZyuZeH53
	 fkCLd12cvv/YlQ2kRYc6Ofb9BMhhGY5JErSN0buMMCu/WjyIqD+fyrAf48KSBNouMC
	 PNzKGf7lSL/Zg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: James Chapman <jchapman@katalix.com>,
	Tom Parkin <tparkin@katalix.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 030/139] l2tp: don't use tunnel socket sk_user_data in ppp procfs output
Date: Wed, 25 Sep 2024 08:07:30 -0400
Message-ID: <20240925121137.1307574-30-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
Content-Transfer-Encoding: 8bit

From: James Chapman <jchapman@katalix.com>

[ Upstream commit eeb11209e000797d555aefd642e24ed6f4e70140 ]

l2tp's ppp procfs output can be used to show internal state of
pppol2tp. It includes a 'user-data-ok' field, which is derived from
the tunnel socket's sk_user_data being non-NULL. Use tunnel->sock
being non-NULL to indicate this instead.

Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: Tom Parkin <tparkin@katalix.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/l2tp/l2tp_ppp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index 6146e4e67bbb5..6ab8c47487161 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -1511,7 +1511,7 @@ static void pppol2tp_seq_tunnel_show(struct seq_file *m, void *v)
 
 	seq_printf(m, "\nTUNNEL '%s', %c %d\n",
 		   tunnel->name,
-		   (tunnel == tunnel->sock->sk_user_data) ? 'Y' : 'N',
+		   tunnel->sock ? 'Y' : 'N',
 		   refcount_read(&tunnel->ref_count) - 1);
 	seq_printf(m, " %08x %ld/%ld/%ld %ld/%ld/%ld\n",
 		   0,
-- 
2.43.0


