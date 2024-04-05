Return-Path: <stable+bounces-36133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7ABC89A16D
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 17:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 075081C23B32
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 15:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA7F16D32C;
	Fri,  5 Apr 2024 15:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8xp3+FO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2D316FF2A;
	Fri,  5 Apr 2024 15:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712331443; cv=none; b=jiFWLDGSIdm7uSf/NehIPL85A+GOylB8bOsSz3PScLzs2I+p7hICO9UEYSWticuX3hIrrpAg33lu2040Z55QSxWB8fktTRCsZUYn2Il7+Zt6/GZiKh5VTsyiRJ0OMBiMAXE3xqyVQFYNRVZYFZvKsVta9uqRbay8uypiWZbMhzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712331443; c=relaxed/simple;
	bh=rE6d/stsYwMMdTfVw9+xOIHkpx4vop2zqk69liaFzMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bvvROES8oOYKq09MjTNbNnHhw+icqcOl2si6OoxBfKUHOWkvd+K7Hpsd3qAsBo78+/f4OkpnT9bRdvUKnl+exb89x92GIW6LAfSCyGJ3eYJ2+lJRuahK6ogoNOwH1padeS7JPUBMdFaKMATRKnNT+YMu7f4Dz56FJggf8V5krkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8xp3+FO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4D8C43394;
	Fri,  5 Apr 2024 15:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712331442;
	bh=rE6d/stsYwMMdTfVw9+xOIHkpx4vop2zqk69liaFzMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B8xp3+FOSb6FOT3SOyO/OAUwGNTKjrr13U1rePJD9vYxHW68k/6SjoMWD3VFw1KXq
	 n7FnGj9LARLqWSEnQ3QVGtJGbxAnU8eZiD25UEoMREJr4ZuPDscwBolCQV+MUoOGLA
	 GtBOyeGw7eGNCIXO/d5nIM5ijysHYeapAJSGTsX6AN5x8dD+b+fB/H+bfeMrTCimjj
	 156fevAgtk2+0eTn7yBsKHjnqhzDF/KaYlzVW5YtVRXZm7GsOB7kaXwq6IvRo8n9qH
	 aq8ZyF0bCVMgnsUHCnlx1nTZW9uIVTLL7kjJzba/p4xL6dy0u7INZ8vbATJFTYyecg
	 6D8UisobJTWxg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Davide Caratti <dcaratti@redhat.com>,
	Christoph Paasch <cpaasch@apple.com>,
	Mat Martineau <martineau@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y 5/5] mptcp: don't account accept() of non-MPC client as fallback to TCP
Date: Fri,  5 Apr 2024 17:36:42 +0200
Message-ID: <20240405153636.958019-12-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024040520-unselect-antitrust-a41b@gregkh>
References: <2024040520-unselect-antitrust-a41b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4686; i=matttbe@kernel.org; h=from:subject; bh=l/OsjxB+MpbAfxRpJT7WFpvzc4RCN9xeok2ZdToedY0=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmEBqFcjrSvlMm2b/yTBoiZGv+mHYCuL69J4rHl GRXp9HT72mJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZhAahQAKCRD2t4JPQmmg c1XVEACpOc6Fy0jm2ebfuFYDsAe5guEPUHH0ZtpmfXUNjjHrZqYMn+fxLeJ5paclI9FxPdCVUqD SHkKvLqhUhWC98TKbAp7Zc331+BjaKQfKcwgNHEuHai8RCioKHXCdNHnhcSr5XWGmUY6JlstpTo tI1LqjSiK9qWMCbd7X+ehP1v3ttiaLA+/uHi2/t7UMNF8CnPAqB0EKVk+sJVHMRSTzDOBFDsGmY 4pCm0N+tKwm+DYeDkdAv0vKnfxe2i72rnMptNGJq2zqY7EcuyRzU474iup6iRZ05fygDEDX1oRA w3Qd11FWDsXd4+pZKXnIPVCIGIsdOcERDKPKe4yv7Qp2P5Rm4wZZiKdjcK9iqzvFiiUyo5Oxjml hWkx+hdBFFNaExwRYf6QxoOthw5dNlfBVw2InZKVGmJD6kOIWcf8O5LRBadOcKQOj9AruWxZHtu nIQjQQHittQbFyMFikuC90FshirMvltGKlt6dhKWztuaZ1y2aHl8Wj7KFImECwetnl1nBgXtZA8 IUybWeYw1EvTYrOkpLV7HXtKZUR1IdYQ8/vvFGEseVCIl/BhWndEGX1xKP/c00wvVsuVST+cczy cew1mjN8/GQBvS6cTnszrwZHXhWZCQ9BwDxGu4PsN2OAfCk4+OR3atP95339C/ERVDphj3/CRRX XN/W7mrka967E2w==
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
index 35f9d59c8ded..01ac690af779 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3911,8 +3911,6 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 				mptcp_set_state(newsk, TCP_CLOSE);
 		}
 	} else {
-		MPTCP_INC_STATS(sock_net(ssk),
-				MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK);
 tcpfallback:
 		newsk->sk_kern_sock = kern;
 		lock_sock(newsk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index ab41700bee68..23ee96c6abcb 100644
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
index f40d3222442b..ffb2aff14690 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -433,12 +433,14 @@ do_transfer()
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
@@ -507,11 +509,13 @@ do_transfer()
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
@@ -558,6 +562,11 @@ do_transfer()
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


