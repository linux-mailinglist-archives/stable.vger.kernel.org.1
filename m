Return-Path: <stable+bounces-81570-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4CB99462F
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05496286B28
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 11:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3611DF98C;
	Tue,  8 Oct 2024 11:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sWQw+pO8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50EB1DF981;
	Tue,  8 Oct 2024 11:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728385529; cv=none; b=bruRK8F8DGa3IEpAqwlERK/gO4vCm232RiXk8YZk+FdqyHAc1mXWgNgP2nLqOTEj6XIhcRwJrnDQC68PU287Vh9qzh9l8g/rtmI5BvPCLErYf3QPl7RPckBa6VQChclmfV87hTCfpMBbxUSBiOMRJEnLSyXrIoOsiDMttCDPaIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728385529; c=relaxed/simple;
	bh=uIa4KGwhFx3LNKZBeUu/lhp2jdewkGAxty3TTR0RmHk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Iazzx00wiAIIfQauJ9WOTl58ObGMNTnvPXbXOJV26mVBCJQtkBstwq9hGZGh+w7haDEOmCIYLPHZfMjbRXywC2eukpHeIvsa1+QygbNi0bxigWgC9n2sqyiSKhY96UnRx00lo50p4I8CPnFyym/uvBZwSVVKKPmfcDd+Xytrx6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sWQw+pO8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F1FC4CED1;
	Tue,  8 Oct 2024 11:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728385528;
	bh=uIa4KGwhFx3LNKZBeUu/lhp2jdewkGAxty3TTR0RmHk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sWQw+pO8EL0POxNsG5NkKZJuS4rW2izDc3/CpLCqiRFlkyLxIoKagxSFx8lv25Pg7
	 j4DKb06sw/9XZHgqg31QN3rq4VuRtT3eyrdbI9kMQ9LeIvkmxiAGBzBKusv9nxsx0c
	 +W4/lN/xIkrFb5KNUVVDBMWUL5oSXWaaDxaVa5yT+yxf6tCbvZDSKcBrJSw68QTUXP
	 E5ire3vYHh9Z2615qFR3xszURenpLcD6SUwE91UL78Drk+K0ooW48f8chmK0wcMDg2
	 p9ABRhxHiSp0mKMgWPWotwgdX799qbKaWDbugfw42U328g+IVzCs1zlS5K0CcuZkuj
	 7oPnVvy4i1UBQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 08 Oct 2024 13:04:54 +0200
Subject: [PATCH net 3/4] mptcp: fallback when MPTCP opts are dropped after
 1st data
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-net-mptcp-fallback-fixes-v1-3-c6fb8e93e551@kernel.org>
References: <20241008-net-mptcp-fallback-fixes-v1-0-c6fb8e93e551@kernel.org>
In-Reply-To: <20241008-net-mptcp-fallback-fixes-v1-0-c6fb8e93e551@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Florian Westphal <fw@strlen.de>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 Christoph Paasch <cpaasch@apple.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3751; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=uIa4KGwhFx3LNKZBeUu/lhp2jdewkGAxty3TTR0RmHk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnBRHrX0Pa/sFum93bYCWw25/ScAxBtjfvoCqqe
 OHxp+q92gWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZwUR6wAKCRD2t4JPQmmg
 c0ZWEAC3csET5nAmzbm4UP5hPl+3hTIzHwP9vcqWBhHodGp8YHe/qz8GdKy4GUDmwECffjg2Xnb
 OxYyMwvqba7YSpk43/HjJw9Q7pdy6gQv40F8yBWUoAVw1nUF4uL2hOdAS28UAgiUsuJ9xL+ZKWZ
 hWbPMrubGlIGl+c0ncd1qDzggbmP1hR1XeeRCdqG4e9uMCTmYdXRj1RZ8ONF3UfXhYIfAZjRB7V
 Yhou+Ttq9NEcOwr8pqJhNbpGsqZuPhhzakfDnLanAZviRspTXQMBfZVc8s8eBKshyx7mZQJv1Z1
 KU0yKLPbp+iq/CjSTuvPa91q+YW6zYjrYN6DEQTKHsVUcGVBxYYGfgKnHag/qcnq1LyrX/Czthr
 nNzE4iWJQAVsBSs1084Z69g8i3K+0gP7dLGTsg6Be6zYBHwmiSlRsk8Jh5X3HzCZCMzvgkT3z4P
 SRX3v7xlTAwepwafmHf1XxGjTlJZ0JR2t2N/fNzAlVuaboK/8ixgpEd74wLozQeDhcYIRE+Ksrq
 m9eK5Oh0H8yIFTO62cYTnTv8Cjvz46OE9WKsKpzhTahXqjzb+o3UQqWeXBDWIS59xbSFxqPQe8F
 cpg4rrl7efbe+BNYNgt8wAh4sRpmEb/ZlYkh6vN9eo3cWo3Bjo6ZG5G0guGnPqzY6uRXCIHoENx
 10eA0T9epjnDLmg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

As reported by Christoph [1], before this patch, an MPTCP connection was
wrongly reset when a host received a first data packet with MPTCP
options after the 3wHS, but got the next ones without.

According to the MPTCP v1 specs [2], a fallback should happen in this
case, because the host didn't receive a DATA_ACK from the other peer,
nor receive data for more than the initial window which implies a
DATA_ACK being received by the other peer.

The patch here re-uses the same logic as the one used in other places:
by looking at allow_infinite_fallback, which is disabled at the creation
of an additional subflow. It's not looking at the first DATA_ACK (or
implying one received from the other side) as suggested by the RFC, but
it is in continuation with what was already done, which is safer, and it
fixes the reported issue. The next step, looking at this first DATA_ACK,
is tracked in [4].

This patch has been validated using the following Packetdrill script:

   0 socket(..., SOCK_STREAM, IPPROTO_MPTCP) = 3
  +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
  +0 bind(3, ..., ...) = 0
  +0 listen(3, 1) = 0

  // 3WHS is OK
  +0.0 < S  0:0(0)       win 65535  <mss 1460, sackOK, nop, nop, nop, wscale 6, mpcapable v1 flags[flag_h] nokey>
  +0.0 > S. 0:0(0) ack 1            <mss 1460, nop, nop, sackOK, nop, wscale 8, mpcapable v1 flags[flag_h] key[skey]>
  +0.1 <  . 1:1(0) ack 1 win 2048                                              <mpcapable v1 flags[flag_h] key[ckey=2, skey]>
  +0 accept(3, ..., ...) = 4

  // Data from the client with valid MPTCP options (no DATA_ACK: normal)
  +0.1 < P. 1:501(500) ack 1 win 2048 <mpcapable v1 flags[flag_h] key[skey, ckey] mpcdatalen 500, nop, nop>
  // From here, the MPTCP options will be dropped by a middlebox
  +0.0 >  . 1:1(0)     ack 501        <dss dack8=501 dll=0 nocs>

  +0.1 read(4, ..., 500) = 500
  +0   write(4, ..., 100) = 100

  // The server replies with data, still thinking MPTCP is being used
  +0.0 > P. 1:101(100)   ack 501          <dss dack8=501 dsn8=1 ssn=1 dll=100 nocs, nop, nop>
  // But the client already did a fallback to TCP, because the two previous packets have been received without MPTCP options
  +0.1 <  . 501:501(0)   ack 101 win 2048

  +0.0 < P. 501:601(100) ack 101 win 2048
  // The server should fallback to TCP, not reset: it didn't get a DATA_ACK, nor data for more than the initial window
  +0.0 >  . 101:101(0)   ack 601

Note that this script requires Packetdrill with MPTCP support, see [3].

Fixes: dea2b1ea9c70 ("mptcp: do not reset MP_CAPABLE subflow on mapping errors")
Cc: stable@vger.kernel.org
Reported-by: Christoph Paasch <cpaasch@apple.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/518 [1]
Link: https://datatracker.ietf.org/doc/html/rfc8684#name-fallback [2]
Link: https://github.com/multipath-tcp/packetdrill [3]
Link: https://github.com/multipath-tcp/mptcp_net-next/issues/519 [4]
Reviewed-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/subflow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index e1046a696ab5c79a2cef79870eb79637b432fcd5..25dde81bcb7575958635aaf14a5b8e9a5005e05f 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1282,7 +1282,7 @@ static bool subflow_can_fallback(struct mptcp_subflow_context *subflow)
 	else if (READ_ONCE(msk->csum_enabled))
 		return !subflow->valid_csum_seen;
 	else
-		return !subflow->fully_established;
+		return READ_ONCE(msk->allow_infinite_fallback);
 }
 
 static void mptcp_subflow_fail(struct mptcp_sock *msk, struct sock *ssk)

-- 
2.45.2


