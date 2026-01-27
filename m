Return-Path: <stable+bounces-211888-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MItgII0SeWkcvAEAu9opvQ
	(envelope-from <stable+bounces-211888-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 20:31:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C4299E30
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 20:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8CD493080BDB
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 19:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5446C36F429;
	Tue, 27 Jan 2026 19:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aj5aGBbl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127D536E465;
	Tue, 27 Jan 2026 19:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769542064; cv=none; b=V2MV4oiH/rAYRyvxbybr3twUx/A9F+5qtpO6cyUD1oMBOEwUWa5dTn7I+AaL8+9ZpHl8jfn3sP5CTNHp5EYGEgMff1blsrXzfbZXH9Cwr/oF46AL/tRcGWv2cfW2Q9cQ4UujOMzjbKy4PQZn48sb3vVZBeQ3uytiyR38+0ka1sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769542064; c=relaxed/simple;
	bh=1Kh7LSasfGndIOTYsv93QNash+ih3iVLeARY56QPYlI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sHk0dqiyug/2e94pdKjPKwAIcVoe7LpFpgPDb0ZY4iRR3EsfUKo7hFY9GlRphwsAtUw+lWpkPGiZ6G1ZK4H1z9BUvHXoREOlc+AUTxM+5nnkhynuIYsnJt5RdrH8tDhN73wG0YbEH9UQJorEzx6NBxlw5Vi55CjLCtaCpKfizck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aj5aGBbl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C17C116C6;
	Tue, 27 Jan 2026 19:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769542063;
	bh=1Kh7LSasfGndIOTYsv93QNash+ih3iVLeARY56QPYlI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Aj5aGBblXeVQ21mvcpYocBX7iYicPud/M63ZUdl0dvgCMZIH65NLD0tc75xZNbjZW
	 cypSRdI03OjlSUQJP/aalH0VXDwQjPhPkeskp8cGj4xeLeRh5rUHDMFGgazJbcPChd
	 RsPm62lFn+c5n/IdvESey8YWm8HKJwlU+Ny0zBhqTWaLCoZENlGN+6KQVi+JsodTDN
	 qs803YSiV7zPtc7A9UEA5+Y2Hsp5J4ZzV2UJ6rfUhWpiE9i4sysagaMlEgtU8wA33Z
	 ue0j7uPqPuYs2J5Bo9QhvJT+426eoxm4tIfY+5jwFZUGa8JRhddsN4Ian7uXJcEIr/
	 Dk0x4r7K4umqg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 27 Jan 2026 20:27:24 +0100
Subject: [PATCH net 2/5] selftests: mptcp: check no dup close events after
 error
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-net-mptcp-dup-nl-events-v1-2-7f71e1bc4feb@kernel.org>
References: <20260127-net-mptcp-dup-nl-events-v1-0-7f71e1bc4feb@kernel.org>
In-Reply-To: <20260127-net-mptcp-dup-nl-events-v1-0-7f71e1bc4feb@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3543; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=1Kh7LSasfGndIOTYsv93QNash+ih3iVLeARY56QPYlI=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIrBZe1Loqf9GHOdHe79/uXr7vjLfRlwUnLzo1cEZkPy
 vbyesZydZSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEzkfTUjw8mb75l2HDvNzVhf
 +yg9n/PerbQo9h+x8v/4p6Um//tpJsfIcEbdU9HqVqP7O6Nyg+e/rlrsT2aZ01ggVrzvznzLvdM
 OswEA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211888-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: F1C4299E30
X-Rspamd-Action: no action

This validates the previous commit: subflow closed events are re-sent
with less info when the initial subflow is disconnected after an error
and each time a subflow is closed after that.

In this new test, the userspace PM is involved because that's how it was
discovered, but it is not specific to it. The initial subflow is
terminated with a RESET, and that will cause the subflow disconnect.
Then, a new subflow is initiated, but also got rejected, which cause a
second subflow closed event, but not a third one.

While at it, in case of failure to get the expected amount of events,
the events are printed.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: d82809b6c5f2 ("mptcp: avoid duplicated SUB_CLOSED events")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 51 +++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index b2e6e548f796..1765714a1e2f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3872,11 +3872,32 @@ chk_evt_nr()
 	count=$(grep -cw "type:${evt}" "${evts}")
 	if [ "${count}" != "${exp}" ]; then
 		fail_test "got ${count} events, expected ${exp}"
+		cat "${evts}"
 	else
 		print_ok
 	fi
 }
 
+# $1: ns ; $2: event type ; $3: expected count
+wait_event()
+{
+	local ns="${1}"
+	local evt_name="${2}"
+	local exp="${3}"
+
+	local evt="${!evt_name}"
+	local evts="${evts_ns1}"
+	local count
+
+	[ "${ns}" == "ns2" ] && evts="${evts_ns2}"
+
+	for _ in $(seq 100); do
+		count=$(grep -cw "type:${evt}" "${evts}")
+		[ "${count}" -ge "${exp}" ] && break
+		sleep 0.1
+	done
+}
+
 userspace_tests()
 {
 	# userspace pm type prevents add_addr
@@ -4085,6 +4106,36 @@ userspace_tests()
 		kill_events_pids
 		mptcp_lib_kill_group_wait $tests_pid
 	fi
+
+	# userspace pm no duplicated spurious close events after an error
+	if reset_with_events "userspace pm no dup close events after error" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+		set_userspace_pm $ns2
+		pm_nl_set_limits $ns1 0 2
+		{ timeout_test=120 test_linkfail=128 speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
+		local tests_pid=$!
+		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
+		userspace_pm_add_sf $ns2 10.0.3.2 20
+		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 2 2
+
+		# force quick loss
+		ip netns exec $ns2 sysctl -q net.ipv4.tcp_syn_retries=1
+		if ip netns exec "${ns1}" ${iptables} -A INPUT -s "10.0.1.2" \
+		      -p tcp --tcp-option 30 -j REJECT --reject-with tcp-reset &&
+		   ip netns exec "${ns2}" ${iptables} -A INPUT -d "10.0.1.2" \
+		      -p tcp --tcp-option 30 -j REJECT --reject-with tcp-reset; then
+			wait_event ns2 MPTCP_LIB_EVENT_SUB_CLOSED 1
+			wait_event ns1 MPTCP_LIB_EVENT_SUB_CLOSED 1
+			chk_subflows_total 1 1
+			userspace_pm_add_sf $ns2 10.0.1.2 0
+			wait_event ns2 MPTCP_LIB_EVENT_SUB_CLOSED 2
+			chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 2
+		fi
+		kill_events_pids
+		mptcp_lib_kill_group_wait $tests_pid
+	fi
 }
 
 endpoint_tests()

-- 
2.51.0


