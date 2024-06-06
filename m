Return-Path: <stable+bounces-48551-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F608FE97B
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01EFA1C24834
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B1F197A9E;
	Thu,  6 Jun 2024 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eqlJnHEN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8160F198822;
	Thu,  6 Jun 2024 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683029; cv=none; b=LvshYGNjISGsCIIz7MT1ZL0HOL2dq3ArzJsZuAMcMG+EV++XYoeTEwF5UTjCW6YBsunH7z4LQrf7mSqTloO9YUn5irqIhYphiPpVeuwjH9vlDCOaFqioORIBiMHS3A5aY2VA4BWTfvUhaN+18xfsD80/6vk1xEIlABNGMuDfc0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683029; c=relaxed/simple;
	bh=orpu/kVRFNKMuIi1Og36fCp1yVFTSNZ9sBciQBJzQ90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fdvmX2gFToMy2tBRJKWDYkNF44kl+Y8lxpq2omRHaR+8kpVxsNw93hCy3Jvb8OdKzLOi7HC47p5MdNSmeBwmuU0RXE0OJu1h7B5vVWng9ceUoSHe5npf3uHIahfCn9HMVCP5R6Z2ekdHhIcfjLx+EKFtJbnsDOY/H6iv0QS0zzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eqlJnHEN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0AAC32781;
	Thu,  6 Jun 2024 14:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683029;
	bh=orpu/kVRFNKMuIi1Og36fCp1yVFTSNZ9sBciQBJzQ90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eqlJnHENOYXR/wtu8jpNDu+4ePnMRJi2HVsxpXz8mNvbqAvq6R38HMZ/AMV4Guoiv
	 gRcMNq4msLSWNw2JzzZDJN6BqxLPee/vs1tOAxaPJC/hcyAMqrJp5T/DxZ6TC2qtbr
	 Vdfukn2uMCKC34qiajopgmanhGgTiauk1AO0I+Tw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hangbin Liu <liuhangbin@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 251/374] selftests/net: use tc rule to filter the na packet
Date: Thu,  6 Jun 2024 16:03:50 +0200
Message-ID: <20240606131700.240735854@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131651.683718371@linuxfoundation.org>
References: <20240606131651.683718371@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit ea63ac14292564eefc7dffe868ed354ff9ed6f4b ]

Test arp_ndisc_untracked_subnets use tcpdump to filter the unsolicited
and untracked na messages. It set -e before calling tcpdump. But if
tcpdump filters 0 packet, it will return none zero, and cause the script
to exit.

Instead of using slow tcpdump to capture packets, let's using tc rule
to filter out the na message.

At the same time, fix function setup_v6 which only needs one parameter.
Move all the related helpers from forwarding lib.sh to net lib.sh.

Fixes: 0ea7b0a454ca ("selftests: net: arp_ndisc_untracked_subnets: test for arp_accept and accept_untracked_na")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20240517010327.2631319-1-liuhangbin@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/arp_ndisc_untracked_subnets.sh        | 53 ++++++-----------
 tools/testing/selftests/net/forwarding/lib.sh | 58 -------------------
 tools/testing/selftests/net/lib.sh            | 58 +++++++++++++++++++
 3 files changed, 75 insertions(+), 94 deletions(-)

diff --git a/tools/testing/selftests/net/arp_ndisc_untracked_subnets.sh b/tools/testing/selftests/net/arp_ndisc_untracked_subnets.sh
index a40c0e9bd023c..eef5cbf6eecca 100755
--- a/tools/testing/selftests/net/arp_ndisc_untracked_subnets.sh
+++ b/tools/testing/selftests/net/arp_ndisc_untracked_subnets.sh
@@ -73,25 +73,19 @@ setup_v6() {
 	# namespaces. veth0 is veth-router, veth1 is veth-host.
 	# first, set up the inteface's link to the namespace
 	# then, set the interface "up"
-	ip -6 -netns ${ROUTER_NS_V6} link add name ${ROUTER_INTF} \
-		type veth peer name ${HOST_INTF}
-
-	ip -6 -netns ${ROUTER_NS_V6} link set dev ${ROUTER_INTF} up
-	ip -6 -netns ${ROUTER_NS_V6} link set dev ${HOST_INTF} netns \
-		${HOST_NS_V6}
+	ip -n ${ROUTER_NS_V6} link add name ${ROUTER_INTF} \
+		type veth peer name ${HOST_INTF} netns ${HOST_NS_V6}
 
-	ip -6 -netns ${HOST_NS_V6} link set dev ${HOST_INTF} up
-	ip -6 -netns ${ROUTER_NS_V6} addr add \
-		${ROUTER_ADDR_V6}/${PREFIX_WIDTH_V6} dev ${ROUTER_INTF} nodad
+	# Add tc rule to filter out host na message
+	tc -n ${ROUTER_NS_V6} qdisc add dev ${ROUTER_INTF} clsact
+	tc -n ${ROUTER_NS_V6} filter add dev ${ROUTER_INTF} \
+		ingress protocol ipv6 pref 1 handle 101 \
+		flower src_ip ${HOST_ADDR_V6} ip_proto icmpv6 type 136 skip_hw action pass
 
 	HOST_CONF=net.ipv6.conf.${HOST_INTF}
 	ip netns exec ${HOST_NS_V6} sysctl -qw ${HOST_CONF}.ndisc_notify=1
 	ip netns exec ${HOST_NS_V6} sysctl -qw ${HOST_CONF}.disable_ipv6=0
-	ip -6 -netns ${HOST_NS_V6} addr add ${HOST_ADDR_V6}/${PREFIX_WIDTH_V6} \
-		dev ${HOST_INTF}
-
 	ROUTER_CONF=net.ipv6.conf.${ROUTER_INTF}
-
 	ip netns exec ${ROUTER_NS_V6} sysctl -w \
 		${ROUTER_CONF}.forwarding=1 >/dev/null 2>&1
 	ip netns exec ${ROUTER_NS_V6} sysctl -w \
@@ -99,6 +93,13 @@ setup_v6() {
 	ip netns exec ${ROUTER_NS_V6} sysctl -w \
 		${ROUTER_CONF}.accept_untracked_na=${accept_untracked_na} \
 		>/dev/null 2>&1
+
+	ip -n ${ROUTER_NS_V6} link set dev ${ROUTER_INTF} up
+	ip -n ${HOST_NS_V6} link set dev ${HOST_INTF} up
+	ip -n ${ROUTER_NS_V6} addr add ${ROUTER_ADDR_V6}/${PREFIX_WIDTH_V6} \
+		dev ${ROUTER_INTF} nodad
+	ip -n ${HOST_NS_V6} addr add ${HOST_ADDR_V6}/${PREFIX_WIDTH_V6} \
+		dev ${HOST_INTF}
 	set +e
 }
 
@@ -162,26 +163,6 @@ arp_test_gratuitous_combinations() {
 	arp_test_gratuitous 2 1
 }
 
-cleanup_tcpdump() {
-	set -e
-	[[ ! -z  ${tcpdump_stdout} ]] && rm -f ${tcpdump_stdout}
-	[[ ! -z  ${tcpdump_stderr} ]] && rm -f ${tcpdump_stderr}
-	tcpdump_stdout=
-	tcpdump_stderr=
-	set +e
-}
-
-start_tcpdump() {
-	set -e
-	tcpdump_stdout=`mktemp`
-	tcpdump_stderr=`mktemp`
-	ip netns exec ${ROUTER_NS_V6} timeout 15s \
-		tcpdump --immediate-mode -tpni ${ROUTER_INTF} -c 1 \
-		"icmp6 && icmp6[0] == 136 && src ${HOST_ADDR_V6}" \
-		> ${tcpdump_stdout} 2> /dev/null
-	set +e
-}
-
 verify_ndisc() {
 	local accept_untracked_na=$1
 	local same_subnet=$2
@@ -222,8 +203,9 @@ ndisc_test_untracked_advertisements() {
 			HOST_ADDR_V6=2001:db8:abcd:0012::3
 		fi
 	fi
-	setup_v6 $1 $2
-	start_tcpdump
+	setup_v6 $1
+	slowwait_for_counter 15 1 \
+		tc_rule_handle_stats_get "dev ${ROUTER_INTF} ingress" 101 ".packets" "-n ${ROUTER_NS_V6}"
 
 	if verify_ndisc $1 $2; then
 		printf "    TEST: %-60s  [ OK ]\n" "${test_msg[*]}"
@@ -231,7 +213,6 @@ ndisc_test_untracked_advertisements() {
 		printf "    TEST: %-60s  [FAIL]\n" "${test_msg[*]}"
 	fi
 
-	cleanup_tcpdump
 	cleanup_v6
 	set +e
 }
diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 01322758255f7..e78f11140edd8 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -38,14 +38,6 @@ fi
 
 source "$net_forwarding_dir/../lib.sh"
 
-# timeout in seconds
-slowwait()
-{
-	local timeout_sec=$1; shift
-
-	loopy_wait "sleep 0.1" "$((timeout_sec * 1000))" "$@"
-}
-
 ##############################################################################
 # Sanity checks
 
@@ -529,33 +521,6 @@ wait_for_trap()
 	"$@" | grep -q trap
 }
 
-until_counter_is()
-{
-	local expr=$1; shift
-	local current=$("$@")
-
-	echo $((current))
-	((current $expr))
-}
-
-busywait_for_counter()
-{
-	local timeout=$1; shift
-	local delta=$1; shift
-
-	local base=$("$@")
-	busywait "$timeout" until_counter_is ">= $((base + delta))" "$@"
-}
-
-slowwait_for_counter()
-{
-	local timeout=$1; shift
-	local delta=$1; shift
-
-	local base=$("$@")
-	slowwait "$timeout" until_counter_is ">= $((base + delta))" "$@"
-}
-
 setup_wait_dev()
 {
 	local dev=$1; shift
@@ -861,29 +826,6 @@ link_stats_rx_errors_get()
 	link_stats_get $1 rx errors
 }
 
-tc_rule_stats_get()
-{
-	local dev=$1; shift
-	local pref=$1; shift
-	local dir=$1; shift
-	local selector=${1:-.packets}; shift
-
-	tc -j -s filter show dev $dev ${dir:-ingress} pref $pref \
-	    | jq ".[1].options.actions[].stats$selector"
-}
-
-tc_rule_handle_stats_get()
-{
-	local id=$1; shift
-	local handle=$1; shift
-	local selector=${1:-.packets}; shift
-	local netns=${1:-""}; shift
-
-	tc $netns -j -s filter show $id \
-	    | jq ".[] | select(.options.handle == $handle) | \
-		  .options.actions[0].stats$selector"
-}
-
 ethtool_stats_get()
 {
 	local dev=$1; shift
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 308c3b0bcf210..fb640fb9e8d32 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -86,6 +86,41 @@ busywait()
 	loopy_wait : "$timeout_ms" "$@"
 }
 
+# timeout in seconds
+slowwait()
+{
+	local timeout_sec=$1; shift
+
+	loopy_wait "sleep 0.1" "$((timeout_sec * 1000))" "$@"
+}
+
+until_counter_is()
+{
+	local expr=$1; shift
+	local current=$("$@")
+
+	echo $((current))
+	((current $expr))
+}
+
+busywait_for_counter()
+{
+	local timeout=$1; shift
+	local delta=$1; shift
+
+	local base=$("$@")
+	busywait "$timeout" until_counter_is ">= $((base + delta))" "$@"
+}
+
+slowwait_for_counter()
+{
+	local timeout=$1; shift
+	local delta=$1; shift
+
+	local base=$("$@")
+	slowwait "$timeout" until_counter_is ">= $((base + delta))" "$@"
+}
+
 cleanup_ns()
 {
 	local ns=""
@@ -145,3 +180,26 @@ setup_ns()
 	done
 	NS_LIST="$NS_LIST $ns_list"
 }
+
+tc_rule_stats_get()
+{
+	local dev=$1; shift
+	local pref=$1; shift
+	local dir=$1; shift
+	local selector=${1:-.packets}; shift
+
+	tc -j -s filter show dev $dev ${dir:-ingress} pref $pref \
+	    | jq ".[1].options.actions[].stats$selector"
+}
+
+tc_rule_handle_stats_get()
+{
+	local id=$1; shift
+	local handle=$1; shift
+	local selector=${1:-.packets}; shift
+	local netns=${1:-""}; shift
+
+	tc $netns -j -s filter show $id \
+	    | jq ".[] | select(.options.handle == $handle) | \
+		  .options.actions[0].stats$selector"
+}
-- 
2.43.0




