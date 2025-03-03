Return-Path: <stable+bounces-120110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA0EA4C758
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 17:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31F84188C52C
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 16:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46DE23498E;
	Mon,  3 Mar 2025 16:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkzeRRH5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7849D2343C6;
	Mon,  3 Mar 2025 16:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019420; cv=none; b=BrJ5NweXg1COLseRDFrZ2CF4f5JgfOFqT2LG6jLO44zf5BTFVmQ2g9TRl60Lmtd4j5W21LQX90BOZdjvN+M/gm0cr59t6gHNweQCVgbRZl6dWfT8NkM58BgQGYNlT2EL6d2ZAUDgdg5tO9Z/VTDon4yqGjFqQxMkjqdDwUzQaQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019420; c=relaxed/simple;
	bh=PQcdHR7xGldchHufFfkG93+0uiY9+gpl16eM5PJNtzI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OkdjmoRWHbMpr3qHnHy22+3Pi8gSM27k8/DcuV5MNN0ifi4/16A/d1rd9MpOsHWrRbFNIMlq8co87aVWrROE+5jAyVpLKlqBvgU+leN7UM1hClNhI6KY0YCQeWhdpZnu+wzBfCSMFpuEOpF/Dl0T96hIBGwqnTuTTg6RI2hMtI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkzeRRH5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C394AC4CEE6;
	Mon,  3 Mar 2025 16:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019420;
	bh=PQcdHR7xGldchHufFfkG93+0uiY9+gpl16eM5PJNtzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EkzeRRH5nTsfiilyCqnvA+3r7iGONEkp0S4Lu2mC1mcee9AYfGTY49a0zGwQM/a45
	 zRMrtrNBOzruAtm4TGTyPWyf27GRM0V/kFGOPH+3Iz+KZXBgwbugpOaS5N8hss9Txu
	 YT9vaHIpGrOVbqpSl+O8xKPdZSURzPKB54AOFeAnVOraKBCY5XmOwoZfgTF38je4A0
	 mXuaZxxrallFKaJE4zCc39NHiHK3cws6WXsdvn0FoMP9eDAUIg3WjvRFhItcDNdlav
	 B0xYz16X2rij0UQ15RlLx7ArzPQ3J/DA3mpeIiOCNqPDDSMIQb74bXyvYFr+QBEYxt
	 VJit8STcLaCjg==
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
Subject: [PATCH AUTOSEL 6.13 13/17] mptcp: safety check before fallback
Date: Mon,  3 Mar 2025 11:29:45 -0500
Message-Id: <20250303162951.3763346-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303162951.3763346-1-sashal@kernel.org>
References: <20250303162951.3763346-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.5
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
index b70a303e08287..7e2f70f22b05b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1194,6 +1194,8 @@ static inline void __mptcp_do_fallback(struct mptcp_sock *msk)
 		pr_debug("TCP fallback already done (msk=%p)\n", msk);
 		return;
 	}
+	if (WARN_ON_ONCE(!READ_ONCE(msk->allow_infinite_fallback)))
+		return;
 	set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
 }
 
-- 
2.39.5


