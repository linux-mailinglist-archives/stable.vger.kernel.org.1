Return-Path: <stable+bounces-36140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAB689A298
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 18:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83D00287484
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 16:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB90219E4;
	Fri,  5 Apr 2024 16:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igRQi3KJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1E16AB6;
	Fri,  5 Apr 2024 16:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712334932; cv=none; b=BgTxMHKxBvzFRb2sjQ3FaFycySeYHmCD0UVk6mCdFEFTWnmak6licQrQv4I+qfqZ/rdRnCi++IPovlltKchRDJ5xI+ykMXITDpSeYSGhjonChFCj1PnGV8i1Zr1GPKz4/zc2fSgDwKM4lQrRXbGrIGzvQKk8QsSc37q7Pq5YZUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712334932; c=relaxed/simple;
	bh=p/+QpX0KlgkdLBwbAK4Hs4k1UkbMmcEgsjTKeopdg3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HyurtkG9AulBICfiPiOgGWfxc6KGUUX7TWTGw+fAc3wefLCg3Kwbf+WyOhDIPynX7MmSZSkIotMk05rEfllTwuDC0YMyE++GgH35QLOWnMwAhuYLm0L6a2I7Rk98W2spbZXIIbbjWV1frjJcJ3deHqDKFg5VyMzdI/b48IcA00Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=igRQi3KJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C88FC433C7;
	Fri,  5 Apr 2024 16:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712334932;
	bh=p/+QpX0KlgkdLBwbAK4Hs4k1UkbMmcEgsjTKeopdg3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=igRQi3KJIGUhmay5u1dWjibiBnPBTsjlOkK9QLay4szt3+dTT2vOG3Fre364mew6e
	 t1saKe2WVsWmYCkPoSLUt3ft3akmEfV56bf5Y7MtyFWJl+djcuq9ra8W/8tGiImqSD
	 t+HFQ+8IymudMvt3/8uQ+3mCYDdlrWxowykuV1dW3hvdLkmeSZpP6TnTx7WRgLrNK3
	 Ih3rseuGD8mHynjyyHFE8D5EWR/g/DEVytGy/jwntrMCz81Zw5re4m/LUmyLFu03eJ
	 OO05Nz08D9oDNwrPBXuPtBcE5WYF0q0x7XAMnEdIGJ6CliXHuJ7u6Oxgk2+ZbabY2s
	 RHmb1bhedduLw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Davide Caratti <dcaratti@redhat.com>,
	Christoph Paasch <cpaasch@apple.com>,
	Mat Martineau <martineau@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y] mptcp: don't account accept() of non-MPC client as fallback to TCP
Date: Fri,  5 Apr 2024 18:35:22 +0200
Message-ID: <20240405163521.1221351-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024040522-tremor-freehand-618e@gregkh>
References: <2024040522-tremor-freehand-618e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4810; i=matttbe@kernel.org; h=from:subject; bh=GsftLZFFdBRa1yvvDkcfllC5qjRTCi2xFub5bG7Zxrk=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmEChKf3JEpQYaGsNO6VehhcyRV/EV1jpi1o71t RoFqU6ZZuaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZhAoSgAKCRD2t4JPQmmg cxdoEADQ4878KZoHcpNjL35ZxUnscSW9EyGsKQ2wEAFSX05feQJI3Mh7MmY8ORW57NNsipJAeAn /bXOdWk+qbOTJtXj5n+MPHY1KdQWsMCSLDxqBNofD2pD26SLKX2CYXAiwVCNdkWoGHLjiGCYebj DJ02QqowRPGXDznPf00dMtNKrrRMnvXSLlQ/ntg6aBcCmk6tnkyA/HJ+FbZmU0OA2aRP77DlS7S EQgBK24Ujh2MUjjQdvdw9uKIIaOYo7T/ixrs7zH5VhMgWGo+8RRIHFM6g+8mwTYs7G8AyZglMOU k58YGgjrCX7d+P99TCs3EgPzzj3gyLj0eLc2x4DGWc5Z5GiB8JmtDmnIGIe7atCId6z+RVVzvfn 60NPTiwmOjlpF9aagaKjay7mMtOvdoi6wBhyI6CwvR/Sc9rbyB1eENIqttbTpZ6TNN1H3gg+Wom LNItvoqqpdvlIBrAwX1Bzk8O7JvKJX5m/3M6U4zFZuULttc/HZz+c+YuoTdLpuHDJdxfS/TmrFB qgfNUfyOqIxpcbEdTdOw01IWeZhc7lwhj6nKyzI/vFrj3F6IbPCwYZqRwXaLWB29yVA6xE3u+J/ gvlIRXUlC7oCLYb7VZz8OPAKWsaFrCHZKzRTGMp6SUx4h22IxsxS9Zi5uQrbZX30+3yNYQVVSBJ RGFL5cggICXbKng==
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
 net/mptcp/subflow.c                                | 2 ++
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 7 +++++++
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3bc21581486a..c652c8ca765c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3349,9 +3349,6 @@ static struct sock *mptcp_accept(struct sock *sk, int flags, int *err,
 
 		newsk = new_mptcp_sock;
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEPASSIVEACK);
-	} else {
-		MPTCP_INC_STATS(sock_net(sk),
-				MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK);
 	}
 
 out:
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 891c2f4fed08..f1d422396b28 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -816,6 +816,8 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 	return child;
 
 fallback:
+	if (fallback)
+		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK);
 	mptcp_subflow_drop_ctx(child);
 	return child;
 }
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 18c9b00ca058..dacf4cf2246d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -439,6 +439,7 @@ do_transfer()
 	local stat_cookierx_last=$(get_mib_counter "${listener_ns}" "TcpExtSyncookiesRecv")
 	local stat_csum_err_s=$(get_mib_counter "${listener_ns}" "MPTcpExtDataCsumErr")
 	local stat_csum_err_c=$(get_mib_counter "${connector_ns}" "MPTcpExtDataCsumErr")
+	local stat_tcpfb_last_l=$(get_mib_counter "${listener_ns}" "MPTcpExtMPCapableFallbackACK")
 
 	timeout ${timeout_test} \
 		ip netns exec ${listener_ns} \
@@ -504,6 +505,7 @@ do_transfer()
 	local stat_cookietx_now=$(get_mib_counter "${listener_ns}" "TcpExtSyncookiesSent")
 	local stat_cookierx_now=$(get_mib_counter "${listener_ns}" "TcpExtSyncookiesRecv")
 	local stat_ooo_now=$(get_mib_counter "${listener_ns}" "TcpExtTCPOFOQueue")
+	local stat_tcpfb_now_l=$(get_mib_counter "${listener_ns}" "MPTcpExtMPCapableFallbackACK")
 
 	expect_synrx=$((stat_synrx_last_l))
 	expect_ackrx=$((stat_ackrx_last_l))
@@ -548,6 +550,11 @@ do_transfer()
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


