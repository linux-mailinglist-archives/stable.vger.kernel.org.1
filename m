Return-Path: <stable+bounces-72804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDDD969A0E
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 12:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D7B02844DE
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 10:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8131B9834;
	Tue,  3 Sep 2024 10:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibzhPEsi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662D31AD278;
	Tue,  3 Sep 2024 10:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725359036; cv=none; b=h/3DXtEWDENb4n67+QviMXW4dYGnm/DmnevcQJe3j1SCQ7mjUUmiZB14u6jgJMovDm32/0Vg/8DtyluaJC/dmric9pfolawEYQ/kyRGr6Kb+8t6vbtCLPzj/5TR8YAsY8F+JTNCBOGmCTd8ffVpf6DVQmuX+/e5JZQqS3+4FLxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725359036; c=relaxed/simple;
	bh=rV1vjGTjzOzwSExTkJWvWtoeOAWlAaMiYtcR6b02Oaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQmMPhIkYA92pkwGfXS3YTrQ59fA/zPESQBRvhiqIse5jXCb7fNrE4AgeiAW6Kr8aqyLMu/95PRRRtUUWYsZ1BObTZEPc5qhYJFxUvbaopk6oGttt3TsLPIUrFkqdGo9AGO0Y5xmazLrHUTV5bXZdJBVdJEBduzaiS2Iat296jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibzhPEsi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68032C4AF09;
	Tue,  3 Sep 2024 10:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725359035;
	bh=rV1vjGTjzOzwSExTkJWvWtoeOAWlAaMiYtcR6b02Oaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ibzhPEsiO2l37oZY3nVLCYEc5mzeKHF1XafNyL9LOLN76Pvj7t3FWD3l8OQZskSEI
	 YkJewi9cTkSTQmiTTBhU/Q0brOEIJspKsxBMBqjfHTx0gH1njjulxP9rFU4NhO3c0W
	 ENXgzegcQ+1eHORfiTxFAOgZw1B2oZhUSsfZ6SZKdZ2gm7pBlXgMCV7x8Ops+Q6c+S
	 7ozIJtPHSrl9H4tOuZ8+1UJ2oQuAaGtMthYMuDXk5R+wcGkWtF1htGX5wAwjDDtuKC
	 gyaobG6VJ8lFd81gw9bmAQZy3D/0E7x98uJeBWUEr/j14zOhnnlc5QgXL36ZkHo/VZ
	 Gl/bt61V90WNA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Matthieu Baerts <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y 1/3] selftests: mptcp: add mptcp_lib_events helper
Date: Tue,  3 Sep 2024 12:23:49 +0200
Message-ID: <20240903102347.3384947-6-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024083025-ruined-stupor-4967@gregkh>
References: <2024083025-ruined-stupor-4967@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4014; i=matttbe@kernel.org; h=from:subject; bh=/K1q5LfgKWfWfkdCD0RDAGHV3/LjT2CFFxSixQnB9Ro=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm1uOzZGNSOKmlNvGWvcOp1X/4xddSjfzQBK86P 2z1qVRI4YiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtbjswAKCRD2t4JPQmmg c2D2EADu9bJCnDVng7Ko9gtcPZLM0OHNHdysNa8r/ag3vc5kXJ1xhwSc1h523kDBJFVlorz4Pso Bs0ldTWp6h7dQPUN6f41+uPHMqOK+W3On8TqiBZUFjY7J3r+YD4gSrkwdgyOoextYJgOFW3ZgHD 1rmMgY5Z2YwvMRL4aOb2XRFs+TZ1nQUF7AkAmD4R9TZK/rEC3t/srybvseyRtkpBh9SUpE9x/fa Lp0rp3CyHv915sR3DcQclumm8V9xTCZemYWmzYTbJLg69BqKR6HfCd4HGZIngyJdX1GDh+NAa4T YRESWhx+K4Xzrx7X5/hcSiNbalI7S4wpbty+Yow09JWi1D0AN2giseRT2pTo6sE+ATo5+wz8+/5 pjwb1TDyWiR4FIUO+x30IojU30AD1UNULq+5zOmssvEuJ1FFORsVSlDIwdRyKrPloeTSzT2ozaA gVWdQX6VDhyCX6Rx+HNHhBYcRXu6qNFUzgkBvxLRwDQvxwFau9AelzJubvoZk1lkj9lms04wspQ ug89ytTNTgIS9iXuxqW3h9KyUrnEqLgja4aPz/05SUspSJDwZPUCw4eF4htli7c388FM/+n9ezs 0Ka++7s+1Z9fbpc9yg2O2JuZ4qBfem4YstmZdxadKpp22sujcfjgKBIAgbtMknodyYUJdKajU7U up4E/VmjrAvyxog==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

commit 35bc143a8514ee72b2e9d6b8b385468608b93a53 upstream.

To avoid duplicated code in different MPTCP selftests, we can add and
use helpers defined in mptcp_lib.sh.

This patch unifies "pm_nl_ctl events" related code in userspace_pm.sh
and mptcp_join.sh into a helper mptcp_lib_events(). Define it in
mptcp_lib.sh and use it in both scripts.

Note that mptcp_lib_kill_wait is now call before starting 'events' for
mptcp_join.sh as well, but that's fine: each test is started from a new
netns, so there will not be any existing pid there, and nothing is done
when mptcp_lib_kill_wait is called with 0.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://lore.kernel.org/r/20240306-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v2-6-bc79e6e5e6a0@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 20ccc7c5f7a3 ("selftests: mptcp: join: validate event numbers")
[ Conflicts in mptcp_lib.sh, because the context is different at the end
  of the file, where the new helper is supposed to go. The new helper
  has simply be added at the end. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh   | 10 ++++------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh    | 12 ++++++++++++
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 14 ++------------
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 176790507019..12a5daf6dc10 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -465,12 +465,8 @@ reset_with_events()
 {
 	reset "${1}" || return 1
 
-	:> "$evts_ns1"
-	:> "$evts_ns2"
-	ip netns exec $ns1 ./pm_nl_ctl events >> "$evts_ns1" 2>&1 &
-	evts_ns1_pid=$!
-	ip netns exec $ns2 ./pm_nl_ctl events >> "$evts_ns2" 2>&1 &
-	evts_ns2_pid=$!
+	mptcp_lib_events "${ns1}" "${evts_ns1}" evts_ns1_pid
+	mptcp_lib_events "${ns2}" "${evts_ns2}" evts_ns2_pid
 }
 
 reset_with_tcp_filter()
@@ -669,7 +665,9 @@ wait_mpj()
 kill_events_pids()
 {
 	mptcp_lib_kill_wait $evts_ns1_pid
+	evts_ns1_pid=0
 	mptcp_lib_kill_wait $evts_ns2_pid
+	evts_ns2_pid=0
 }
 
 pm_nl_set_limits()
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 8939d5c135a0..000a9f7c018c 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -247,3 +247,15 @@ mptcp_lib_get_counter() {
 
 	echo "${count}"
 }
+
+mptcp_lib_events() {
+	local ns="${1}"
+	local evts="${2}"
+	declare -n pid="${3}"
+
+	:>"${evts}"
+
+	mptcp_lib_kill_wait "${pid:-0}"
+	ip netns exec "${ns}" ./pm_nl_ctl events >> "${evts}" 2>&1 &
+	pid=$!
+}
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 4e5829155049..bb0fa1a3b124 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -201,21 +201,11 @@ make_connection()
 	if [ -z "$client_evts" ]; then
 		client_evts=$(mktemp)
 	fi
-	:>"$client_evts"
-	if [ $client_evts_pid -ne 0 ]; then
-		mptcp_lib_kill_wait $client_evts_pid
-	fi
-	ip netns exec "$ns2" ./pm_nl_ctl events >> "$client_evts" 2>&1 &
-	client_evts_pid=$!
+	mptcp_lib_events "${ns2}" "${client_evts}" client_evts_pid
 	if [ -z "$server_evts" ]; then
 		server_evts=$(mktemp)
 	fi
-	:>"$server_evts"
-	if [ $server_evts_pid -ne 0 ]; then
-		mptcp_lib_kill_wait $server_evts_pid
-	fi
-	ip netns exec "$ns1" ./pm_nl_ctl events >> "$server_evts" 2>&1 &
-	server_evts_pid=$!
+	mptcp_lib_events "${ns1}" "${server_evts}" server_evts_pid
 	sleep 0.5
 
 	# Run the server
-- 
2.45.2


