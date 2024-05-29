Return-Path: <stable+bounces-47646-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E18628D3A8D
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 17:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25125B26382
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 15:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E51A17F39F;
	Wed, 29 May 2024 15:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="VgcMTizQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECA917F38E
	for <stable@vger.kernel.org>; Wed, 29 May 2024 15:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716995868; cv=none; b=QK1syJBbnUMeWS6h4aGOOO0vMZsyEmghJNdpx8OuFfyJIS1ZnasouiSWr2prTjddsv1FZV4d5YGFrfEaL/cghNuIXnXaUk18RPMvXPDkqWZ4jPbDiR/0KIrz5+8Rd7fJqnbL4PUm5pv3Zflg4fPYerR0PzsAMkEqmJHm5uvpKNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716995868; c=relaxed/simple;
	bh=Jdw9Q0fhrZiHcNcFms8IEwmn79ke0fCkFUYIy45rBCg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LbIUTfaEt3JDeSXXpSgqFw9GOG1a78abx77Pe7n+X7W5C4mLqAnz4j22NQHPh8km01fvxnZEko1NeD9EEKAW/ai4YeXSA7QATCaiIBrFg+vmSMwrTyhMHANkmfeFCD+0rd3726S9G/AWwFBygYNIxW5Gi4fpaYV+UH976AukTRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=VgcMTizQ; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from localhost.localdomain (2.general.phlin.uk.vpn [10.172.194.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id D46933FEEB;
	Wed, 29 May 2024 15:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1716995857;
	bh=s1DeipaQAwNBHZAO/JHwgLJZxUfbzGqo+sW2fFtGiJo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=VgcMTizQOqZG9c6Yr5DxJDYnvNVJbYvwhfGZ0PCqeZElXKAAV3TiYPv8mQS9IRuw7
	 dsayjkWlxsZim8OinywQJoXe7R0NqTrMLuQCuySbsdDYO6mClDRQwHh9wPhygD+yhp
	 KYff49haCPJNoQOgzoDbabC6ighak/i+5ilhASY3BqXUUDs4gHJtzSH7GRKclm4+/6
	 +9SlLhPTf7IbcFRoyAlXiLv+DyIrCPj4HUlPhikqhcYWVWSBhIVsLerzXg/F7bG/wg
	 mW6mmgKlrzLD3cxZHoVqoarhlqjiTj7nYjioesPV36LZxJqdOvLGe/DOQfphhfsNh0
	 9T0zQJlaZ8xWQ==
From: Po-Hsu Lin <po-hsu.lin@canonical.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	po-hsu.lin@canonical.com
Subject: [PATCH 6.6.y 1/4] selftests/net: synchronize udpgro tests' tx and rx connection
Date: Wed, 29 May 2024 23:16:00 +0800
Message-Id: <20240529151603.204106-2-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529151603.204106-1-po-hsu.lin@canonical.com>
References: <20240529151603.204106-1-po-hsu.lin@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lucas Karpinski <lkarpins@redhat.com>

commit 3bdd9fd29cb0f136b307559a19c107210ad5c314 upstream.

The sockets used by udpgso_bench_tx aren't always ready when
udpgso_bench_tx transmits packets. This issue is more prevalent in -rt
kernels, but can occur in both. Replace the hacky sleep calls with a
function that checks whether the ports in the namespace are ready for
use.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Lucas Karpinski <lkarpins@redhat.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[PHLin: context adjustment for the differences in BPF_FILE]
Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/net/net_helper.sh     | 22 ++++++++++++++++++++++
 tools/testing/selftests/net/udpgro.sh         | 13 ++++++-------
 tools/testing/selftests/net/udpgro_bench.sh   |  5 +++--
 tools/testing/selftests/net/udpgro_frglist.sh |  5 +++--
 4 files changed, 34 insertions(+), 11 deletions(-)
 create mode 100755 tools/testing/selftests/net/net_helper.sh

diff --git a/tools/testing/selftests/net/net_helper.sh b/tools/testing/selftests/net/net_helper.sh
new file mode 100755
index 00000000..4fe0bef
--- /dev/null
+++ b/tools/testing/selftests/net/net_helper.sh
@@ -0,0 +1,22 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Helper functions
+
+wait_local_port_listen()
+{
+	local listener_ns="${1}"
+	local port="${2}"
+	local protocol="${3}"
+	local port_hex
+	local i
+
+	port_hex="$(printf "%04X" "${port}")"
+	for i in $(seq 10); do
+		if ip netns exec "${listener_ns}" cat /proc/net/"${protocol}"* | \
+		   grep -q "${port_hex}"; then
+			break
+		fi
+		sleep 0.1
+	done
+}
diff --git a/tools/testing/selftests/net/udpgro.sh b/tools/testing/selftests/net/udpgro.sh
index 3f09ac78..8802604 100755
--- a/tools/testing/selftests/net/udpgro.sh
+++ b/tools/testing/selftests/net/udpgro.sh
@@ -3,6 +3,8 @@
 #
 # Run a series of udpgro functional tests.
 
+source net_helper.sh
+
 readonly PEER_NS="ns-peer-$(mktemp -u XXXXXX)"
 
 BPF_FILE="xdp_dummy.o"
@@ -51,8 +53,7 @@ run_one() {
 		echo "ok" || \
 		echo "failed" &
 
-	# Hack: let bg programs complete the startup
-	sleep 0.2
+	wait_local_port_listen ${PEER_NS} 8000 udp
 	./udpgso_bench_tx ${tx_args}
 	ret=$?
 	wait $(jobs -p)
@@ -97,7 +98,7 @@ run_one_nat() {
 		echo "ok" || \
 		echo "failed"&
 
-	sleep 0.1
+	wait_local_port_listen "${PEER_NS}" 8000 udp
 	./udpgso_bench_tx ${tx_args}
 	ret=$?
 	kill -INT $pid
@@ -118,11 +119,9 @@ run_one_2sock() {
 		echo "ok" || \
 		echo "failed" &
 
-	# Hack: let bg programs complete the startup
-	sleep 0.2
+	wait_local_port_listen "${PEER_NS}" 12345 udp
 	./udpgso_bench_tx ${tx_args} -p 12345
-	sleep 0.1
-	# first UDP GSO socket should be closed at this point
+	wait_local_port_listen "${PEER_NS}" 8000 udp
 	./udpgso_bench_tx ${tx_args}
 	ret=$?
 	wait $(jobs -p)
diff --git a/tools/testing/selftests/net/udpgro_bench.sh b/tools/testing/selftests/net/udpgro_bench.sh
index 65ff1d4..7080eae 100755
--- a/tools/testing/selftests/net/udpgro_bench.sh
+++ b/tools/testing/selftests/net/udpgro_bench.sh
@@ -3,6 +3,8 @@
 #
 # Run a series of udpgro benchmarks
 
+source net_helper.sh
+
 readonly PEER_NS="ns-peer-$(mktemp -u XXXXXX)"
 
 BPF_FILE="xdp_dummy.o"
@@ -40,8 +42,7 @@ run_one() {
 	ip netns exec "${PEER_NS}" ./udpgso_bench_rx ${rx_args} -r &
 	ip netns exec "${PEER_NS}" ./udpgso_bench_rx -t ${rx_args} -r &
 
-	# Hack: let bg programs complete the startup
-	sleep 0.2
+	wait_local_port_listen "${PEER_NS}" 8000 udp
 	./udpgso_bench_tx ${tx_args}
 }
 
diff --git a/tools/testing/selftests/net/udpgro_frglist.sh b/tools/testing/selftests/net/udpgro_frglist.sh
index bd51d38..e1ff645 100755
--- a/tools/testing/selftests/net/udpgro_frglist.sh
+++ b/tools/testing/selftests/net/udpgro_frglist.sh
@@ -3,6 +3,8 @@
 #
 # Run a series of udpgro benchmarks
 
+source net_helper.sh
+
 readonly PEER_NS="ns-peer-$(mktemp -u XXXXXX)"
 
 BPF_FILE="xdp_dummy.o"
@@ -45,8 +47,7 @@ run_one() {
         echo ${rx_args}
 	ip netns exec "${PEER_NS}" ./udpgso_bench_rx ${rx_args} -r &
 
-	# Hack: let bg programs complete the startup
-	sleep 0.2
+	wait_local_port_listen "${PEER_NS}" 8000 udp
 	./udpgso_bench_tx ${tx_args}
 }
 
-- 
2.7.4


