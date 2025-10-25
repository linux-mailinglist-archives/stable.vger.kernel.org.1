Return-Path: <stable+bounces-189328-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 767DFC093D8
	for <lists+stable@lfdr.de>; Sat, 25 Oct 2025 18:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD9C71897BE3
	for <lists+stable@lfdr.de>; Sat, 25 Oct 2025 16:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A563043B4;
	Sat, 25 Oct 2025 16:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WvVWU99+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FEA21767C;
	Sat, 25 Oct 2025 16:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761408714; cv=none; b=WmDdhv1iwufu4vnSEkRhbL1ZH1QNMt5VyZ3N8QvC9Zt3q8yU5d+WffjzAr6S1y1fmJqgogbiwLSr8Wzgk5IelJEViGSn8v7lKVtBZ3nAmDwk1qVNO+W4FuJIi74S1IRXg0uH8edHTwJeR7Zq1MYZESMJa55nsr43/hikOARygKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761408714; c=relaxed/simple;
	bh=ml5iXBgMekbfkEjlemxXrIQft3qOOZyOi21L6BZUmsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LrMPiUfHDJWw9MOqbjdPZBWKo832UTsXF2c1rcadnFSeCCJz3ToAO2SXGJNkw2vFuHNVlmge3POTi8wl0Pe/p2C5Lynj8NhG6fPw1q8nAxlo6mRka2i+F+/6lB3NgbN+Rxzn5otVzEXjPVSvGx9oqOKRyh2InxPddzVem+nlttI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WvVWU99+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58832C4CEFB;
	Sat, 25 Oct 2025 16:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761408714;
	bh=ml5iXBgMekbfkEjlemxXrIQft3qOOZyOi21L6BZUmsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WvVWU99+OHvQp7Zvufn36u+2T0hnq76OMMot4WyR1hjBkUh/zZw2uLNFy589OdngP
	 Vt7KUHP+BgkxjG+VMEEplyQnXQVsgggeuQrp/MPdEYK9h6VwZ0VDfKaCV9I/tskvdX
	 THkptY3aIDNhueovVgw3WJ9ArXNPOyuz8RV9WUsrDJWcTeG7KLWonHk1gsbVjfDVy6
	 1O1OdqO0SjYB+FkqdU15PUdYruIH9KRdrFtkqyQgRwjrNxEDpVWxTI+jJfglDkgtoX
	 ZPOjD3nEgPXt+O/HvSn2j5fRTybtJr8cwk4GDQX9tlV1RuQ45BApec4qOF5jzvGE1+
	 YYsxxGkBykOTw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-6.1] selftests: net: replace sleeps in fcnal-test with waits
Date: Sat, 25 Oct 2025 11:54:41 -0400
Message-ID: <20251025160905.3857885-50-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025160905.3857885-1-sashal@kernel.org>
References: <20251025160905.3857885-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 15c068cb214d74a2faca9293b25f454242d0d65e ]

fcnal-test.sh already includes lib.sh, use relevant helpers
instead of sleeping. Replace sleep after starting nettest
as a server with wait_local_port_listen.

Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://patch.msgid.link/20250909223837.863217-1-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES

Explanation
- What changed: Replaces fixed sleeps after starting nettest servers
  with explicit readiness waits via lib.sh’s helper. Example
  conversions:
  - TCP example: tools/testing/selftests/net/fcnal-test.sh:880 waits for
    server in `NSA` to LISTEN on `12345` before client connects.
  - UDP example: tools/testing/selftests/net/fcnal-test.sh:1527 uses
    `udp` to wait for the bound socket.
  - Server in peer namespace: tools/testing/selftests/net/fcnal-
    test.sh:1226 uses `${NSB}` to wait on the correct namespace.
  - Port chosen dynamically: tools/testing/selftests/net/fcnal-
    test.sh:4226, tools/testing/selftests/net/fcnal-test.sh:4231 wait on
    `${port}`.

- Why it’s safer: The helper `wait_local_port_listen()` is already
  provided by the shared test library and included at the top of the
  script:
  - Sourced: tools/testing/selftests/net/fcnal-test.sh:40
  - Helper definition: tools/testing/selftests/net/lib.sh:628 checks
    `/proc/net/{tcp,udp}` in the proper namespace; for TCP it ensures
    state `0A` (LISTEN).
  - Many other selftests already rely on this helper, e.g.
    tools/testing/selftests/net/tfo_passive.sh:89 and
    tools/testing/selftests/net/udpgro.sh:54, so usage is consistent and
    field-tested.

- Impact and risk:
  - Selftests-only; no kernel code changes. Improves determinism and
    reduces flakiness by waiting for readiness instead of sleeping a
    fixed time.
  - The helper polls up to ~1s total (10×0.1s); previous code slept 1s
    unconditionally. This is strictly better or equal in both speed and
    reliability.
  - Correct protocol is used (`tcp` vs `udp`) and correct namespace is
    passed in each updated call, matching where the server was started
    (e.g., tools/testing/selftests/net/fcnal-test.sh:1218–1231,
    1514–1532).
  - Minor nit: one commented-out negative-test block gained an
    uncommented wait, adding up to ~1s overhead even though the server
    isn’t started (tools/testing/selftests/net/fcnal-test.sh:3164–3170).
    This does not affect correctness, only adds a small delay; it’s
    acceptable but could be trivially cleaned in a follow-up.

- Stable backport criteria:
  - Important test reliability improvement; small, contained to
    selftests; no API or architectural changes; minimal risk of
    regression.
  - The required helper exists in the same tree
    (tools/testing/selftests/net/lib.sh:628). For older stable branches,
    ensure lib.sh already contains this helper; for current 6.17 it
    does.

Conclusion
- This is a good, low-risk selftests improvement that reduces flakiness
  and aligns with existing patterns. Recommend backporting to stable.

 tools/testing/selftests/net/fcnal-test.sh | 428 +++++++++++-----------
 1 file changed, 214 insertions(+), 214 deletions(-)

diff --git a/tools/testing/selftests/net/fcnal-test.sh b/tools/testing/selftests/net/fcnal-test.sh
index 4fcc38907e48e..f0fb114764b24 100755
--- a/tools/testing/selftests/net/fcnal-test.sh
+++ b/tools/testing/selftests/net/fcnal-test.sh
@@ -875,7 +875,7 @@ ipv4_tcp_md5_novrf()
 	# basic use case
 	log_start
 	run_cmd nettest -s -M ${MD5_PW} -m ${NSB_IP} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsb nettest -r ${NSA_IP} -X ${MD5_PW}
 	log_test $? 0 "MD5: Single address config"
 
@@ -883,7 +883,7 @@ ipv4_tcp_md5_novrf()
 	log_start
 	show_hint "Should timeout due to MD5 mismatch"
 	run_cmd nettest -s &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsb nettest -r ${NSA_IP} -X ${MD5_PW}
 	log_test $? 2 "MD5: Server no config, client uses password"
 
@@ -891,7 +891,7 @@ ipv4_tcp_md5_novrf()
 	log_start
 	show_hint "Should timeout since client uses wrong password"
 	run_cmd nettest -s -M ${MD5_PW} -m ${NSB_IP} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsb nettest -r ${NSA_IP} -X ${MD5_WRONG_PW}
 	log_test $? 2 "MD5: Client uses wrong password"
 
@@ -899,7 +899,7 @@ ipv4_tcp_md5_novrf()
 	log_start
 	show_hint "Should timeout due to MD5 mismatch"
 	run_cmd nettest -s -M ${MD5_PW} -m ${NSB_LO_IP} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsb nettest -r ${NSA_IP} -X ${MD5_PW}
 	log_test $? 2 "MD5: Client address does not match address configured with password"
 
@@ -910,7 +910,7 @@ ipv4_tcp_md5_novrf()
 	# client in prefix
 	log_start
 	run_cmd nettest -s -M ${MD5_PW} -m ${NS_NET} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsb nettest  -r ${NSA_IP} -X ${MD5_PW}
 	log_test $? 0 "MD5: Prefix config"
 
@@ -918,7 +918,7 @@ ipv4_tcp_md5_novrf()
 	log_start
 	show_hint "Should timeout since client uses wrong password"
 	run_cmd nettest -s -M ${MD5_PW} -m ${NS_NET} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsb nettest -r ${NSA_IP} -X ${MD5_WRONG_PW}
 	log_test $? 2 "MD5: Prefix config, client uses wrong password"
 
@@ -926,7 +926,7 @@ ipv4_tcp_md5_novrf()
 	log_start
 	show_hint "Should timeout due to MD5 mismatch"
 	run_cmd nettest -s -M ${MD5_PW} -m ${NS_NET} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsb nettest -c ${NSB_LO_IP} -r ${NSA_IP} -X ${MD5_PW}
 	log_test $? 2 "MD5: Prefix config, client address not in configured prefix"
 }
@@ -943,7 +943,7 @@ ipv4_tcp_md5()
 	# basic use case
 	log_start
 	run_cmd nettest -s -I ${VRF} -M ${MD5_PW} -m ${NSB_IP} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsb nettest -r ${NSA_IP} -X ${MD5_PW}
 	log_test $? 0 "MD5: VRF: Single address config"
 
@@ -951,7 +951,7 @@ ipv4_tcp_md5()
 	log_start
 	show_hint "Should timeout since server does not have MD5 auth"
 	run_cmd nettest -s -I ${VRF} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsb nettest -r ${NSA_IP} -X ${MD5_PW}
 	log_test $? 2 "MD5: VRF: Server no config, client uses password"
 
@@ -959,7 +959,7 @@ ipv4_tcp_md5()
 	log_start
 	show_hint "Should timeout since client uses wrong password"
 	run_cmd nettest -s -I ${VRF} -M ${MD5_PW} -m ${NSB_IP} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsb nettest -r ${NSA_IP} -X ${MD5_WRONG_PW}
 	log_test $? 2 "MD5: VRF: Client uses wrong password"
 
@@ -967,7 +967,7 @@ ipv4_tcp_md5()
 	log_start
 	show_hint "Should timeout since server config differs from client"
 	run_cmd nettest -s -I ${VRF} -M ${MD5_PW} -m ${NSB_LO_IP} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsb nettest -r ${NSA_IP} -X ${MD5_PW}
 	log_test $? 2 "MD5: VRF: Client address does not match address configured with password"
 
@@ -978,7 +978,7 @@ ipv4_tcp_md5()
 	# client in prefix
 	log_start
 	run_cmd nettest -s -I ${VRF} -M ${MD5_PW} -m ${NS_NET} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsb nettest  -r ${NSA_IP} -X ${MD5_PW}
 	log_test $? 0 "MD5: VRF: Prefix config"
 
@@ -986,7 +986,7 @@ ipv4_tcp_md5()
 	log_start
 	show_hint "Should timeout since client uses wrong password"
 	run_cmd nettest -s -I ${VRF} -M ${MD5_PW} -m ${NS_NET} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsb nettest -r ${NSA_IP} -X ${MD5_WRONG_PW}
 	log_test $? 2 "MD5: VRF: Prefix config, client uses wrong password"
 
@@ -994,7 +994,7 @@ ipv4_tcp_md5()
 	log_start
 	show_hint "Should timeout since client address is outside of prefix"
 	run_cmd nettest -s -I ${VRF} -M ${MD5_PW} -m ${NS_NET} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsb nettest -c ${NSB_LO_IP} -r ${NSA_IP} -X ${MD5_PW}
 	log_test $? 2 "MD5: VRF: Prefix config, client address not in configured prefix"
 
@@ -1005,14 +1005,14 @@ ipv4_tcp_md5()
 	log_start
 	run_cmd nettest -s -I ${VRF} -M ${MD5_PW} -m ${NSB_IP} &
 	run_cmd nettest -s -M ${MD5_WRONG_PW} -m ${NSB_IP} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsb nettest  -r ${NSA_IP} -X ${MD5_PW}
 	log_test $? 0 "MD5: VRF: Single address config in default VRF and VRF, conn in VRF"
 
 	log_start
 	run_cmd nettest -s -I ${VRF} -M ${MD5_PW} -m ${NSB_IP} &
 	run_cmd nettest -s -M ${MD5_WRONG_PW} -m ${NSB_IP} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsc nettest  -r ${NSA_IP} -X ${MD5_WRONG_PW}
 	log_test $? 0 "MD5: VRF: Single address config in default VRF and VRF, conn in default VRF"
 
@@ -1020,7 +1020,7 @@ ipv4_tcp_md5()
 	show_hint "Should timeout since client in default VRF uses VRF password"
 	run_cmd nettest -s -I ${VRF} -M ${MD5_PW} -m ${NSB_IP} &
 	run_cmd nettest -s -M ${MD5_WRONG_PW} -m ${NSB_IP} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsc nettest -r ${NSA_IP} -X ${MD5_PW}
 	log_test $? 2 "MD5: VRF: Single address config in default VRF and VRF, conn in default VRF with VRF pw"
 
@@ -1028,21 +1028,21 @@ ipv4_tcp_md5()
 	show_hint "Should timeout since client in VRF uses default VRF password"
 	run_cmd nettest -s -I ${VRF} -M ${MD5_PW} -m ${NSB_IP} &
 	run_cmd nettest -s -M ${MD5_WRONG_PW} -m ${NSB_IP} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsb nettest -r ${NSA_IP} -X ${MD5_WRONG_PW}
 	log_test $? 2 "MD5: VRF: Single address config in default VRF and VRF, conn in VRF with default VRF pw"
 
 	log_start
 	run_cmd nettest -s -I ${VRF} -M ${MD5_PW} -m ${NS_NET} &
 	run_cmd nettest -s -M ${MD5_WRONG_PW} -m ${NS_NET} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsb nettest  -r ${NSA_IP} -X ${MD5_PW}
 	log_test $? 0 "MD5: VRF: Prefix config in default VRF and VRF, conn in VRF"
 
 	log_start
 	run_cmd nettest -s -I ${VRF} -M ${MD5_PW} -m ${NS_NET} &
 	run_cmd nettest -s -M ${MD5_WRONG_PW} -m ${NS_NET} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsc nettest  -r ${NSA_IP} -X ${MD5_WRONG_PW}
 	log_test $? 0 "MD5: VRF: Prefix config in default VRF and VRF, conn in default VRF"
 
@@ -1050,7 +1050,7 @@ ipv4_tcp_md5()
 	show_hint "Should timeout since client in default VRF uses VRF password"
 	run_cmd nettest -s -I ${VRF} -M ${MD5_PW} -m ${NS_NET} &
 	run_cmd nettest -s -M ${MD5_WRONG_PW} -m ${NS_NET} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsc nettest -r ${NSA_IP} -X ${MD5_PW}
 	log_test $? 2 "MD5: VRF: Prefix config in default VRF and VRF, conn in default VRF with VRF pw"
 
@@ -1058,7 +1058,7 @@ ipv4_tcp_md5()
 	show_hint "Should timeout since client in VRF uses default VRF password"
 	run_cmd nettest -s -I ${VRF} -M ${MD5_PW} -m ${NS_NET} &
 	run_cmd nettest -s -M ${MD5_WRONG_PW} -m ${NS_NET} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsb nettest -r ${NSA_IP} -X ${MD5_WRONG_PW}
 	log_test $? 2 "MD5: VRF: Prefix config in default VRF and VRF, conn in VRF with default VRF pw"
 
@@ -1082,14 +1082,14 @@ test_ipv4_md5_vrf__vrf_server__no_bind_ifindex()
 	log_start
 	show_hint "Simulates applications using VRF without TCP_MD5SIG_FLAG_IFINDEX"
 	run_cmd nettest -s -I ${VRF} -M ${MD5_PW} -m ${NS_NET} --no-bind-key-ifindex &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsb nettest -r ${NSA_IP} -X ${MD5_PW}
 	log_test $? 0 "MD5: VRF: VRF-bound server, unbound key accepts connection"
 
 	log_start
 	show_hint "Binding both the socket and the key is not required but it works"
 	run_cmd nettest -s -I ${VRF} -M ${MD5_PW} -m ${NS_NET} --force-bind-key-ifindex &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsb nettest -r ${NSA_IP} -X ${MD5_PW}
 	log_test $? 0 "MD5: VRF: VRF-bound server, bound key accepts connection"
 }
@@ -1103,25 +1103,25 @@ test_ipv4_md5_vrf__global_server__bind_ifindex0()
 
 	log_start
 	run_cmd nettest -s -M ${MD5_PW} -m ${NS_NET} --force-bind-key-ifindex &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsb nettest -r ${NSA_IP} -X ${MD5_PW}
 	log_test $? 2 "MD5: VRF: Global server, Key bound to ifindex=0 rejects VRF connection"
 
 	log_start
 	run_cmd nettest -s -M ${MD5_PW} -m ${NS_NET} --force-bind-key-ifindex &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsc nettest -r ${NSA_IP} -X ${MD5_PW}
 	log_test $? 0 "MD5: VRF: Global server, key bound to ifindex=0 accepts non-VRF connection"
 	log_start
 
 	run_cmd nettest -s -M ${MD5_PW} -m ${NS_NET} --no-bind-key-ifindex &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsb nettest -r ${NSA_IP} -X ${MD5_PW}
 	log_test $? 0 "MD5: VRF: Global server, key not bound to ifindex accepts VRF connection"
 
 	log_start
 	run_cmd nettest -s -M ${MD5_PW} -m ${NS_NET} --no-bind-key-ifindex &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsc nettest -r ${NSA_IP} -X ${MD5_PW}
 	log_test $? 0 "MD5: VRF: Global server, key not bound to ifindex accepts non-VRF connection"
 
@@ -1193,7 +1193,7 @@ ipv4_tcp_novrf()
 	do
 		log_start
 		run_cmd nettest -s &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 tcp
 		run_cmd_nsb nettest -r ${a}
 		log_test_addr ${a} $? 0 "Global server"
 	done
@@ -1201,7 +1201,7 @@ ipv4_tcp_novrf()
 	a=${NSA_IP}
 	log_start
 	run_cmd nettest -s -I ${NSA_DEV} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsb nettest -r ${a}
 	log_test_addr ${a} $? 0 "Device server"
 
@@ -1221,13 +1221,13 @@ ipv4_tcp_novrf()
 	do
 		log_start
 		run_cmd_nsb nettest -s &
-		sleep 1
+		wait_local_port_listen ${NSB} 12345 tcp
 		run_cmd nettest -r ${a} -0 ${NSA_IP}
 		log_test_addr ${a} $? 0 "Client"
 
 		log_start
 		run_cmd_nsb nettest -s &
-		sleep 1
+		wait_local_port_listen ${NSB} 12345 tcp
 		run_cmd nettest -r ${a} -d ${NSA_DEV}
 		log_test_addr ${a} $? 0 "Client, device bind"
 
@@ -1249,7 +1249,7 @@ ipv4_tcp_novrf()
 	do
 		log_start
 		run_cmd nettest -s &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 tcp
 		run_cmd nettest -r ${a} -0 ${a} -1 ${a}
 		log_test_addr ${a} $? 0 "Global server, local connection"
 	done
@@ -1257,7 +1257,7 @@ ipv4_tcp_novrf()
 	a=${NSA_IP}
 	log_start
 	run_cmd nettest -s -I ${NSA_DEV} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd nettest -r ${a} -0 ${a}
 	log_test_addr ${a} $? 0 "Device server, unbound client, local connection"
 
@@ -1266,7 +1266,7 @@ ipv4_tcp_novrf()
 		log_start
 		show_hint "Should fail 'Connection refused' since addresses on loopback are out of device scope"
 		run_cmd nettest -s -I ${NSA_DEV} &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 tcp
 		run_cmd nettest -r ${a}
 		log_test_addr ${a} $? 1 "Device server, unbound client, local connection"
 	done
@@ -1274,7 +1274,7 @@ ipv4_tcp_novrf()
 	a=${NSA_IP}
 	log_start
 	run_cmd nettest -s &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd nettest -r ${a} -0 ${a} -d ${NSA_DEV}
 	log_test_addr ${a} $? 0 "Global server, device client, local connection"
 
@@ -1283,7 +1283,7 @@ ipv4_tcp_novrf()
 		log_start
 		show_hint "Should fail 'No route to host' since addresses on loopback are out of device scope"
 		run_cmd nettest -s &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 tcp
 		run_cmd nettest -r ${a} -d ${NSA_DEV}
 		log_test_addr ${a} $? 1 "Global server, device client, local connection"
 	done
@@ -1291,7 +1291,7 @@ ipv4_tcp_novrf()
 	a=${NSA_IP}
 	log_start
 	run_cmd nettest -s -I ${NSA_DEV} -3 ${NSA_DEV} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd nettest  -d ${NSA_DEV} -r ${a} -0 ${a}
 	log_test_addr ${a} $? 0 "Device server, device client, local connection"
 
@@ -1323,19 +1323,19 @@ ipv4_tcp_vrf()
 		log_start
 		show_hint "Should fail 'Connection refused' since global server with VRF is disabled"
 		run_cmd nettest -s &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 tcp
 		run_cmd_nsb nettest -r ${a}
 		log_test_addr ${a} $? 1 "Global server"
 
 		log_start
 		run_cmd nettest -s -I ${VRF} -3 ${VRF} &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 tcp
 		run_cmd_nsb nettest -r ${a}
 		log_test_addr ${a} $? 0 "VRF server"
 
 		log_start
 		run_cmd nettest -s -I ${NSA_DEV} -3 ${NSA_DEV} &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 tcp
 		run_cmd_nsb nettest -r ${a}
 		log_test_addr ${a} $? 0 "Device server"
 
@@ -1352,7 +1352,7 @@ ipv4_tcp_vrf()
 	log_start
 	show_hint "Should fail 'Connection refused' since global server with VRF is disabled"
 	run_cmd nettest -s &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd nettest -r ${a} -d ${NSA_DEV}
 	log_test_addr ${a} $? 1 "Global server, local connection"
 
@@ -1374,14 +1374,14 @@ ipv4_tcp_vrf()
 		log_start
 		show_hint "client socket should be bound to VRF"
 		run_cmd nettest -s -3 ${VRF} &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 tcp
 		run_cmd_nsb nettest -r ${a}
 		log_test_addr ${a} $? 0 "Global server"
 
 		log_start
 		show_hint "client socket should be bound to VRF"
 		run_cmd nettest -s -I ${VRF} -3 ${VRF} &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 tcp
 		run_cmd_nsb nettest -r ${a}
 		log_test_addr ${a} $? 0 "VRF server"
 
@@ -1396,7 +1396,7 @@ ipv4_tcp_vrf()
 	log_start
 	show_hint "client socket should be bound to device"
 	run_cmd nettest -s -I ${NSA_DEV} -3 ${NSA_DEV} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsb nettest -r ${a}
 	log_test_addr ${a} $? 0 "Device server"
 
@@ -1406,7 +1406,7 @@ ipv4_tcp_vrf()
 		log_start
 		show_hint "Should fail 'Connection refused' since client is not bound to VRF"
 		run_cmd nettest -s -I ${VRF} &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 tcp
 		run_cmd nettest -r ${a}
 		log_test_addr ${a} $? 1 "Global server, local connection"
 	done
@@ -1418,13 +1418,13 @@ ipv4_tcp_vrf()
 	do
 		log_start
 		run_cmd_nsb nettest -s &
-		sleep 1
+		wait_local_port_listen ${NSB} 12345 tcp
 		run_cmd nettest -r ${a} -d ${VRF}
 		log_test_addr ${a} $? 0 "Client, VRF bind"
 
 		log_start
 		run_cmd_nsb nettest -s &
-		sleep 1
+		wait_local_port_listen ${NSB} 12345 tcp
 		run_cmd nettest -r ${a} -d ${NSA_DEV}
 		log_test_addr ${a} $? 0 "Client, device bind"
 
@@ -1443,7 +1443,7 @@ ipv4_tcp_vrf()
 	do
 		log_start
 		run_cmd nettest -s -I ${VRF} -3 ${VRF} &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 tcp
 		run_cmd nettest -r ${a} -d ${VRF} -0 ${a}
 		log_test_addr ${a} $? 0 "VRF server, VRF client, local connection"
 	done
@@ -1451,26 +1451,26 @@ ipv4_tcp_vrf()
 	a=${NSA_IP}
 	log_start
 	run_cmd nettest -s -I ${VRF} -3 ${VRF} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd nettest -r ${a} -d ${NSA_DEV} -0 ${a}
 	log_test_addr ${a} $? 0 "VRF server, device client, local connection"
 
 	log_start
 	show_hint "Should fail 'No route to host' since client is out of VRF scope"
 	run_cmd nettest -s -I ${VRF} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd nettest -r ${a}
 	log_test_addr ${a} $? 1 "VRF server, unbound client, local connection"
 
 	log_start
 	run_cmd nettest -s -I ${NSA_DEV} -3 ${NSA_DEV} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd nettest -r ${a} -d ${VRF} -0 ${a}
 	log_test_addr ${a} $? 0 "Device server, VRF client, local connection"
 
 	log_start
 	run_cmd nettest -s -I ${NSA_DEV} -3 ${NSA_DEV} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd nettest -r ${a} -d ${NSA_DEV} -0 ${a}
 	log_test_addr ${a} $? 0 "Device server, device client, local connection"
 }
@@ -1509,7 +1509,7 @@ ipv4_udp_novrf()
 	do
 		log_start
 		run_cmd nettest -D -s -3 ${NSA_DEV} &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 udp
 		run_cmd_nsb nettest -D -r ${a}
 		log_test_addr ${a} $? 0 "Global server"
 
@@ -1522,7 +1522,7 @@ ipv4_udp_novrf()
 	a=${NSA_IP}
 	log_start
 	run_cmd nettest -D -I ${NSA_DEV} -s -3 ${NSA_DEV} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 udp
 	run_cmd_nsb nettest -D -r ${a}
 	log_test_addr ${a} $? 0 "Device server"
 
@@ -1533,31 +1533,31 @@ ipv4_udp_novrf()
 	do
 		log_start
 		run_cmd_nsb nettest -D -s &
-		sleep 1
+		wait_local_port_listen ${NSB} 12345 udp
 		run_cmd nettest -D -r ${a} -0 ${NSA_IP}
 		log_test_addr ${a} $? 0 "Client"
 
 		log_start
 		run_cmd_nsb nettest -D -s &
-		sleep 1
+		wait_local_port_listen ${NSB} 12345 udp
 		run_cmd nettest -D -r ${a} -d ${NSA_DEV} -0 ${NSA_IP}
 		log_test_addr ${a} $? 0 "Client, device bind"
 
 		log_start
 		run_cmd_nsb nettest -D -s &
-		sleep 1
+		wait_local_port_listen ${NSB} 12345 udp
 		run_cmd nettest -D -r ${a} -d ${NSA_DEV} -C -0 ${NSA_IP}
 		log_test_addr ${a} $? 0 "Client, device send via cmsg"
 
 		log_start
 		run_cmd_nsb nettest -D -s &
-		sleep 1
+		wait_local_port_listen ${NSB} 12345 udp
 		run_cmd nettest -D -r ${a} -d ${NSA_DEV} -S -0 ${NSA_IP}
 		log_test_addr ${a} $? 0 "Client, device bind via IP_UNICAST_IF"
 
 		log_start
 		run_cmd_nsb nettest -D -s &
-		sleep 1
+		wait_local_port_listen ${NSB} 12345 udp
 		run_cmd nettest -D -r ${a} -d ${NSA_DEV} -S -0 ${NSA_IP} -U
 		log_test_addr ${a} $? 0 "Client, device bind via IP_UNICAST_IF, with connect()"
 
@@ -1580,7 +1580,7 @@ ipv4_udp_novrf()
 	do
 		log_start
 		run_cmd nettest -D -s &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 udp
 		run_cmd nettest -D -r ${a} -0 ${a} -1 ${a}
 		log_test_addr ${a} $? 0 "Global server, local connection"
 	done
@@ -1588,7 +1588,7 @@ ipv4_udp_novrf()
 	a=${NSA_IP}
 	log_start
 	run_cmd nettest -s -D -I ${NSA_DEV} -3 ${NSA_DEV} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 udp
 	run_cmd nettest -D -r ${a}
 	log_test_addr ${a} $? 0 "Device server, unbound client, local connection"
 
@@ -1597,7 +1597,7 @@ ipv4_udp_novrf()
 		log_start
 		show_hint "Should fail 'Connection refused' since address is out of device scope"
 		run_cmd nettest -s -D -I ${NSA_DEV} &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 udp
 		run_cmd nettest -D -r ${a}
 		log_test_addr ${a} $? 1 "Device server, unbound client, local connection"
 	done
@@ -1605,25 +1605,25 @@ ipv4_udp_novrf()
 	a=${NSA_IP}
 	log_start
 	run_cmd nettest -s -D &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 udp
 	run_cmd nettest -D -d ${NSA_DEV} -r ${a}
 	log_test_addr ${a} $? 0 "Global server, device client, local connection"
 
 	log_start
 	run_cmd nettest -s -D &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 udp
 	run_cmd nettest -D -d ${NSA_DEV} -C -r ${a}
 	log_test_addr ${a} $? 0 "Global server, device send via cmsg, local connection"
 
 	log_start
 	run_cmd nettest -s -D &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 udp
 	run_cmd nettest -D -d ${NSA_DEV} -S -r ${a}
 	log_test_addr ${a} $? 0 "Global server, device client via IP_UNICAST_IF, local connection"
 
 	log_start
 	run_cmd nettest -s -D &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 udp
 	run_cmd nettest -D -d ${NSA_DEV} -S -r ${a} -U
 	log_test_addr ${a} $? 0 "Global server, device client via IP_UNICAST_IF, local connection, with connect()"
 
@@ -1636,28 +1636,28 @@ ipv4_udp_novrf()
 		log_start
 		show_hint "Should fail since addresses on loopback are out of device scope"
 		run_cmd nettest -D -s &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 udp
 		run_cmd nettest -D -r ${a} -d ${NSA_DEV}
 		log_test_addr ${a} $? 2 "Global server, device client, local connection"
 
 		log_start
 		show_hint "Should fail since addresses on loopback are out of device scope"
 		run_cmd nettest -D -s &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 udp
 		run_cmd nettest -D -r ${a} -d ${NSA_DEV} -C
 		log_test_addr ${a} $? 1 "Global server, device send via cmsg, local connection"
 
 		log_start
 		show_hint "Should fail since addresses on loopback are out of device scope"
 		run_cmd nettest -D -s &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 udp
 		run_cmd nettest -D -r ${a} -d ${NSA_DEV} -S
 		log_test_addr ${a} $? 1 "Global server, device client via IP_UNICAST_IF, local connection"
 
 		log_start
 		show_hint "Should fail since addresses on loopback are out of device scope"
 		run_cmd nettest -D -s &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 udp
 		run_cmd nettest -D -r ${a} -d ${NSA_DEV} -S -U
 		log_test_addr ${a} $? 1 "Global server, device client via IP_UNICAST_IF, local connection, with connect()"
 
@@ -1667,7 +1667,7 @@ ipv4_udp_novrf()
 	a=${NSA_IP}
 	log_start
 	run_cmd nettest -D -s -I ${NSA_DEV} -3 ${NSA_DEV} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 udp
 	run_cmd nettest -D -d ${NSA_DEV} -r ${a} -0 ${a}
 	log_test_addr ${a} $? 0 "Device server, device client, local conn"
 
@@ -1709,19 +1709,19 @@ ipv4_udp_vrf()
 		log_start
 		show_hint "Fails because ingress is in a VRF and global server is disabled"
 		run_cmd nettest -D -s &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 udp
 		run_cmd_nsb nettest -D -r ${a}
 		log_test_addr ${a} $? 1 "Global server"
 
 		log_start
 		run_cmd nettest -D -I ${VRF} -s -3 ${NSA_DEV} &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 udp
 		run_cmd_nsb nettest -D -r ${a}
 		log_test_addr ${a} $? 0 "VRF server"
 
 		log_start
 		run_cmd nettest -D -I ${NSA_DEV} -s -3 ${NSA_DEV} &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 udp
 		run_cmd_nsb nettest -D -r ${a}
 		log_test_addr ${a} $? 0 "Enslaved device server"
 
@@ -1733,7 +1733,7 @@ ipv4_udp_vrf()
 		log_start
 		show_hint "Should fail 'Connection refused' since global server is out of scope"
 		run_cmd nettest -D -s &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 udp
 		run_cmd nettest -D -d ${VRF} -r ${a}
 		log_test_addr ${a} $? 1 "Global server, VRF client, local connection"
 	done
@@ -1741,26 +1741,26 @@ ipv4_udp_vrf()
 	a=${NSA_IP}
 	log_start
 	run_cmd nettest -s -D -I ${VRF} -3 ${NSA_DEV} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 udp
 	run_cmd nettest -D -d ${VRF} -r ${a}
 	log_test_addr ${a} $? 0 "VRF server, VRF client, local conn"
 
 	log_start
 	run_cmd nettest -s -D -I ${VRF} -3 ${NSA_DEV} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 udp
 	run_cmd nettest -D -d ${NSA_DEV} -r ${a}
 	log_test_addr ${a} $? 0 "VRF server, enslaved device client, local connection"
 
 	a=${NSA_IP}
 	log_start
 	run_cmd nettest -s -D -I ${NSA_DEV} -3 ${NSA_DEV} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 udp
 	run_cmd nettest -D -d ${VRF} -r ${a}
 	log_test_addr ${a} $? 0 "Enslaved device server, VRF client, local conn"
 
 	log_start
 	run_cmd nettest -s -D -I ${NSA_DEV} -3 ${NSA_DEV} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 udp
 	run_cmd nettest -D -d ${NSA_DEV} -r ${a}
 	log_test_addr ${a} $? 0 "Enslaved device server, device client, local conn"
 
@@ -1775,19 +1775,19 @@ ipv4_udp_vrf()
 	do
 		log_start
 		run_cmd nettest -D -s -3 ${NSA_DEV} &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 udp
 		run_cmd_nsb nettest -D -r ${a}
 		log_test_addr ${a} $? 0 "Global server"
 
 		log_start
 		run_cmd nettest -D -I ${VRF} -s -3 ${NSA_DEV} &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 udp
 		run_cmd_nsb nettest -D -r ${a}
 		log_test_addr ${a} $? 0 "VRF server"
 
 		log_start
 		run_cmd nettest -D -I ${NSA_DEV} -s -3 ${NSA_DEV} &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 udp
 		run_cmd_nsb nettest -D -r ${a}
 		log_test_addr ${a} $? 0 "Enslaved device server"
 
@@ -1802,13 +1802,13 @@ ipv4_udp_vrf()
 	#
 	log_start
 	run_cmd_nsb nettest -D -s &
-	sleep 1
+	wait_local_port_listen ${NSB} 12345 udp
 	run_cmd nettest -d ${VRF} -D -r ${NSB_IP} -1 ${NSA_IP}
 	log_test $? 0 "VRF client"
 
 	log_start
 	run_cmd_nsb nettest -D -s &
-	sleep 1
+	wait_local_port_listen ${NSB} 12345 udp
 	run_cmd nettest -d ${NSA_DEV} -D -r ${NSB_IP} -1 ${NSA_IP}
 	log_test $? 0 "Enslaved device client"
 
@@ -1829,31 +1829,31 @@ ipv4_udp_vrf()
 	a=${NSA_IP}
 	log_start
 	run_cmd nettest -D -s -3 ${NSA_DEV} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 udp
 	run_cmd nettest -D -d ${VRF} -r ${a}
 	log_test_addr ${a} $? 0 "Global server, VRF client, local conn"
 
 	log_start
 	run_cmd nettest -s -D -I ${VRF} -3 ${NSA_DEV} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 udp
 	run_cmd nettest -D -d ${VRF} -r ${a}
 	log_test_addr ${a} $? 0 "VRF server, VRF client, local conn"
 
 	log_start
 	run_cmd nettest -s -D -I ${VRF} -3 ${NSA_DEV} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 udp
 	run_cmd nettest -D -d ${NSA_DEV} -r ${a}
 	log_test_addr ${a} $? 0 "VRF server, device client, local conn"
 
 	log_start
 	run_cmd nettest -s -D -I ${NSA_DEV} -3 ${NSA_DEV} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 udp
 	run_cmd nettest -D -d ${VRF} -r ${a}
 	log_test_addr ${a} $? 0 "Enslaved device server, VRF client, local conn"
 
 	log_start
 	run_cmd nettest -s -D -I ${NSA_DEV} -3 ${NSA_DEV} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 udp
 	run_cmd nettest -D -d ${NSA_DEV} -r ${a}
 	log_test_addr ${a} $? 0 "Enslaved device server, device client, local conn"
 
@@ -1861,7 +1861,7 @@ ipv4_udp_vrf()
 	do
 		log_start
 		run_cmd nettest -D -s -3 ${VRF} &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 udp
 		run_cmd nettest -D -d ${VRF} -r ${a}
 		log_test_addr ${a} $? 0 "Global server, VRF client, local conn"
 	done
@@ -1870,7 +1870,7 @@ ipv4_udp_vrf()
 	do
 		log_start
 		run_cmd nettest -s -D -I ${VRF} -3 ${VRF} &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 udp
 		run_cmd nettest -D -d ${VRF} -r ${a}
 		log_test_addr ${a} $? 0 "VRF server, VRF client, local conn"
 	done
@@ -2093,7 +2093,7 @@ ipv4_rt()
 	do
 		log_start
 		run_cmd nettest ${varg} -s &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 tcp
 		run_cmd_nsb nettest ${varg} -r ${a} &
 		sleep 3
 		run_cmd ip link del ${VRF}
@@ -2107,7 +2107,7 @@ ipv4_rt()
 	do
 		log_start
 		run_cmd nettest ${varg} -s -I ${VRF} &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 tcp
 		run_cmd_nsb nettest ${varg} -r ${a} &
 		sleep 3
 		run_cmd ip link del ${VRF}
@@ -2120,7 +2120,7 @@ ipv4_rt()
 	a=${NSA_IP}
 	log_start
 	run_cmd nettest ${varg} -s -I ${NSA_DEV} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsb nettest ${varg} -r ${a} &
 	sleep 3
 	run_cmd ip link del ${VRF}
@@ -2134,7 +2134,7 @@ ipv4_rt()
 	#
 	log_start
 	run_cmd_nsb nettest ${varg} -s &
-	sleep 1
+	wait_local_port_listen ${NSB} 12345 tcp
 	run_cmd nettest ${varg} -d ${VRF} -r ${NSB_IP} &
 	sleep 3
 	run_cmd ip link del ${VRF}
@@ -2145,7 +2145,7 @@ ipv4_rt()
 
 	log_start
 	run_cmd_nsb nettest ${varg} -s &
-	sleep 1
+	wait_local_port_listen ${NSB} 12345 tcp
 	run_cmd nettest ${varg} -d ${NSA_DEV} -r ${NSB_IP} &
 	sleep 3
 	run_cmd ip link del ${VRF}
@@ -2161,7 +2161,7 @@ ipv4_rt()
 	do
 		log_start
 		run_cmd nettest ${varg} -s &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 tcp
 		run_cmd nettest ${varg} -d ${VRF} -r ${a} &
 		sleep 3
 		run_cmd ip link del ${VRF}
@@ -2175,7 +2175,7 @@ ipv4_rt()
 	do
 		log_start
 		run_cmd nettest ${varg} -I ${VRF} -s &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 tcp
 		run_cmd nettest ${varg} -d ${VRF} -r ${a} &
 		sleep 3
 		run_cmd ip link del ${VRF}
@@ -2189,7 +2189,7 @@ ipv4_rt()
 	log_start
 
 	run_cmd nettest ${varg} -s &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd nettest ${varg} -d ${NSA_DEV} -r ${a} &
 	sleep 3
 	run_cmd ip link del ${VRF}
@@ -2200,7 +2200,7 @@ ipv4_rt()
 
 	log_start
 	run_cmd nettest ${varg} -I ${VRF} -s &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd nettest ${varg} -d ${NSA_DEV} -r ${a} &
 	sleep 3
 	run_cmd ip link del ${VRF}
@@ -2211,7 +2211,7 @@ ipv4_rt()
 
 	log_start
 	run_cmd nettest ${varg} -I ${NSA_DEV} -s &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd nettest ${varg} -d ${NSA_DEV} -r ${a} &
 	sleep 3
 	run_cmd ip link del ${VRF}
@@ -2561,7 +2561,7 @@ ipv6_tcp_md5_novrf()
 	# basic use case
 	log_start
 	run_cmd nettest -6 -s -M ${MD5_PW} -m ${NSB_IP6} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsb nettest -6 -r ${NSA_IP6} -X ${MD5_PW}
 	log_test $? 0 "MD5: Single address config"
 
@@ -2569,7 +2569,7 @@ ipv6_tcp_md5_novrf()
 	log_start
 	show_hint "Should timeout due to MD5 mismatch"
 	run_cmd nettest -6 -s &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsb nettest -6 -r ${NSA_IP6} -X ${MD5_PW}
 	log_test $? 2 "MD5: Server no config, client uses password"
 
@@ -2577,7 +2577,7 @@ ipv6_tcp_md5_novrf()
 	log_start
 	show_hint "Should timeout since client uses wrong password"
 	run_cmd nettest -6 -s -M ${MD5_PW} -m ${NSB_IP6} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsb nettest -6 -r ${NSA_IP6} -X ${MD5_WRONG_PW}
 	log_test $? 2 "MD5: Client uses wrong password"
 
@@ -2585,7 +2585,7 @@ ipv6_tcp_md5_novrf()
 	log_start
 	show_hint "Should timeout due to MD5 mismatch"
 	run_cmd nettest -6 -s -M ${MD5_PW} -m ${NSB_LO_IP6} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsb nettest -6 -r ${NSA_IP6} -X ${MD5_PW}
 	log_test $? 2 "MD5: Client address does not match address configured with password"
 
@@ -2596,7 +2596,7 @@ ipv6_tcp_md5_novrf()
 	# client in prefix
 	log_start
 	run_cmd nettest -6 -s -M ${MD5_PW} -m ${NS_NET6} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsb nettest -6 -r ${NSA_IP6} -X ${MD5_PW}
 	log_test $? 0 "MD5: Prefix config"
 
@@ -2604,7 +2604,7 @@ ipv6_tcp_md5_novrf()
 	log_start
 	show_hint "Should timeout since client uses wrong password"
 	run_cmd nettest -6 -s -M ${MD5_PW} -m ${NS_NET6} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsb nettest -6 -r ${NSA_IP6} -X ${MD5_WRONG_PW}
 	log_test $? 2 "MD5: Prefix config, client uses wrong password"
 
@@ -2612,7 +2612,7 @@ ipv6_tcp_md5_novrf()
 	log_start
 	show_hint "Should timeout due to MD5 mismatch"
 	run_cmd nettest -6 -s -M ${MD5_PW} -m ${NS_NET6} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsb nettest -6 -c ${NSB_LO_IP6} -r ${NSA_IP6} -X ${MD5_PW}
 	log_test $? 2 "MD5: Prefix config, client address not in configured prefix"
 }
@@ -2629,7 +2629,7 @@ ipv6_tcp_md5()
 	# basic use case
 	log_start
 	run_cmd nettest -6 -s -I ${VRF} -M ${MD5_PW} -m ${NSB_IP6} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsb nettest -6 -r ${NSA_IP6} -X ${MD5_PW}
 	log_test $? 0 "MD5: VRF: Single address config"
 
@@ -2637,7 +2637,7 @@ ipv6_tcp_md5()
 	log_start
 	show_hint "Should timeout since server does not have MD5 auth"
 	run_cmd nettest -6 -s -I ${VRF} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsb nettest -6 -r ${NSA_IP6} -X ${MD5_PW}
 	log_test $? 2 "MD5: VRF: Server no config, client uses password"
 
@@ -2645,7 +2645,7 @@ ipv6_tcp_md5()
 	log_start
 	show_hint "Should timeout since client uses wrong password"
 	run_cmd nettest -6 -s -I ${VRF} -M ${MD5_PW} -m ${NSB_IP6} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsb nettest -6 -r ${NSA_IP6} -X ${MD5_WRONG_PW}
 	log_test $? 2 "MD5: VRF: Client uses wrong password"
 
@@ -2653,7 +2653,7 @@ ipv6_tcp_md5()
 	log_start
 	show_hint "Should timeout since server config differs from client"
 	run_cmd nettest -6 -s -I ${VRF} -M ${MD5_PW} -m ${NSB_LO_IP6} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsb nettest -6 -r ${NSA_IP6} -X ${MD5_PW}
 	log_test $? 2 "MD5: VRF: Client address does not match address configured with password"
 
@@ -2664,7 +2664,7 @@ ipv6_tcp_md5()
 	# client in prefix
 	log_start
 	run_cmd nettest -6 -s -I ${VRF} -M ${MD5_PW} -m ${NS_NET6} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsb nettest -6 -r ${NSA_IP6} -X ${MD5_PW}
 	log_test $? 0 "MD5: VRF: Prefix config"
 
@@ -2672,7 +2672,7 @@ ipv6_tcp_md5()
 	log_start
 	show_hint "Should timeout since client uses wrong password"
 	run_cmd nettest -6 -s -I ${VRF} -M ${MD5_PW} -m ${NS_NET6} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsb nettest -6 -r ${NSA_IP6} -X ${MD5_WRONG_PW}
 	log_test $? 2 "MD5: VRF: Prefix config, client uses wrong password"
 
@@ -2680,7 +2680,7 @@ ipv6_tcp_md5()
 	log_start
 	show_hint "Should timeout since client address is outside of prefix"
 	run_cmd nettest -6 -s -I ${VRF} -M ${MD5_PW} -m ${NS_NET6} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsb nettest -6 -c ${NSB_LO_IP6} -r ${NSA_IP6} -X ${MD5_PW}
 	log_test $? 2 "MD5: VRF: Prefix config, client address not in configured prefix"
 
@@ -2691,14 +2691,14 @@ ipv6_tcp_md5()
 	log_start
 	run_cmd nettest -6 -s -I ${VRF} -M ${MD5_PW} -m ${NSB_IP6} &
 	run_cmd nettest -6 -s -M ${MD5_WRONG_PW} -m ${NSB_IP6} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsb nettest -6 -r ${NSA_IP6} -X ${MD5_PW}
 	log_test $? 0 "MD5: VRF: Single address config in default VRF and VRF, conn in VRF"
 
 	log_start
 	run_cmd nettest -6 -s -I ${VRF} -M ${MD5_PW} -m ${NSB_IP6} &
 	run_cmd nettest -6 -s -M ${MD5_WRONG_PW} -m ${NSB_IP6} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsc nettest -6 -r ${NSA_IP6} -X ${MD5_WRONG_PW}
 	log_test $? 0 "MD5: VRF: Single address config in default VRF and VRF, conn in default VRF"
 
@@ -2706,7 +2706,7 @@ ipv6_tcp_md5()
 	show_hint "Should timeout since client in default VRF uses VRF password"
 	run_cmd nettest -6 -s -I ${VRF} -M ${MD5_PW} -m ${NSB_IP6} &
 	run_cmd nettest -6 -s -M ${MD5_WRONG_PW} -m ${NSB_IP6} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsc nettest -6 -r ${NSA_IP6} -X ${MD5_PW}
 	log_test $? 2 "MD5: VRF: Single address config in default VRF and VRF, conn in default VRF with VRF pw"
 
@@ -2714,21 +2714,21 @@ ipv6_tcp_md5()
 	show_hint "Should timeout since client in VRF uses default VRF password"
 	run_cmd nettest -6 -s -I ${VRF} -M ${MD5_PW} -m ${NSB_IP6} &
 	run_cmd nettest -6 -s -M ${MD5_WRONG_PW} -m ${NSB_IP6} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsb nettest -6 -r ${NSA_IP6} -X ${MD5_WRONG_PW}
 	log_test $? 2 "MD5: VRF: Single address config in default VRF and VRF, conn in VRF with default VRF pw"
 
 	log_start
 	run_cmd nettest -6 -s -I ${VRF} -M ${MD5_PW} -m ${NS_NET6} &
 	run_cmd nettest -6 -s -M ${MD5_WRONG_PW} -m ${NS_NET6} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsb nettest -6 -r ${NSA_IP6} -X ${MD5_PW}
 	log_test $? 0 "MD5: VRF: Prefix config in default VRF and VRF, conn in VRF"
 
 	log_start
 	run_cmd nettest -6 -s -I ${VRF} -M ${MD5_PW} -m ${NS_NET6} &
 	run_cmd nettest -6 -s -M ${MD5_WRONG_PW} -m ${NS_NET6} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsc nettest -6 -r ${NSA_IP6} -X ${MD5_WRONG_PW}
 	log_test $? 0 "MD5: VRF: Prefix config in default VRF and VRF, conn in default VRF"
 
@@ -2736,7 +2736,7 @@ ipv6_tcp_md5()
 	show_hint "Should timeout since client in default VRF uses VRF password"
 	run_cmd nettest -6 -s -I ${VRF} -M ${MD5_PW} -m ${NS_NET6} &
 	run_cmd nettest -6 -s -M ${MD5_WRONG_PW} -m ${NS_NET6} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsc nettest -6 -r ${NSA_IP6} -X ${MD5_PW}
 	log_test $? 2 "MD5: VRF: Prefix config in default VRF and VRF, conn in default VRF with VRF pw"
 
@@ -2744,7 +2744,7 @@ ipv6_tcp_md5()
 	show_hint "Should timeout since client in VRF uses default VRF password"
 	run_cmd nettest -6 -s -I ${VRF} -M ${MD5_PW} -m ${NS_NET6} &
 	run_cmd nettest -6 -s -M ${MD5_WRONG_PW} -m ${NS_NET6} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsb nettest -6 -r ${NSA_IP6} -X ${MD5_WRONG_PW}
 	log_test $? 2 "MD5: VRF: Prefix config in default VRF and VRF, conn in VRF with default VRF pw"
 
@@ -2772,7 +2772,7 @@ ipv6_tcp_novrf()
 	do
 		log_start
 		run_cmd nettest -6 -s &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 tcp
 		run_cmd_nsb nettest -6 -r ${a}
 		log_test_addr ${a} $? 0 "Global server"
 	done
@@ -2793,7 +2793,7 @@ ipv6_tcp_novrf()
 	do
 		log_start
 		run_cmd_nsb nettest -6 -s &
-		sleep 1
+		wait_local_port_listen ${NSB} 12345 tcp
 		run_cmd nettest -6 -r ${a}
 		log_test_addr ${a} $? 0 "Client"
 	done
@@ -2802,7 +2802,7 @@ ipv6_tcp_novrf()
 	do
 		log_start
 		run_cmd_nsb nettest -6 -s &
-		sleep 1
+		wait_local_port_listen ${NSB} 12345 tcp
 		run_cmd nettest -6 -r ${a} -d ${NSA_DEV}
 		log_test_addr ${a} $? 0 "Client, device bind"
 	done
@@ -2822,7 +2822,7 @@ ipv6_tcp_novrf()
 	do
 		log_start
 		run_cmd nettest -6 -s &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 tcp
 		run_cmd nettest -6 -r ${a}
 		log_test_addr ${a} $? 0 "Global server, local connection"
 	done
@@ -2830,7 +2830,7 @@ ipv6_tcp_novrf()
 	a=${NSA_IP6}
 	log_start
 	run_cmd nettest -6 -s -I ${NSA_DEV} -3 ${NSA_DEV} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd nettest -6 -r ${a} -0 ${a}
 	log_test_addr ${a} $? 0 "Device server, unbound client, local connection"
 
@@ -2839,7 +2839,7 @@ ipv6_tcp_novrf()
 		log_start
 		show_hint "Should fail 'Connection refused' since addresses on loopback are out of device scope"
 		run_cmd nettest -6 -s -I ${NSA_DEV} &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 tcp
 		run_cmd nettest -6 -r ${a}
 		log_test_addr ${a} $? 1 "Device server, unbound client, local connection"
 	done
@@ -2847,7 +2847,7 @@ ipv6_tcp_novrf()
 	a=${NSA_IP6}
 	log_start
 	run_cmd nettest -6 -s &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd nettest -6 -r ${a} -d ${NSA_DEV} -0 ${a}
 	log_test_addr ${a} $? 0 "Global server, device client, local connection"
 
@@ -2856,7 +2856,7 @@ ipv6_tcp_novrf()
 		log_start
 		show_hint "Should fail 'Connection refused' since addresses on loopback are out of device scope"
 		run_cmd nettest -6 -s &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 tcp
 		run_cmd nettest -6 -r ${a} -d ${NSA_DEV}
 		log_test_addr ${a} $? 1 "Global server, device client, local connection"
 	done
@@ -2865,7 +2865,7 @@ ipv6_tcp_novrf()
 	do
 		log_start
 		run_cmd nettest -6 -s -I ${NSA_DEV} -3 ${NSA_DEV} &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 tcp
 		run_cmd nettest -6  -d ${NSA_DEV} -r ${a}
 		log_test_addr ${a} $? 0 "Device server, device client, local conn"
 	done
@@ -2898,7 +2898,7 @@ ipv6_tcp_vrf()
 		log_start
 		show_hint "Should fail 'Connection refused' since global server with VRF is disabled"
 		run_cmd nettest -6 -s &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 tcp
 		run_cmd_nsb nettest -6 -r ${a}
 		log_test_addr ${a} $? 1 "Global server"
 	done
@@ -2907,7 +2907,7 @@ ipv6_tcp_vrf()
 	do
 		log_start
 		run_cmd nettest -6 -s -I ${VRF} -3 ${VRF} &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 tcp
 		run_cmd_nsb nettest -6 -r ${a}
 		log_test_addr ${a} $? 0 "VRF server"
 	done
@@ -2916,7 +2916,7 @@ ipv6_tcp_vrf()
 	a=${NSA_LINKIP6}%${NSB_DEV}
 	log_start
 	run_cmd nettest -6 -s -I ${VRF} -3 ${NSA_DEV} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsb nettest -6 -r ${a}
 	log_test_addr ${a} $? 0 "VRF server"
 
@@ -2924,7 +2924,7 @@ ipv6_tcp_vrf()
 	do
 		log_start
 		run_cmd nettest -6 -s -I ${NSA_DEV} -3 ${NSA_DEV} &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 tcp
 		run_cmd_nsb nettest -6 -r ${a}
 		log_test_addr ${a} $? 0 "Device server"
 	done
@@ -2943,7 +2943,7 @@ ipv6_tcp_vrf()
 	log_start
 	show_hint "Should fail 'Connection refused' since global server with VRF is disabled"
 	run_cmd nettest -6 -s &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd nettest -6 -r ${a} -d ${NSA_DEV}
 	log_test_addr ${a} $? 1 "Global server, local connection"
 
@@ -2964,7 +2964,7 @@ ipv6_tcp_vrf()
 	do
 		log_start
 		run_cmd nettest -6 -s -3 ${VRF} &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 tcp
 		run_cmd_nsb nettest -6 -r ${a}
 		log_test_addr ${a} $? 0 "Global server"
 	done
@@ -2973,7 +2973,7 @@ ipv6_tcp_vrf()
 	do
 		log_start
 		run_cmd nettest -6 -s -I ${VRF} -3 ${VRF} &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 tcp
 		run_cmd_nsb nettest -6 -r ${a}
 		log_test_addr ${a} $? 0 "VRF server"
 	done
@@ -2982,13 +2982,13 @@ ipv6_tcp_vrf()
 	a=${NSA_LINKIP6}%${NSB_DEV}
 	log_start
 	run_cmd nettest -6 -s -3 ${NSA_DEV} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsb nettest -6 -r ${a}
 	log_test_addr ${a} $? 0 "Global server"
 
 	log_start
 	run_cmd nettest -6 -s -I ${VRF} -3 ${NSA_DEV} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd_nsb nettest -6 -r ${a}
 	log_test_addr ${a} $? 0 "VRF server"
 
@@ -2996,7 +2996,7 @@ ipv6_tcp_vrf()
 	do
 		log_start
 		run_cmd nettest -6 -s -I ${NSA_DEV} -3 ${NSA_DEV} &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 tcp
 		run_cmd_nsb nettest -6 -r ${a}
 		log_test_addr ${a} $? 0 "Device server"
 	done
@@ -3016,7 +3016,7 @@ ipv6_tcp_vrf()
 		log_start
 		show_hint "Fails 'Connection refused' since client is not in VRF"
 		run_cmd nettest -6 -s -I ${VRF} &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 tcp
 		run_cmd nettest -6 -r ${a}
 		log_test_addr ${a} $? 1 "Global server, local connection"
 	done
@@ -3029,7 +3029,7 @@ ipv6_tcp_vrf()
 	do
 		log_start
 		run_cmd_nsb nettest -6 -s &
-		sleep 1
+		wait_local_port_listen ${NSB} 12345 tcp
 		run_cmd nettest -6 -r ${a} -d ${VRF}
 		log_test_addr ${a} $? 0 "Client, VRF bind"
 	done
@@ -3038,7 +3038,7 @@ ipv6_tcp_vrf()
 	log_start
 	show_hint "Fails since VRF device does not allow linklocal addresses"
 	run_cmd_nsb nettest -6 -s &
-	sleep 1
+	wait_local_port_listen ${NSB} 12345 tcp
 	run_cmd nettest -6 -r ${a} -d ${VRF}
 	log_test_addr ${a} $? 1 "Client, VRF bind"
 
@@ -3046,7 +3046,7 @@ ipv6_tcp_vrf()
 	do
 		log_start
 		run_cmd_nsb nettest -6 -s &
-		sleep 1
+		wait_local_port_listen ${NSB} 12345 tcp
 		run_cmd nettest -6 -r ${a} -d ${NSA_DEV}
 		log_test_addr ${a} $? 0 "Client, device bind"
 	done
@@ -3071,7 +3071,7 @@ ipv6_tcp_vrf()
 	do
 		log_start
 		run_cmd nettest -6 -s -I ${VRF} -3 ${VRF} &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 tcp
 		run_cmd nettest -6 -r ${a} -d ${VRF} -0 ${a}
 		log_test_addr ${a} $? 0 "VRF server, VRF client, local connection"
 	done
@@ -3079,7 +3079,7 @@ ipv6_tcp_vrf()
 	a=${NSA_IP6}
 	log_start
 	run_cmd nettest -6 -s -I ${VRF} -3 ${VRF} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd nettest -6 -r ${a} -d ${NSA_DEV} -0 ${a}
 	log_test_addr ${a} $? 0 "VRF server, device client, local connection"
 
@@ -3087,13 +3087,13 @@ ipv6_tcp_vrf()
 	log_start
 	show_hint "Should fail since unbound client is out of VRF scope"
 	run_cmd nettest -6 -s -I ${VRF} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd nettest -6 -r ${a}
 	log_test_addr ${a} $? 1 "VRF server, unbound client, local connection"
 
 	log_start
 	run_cmd nettest -6 -s -I ${NSA_DEV} -3 ${NSA_DEV} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd nettest -6 -r ${a} -d ${VRF} -0 ${a}
 	log_test_addr ${a} $? 0 "Device server, VRF client, local connection"
 
@@ -3101,7 +3101,7 @@ ipv6_tcp_vrf()
 	do
 		log_start
 		run_cmd nettest -6 -s -I ${NSA_DEV} -3 ${NSA_DEV} &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 tcp
 		run_cmd nettest -6 -r ${a} -d ${NSA_DEV} -0 ${a}
 		log_test_addr ${a} $? 0 "Device server, device client, local connection"
 	done
@@ -3141,13 +3141,13 @@ ipv6_udp_novrf()
 	do
 		log_start
 		run_cmd nettest -6 -D -s -3 ${NSA_DEV} &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 udp
 		run_cmd_nsb nettest -6 -D -r ${a}
 		log_test_addr ${a} $? 0 "Global server"
 
 		log_start
 		run_cmd nettest -6 -D -I ${NSA_DEV} -s -3 ${NSA_DEV} &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 udp
 		run_cmd_nsb nettest -6 -D -r ${a}
 		log_test_addr ${a} $? 0 "Device server"
 	done
@@ -3155,7 +3155,7 @@ ipv6_udp_novrf()
 	a=${NSA_LO_IP6}
 	log_start
 	run_cmd nettest -6 -D -s -3 ${NSA_DEV} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 udp
 	run_cmd_nsb nettest -6 -D -r ${a}
 	log_test_addr ${a} $? 0 "Global server"
 
@@ -3165,7 +3165,7 @@ ipv6_udp_novrf()
 	#log_start
 	#show_hint "Should fail since loopback address is out of scope"
 	#run_cmd nettest -6 -D -I ${NSA_DEV} -s -3 ${NSA_DEV} &
-	#sleep 1
+	wait_local_port_listen ${NSA} 12345 udp
 	#run_cmd_nsb nettest -6 -D -r ${a}
 	#log_test_addr ${a} $? 1 "Device server"
 
@@ -3185,25 +3185,25 @@ ipv6_udp_novrf()
 	do
 		log_start
 		run_cmd_nsb nettest -6 -D -s &
-		sleep 1
+		wait_local_port_listen ${NSB} 12345 udp
 		run_cmd nettest -6 -D -r ${a} -0 ${NSA_IP6}
 		log_test_addr ${a} $? 0 "Client"
 
 		log_start
 		run_cmd_nsb nettest -6 -D -s &
-		sleep 1
+		wait_local_port_listen ${NSB} 12345 udp
 		run_cmd nettest -6 -D -r ${a} -d ${NSA_DEV} -0 ${NSA_IP6}
 		log_test_addr ${a} $? 0 "Client, device bind"
 
 		log_start
 		run_cmd_nsb nettest -6 -D -s &
-		sleep 1
+		wait_local_port_listen ${NSB} 12345 udp
 		run_cmd nettest -6 -D -r ${a} -d ${NSA_DEV} -C -0 ${NSA_IP6}
 		log_test_addr ${a} $? 0 "Client, device send via cmsg"
 
 		log_start
 		run_cmd_nsb nettest -6 -D -s &
-		sleep 1
+		wait_local_port_listen ${NSB} 12345 udp
 		run_cmd nettest -6 -D -r ${a} -d ${NSA_DEV} -S -0 ${NSA_IP6}
 		log_test_addr ${a} $? 0 "Client, device bind via IPV6_UNICAST_IF"
 
@@ -3225,7 +3225,7 @@ ipv6_udp_novrf()
 	do
 		log_start
 		run_cmd nettest -6 -D -s &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 udp
 		run_cmd nettest -6 -D -r ${a} -0 ${a} -1 ${a}
 		log_test_addr ${a} $? 0 "Global server, local connection"
 	done
@@ -3233,7 +3233,7 @@ ipv6_udp_novrf()
 	a=${NSA_IP6}
 	log_start
 	run_cmd nettest -6 -s -D -I ${NSA_DEV} -3 ${NSA_DEV} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 udp
 	run_cmd nettest -6 -D -r ${a}
 	log_test_addr ${a} $? 0 "Device server, unbound client, local connection"
 
@@ -3242,7 +3242,7 @@ ipv6_udp_novrf()
 		log_start
 		show_hint "Should fail 'Connection refused' since address is out of device scope"
 		run_cmd nettest -6 -s -D -I ${NSA_DEV} &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 udp
 		run_cmd nettest -6 -D -r ${a}
 		log_test_addr ${a} $? 1 "Device server, local connection"
 	done
@@ -3250,19 +3250,19 @@ ipv6_udp_novrf()
 	a=${NSA_IP6}
 	log_start
 	run_cmd nettest -6 -s -D &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 udp
 	run_cmd nettest -6 -D -d ${NSA_DEV} -r ${a}
 	log_test_addr ${a} $? 0 "Global server, device client, local connection"
 
 	log_start
 	run_cmd nettest -6 -s -D &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 udp
 	run_cmd nettest -6 -D -d ${NSA_DEV} -C -r ${a}
 	log_test_addr ${a} $? 0 "Global server, device send via cmsg, local connection"
 
 	log_start
 	run_cmd nettest -6 -s -D &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 udp
 	run_cmd nettest -6 -D -d ${NSA_DEV} -S -r ${a}
 	log_test_addr ${a} $? 0 "Global server, device client via IPV6_UNICAST_IF, local connection"
 
@@ -3271,28 +3271,28 @@ ipv6_udp_novrf()
 		log_start
 		show_hint "Should fail 'No route to host' since addresses on loopback are out of device scope"
 		run_cmd nettest -6 -D -s &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 udp
 		run_cmd nettest -6 -D -r ${a} -d ${NSA_DEV}
 		log_test_addr ${a} $? 1 "Global server, device client, local connection"
 
 		log_start
 		show_hint "Should fail 'No route to host' since addresses on loopback are out of device scope"
 		run_cmd nettest -6 -D -s &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 udp
 		run_cmd nettest -6 -D -r ${a} -d ${NSA_DEV} -C
 		log_test_addr ${a} $? 1 "Global server, device send via cmsg, local connection"
 
 		log_start
 		show_hint "Should fail 'No route to host' since addresses on loopback are out of device scope"
 		run_cmd nettest -6 -D -s &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 udp
 		run_cmd nettest -6 -D -r ${a} -d ${NSA_DEV} -S
 		log_test_addr ${a} $? 1 "Global server, device client via IP_UNICAST_IF, local connection"
 
 		log_start
 		show_hint "Should fail 'No route to host' since addresses on loopback are out of device scope"
 		run_cmd nettest -6 -D -s &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 udp
 		run_cmd nettest -6 -D -r ${a} -d ${NSA_DEV} -S -U
 		log_test_addr ${a} $? 1 "Global server, device client via IP_UNICAST_IF, local connection, with connect()"
 	done
@@ -3300,7 +3300,7 @@ ipv6_udp_novrf()
 	a=${NSA_IP6}
 	log_start
 	run_cmd nettest -6 -D -s -I ${NSA_DEV} -3 ${NSA_DEV} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 udp
 	run_cmd nettest -6 -D -d ${NSA_DEV} -r ${a} -0 ${a}
 	log_test_addr ${a} $? 0 "Device server, device client, local conn"
 
@@ -3314,7 +3314,7 @@ ipv6_udp_novrf()
 	run_cmd_nsb ip -6 ro add ${NSA_IP6}/128 dev ${NSB_DEV}
 	log_start
 	run_cmd nettest -6 -s -D &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 udp
 	run_cmd_nsb nettest -6 -D -r ${NSA_IP6}
 	log_test $? 0 "UDP in - LLA to GUA"
 
@@ -3338,7 +3338,7 @@ ipv6_udp_vrf()
 		log_start
 		show_hint "Should fail 'Connection refused' since global server is disabled"
 		run_cmd nettest -6 -D -s &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 udp
 		run_cmd_nsb nettest -6 -D -r ${a}
 		log_test_addr ${a} $? 1 "Global server"
 	done
@@ -3347,7 +3347,7 @@ ipv6_udp_vrf()
 	do
 		log_start
 		run_cmd nettest -6 -D -I ${VRF} -s -3 ${NSA_DEV} &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 udp
 		run_cmd_nsb nettest -6 -D -r ${a}
 		log_test_addr ${a} $? 0 "VRF server"
 	done
@@ -3356,7 +3356,7 @@ ipv6_udp_vrf()
 	do
 		log_start
 		run_cmd nettest -6 -D -I ${NSA_DEV} -s -3 ${NSA_DEV} &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 udp
 		run_cmd_nsb nettest -6 -D -r ${a}
 		log_test_addr ${a} $? 0 "Enslaved device server"
 	done
@@ -3378,7 +3378,7 @@ ipv6_udp_vrf()
 		log_start
 		show_hint "Should fail 'Connection refused' since global server is disabled"
 		run_cmd nettest -6 -D -s &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 udp
 		run_cmd nettest -6 -D -d ${VRF} -r ${a}
 		log_test_addr ${a} $? 1 "Global server, VRF client, local conn"
 	done
@@ -3387,7 +3387,7 @@ ipv6_udp_vrf()
 	do
 		log_start
 		run_cmd nettest -6 -D -I ${VRF} -s &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 udp
 		run_cmd nettest -6 -D -d ${VRF} -r ${a}
 		log_test_addr ${a} $? 0 "VRF server, VRF client, local conn"
 	done
@@ -3396,25 +3396,25 @@ ipv6_udp_vrf()
 	log_start
 	show_hint "Should fail 'Connection refused' since global server is disabled"
 	run_cmd nettest -6 -D -s &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 udp
 	run_cmd nettest -6 -D -d ${NSA_DEV} -r ${a}
 	log_test_addr ${a} $? 1 "Global server, device client, local conn"
 
 	log_start
 	run_cmd nettest -6 -D -I ${VRF} -s -3 ${NSA_DEV} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 udp
 	run_cmd nettest -6 -D -d ${NSA_DEV} -r ${a}
 	log_test_addr ${a} $? 0 "VRF server, device client, local conn"
 
 	log_start
 	run_cmd nettest -6 -D -I ${NSA_DEV} -s -3 ${NSA_DEV} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 udp
 	run_cmd nettest -6 -D -d ${VRF} -r ${a}
 	log_test_addr ${a} $? 0 "Enslaved device server, VRF client, local conn"
 
 	log_start
 	run_cmd nettest -6 -D -I ${NSA_DEV} -s -3 ${NSA_DEV} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 udp
 	run_cmd nettest -6 -D -d ${NSA_DEV} -r ${a}
 	log_test_addr ${a} $? 0 "Enslaved device server, device client, local conn"
 
@@ -3429,7 +3429,7 @@ ipv6_udp_vrf()
 	do
 		log_start
 		run_cmd nettest -6 -D -s -3 ${NSA_DEV} &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 udp
 		run_cmd_nsb nettest -6 -D -r ${a}
 		log_test_addr ${a} $? 0 "Global server"
 	done
@@ -3438,7 +3438,7 @@ ipv6_udp_vrf()
 	do
 		log_start
 		run_cmd nettest -6 -D -I ${VRF} -s -3 ${NSA_DEV} &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 udp
 		run_cmd_nsb nettest -6 -D -r ${a}
 		log_test_addr ${a} $? 0 "VRF server"
 	done
@@ -3447,7 +3447,7 @@ ipv6_udp_vrf()
 	do
 		log_start
 		run_cmd nettest -6 -D -I ${NSA_DEV} -s -3 ${NSA_DEV} &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 udp
 		run_cmd_nsb nettest -6 -D -r ${a}
 		log_test_addr ${a} $? 0 "Enslaved device server"
 	done
@@ -3465,7 +3465,7 @@ ipv6_udp_vrf()
 	#
 	log_start
 	run_cmd_nsb nettest -6 -D -s &
-	sleep 1
+	wait_local_port_listen ${NSB} 12345 udp
 	run_cmd nettest -6 -D -d ${VRF} -r ${NSB_IP6}
 	log_test $? 0 "VRF client"
 
@@ -3476,7 +3476,7 @@ ipv6_udp_vrf()
 
 	log_start
 	run_cmd_nsb nettest -6 -D -s &
-	sleep 1
+	wait_local_port_listen ${NSB} 12345 udp
 	run_cmd nettest -6 -D -d ${NSA_DEV} -r ${NSB_IP6}
 	log_test $? 0 "Enslaved device client"
 
@@ -3491,13 +3491,13 @@ ipv6_udp_vrf()
 	a=${NSA_IP6}
 	log_start
 	run_cmd nettest -6 -D -s -3 ${NSA_DEV} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 udp
 	run_cmd nettest -6 -D -d ${VRF} -r ${a}
 	log_test_addr ${a} $? 0 "Global server, VRF client, local conn"
 
 	#log_start
 	run_cmd nettest -6 -D -I ${VRF} -s -3 ${NSA_DEV} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 udp
 	run_cmd nettest -6 -D -d ${VRF} -r ${a}
 	log_test_addr ${a} $? 0 "VRF server, VRF client, local conn"
 
@@ -3505,13 +3505,13 @@ ipv6_udp_vrf()
 	a=${VRF_IP6}
 	log_start
 	run_cmd nettest -6 -D -s -3 ${VRF} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 udp
 	run_cmd nettest -6 -D -d ${VRF} -r ${a}
 	log_test_addr ${a} $? 0 "Global server, VRF client, local conn"
 
 	log_start
 	run_cmd nettest -6 -D -I ${VRF} -s -3 ${VRF} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 udp
 	run_cmd nettest -6 -D -d ${VRF} -r ${a}
 	log_test_addr ${a} $? 0 "VRF server, VRF client, local conn"
 
@@ -3527,25 +3527,25 @@ ipv6_udp_vrf()
 	a=${NSA_IP6}
 	log_start
 	run_cmd nettest -6 -D -s -3 ${NSA_DEV} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 udp
 	run_cmd nettest -6 -D -d ${NSA_DEV} -r ${a}
 	log_test_addr ${a} $? 0 "Global server, device client, local conn"
 
 	log_start
 	run_cmd nettest -6 -D -I ${VRF} -s -3 ${NSA_DEV} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 udp
 	run_cmd nettest -6 -D -d ${NSA_DEV} -r ${a}
 	log_test_addr ${a} $? 0 "VRF server, device client, local conn"
 
 	log_start
 	run_cmd nettest -6 -D -I ${NSA_DEV} -s -3 ${NSA_DEV} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 udp
 	run_cmd nettest -6 -D -d ${VRF} -r ${a}
 	log_test_addr ${a} $? 0 "Device server, VRF client, local conn"
 
 	log_start
 	run_cmd nettest -6 -D -I ${NSA_DEV} -s -3 ${NSA_DEV} &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 udp
 	run_cmd nettest -6 -D -d ${NSA_DEV} -r ${a}
 	log_test_addr ${a} $? 0 "Device server, device client, local conn"
 
@@ -3557,7 +3557,7 @@ ipv6_udp_vrf()
 	# link local addresses
 	log_start
 	run_cmd nettest -6 -D -s &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 udp
 	run_cmd_nsb nettest -6 -D -d ${NSB_DEV} -r ${NSA_LINKIP6}
 	log_test $? 0 "Global server, linklocal IP"
 
@@ -3568,7 +3568,7 @@ ipv6_udp_vrf()
 
 	log_start
 	run_cmd_nsb nettest -6 -D -s &
-	sleep 1
+	wait_local_port_listen ${NSB} 12345 udp
 	run_cmd nettest -6 -D -d ${NSA_DEV} -r ${NSB_LINKIP6}
 	log_test $? 0 "Enslaved device client, linklocal IP"
 
@@ -3579,7 +3579,7 @@ ipv6_udp_vrf()
 
 	log_start
 	run_cmd nettest -6 -D -s &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 udp
 	run_cmd nettest -6 -D -d ${NSA_DEV} -r ${NSA_LINKIP6}
 	log_test $? 0 "Enslaved device client, local conn - linklocal IP"
 
@@ -3592,7 +3592,7 @@ ipv6_udp_vrf()
 	run_cmd_nsb ip -6 ro add ${NSA_IP6}/128 dev ${NSB_DEV}
 	log_start
 	run_cmd nettest -6 -s -D &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 udp
 	run_cmd_nsb nettest -6 -D -r ${NSA_IP6}
 	log_test $? 0 "UDP in - LLA to GUA"
 
@@ -3771,7 +3771,7 @@ ipv6_rt()
 	do
 		log_start
 		run_cmd nettest ${varg} -s &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 tcp
 		run_cmd_nsb nettest ${varg} -r ${a} &
 		sleep 3
 		run_cmd ip link del ${VRF}
@@ -3785,7 +3785,7 @@ ipv6_rt()
 	do
 		log_start
 		run_cmd nettest ${varg} -I ${VRF} -s &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 tcp
 		run_cmd_nsb nettest ${varg} -r ${a} &
 		sleep 3
 		run_cmd ip link del ${VRF}
@@ -3799,7 +3799,7 @@ ipv6_rt()
 	do
 		log_start
 		run_cmd nettest ${varg} -I ${NSA_DEV} -s &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 tcp
 		run_cmd_nsb nettest ${varg} -r ${a} &
 		sleep 3
 		run_cmd ip link del ${VRF}
@@ -3814,7 +3814,7 @@ ipv6_rt()
 	#
 	log_start
 	run_cmd_nsb nettest ${varg} -s &
-	sleep 1
+	wait_local_port_listen ${NSB} 12345 tcp
 	run_cmd nettest ${varg} -d ${VRF} -r ${NSB_IP6} &
 	sleep 3
 	run_cmd ip link del ${VRF}
@@ -3825,7 +3825,7 @@ ipv6_rt()
 
 	log_start
 	run_cmd_nsb nettest ${varg} -s &
-	sleep 1
+	wait_local_port_listen ${NSB} 12345 tcp
 	run_cmd nettest ${varg} -d ${NSA_DEV} -r ${NSB_IP6} &
 	sleep 3
 	run_cmd ip link del ${VRF}
@@ -3842,7 +3842,7 @@ ipv6_rt()
 	do
 		log_start
 		run_cmd nettest ${varg} -s &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 tcp
 		run_cmd nettest ${varg} -d ${VRF} -r ${a} &
 		sleep 3
 		run_cmd ip link del ${VRF}
@@ -3856,7 +3856,7 @@ ipv6_rt()
 	do
 		log_start
 		run_cmd nettest ${varg} -I ${VRF} -s &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 tcp
 		run_cmd nettest ${varg} -d ${VRF} -r ${a} &
 		sleep 3
 		run_cmd ip link del ${VRF}
@@ -3869,7 +3869,7 @@ ipv6_rt()
 	a=${NSA_IP6}
 	log_start
 	run_cmd nettest ${varg} -s &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd nettest ${varg} -d ${NSA_DEV} -r ${a} &
 	sleep 3
 	run_cmd ip link del ${VRF}
@@ -3880,7 +3880,7 @@ ipv6_rt()
 
 	log_start
 	run_cmd nettest ${varg} -I ${VRF} -s &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd nettest ${varg} -d ${NSA_DEV} -r ${a} &
 	sleep 3
 	run_cmd ip link del ${VRF}
@@ -3891,7 +3891,7 @@ ipv6_rt()
 
 	log_start
 	run_cmd nettest ${varg} -I ${NSA_DEV} -s &
-	sleep 1
+	wait_local_port_listen ${NSA} 12345 tcp
 	run_cmd nettest ${varg} -d ${NSA_DEV} -r ${a} &
 	sleep 3
 	run_cmd ip link del ${VRF}
@@ -3950,7 +3950,7 @@ netfilter_tcp_reset()
 	do
 		log_start
 		run_cmd nettest -s &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 tcp
 		run_cmd_nsb nettest -r ${a}
 		log_test_addr ${a} $? 1 "Global server, reject with TCP-reset on Rx"
 	done
@@ -3968,7 +3968,7 @@ netfilter_icmp()
 	do
 		log_start
 		run_cmd nettest ${arg} -s &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 tcp
 		run_cmd_nsb nettest ${arg} -r ${a}
 		log_test_addr ${a} $? 1 "Global ${stype} server, Rx reject icmp-port-unreach"
 	done
@@ -4007,7 +4007,7 @@ netfilter_tcp6_reset()
 	do
 		log_start
 		run_cmd nettest -6 -s &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 tcp
 		run_cmd_nsb nettest -6 -r ${a}
 		log_test_addr ${a} $? 1 "Global server, reject with TCP-reset on Rx"
 	done
@@ -4025,7 +4025,7 @@ netfilter_icmp6()
 	do
 		log_start
 		run_cmd nettest -6 -s ${arg} &
-		sleep 1
+		wait_local_port_listen ${NSA} 12345 tcp
 		run_cmd_nsb nettest -6 ${arg} -r ${a}
 		log_test_addr ${a} $? 1 "Global ${stype} server, Rx reject icmp-port-unreach"
 	done
@@ -4221,12 +4221,12 @@ use_case_snat_on_vrf()
 	run_cmd ip6tables -t nat -A POSTROUTING -p tcp -m tcp --dport ${port} -j SNAT --to-source ${NSA_LO_IP6} -o ${VRF}
 
 	run_cmd_nsb nettest -s -l ${NSB_IP} -p ${port} &
-	sleep 1
+	wait_local_port_listen ${NSB} ${port} tcp
 	run_cmd nettest -d ${VRF} -r ${NSB_IP} -p ${port}
 	log_test $? 0 "IPv4 TCP connection over VRF with SNAT"
 
 	run_cmd_nsb nettest -6 -s -l ${NSB_IP6} -p ${port} &
-	sleep 1
+	wait_local_port_listen ${NSB} ${port} tcp
 	run_cmd nettest -6 -d ${VRF} -r ${NSB_IP6} -p ${port}
 	log_test $? 0 "IPv6 TCP connection over VRF with SNAT"
 
-- 
2.51.0


