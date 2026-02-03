Return-Path: <stable+bounces-213216-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAZiO67ugWlAMwMAu9opvQ
	(envelope-from <stable+bounces-213216-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 13:48:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C26CD94C2
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 13:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BEE7B3085DFE
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 12:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4668934029C;
	Tue,  3 Feb 2026 12:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vpK6zR78"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A95B154425
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 12:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770122846; cv=none; b=NiesoKwyJD3WCGAQttp6LL9VvcIO8yC4ZD8J1yjQpKnZ8YL4H8uyFmqJgM6AzxxRPOFGzHYTzo8w4lJtMJdS9bk5rvpN0rdZd52vY3LacFxJRW3nmL4na7fKAfqDimL9/jq6u5B6ReCDGoFt5lwD8c+8RIkM7RJ8xhKWZk2Udac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770122846; c=relaxed/simple;
	bh=wXsoleApGkoecFPFqaYTh6hDl9ecu90h0w3xAR2puVs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZHKrvnfSu1QwZHjddhEDnVSUfGgPRQ02HmNR4dAnSj9lB9Jmtu4Dnwbq8iA0mQmtwzVrKf6LzaMtIUhmQsJ9P8dm0H+LYs+lSU2nWkIcIcFwTsxAj9UWVaXtMa3lAZzYJXHGQt1gzO5F70bCfy7DCR1Lam5wX9dJxJqHEQtF16E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vpK6zR78; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B95C116D0;
	Tue,  3 Feb 2026 12:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770122845;
	bh=wXsoleApGkoecFPFqaYTh6hDl9ecu90h0w3xAR2puVs=;
	h=Subject:To:Cc:From:Date:From;
	b=vpK6zR78tLPHFcIvmzIqFWO/Mn1DwggW9DqDM75MJ/lRD1QRk2nGDxicW1VGGytrx
	 yZoBAjTNRIv1rIP5KAjzJKwxWH2rUbTgGWO8A2sIrbc+L8i+4jGWM60PPcogZAnzfI
	 UzQrpcLrGtlYEVCtQ8LFEKzN4elPcQq5v/6l9rYs=
Subject: FAILED: patch "[PATCH] selftests: mptcp: check no dup close events after error" failed to apply to 6.1-stable tree
To: matttbe@kernel.org,geliang@kernel.org,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Feb 2026 13:47:14 +0100
Message-ID: <2026020314-crane-crying-d547@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213216-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gregkh:email,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: 6C26CD94C2
X-Rspamd-Action: no action


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 8467458dfa61b37e259e3485a5d3e415d08193c1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026020314-crane-crying-d547@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8467458dfa61b37e259e3485a5d3e415d08193c1 Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 27 Jan 2026 20:27:24 +0100
Subject: [PATCH] selftests: mptcp: check no dup close events after error

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
Link: https://patch.msgid.link/20260127-net-mptcp-dup-nl-events-v1-2-7f71e1bc4feb@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

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


