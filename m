Return-Path: <stable+bounces-177506-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 358D2B40860
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 17:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BCD65E3BE9
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 15:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C142EDD6B;
	Tue,  2 Sep 2025 15:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5t1J8OR"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258CC1DE2A0;
	Tue,  2 Sep 2025 15:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756825386; cv=none; b=ZHVt0xFGBEmaUBGiJ+8HKOlqj4KnuQlkHJchsYxWXxD5h3c3Wzbg0OFyjsMW8qjYN3J+jpW0xCBq1lvfooRsQxY6je9iLXAEQGmdfD70RsNZasKPPLcf1xkxxJBCRj0jJuourWRKYyf+qZBQU/G0eqHYJSD0WChkJth5YPeiPcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756825386; c=relaxed/simple;
	bh=nCJi32g+2XrXf+4mA4uBGNHiEBbBcgVatkU/fgKodc4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u/XFwX+d69mrHYm5Bgsu6npTYvyhQwmg5g3ZRcC9sxOgKVtLHEwCXnMF5PBnLLP4us/ienyHvI2MKxKxuVxHUUGAoOo2NoBcJadtEpOI+238/zhEwCc0N9XnUSfStgbejNofD05w6BanAFf41WILETU60i9gx50EXibnRjQY92I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5t1J8OR; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45b79ec2fbeso37292825e9.3;
        Tue, 02 Sep 2025 08:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756825383; x=1757430183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+q+6KxQjNGlpDK0FwgWdmK7uwlAylATpqLWZsT8oVn8=;
        b=Q5t1J8OR+52N94vE+ORBrOOkd5Tgurd+Cy6bHC7koEmNWwzvRE9fJK+LzWZz+hLIqU
         xgKjcc3mKdKvIkhibxs2e7Nyuhj/SA8ZEBERDSgz3K4A3DXRuXKNoJbjfp7uSl00aTnL
         Cp0oRBR2bG6Ru3uFVK5ZklQcVr+Lx6igAC++4TgZ1bp5AL9QNJtbwM2m0E3sORkbteVh
         s7sKfW5NRYVG2FpDUaep4DWnhMKvfWffcnzXmuFYPXTQYhKK6+hwJid/rJKsuPZTFWt/
         767Tb/yKaW+sJDAfdX0pNJTBWt/Rg7or5XJxecWu82xWB5TxaxIwZDFbYz+2+bKKLxER
         8SCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756825383; x=1757430183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+q+6KxQjNGlpDK0FwgWdmK7uwlAylATpqLWZsT8oVn8=;
        b=d6z7bLrJZyQOQh+NiK8GaagyvgLPYqTtEESx/7YpdlFji/b0qjxqvs90YD8xrS0qKP
         c2UJJ3Bo8nm/xquEXAWCU3+iQUheYnz5v8pMqNdPhWBNIGs2OcTQSiZZEUPV2LsRHn88
         1Vxwc6IK+RCSoMzvXGNzGykSu+20wmDtfY/PubkccgCDMVSwZv6NqMHflg4sfiEJmX8N
         naSDlx9OHivBMTZBsGJD+isGxzz4c8+vnVHOlcfBYhhOiNjRfSXmHSSMcV5+JKgm/eOa
         tyv7npvBlqik2H4qL0Ct1y+0QratRIUIA1G/GQT/1aWHKDadX04Cz1gJhkkiZLJcjcnp
         p4Zg==
X-Forwarded-Encrypted: i=1; AJvYcCXGX4hPCI4E82m1LfUwNT1SysMUbuu6rGEv/sxWzHcx2BkG3j/fDL720FI51xQn5cvkg3VObHs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk7JEKOm3k+8ZKAe4SDSN1mdTg5I73xn+ZVAM4msxrCbuKQ8/h
	fSrAyWAJrvv68ri7eEcke8ZkZ7LPSbtjVj1ocwiH6wkWYUcPxo+JEMq9uQRR6/0b
X-Gm-Gg: ASbGnctMvO3chagpj5DX1ZuVqsgiMT4rtls2Lj6CZtwKF4sop3BDl/0Nz02uh+IYlVI
	YHfFd+MIWTfs1xM/1PFnJzbb6NoBW2BIkPO3gGdmNEpll1tKA1C7EaohfY7eg0qPNHy0SyIZskw
	LY4YDaWjycS76I0yHuJe3RgstzRR99b+4wlX2vAhaxMoqIM/EogeiFYXd5LaXI7FZETBtSx5k+Q
	WG6X7Bpws2Je1udbKgmwnNMuUg/0qEMzhwYK3+zraRsPEf8q+bsEFxHffpIK76W+X9EYGnJq6CD
	ZtD0wPBtIv14xtCEvj8Zv4PYWa4d0k39kRAd0dRw/CU7DraRrcLhVCFoRJji36rfsdi0QAG9P3h
	a8l4o7sf+v2eOCFJzSf0LQPsPv3lo2XFvKOE=
X-Google-Smtp-Source: AGHT+IG6qIR7Mz9ze8kV0dkEjDHFLIMXTiO/mwGxOMslVTSOdM/NzgwnMM7o6oftyrIuL4bODH6MyQ==
X-Received: by 2002:a05:600c:46c6:b0:45b:84b1:b409 with SMTP id 5b1f17b1804b1-45b855ad0b0mr120431005e9.30.1756825382991;
        Tue, 02 Sep 2025 08:03:02 -0700 (PDT)
Received: from oscar-xps.. ([79.127.164.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7a938e75sm134978505e9.4.2025.09.02.08.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 08:03:02 -0700 (PDT)
From: Oscar Maes <oscmaes92@gmail.com>
To: netdev@vger.kernel.org,
	bacs@librecast.net,
	brett@librecast.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	stable@vger.kernel.org,
	Oscar Maes <oscmaes92@gmail.com>
Subject: [PATCH net v5] selftests: net: add test for destination in broadcast packets
Date: Tue,  2 Sep 2025 17:02:40 +0200
Message-Id: <20250902150240.4272-1-oscmaes92@gmail.com>
X-Mailer: git-send-email 2.39.5
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

Co-developed-by: Brett A C Sheffield <bacs@librecast.net>
Signed-off-by: Brett A C Sheffield <bacs@librecast.net>
Signed-off-by: Oscar Maes <oscmaes92@gmail.com>
---
v4 -> v5:
 - Fixed Signed-off-by chain

v3 -> v4:
 - Added Brett as co-author
 - Wait for tcpdump to bind using slowwait

Links:
 - Discussion: https://lore.kernel.org/netdev/20250822165231.4353-4-bacs@librecast.net/
 - Previous version: https://lore.kernel.org/netdev/20250828114242.6433-1-oscmaes92@gmail.com/

Thanks to Brett Sheffield for co-developing this selftest!

 tools/testing/selftests/net/Makefile          |  1 +
 .../selftests/net/broadcast_ether_dst.sh      | 83 +++++++++++++++++++
 2 files changed, 84 insertions(+)
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
index 000000000000..334a7eca8a80
--- /dev/null
+++ b/tools/testing/selftests/net/broadcast_ether_dst.sh
@@ -0,0 +1,83 @@
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
+	rm -f "${CAPFILE}" "${OUTPUT}"
+	ip -net "${SERVER_NS}" link del link1
+	cleanup_ns "${CLIENT_NS}" "${SERVER_NS}"
+}
+
+test_broadcast_ether_dst() {
+	local rc=0
+	CAPFILE=$(mktemp -u cap.XXXXXXXXXX)
+	OUTPUT=$(mktemp -u out.XXXXXXXXXX)
+
+	echo "Testing ethernet broadcast destination"
+
+	# start tcpdump listening for icmp
+	# tcpdump will exit after receiving a single packet
+	# timeout will kill tcpdump if it is still running after 2s
+	timeout 2s ip netns exec "${CLIENT_NS}" \
+		tcpdump -i link0 -c 1 -w "${CAPFILE}" icmp &> "${OUTPUT}" &
+	pid=$!
+	slowwait 1 grep -qs "listening" "${OUTPUT}"
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


