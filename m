Return-Path: <stable+bounces-120127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9F1A4C7C7
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 17:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 709841886340
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 16:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B742E2528FD;
	Mon,  3 Mar 2025 16:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErdBMfGe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8562517BB;
	Mon,  3 Mar 2025 16:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019460; cv=none; b=eCoWnhHGtztR0vONvUYH0REEhW0t0bO04bI+L+T6lGZ9+9uzq0zKTqCIG6rmDh5EAtYJP3rTTXcXmL/HzT/dJqZqBAthswlzm5rkLPj2sWg+6q4UkFtnovy532Az4/ti0jho1/seXXzXrddtjod/D1mdCs22nuIZpltCxxnprZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019460; c=relaxed/simple;
	bh=PQcdHR7xGldchHufFfkG93+0uiY9+gpl16eM5PJNtzI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LeSzln+dUipCNQGKesr3tXGHN2EMT+TJve+gDxoT8DZnbKkT/M9q8phKk8Q3w4I70lUBu1Mb6dPDtTaIGkljz1T58nOtwC3puAIB9uFEmts+5tc6NNA2P7rOAe2wFebuYOJs+uF9qOhtN+i1OW+bH8MMVaedv/eAnq2T2emhd9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErdBMfGe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85AFAC4CEE6;
	Mon,  3 Mar 2025 16:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019459;
	bh=PQcdHR7xGldchHufFfkG93+0uiY9+gpl16eM5PJNtzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ErdBMfGe6mc0CmdOLIjWyZLb5U4S8HrTqG1dPdajp+fggUf207buPakKaIccgU2ps
	 6c1v6UePJOsO2u4dT/pyl9nLN77/o+yJTEhL6lqq26sJ0A+c5D3/KclnriQ91nzWn2
	 kFJbz1llYfOlSr1EnEzC11CMZYUNFxajeyT1XmdBIREfddSGCBFCuFaBKFa+0ENWY/
	 XIyAhfFY2t1K+0PIf1dZNcaBcnZFXQW/jOBSvabY5wDivkb+VsVwkDY2rGiXOetr+y
	 qAwLLDuNJYwV4opB1QcTSHRF0Fnh/7Xj9p9yBZ7dtSlZWHwyNhOYgJ2WTqdSxLl3JP
	 FQxGKcUR9Pu9Q==
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
Subject: [PATCH AUTOSEL 6.12 13/17] mptcp: safety check before fallback
Date: Mon,  3 Mar 2025 11:30:25 -0500
Message-Id: <20250303163031.3763651-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303163031.3763651-1-sashal@kernel.org>
References: <20250303163031.3763651-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.17
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


