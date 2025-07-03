Return-Path: <stable+bounces-160085-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51348AF7C72
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 17:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 554746E2AA6
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 15:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52CA221FC7;
	Thu,  3 Jul 2025 15:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGiSvIGq"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF462E41E;
	Thu,  3 Jul 2025 15:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751556625; cv=none; b=gXsO+X5c79OoUJacy4aa8UFOFjLcKw3YGPK23kPay/y4TbAzsqyaRxV/KE8E70/PpE1CyACLMcNNuTdRtxMRT1tiSYsSDXItSstF7qUWaOrmU5sn9965TYcYo/7G77/IsG5qp8GE8gw80EXzxlUWzIQeurAKTpvguvfjJrLoPrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751556625; c=relaxed/simple;
	bh=suwZtmA/bkO4pu6z6zqIT7/QlTmUTdBres8SXOQ//Do=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qmV6vAW0sGWF+b+rPmodIxsyp8nOOHuJlxu35xrPiCiK4zOMVSTMgy8Xxx1PpJ1vT3WvbtEKC7j18VBLH4/rMUxK7kuiAQlbWFiZh43LSyNV2VSN42RaGowgcb3nV6i+xkIqmnPi7w8C5FAhwdREmqGGRCERmoZ2QPIB9tck/d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aGiSvIGq; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6088d856c6eso15101813a12.0;
        Thu, 03 Jul 2025 08:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751556621; x=1752161421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/DGs2fZZIChUDK1MfzACEqWRIQR03D4HhGtXUb2EUok=;
        b=aGiSvIGqiCm1vLs4rDUPjpNAwIzJi+LNLwCvxqGNgUU9ZS12eRpUxwyqUBMXfKvPXa
         pV9hJSMWFZRddb8lr8dUu7l2XLlnoCLB5mbzeDWHEuJexXbwpWhUGSyxzbQr5N9HkjEL
         ptCC+zDPgxaKiV0wAps1y4JOD5S2jMLZapnIADc48Bpeu5FfREG2+5/gxY9KrLyTra0g
         BjHVQ/kvKq3Zwfkj5+y/VSjc6oKz0vspLqURjly2dwKtk9xSVHdZpLvR8rITJPKLnp3F
         2FuLFsOtvzFVle1fRC6LJz+bqoKKzIHAtiClWp1mFeNgNUcbo5gO4WBVHZaIjD1WdpX0
         WeUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751556621; x=1752161421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/DGs2fZZIChUDK1MfzACEqWRIQR03D4HhGtXUb2EUok=;
        b=POdaNyrONIU5Ndp4beLJvTIHnKzskV+9joEY6F9TXa9R7dM2aQwUJ+g5TtgiWEPIBM
         oEaboMmo37hb9hAueBs/QlrnznhGPjp9AlKqQJ1fyq7QOsMFhMgZVnW5NP2WZe1ARhhn
         YWMRFpmG2JLUJTNnjkyK3bqFSS9nfuSMDTksRc2eljmgv+txNo6F9tphBTwyrz7XuAI5
         hqMGQUoivhC/T4tpx7RuTtnouYAVgSpU26zm9h8Sb/W7ZPMQ27R0reyBA7SIbj4yfSxD
         sN/mkgVkbJaASBrZ27WNnQI3oydbkHjF5OePwZJjwkhaG6p9Rgk+mxtNvPpFkqFJbp0X
         BIUw==
X-Forwarded-Encrypted: i=1; AJvYcCUIAXhe/+MtxwJVKep2XC5H4+9AFEQR2rC4ssna+QNcfWg0fwXrqD3+EIsnTlhnpA0o5QMT5dMU@vger.kernel.org, AJvYcCWZtLcc2Kpb3b1KBxmyYIIbys4rX1uhsSQ2UPLdpQQy4m0kZpLKEFAQGoTCgNlgRS+Ci7kTwD0f9AOgF/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YweUQrNzfltcSUnlNKKuAfIlRS9WPIIP9yxe03mL0KCHea3ZiK4
	BU/Ie8MbMs26K+ljSwAEhqvalaWlrxmy6svjOBsP5A3J+FWvnw/EnhHhTWGHkaLN
X-Gm-Gg: ASbGncsULYCr2UhQ4mJtYJjFQnbVT8CS/4yPdZ/B6UjoBOjLVivwkiCjn7VOy9+5xC/
	sbAzd8Vzk4+TPyA43V8M2UZOnzhfFYxPFTI8E5NkPWkBdnbn1E4PX6nRogfbKKgz99uMTB7kjBf
	FYYqsaI+2wmQXIALDU6YfHlJzf7mRL03fa3nAHLbPgs4qlP/tYA5yKgaRe7TC7/5hf5m1+HnTx8
	Acrp4hbOMdke3Pun2cmJchnNpkQZ+PCRdM1KGZPKeFrHaKIMTh4zq9b/4m9JcspxhIxxCc+ytwj
	DhD5axqEbSz2s+NyM0IUn8PQyVKkfb7GG1PuO2OD7E47odwEokJlZWXPMgCP4VD20ojO1M+zdGc
	=
X-Google-Smtp-Source: AGHT+IED0O8R+/wRKm2NKib20kCoJhGhXU1WtskJ9jN+V5+RleE3IEO24/3Xb4AIOoCNu78agUbhLw==
X-Received: by 2002:a17:907:9490:b0:ae3:7b53:31b9 with SMTP id a640c23a62f3a-ae3d8c9dcd6mr313325866b.35.1751556620827;
        Thu, 03 Jul 2025 08:30:20 -0700 (PDT)
Received: from localhost.localdomain ([45.128.133.218])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c013cdsm1289978766b.93.2025.07.03.08.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 08:30:20 -0700 (PDT)
From: Oscar Maes <oscmaes92@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Oscar Maes <oscmaes92@gmail.com>
Subject: [PATCH net v2 2/2] selftests: net: add test for variable PMTU in broadcast routes
Date: Thu,  3 Jul 2025 17:28:38 +0200
Message-Id: <20250703152838.2993-2-oscmaes92@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250703152838.2993-1-oscmaes92@gmail.com>
References: <20250703152838.2993-1-oscmaes92@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added a test for variable PMTU in broadcast routes.

This test uses iputils' ping and attempts to send a ping between
two peers, which should result in a regular echo reply.

This test will fail when the receiving peer does not receive the echo
request due to a lack of packet fragmentation.

Signed-off-by: Oscar Maes <oscmaes92@gmail.com>
---
 tools/testing/selftests/net/Makefile          |  1 +
 tools/testing/selftests/net/broadcast_pmtu.sh | 47 +++++++++++++++++++
 2 files changed, 48 insertions(+)
 create mode 100755 tools/testing/selftests/net/broadcast_pmtu.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 332f38761..f4aa94588 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -112,6 +112,7 @@ TEST_PROGS += skf_net_off.sh
 TEST_GEN_FILES += skf_net_off
 TEST_GEN_FILES += tfo
 TEST_PROGS += tfo_passive.sh
+TEST_PROGS += broadcast_pmtu.sh
 
 # YNL files, must be before "include ..lib.mk"
 YNL_GEN_FILES := busy_poller netlink-dumps
diff --git a/tools/testing/selftests/net/broadcast_pmtu.sh b/tools/testing/selftests/net/broadcast_pmtu.sh
new file mode 100755
index 000000000..726eb5d25
--- /dev/null
+++ b/tools/testing/selftests/net/broadcast_pmtu.sh
@@ -0,0 +1,47 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Ensures broadcast route MTU is respected
+
+CLIENT_NS=$(mktemp -u client-XXXXXXXX)
+CLIENT_IP4="192.168.0.1/24"
+CLIENT_BROADCAST_ADDRESS="192.168.0.255"
+
+SERVER_NS=$(mktemp -u server-XXXXXXXX)
+SERVER_IP4="192.168.0.2/24"
+
+setup() {
+	ip netns add "${CLIENT_NS}"
+	ip netns add "${SERVER_NS}"
+
+	ip -net "${SERVER_NS}" link add link1 type veth peer name link0 netns "${CLIENT_NS}"
+
+	ip -net "${CLIENT_NS}" link set link0 up
+	ip -net "${CLIENT_NS}" link set link0 mtu 9000
+	ip -net "${CLIENT_NS}" addr add "${CLIENT_IP4}" dev link0
+
+	ip -net "${SERVER_NS}" link set link1 up
+	ip -net "${SERVER_NS}" link set link1 mtu 1500
+	ip -net "${SERVER_NS}" addr add "${SERVER_IP4}" dev link1
+
+	read -r -a CLIENT_BROADCAST_ENTRY <<< "$(ip -net "${CLIENT_NS}" route show table local type broadcast)"
+	ip -net "${CLIENT_NS}" route del "${CLIENT_BROADCAST_ENTRY[@]}"
+	ip -net "${CLIENT_NS}" route add "${CLIENT_BROADCAST_ENTRY[@]}" mtu 1500
+
+	ip net exec "${SERVER_NS}" sysctl -wq net.ipv4.icmp_echo_ignore_broadcasts=0
+}
+
+cleanup() {
+	ip -net "${SERVER_NS}" link del link1
+	ip netns del "${CLIENT_NS}"
+	ip netns del "${SERVER_NS}"
+}
+
+trap cleanup EXIT
+
+setup &&
+	echo "Testing for broadcast route MTU" &&
+	ip net exec "${CLIENT_NS}" ping -f -M want -q -c 1 -s 8000 -w 1 -b "${CLIENT_BROADCAST_ADDRESS}" > /dev/null 2>&1
+
+exit $?
+
-- 
2.39.5


