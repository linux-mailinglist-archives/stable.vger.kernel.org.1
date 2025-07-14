Return-Path: <stable+bounces-161876-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9162B045B1
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 18:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BAD71A62A4E
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 16:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7933265CA0;
	Mon, 14 Jul 2025 16:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWe8IheH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5A9266571;
	Mon, 14 Jul 2025 16:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752511328; cv=none; b=gaZnl1aHKzXWQTtK0CKEgBLM5NF3RMFxW+RdUd/hPEJ0x6/KA5qC+uqAbzyF2K0e57725sCQGn+lysANZeBR84LMl47pKXIXCwOVf9LEi+Otu33DCVH5CIkPC/H25IbNmw1Pz1FEKs8C9yG9DpvHYU10H8lCdohp0iB0TpHGROg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752511328; c=relaxed/simple;
	bh=1N7+GeRvg3UlhrQNvi0MzXHzXlGklkvNQD2n2ZPlph0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ik0bUBHDNR4KJR4vVLYmL7wNO71K2czqRjbqhHCQ0D7WG0aaro/w8YToQQzCl7wMWXLuXL7R9+Bo8dlz7ZkMGppVN6Hs8Ej+fNKwGvEKxXZufxb4DjlGC8ErGJqZBZoHWNge4BTas4/5bbgf28QHNY5LGjZGfBmEeEJnAFXHuIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pWe8IheH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21763C4CEED;
	Mon, 14 Jul 2025 16:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752511328;
	bh=1N7+GeRvg3UlhrQNvi0MzXHzXlGklkvNQD2n2ZPlph0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pWe8IheHYI0DOKkc6IvgLlhe0xFiK3bUyYa+43WIUQ89a/NR0SQkrtc3VOjv6IWAD
	 ibCIUX30Odfewdkm9HJJiXll0L+DqSFmyvFGt03L0qa1HOZVxoMy2keQD7BS0NNUeO
	 6uqo5bXsoW9pmt91VhogxjiCfbmfxmiOTFzPLLDLCvAqFM6Zm5jOYpGM60yEeT8eM/
	 fqoUcZb+zvShhRMO6clllWcD3/ycL1+1LQkendAecvDj1CAV9kbe1LqoTsfH9lSP+d
	 HobSkNHGjYtiRUPC8bDptauPUCm2tG+RwIj87azWMn/GopRA2wZ4FwzzEdN3jZ9QH2
	 XQrHcTQfEj4MA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 14 Jul 2025 18:41:46 +0200
Subject: [PATCH net 3/3] mptcp: reset fallback status gracefully at
 disconnect() time
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-net-mptcp-fallback-races-v1-3-391aff963322@kernel.org>
References: <20250714-net-mptcp-fallback-races-v1-0-391aff963322@kernel.org>
In-Reply-To: <20250714-net-mptcp-fallback-races-v1-0-391aff963322@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1498; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=gfDHvhkpq8awEepc0HtZrNS8nkt/GbmvMC5YwhaAY2I=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJKjUNNt1vzCmyOOG/gm3qv/POWFp+o3uyDydIKLRxC7
 TZlk1w6SlkYxLgYZMUUWaTbIvNnPq/iLfHys4CZw8oEMoSBi1MAJjJ1L8P/RNtv0/58nJMsWvSO
 S8noSHyQ4gy1ilLdiJVfXV8fbrbkYGTYL1rs1a3lVaGnV6kpfcU+xsalbflMS0/HnJlapuF9tTw A
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

mptcp_disconnect() clears the fallback bit unconditionally, without
touching the associated flags.

The bit clear is safe, as no fallback operation can race with that --
all subflow are already in TCP_CLOSE status thanks to the previous
FASTCLOSE -- but we need to consistently reset all the fallback related
status.

Also acquire the relevant lock, to avoid fouling static analyzers.

Fixes: b29fcfb54cd7 ("mptcp: full disconnect implementation")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index bf92cee9b5cee39e2b0831b6f7e06ce013fb6913..6a817a13b1549c3397e8fa2e315448ce2770e195 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3142,7 +3142,16 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	 * subflow
 	 */
 	mptcp_destroy_common(msk, MPTCP_CF_FASTCLOSE);
+
+	/* The first subflow is already in TCP_CLOSE status, the following
+	 * can't overlap with a fallback anymore
+	 */
+	spin_lock_bh(&msk->fallback_lock);
+	msk->allow_subflows = true;
+	msk->allow_infinite_fallback = true;
 	WRITE_ONCE(msk->flags, 0);
+	spin_unlock_bh(&msk->fallback_lock);
+
 	msk->cb_flags = 0;
 	msk->recovery = false;
 	WRITE_ONCE(msk->can_ack, false);

-- 
2.48.1


