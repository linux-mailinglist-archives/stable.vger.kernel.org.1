Return-Path: <stable+bounces-36145-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B1689A360
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 19:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0466C1C230F3
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 17:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B759171645;
	Fri,  5 Apr 2024 17:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="It/OiOX1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B88B16C858;
	Fri,  5 Apr 2024 17:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712337277; cv=none; b=KmsJWVo9c/gmNVno7F0U66JgSqk590/EkM1ONoEA4iSRCvdIKHE4E7ganrSHz1ABUBttAIk7mJn0A5P093nI7D02aamGrQczQrrbO7oycLPa6Daec4j+5iI3idydOXRrjC5UjPvne7b9gfeX6DEDvkSzL4LIhGHPim9CgNOr2O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712337277; c=relaxed/simple;
	bh=7KS+8uQDn3+UWDLsdqWI+ka4b54MG5rnGe8OuN9/We0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qz4rTrJzdd9FLWK3OiGlZ6/pna4ugylF1UUs//rSz75dpDBUkBwHCiHlzQ+B04AlZfpOYfkSaY3Mv9J9pIEDbINOJcm91GhCO4SZ3SjQG23qljJvH5g/+nItDtUhuUxdDmcPTvWIa8JXRRBCJCrKmljNiUjxV8AY6ePHpIW4zSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=It/OiOX1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD7EAC433F1;
	Fri,  5 Apr 2024 17:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712337276;
	bh=7KS+8uQDn3+UWDLsdqWI+ka4b54MG5rnGe8OuN9/We0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=It/OiOX1FqkuRW802LWR0AmqT9af15526bL1EOsOk9GBljQmCsLMX8ndcNsIO2e1F
	 z15mvdv3oGwmHTNFv8RCS50RbXXPOdzCpg2v/T88AZ+T7jG3RNMBGoheZY8SFgIR7O
	 KAv2BlFxIy1n3fu7ji0duPHtzNUko5hszwZSPJaTv5OT93PTBjlX40ufJMpUpKEOzk
	 IVS1QixgZmWUwjol50uKve/M69Z05GFA1usrPQf81klQOurW06RKtOQ25+Kky/5YHd
	 AfYgL4ZdYGnSc4tuwePvXm+MAPx+FsOqelC43jX6d4K6riD5PVPMyRsspHgWpAEZEy
	 NYeaNuP6SzpHA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Davide Caratti <dcaratti@redhat.com>,
	Christoph Paasch <cpaasch@apple.com>,
	Mat Martineau <martineau@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15.y] mptcp: don't account accept() of non-MPC client as fallback to TCP
Date: Fri,  5 Apr 2024 19:14:15 +0200
Message-ID: <20240405171415.1389330-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024040523-handling-conceded-2895@gregkh>
References: <2024040523-handling-conceded-2895@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5185; i=matttbe@kernel.org; h=from:subject; bh=WybP+5ScK2x6ufSrrqQgVxdnkoh2etpaZNO5gcKMwU4=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmEDFnjK39FsmoMdCJv0xpqjbWPTX2UfpEtMXzF e8JxQlZ7F6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZhAxZwAKCRD2t4JPQmmg czX3D/9jmdVSWh9mZIyfRfKKo96wyZGAQuTq/8LnSoCmkT9RZipPXj4Io2V7HYdsNO7UrrI/lRx iLpbKuiJSJ9yd1GzclkWBxWZLO4etd5b8PmkSNfjEnQttznXixA7G7h8WrmpsDxLVe3PInTpdwS xd55f3KgquDUEWaRXopz/cxPftpT/kLm9V30esn3KiVRuhFX/jB5HA92JbusTFNx4QESUXxva6g ntB3MkB2bFqprt/dqY9PqJN38RaiWpuU55oC9rNqPPZvaTFE8Ymq9W28aVRQY5k/tLbj8J+bX3K 5lrFJpgk9+98xW8oHCl/7YGXDHvBGvFfKL/oY7f/fMOGbSsBAtCFtYjD4tKbv47wjfWyEkrPNwr +WYnKTVHPEZe3nyQi0l/x98aVDApRKppm/sLJpOSk26wLf4N9jk96KfaMCIRpfFscp9vHPmvGnl mwJZBytRFzyXuKJuOn5/l9khzR6wZtXTjWb1vyl7MQmLihXPy+W3cBC0dF8lqTyJyb9NMIGigEN uThU55DAD3e0wNMX25Jd8dIHgqq7btTl/orHB1lleUzg7i8IxIAt0S6dXSzdZVYuag4akofUlRi irCOHnB1NbpF6vPq1RZD+WOEOAjuPulX2EaqD3lmmpxwkPnCqvbIvsocmXjwevXq6RaYc0VzAzJ M4Bf7WiUxAgA0RQ==
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
Notes:
  - Conflicts in protocol.c: because commit 8e2b8a9fa512 ("mptcp: don't
    overwrite sock_ops in mptcp_is_tcpsk()") is not in this version, but
    it depends on new features, making it hard to be backported, while
    the conflict resolution is easy: just remove the MIB incrementation
    from the previous location.
  - Conflicts in subflow.c: because commit a88d0092b24b ("mptcp:
    simplify subflow_syn_recv_sock()") is not in this version, but it
    depends on new features, making it hard to be backported, while the
    conflict resolution is easy: just move the MIB incrementation where
    the subflow context is dropped (fallback to TCP).
  - Conflicts in mptcp_connect.sh: because commit e3aae1098f10
    ("selftests: mptcp: connect: fix shellcheck warnings") and commit
    e7c42bf4d320 ("selftests: mptcp: use += operator to append strings")
    are not in this version. The dependency chain looks too long, while
    resolving the conflicts was not difficult:
      - using get_mib_counter() instead of the new
        mptcp_lib_get_counter()
      - writing the error message with 'printf' instead of the new
        mptcp_lib_pr_fail().
---
 net/mptcp/protocol.c                               | 3 ---
 net/mptcp/subflow.c                                | 3 +++
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 7 +++++++
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5db1c0142abb..cde62dafda49 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3018,9 +3018,6 @@ static struct sock *mptcp_accept(struct sock *sk, int flags, int *err,
 		sock_hold(new_mptcp_sock);
 		newsk = new_mptcp_sock;
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEPASSIVEACK);
-	} else {
-		MPTCP_INC_STATS(sock_net(sk),
-				MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK);
 	}
 
 out:
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 80230787554e..ff7239fe3d2c 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -725,6 +725,9 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 				goto dispose_child;
 			}
 
+			if (fallback)
+				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK);
+
 			subflow_drop_ctx(child);
 			goto out;
 		}
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 8efff3f9c52a..5a1277d17286 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -451,6 +451,7 @@ do_transfer()
 	local stat_cookierx_last=$(get_mib_counter "${listener_ns}" "TcpExtSyncookiesRecv")
 	local stat_csum_err_s=$(get_mib_counter "${listener_ns}" "MPTcpExtDataCsumErr")
 	local stat_csum_err_c=$(get_mib_counter "${connector_ns}" "MPTcpExtDataCsumErr")
+	local stat_tcpfb_last_l=$(get_mib_counter "${listener_ns}" "MPTcpExtMPCapableFallbackACK")
 
 	timeout ${timeout_test} \
 		ip netns exec ${listener_ns} \
@@ -516,6 +517,7 @@ do_transfer()
 	local stat_cookietx_now=$(get_mib_counter "${listener_ns}" "TcpExtSyncookiesSent")
 	local stat_cookierx_now=$(get_mib_counter "${listener_ns}" "TcpExtSyncookiesRecv")
 	local stat_ooo_now=$(get_mib_counter "${listener_ns}" "TcpExtTCPOFOQueue")
+	local stat_tcpfb_now_l=$(get_mib_counter "${listener_ns}" "MPTcpExtMPCapableFallbackACK")
 
 	expect_synrx=$((stat_synrx_last_l))
 	expect_ackrx=$((stat_ackrx_last_l))
@@ -560,6 +562,11 @@ do_transfer()
 		fi
 	fi
 
+	if [ ${stat_ooo_now} -eq 0 ] && [ ${stat_tcpfb_last_l} -ne ${stat_tcpfb_now_l} ]; then
+		printf "[ FAIL ]\nunexpected fallback to TCP"
+		rets=1
+	fi
+
 	if [ $retc -eq 0 ] && [ $rets -eq 0 ]; then
 		printf "[ OK ]"
 	fi
-- 
2.43.0


