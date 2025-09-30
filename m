Return-Path: <stable+bounces-182259-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC735BAD6D4
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 17:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EE623B53EB
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 14:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2EA30506E;
	Tue, 30 Sep 2025 14:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G8fFoUVc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73E92FFDE6;
	Tue, 30 Sep 2025 14:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759244365; cv=none; b=LNTMGGwM587cf6US+ysnHe6q/hJ88D8gZPeEVEj33GO8Myc9G9qcYrP7WjN8vfaIjd4yqzUMZYjJ1Cw0FmfR0JHwoffyITVrEx/eCGbJetaQdrv+YDf6/Km+Jw1vrzUE5A3YggusTeI7mfjDSEVqPGbpRV3u8BsJ4bnmJlgJov4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759244365; c=relaxed/simple;
	bh=st9OnGXg8Y4o1bUJkJWfQan2qmNvaDNhong9duGKZgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lN/eNMb5iodrK5itXu9wW13Pa/eScEHjgfFb5ZGAyrgEJnVBzgfpbgc2+2yDkxBYsUS4MJ6UfB34NWPP6oFEvusIyCVilk+yeqKzpcPk7JiUCVrRIJ3x+M6h6iJnE9rAlwmxgIVE+fpabz9ftVhrHI1rpRz4Ral3Ceh7eCAUGTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G8fFoUVc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA94C116B1;
	Tue, 30 Sep 2025 14:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759244365;
	bh=st9OnGXg8Y4o1bUJkJWfQan2qmNvaDNhong9duGKZgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G8fFoUVcjUnDb3YOgrvMIRD9KHNSaLjUGDmb5Z7B/Z6mDZI1teSVS7Fh6D986zynU
	 ruD4MmVwXCiiQmknDAGt8Q4P3IbS56ov+zBb2PFFkfTkJLn25GJ93XNC8esSzne4D0
	 RJsm7BuYJQX8l0XWzQQU280oQZ9wa0jq+rYYwOYM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ido Schimmel <idosch@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 107/122] selftests: fib_nexthops: Fix creation of non-FDB nexthops
Date: Tue, 30 Sep 2025 16:47:18 +0200
Message-ID: <20250930143827.354961815@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930143822.939301999@linuxfoundation.org>
References: <20250930143822.939301999@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ido Schimmel <idosch@nvidia.com>

[ Upstream commit c29913109c70383cdf90b6fc792353e1009f24f5 ]

The test creates non-FDB nexthops without a nexthop device which leads
to the expected failure, but for the wrong reason:

 # ./fib_nexthops.sh -t "ipv6_fdb_grp_fcnal ipv4_fdb_grp_fcnal" -v

 IPv6 fdb groups functional
 --------------------------
 [...]
 COMMAND: ip -netns me-nRsN3E nexthop add id 63 via 2001:db8:91::4
 Error: Device attribute required for non-blackhole and non-fdb nexthops.
 COMMAND: ip -netns me-nRsN3E nexthop add id 64 via 2001:db8:91::5
 Error: Device attribute required for non-blackhole and non-fdb nexthops.
 COMMAND: ip -netns me-nRsN3E nexthop add id 103 group 63/64 fdb
 Error: Invalid nexthop id.
 TEST: Fdb Nexthop group with non-fdb nexthops                       [ OK ]
 [...]

 IPv4 fdb groups functional
 --------------------------
 [...]
 COMMAND: ip -netns me-nRsN3E nexthop add id 14 via 172.16.1.2
 Error: Device attribute required for non-blackhole and non-fdb nexthops.
 COMMAND: ip -netns me-nRsN3E nexthop add id 15 via 172.16.1.3
 Error: Device attribute required for non-blackhole and non-fdb nexthops.
 COMMAND: ip -netns me-nRsN3E nexthop add id 103 group 14/15 fdb
 Error: Invalid nexthop id.
 TEST: Fdb Nexthop group with non-fdb nexthops                       [ OK ]

 COMMAND: ip -netns me-nRsN3E nexthop add id 16 via 172.16.1.2 fdb
 COMMAND: ip -netns me-nRsN3E nexthop add id 17 via 172.16.1.3 fdb
 COMMAND: ip -netns me-nRsN3E nexthop add id 104 group 14/15
 Error: Invalid nexthop id.
 TEST: Non-Fdb Nexthop group with fdb nexthops                       [ OK ]
 [...]
 COMMAND: ip -netns me-0dlhyd ro add 172.16.0.0/22 nhid 15
 Error: Nexthop id does not exist.
 TEST: Route add with fdb nexthop                                    [ OK ]

In addition, as can be seen in the above output, a couple of IPv4 test
cases used the non-FDB nexthops (14 and 15) when they intended to use
the FDB nexthops (16 and 17). These test cases only passed because
failure was expected, but they failed for the wrong reason.

Fix the test to create the non-FDB nexthops with a nexthop device and
adjust the IPv4 test cases to use the FDB nexthops instead of the
non-FDB nexthops.

Output after the fix:

 # ./fib_nexthops.sh -t "ipv6_fdb_grp_fcnal ipv4_fdb_grp_fcnal" -v

 IPv6 fdb groups functional
 --------------------------
 [...]
 COMMAND: ip -netns me-lNzfHP nexthop add id 63 via 2001:db8:91::4 dev veth1
 COMMAND: ip -netns me-lNzfHP nexthop add id 64 via 2001:db8:91::5 dev veth1
 COMMAND: ip -netns me-lNzfHP nexthop add id 103 group 63/64 fdb
 Error: FDB nexthop group can only have fdb nexthops.
 TEST: Fdb Nexthop group with non-fdb nexthops                       [ OK ]
 [...]

 IPv4 fdb groups functional
 --------------------------
 [...]
 COMMAND: ip -netns me-lNzfHP nexthop add id 14 via 172.16.1.2 dev veth1
 COMMAND: ip -netns me-lNzfHP nexthop add id 15 via 172.16.1.3 dev veth1
 COMMAND: ip -netns me-lNzfHP nexthop add id 103 group 14/15 fdb
 Error: FDB nexthop group can only have fdb nexthops.
 TEST: Fdb Nexthop group with non-fdb nexthops                       [ OK ]

 COMMAND: ip -netns me-lNzfHP nexthop add id 16 via 172.16.1.2 fdb
 COMMAND: ip -netns me-lNzfHP nexthop add id 17 via 172.16.1.3 fdb
 COMMAND: ip -netns me-lNzfHP nexthop add id 104 group 16/17
 Error: Non FDB nexthop group cannot have fdb nexthops.
 TEST: Non-Fdb Nexthop group with fdb nexthops                       [ OK ]
 [...]
 COMMAND: ip -netns me-lNzfHP ro add 172.16.0.0/22 nhid 16
 Error: Route cannot point to a fdb nexthop.
 TEST: Route add with fdb nexthop                                    [ OK ]
 [...]
 Tests passed:  30
 Tests failed:   0
 Tests skipped:  0

Fixes: 0534c5489c11 ("selftests: net: add fdb nexthop tests")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://patch.msgid.link/20250921150824.149157-3-idosch@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/fib_nexthops.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/fib_nexthops.sh b/tools/testing/selftests/net/fib_nexthops.sh
index 7ece4131dc6fc..cdc7c0ff090f6 100755
--- a/tools/testing/selftests/net/fib_nexthops.sh
+++ b/tools/testing/selftests/net/fib_nexthops.sh
@@ -370,8 +370,8 @@ ipv6_fdb_grp_fcnal()
 	log_test $? 0 "Get Fdb nexthop group by id"
 
 	# fdb nexthop group can only contain fdb nexthops
-	run_cmd "$IP nexthop add id 63 via 2001:db8:91::4"
-	run_cmd "$IP nexthop add id 64 via 2001:db8:91::5"
+	run_cmd "$IP nexthop add id 63 via 2001:db8:91::4 dev veth1"
+	run_cmd "$IP nexthop add id 64 via 2001:db8:91::5 dev veth1"
 	run_cmd "$IP nexthop add id 103 group 63/64 fdb"
 	log_test $? 2 "Fdb Nexthop group with non-fdb nexthops"
 
@@ -450,15 +450,15 @@ ipv4_fdb_grp_fcnal()
 	log_test $? 0 "Get Fdb nexthop group by id"
 
 	# fdb nexthop group can only contain fdb nexthops
-	run_cmd "$IP nexthop add id 14 via 172.16.1.2"
-	run_cmd "$IP nexthop add id 15 via 172.16.1.3"
+	run_cmd "$IP nexthop add id 14 via 172.16.1.2 dev veth1"
+	run_cmd "$IP nexthop add id 15 via 172.16.1.3 dev veth1"
 	run_cmd "$IP nexthop add id 103 group 14/15 fdb"
 	log_test $? 2 "Fdb Nexthop group with non-fdb nexthops"
 
 	# Non fdb nexthop group can not contain fdb nexthops
 	run_cmd "$IP nexthop add id 16 via 172.16.1.2 fdb"
 	run_cmd "$IP nexthop add id 17 via 172.16.1.3 fdb"
-	run_cmd "$IP nexthop add id 104 group 14/15"
+	run_cmd "$IP nexthop add id 104 group 16/17"
 	log_test $? 2 "Non-Fdb Nexthop group with fdb nexthops"
 
 	# fdb nexthop cannot have blackhole
@@ -485,7 +485,7 @@ ipv4_fdb_grp_fcnal()
 	run_cmd "$BRIDGE fdb add 02:02:00:00:00:14 dev vx10 nhid 12 self"
 	log_test $? 255 "Fdb mac add with nexthop"
 
-	run_cmd "$IP ro add 172.16.0.0/22 nhid 15"
+	run_cmd "$IP ro add 172.16.0.0/22 nhid 16"
 	log_test $? 2 "Route add with fdb nexthop"
 
 	run_cmd "$IP ro add 172.16.0.0/22 nhid 103"
-- 
2.51.0




