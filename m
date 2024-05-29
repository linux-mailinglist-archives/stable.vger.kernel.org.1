Return-Path: <stable+bounces-47648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1A58D3A8C
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 17:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 615D51F269BD
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 15:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDEC1802BB;
	Wed, 29 May 2024 15:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="es2s0tL/"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2746A7D3FB
	for <stable@vger.kernel.org>; Wed, 29 May 2024 15:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716995873; cv=none; b=kQ8pbGyD2gmrAWAt6GSLX/uEYHxZovZ7mMFm/EEVbbhz4o+501P+Qn7IwWhztlrdRnw+docb8unoXBkZBslyOU25nn5vuZ8lIZ6vHSxC6QJK8fIDgaevEtqpyRPyNrSj9xlTGHwHRpjblzavp3x1WAGbRzN8e3EnVlz8QIbQFE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716995873; c=relaxed/simple;
	bh=7rFdAu+pXGpI15zuOiqQyg8Btc3hy3z8VKiimsK5364=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U3a4a9aDNvMVg6S9sGd8MASV8mGj2u1Qm9HLanvSSG6jSHsqoMdlC25tYjkXOMm6pM6fyK7KTnP1F6F8xcCpIEfYyosHfdtL6tGagr2G4kyL8uNRtqRGac4XiE+PIKfCQzpaWGTuLvaVGV1oEvXlflK+L23pwaccR0lnhoGkEOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=es2s0tL/; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from localhost.localdomain (2.general.phlin.uk.vpn [10.172.194.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 937E33F772;
	Wed, 29 May 2024 15:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1716995868;
	bh=tan6nxgr+bvAEQjKfuV1d7tqS+/2bEeBHqy0CD4OUow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=es2s0tL/SJ3WTY+vWncUxoAcQsieOcjvRiXFDWA9wW67dB5tZZlNfy2Ghdn8wRQIM
	 kXaZGbFTpKB2noNIpAyV6Qznapkp1nN35ttY99/fM2E3xeJAek/syDxuvzG8XZviud
	 SJOADZS3FLHN25YvMgQjybezLES5a68+dYoL2hTGdFu7uhWMyMsv+BVmxVW1FzrqpF
	 zYvmaMJP8Hc75IeRsgiDrMpHI6wr9FZo93x12q0CWlRK2yTb2ZcbESodn05KJ1UmMq
	 T2yHM9iQb+eOdt6qb2KeowrVl+zvgbLxTpgTe3RbOrCdHUJhFyfuYLTqQw+Qzs0dw/
	 fT4HD/bOTJAPA==
From: Po-Hsu Lin <po-hsu.lin@canonical.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	po-hsu.lin@canonical.com
Subject: [PATCH 6.6.y 4/4] selftests: net: List helper scripts in TEST_FILES Makefile variable
Date: Wed, 29 May 2024 23:16:03 +0800
Message-Id: <20240529151603.204106-5-po-hsu.lin@canonical.com>
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

From: Benjamin Poirier <bpoirier@nvidia.com>

commit 06efafd8608dac0c3a480539acc66ee41d2fb430 upstream.

Some scripts are not tests themselves; they contain utility functions used
by other tests. According to Documentation/dev-tools/kselftest.rst, such
files should be listed in TEST_FILES. Move those utility scripts to
TEST_FILES.

Fixes: 1751eb42ddb5 ("selftests: net: use TEST_PROGS_EXTENDED")
Fixes: 25ae948b4478 ("selftests/net: add lib.sh")
Fixes: b99ac1841147 ("kselftests/net: add missed setup_loopback.sh/setup_veth.sh to Makefile")
Fixes: f5173fe3e13b ("selftests: net: included needed helper in the install targets")
Suggested-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
Link: https://lore.kernel.org/r/20240131140848.360618-5-bpoirier@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[PHLin: ignore the non-existing lib.sh]
Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/net/Makefile | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 6fbebf8..3412b29 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -53,9 +53,7 @@ TEST_PROGS += bind_bhash.sh
 TEST_PROGS += ip_local_port_range.sh
 TEST_PROGS += rps_default_mask.sh
 TEST_PROGS += big_tcp.sh
-TEST_PROGS_EXTENDED := in_netns.sh setup_loopback.sh setup_veth.sh
-TEST_PROGS_EXTENDED += toeplitz_client.sh toeplitz.sh
-TEST_PROGS_EXTENDED += net_helper.sh
+TEST_PROGS_EXTENDED := toeplitz_client.sh toeplitz.sh
 TEST_GEN_FILES =  socket nettest
 TEST_GEN_FILES += psock_fanout psock_tpacket msg_zerocopy reuseport_addr_any
 TEST_GEN_FILES += tcp_mmap tcp_inq psock_snd txring_overwrite
@@ -94,6 +92,7 @@ TEST_PROGS += test_vxlan_nolocalbypass.sh
 TEST_PROGS += test_bridge_backup_port.sh
 
 TEST_FILES := settings
+TEST_FILES += in_netns.sh net_helper.sh setup_loopback.sh setup_veth.sh
 
 include ../lib.mk
 
-- 
2.7.4


