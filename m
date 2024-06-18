Return-Path: <stable+bounces-52644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1980690C688
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 12:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A9851C21D90
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 10:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34E118EFF3;
	Tue, 18 Jun 2024 07:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="GPntzDUL"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5801327E5
	for <stable@vger.kernel.org>; Tue, 18 Jun 2024 07:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718697230; cv=none; b=d+W0AcaAhs46SFqvxfFCy8bT8BlQo01I0mGx5xhBvTtSMxUsRPRxWdpXJ8gDgVQBoTAPm6pNXzkPvGuSyeGIWWCz/1v85tpEqT0RYmYoFadQOYiiXMZkjWkbuJXYpaw2+L0z6i5QcM6rLSiSDOa1EETmQ3XgSTQpWrRWLg9i1Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718697230; c=relaxed/simple;
	bh=iyjeGmXh7Y92zHpYjtCUQgZC10JfR3oYwdE3ugkVbO4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lbDj3tt42dX4u5/9toZ+Od1tCzpoI8z2ZduIx6L2u2zzHlxXrSxdA9rOPTantIhg09HnWJwSV7xoB8Wz15X8OmmAs470FLOSOjDU5bkhU0RGVd8K4k0RJ52bKyXf0V8BAzDKSA9b+cMbwow0lpbeBfhwBEa+j89qxnxMf2oQRjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=GPntzDUL; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from Phocidae.conference (1.general.phlin.uk.vpn [10.172.194.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 37F313F070;
	Tue, 18 Jun 2024 07:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1718697227;
	bh=+QCssrpZ9bz1IaOmzN409QtZBtZYlIk22JbBS6fOj9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=GPntzDULL2/EmpmERoZN9+zS2PVh99h8aV8l5DrNRSxwepLVuYr9Fmk5L4zNBEyf5
	 6qLt0aM+2x7y9mAZ7k3j4vDhCXScw0D/u1ELczyHFNfvIGs4APnt17lkOGtK0U9zGx
	 j4sq1WT+F12HSu2bhbNU95n6y1DWjvIyLHSz/u8US1cidxT/eNB3wOAaiXhhnXtyNl
	 E1eQpggn7JMV//vFwxWlJE9yWsBZAQANG5U25nKpNegpBbu+Ji9KDn4DWDPTQzSj3L
	 D+fpLEXJ5m6gJmE1HQ4KyXZhI7d7psFc7tznCAF6l5Huv/+f56F+mzcIk+LOkC4PEm
	 N9qYGqiJ/zmPA==
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
Subject: [PATCHv2 6.6.y 3/3] selftests: forwarding: Avoid failures to source net/lib.sh
Date: Tue, 18 Jun 2024 15:53:06 +0800
Message-Id: <20240618075306.1073405-4-po-hsu.lin@canonical.com>
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


