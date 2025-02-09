Return-Path: <stable+bounces-114461-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 500F2A2DFA5
	for <lists+stable@lfdr.de>; Sun,  9 Feb 2025 18:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37C6C3A1AAC
	for <lists+stable@lfdr.de>; Sun,  9 Feb 2025 17:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4C21DFD8C;
	Sun,  9 Feb 2025 17:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhK3oAt9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EFB1D934D;
	Sun,  9 Feb 2025 17:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739123712; cv=none; b=adzsAelz8uAZxMqN1zpE0wyWbSTurctq+74R7a4WlWjNKq6j7qO9QKESzv/Ycn3CzxK7gNLgc82PDh5p/GLgzDS1MYpWT3RMsUT9cueJKX7Zl0/YkxhJtdxN6PdgzvNNDNoGKJ7X2EZNrAzfkOeXxUQtSAdgr3vLX01iQFw+gKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739123712; c=relaxed/simple;
	bh=VKkgpE1ckVxffCK3SGKfm31z78bRnpKGHB1DNkAE+pk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RlVeDVwBB5ZfTgAsQp3uM+XGRsmzMuCgryLHAtWjzZ622txITdrgVf0HRkrnXS9eUq7tQBF+MpaYNannD+NGFOpmD6t2pdsygFoP4WP+LAYkvXA7fuKbcjZ8KseM4ylhwaBADdn3B8jpR1yDdFHV60nsnOYQDYR9OqPnaWcRNQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhK3oAt9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C53CC4CEDD;
	Sun,  9 Feb 2025 17:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739123712;
	bh=VKkgpE1ckVxffCK3SGKfm31z78bRnpKGHB1DNkAE+pk=;
	h=From:To:Cc:Subject:Date:From;
	b=fhK3oAt9Mib6cHmTtYIdRqgE5ZYbitVItF62mSEGnQ+nAiROwxcVe9iduIv/wik8i
	 5Ah97mu9A1bjAUtEchomzSLs1bYbSvdoXFmBFMO6Lu68KXEz64tSDIwVONtJYvrPCr
	 +5gtN+f2pg/HdawUk0ssFzjwtf7JqsRwlZv0iDXV+D6C9OpYApNfAjPNk86MoJkGWN
	 33mhgLydor1thmzRJkj/dN1tUO3Llf6RqVJVTf8Rr/8bqWRWLIMQYybqhrJgpj7iHT
	 2tqZLApLkZdBDtrxuEe4ekhAkiDrOpMaQExIs8WN6ugc8BxUZGQPi+0d27Fq6jqBSR
	 L6XWNeTDscY+w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: sashal@kernel.org,
	MPTCP Upstream <mptcp@lists.linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15.y] mptcp: prevent excessive coalescing on receive
Date: Sun,  9 Feb 2025 18:55:05 +0100
Message-ID: <20250209175504.3405385-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1472; i=matttbe@kernel.org; h=from:subject; bh=8cp6QKlSyOtDX6v4zGEeoGyzl3mMEuUDCopn5jMee0I=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnqOv4770LDGdBZB399WVMHnfl1+nHJrnLlev6q JjE5NUO59SJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ6jr+AAKCRD2t4JPQmmg c8QeD/9ZSsoYB5z0LRs7FoYiToQV9ziNKsDkK9QU5ZLCHubv3HlL3f01/wuQYWQuPFQ0PS0wc/1 414UWhsbFWyk1MyqEBWPA3DV5fsx/VGZNiRfA1JxiRynfVL/S3XbJpYOuACTIozzk442h5/Et9s Hc/w0NVt63oRb6nUxjY3Ux5D/FDFVPHjlFe05GxLHpehvsKx5/X0S0JJwzQ4j/hm8wqQB9kfxsN QT+cVf14wswBcFA8kqCqFlPOJW5U4KawejMta6o7Bdp7Y3tlipEr4m1EiScdEhlz2HuZM0gat+K cI3aWEsGyVbYxGY6bpo7Z11SMOqgB0gBmGJT5n6lpigCt+COvbLHe+IWpkckxDjkIFNGdVLWN9X 81tyvmEvQMamY37HHC8ZcFmechcxkLALBi2/e2SXlrT9p6RouvwHsp7O3YNW80vyyWucNjIHml6 TWoSoJhwd52wwBZGg2aA4Sqy1aqTEt2Vgl6xEGXPhc3E3eyDGz8H8BAIGC7e9IRzCzSztRpEPnd TD3Y6RAoqHiqYSGGBBE2j3mCTqglfTcX5aN4t4Q/lczmMpEEzUpzIPasrENFQsHXtmHS1G7vzXB Od8BrFaaSQBFt+6objsg6+M3dLHXLZ84ULw+EaKBMqBdfyHkZeGqeDoVyWMTvVh8mgenbUsvLVa jNCo97P0VWU3v3A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

commit 56b824eb49d6258aa0bad09a406ceac3f643cdae upstream.

Currently the skb size after coalescing is only limited by the skb
layout (the skb must not carry frag_list). A single coalesced skb
covering several MSS can potentially fill completely the receive
buffer. In such a case, the snd win will zero until the receive buffer
will be empty again, affecting tput badly.

Fixes: 8268ed4c9d19 ("mptcp: introduce and use mptcp_try_coalesce()")
Cc: stable@vger.kernel.org # please delay 2 weeks after 6.13-final release
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20241230-net-mptcp-rbuf-fixes-v1-3-8608af434ceb@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - We asked to delay the patch. There were no conflicts.
---
 net/mptcp/protocol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f337dd3323a0..c6a11d6df516 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -133,6 +133,7 @@ static bool mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
 	int delta;
 
 	if (MPTCP_SKB_CB(from)->offset ||
+	    ((to->len + from->len) > (sk->sk_rcvbuf >> 3)) ||
 	    !skb_try_coalesce(to, from, &fragstolen, &delta))
 		return false;
 
-- 
2.47.1


