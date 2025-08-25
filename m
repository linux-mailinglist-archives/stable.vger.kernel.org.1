Return-Path: <stable+bounces-172780-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E99EDB33638
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 08:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94FEA1745A5
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 06:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1557B2765CE;
	Mon, 25 Aug 2025 06:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTCP4RSG"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B644A277C85;
	Mon, 25 Aug 2025 06:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756102183; cv=none; b=PDx+5oTrGBBLmEYOBr0LIFGqKYfo4VgWDGYOJAVHsEFIbPbb0IYmMoEydF5MSWcdJVa9XCHf90KMZFfbGKdb6a4hY4k+nDeYC0BPHR2UFmuf6V03g2SDdd1wv6Zo7/F4oYR+uIJuXAa1jt3dvr8P+bmKGNEjvsYwE8Zc01sesrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756102183; c=relaxed/simple;
	bh=Uh3C5KzgehWTf7PBs8GBkkXVoSNOHZeQx8B+f8Jht+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DqjxFkSKKR9i0I9+oJvPxTwfg9RuVhb9+ZRw5YIPTHQ1MQHX3kz3IFwcuRy46Hu0I+0+q65wecdESLfMnxeVKh5AqfVl9RB3+fTxJ6R9cQBPwqHDyJhLZKJJnENYSv8OOqjOT9/L8xtJHfWImijW1ErX8GmBeipZ0qDFQ96k0Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTCP4RSG; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3c8b0f1b699so651101f8f.0;
        Sun, 24 Aug 2025 23:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756102180; x=1756706980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNGUiH1HlaDsvr1HkUqzRQTsgKZhSr885hmNIdYPFpk=;
        b=YTCP4RSGOIDpj8aM3Qhx9Mjmp1wCx3TlcbqzS1DoLvFhVQ+M2rrZ9Ysjefxx8dwN4Z
         3M/De2u/RgdRtVHJJvXmxUiR+34knsNhQK7wJ36e+Z1MybfSlU+pJ7OT6V1CNNLJKbMD
         Qel3L/Bih1llGdDVQl1j3cwqbB5MwpWGcskLHHNAp/LkGDd5b8g/pTDOcduvSW2EbwDW
         TTIMymjj03pKQg9tNYHeJH1a+bAn0u3OSKAJykARfs/LCyQFG0ZQ1hiFb0LPhku3ycEC
         Su+3Q7tO0OKzOSWtMH8LOT4qG60rE8nhfajFfTrU838+z5ZQmQlZNpbtt/92SHeUuaHt
         RUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756102180; x=1756706980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dNGUiH1HlaDsvr1HkUqzRQTsgKZhSr885hmNIdYPFpk=;
        b=OBeI1Zz0rENCAUYmAAv44efm8cwQ+1zn1Ga1E7/wMXbIfzcs1wcgPuTx7Lt9GhrgYc
         EIEnK94ggZySrJJcK/YYzBaAaM/RSMOQp/i0MITRAkbKNbu1QIePa/11QlDsHB3Klh72
         njInZwK0FzzvMiVxRsPLKfOjfdhTredeHavLq2ehtJok1Z+VivyzN1FLO9+Lqk1lAcuC
         wW3CAIfRcPZahkur0BrQaAl2Qmqd28ro9HMRBw7gnku/Q2FtZmihXFFj96GWvqtJmHmh
         juLH/6T9rp+H7Cbw9KaqwDuWSwdKTHe33HqUTttXV51aM4Huhf5+MXlictV+WtkgzYW8
         +HSg==
X-Forwarded-Encrypted: i=1; AJvYcCU3LijibqqIYrjEgJKAPE8iyZGjKmh0hxba93n8NPBgYXRxobEp0pVlOxRJsMqKLM8Nshd5lAQ=@vger.kernel.org, AJvYcCUJgFU8tCzYbswkRTBa41G9bhvrD5uU1m6sdwXY+NZ4KDbjacHW402fPe4eDky22k5mM/3A+oy6@vger.kernel.org
X-Gm-Message-State: AOJu0YyiQSw66QcoBxtpAnX/0BqaezLBHrdUG+YuRH5zRxUnwtZ4UapF
	LEg9QvGkqP+dOZmsGuKPTIXvJ1UNACnPahcKzjsfxl+3zHfv+crcDMKI
X-Gm-Gg: ASbGncvzbJwV00rBSS5pEYjl0IddxqxTm+P1DBUiFQ5FIbqQ/duH9jSp1E9h9bvGN4m
	/zkXa0zQTQonIMsRUmzpF+L7/9YiTN68KmFymkpZkp+ys58v1+LDG1lhh4Cx1MJKwtIhvsZePPg
	7B/+5sIMux2noQ+WGxO2bWHU6iQJCiMwvG7RntVSTFIuct+zuGug2/fb8dn5lOqIw5SYXTqiXpV
	Hsf059uONr4ndEBpzFm8+AD6SUF1aWeqFSRFIJ/dZk2L58iNXl05BlO35TAUcd1o0HnzGubgfri
	0iEjqcFSdP9AVNsQKVSxXNizG9RxcO4wQa9QfWkER3qBwN7BUsFHWRDl5+0ZUHoK92b1Na5V9WP
	lLJ5Gxk7wUDuH/pgA0IQu4g==
X-Google-Smtp-Source: AGHT+IHcrevRUj1cD5LeAp4LI1B3nH7eEN5AQX9rs7eSbOAM9Hvpepk/llONPE+TUwRHg/i9+KJPcQ==
X-Received: by 2002:a05:6000:24c4:b0:3a6:c923:bc5f with SMTP id ffacd0b85a97d-3c5dae061dfmr7042185f8f.17.1756102179839;
        Sun, 24 Aug 2025 23:09:39 -0700 (PDT)
Received: from oscar-xps.. ([45.128.133.220])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b5759274asm94690775e9.23.2025.08.24.23.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 23:09:39 -0700 (PDT)
From: Oscar Maes <oscmaes92@gmail.com>
To: bacs@librecast.net,
	brett@librecast.net,
	kuba@kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	netdev@vger.kernel.org,
	regressions@lists.linux.dev,
	stable@vger.kernel.org,
	Oscar Maes <oscmaes92@gmail.com>
Subject: [PATCH net 2/2] selftests: net: add test for destination in broadcast packets
Date: Mon, 25 Aug 2025 08:09:18 +0200
Message-Id: <20250825060918.4799-2-oscmaes92@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250825060918.4799-1-oscmaes92@gmail.com>
References: <20250825060229-oscmaes92@gmail.com>
 <20250825060918.4799-1-oscmaes92@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test to check the broadcast ethernet destination field is set
correctly.

This test sends a broadcast ping, captures it using tcpdump and
ensures that all bits of the 6 octet ethernet destination address
are correctly set by examining the output capture file.

Signed-off-by: Oscar Maes <oscmaes92@gmail.com>
---
 tools/testing/selftests/net/Makefile          |  1 +
 .../selftests/net/broadcast_ether_dst.sh      | 82 +++++++++++++++++++
 2 files changed, 83 insertions(+)
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
index 000000000000..865b5c7c8c8a
--- /dev/null
+++ b/tools/testing/selftests/net/broadcast_ether_dst.sh
@@ -0,0 +1,82 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Author: Brett A C Sheffield <bacs@librecast.net>
+# Author: Oscar Maes <oscmaes92@gmail.com>
+#
+# Ensure destination ethernet field is correctly set for
+# broadcast packets
+
+source lib.sh
+
+CLIENT_IP4="192.168.0.1"
+GW_IP4="192.168.0.2"
+
+setup() {
+	setup_ns CLIENT_NS SERVER_NS
+
+	ip -net "${SERVER_NS}" link add link1 type veth \
+		peer name link0 netns "${CLIENT_NS}"
+
+	ip -net "${CLIENT_NS}" link set link0 up
+	ip -net "${CLIENT_NS}" addr add "${CLIENT_IP4}"/24 dev link0
+
+	ip -net "${SERVER_NS}" link set link1 up
+
+	ip -net "${CLIENT_NS}" route add default via "${GW_IP4}"
+	ip netns exec "${CLIENT_NS}" arp -s "${GW_IP4}" 00:11:22:33:44:55
+}
+
+cleanup() {
+	rm -f "${CAPFILE}"
+	ip -net "${SERVER_NS}" link del link1
+	cleanup_ns "${CLIENT_NS}" "${SERVER_NS}"
+}
+
+test_broadcast_ether_dst() {
+	local rc=0
+	CAPFILE=$(mktemp -u cap.XXXXXXXXXX)
+
+	echo "Testing ethernet broadcast destination"
+
+	# start tcpdump listening for icmp
+	# tcpdump will exit after receiving a single packet
+	# timeout will kill tcpdump if it is still running after 2s
+	timeout 2s ip netns exec "${CLIENT_NS}" \
+		tcpdump -i link0 -c 1 -w "${CAPFILE}" icmp &> /dev/null &
+	pid=$!
+	sleep 0.1 # let tcpdump wake up
+
+	# send broadcast ping
+	ip netns exec "${CLIENT_NS}" \
+		ping -W0.01 -c1 -b 255.255.255.255 &> /dev/null
+
+	# wait for tcpdump for exit after receiving packet
+	wait "${pid}"
+
+	# compare ethernet destination field to ff:ff:ff:ff:ff:ff
+	ether_dst=$(tcpdump -r "${CAPFILE}" -tnne 2>/dev/null | \
+			awk '{sub(/,/,"",$3); print $3}')
+	if [[ "${ether_dst}" == "ff:ff:ff:ff:ff:ff" ]]; then
+		echo "[ OK ]"
+		rc="${ksft_pass}"
+	else
+		echo "[FAIL] expected dst ether addr to be ff:ff:ff:ff:ff:ff," \
+			"got ${ether_dst}"
+		rc="${ksft_fail}"
+	fi
+
+	return "${rc}"
+}
+
+if [ ! -x "$(command -v tcpdump)" ]; then
+	echo "SKIP: Could not run test without tcpdump tool"
+	exit "${ksft_skip}"
+fi
+
+trap cleanup EXIT
+
+setup
+test_broadcast_ether_dst
+
+exit $?
-- 
2.39.5


