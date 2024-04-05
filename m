Return-Path: <stable+bounces-36024-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97631899556
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 08:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D1F71F23975
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 06:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B072D22626;
	Fri,  5 Apr 2024 06:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SndZrM3n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C7A1803D
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 06:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712298582; cv=none; b=VkgvDdf0qSBTydlfKPlMHcDHhgErkaRJLwpkKLWsXAGPLQV3Au/3IofuseSw71JTZRb4spU62QnyJeof+0E+3EOFFdFlQFEcO+RLo8PG0+nrP2EOe8a+3GLZYmQ22FU6lqxjR12KrHvUb563g2oRbCrHGNBLNBHfTfgzh10uDx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712298582; c=relaxed/simple;
	bh=bTfBhIjCaL7lM4vT9b4+nSp6Nmx7h9w2rzS4HrNZdVI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QGMCJLDFvX3q1/38ZzECMRMwdsIaJYuCT/TblsnbcfDHUFNdNGgF14KGKK9Dg4ubV6GPGhPrwdD52InyoEYAqCCDO7ILtq92j/7epBGVno4eycHKm4Xxxon6TZq3T24w/oRbqGL1+/KL2+SPDY9/EP7t7laGs2KJZpZTBXKSQ9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SndZrM3n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4495C433F1;
	Fri,  5 Apr 2024 06:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712298582;
	bh=bTfBhIjCaL7lM4vT9b4+nSp6Nmx7h9w2rzS4HrNZdVI=;
	h=Subject:To:Cc:From:Date:From;
	b=SndZrM3nAeslhZby9mdLmYvVGF9+KgfCTZRzipYPC6vFJbPL+0OXqQz+5CL66fFQO
	 bCmHIH7ZTJ6kgTokd6tq/JpZ/WouIbAe+dBbpcHC7ZfGkwRUC26MkmAHxrfaEebSM6
	 6JQfg1fEU91Ff7ZUpZR1E3rot+cHWKPaQQ6zKQIk=
Subject: FAILED: patch "[PATCH] mptcp: don't account accept() of non-MPC client as fallback" failed to apply to 5.10-stable tree
To: dcaratti@redhat.com,cpaasch@apple.com,kuba@kernel.org,martineau@kernel.org,matttbe@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 05 Apr 2024 08:29:24 +0200
Message-ID: <2024040524-stitch-resolute-ead5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 7a1b3490f47e88ec4cbde65f1a77a0f4bc972282
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024040524-stitch-resolute-ead5@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7a1b3490f47e88ec4cbde65f1a77a0f4bc972282 Mon Sep 17 00:00:00 2001
From: Davide Caratti <dcaratti@redhat.com>
Date: Fri, 29 Mar 2024 13:08:52 +0100
Subject: [PATCH] mptcp: don't account accept() of non-MPC client as fallback
 to TCP

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

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3a1967bc7bad..7e74b812e366 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3937,8 +3937,6 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 				mptcp_set_state(newsk, TCP_CLOSE);
 		}
 	} else {
-		MPTCP_INC_STATS(sock_net(ssk),
-				MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK);
 tcpfallback:
 		newsk->sk_kern_sock = kern;
 		lock_sock(newsk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 1626dd20c68f..6042a47da61b 100644
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
index 4c4248554826..4131f3263a48 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -383,12 +383,14 @@ do_transfer()
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
@@ -457,11 +459,13 @@ do_transfer()
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
@@ -508,6 +512,11 @@ do_transfer()
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


