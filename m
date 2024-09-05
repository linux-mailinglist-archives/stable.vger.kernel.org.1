Return-Path: <stable+bounces-73611-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7FA96DC31
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 16:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 941291F248CF
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 14:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F114D17BA7;
	Thu,  5 Sep 2024 14:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNZpDhKe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C6A17993;
	Thu,  5 Sep 2024 14:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725547462; cv=none; b=JvXIWW0pxZhXywbsm8+b778z9ZNOOlmD+MfEI6Tmdx59i72zZGowRiovqrpLS7/s/qT7nD+dcLokb5j3yaDmbudBnNYBil/4TVEvjbV1MtqgSw+DoxxB6qtLWFpwddgiWr6Myo2M2013pvYhPrP10lkIrlSWt0QkD3xjebkz7kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725547462; c=relaxed/simple;
	bh=fpEFvGFFag+780ZtAtou5COobtQgLFMZvq33imMF7vE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hhV60tYGzzURCQBAfIFs7o21ZCZPfqND4Z++HHIOuapzbvxtyZxbbMS/f7uWoWOQAmfVc4DsZEZ2I29aTMygm4cHBmmv5mMIURyYPVa4xiQdmZNRcacdB4Uaa4X8wC6vonXA7IgAtgaiRWDkxk88ZUBzn8Z+6yl5yrKabspboYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNZpDhKe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394BEC4CEC3;
	Thu,  5 Sep 2024 14:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725547462;
	bh=fpEFvGFFag+780ZtAtou5COobtQgLFMZvq33imMF7vE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KNZpDhKefNgnr+uT082YhG/QffEUcc2HcJsYNaJU7jQB2bzxwuzcQOvJfGZdlxMUL
	 2ll+uwCj9W2Q42YmcyNZIXUjDKbGM447SmkCl4hyG7wzufBw1SPkyKz5iooRZR0IUi
	 Z4jTzYUv1zTk1e7+3DSLOSugwWwKuwvHGP4WnIwmK/J7JTzvzWk7lYH1RIwtjrYwub
	 KhRe/J6y0Kxdj04jtzSGFRtHYorBO+QmfZR5QXPfT9rZpvB/84kaibeVoxTLZ8ur6/
	 tlQ0B/SixLBWqxqPFBgIl21BJLgQCEQYpn58gWkORJQvZXjaeIqIj6P504OvDZVNLB
	 Z2EtyFnciYorQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH 6.1.y 1/3] selftests: mptcp: fix backport issues
Date: Thu,  5 Sep 2024 16:43:08 +0200
Message-ID: <20240905144306.1192409-6-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <220913e1-603f-4399-a595-bb602942161a@kernel.org>
References: <220913e1-603f-4399-a595-bb602942161a@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5640; i=matttbe@kernel.org; h=from:subject; bh=fpEFvGFFag+780ZtAtou5COobtQgLFMZvq33imMF7vE=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm2cN7jhYayKCcGfLO2rOLq1yHa4sI8wHxmb/XL 3dSwWJVwvCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtnDewAKCRD2t4JPQmmg c8h5D/0f4821ukpAoleb2jllENuZQ+OibLAopyE8Khl7j7CGu1duItkGXCL+/tnXmLH27rWuZJD xKLgwTt60ZzCLU/ki+QbYyFvElXEA4v5u0Sw7JQ2G2zf8WW1ZyPhucTRnSZ9eMeWUL4YBS1sbpt 1ls3PCS5nqlrO4U6gkhExtYavz2Yf9AQi/tHrDezgAMpN8of60ahygOEAqwAPP4p9xOXFsBtSXI 7lpanDT5waMTRKwUOaCvL+J6Wn9XGZCK1SZDig6i3llGSVHatktqiOsP36XB6KWDaMd17Rz7N7P jIHR2ibmCgCAM6LFYmQgFJ29uClCoJUIgebowkdVka55N6GtNShuVVReTdtv2z8G1J/xpPjmeNR lB3mfpz4f2hgdi5uFiWlHgP8ircvNCEPGEZenFcfQ341HcGbtBva/8VG9PcHiKXW4cIYjxbGFyy sDy8T0x+rX6HgyUtt6LJSWuaYmlLtIjFeBhfM74Koy4kOteM0dYQObnuicICt4xZbOJwsobESRw C8MCsDTRuV6lMwV0yYiMj0QWoSPJ2hYf5fmBBYYaXyY7KwKIwqzfb0HTd52+/4O0NEvWh9JG7hg BmiEcVHnfqU/f7UlR2DJZYrhphrqYKIhjoGqwiXVhoWRKMECZGvpjTugFuXKN7VGnjNV0P5XISJ CJpQgJUenjtpanA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

By accident, some patches modifying the MPTCP selftests have been
applied twice, using different versions of the patch [1].

These patches have been dropped, but it looks like quilt incorrectly
handled that by placing the new subtests at the wrong place: in
userspace_tests() instead of endpoint_tests(). That caused a few other
patches not to apply properly.

Not to have to revert and re-apply patches, this issue can be fixed by
moving some code around.

Link: https://lore.kernel.org/fc21db4a-508d-41db-aa45-e3bc06d18ce7@kernel.org [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 138 +++++++++---------
 1 file changed, 69 insertions(+), 69 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 33c002c26604..11585510695e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3236,75 +3236,6 @@ userspace_tests()
 		chk_join_nr 1 1 1
 		chk_rm_nr 0 1
 	fi
-
-	# remove and re-add
-	if reset "delete re-add signal" &&
-	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
-		pm_nl_set_limits $ns1 0 3
-		pm_nl_set_limits $ns2 3 3
-		pm_nl_add_endpoint $ns1 10.0.2.1 id 1 flags signal
-		# broadcast IP: no packet for this address will be received on ns1
-		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
-		pm_nl_add_endpoint $ns1 10.0.1.1 id 42 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_20 2>/dev/null &
-		local tests_pid=$!
-
-		wait_mpj $ns2
-		chk_subflow_nr needtitle "before delete" 2
-
-		pm_nl_del_endpoint $ns1 1 10.0.2.1
-		pm_nl_del_endpoint $ns1 2 224.0.0.1
-		sleep 0.5
-		chk_subflow_nr "" "after delete" 1
-
-		pm_nl_add_endpoint $ns1 10.0.2.1 id 1 flags signal
-		pm_nl_add_endpoint $ns1 10.0.3.1 id 2 flags signal
-		wait_mpj $ns2
-		chk_subflow_nr "" "after re-add" 3
-
-		pm_nl_del_endpoint $ns1 42 10.0.1.1
-		sleep 0.5
-		chk_subflow_nr "" "after delete ID 0" 2
-
-		pm_nl_add_endpoint $ns1 10.0.1.1 id 99 flags signal
-		wait_mpj $ns2
-		chk_subflow_nr "" "after re-add" 3
-		kill_tests_wait
-
-		chk_join_nr 4 4 4
-		chk_add_nr 5 5
-		chk_rm_nr 3 2 invert
-	fi
-
-	# flush and re-add
-	if reset_with_tcp_filter "flush re-add" ns2 10.0.3.2 REJECT OUTPUT &&
-	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
-		pm_nl_set_limits $ns1 0 2
-		pm_nl_set_limits $ns2 1 2
-		# broadcast IP: no packet for this address will be received on ns1
-		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
-		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_20 2>/dev/null &
-		local tests_pid=$!
-
-		wait_attempt_fail $ns2
-		chk_subflow_nr needtitle "before flush" 1
-
-		pm_nl_flush_endpoint $ns2
-		pm_nl_flush_endpoint $ns1
-		wait_rm_addr $ns2 0
-		ip netns exec "${ns2}" ${iptables} -D OUTPUT -s "10.0.3.2" -p tcp -j REJECT
-		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
-		wait_mpj $ns2
-		pm_nl_add_endpoint $ns1 10.0.3.1 id 2 flags signal
-		wait_mpj $ns2
-		kill_wait "${tests_pid}"
-		kill_tests_wait
-
-		chk_join_nr 2 2 2
-		chk_add_nr 2 2
-		chk_rm_nr 1 0 invert
-	fi
 }
 
 endpoint_tests()
@@ -3375,6 +3306,75 @@ endpoint_tests()
 		chk_join_nr 6 6 6
 		chk_rm_nr 4 4
 	fi
+
+	# remove and re-add
+	if reset "delete re-add signal" &&
+	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+		pm_nl_set_limits $ns1 0 3
+		pm_nl_set_limits $ns2 3 3
+		pm_nl_add_endpoint $ns1 10.0.2.1 id 1 flags signal
+		# broadcast IP: no packet for this address will be received on ns1
+		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
+		pm_nl_add_endpoint $ns1 10.0.1.1 id 42 flags signal
+		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_20 2>/dev/null &
+		local tests_pid=$!
+
+		wait_mpj $ns2
+		chk_subflow_nr needtitle "before delete" 2
+
+		pm_nl_del_endpoint $ns1 1 10.0.2.1
+		pm_nl_del_endpoint $ns1 2 224.0.0.1
+		sleep 0.5
+		chk_subflow_nr "" "after delete" 1
+
+		pm_nl_add_endpoint $ns1 10.0.2.1 id 1 flags signal
+		pm_nl_add_endpoint $ns1 10.0.3.1 id 2 flags signal
+		wait_mpj $ns2
+		chk_subflow_nr "" "after re-add" 3
+
+		pm_nl_del_endpoint $ns1 42 10.0.1.1
+		sleep 0.5
+		chk_subflow_nr "" "after delete ID 0" 2
+
+		pm_nl_add_endpoint $ns1 10.0.1.1 id 99 flags signal
+		wait_mpj $ns2
+		chk_subflow_nr "" "after re-add" 3
+		kill_tests_wait
+
+		chk_join_nr 4 4 4
+		chk_add_nr 5 5
+		chk_rm_nr 3 2 invert
+	fi
+
+	# flush and re-add
+	if reset_with_tcp_filter "flush re-add" ns2 10.0.3.2 REJECT OUTPUT &&
+	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 1 2
+		# broadcast IP: no packet for this address will be received on ns1
+		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
+		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
+		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_20 2>/dev/null &
+		local tests_pid=$!
+
+		wait_attempt_fail $ns2
+		chk_subflow_nr needtitle "before flush" 1
+
+		pm_nl_flush_endpoint $ns2
+		pm_nl_flush_endpoint $ns1
+		wait_rm_addr $ns2 0
+		ip netns exec "${ns2}" ${iptables} -D OUTPUT -s "10.0.3.2" -p tcp -j REJECT
+		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
+		wait_mpj $ns2
+		pm_nl_add_endpoint $ns1 10.0.3.1 id 2 flags signal
+		wait_mpj $ns2
+		kill_wait "${tests_pid}"
+		kill_tests_wait
+
+		chk_join_nr 2 2 2
+		chk_add_nr 2 2
+		chk_rm_nr 1 0 invert
+	fi
 }
 
 # [$1: error message]
-- 
2.45.2


