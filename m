Return-Path: <stable+bounces-13349-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C5A837B81
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5D47281F25
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEBF1353E2;
	Tue, 23 Jan 2024 00:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c4eMIt34"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797501350F9;
	Tue, 23 Jan 2024 00:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969355; cv=none; b=SYm2WZJiN34XguJJLtcBH2X+LjcMtfjX6jXyMsZavo/AqdluOHAj5u30am0/AZEPdpo8E3s7BA4/dbRCa3fO1JdwznNnUx2hO2ZIy/NotCiV36d+N0Ym7u2LsTTRF44q245jAgHJm3R0AwFNbS3jKtshNS6BDfaVrHfxZAXJc+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969355; c=relaxed/simple;
	bh=LL85P5GR4gxVSvvi/HpofaknJwJufrRarvt2gqu73DY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZE/6uF+9mT9+4sQsFiFlcbIhysCL1Sy3WE2Cls/v/R2CiMLrLm1ZRFED/IfP512kXwwDUpcy/BwCo/ieCCDWHf/YcXHAWCfHwSV+gVC30GcL3KU88CUOFsXjDaMqsLI3CS+D+9MkyfBpf3qjIEhZJB3hMs13IZewvVngfc0inZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c4eMIt34; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 113DDC433F1;
	Tue, 23 Jan 2024 00:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705969355;
	bh=LL85P5GR4gxVSvvi/HpofaknJwJufrRarvt2gqu73DY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c4eMIt34Z21MjmtHCu4oC+redE/BqGhM9vMndP4w3+4T6t7ROocEdDEhLD+HaHCkn
	 I+IuIjTuh42tVAgom0YlZuKZP2Wvn1z3iUDAWiXl2+HwpDNPiO1omiAKg7Q3mFaJ3N
	 gN2GGXDTE1QNPZu0dBRzfJieNrr0s+RunprZA2h0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hangbin Liu <liuhangbin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 184/641] selftests/net: fix grep checking for fib_nexthop_multiprefix
Date: Mon, 22 Jan 2024 15:51:28 -0800
Message-ID: <20240122235823.747838935@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235818.091081209@linuxfoundation.org>
References: <20240122235818.091081209@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit a33e9da3470499e9ff476138f271fb52d6bfe767 ]

When running fib_nexthop_multiprefix test I saw all IPv6 test failed.
e.g.

 ]# ./fib_nexthop_multiprefix.sh
 TEST: IPv4: host 0 to host 1, mtu 1300                              [ OK ]
 TEST: IPv6: host 0 to host 1, mtu 1300                              [FAIL]

 With -v it shows

 COMMAND: ip netns exec h0 /usr/sbin/ping6 -s 1350 -c5 -w5 2001:db8:101::1
 PING 2001:db8:101::1(2001:db8:101::1) 1350 data bytes
 From 2001:db8:100::64 icmp_seq=1 Packet too big: mtu=1300

 --- 2001:db8:101::1 ping statistics ---
 1 packets transmitted, 0 received, +1 errors, 100% packet loss, time 0ms

 Route get
 2001:db8:101::1 via 2001:db8:100::64 dev eth0 src 2001:db8:100::1 metric 1024 expires 599sec mtu 1300 pref medium
 Searching for:
     2001:db8:101::1 from :: via 2001:db8:100::64 dev eth0 src 2001:db8:100::1 .* mtu 1300

The reason is when CONFIG_IPV6_SUBTREES is not enabled, rt6_fill_node() will
not put RTA_SRC info. After fix:

]# ./fib_nexthop_multiprefix.sh
TEST: IPv4: host 0 to host 1, mtu 1300                              [ OK ]
TEST: IPv6: host 0 to host 1, mtu 1300                              [ OK ]

Fixes: 735ab2f65dce ("selftests: Add test with multiple prefixes using single nexthop")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Link: https://lore.kernel.org/r/20231213060856.4030084-7-liuhangbin@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/fib_nexthop_multiprefix.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/fib_nexthop_multiprefix.sh b/tools/testing/selftests/net/fib_nexthop_multiprefix.sh
index 51df5e305855..b52d59547fc5 100755
--- a/tools/testing/selftests/net/fib_nexthop_multiprefix.sh
+++ b/tools/testing/selftests/net/fib_nexthop_multiprefix.sh
@@ -209,12 +209,12 @@ validate_v6_exception()
 		echo "Route get"
 		ip -netns h0 -6 ro get ${dst}
 		echo "Searching for:"
-		echo "    ${dst} from :: via ${r1} dev eth0 src ${h0} .* mtu ${mtu}"
+		echo "    ${dst}.* via ${r1} dev eth0 src ${h0} .* mtu ${mtu}"
 		echo
 	fi
 
 	ip -netns h0 -6 ro get ${dst} | \
-	grep -q "${dst} from :: via ${r1} dev eth0 src ${h0} .* mtu ${mtu}"
+	grep -q "${dst}.* via ${r1} dev eth0 src ${h0} .* mtu ${mtu}"
 	rc=$?
 
 	log_test $rc 0 "IPv6: host 0 to host ${i}, mtu ${mtu}"
-- 
2.43.0




