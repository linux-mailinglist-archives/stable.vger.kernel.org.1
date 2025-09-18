Return-Path: <stable+bounces-178478-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A76BB47ED5
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0BFA7A4907
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 20:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736DE212B3D;
	Sun,  7 Sep 2025 20:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iZKSDzTb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6A617BB21;
	Sun,  7 Sep 2025 20:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757276963; cv=none; b=pvzAT/6mZ1Wb5OuI2JYq6oVcdEJfP/Wtue7ZBKRuvt/CbZ389wp+pA5/M5jBi2xjcELJ5tWbk/PbYr+6Tf4tcB9qzqd2SbytMnu+8wAACx8cWmgd3wqHxNCD6ChnoJ/jmhCs4Ehvx3ZEhf23qR+4BHVD+JvDcEJGje6aveb8kvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757276963; c=relaxed/simple;
	bh=BF3rUQIWKLit7A/aw9eAD19dr9Q98Y5MPTVLchFa2AI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EIrsbVe9yx9GfE5E8whxMxxFXDVaE97xwMDzZIr5RLj1uHIHJCsNUdOuHxGm4sVU+7VMAPtPT2qTcMEavuIG2xrplrhHIHHifupFNQOn5s0TbVFJA1iuanmOcwx4eE7qQXbryTQyFp3W1EWSmMpwLu+1xXXK1KOugNkwFk0FtQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iZKSDzTb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A142FC4CEF0;
	Sun,  7 Sep 2025 20:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757276963;
	bh=BF3rUQIWKLit7A/aw9eAD19dr9Q98Y5MPTVLchFa2AI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iZKSDzTbgZJD5QhvGgWuT9DPIoutpUek6S3xu11GNhKx/xmvS6zpJ3tqiya/M/7hj
	 rcrRyepGSDF/WlvyQbro386eXMHU7p1hnYqhR54nmu9dJKf46DcU+W6wkJuzykZcvX
	 w1nwo1AR+BpDcKHBj33OLoe/WqVC6Nknx6emSkI0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 044/175] netfilter: nft_flowtable.sh: re-run with random mtu sizes
Date: Sun,  7 Sep 2025 21:57:19 +0200
Message-ID: <20250907195615.895806234@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250907195614.892725141@linuxfoundation.org>
References: <20250907195614.892725141@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

[ Upstream commit d6a367ec6c96fc8e61b4d67e69df03565ec69fb7 ]

Jakub says:
 nft_flowtable.sh is one of the most flake-atious test for netdev CI currently :(

The root cause is two-fold:
1. the failing part of the test is supposed to make sure that ip
   fragments are forwarded for offloaded flows.
   (flowtable has to pass them to classic forward path).
   path mtu discovery for these subtests is disabled.

2. nft_flowtable.sh has two passes.  One with fixed mtus/file size and
  one where link mtus and file sizes are random.

The CI failures all have same pattern:
  re-run with random mtus and file size: -o 27663 -l 4117 -r 10089 -s 54384840
  [..]
  PASS: dscp_egress: dscp packet counters match
  FAIL: file mismatch for ns1 -> ns2

In some cases this error triggers a bit ealier, sometimes in a later
subtest:
  re-run with random mtus and file size: -o 20201 -l 4555 -r 12657 -s 9405856
  [..]
  PASS: dscp_egress: dscp packet counters match
  PASS: dscp_fwd: dscp packet counters match
  2025/08/17 20:37:52 socat[18954] E write(7, 0x560716b96000, 8192): Broken pipe
  FAIL: file mismatch for ns1 -> ns2
  -rw------- 1 root root 9405856 Aug 17 20:36 /tmp/tmp.2n63vlTrQe

But all logs I saw show same scenario:
1. Failing tests have pmtu discovery off (i.e., ip fragmentation)
2. The test file is much larger than first-pass default (2M Byte)
3. peers have much larger MTUs compared to the 'network'.

These errors are very reproducible when re-running the test with
the same commandline arguments.

The timeout became much more prominent with
1d2fbaad7cd8 ("tcp: stronger sk_rcvbuf checks"): reassembled packets
typically have a skb->truesize more than double the skb length.

As that commit is intentional and pmtud-off with
large-tcp-packets-as-fragments is not normal adjust the test to use a
smaller file for the pmtu-off subtests.

While at it, add more information to pass/fail messages and
also run the dscp alteration subtest with pmtu discovery enabled.

Link: https://netdev.bots.linux.dev/contest.html?test=nft-flowtable-sh
Fixes: f84ab634904c ("selftests: netfilter: nft_flowtable.sh: re-run with random mtu sizes")
Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/netdev/20250822071330.4168f0db@kernel.org/
Signed-off-by: Florian Westphal <fw@strlen.de>
Link: https://patch.msgid.link/20250828214918.3385-1-fw@strlen.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../selftests/net/netfilter/nft_flowtable.sh  | 113 ++++++++++++------
 1 file changed, 76 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/net/netfilter/nft_flowtable.sh b/tools/testing/selftests/net/netfilter/nft_flowtable.sh
index a4ee5496f2a17..45832df982950 100755
--- a/tools/testing/selftests/net/netfilter/nft_flowtable.sh
+++ b/tools/testing/selftests/net/netfilter/nft_flowtable.sh
@@ -20,6 +20,7 @@ ret=0
 SOCAT_TIMEOUT=60
 
 nsin=""
+nsin_small=""
 ns1out=""
 ns2out=""
 
@@ -36,7 +37,7 @@ cleanup() {
 
 	cleanup_all_ns
 
-	rm -f "$nsin" "$ns1out" "$ns2out"
+	rm -f "$nsin" "$nsin_small" "$ns1out" "$ns2out"
 
 	[ "$log_netns" -eq 0 ] && sysctl -q net.netfilter.nf_log_all_netns="$log_netns"
 }
@@ -72,6 +73,7 @@ lmtu=1500
 rmtu=2000
 
 filesize=$((2 * 1024 * 1024))
+filesize_small=$((filesize / 16))
 
 usage(){
 	echo "nft_flowtable.sh [OPTIONS]"
@@ -89,7 +91,10 @@ do
 		o) omtu=$OPTARG;;
 		l) lmtu=$OPTARG;;
 		r) rmtu=$OPTARG;;
-		s) filesize=$OPTARG;;
+		s)
+			filesize=$OPTARG
+			filesize_small=$((OPTARG / 16))
+		;;
 		*) usage;;
 	esac
 done
@@ -215,6 +220,7 @@ if ! ip netns exec "$ns2" ping -c 1 -q 10.0.1.99 > /dev/null; then
 fi
 
 nsin=$(mktemp)
+nsin_small=$(mktemp)
 ns1out=$(mktemp)
 ns2out=$(mktemp)
 
@@ -265,6 +271,7 @@ check_counters()
 check_dscp()
 {
 	local what=$1
+	local pmtud="$2"
 	local ok=1
 
 	local counter
@@ -277,37 +284,39 @@ check_dscp()
 	local pc4z=${counter%*bytes*}
 	local pc4z=${pc4z#*packets}
 
+	local failmsg="FAIL: pmtu $pmtu: $what counters do not match, expected"
+
 	case "$what" in
 	"dscp_none")
 		if [ "$pc4" -gt 0 ] || [ "$pc4z" -eq 0 ]; then
-			echo "FAIL: dscp counters do not match, expected dscp3 == 0, dscp0 > 0, but got $pc4,$pc4z" 1>&2
+			echo "$failmsg dscp3 == 0, dscp0 > 0, but got $pc4,$pc4z" 1>&2
 			ret=1
 			ok=0
 		fi
 		;;
 	"dscp_fwd")
 		if [ "$pc4" -eq 0 ] || [ "$pc4z" -eq 0 ]; then
-			echo "FAIL: dscp counters do not match, expected dscp3 and dscp0 > 0 but got $pc4,$pc4z" 1>&2
+			echo "$failmsg dscp3 and dscp0 > 0 but got $pc4,$pc4z" 1>&2
 			ret=1
 			ok=0
 		fi
 		;;
 	"dscp_ingress")
 		if [ "$pc4" -eq 0 ] || [ "$pc4z" -gt 0 ]; then
-			echo "FAIL: dscp counters do not match, expected dscp3 > 0, dscp0 == 0 but got $pc4,$pc4z" 1>&2
+			echo "$failmsg dscp3 > 0, dscp0 == 0 but got $pc4,$pc4z" 1>&2
 			ret=1
 			ok=0
 		fi
 		;;
 	"dscp_egress")
 		if [ "$pc4" -eq 0 ] || [ "$pc4z" -gt 0 ]; then
-			echo "FAIL: dscp counters do not match, expected dscp3 > 0, dscp0 == 0 but got $pc4,$pc4z" 1>&2
+			echo "$failmsg dscp3 > 0, dscp0 == 0 but got $pc4,$pc4z" 1>&2
 			ret=1
 			ok=0
 		fi
 		;;
 	*)
-		echo "FAIL: Unknown DSCP check" 1>&2
+		echo "$failmsg: Unknown DSCP check" 1>&2
 		ret=1
 		ok=0
 	esac
@@ -319,9 +328,9 @@ check_dscp()
 
 check_transfer()
 {
-	in=$1
-	out=$2
-	what=$3
+	local in=$1
+	local out=$2
+	local what=$3
 
 	if ! cmp "$in" "$out" > /dev/null 2>&1; then
 		echo "FAIL: file mismatch for $what" 1>&2
@@ -342,25 +351,39 @@ test_tcp_forwarding_ip()
 {
 	local nsa=$1
 	local nsb=$2
-	local dstip=$3
-	local dstport=$4
+	local pmtu=$3
+	local dstip=$4
+	local dstport=$5
 	local lret=0
+	local socatc
+	local socatl
+	local infile="$nsin"
+
+	if [ $pmtu -eq 0 ]; then
+		infile="$nsin_small"
+	fi
 
-	timeout "$SOCAT_TIMEOUT" ip netns exec "$nsb" socat -4 TCP-LISTEN:12345,reuseaddr STDIO < "$nsin" > "$ns2out" &
+	timeout "$SOCAT_TIMEOUT" ip netns exec "$nsb" socat -4 TCP-LISTEN:12345,reuseaddr STDIO < "$infile" > "$ns2out" &
 	lpid=$!
 
 	busywait 1000 listener_ready
 
-	timeout "$SOCAT_TIMEOUT" ip netns exec "$nsa" socat -4 TCP:"$dstip":"$dstport" STDIO < "$nsin" > "$ns1out"
+	timeout "$SOCAT_TIMEOUT" ip netns exec "$nsa" socat -4 TCP:"$dstip":"$dstport" STDIO < "$infile" > "$ns1out"
+	socatc=$?
 
 	wait $lpid
+	socatl=$?
 
-	if ! check_transfer "$nsin" "$ns2out" "ns1 -> ns2"; then
+	if [ $socatl -ne 0 ] || [ $socatc -ne 0 ];then
+		rc=1
+	fi
+
+	if ! check_transfer "$infile" "$ns2out" "ns1 -> ns2"; then
 		lret=1
 		ret=1
 	fi
 
-	if ! check_transfer "$nsin" "$ns1out" "ns1 <- ns2"; then
+	if ! check_transfer "$infile" "$ns1out" "ns1 <- ns2"; then
 		lret=1
 		ret=1
 	fi
@@ -370,14 +393,16 @@ test_tcp_forwarding_ip()
 
 test_tcp_forwarding()
 {
-	test_tcp_forwarding_ip "$1" "$2" 10.0.2.99 12345
+	local pmtu="$3"
+
+	test_tcp_forwarding_ip "$1" "$2" "$pmtu" 10.0.2.99 12345
 
 	return $?
 }
 
 test_tcp_forwarding_set_dscp()
 {
-	check_dscp "dscp_none"
+	local pmtu="$3"
 
 ip netns exec "$nsr1" nft -f - <<EOF
 table netdev dscpmangle {
@@ -388,8 +413,8 @@ table netdev dscpmangle {
 }
 EOF
 if [ $? -eq 0 ]; then
-	test_tcp_forwarding_ip "$1" "$2"  10.0.2.99 12345
-	check_dscp "dscp_ingress"
+	test_tcp_forwarding_ip "$1" "$2" "$3" 10.0.2.99 12345
+	check_dscp "dscp_ingress" "$pmtu"
 
 	ip netns exec "$nsr1" nft delete table netdev dscpmangle
 else
@@ -405,10 +430,10 @@ table netdev dscpmangle {
 }
 EOF
 if [ $? -eq 0 ]; then
-	test_tcp_forwarding_ip "$1" "$2"  10.0.2.99 12345
-	check_dscp "dscp_egress"
+	test_tcp_forwarding_ip "$1" "$2" "$pmtu"  10.0.2.99 12345
+	check_dscp "dscp_egress" "$pmtu"
 
-	ip netns exec "$nsr1" nft flush table netdev dscpmangle
+	ip netns exec "$nsr1" nft delete table netdev dscpmangle
 else
 	echo "SKIP: Could not load netdev:egress for veth1"
 fi
@@ -416,48 +441,53 @@ fi
 	# partial.  If flowtable really works, then both dscp-is-0 and dscp-is-cs3
 	# counters should have seen packets (before and after ft offload kicks in).
 	ip netns exec "$nsr1" nft -a insert rule inet filter forward ip dscp set cs3
-	test_tcp_forwarding_ip "$1" "$2"  10.0.2.99 12345
-	check_dscp "dscp_fwd"
+	test_tcp_forwarding_ip "$1" "$2" "$pmtu"  10.0.2.99 12345
+	check_dscp "dscp_fwd" "$pmtu"
 }
 
 test_tcp_forwarding_nat()
 {
+	local nsa="$1"
+	local nsb="$2"
+	local pmtu="$3"
+	local what="$4"
 	local lret
-	local pmtu
 
-	test_tcp_forwarding_ip "$1" "$2" 10.0.2.99 12345
-	lret=$?
+	[ "$pmtu" -eq 0 ] && what="$what (pmtu disabled)"
 
-	pmtu=$3
-	what=$4
+	test_tcp_forwarding_ip "$nsa" "$nsb" "$pmtu" 10.0.2.99 12345
+	lret=$?
 
 	if [ "$lret" -eq 0 ] ; then
 		if [ "$pmtu" -eq 1 ] ;then
-			check_counters "flow offload for ns1/ns2 with masquerade and pmtu discovery $what"
+			check_counters "flow offload for ns1/ns2 with masquerade $what"
 		else
 			echo "PASS: flow offload for ns1/ns2 with masquerade $what"
 		fi
 
-		test_tcp_forwarding_ip "$1" "$2" 10.6.6.6 1666
+		test_tcp_forwarding_ip "$1" "$2" "$pmtu" 10.6.6.6 1666
 		lret=$?
 		if [ "$pmtu" -eq 1 ] ;then
-			check_counters "flow offload for ns1/ns2 with dnat and pmtu discovery $what"
+			check_counters "flow offload for ns1/ns2 with dnat $what"
 		elif [ "$lret" -eq 0 ] ; then
 			echo "PASS: flow offload for ns1/ns2 with dnat $what"
 		fi
+	else
+		echo "FAIL: flow offload for ns1/ns2 with dnat $what"
 	fi
 
 	return $lret
 }
 
 make_file "$nsin" "$filesize"
+make_file "$nsin_small" "$filesize_small"
 
 # First test:
 # No PMTU discovery, nsr1 is expected to fragment packets from ns1 to ns2 as needed.
 # Due to MTU mismatch in both directions, all packets (except small packets like pure
 # acks) have to be handled by normal forwarding path.  Therefore, packet counters
 # are not checked.
-if test_tcp_forwarding "$ns1" "$ns2"; then
+if test_tcp_forwarding "$ns1" "$ns2" 0; then
 	echo "PASS: flow offloaded for ns1/ns2"
 else
 	echo "FAIL: flow offload for ns1/ns2:" 1>&2
@@ -489,8 +519,9 @@ table ip nat {
 }
 EOF
 
+check_dscp "dscp_none" "0"
 if ! test_tcp_forwarding_set_dscp "$ns1" "$ns2" 0 ""; then
-	echo "FAIL: flow offload for ns1/ns2 with dscp update" 1>&2
+	echo "FAIL: flow offload for ns1/ns2 with dscp update and no pmtu discovery" 1>&2
 	exit 0
 fi
 
@@ -512,6 +543,14 @@ ip netns exec "$ns2" sysctl net.ipv4.ip_no_pmtu_disc=0 > /dev/null
 # are lower than file size and packets were forwarded via flowtable layer.
 # For earlier tests (large mtus), packets cannot be handled via flowtable
 # (except pure acks and other small packets).
+ip netns exec "$nsr1" nft reset counters table inet filter >/dev/null
+ip netns exec "$ns2"  nft reset counters table inet filter >/dev/null
+
+if ! test_tcp_forwarding_set_dscp "$ns1" "$ns2" 1 ""; then
+	echo "FAIL: flow offload for ns1/ns2 with dscp update and pmtu discovery" 1>&2
+	exit 0
+fi
+
 ip netns exec "$nsr1" nft reset counters table inet filter >/dev/null
 
 if ! test_tcp_forwarding_nat "$ns1" "$ns2" 1 ""; then
@@ -644,7 +683,7 @@ ip -net "$ns2" route del 192.168.10.1 via 10.0.2.1
 ip -net "$ns2" route add default via 10.0.2.1
 ip -net "$ns2" route add default via dead:2::1
 
-if test_tcp_forwarding "$ns1" "$ns2"; then
+if test_tcp_forwarding "$ns1" "$ns2" 1; then
 	check_counters "ipsec tunnel mode for ns1/ns2"
 else
 	echo "FAIL: ipsec tunnel mode for ns1/ns2"
@@ -668,7 +707,7 @@ if [ "$1" = "" ]; then
 	fi
 
 	echo "re-run with random mtus and file size: -o $o -l $l -r $r -s $filesize"
-	$0 -o "$o" -l "$l" -r "$r" -s "$filesize"
+	$0 -o "$o" -l "$l" -r "$r" -s "$filesize" || ret=1
 fi
 
 exit $ret
-- 
2.50.1




