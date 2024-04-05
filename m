Return-Path: <stable+bounces-36120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8E089A031
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 16:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1BBD28249B
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 14:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E4A16F27F;
	Fri,  5 Apr 2024 14:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h32LF6yT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28FC16D331;
	Fri,  5 Apr 2024 14:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712328702; cv=none; b=afyNO+NMbfq5hPohO5ERa45Bjt/R9AkCY1L1TBcuMkO3w2GpAk/8Nvk4cyCDaXn1YpOpA+u1CfrbsLUc+us5AQba1m880JbFCWIG8OPMbqTyF4rkQ0QOSJ3tyBh18natualL4rS4WyUqR3BNxJZZmqieGxPVXzUQJa6OXXTh94E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712328702; c=relaxed/simple;
	bh=7VtadKXfre4/0B6p1wfQIXTituwW4IaCsTTe3fFhHc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gmaHgBMMJkGfn8mE+602hm0TS+Kml5s+KgCNmRvH3t+PJKgz+crcC/wmg6TesddaFSd0SdyKnV51pr68ezbnF8viwQ2dgM+bSoGNyfCr6IRCvdTIyOALW4QsbUz4ycaHSIjX9BxbDKJOL//ORe88HQQQw43Gwvw8+tURJdrK1PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h32LF6yT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B532C433F1;
	Fri,  5 Apr 2024 14:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712328701;
	bh=7VtadKXfre4/0B6p1wfQIXTituwW4IaCsTTe3fFhHc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h32LF6yTxPXDjZbSTEa4+Vg9Qwk1KPxkD68V/z+0atRIA+OfzfRwDWBQcWfFpXBV6
	 k5Kag94+hk31HDJMhb6OnL0at50A9RUq4HgxkEPFuzMGxNrl7V1fp92khtsoEcxv7Y
	 aETlzlNcq8uyb/BCLV0STRONzQIrF8+FDZYs3Rj5wxjuHBqxyxnb3HjTCWOmx32rrH
	 g/X/BKhK8r8WtLIGqOR/HdkVQ94+zI4qSsKUHtJFq0Yar+K1DXp81iJssLZl6oUAs6
	 EnqNhKLLWBdM0jJ5+wIC6y8PyfkrsQbL4g3PtLYr7c2x/w9R8sPiCqVEH3J+NXAGp3
	 D/aHC2IEjGcyA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Davide Caratti <dcaratti@redhat.com>,
	Christoph Paasch <cpaasch@apple.com>,
	Mat Martineau <martineau@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.8.y 3/3] mptcp: don't account accept() of non-MPC client as fallback to TCP
Date: Fri,  5 Apr 2024 16:51:21 +0200
Message-ID: <20240405145117.854766-8-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024040519-palpable-barrel-9103@gregkh>
References: <2024040519-palpable-barrel-9103@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4686; i=matttbe@kernel.org; h=from:subject; bh=yw4rY6INu8vdujra2LYVHRqM1Laf0OU2wo5D/a5AdeU=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmEA/mQXI7xMBs0ihTZaiHKmO/4OjYdGL40rdpO bIXPD7pwMiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZhAP5gAKCRD2t4JPQmmg cx3SEACrP3F8qFjDMfW5Q8+lGlXfIZ3ED5VDUD8sgCp4z0x10iqGspNwuHJ9z6eSmfSdwu9xhOR YlZSopT1gXmJQ10Z43axRedPhTLOi0JIAlfMNkgkvuIy9ZjZbC1D9L35HbqHC7maiFiDxA0CV8g 3SuCgmXcFvBxv1v0LHVB/RhMSoTlrg+o+slXAhq2orELGQbMHHbUwAND4SspqNY16I/uo2S1oGO sBoQIJuV6qZ9dLb7sEusjJo+blveaKJLsazZ6ERTlMK9pdTUpHsDU490Kp+1C8YmYJBKOKPkMKT WJS43+zhjGjKtc/Kl3N6vKAcGPQx73G4J6ZCR8Eyp3689x7XKwLEwIZL/f5P8OrHL2hishr2+qC +UVyEi93m7P8xetNwkDK2bbNDgKUkSJvnwGxxXpT5N2E6l1dFpsylFBBPGZ3RLepMJqq0Z1/QsC PPCEFmZZpSplCOOJS30gedhZistcjt9D20Jmx7U8mxYsYmhD8Tps9sYYox9swWGy3UWXwbsWS/8 ue4ILByjprkCqAxYTipRsoQdZpONaw9+HbCcQWwEiITKAQ8vQa20JtG++5+uIuGxdXHONNlzCA/ 7jZ6tqWcCXOd5a0tpuqHpxAYnCSAiY8xeapa95GnSKprWPc3wLFlQN9sxLyiFDWp9h5zXOtpqvz 6oHljnupnLwtY/Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Davide Caratti <dcaratti@redhat.com>

Current MPTCP servers increment MPTcpExtMPCapableFallbackACK when they
accept non-MPC connections. As reported by Christoph, this is "surprising"
because the counter might become greater than MPTcpExtMPCapableSYNRX.

MPTcpExtMPCapableFallbackACK counter's name suggests it should only be
incremented when a connection was seen using MPTCP options, then a
fallback to TCP has been done. Let's do that by incrementing it when
the subflow context of an inbound MPC connection attempt is dropped.
Also, update mptcp_connect.sh kselftest, to ensure that the
above MIB does not increment in case a pure TCP client connects to a
MPTCP server.

Fixes: fc518953bc9c ("mptcp: add and use MIB counter infrastructure")
Cc: stable@vger.kernel.org
Reported-by: Christoph Paasch <cpaasch@apple.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/449
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://lore.kernel.org/r/20240329-upstream-net-20240329-fallback-mib-v1-1-324a8981da48@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 7a1b3490f47e88ec4cbde65f1a77a0f4bc972282)
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c                               | 2 --
 net/mptcp/subflow.c                                | 2 ++
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 9 +++++++++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7833a49f6214..2b921af2718d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3916,8 +3916,6 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 				mptcp_set_state(newsk, TCP_CLOSE);
 		}
 	} else {
-		MPTCP_INC_STATS(sock_net(ssk),
-				MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK);
 tcpfallback:
 		newsk->sk_kern_sock = kern;
 		lock_sock(newsk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 71ba86246ff8..13f66d11b7a0 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -905,6 +905,8 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 	return child;
 
 fallback:
+	if (fallback)
+		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK);
 	mptcp_subflow_drop_ctx(child);
 	return child;
 }
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index f8e1b3daa748..713de8182222 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -391,12 +391,14 @@ do_transfer()
 	local stat_cookierx_last
 	local stat_csum_err_s
 	local stat_csum_err_c
+	local stat_tcpfb_last_l
 	stat_synrx_last_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableSYNRX")
 	stat_ackrx_last_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableACKRX")
 	stat_cookietx_last=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesSent")
 	stat_cookierx_last=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesRecv")
 	stat_csum_err_s=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtDataCsumErr")
 	stat_csum_err_c=$(mptcp_lib_get_counter "${connector_ns}" "MPTcpExtDataCsumErr")
+	stat_tcpfb_last_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableFallbackACK")
 
 	timeout ${timeout_test} \
 		ip netns exec ${listener_ns} \
@@ -465,11 +467,13 @@ do_transfer()
 	local stat_cookietx_now
 	local stat_cookierx_now
 	local stat_ooo_now
+	local stat_tcpfb_now_l
 	stat_synrx_now_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableSYNRX")
 	stat_ackrx_now_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableACKRX")
 	stat_cookietx_now=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesSent")
 	stat_cookierx_now=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesRecv")
 	stat_ooo_now=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtTCPOFOQueue")
+	stat_tcpfb_now_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableFallbackACK")
 
 	expect_synrx=$((stat_synrx_last_l))
 	expect_ackrx=$((stat_ackrx_last_l))
@@ -516,6 +520,11 @@ do_transfer()
 		fi
 	fi
 
+	if [ ${stat_ooo_now} -eq 0 ] && [ ${stat_tcpfb_last_l} -ne ${stat_tcpfb_now_l} ]; then
+		mptcp_lib_pr_fail "unexpected fallback to TCP"
+		rets=1
+	fi
+
 	if [ $cookies -eq 2 ];then
 		if [ $stat_cookietx_last -ge $stat_cookietx_now ] ;then
 			extra+=" WARN: CookieSent: did not advance"
-- 
2.43.0


