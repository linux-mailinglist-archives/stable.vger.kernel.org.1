Return-Path: <stable+bounces-53806-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B6490E731
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 11:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 844CBB2205C
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 09:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB52823DD;
	Wed, 19 Jun 2024 09:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="HsYjW5QP"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA85481745
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 09:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718790013; cv=none; b=BcTiGJ5vcuy5qaS/hCmuJdmv833O+ECdLBijQSzPps/BF2HEX4JhWVU+1SVjDKx8PNIzZ4B2eNZzgtuZqovyY0w0IB/34WzOHmaH5axVeO9YXU3WwAVrJ8gq0EYEqqQpvkTY0Vhe6oeY7L3R5d3otOfAG7j0xL2MOXIiQonJ3Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718790013; c=relaxed/simple;
	bh=iyjeGmXh7Y92zHpYjtCUQgZC10JfR3oYwdE3ugkVbO4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qf/ZaP9y36W+m16HmezwMWFD2fCq8OPdJW1ijj4xuZTnMnBTPcHMs5vC5cp/bWvXvIh8r8yx9QAPLHqqYiOj+fgCuxzLCBv4qaJNXCAErkrzZQRPA2XvEzvpVHkSUdsVrZnnxD/gqq4ZiTEFnWxWe+X3N7vMdgZSQ/VcHZOVUU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=HsYjW5QP; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from Phocidae.conference (1.general.phlin.uk.vpn [10.172.194.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id E3F193F120;
	Wed, 19 Jun 2024 09:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1718790008;
	bh=+QCssrpZ9bz1IaOmzN409QtZBtZYlIk22JbBS6fOj9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=HsYjW5QPpn29jqqUM2ZDu4fwpOCj5F6Ay4Secg3+a5rK5dGdrcBROAr3gtvuJ8EgS
	 VhavzLtmIjLdpT0SPXg4xxJoDD7DwPTrOufBO8Nbrn8E5hDyP7I+chF92W+75Gn+vC
	 QZD7Yxt4kbv5OTI4JeAl9Ir2AZzAh6P6tbs5ej5ayWx9mviRVe3uPyxgpmOiBP91xK
	 r04TlleXubfkxsCgUlr4udpHX3L7sgrmdlZqKC8YPMo1+TxQXGpsFkljksFeITcWTW
	 U9ljWlFOiIpPvVPZMpyNPTFJ7DivecUiDrnFVWnXrSUsItaLkzE0edJoZL2wZPWEc7
	 9wFL4h0q+SdrA==
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
Subject: [PATCHv3 6.6.y 3/3] selftests: forwarding: Avoid failures to source net/lib.sh
Date: Wed, 19 Jun 2024 17:39:24 +0800
Message-Id: <20240619093924.1291623-4-po-hsu.lin@canonical.com>
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

From: Benjamin Poirier <bpoirier@nvidia.com>

commit 2114e83381d3289a88378850f43069e79f848083 upstream.

The expression "source ../lib.sh" added to net/forwarding/lib.sh in commit
25ae948b4478 ("selftests/net: add lib.sh") does not work for tests outside
net/forwarding which source net/forwarding/lib.sh (1). It also does not
work in some cases where only a subset of tests are exported (2).

Avoid the problems mentioned above by replacing the faulty expression with
a copy of the content from net/lib.sh which is used by files under
net/forwarding.

A more thorough solution which avoids duplicating content between
net/lib.sh and net/forwarding/lib.sh has been posted here:
https://lore.kernel.org/netdev/20231222135836.992841-1-bpoirier@nvidia.com/

The approach in the current patch is a stopgap solution to avoid submitting
large changes at the eleventh hour of this development cycle.

Example of problem 1)

tools/testing/selftests/drivers/net/bonding$ ./dev_addr_lists.sh
./net_forwarding_lib.sh: line 41: ../lib.sh: No such file or directory
TEST: bonding cleanup mode active-backup                            [ OK ]
TEST: bonding cleanup mode 802.3ad                                  [ OK ]
TEST: bonding LACPDU multicast address to slave (from bond down)    [ OK ]
TEST: bonding LACPDU multicast address to slave (from bond up)      [ OK ]

An error message is printed but since the test does not use functions from
net/lib.sh, the test results are not affected.

Example of problem 2)

tools/testing/selftests$ make install TARGETS="net/forwarding"
tools/testing/selftests$ cd kselftest_install/net/forwarding/
tools/testing/selftests/kselftest_install/net/forwarding$ ./pedit_ip.sh veth{0..3}
lib.sh: line 41: ../lib.sh: No such file or directory
TEST: ping                                                          [ OK ]
TEST: ping6                                                         [ OK ]
./pedit_ip.sh: line 135: busywait: command not found
TEST: dev veth1 ingress pedit ip src set 198.51.100.1               [FAIL]
        Expected to get 10 packets, but got .
./pedit_ip.sh: line 135: busywait: command not found
TEST: dev veth2 egress pedit ip src set 198.51.100.1                [FAIL]
        Expected to get 10 packets, but got .
./pedit_ip.sh: line 135: busywait: command not found
TEST: dev veth1 ingress pedit ip dst set 198.51.100.1               [FAIL]
        Expected to get 10 packets, but got .
./pedit_ip.sh: line 135: busywait: command not found
TEST: dev veth2 egress pedit ip dst set 198.51.100.1                [FAIL]
        Expected to get 10 packets, but got .
./pedit_ip.sh: line 135: busywait: command not found
TEST: dev veth1 ingress pedit ip6 src set 2001:db8:2::1             [FAIL]
        Expected to get 10 packets, but got .
./pedit_ip.sh: line 135: busywait: command not found
TEST: dev veth2 egress pedit ip6 src set 2001:db8:2::1              [FAIL]
        Expected to get 10 packets, but got .
./pedit_ip.sh: line 135: busywait: command not found
TEST: dev veth1 ingress pedit ip6 dst set 2001:db8:2::1             [FAIL]
        Expected to get 10 packets, but got .
./pedit_ip.sh: line 135: busywait: command not found
TEST: dev veth2 egress pedit ip6 dst set 2001:db8:2::1              [FAIL]
        Expected to get 10 packets, but got .

In this case, the test results are affected.

Fixes: 25ae948b4478 ("selftests/net: add lib.sh")
Suggested-by: Ido Schimmel <idosch@nvidia.com>
Suggested-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
Link: https://lore.kernel.org/r/20240104141109.100672-1-bpoirier@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 8f6ca45..97e7675 100755
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -38,7 +38,32 @@ if [[ -f $relative_path/forwarding.config ]]; then
 	source "$relative_path/forwarding.config"
 fi
 
-source ../lib.sh
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
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
 ##############################################################################
 # Sanity checks
 
-- 
2.7.4


