Return-Path: <stable+bounces-53805-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D849990E72D
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 11:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC7D81C211C8
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 09:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECFC81219;
	Wed, 19 Jun 2024 09:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="U8TYIqzv"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D51180BF2
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 09:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718790008; cv=none; b=VychshGmNDfZ0WDiJcqE01bgSqvGwCo38cRa3/ybKxbKorEZBBor+dLooexUDOTpX8OCxQbtDU9UH8jXXYJ3aoEcg0xcaMXxm8HEblfh+NwZCPPVggudvsuywNRNZ6ZmuUbiUn7VQfAWLFxp3aYLSdRNEDR0ClDTGwP7dX2pJzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718790008; c=relaxed/simple;
	bh=y45xI2BrcvoTkjLGpNg5N0PA2/AAKpr5IgtlDGI8eYI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VmAbWWGcwuiFY6Uns/twJx2qfCfv1fNv1+6Y0fWiQlmEtFhJut0y1MJHyjgGRAheqB0DakJBzhxdANnp9xdhuYZVQHe4sGKCt3N+EgNy1Q4EP0p7Gwf0O+Ms23gcU5TOBrD4thq8JkVqWttb6OesyiiR6dStv0w9O2U50BpLSW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=U8TYIqzv; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from Phocidae.conference (1.general.phlin.uk.vpn [10.172.194.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id C6CC740889;
	Wed, 19 Jun 2024 09:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1718789999;
	bh=WHfYeASCr6YSeazmV+kC5fut3pq8TjRZp/c96gS61Ns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=U8TYIqzvVMuHspI4aBN+BlkNsWKqhqkKzv6Bl/G/ho6dNd2APFsmMCKZo0eN409Yb
	 LYNKpZ5PLEzkhvjprfmNhIalfQi2zpYZstarHrNBI1fRWZ6jJkQSnh500H9VF9lk9x
	 G29Et3r3WVJyY+L949zN3efOCicKk6AYl0UzolLPs3nUlH1+rlvEZXwve4YoKySLif
	 xbJJAMxeO/W24+yywjK7aZ0QaqYZrmjAeJElEtk/wVTS9WPV6CYCwQJ8UPqjy1+upH
	 vwGKjLEwSEDjwmXaOzjgh2xqQutGOr3Y0aR7fd9M5DXNDk8aKmg+4RVvvwI3LzroDE
	 nubuFIXgL/6JA==
From: Po-Hsu Lin <po-hsu.lin@canonical.com>
To: stable@vger.kernel.org
Cc: po-hsu.lin@canonical.com,
	gregkh@linuxfoundation.org,
	petrm@nvidia.com,
	liuhangbin@gmail.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	bpoirier@nvidia.com,
	idosch@nvidia.com
Subject: [PATCHv3 6.6.y 1/3] selftests/net: add lib.sh
Date: Wed, 19 Jun 2024 17:39:22 +0800
Message-Id: <20240619093924.1291623-2-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240619093924.1291623-1-po-hsu.lin@canonical.com>
References: <20240619093924.1291623-1-po-hsu.lin@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hangbin Liu <liuhangbin@gmail.com>

commit 25ae948b447881bf689d459cd5bd4629d9c04b20 upstream.

Add a lib.sh for net selftests. This file can be used to define commonly
used variables and functions. Some commonly used functions can be moved
from forwarding/lib.sh to this lib file. e.g. busywait().

Add function setup_ns() for user to create unique namespaces with given
prefix name.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[PHLin: add lib.sh to TEST_FILES directly as we already have upstream
        commit 06efafd8 landed in 6.6.y]
Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/net/Makefile          |  2 +-
 tools/testing/selftests/net/forwarding/lib.sh | 27 +--------
 tools/testing/selftests/net/lib.sh            | 85 +++++++++++++++++++++++++++
 3 files changed, 87 insertions(+), 27 deletions(-)
 create mode 100644 tools/testing/selftests/net/lib.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 3412b29..d417de1 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -92,7 +92,7 @@ TEST_PROGS += test_vxlan_nolocalbypass.sh
 TEST_PROGS += test_bridge_backup_port.sh
 
 TEST_FILES := settings
-TEST_FILES += in_netns.sh net_helper.sh setup_loopback.sh setup_veth.sh
+TEST_FILES += in_netns.sh lib.sh net_helper.sh setup_loopback.sh setup_veth.sh
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index e37a15e..8f6ca45 100755
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -4,9 +4,6 @@
 ##############################################################################
 # Defines
 
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
-
 # Can be overridden by the configuration file.
 PING=${PING:=ping}
 PING6=${PING6:=ping6}
@@ -41,6 +38,7 @@ if [[ -f $relative_path/forwarding.config ]]; then
 	source "$relative_path/forwarding.config"
 fi
 
+source ../lib.sh
 ##############################################################################
 # Sanity checks
 
@@ -395,29 +393,6 @@ log_info()
 	echo "INFO: $msg"
 }
 
-busywait()
-{
-	local timeout=$1; shift
-
-	local start_time="$(date -u +%s%3N)"
-	while true
-	do
-		local out
-		out=$("$@")
-		local ret=$?
-		if ((!ret)); then
-			echo -n "$out"
-			return 0
-		fi
-
-		local current_time="$(date -u +%s%3N)"
-		if ((current_time - start_time > timeout)); then
-			echo -n "$out"
-			return 1
-		fi
-	done
-}
-
 not()
 {
 	"$@"
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
new file mode 100644
index 00000000..518eca5
--- /dev/null
+++ b/tools/testing/selftests/net/lib.sh
@@ -0,0 +1,85 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+##############################################################################
+# Defines
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+##############################################################################
+# Helpers
+busywait()
+{
+	local timeout=$1; shift
+
+	local start_time="$(date -u +%s%3N)"
+	while true
+	do
+		local out
+		out=$("$@")
+		local ret=$?
+		if ((!ret)); then
+			echo -n "$out"
+			return 0
+		fi
+
+		local current_time="$(date -u +%s%3N)"
+		if ((current_time - start_time > timeout)); then
+			echo -n "$out"
+			return 1
+		fi
+	done
+}
+
+cleanup_ns()
+{
+	local ns=""
+	local errexit=0
+	local ret=0
+
+	# disable errexit temporary
+	if [[ $- =~ "e" ]]; then
+		errexit=1
+		set +e
+	fi
+
+	for ns in "$@"; do
+		ip netns delete "${ns}" &> /dev/null
+		if ! busywait 2 ip netns list \| grep -vq "^$ns$" &> /dev/null; then
+			echo "Warn: Failed to remove namespace $ns"
+			ret=1
+		fi
+	done
+
+	[ $errexit -eq 1 ] && set -e
+	return $ret
+}
+
+# setup netns with given names as prefix. e.g
+# setup_ns local remote
+setup_ns()
+{
+	local ns=""
+	local ns_name=""
+	local ns_list=""
+	for ns_name in "$@"; do
+		# Some test may setup/remove same netns multi times
+		if unset ${ns_name} 2> /dev/null; then
+			ns="${ns_name,,}-$(mktemp -u XXXXXX)"
+			eval readonly ${ns_name}="$ns"
+		else
+			eval ns='$'${ns_name}
+			cleanup_ns "$ns"
+
+		fi
+
+		if ! ip netns add "$ns"; then
+			echo "Failed to create namespace $ns_name"
+			cleanup_ns "$ns_list"
+			return $ksft_skip
+		fi
+		ip -n "$ns" link set lo up
+		ns_list="$ns_list $ns"
+	done
+}
-- 
2.7.4


