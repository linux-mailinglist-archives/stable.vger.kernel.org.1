Return-Path: <stable+bounces-120166-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65155A4C85E
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 17:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B36D18973CA
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 16:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AB527560A;
	Mon,  3 Mar 2025 16:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEe33isZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A380276039;
	Mon,  3 Mar 2025 16:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019545; cv=none; b=mWPZUt+px5FI1mVr2z+5vn4tXY+9hz8hocyidpow7aEAOj8FuswuLFKnptwX8g5FfNio9/eVBhjKMVrtoo1pIAMA/8yXeU6v2RcKm6QQQXoFujfd6bFQ5rCvizI50t2XlQbn/q7OjFcKIo0gMdCCjoefz6IloRaPxkIf0u2bvQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019545; c=relaxed/simple;
	bh=OOFs3TWcXVjk7M91KK5WNZ0dhqX9bDl3xuj94Xbc2Vw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dK0KpSO/CG8ZkbcH9OnITP5dmyCCo9HWe+Xt6pS7e4Pk1uPaAQ3tCR7vvRULwkz6qTnRc31+kMkm3VcZAFCk5/BdyINkVK+9fZzujTD9HUyEFpaO2NF/rdDrVkHxZI0+D9w2lyETZU6Q1HCgiM9IYZLr3fW9R0swHgcZKmuVI+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEe33isZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3196FC4CEE6;
	Mon,  3 Mar 2025 16:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019544;
	bh=OOFs3TWcXVjk7M91KK5WNZ0dhqX9bDl3xuj94Xbc2Vw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TEe33isZNYUW/rBiTnA8ZjKMudovCyEEdxxdocZZuuCyMQnSHouyypVA+cG8qKuEc
	 2iunVT9/J0pNwF1mCpfi4U/vjDrRSYx81J8T+6GKJVTz+6xtrTI8hhjzGLfdfwVEVq
	 nF+9LLUYjU464KR84bohZ8sBcOTPAmFwS3O5lIsVM9JkjaXnha9IPRewJFe2DJWfyf
	 6ixQgkRREmoACukdKMCub///hmPBPIQXSX9e7ogE2jq4r3WaSqPs3bHDw4sQZ66WP9
	 1QgxtGYH9JtLFOK+lfqgZgS7Q5MASu7uuDJ/J/3phrJ/zvCO+HOFcCQaetTMJE6zxF
	 xOhzdwbR4jrkw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	martineau@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: [PATCH AUTOSEL 5.10 6/8] mptcp: safety check before fallback
Date: Mon,  3 Mar 2025 11:32:09 -0500
Message-Id: <20250303163211.3764282-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303163211.3764282-1-sashal@kernel.org>
References: <20250303163211.3764282-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.234
Content-Transfer-Encoding: 8bit

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

[ Upstream commit db75a16813aabae3b78c06b1b99f5e314c1f55d3 ]

Recently, some fallback have been initiated, while the connection was
not supposed to fallback.

Add a safety check with a warning to detect when an wrong attempt to
fallback is being done. This should help detecting any future issues
quicker.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250224-net-mptcp-misc-fixes-v1-3-f550f636b435@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/protocol.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2330140d6b1cc..f5aeb3061408a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -530,6 +530,8 @@ static inline void __mptcp_do_fallback(struct mptcp_sock *msk)
 		pr_debug("TCP fallback already done (msk=%p)\n", msk);
 		return;
 	}
+	if (WARN_ON_ONCE(!READ_ONCE(msk->allow_infinite_fallback)))
+		return;
 	set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
 }
 
-- 
2.39.5


