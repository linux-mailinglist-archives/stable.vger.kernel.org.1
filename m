Return-Path: <stable+bounces-120158-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D395A4C84A
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 17:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B3FD168E54
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 16:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2B3269B02;
	Mon,  3 Mar 2025 16:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCZk50QK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB3522E405;
	Mon,  3 Mar 2025 16:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019527; cv=none; b=RJxEIe8//HAbdFCwzqh68iTdypUVmjHINoqyESDt+5EFl48xRghjSRis1bC+u71/fWE4FN9Klwr7Jez2jeYmycZZs7GgF3MSZPIVXbafYquHufcVp3IfJjkzzzqxMHbGvx+3V3+nfw5X4EdEV7km4YygvaznOhhTfF/2ifaDp8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019527; c=relaxed/simple;
	bh=4LlMWS7unNjrr4UO9L6/YFDaJLbN0Pbn3aVKgAkooS4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F9WsRLn9xIjNj885TTk4K+vg4cAuyMqt75EO7SBGBz+hyDYNL9hG9yBkxjycHzye+hwkZBtHVd7/ZA32+41LA8AoBToF/4fzpAP1q9J0kwPbg0z7e9BGl1dQyaLgdX86DgynMaEu2DWG9UVPpv96TidfoUNP/LvySgPim959e+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCZk50QK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68CDBC4CED6;
	Mon,  3 Mar 2025 16:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019527;
	bh=4LlMWS7unNjrr4UO9L6/YFDaJLbN0Pbn3aVKgAkooS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dCZk50QKQklRygiHfqvmd9YQC+lJIg7B5J/OzLJuldIakCbTs9o5+a/4cDJLlpNHN
	 3rTe+pbI9EYFS6Z580FFwtk/3UVUIKWCodDzFnL6u+cc7DP6wHarUQu1sO3ivZtfe5
	 ysYabUuSk27ocgJBt7RejRhhXCk5oiDEjENiZttaEwiZYFDn0uXjEnQiKmg49dmw5F
	 xqItIzcz/Xdv1Fcj24Cn5v1MiAhtgq/Pv7QK9uqdXk0V5O48fhcEaPYB2WK8JewW0e
	 OCOABoFrJlL5Zvvs/j/cfrWMTWfcWxmdHJzdd6cFQw5OesCqjHtmQKOwINKJGgWzJi
	 ebVfVVHC6BdHQ==
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
Subject: [PATCH AUTOSEL 5.15 7/9] mptcp: safety check before fallback
Date: Mon,  3 Mar 2025 11:31:50 -0500
Message-Id: <20250303163152.3764156-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303163152.3764156-1-sashal@kernel.org>
References: <20250303163152.3764156-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.178
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
index 6026f0bcdea60..b92646ddbf077 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -870,6 +870,8 @@ static inline void __mptcp_do_fallback(struct mptcp_sock *msk)
 		pr_debug("TCP fallback already done (msk=%p)\n", msk);
 		return;
 	}
+	if (WARN_ON_ONCE(!READ_ONCE(msk->allow_infinite_fallback)))
+		return;
 	set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
 }
 
-- 
2.39.5


