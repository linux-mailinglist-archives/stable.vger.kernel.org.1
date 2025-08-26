Return-Path: <stable+bounces-173735-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13387B35EFE
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD30316474A
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 12:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FC21CD208;
	Tue, 26 Aug 2025 12:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RH0ZOT/i"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E02631987F;
	Tue, 26 Aug 2025 12:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756210710; cv=none; b=bPw6qt5LU7L0FAZWG1royPhelXrNxM2pHEBAf5rKybFgD2isylLETHkqk1R2B24MgFxmU3GTeLyAcT49/yb4doApPtDkafBHhWkVbRZic3l0kv/dG22ykQJLYyyw6C9jlIt9xrpq14wlTb6R1CB6TZIq6apFYWj7fU6Hu9e8ZqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756210710; c=relaxed/simple;
	bh=xl7TGiKrLZLjjRkY4r2IBQ4zmCgxfGdphk5O0Hawwnk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m4njptMu5alT+MjXxnZGmNE9kasKJLgOZ9FiSIf9OLEhKKBEOfye8XY4cNeD8GRxnJaSLsPCDf3e6qQpjOLbEEbU/j0to0Ld7MyVv2jP5Kd2NFzwW7BhncUgTtQ8hqpp0guzGIjyQwqYjDnbgQcl4OmbndR6P1KMOg95O5mbB9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RH0ZOT/i; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45b627ea685so12851055e9.1;
        Tue, 26 Aug 2025 05:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756210707; x=1756815507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uUquV0WS+fxJUivCT1xUeaF0YeOMY0unvquPcAzHaLs=;
        b=RH0ZOT/iBWcnwIjnL9sPGRq0kllVPxVwHR+iGnOJZ3KFES5GBQg6ye+1htZ4E5MOJ4
         UPmA7RllvtrlAzLUhmNH3e4ZdosoA2/Ny0sDb2xgHFPql8KQs3Xqa1ppJmaBnEBuAEaB
         oG1eVx5xHBkfw2PN/zdxEseTmOuDkc32uOaHzPaqMaWRp/YNvo7BxvFTibIlPdhdjWH/
         YmEyN6Ui7aDQ4KyDA9WIJKsMcndk8yMU1Hl3PZWy5ljQAnTNGWZf81hY6wj97pEQxCnz
         /4M9fQd5NsqygN0ua7+gZl4iqlbmrNj7hGjXYLS9aqp0EWBeFB8LSmTHhq7+1BoiL1Zp
         ugsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756210707; x=1756815507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uUquV0WS+fxJUivCT1xUeaF0YeOMY0unvquPcAzHaLs=;
        b=bCVYVIimYAnkU6ve1Vr0fNAzaP6fOl2CddynDnGyqfF4epMwVr9DgenMNSm4mid+uL
         8l5yz1KH8TJVta2vOCNxRqY/4a7qHO3CBN1mAsTyZjCO2nD/KcqVL0njoySo/gTpAR0S
         sVmD/oSnzvE5uSwgHM7RfR9RuV/QHhNk+G2rJYDvu3/S97U2vVGF6H7hJ1HHj/bi2K6V
         7Brxye5CB6pvZdAkf3C0kguMHKUeHl/tqYw67flDsKPmeOA2u7lVEYlsV0jM/w02NLJU
         HbgkboIilS81BWofQVi5vaA02UNSqhAIIOfxMzi96MVAhTQwp/KiAFx5WEOgi7w9Ub3C
         iRyw==
X-Forwarded-Encrypted: i=1; AJvYcCV4+qyXA0vyfUSf51JeS4Ig8Bq+fWjiyYxlTW3vXa+lNShdJLAo+O51mHOqRbuKa1YP/PCRyiU=@vger.kernel.org, AJvYcCVqcohrvfXaf9XwpwC/aRY49bv5HZGkfGM31Ou36mgkIfn81z2LRSZK0jiykqAbOs8cgEibFhN8@vger.kernel.org
X-Gm-Message-State: AOJu0YybvMOAzGmGFB1/56zDesrZ9IaRRXdAAAkOUqUq6A5gDxlHTKlr
	Mao7z1riykIliZ5wH2ZwBIeof0Ye6gZLzDI8fOdfoMPZNSRKpzZWIgA3
X-Gm-Gg: ASbGnctIpF7//I5TtCV+Ruz+toPH4sVYaUXkdZPfxNv7vmJb3kKdE6esHABsOBRn7UD
	1R2gBXmz+NH/5kZudDLxAfTQMNyJR8wAXDyPeCjbVglGwLYUVkhTYT66HE9BTdSwgrmqHQ30A15
	CPj8FgYUqiZ8sXlWjECLbh5tIwotINyRBJLo4Jri3hA/nEAqh+Q5WiO3Fz4EPMn0sv0J5Kq1UQs
	CK0yfCHhC+38Z6ueHdnkxSbqporZ6SC3S/JhbVJahtUBjNy87lNB+iJic+wSJdWCqnl/3VBy8/l
	6I6QOMMaCZQtDKcZW7uWguDxPiJ3jsQUqU36JACz+XGgYX6piUAf4FNzf3NHDlc93s/uUowH3JE
	+rJBGeeA34miJI+R47oceKNP49UTQXyfr
X-Google-Smtp-Source: AGHT+IFA+w9zyLiHWHSxzU53Rb5LUj410W6JWkcnK35EtrBXTWpbfg8retqet4NA+n39H/gbCoK57Q==
X-Received: by 2002:a05:600c:3b85:b0:459:d780:3604 with SMTP id 5b1f17b1804b1-45b689f27ddmr12881755e9.3.1756210706739;
        Tue, 26 Aug 2025 05:18:26 -0700 (PDT)
Received: from oscar-xps.. ([45.128.133.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b5758a0bfsm149513675e9.20.2025.08.26.05.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 05:18:26 -0700 (PDT)
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
Subject: [PATCH net v2 2/2] selftests: net: add test for destination in broadcast packets
Date: Tue, 26 Aug 2025 14:17:50 +0200
Message-Id: <20250826121750.8451-2-oscmaes92@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250826121126-oscmaes92@gmail.com>
References: <20250826121126-oscmaes92@gmail.com>
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

Thanks to Brett Sheffield for the initial selftest!
---
 tools/testing/selftests/net/Makefile          |  1 +
 .../selftests/net/broadcast_ether_dst.sh      | 82 +++++++++++++++++++
 2 files changed, 83 insertions(+)
 create mode 100755 tools/testing/selftests/net/broadcast_ether_dst.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index eef0b8f8a7b0..9bbe1d010f5a 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -116,6 +116,7 @@ TEST_GEN_FILES += skf_net_off
 TEST_GEN_FILES += tfo
 TEST_PROGS += tfo_passive.sh
 TEST_PROGS += broadcast_pmtu.sh
+TEST_PROGS += broadcast_ether_dst.sh
 TEST_PROGS += ipv6_force_forwarding.sh
 TEST_PROGS += route_hint.sh
 
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


