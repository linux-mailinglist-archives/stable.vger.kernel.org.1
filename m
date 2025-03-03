Return-Path: <stable+bounces-120149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FCAA4C841
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 17:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C05403A91BD
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 16:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF1F264628;
	Mon,  3 Mar 2025 16:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOOTHEdQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947B126462A;
	Mon,  3 Mar 2025 16:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019509; cv=none; b=bEOOdszjsVke0kQ9r6MBtakcGKKXmvv518BvkrQjXsmvohdqE8v2hdboWoMjKdPyH5cS9JCbF3QkyeL6azkhn7IuurssukBLb8Nrv9qt9nsxPeL5RNsV8o2VXPMhE/ITdW2wAo5WE/3lRe42sS1ktsz8gyR8nAkZ80txJcVfcq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019509; c=relaxed/simple;
	bh=w4eZ7vTmYbfaw63YjKeyHVuq0kQ1D/IJR+agJq/71Rg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jsU550NucV9RXSh9SP4qQ7Qa4wKHa3jvsrqmMqHmsBk9zevMHYQjLhv2R+pIIk7Sbb60n0Pi4IECN5NVMA7Bs89Tx3TE23tmfKZUwjb18S5745EjI2xMLUpbFeyP6FR5jdzCLpdX/jfjwPtmF7kIqmkOMy1vgdfULSO29WSeOwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOOTHEdQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10D6C4CED6;
	Mon,  3 Mar 2025 16:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019509;
	bh=w4eZ7vTmYbfaw63YjKeyHVuq0kQ1D/IJR+agJq/71Rg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bOOTHEdQ/J1vC/HxPIQIGz7elaYHIWEVZf1N3G/qHjgKyceXusXpi1M4t5+PRoEMb
	 7Qr0ZvuVFWceKXmR/z9WjIPsasJ/JeTMw3Co6c2bENruGdBHJSXYtI7t6zW7kMYFxg
	 GKNnNcI/inZvWBXk+w3SBBKEGy+BdfUKO64VMJrig0c4dP2ko2dzgHAlyVIrei7kMt
	 jgM4Ct7hBsGLunE2CavWY9xnSNqfYeSNJMiToTsva2T5A/lHgrVyZ/dU8I2iYpI8Gj
	 ChTaaK5CpT9ofp8PcXIw4ZiTReoLWRHpH2H74P9VQQsXBT0Y32RowEpIcRaqVnEKaS
	 Ey9cxcDA2STCQ==
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
Subject: [PATCH AUTOSEL 6.1 7/9] mptcp: safety check before fallback
Date: Mon,  3 Mar 2025 11:31:31 -0500
Message-Id: <20250303163133.3764032-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303163133.3764032-1-sashal@kernel.org>
References: <20250303163133.3764032-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.129
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
index 77e727d81cc24..25c1cda5c1bcf 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -981,6 +981,8 @@ static inline void __mptcp_do_fallback(struct mptcp_sock *msk)
 		pr_debug("TCP fallback already done (msk=%p)\n", msk);
 		return;
 	}
+	if (WARN_ON_ONCE(!READ_ONCE(msk->allow_infinite_fallback)))
+		return;
 	set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
 }
 
-- 
2.39.5


