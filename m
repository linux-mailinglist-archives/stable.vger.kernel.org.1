Return-Path: <stable+bounces-161588-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6423B0053A
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 16:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43E186462B1
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 14:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DC9273D7E;
	Thu, 10 Jul 2025 14:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0RYYk9i"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8676155393;
	Thu, 10 Jul 2025 14:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752157682; cv=none; b=Lv3aZBWycrXA1Cne7w/pT30f7N8EwGJUFVyQvaxDIj9nD574VWOSj7cUY8YlcNyVEwef+9p5Bh6Njy60FXuqRenegDpCHJhmYYEVxWNmkCOd1Krahgl7hEimgS/GdqMHAPFArYcdrVSOnZV2OutjYE0Rq96aFCY6kacocT6wVU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752157682; c=relaxed/simple;
	bh=j2nbPASgvYLLYNCi4Etlcf80Fw6mKYASEA43fPe1Uiw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KXaRA0QuDJXpV/4oyKa8zeRQRysT0fCKXNF1GYnYIs4/iQDB9VHa+pF1Uh0GpKmjylQSZMQiMoblas/YoHZV1xRqIl7HnE7IadzlkW2PqnJ5YE4zRdtufVaE33J+FdR8glSERZh8Fy/+bOxolxpe2CD/LH9ckbnESgxcOE87jo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0RYYk9i; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a575a988f9so754760f8f.0;
        Thu, 10 Jul 2025 07:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752157679; x=1752762479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6PZo8JJ1Wfz2lrXJvo02pOBuZpAeF+qVv1oHWeeIC4s=;
        b=X0RYYk9iHKKsoGlOb+7ddT0MlKNc7HhChcAmc7zegLENO39RgYaDIkg/5GOuc8JfPO
         MT3fLMTiavc2lDGMuzt0jcB+sXVaFK7RJOA4ujimWhxyl43Ddva76L7hW+mVuyG68tEI
         xpJyyjH/fYN5qUAzCsAP8fwHVEh69GZIFOnMG28EsxBhFUnCUuAjMYh5dzZ9rMuqq0Hq
         rcv562oyB1Fa/QfDyzAbLt+LSA5qWxRWik4LpjimCUl7FSMnqFWRHSWf7whCqPcF1tDI
         aCPEq1yVheVTMU3Mliw+XEEGIQYtLETuy195xdez83Pn4hmXR9waV0L3oC8wGFwRY+C0
         R9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752157679; x=1752762479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6PZo8JJ1Wfz2lrXJvo02pOBuZpAeF+qVv1oHWeeIC4s=;
        b=tbNZQqDTlY6x9zFxNNianI/ACUXmDDAg0ILlqYbcIQZ5hbCw7rY1ZTI0WUWJqIM/ke
         KsuQMmtq7rtsKqOKUjt/j1pDh2iKu+V20fpwouNeJM0HobmFRU2mV5JJRIaPmQLLddGy
         if+KHvl8yD+cH6ORdBdJOtIbtSiIdGuv+fEV0CeGTCdSXTBIsUUa5OdD+I3heVE4QH5W
         0bh4dcIwY2EMf5xwkDM8idqw5sTiU6xB+V5CoFike0AnRU4RvF8+S931DsyS2GtPFAGX
         84iRG/Jr5Hzi0RbRgfJY6OJglbvPl+O12PbMLM2YBOw+7GshGPtUGji8layNSsF1+Whx
         vS7Q==
X-Forwarded-Encrypted: i=1; AJvYcCV2PoGZWtSMZbEbuQTRf/gtm2yLKa/o61dW1g60XjJs92BrlZWeR6wHaLuAU1UUjDjnJbw/XsEZ@vger.kernel.org, AJvYcCXHHp+N1XYtvB6uJhp5zSK01SrdYw+ArpcdbBZd9fodlwZUO32QRpaiZQsIqO6OcJk40gx1aGiCrkhJpdw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyaf1+JdwpaKxsLAQaypG1VdnJCGxv1ztZ5dq4iF4WKQt+mDqXq
	/b5TnlqsvUgBapmIummdT78F+FDuta0kyVZjXPqghde7ReRIovoG42k5Cc7wpBRj
X-Gm-Gg: ASbGncsstaflBPupXQfNRBUo2QPOWWCICD2wv6HFsa79297bcILpDwwqfn6YLzMsWDT
	3DVqGaZn4OmFzPABkI0ClQxPSxkvIQ0/tzp95nfBb2NZzl3tKzVOZ0Ca6ynzazLh+2jxIeMUeh+
	tLzzjtqzDrn8qaA8xeGUn7WjSu3GPmxVbnjPjh7NbvK/H3/QfMduGs+WtWm0pFx7ndl91tDPKm5
	6o29GzWYLtDHk9b+djGlEs2iQGoegng3Zx63CYCmW3vlz6EyiogHVtY4Qj5IwlmBC3GQ20fPwdW
	BrhNT25+oJcPS/RDEGG2z+5fO1ZoK/sybPrPKnjtV/YQQMzzMQGRwMo6ivtDJFzmECbN+dUkwz0
	=
X-Google-Smtp-Source: AGHT+IERXmuDI3GoiPegJhpVc4M5/ShLvIXoN+HM9hwExW1oNRKiHyLGAJMD0WfwvtQKPkXVFPvNLA==
X-Received: by 2002:a05:6000:4184:b0:3a4:d274:1d9b with SMTP id ffacd0b85a97d-3b5e7898ca5mr3092611f8f.25.1752157678945;
        Thu, 10 Jul 2025 07:27:58 -0700 (PDT)
Received: from localhost.localdomain ([45.128.133.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd55b0e4sm21237845e9.39.2025.07.10.07.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 07:27:58 -0700 (PDT)
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
Subject: [PATCH net-next v2 2/2] selftests: net: add test for variable PMTU in broadcast routes
Date: Thu, 10 Jul 2025 16:27:14 +0200
Message-Id: <20250710142714.12986-2-oscmaes92@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250710142714.12986-1-oscmaes92@gmail.com>
References: <20250710142714.12986-1-oscmaes92@gmail.com>
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
index 543776596..fc308c68a 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -114,6 +114,7 @@ TEST_PROGS += skf_net_off.sh
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


