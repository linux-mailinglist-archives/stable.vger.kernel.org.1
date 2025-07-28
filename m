Return-Path: <stable+bounces-164898-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E7EB1375A
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 11:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 286FB177B9D
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 09:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EACE186284;
	Mon, 28 Jul 2025 09:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtHq4evV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C048A1A83F7;
	Mon, 28 Jul 2025 09:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753694131; cv=none; b=RQiImwuhXJEDlWWYIggySINENTxamB8Xhj8MT0ug+pGvedWf/IFS2OFHOa/gqun6MSkzWRP5AkkQ2rDrF8kKvcFK+geS01GCXZ8qQXzuhzG6R936To8DQEhMxshh5z44uW13ZJJGwGVnaWI2vpCsWX7j7ZsHxxtLK6kSYY4CzmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753694131; c=relaxed/simple;
	bh=/z4nAMGjbg9eq/WyFM+G90fDZlxTQvo0pkTNi0ZO8/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jKISC7i3gmaN4KsQrro9OnSJ8uFxLL5GK1cgBgsOCoGPJFnyFL7VAomffkOC/Trq8bZraHhx8M+kk/PsuR1uoz4MEzm8oK/DNDFGEnV8W6GO5XY7ZVSMxHUjBiVTVFenH6vU53UCOJi6b9p5ZyP1EzqT4QxEnRPur8GY7us2b+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtHq4evV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B16C4CEF4;
	Mon, 28 Jul 2025 09:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753694131;
	bh=/z4nAMGjbg9eq/WyFM+G90fDZlxTQvo0pkTNi0ZO8/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WtHq4evVP7Kejo2vDGOSYJVA+U/RguGMw15Gam/XITfvAbRptZK8KxXBO5OXtf5RH
	 OBsKH5Ttg6DQrVaHrLRUzmkISXJILuScB/5tIgUnbOZ1WasBajQNZXRUitegAuoWqc
	 ht+BoUGFjiqHNoe5JydHVOye/Bxri9LcsulWqVyK+Oos7qzE9XMPoQP9y5oEPMtPAu
	 Zw82R3SRmkwIhf8JNrhgM/ONRvkwRv570/ISflH1n2r5b6Xt6ny5OkXtCRHczVq29Y
	 +Ksky5UUK+E5ZchU96Lgjx/eSHrbLns8iOyeIPPXK+YphxZQgm8ioBucEdOAOaP7zK
	 Thb8NopsbOejA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	sashal@kernel.org,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y 3/3] mptcp: reset fallback status gracefully at disconnect() time
Date: Mon, 28 Jul 2025 11:14:51 +0200
Message-ID: <20250728091448.3494479-8-matttbe@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250728091448.3494479-5-matttbe@kernel.org>
References: <20250728091448.3494479-5-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1694; i=matttbe@kernel.org; h=from:subject; bh=KDTgPScFQXodrdXEbeZB+zJKYm2D1b5M+u5QUzHsyjg=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLa7aepvKlOerDjQvxlSdd13a9WXlmSFKRoJtC9b0fGp 3hz07m6HaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABOpyGL4wymiyeYkfPhectLn jSErFqy8kdu3dVfxTt/DmRWz7wictWRk6OIsTf5a2cYV7Z95+4HAv0eXz874vL33g5XF2ev1ooF 13AA=
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
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d95fc113d317..e3f09467b36b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3208,7 +3208,16 @@ static int mptcp_disconnect(struct sock *sk, int flags)
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
 	msk->can_ack = false;
-- 
2.50.0


