Return-Path: <stable+bounces-196847-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A48C83393
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 04:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7A9053444F8
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 03:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A992433EC;
	Tue, 25 Nov 2025 03:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICLJJ3qx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A2F19755B
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 03:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764041231; cv=none; b=ChA9x/i1IfJ6rPpXzszl+B67bqu68onIGa0MXCmOpKPn4Ztct5jdr7iyifjOhWdQHTZgoUYOf4MsvmLA+MsyjmYtyVJ0sEBFsjIFjXvwSfj6kNWBO6iw6oaU5+76Na1Us+vHfR3ty83v1CVr2lHKWjZ1/9PShHA5xmRr/lyHMUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764041231; c=relaxed/simple;
	bh=W4efABSlDH6ls6yHaqdyy5Wo0FVBTrEA7I1ml+LK4x0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tbanQdNKMTADQzm6cbME9kEb048gMIf9SaUE639ai+Z72ultJIingENmrnLsEpu3hCxglDux2DUQXtttmr2GLBrswZKpMtoIZnb8iYvdIfZqEJBXfU0bN2y+pg8RMb2eyDFz7lweBJEGtZpez9T72ipFlS4us+/nMvUL2E7u1DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICLJJ3qx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49679C4CEF1;
	Tue, 25 Nov 2025 03:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764041229;
	bh=W4efABSlDH6ls6yHaqdyy5Wo0FVBTrEA7I1ml+LK4x0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ICLJJ3qxZ1MjvAYv/dutY4BGdBc3MHAH1f3eqkkfS+FWL61F2m3vtCdNd65GHRICx
	 7UAP02o26aS8etSOA79cEhel+uXBb5+Mkxi6+eN4HXQKum1ijMcngBXnHmfxMJ9RDP
	 57PxAPcdTDoXbXsd6zBGuxxjZZ7+WGy28DOs9xL4hfV/tlf+IHLO3LAC0kVWSrI/o2
	 q7g+/2VIliEsHhdyMDE/jm/T4AHsTMNSA/ASFLPqzOfExADdqpJJBfETzlvSYpZTFU
	 w0WRZ8BoLzCMtk+idXpzvV+DbhsWhJUkixFxebCNwm32S6VBajfU9Que4Y+5JaRUP7
	 qVkqwNKV0uO6A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] mptcp: do not fallback when OoO is present
Date: Mon, 24 Nov 2025 22:27:07 -0500
Message-ID: <20251125032707.340833-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112426-backroom-negate-d125@gregkh>
References: <2025112426-backroom-negate-d125@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 1bba3f219c5e8c29e63afa3c1fc24f875ebec119 ]

In case of DSS corruption, the MPTCP protocol tries to avoid the subflow
reset if fallback is possible. Such corruptions happen in the receive
path; to ensure fallback is possible the stack additionally needs to
check for OoO data, otherwise the fallback will break the data stream.

Fixes: e32d262c89e2 ("mptcp: handle consistently DSS corruption")
Cc: stable@vger.kernel.org
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/598
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20251118-net-mptcp-misc-fixes-6-18-rc6-v1-4-806d3781c95f@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ patch mptcp_dss_corruption() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/protocol.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1342c31df0c40..d223f318f4ce6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -477,6 +477,15 @@ static void mptcp_check_data_fin(struct sock *sk)
 static void mptcp_dss_corruption(struct mptcp_sock *msk, struct sock *ssk)
 {
 	if (READ_ONCE(msk->allow_infinite_fallback)) {
+		/* The caller possibly is not holding the msk socket lock, but
+		 * in the fallback case only the current subflow is touching
+		 * the OoO queue.
+		 */
+		if (!RB_EMPTY_ROOT(&msk->out_of_order_queue)) {
+			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSCORRUPTIONRESET);
+			mptcp_subflow_reset(ssk);
+			return;
+		}
 		MPTCP_INC_STATS(sock_net(ssk),
 				MPTCP_MIB_DSSCORRUPTIONFALLBACK);
 		mptcp_do_fallback(ssk);
-- 
2.51.0


