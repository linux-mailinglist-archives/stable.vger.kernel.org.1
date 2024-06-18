Return-Path: <stable+bounces-52643-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B18A90C687
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 12:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7F09283701
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 10:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34DF18EFEC;
	Tue, 18 Jun 2024 07:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="k5nigMWu"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9560513D501
	for <stable@vger.kernel.org>; Tue, 18 Jun 2024 07:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718697226; cv=none; b=oznPmsu0Pbxcw0I+DjsrYLVOrnud4I5XdllVR8xF2Gz9JLf4um9y3YMx7qh4VxsiG87iWkTE4D1VX/N3ktcoFGbvaQd8nQiRQdtX09C6r9ftQYoAqhgjQW0NTnZrUDgXoYnEv15gCGSo0FMj7PRwVDrP68thyBegS1mnehGKkUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718697226; c=relaxed/simple;
	bh=495W13VAzGSnmElysto0hx912kD0/UmYGQLl1cLiK9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TKDsyTd11wA1pF/T79s3DJ8J6arub3o8t0w0D3MtlW8Rbu2SKwhN+OXqu7N4unpQe36c/Qrnua6MqpVi4qoNDVMe28bm4L69qW02b34NtIRsTgD0jWfhNgPwUr/g6ruXERcAFgKwUJp6cUoZFZk4fuCEW6SgHJvVIGldza4pFC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=k5nigMWu; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from Phocidae.conference (1.general.phlin.uk.vpn [10.172.194.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 52E274087E;
	Tue, 18 Jun 2024 07:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1718697216;
	bh=Yy89x8yKC0BlIUHDwmSZMmszcpGI/5eFaC7CAM9iTsg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=k5nigMWue+D5o/hTB5JmqFEWxSZswSmgiRu2vyoimY+5AYaXCm+43YyA/j10T4daK
	 tcX7eZ0lnys04rsxuf+09G4I9k6EdovpWyAWRPlCJkVuAwbkxRKMMyGMypVY1nIewz
	 5tX3IsUPrNJpx3PwZp+3Jthx4A3nE5p5UV1v6lKu1fdUjnikUIrJObJrwo020RqtLH
	 J5pKEik5uuGNooxcYlbIKPHrSA/SF5ZG3FcnhmSWoy9JlAzy3BlIjph+cbjfGHcgxZ
	 FCtnAOOGTVsIrlz3Q2RDJQaY7n2JuWSuGL9FRrH37tgHDxtkVkf/VE6imDuIhmhUae
	 TPqdza/4cZtOQ==
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
Subject: [PATCHv2 6.6.y 1/3] selftests/net: add lib.sh
Date: Tue, 18 Jun 2024 15:53:04 +0800
Message-Id: <20240618075306.1073405-2-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240618075306.1073405-1-po-hsu.lin@canonical.com>
References: <20240618075306.1073405-1-po-hsu.lin@canonical.com>
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
Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/net/Makefile          |  2 +-
 tools/testing/selftests/net/forwarding/lib.sh | 27 +--------
 tools/testing/selftests/net/lib.sh            | 85 +++++++++++++++++++++++++++
 3 files changed, 87 insertions(+), 27 deletions(-)
 create mode 100644 tools/testing/selftests/net/lib.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index de4506e..7dbdc5e 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -54,7 +54,7 @@ TEST_PROGS += ip_local_port_range.sh
 TEST_PROGS += rps_default_mask.sh
 TEST_PROGS += big_tcp.sh
 TEST_PROGS_EXTENDED := in_netns.sh setup_loopback.sh setup_veth.sh
-TEST_PROGS_EXTENDED += toeplitz_client.sh toeplitz.sh
+TEST_PROGS_EXTENDED += toeplitz_client.sh toeplitz.sh lib.sh
 TEST_GEN_FILES =  socket nettest
 TEST_GEN_FILES += psock_fanout psock_tpacket msg_zerocopy reuseport_addr_any
 TEST_GEN_FILES += tcp_mmap tcp_inq psock_snd txring_overwrite
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


