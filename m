Return-Path: <stable+bounces-140381-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 251C9AAA818
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D924C1883627
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CF0346EA9;
	Mon,  5 May 2025 22:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCBInygN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D722957C5;
	Mon,  5 May 2025 22:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484732; cv=none; b=cb+T3Ti+ecz4stwl8g8Xm4R8sY3oE3DMM06XkqnEBL9Gob1BauGrENzDf8Jltpa5ZOnFLdh1zCPGgCdnw9ZVH9V+xYZqgNBXZPSzHMEFHiCIK39mpv+sxVNw26Yngeg1B0yBmp8AW7Aq/VuqyG4YlYIFckh7YuYB9OpHJ3d8VfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484732; c=relaxed/simple;
	bh=z65+LRzHh/2gE62xUs/hX7uhqQuSK505LPQ3HD6jUQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CQCInM52u7ZVGvV8DU4hmlorM1spkpB4QyAgFyx5GbdPPaIZTc7PaWDJ1hHxih/xLBQXNzwJtMyfQJdQkaSTX/awPu941EhqNyyGVPjQqOMPhXuV9ar9lLXyYrCZcbJcBLQiz6+8fn7qdpFEa7n+ypg8/UQjx54hXWexXd8Lts0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCBInygN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 632DEC4CEF2;
	Mon,  5 May 2025 22:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484731;
	bh=z65+LRzHh/2gE62xUs/hX7uhqQuSK505LPQ3HD6jUQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CCBInygNsrHowJpI6Kc/Y30kWJdawW0VLEZhrysFbzTh5l4LI66uiGj0hCnbZkon/
	 zD3CaU25CbFVkoNa+UkDjExEo6RkZJ/yddZhSZ1olPfdPMFJ6ij5c2syb50C9bf/8/
	 xeCMXcZ31Sy0TeA5UPIBvLxdcihHgeo57RboRl8/IbMC2N9I8+7IHffsfc1jlmzaCK
	 5LibG6KkgM9eMgTZ3Auo2+0SeCR90xAMHAmFOe1Bu92ljwNBloRT12xFyWFB6YEUNQ
	 ZuOX6m+CN53GBZg7BaGn26E1YRw6xzOitlHDpMeI/Dkh4ZvwEPz9KJJRLy+eCbV2MO
	 jpJk3/zcHqzAA==
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
Subject: [PATCH AUTOSEL 6.14 632/642] ipv6: remove leftover ip6 cookie initializer
Date: Mon,  5 May 2025 18:14:08 -0400
Message-Id: <20250505221419.2672473-632-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

[ Upstream commit 54580ccdd8a9c6821fd6f72171d435480867e4c3 ]

As of the blamed commit ipc6.dontfrag is always initialized at the
start of udpv6_sendmsg, by ipcm6_init_sk, to either 0 or 1.

Later checks against -1 are no longer needed and the branches are now
dead code.

The blamed commit had removed those branches. But I had overlooked
this one case.

UDP has both a lockless fast path and a slower path for corked
requests. This branch remained in the fast path.

Fixes: 096208592b09 ("ipv6: replace ipcm6_init calls with ipcm6_init_sk")
Signed-off-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20250307033620.411611-2-willemdebruijn.kernel@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/ip6_output.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index eb636bec89796..581bc62890818 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -2055,8 +2055,6 @@ struct sk_buff *ip6_make_skb(struct sock *sk,
 		ip6_cork_release(cork, &v6_cork);
 		return ERR_PTR(err);
 	}
-	if (ipc6->dontfrag < 0)
-		ipc6->dontfrag = inet6_test_bit(DONTFRAG, sk);
 
 	err = __ip6_append_data(sk, &queue, cork, &v6_cork,
 				&current->task_frag, getfrag, from,
-- 
2.39.5


