Return-Path: <stable+bounces-172580-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E27B3287B
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 14:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF1185C709D
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 12:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E531125B2FD;
	Sat, 23 Aug 2025 12:15:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bregans-0.gladserv.net (bregans-0.gladserv.net [185.128.210.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AA525A2A1;
	Sat, 23 Aug 2025 12:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.210.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755951310; cv=none; b=NO8g3EnK0aMKFCnASd3T/xe/QQKBX6o9P7Kb3nmnhoRCnM8w3N6TPH+8EpXS4dJPhS27AYFVW+abusWq1KggHgaTJh8Lhx4QPZqJEqCZoYmHm2M4Ox2SoyUNT8TynW8xz0y34EpTJ50ICFyK8aeZFeeg566PazgKL9wyrbY8UH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755951310; c=relaxed/simple;
	bh=oGwwTtNxjC5t6H2oUN4Te1U8p72aoeL6OFMsznW6HIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jfa3nszTUzL4lP2FcYrU/SP/ugspNOQM5yTOs9ogayN+oR5hcUPtXpz3mul7AFboNbgLDtgG42P/L2IywKpuBxnvXOgL+c///+Sfcgjty/xSp2dAiJMd+ndQ96KPZtkh1KLfOFakyHPxOd7mcI/CXeaC+LpO5jEnVv0yE9oY3v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=librecast.net; arc=none smtp.client-ip=185.128.210.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=librecast.net
From: Brett A C Sheffield <bacs@librecast.net>
To: regressions@lists.linux.dev
Cc: netdev@vger.kernel.org,
	stable@vger.kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	oscmaes92@gmail.com,
	kuba@kernel.org,
	Brett A C Sheffield <bacs@librecast.net>
Subject: [PATCH v2 1/2] selftests: net: add test for broadcast destination
Date: Sat, 23 Aug 2025 12:13:36 +0000
Message-ID: <20250823121336.18492-2-bacs@librecast.net>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250822183250.2a9cb92c@kernel.org>
References: <20250822183250.2a9cb92c@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test to check the broadcast ethernet destination field is set
correctly.

This test uses the tcpdump and socat programs.

Send a UDP broadcast packet to UDP port 9 (DISCARD), capture this
with tcpdump and ensure that all bits of the 6 octet ethernet destination
are correctly set.

Cc: stable@vger.kernel.org
Signed-off-by: Brett A C Sheffield <bacs@librecast.net>
Link: https://lore.kernel.org/regressions/20250822165231.4353-4-bacs@librecast.net
---
 tools/testing/selftests/net/Makefile          |  1 +
 .../selftests/net/broadcast_ether_dst.sh      | 38 +++++++++++++++++++
 2 files changed, 39 insertions(+)
 create mode 100755 tools/testing/selftests/net/broadcast_ether_dst.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index b31a71f2b372..463642a78eea 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -116,6 +116,7 @@ TEST_GEN_FILES += skf_net_off
 TEST_GEN_FILES += tfo
 TEST_PROGS += tfo_passive.sh
 TEST_PROGS += broadcast_pmtu.sh
+TEST_PROGS += broadcast_ether_dst.sh
 TEST_PROGS += ipv6_force_forwarding.sh
 
 # YNL files, must be before "include ..lib.mk"
diff --git a/tools/testing/selftests/net/broadcast_ether_dst.sh b/tools/testing/selftests/net/broadcast_ether_dst.sh
new file mode 100755
index 000000000000..de6abe3513b6
--- /dev/null
+++ b/tools/testing/selftests/net/broadcast_ether_dst.sh
@@ -0,0 +1,38 @@
+#!/bin/bash -eu
+# SPDX-License-Identifier: GPL-2.0
+#
+# Author: Brett A C Sheffield <bacs@librecast.net>
+#
+# Ensure destination ethernet field is correctly set for
+# broadcast packets
+
+if ! which tcpdump > /dev/null 2>&1; then
+        echo "No tcpdump found. Required for this test."
+        exit $ERR
+fi
+
+CAPFILE=$(mktemp -u cap.XXXXXXXXXX)
+
+# start tcpdump listening on udp port 9
+# tcpdump will exit after receiving a single packet
+# timeout will kill tcpdump if it is still running after 2s
+timeout 2s tcpdump -c 1 -w ${CAPFILE} udp port 9 > /dev/null 2>&1 &
+PID=$!
+sleep 0.1 # let tcpdump wake up
+
+echo "Testing ethernet broadcast destination"
+
+# send broadcast UDP packet to port 9 (DISCARD)
+echo "Alonso is a good boy" | socat - udp-datagram:255.255.255.255:9,broadcast
+
+# wait for tcpdump for exit after receiving packet
+wait $PID
+
+# compare ethernet destination field to ff:ff:ff:ff:ff:ff
+# pcap has a 24 octet header + 16 octet header for each packet
+# ethernet destination is the first field in the packet
+printf '\xff\xff\xff\xff\xff\xff'| cmp -i40:0 -n6 ${CAPFILE} > /dev/null 2>&1
+RESULT=$?
+
+rm -f "${CAPFILE}"
+exit $RESULT

base-commit: 01b9128c5db1b470575d07b05b67ffa3cb02ebf1
-- 
2.49.1


