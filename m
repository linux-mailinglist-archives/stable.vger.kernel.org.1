Return-Path: <stable+bounces-106565-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3AD9FE9B2
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 19:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 602A7160A97
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 18:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735FE1B3924;
	Mon, 30 Dec 2024 18:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCIeqMQZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225941B0F3C;
	Mon, 30 Dec 2024 18:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735582362; cv=none; b=tUqU+1L6MVrhvT6sX4bJhG12mYPkrYQpqfaFTMY9wx/VFEFx/g877xatDKamas4rVuxbDI+tf9uOpGUD1iBWDwqFZMfQpxzOAHd7SgPcFonTgLe1rCkghgTkQU4xaADejAsj5YSI7y7ZnG/ZJjxQYLabsO3/tuYXUCPYzcrvxIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735582362; c=relaxed/simple;
	bh=L3BgX8P6whV4xrMDVTlgJeTacJQR3LV2RMAHJYZWa0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EH7KAo83WtNtOmWwtEV/O8/48bAUoSgYOLuVtVcszrsZJbcF+n1XatxW8zOJWPUACsgwPJ1bWyXAkyDiztCdUdC3OQ8K/q3oZkx0jKp2OD0jZ+Qm85A/UrQmIla1rCdgCHSAoQAg6C/gMhw0HUg4qkDPrHpqllN1yzJcQOH2uYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCIeqMQZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45BBEC4CEDD;
	Mon, 30 Dec 2024 18:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735582361;
	bh=L3BgX8P6whV4xrMDVTlgJeTacJQR3LV2RMAHJYZWa0g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DCIeqMQZfTw/Pc1ZOhqW359qVJlvKhbP95nGFLT0Mhb3DQjJGKS1yONzoqDoYDvsh
	 sVm2FGwqtNOTzdKyhkU3RFB3XiqCOjy7nDNW/mi4kDnwcZ05EsplJDKnN4OL81RqBZ
	 oQgNNdqLJNUuIZKSVq4nq23dJ8waOD57etOG52pq8OVxAutPNA8dUV8WdIHusRXd+R
	 U0LhB9KJW9RDNKoBrXUjMwoCSVmSWz80+Hk8qcT0pxF1+tAknvjMC1IxFN/VTS7CEx
	 gqN6bLfFWG5PdkaboW2jTY/nuyIMKZr+fa/yWLj7ThUiaYLxPpXK62iSw4bq9TBvPv
	 MjQoG14zNTyvw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 30 Dec 2024 19:12:30 +0100
Subject: [PATCH net 1/3] mptcp: fix recvbuffer adjust on sleeping rcvmsg
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241230-net-mptcp-rbuf-fixes-v1-1-8608af434ceb@kernel.org>
References: <20241230-net-mptcp-rbuf-fixes-v1-0-8608af434ceb@kernel.org>
In-Reply-To: <20241230-net-mptcp-rbuf-fixes-v1-0-8608af434ceb@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2051; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=BGpF45T4eAeVh1ljyb7HGKU5WwHWJrbxG0WTCQ05uIg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBncuKTRs9xD4Tn5onKFbD1r1DSnfwV2Sh/p+wlp
 72N8EBN/C6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ3LikwAKCRD2t4JPQmmg
 c4R6EACmrd4wjtJj0iRehJTGmzwr9BmgcXT/yXROT7e8D8Ov0hRjusyJCWucfRMQHqznzpqa8qw
 uWQqufwr/YUiZ0y5iDfzNfyM1jaSMWZRlYLLtpoKreW3ueiuJRP2Hlf4jE7/A0vixEIpD/VbN7b
 B4Bcq7XxBy/eE5PkmN53u+mrFqeDPNNMpI7m3mRmO1XI/NCSusVeBfYVn/JtK4akpINe+R5xvXq
 3NnPpTYGPmEHSQ/1GCiRcU1IBsykBEm/7pW8LPHKDho5VOIfEyfz8IVEVevRJg8jH/v9wJH8DbW
 nbLzmnec0D7h2yQSq7fhkb1Wv13xbaQhwjMD1hN554X2fP3ALNrSWtjtKGy4W8DzeZTljhUzJui
 8e/KrUtC8YNAj+dZ0QviCCPQSnrUuoXazNcqJiepwdgEYQ2agwMluxWP6A5UG9ur2+NRjLEJr7b
 eHKVSRMbIA9q6WFOJNduGwRDhBOer2lUZMNS6CtkdySd3SMCNLvBh54wFMuCTYDR3nJrvftaseR
 kW1+/KDdoIr/HR1w5Kd155uNcYAAxB8JpKh5f+R5lv3Im5WE49APJygVQKDvcSzafhrEHUIrwjA
 noK7t1bKcTXfxEsdmfIA6bTivE3AygRzmizKiLooCIe5ppD02TgedzGsjJ/q7/UfbhunUaPXnOn
 XB4juqY3W6f+l1A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

If the recvmsg() blocks after receiving some data - i.e. due to
SO_RCVLOWAT - the MPTCP code will attempt multiple times to
adjust the receive buffer size, wrongly accounting every time the
cumulative of received data - instead of accounting only for the
delta.

Address the issue moving mptcp_rcv_space_adjust just after the
data reception and passing it only the just received bytes.

This also removes an unneeded difference between the TCP and MPTCP
RX code path implementation.

Fixes: 581302298524 ("mptcp: error out earlier on disconnect")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 08a72242428c0348471a5995465aec32c67af347..27afdb7e2071b16dbc4dfa1199b6e78c784f7a7c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1939,6 +1939,8 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	goto out;
 }
 
+static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied);
+
 static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
 				struct msghdr *msg,
 				size_t len, int flags,
@@ -1992,6 +1994,7 @@ static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
 			break;
 	}
 
+	mptcp_rcv_space_adjust(msk, copied);
 	return copied;
 }
 
@@ -2268,7 +2271,6 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		}
 
 		pr_debug("block timeout %ld\n", timeo);
-		mptcp_rcv_space_adjust(msk, copied);
 		err = sk_wait_data(sk, &timeo, NULL);
 		if (err < 0) {
 			err = copied ? : err;
@@ -2276,8 +2278,6 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		}
 	}
 
-	mptcp_rcv_space_adjust(msk, copied);
-
 out_err:
 	if (cmsg_flags && copied >= 0) {
 		if (cmsg_flags & MPTCP_CMSG_TS)

-- 
2.47.1


