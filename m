Return-Path: <stable+bounces-215871-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MH5mDlfUjGm+tgAAu9opvQ
	(envelope-from <stable+bounces-215871-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 20:11:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC3E127128
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 20:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEBBE3020017
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 19:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99851352FBF;
	Wed, 11 Feb 2026 19:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNtsY1Iz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594EA346ADC;
	Wed, 11 Feb 2026 19:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770836822; cv=none; b=BIclupD32rKanEjG/5GM6UkrB59jcG5YLrVN9Gr6U9pNioJ/siw0ms9xS4p89I5G4TnIzuuDYHAHkHbsJvchV0gvL5iZ3ks08US+RET4FrJAIVmZanHmdD1hzoXIOYWdm4FKuDegqz9Cv8cwzZ+hcLx5gv8p6/rp9r3Zyn13krQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770836822; c=relaxed/simple;
	bh=VMMvFuctzIugS+JOh0W1dLNT4/NhATHAqY0+7G6/H3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GLzKIzvQda0ov9zxgxsXM+KHTgPtlSGqTVqpaLPLoYJxW9oBdwIvowb0mJ0aXdczM68zzF+Xuh4Gs33YHK/FyVGu4t8vdqyteaUmEis3ewfHWsLsJoxWiIHEULX5DEDWwluGMjg6v3pi3ZJOczYPBeU3YRY8g/07c5Lpw7DQ0UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNtsY1Iz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B255C19424;
	Wed, 11 Feb 2026 19:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770836821;
	bh=VMMvFuctzIugS+JOh0W1dLNT4/NhATHAqY0+7G6/H3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PNtsY1Iz+XjvKQy7n5hdrcRR3g2en9OV2UP0XOF/2Lz3ZNMAHqDeKgv0Tv04sVuLc
	 J+ZTlGf3bFdDSL/KlEpJM6ZhezkqEZ7OFaOpNruNruWEyoY382o+lZulB/mJEG5mob
	 muY+CtObhn6oP7nWrrbUqEl5QoD57gWXHq1wRnaI0W+q52eFrAXXllNe2kJzhCQvkx
	 E/u8FYclEipnqvrxn1Gf+i+ZXNLJr6HxVoUFbaXwekwW0kbYlDCGHs9PmfGPSiPi/e
	 B3b/855lx4cBtfioJKA3no9h0NBFiNAfyKHUcU19Pk4OQ/AblXvaowCvMTE2LXITX0
	 HE0k+IgHm5VWg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org,
	Geliang Tang <geliang@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y 4/6] selftests: mptcp: check no dup close events after error
Date: Wed, 11 Feb 2026 20:06:22 +0100
Message-ID: <20260211190617.77192-12-matttbe@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211190617.77192-8-matttbe@kernel.org>
References: <20260211190617.77192-8-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5019; i=matttbe@kernel.org; h=from:subject; bh=VMMvFuctzIugS+JOh0W1dLNT4/NhATHAqY0+7G6/H3I=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJ7LuuvLD3ct6AiJa/3KotP0JU7ctzVHnPUT86L/FS2w uuxxqLmjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIlsNGf4p/XHb/nFzvKfii4T FwQn/hKZ5z9Rf8aUI199GPedrv6zz5KR4Vf97ZCjubOl34t0P32ctnmx4WuvLCf7DSzpLNJJW6Y IcwEA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-215871-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 9DC3E127128
X-Rspamd-Action: no action

commit 8467458dfa61b37e259e3485a5d3e415d08193c1 upstream.

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
[ Conflicts in mptcp_join.sh, because in this version, commit
  20ccc7c5f7a3 ("selftests: mptcp: join: validate event numbers") has
  been backported with adaptations to display results correctly, see
  commit 5dc9170eee96 ("selftests: mptcp: join: validate event numbers")
  for more details. The same type of adaptations had to be made here as
  well, plus importing a few additional helpers: userspace_pm_add_sf,
  evts_get_info and get_info_value. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 9f73297b69da..f5ae51dcf811 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3183,6 +3183,35 @@ fail_tests()
 	fi
 }
 
+# get the value of keyword $1 in the line marked by keyword $2
+get_info_value() {
+	grep "${2}" 2>/dev/null |
+		sed -n 's/.*\('"${1}"':\)\([0-9a-f:.]*\).*$/\2/p;q'
+		# the ';q' at the end limits to the first matched entry.
+}
+
+# $1: info name ; $2: evts_ns ; [$3: event type; [$4: addr]]
+evts_get_info() {
+	grep "${4:-}" "${2}" 2>/dev/null |
+		get_info_value "${1}" "^type:${3:-1},"
+}
+
+# $1: ns ; $2: addr ; $3: id
+userspace_pm_add_sf()
+{
+	local evts=$evts_ns1
+	local tk da dp
+
+	[ "$1" == "$ns2" ] && evts=$evts_ns2
+	tk=$(evts_get_info token "$evts")
+	da=$(evts_get_info daddr4 "$evts")
+	dp=$(evts_get_info dport "$evts")
+
+	ip netns exec $1 ./pm_nl_ctl csf lip $2 lid $3 \
+				rip $da rport $dp token $tk
+	sleep 1
+}
+
 # $1: ns ; $2: event type ; $3: count
 chk_evt_nr()
 {
@@ -3204,11 +3233,32 @@ chk_evt_nr()
 		echo "[fail] got $count events, expected $exp"
 		fail_test
 		dump_stats
+		cat "${evts}"
 	else
 		echo "[ ok ]"
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
@@ -3302,6 +3352,35 @@ userspace_tests()
 		chk_join_nr 1 1 1
 		chk_rm_nr 0 1
 	fi
+
+	# userspace pm no duplicated spurious close events after an error
+	if reset_with_events "userspace pm no dup close events after error" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+		set_userspace_pm $ns2
+		pm_nl_set_limits $ns1 0 2
+		run_tests $ns1 $ns2 10.0.1.1 128 0 0 slow 2>/dev/null &
+		local tests_pid=$!
+		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
+		userspace_pm_add_sf $ns2 10.0.3.2 20
+		chk_subflow_nr needtitle "new subflow" 2
+
+		# force quick loss
+		ip netns exec $ns2 sysctl -q net.ipv4.tcp_syn_retries=1
+		if ip netns exec "${ns1}" ${iptables} -A INPUT -s "10.0.1.2" \
+		      -p tcp --tcp-option 30 -j REJECT --reject-with tcp-reset &&
+		   ip netns exec "${ns2}" ${iptables} -A INPUT -d "10.0.1.2" \
+		      -p tcp --tcp-option 30 -j REJECT --reject-with tcp-reset; then
+			wait_event ns2 MPTCP_LIB_EVENT_SUB_CLOSED 1
+			wait_event ns1 MPTCP_LIB_EVENT_SUB_CLOSED 1
+			chk_subflow_nr "" "after reject" 1
+			userspace_pm_add_sf $ns2 10.0.1.2 0
+			wait_event ns2 MPTCP_LIB_EVENT_SUB_CLOSED 2
+			chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 2
+		fi
+		kill_wait "${tests_pid}"
+		kill_events_pids
+		kill_tests_wait
+	fi
 }
 
 endpoint_tests()
-- 
2.51.0


