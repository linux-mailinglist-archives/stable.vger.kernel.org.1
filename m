Return-Path: <stable+bounces-120139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEABA4C811
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 17:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75EAF18865F0
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 16:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFE525FA28;
	Mon,  3 Mar 2025 16:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULIzHf8s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9431F22AE7E;
	Mon,  3 Mar 2025 16:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019486; cv=none; b=KTPCCbTRtjY8a8qFfWJLpJUu2TQrxcGkEPJlm6nD4lLUYyAOvWgNpcIdD8TAWZH0BkeBtKAL+grH0+0nbuzbmj4uMXDBGgoIeGWdwThyrcY4U1ezhgw3jw20kgbCVq241aEsYPzKZ2UrxnZVoR7vByJSRCirgf1dsBf6MNEVgI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019486; c=relaxed/simple;
	bh=5PHOtHYrz+HB7YOATOrdWtOSfwLWHrGrPYyKZnUOeLU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DtDPXu22+81aYgeA3Rzz2EieELw5+ihvPszDaQC2DkBicr3YGc0Q3QKtuTMF4GhhTX6vXUPrP1Gw0uMleTvV5XqcUjCl+KURio3e27FXXy6vntGc4toO7uYbfqKkBEWDvYYn2CfefvUfe/uM3zDkgRIoEtcAEwRcYV1uPttKM54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULIzHf8s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4018CC4CEE4;
	Mon,  3 Mar 2025 16:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019486;
	bh=5PHOtHYrz+HB7YOATOrdWtOSfwLWHrGrPYyKZnUOeLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ULIzHf8sIUbR7nCFoJmLVdR8g4jKuRlJQ4iAx4LAaoew5w/nWNjbC4e5yjwNvpJ1V
	 wsZ3MaSSQPpHoh/drK42DoJawqYeynMg1piQJgmi5Q3c8lxK5bKVJrhNp+HT0h5Esi
	 yOavbw2Ps5ASSpzMm56YUZLEsaaJGMNkO6cQmXz0zmb2rdfssdskLdlk3CD4qWXFlV
	 E6dmgHnzdqw5RTxUlFUFTOPTm/hFLu3ocnV8138jduXVhPfrAhwirGUfFGRcFkXvAb
	 mG8t2ZCOuK5WY8i4OT1oa9Z+KtwQl21HoLdS1yAspusaBNdWtkRVQhW1ivqdXaMTLJ
	 3GzbINJD75ekw==
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
Subject: [PATCH AUTOSEL 6.6 08/11] mptcp: safety check before fallback
Date: Mon,  3 Mar 2025 11:31:06 -0500
Message-Id: <20250303163109.3763880-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303163109.3763880-1-sashal@kernel.org>
References: <20250303163109.3763880-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.80
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
index 0bb0386aa0897..d67add91c9b90 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1103,6 +1103,8 @@ static inline void __mptcp_do_fallback(struct mptcp_sock *msk)
 		pr_debug("TCP fallback already done (msk=%p)\n", msk);
 		return;
 	}
+	if (WARN_ON_ONCE(!READ_ONCE(msk->allow_infinite_fallback)))
+		return;
 	set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
 }
 
-- 
2.39.5


