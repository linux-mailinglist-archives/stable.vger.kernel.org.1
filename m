Return-Path: <stable+bounces-15059-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE068383B7
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 350C2295021
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC03264AA9;
	Tue, 23 Jan 2024 01:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g426O4uC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAEF64AB0;
	Tue, 23 Jan 2024 01:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705975044; cv=none; b=SNjItCyl4AixcY6O3oUcbb9xWK4SHngYRvCDIvfPCZE7buwJRaY9pxQlq7+5v2PNwGpf2Yjeij0uTbQk2oZhZ0/4pG0UWDeNEnTqA+7qt1mqcRR9wP6VUXJ6tN3l5gHCUJd2lrhExDvOQ7FFqQAN+pRXEy5JSPRPgFN7DZBIkfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705975044; c=relaxed/simple;
	bh=mo68gWdRrKcAfqkW885tAgeYkn3GcCQ2hK6GpyyrYwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qG+KkMaNpQ0Zm0KAPPhAdNwxsBLDXSp3MzKYyNJJE1BJ5wXr4018HGXnB0tuo8HRnfcNFAQGgDzjQN+XzbXeahh/og7hHGupzX3tATds1n/oCUsq4dvf0JeeKQSdnlGkNoHfWLB60psQWanXRo3lzhZcNli+VbSaceyugxPLsaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g426O4uC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F471C433F1;
	Tue, 23 Jan 2024 01:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705975044;
	bh=mo68gWdRrKcAfqkW885tAgeYkn3GcCQ2hK6GpyyrYwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g426O4uC1KWSYnj045q7zeVt3S6qsED+2+5GauMwzjjM9xQxByfQoJB3bTvmqeCOY
	 Ifxpz1UNb0sl2d8qp+qWjXi6X8qojw5heENRn0aShieSpg4dh49KeS+DpWrnMY/r+8
	 9qDylfFzFsxYt5ew1To+N9rSIrS9muInBrjVqCEQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Florian Westphal <fw@strlen.de>,
	Peter Krystad <peter.krystad@linux.intel.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang.tang@linux.dev>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 338/374] mptcp: use OPTION_MPTCP_MPJ_SYNACK in subflow_finish_connect()
Date: Mon, 22 Jan 2024 15:59:54 -0800
Message-ID: <20240122235756.663473897@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235744.598274724@linuxfoundation.org>
References: <20240122235744.598274724@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit be1d9d9d38da922bd4beeec5b6dd821ff5a1dfeb ]

subflow_finish_connect() uses four fields (backup, join_id, thmac, none)
that may contain garbage unless OPTION_MPTCP_MPJ_SYNACK has been set
in mptcp_parse_option()

Fixes: f296234c98a8 ("mptcp: Add handling of incoming MP_JOIN requests")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Florian Westphal <fw@strlen.de>
Cc: Peter Krystad <peter.krystad@linux.intel.com>
Cc: Matthieu Baerts <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>
Cc: Geliang Tang <geliang.tang@linux.dev>
Reviewed-by: Simon Horman <horms@kernel.org>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Link: https://lore.kernel.org/r/20240111194917.4044654-4-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/subflow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index c2c30724b322..297d2465c413 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -432,7 +432,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 	} else if (subflow->request_join) {
 		u8 hmac[SHA256_DIGEST_SIZE];
 
-		if (!(mp_opt.suboptions & OPTIONS_MPTCP_MPJ)) {
+		if (!(mp_opt.suboptions & OPTION_MPTCP_MPJ_SYNACK)) {
 			subflow->reset_reason = MPTCP_RST_EMPTCP;
 			goto do_reset;
 		}
-- 
2.43.0




