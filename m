Return-Path: <stable+bounces-176458-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D4BB37A49
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 08:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D585A2084FB
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 06:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992242D6E7A;
	Wed, 27 Aug 2025 06:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7glTEmL"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF14283FF7;
	Wed, 27 Aug 2025 06:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756275862; cv=none; b=fL7Oy7qgNkmZ6FkC+YB3qS/mVCyHOjQqG7b6OC7dV4/p9ivs241TpXRspdclIk8SezR4jtg/Ym4jPyYrODrv6KpZPwU4nrNVIaYTu1wbYjJfKYjHVxgY3oLdishW/NzMZ9e7kjL6SSYtNxsb306AiIzT2Qtn2RrYWRM81/+P06c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756275862; c=relaxed/simple;
	bh=o3fJsDxjcT+pYmkEs+fcR3uJijtyNsAylt/fN04Mq+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oO4CBslCgAwzxnDbMd0uP5Q/g+YvyInc/tectUSIVj1HnB1K3mf0ffKwOIp0RNCf6Iq1Qv1fZ4ia8P9ZVUjTjEDCR6vwGQCbM2SGxOnwL9W64Sub7Bi7LF12aX1Q9lFWcpYmf+cAuMiXVDVqYK+TYMVkomrDadxveETYfYvl68E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7glTEmL; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45b618b7d33so23428395e9.1;
        Tue, 26 Aug 2025 23:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756275858; x=1756880658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9wleIvMe0ym3Qd7+HMCQnFYyO0M6VbPyNnWDavGhvg=;
        b=E7glTEmLcaFskjJP9Hpdii89tGtnDMQcQYld0jk6H+EV4ZKPlK2u75jVPPoadsY99F
         P4DmvMIBZ5P8xkWoh5Vs9BpmCsbe+jEW/WvF0sB5bOs5GuEx6Xn8vPKihHS79Br9rAeU
         WxnW8oaqntfhKqZXEmSk+/Z7rh4jWm3vCgwEnIaqghXCtZ2vcs7dlGnRu5mMcgS1sRIk
         8NTTspSHH+JaIyCse0m8grpx6ZeIecDD8Z0tRMIiUPn4DDBhZxg/59PawBt8aZDFZkQh
         RGrItjN+82RYb9pk2F6EpLiTAD4z6XTIvZy8UubMtJiISixIbVj9fTwOHncjXJ8/jIOg
         KpTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756275858; x=1756880658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r9wleIvMe0ym3Qd7+HMCQnFYyO0M6VbPyNnWDavGhvg=;
        b=RxbAvutLvMndr6tI9Cu8EivkKRTGrhSYqUmDSWyLS5fJng2DyC9Fn9ePCe7z5vF6ND
         SOy5i0Rx814hnmyDqIhUO9JmOjBlqN1xRr/DmP1homGVvNbSZHTz4YFCXlnSAMiewGZi
         SmRSi/HCbXLfV0YqfESP9oGEqCUK1IsDPMQZnAdPTJcioVbbYJn5Tq5UlsNYVmawH1BM
         0q011w555NU9avEmzs9epvmyXcRqntM/04ZxytY5E5TdEKBkqzCZ9q9XqhrH/nKl6ukh
         jFd+sUWpAE1BCgW+iwq3aHxsQwJqPp1oC8Bs/BjrtOZFLvbrO73y2h62GYm9K88slGco
         zskQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjj1sbAufoKA1ho0a+7Z2prgGmMe3D93rwpLVvagGzztsQBESAdl/lvc3mLD0C4rDCy3EqVfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPqe8o5DIHsTkehUXnyNvlQ4kb9VmlB5wSl/Yuo1BAZm0TqDSx
	f48j3Kc/yvP/qQLaFy6nzeMYvK/8YZLGHTVyWDU56O+jUGJZv/utvMQc3r1gmA==
X-Gm-Gg: ASbGnctzgjDo4cbqmUvAQFX+ekZsJbkvnsJwcwopiH2H781C88tpDDZQqYyeO0oMy0g
	JLl3PzWNBc2p6D616RRyNOam3PUrRNYAdicvzGQcG2sdXHOhpwH7uCtuDk/beYcDImq9r4FYaOl
	aNRMaid6mHB89dpCWjkJjK9uSVLieBFQtmFtNWC3aBuxViBcQ+ZdQobaSQpX9zDstHG/LMh3A6U
	5Vq05IJqePhDUgxUm07DM4SfzkvFkUc/te3X95bOrmUnZfNC1V4TNg9DdIP4vXD5ODafb6HNqE6
	6JySaoSW12LZggjh/DCobLzv78TjSVe8fn2AYPtykCJTNmNvdgCo3f8unYWkT/QD7zTJYbmtRqY
	ikB3NEUGW5e4PR2tZnoiOQspJDCqepoBFDnPt
X-Google-Smtp-Source: AGHT+IETtphtb7cnxUtM++p+wBtWizOrRU+EkeyiDMIFTiAZ8GkOFL96kRLhi57Ve27XcASOnpr/UQ==
X-Received: by 2002:a05:600c:4fc7:b0:456:25aa:e9b0 with SMTP id 5b1f17b1804b1-45b517ad57emr236095245e9.16.1756275857616;
        Tue, 26 Aug 2025 23:24:17 -0700 (PDT)
Received: from oscar-xps.. ([45.128.133.230])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b66c383b1sm29749875e9.3.2025.08.26.23.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 23:24:17 -0700 (PDT)
From: Oscar Maes <oscmaes92@gmail.com>
To: netdev@vger.kernel.org,
	bacs@librecast.net,
	brett@librecast.net,
	kuba@kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	regressions@lists.linux.dev,
	stable@vger.kernel.org,
	Oscar Maes <oscmaes92@gmail.com>
Subject: [PATCH net v3 2/2] selftests: net: add test for destination in broadcast packets
Date: Wed, 27 Aug 2025 08:23:22 +0200
Message-Id: <20250827062322.4807-2-oscmaes92@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250827062322.4807-1-oscmaes92@gmail.com>
References: <20250827062322.4807-1-oscmaes92@gmail.com>
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
Link to discussion:
https://lore.kernel.org/netdev/20250822165231.4353-4-bacs@librecast.net/

Thanks to Brett Sheffield for writing the initial version of this
selftest!

 tools/testing/selftests/net/Makefile          |  1 +
 .../selftests/net/broadcast_ether_dst.sh      | 82 +++++++++++++++++++
 2 files changed, 83 insertions(+)
 create mode 100755 tools/testing/selftests/net/broadcast_ether_dst.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index b31a71f2b372..56ad10ea6628 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -115,6 +115,7 @@ TEST_PROGS += skf_net_off.sh
 TEST_GEN_FILES += skf_net_off
 TEST_GEN_FILES += tfo
 TEST_PROGS += tfo_passive.sh
+TEST_PROGS += broadcast_ether_dst.sh
 TEST_PROGS += broadcast_pmtu.sh
 TEST_PROGS += ipv6_force_forwarding.sh
 
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


