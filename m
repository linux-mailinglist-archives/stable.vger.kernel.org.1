Return-Path: <stable+bounces-196844-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2966AC832CB
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 04:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C5308349522
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 03:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E69714EC73;
	Tue, 25 Nov 2025 03:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/fpJ81Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2E73C38
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 03:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764040037; cv=none; b=dG429f94MAn3Tz18dAM7LRF/r0rs0ddiFXBoAaBV5I9yjbtcTTW0f4B4kVT0U8l3v5SFv36fX+DDuzyHpalYP2gMH14QqBw1CtV+8KnhAv7Z6xxvc5E/EPg8BfU37Pk64GjdCm5t4PuVFn8QzFG6oLJSERy0mVhZuhLiQUM5MM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764040037; c=relaxed/simple;
	bh=qdgnAkDP87aFrZee5LK7prxg+WPfFBkAPla/f5kS4+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L3zT3L3FQhnOhbfxD1ujAqvWOzm7AaNcgJjYwlmGgtvIJiO0W4XCvWt0gKJ/ypFTE4FtEtyB1JGjr1VfDLEIvg+t3Y/U/epSB1M6IvG6h0W0ZRwYCOSU3nSdErIa/5lFIKyfnxBUjfOyVk0+9KyaIR2y/3jRkAq1uuunmG0K2kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/fpJ81Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C43C4CEF1;
	Tue, 25 Nov 2025 03:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764040034;
	bh=qdgnAkDP87aFrZee5LK7prxg+WPfFBkAPla/f5kS4+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H/fpJ81Zp0fLlPJ7lTJtXfSCMAuzCT59fCvclFLPjawVA2TKNtM+h/92Tx6MaFCWx
	 YQJvx09Eycet6m+BG2jpd/1oVaudcEPV4n2Wwuu+iZHOLsc02A2vQH60t7FxkBVSuc
	 VvSenMTjHxrafwKWOhezNv5995EOFwwrvULzF791l+4CN5C+0r7RJTmqOF16o8r+HD
	 amvc3P7yCgCzJhDCwlkpsK46V+6u2xAIPbeRMdeA5vTwFINRBR75ZJSt6fSI124IHq
	 0jKv16mta4OrDxnBJLQycnJJypY+5V+C6sR7MV9xSPp07pnahl4Woa0XltRXdVLaBz
	 ZlDTT+PckSIFw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mptcp: do not fallback when OoO is present
Date: Mon, 24 Nov 2025 22:07:11 -0500
Message-ID: <20251125030711.325345-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112425-math-lasso-c3b8@gregkh>
References: <2025112425-math-lasso-c3b8@gregkh>
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
index 490fd8b188894..54c74c2870b77 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -573,6 +573,15 @@ static bool mptcp_check_data_fin(struct sock *sk)
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


