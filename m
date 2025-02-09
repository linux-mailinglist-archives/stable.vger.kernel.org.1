Return-Path: <stable+bounces-114460-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF895A2DF95
	for <lists+stable@lfdr.de>; Sun,  9 Feb 2025 18:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7609D164215
	for <lists+stable@lfdr.de>; Sun,  9 Feb 2025 17:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608081DFE06;
	Sun,  9 Feb 2025 17:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhElYdiN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139531F95E;
	Sun,  9 Feb 2025 17:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739123318; cv=none; b=Z9dZqDStsZlCSQXxZjHjieVd5M2yIl7is2B5FUKOoV3nZovIswFkSQt4YQyULEr/fqkC/O/SkC7/MZ28KiTJwcj4fcYtyIy1R3PBRKenUETAWM3RndRprHcHnBWil8yhZKLKIcsU4KvGlX5Z5r8Cdiv1178tjsC26Ki18LuWecY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739123318; c=relaxed/simple;
	bh=fzDuiRpRL2d1xWH0J2p66ofVjRH7WKy0ma5rO/VFPHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lrWia8NYrCpnTJMPTkoCxiKlskKIlwhpP5yDk8820sh2/EyBar1VoMT+4yuGbRcc2XLNAiCkczPWMUqVAp1fY4GP3ud6rCk8MoWgncWoMf15YfMM89OrDixsNYO56UcLagDQ4szIRwkxGRqK1uUCvq0uVi2UBpEsToiXVVMT8+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhElYdiN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE69FC4CEDD;
	Sun,  9 Feb 2025 17:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739123317;
	bh=fzDuiRpRL2d1xWH0J2p66ofVjRH7WKy0ma5rO/VFPHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DhElYdiNwV4D2BZZ4LHw8lXQ4yG1ENhvH5MVcA4MiDDH2Z/zhaV3tAzWQ3Nu4YF8g
	 oiXVvSQcOH7N802Wc7P4tXSpzFDgAAIsdgZXhg2ntIU4gRhyCNXz3aAG0Y3rgaSkwx
	 RfR83qUH1CTHzKmpZfONuf9VjIAgSUHMTZutatHG3q0vgDSNjFm84lDSppSgnknJgR
	 9z4SAAofhSgL3IY/FzAbvv3VvknDMlTEIyvWY4+pVT68oRWWKoBw0ag/Kkm/yexp+V
	 cCyxvOr1YAh2MqLsOzzj4CDV44VrY+Gg4pKD1MwlAq27p74Yyk7RcEDm+37+RBP8ez
	 +swQOk8JSgVqA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y 2/2] mptcp: prevent excessive coalescing on receive
Date: Sun,  9 Feb 2025 18:48:31 +0100
Message-ID: <20250209174828.3397229-6-matttbe@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <2025020435-eagle-precision-e8dd@gregkh>
References: <2025020435-eagle-precision-e8dd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1401; i=matttbe@kernel.org; h=from:subject; bh=eFLGENSx3/TjLkm7K8v/Dyj0E/Q5+QNivasGS2+NndA=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnqOps5XQb5RaSqvj+b1SvCFhSRw0TTR6gtrOfZ +L/qxCC796JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ6jqbAAKCRD2t4JPQmmg c+vzEADwx3xmPjUOIq0XA62zt1wFRXt5e1tH5gqu5//7xNYTuVx7CEGjaNn16CFREzkCO+Jh6GP 7tS3Vz152D01WmrePJFt/1boMrykSgDB2+UfywDL2Y6ioVy2gOpQuotA9itzvqmkBuiEHwciVI7 b87SF1S3KHUmf0NIrEZEZTbhvL+0ec3Ih9t5UOwYMgeAdBqBh4ZZF1GAiuKknDcraQ6PK1VREuq 7WdCFclm21QpFKaeegH1HssLuazQ4MAUWRqCxXkmhRQJWpFloLDbttXWvZdbaBlnl1e81ZjGu8Q tkcJ48LWou77vPcbP+snCH2R/4OHpby39qI77zIUuyG/UD0GxwlLS3frqErbssYiNaKuEAdmodp kELYDDmpLZxsJyx7rzS0YqX7ZNlv2OO1Vucy/UdETTpHKNVnDQ4bHQb6guR5tbBBgBGoau8BUyB 7BWAePP5Qv7paBWlX4AqyPNyUnFxicn+yOMuSxHZhYrjfqJWlbH/rg6EPKM2E0nUHLBsDR8AnSr b8y6uEokxJMQrTk3ewro0M1lvkZv0CVnKGibKEgJ9GAgLdDff46B5nHYDKp0nQKNaKkUFntkgmt 6a8P6Ydx2h8E+eg9FG2vb0XXpCX+TbMXSeRDc3vBaIBwMeGz0C2OLQhN7wuSre5AoWpPB+Mdupc NmH6o2zKlNfXk2A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

commit 56b824eb49d6258aa0bad09a406ceac3f643cdae upstream.

Currently the skb size after coalescing is only limited by the skb
layout (the skb must not carry frag_list). A single coalesced skb
covering several MSS can potentially fill completely the receive
buffer. In such a case, the snd win will zero until the receive buffer
will be empty again, affecting tput badly.

Fixes: 8268ed4c9d19 ("mptcp: introduce and use mptcp_try_coalesce()")
Cc: stable@vger.kernel.org # please delay 2 weeks after 6.13-final release
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20241230-net-mptcp-rbuf-fixes-v1-3-8608af434ceb@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0848e63bac65..82eaf20268e4 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -149,6 +149,7 @@ static bool mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
 	int delta;
 
 	if (MPTCP_SKB_CB(from)->offset ||
+	    ((to->len + from->len) > (sk->sk_rcvbuf >> 3)) ||
 	    !skb_try_coalesce(to, from, &fragstolen, &delta))
 		return false;
 
-- 
2.47.1


