Return-Path: <stable+bounces-176597-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D85CB39BD9
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 13:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07CCA983A5C
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 11:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1DF30E83A;
	Thu, 28 Aug 2025 11:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOqrhLjb"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDED30E0F8;
	Thu, 28 Aug 2025 11:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756381399; cv=none; b=pueldjqp9d5sxNuEeK3p90yc3ZKPn0HAHdRy9Crv7DH/iF3zwiSGmT10JbSV4F/tL70n2GRrThA/9JfhYp0nUzvv0BIslEklHg6QBrjSFiWAOjow0TWhMdlRNl79ZnYCcRuQvhqGf9Mw5zrFn0JdmY9JMoKwAfEqDMdlIhpBYMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756381399; c=relaxed/simple;
	bh=+myR+0Fv4rXJx0fStMB2hd2Op3X8YGMX4Tz0RWFmnac=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T3hrSLIVrEf8QowRiTw/bf27/f5uKK2ubktQDHlDz1KXUigTY06r1oZbpVtvZpbEA8GG4QHhSVZZA+/jKQcNAtDl0sdwDPbih9NAjPsRUDdzm81De3NaS3CHb2D86M6EvcH+CPYCk5yhNhAwo7qDX2f49OdVRhX8kH6uIRgzNrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nOqrhLjb; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45b7d485204so1647285e9.0;
        Thu, 28 Aug 2025 04:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756381396; x=1756986196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M94AO9Oilqa51aVx28oQbfPVztJ4vD5s2KjXJ+MTxLI=;
        b=nOqrhLjb7WWRhTfl6rC5/4IJHKoMH9mTJVw+Tk9+okwFCi8et21Z3i+YRCmUCY3dij
         F4qrDSJvcySog8P8MCnACnq7blD1mFqBVqNwpbmIkOZ9tsxX9qKyILkJ6RsGTI3T3+A5
         dX+MV3c1Ex+n465QbUO8kaHX8ke47Xu97C40hyUwiK/hRlQ56AVY+XvfFyFrtNU5oj/B
         lXtXzWu0zqtAtOrPDCcMufWF2+YKj7wlR1rgatZ3f0lfwCtns+ErPF5geRfa2icbSd5S
         G4FFVZKqzwlQq71tSt4CkSriQOC1unVqfIS/FrbKyoOGPzjPQ8Q576GmlXGQIUBnFr6D
         2srQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756381396; x=1756986196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M94AO9Oilqa51aVx28oQbfPVztJ4vD5s2KjXJ+MTxLI=;
        b=hW7qJWuyL2E956cTK1vqM8l5o36txDyPPDa5VwVLKMskGqVAYt+PoXZ8C0KwY0Bq85
         iEppz/+3q86UQZo7MgzRRD4//WVbo14B8dOxmdO6/O5UloH4EUyu9stZODsIJRPCzl7v
         gJsr0QT+95+i213/OlN0Xh3vtNXDT0WF3get1Da4qspEWh6fOgKkXXBdIpfw3VRP54rn
         B75YBvBfX6mk5fr6L5RRvR7Lc2BusA3KnWm6wUxv3zdP56udZOcmJpvGUUbPFukhg1nM
         pvELwAwHU9Jhxof927P3LZJyi8XCUIn+zhwx4eWLMRlTAGKLdh/A88T/Ma/Vyz26T8y7
         5ZGw==
X-Forwarded-Encrypted: i=1; AJvYcCVZ5gBx/gfbpnDVq9vWf3GZNDKMeWWEqS4LavW1x+Qbj/BZ9Pl3FetDi7Ms+LnpNS+ondSJ+i4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi3V47a/F+7Uo4kguCNhmU/388bnHjxtGhJZMB4aKAxS62DsTj
	ltY7klILG59YrWRCsKdMXOgIk/IR7BzqPZe40RGJeE0yjm+QHifBFI5KH2Z77g==
X-Gm-Gg: ASbGncsPvkRK/6V2R284f6n9dDv+Nya1Vd10Qm/1r9xVzfj9p4hVvH88isTg5bpmTd7
	vGWFWooZ+H1PV8zS6+7yJaINI9tiCuusMKDedQsJLW23rU4MpnSNY9Ns3PqE5/mZiatVmPGwi3W
	B/tKBMSRdb6xGKfJj7WIWMDcnnYruGIAkR6OdOPiOCNkUrGSbyedkm96O3mkCCCAGa8sfVY94+R
	48Fmcwn3g70NXahVslxh54fbmePtTgkZEzAfeYU0KSNVIjyhTtD1BdO6F1hHSab+UGUqlcJCiSb
	sDsl5xqsGKFOd0EDeMUuFCjnJjm8S3qLXqX3g1WbNBhPEKRf0BH6lWsbuuO0Lg85A0Beefsugy8
	0mY0+F8NPQGb+2LzJzNOpq0Av
X-Google-Smtp-Source: AGHT+IFfahugml7cDVfW1/0rHIL7nQtGyRb2Ht1Bgjp6yIG/qgcNK/o25we3LE+8f+yOSWDpfnV16w==
X-Received: by 2002:a05:6000:2505:b0:3cb:5e64:afb with SMTP id ffacd0b85a97d-3cb5e640e84mr7305949f8f.32.1756381395454;
        Thu, 28 Aug 2025 04:43:15 -0700 (PDT)
Received: from oscar-xps.. ([91.90.123.185])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b797dd1e7sm28682735e9.19.2025.08.28.04.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 04:43:14 -0700 (PDT)
From: Oscar Maes <oscmaes92@gmail.com>
To: netdev@vger.kernel.org,
	bacs@librecast.net,
	brett@librecast.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	stable@vger.kernel.org,
	Oscar Maes <oscmaes92@gmail.com>
Subject: [PATCH net v4] selftests: net: add test for destination in broadcast packets
Date: Thu, 28 Aug 2025 13:42:42 +0200
Message-Id: <20250828114242.6433-1-oscmaes92@gmail.com>
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

Signed-off-by: Oscar Maes <oscmaes92@gmail.com>
Co-authored-by: Brett A C Sheffield <bacs@librecast.net>
---
v3 -> v4:
 - Added Brett as co-author
 - Wait for tcpdump to bind using slowwait

Links:
 - Discussion: https://lore.kernel.org/netdev/20250822165231.4353-4-bacs@librecast.net/
 - Previous version: https://lore.kernel.org/netdev/20250827062322.4807-2-oscmaes92@gmail.com/

Thanks to Brett Sheffield for writing the initial version of this
selftest!

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


