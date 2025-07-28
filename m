Return-Path: <stable+bounces-164938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D983DB13B83
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 15:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3559418840E8
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 13:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8DF26772C;
	Mon, 28 Jul 2025 13:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbc5giFt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B5E2673AF;
	Mon, 28 Jul 2025 13:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753709380; cv=none; b=ARRuOIMvJaGqXQ3pri7+QyGFucjfM6qvUe6J2u/wvq8J8QE6E54Pjp++q9PHtyKlZjhQtsRMlMx8EEHkdmtltk3zURWTWsYjrOABVGu+CdDqmvZg3f7m+MbwNb4dbDKoyGUkQ64YHQUBdF+oTfsPGKHwCuMdI4/iRAOrafqwHiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753709380; c=relaxed/simple;
	bh=GHVCaTB0Vx7iBMCo+RjSScymdZpOLghQGpFNn/Pt46E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YFsa5aroluZhwUFHLJhRdg2d/v+N5DYqf0BpbhJvj20nf95H1xulRrP1jykHjR38RSszoWsocSMTgfZj2wTCXWLT6W1htiRyRT9TmMZrlF5caAEfNpRdv01xyXy6nJ5lxBZZyBgrkyEFfx5JszgRUrQaOQnumq3FFR8wa6YoKao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbc5giFt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A04EC4CEFA;
	Mon, 28 Jul 2025 13:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753709378;
	bh=GHVCaTB0Vx7iBMCo+RjSScymdZpOLghQGpFNn/Pt46E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sbc5giFtceIV6RXojxPbYpQlFKOb6KxcS2Z7Tm0z/wDmesJ8YdUQZOeEGtVSBeG0x
	 g8xFvmoPgneOSwdcwEj5pQyA7wtfZkhVlxsxY5phuErqz4InPly++oxJyDp0mqJIvO
	 e/XZ2GY2TcVCLfhJmbL8jc30YZn3Uj45hC2W20HtWymrJ0YITzrUTFNZehvYbBrynY
	 58QirQMryBhtcydt+9852jwrqSr+DawthWFlNsdoxwVqT+inwnMSt/Pte0ohLllosn
	 ioY+ywT6mJNgqQ8h1/rEC8aA/k5aDMSFTKTWrOy8c51FWqcNh2fXVGAegzlFBA9gc0
	 4/00NRnlOzZ8Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	sashal@kernel.org,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y 3/3] mptcp: reset fallback status gracefully at disconnect() time
Date: Mon, 28 Jul 2025 15:29:23 +0200
Message-ID: <20250728132919.3904847-8-matttbe@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250728132919.3904847-5-matttbe@kernel.org>
References: <20250728132919.3904847-5-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1933; i=matttbe@kernel.org; h=from:subject; bh=5mHy2kyjr4LxJA17fPitqXM6r2+TskKQK8TH8Q+eVxU=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLaq01m/udd8myKhpaJTP6Jq5Mabpy0WbrseVufe1fT3 NtzipeYdJSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAExEOICRYe5j1ZCC6KvbpCQO Xfj4iNNyR1bxE+/ZazJfXlZxCkwxXcvwv1g61fSgTm5I/unHt/yeblZin7F1fadW8qIGrtV6B75 O4wQA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

commit da9b2fc7b73d147d88abe1922de5ab72d72d7756 upstream.

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
Link: https://patch.msgid.link/20250714-net-mptcp-fallback-races-v1-3-391aff963322@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in protocol.c, because commit ebc1e08f01eb ("mptcp: drop
  last_snd and MPTCP_RESET_SCHEDULER") is not in this version and
  changed the context. The same modification can still be applied at the
  same place. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 73e298f276a8..883efcbb8dfc 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3204,7 +3204,16 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	 */
 	mptcp_destroy_common(msk, MPTCP_CF_FASTCLOSE);
 	msk->last_snd = NULL;
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
 	msk->can_ack = false;
-- 
2.50.0


