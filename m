Return-Path: <stable+bounces-215872-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOo+G13TjGm+tgAAu9opvQ
	(envelope-from <stable+bounces-215872-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 20:07:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D7D12707C
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 20:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16AF130185A0
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 19:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A837E346ADC;
	Wed, 11 Feb 2026 19:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K27vIPzB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C32347BBD;
	Wed, 11 Feb 2026 19:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770836824; cv=none; b=d9AWdSxGtH44xDdXhuY2MJuVPtfWM/WXz0sEVl0Q6RhW/WG8i1xlfxif8U/g/8hF/LgUTTAAjKzQIq37L1BqXegilU0rVa5NBexQWqdxRQjmEu8C8PA4RBAtzYUSoo1pGRR4wC1gIidv6oJdeiWomOCoSR4IMrShQOP2YIF2HCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770836824; c=relaxed/simple;
	bh=6gFMK2Vf97i3HtqOLYHeDgbtTbc1n1AgCHsY6Wvr8yI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tm887FqdWPFqgw9nMLXtk6tWT/p9sFH+DcFAStqa0tV6mdFF+Hmqa+/yzfYElMrGChB3ph5ktdKubLQBRVHS48RnpiiIj2wl7QIQtOjG5c9dKKeba4qbu8kGtsD8MRSJsdleIBsPCcDXiHY3wT3OEcoDmqjT8pHtfG6GhPWhug0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K27vIPzB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A50B5C4CEF7;
	Wed, 11 Feb 2026 19:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770836824;
	bh=6gFMK2Vf97i3HtqOLYHeDgbtTbc1n1AgCHsY6Wvr8yI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K27vIPzBZaxwAHo6xM1REpmyJ+A9PHn5WZg2IE9SlcLB1DjkTRZPVNy7vWmquQ3o2
	 vbf/0P7YpgOtS72QUe3KCU1RUIzoeJYR3N8CQS81AzLdKosw/MjSx5/hziID5luGOq
	 vRDKtvy1jgHCaJgW/fZwvT1KSc4L4srHxdevR6VZUUwo+aPGnu8rj7TejnA3ycN348
	 77yy3RZr7oQ2O61nNeMpawPbmjsGUN2mAfyDkvhybJOLHpdmwxTslwHxYdAyCXMw0d
	 aNxkg6qoui/HZ600mr6I2b4dJ1TmPVka/Q7CFmbudvReb7P7znDy1GP26LxsF9EqCR
	 JrMvsTcYSPuGg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org,
	Geliang Tang <geliang@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y 5/6] selftests: mptcp: check subflow errors in close events
Date: Wed, 11 Feb 2026 20:06:23 +0100
Message-ID: <20260211190617.77192-13-matttbe@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211190617.77192-8-matttbe@kernel.org>
References: <20260211190617.77192-8-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3369; i=matttbe@kernel.org; h=from:subject; bh=6gFMK2Vf97i3HtqOLYHeDgbtTbc1n1AgCHsY6Wvr8yI=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJ7Lhskd0XvqD0krq4SOVGxMbcmwvVpkalKYvSc3+6Hd ZMPnzXuKGVhEONikBVTZJFui8yf+byKt8TLzwJmDisTyBAGLk4BmEhHCMMfrhU3dp1Nv++V6xVs 6aRxJ1ki7XOo8pGWvsyV8/bvXuypzMjwoiBVrjBvW+Vaj18yfo5fM4reznlWoSjkdkr2nQlvTzs fAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-215872-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: C2D7D12707C
X-Rspamd-Action: no action

commit 2ef9e3a3845d0a20b62b01f5b731debd0364688d upstream.

This validates the previous commit: subflow closed events should contain
an error field when a subflow got closed with an error, e.g. reset or
timeout.

For this test, the chk_evt_nr helper has been extended to check
attributes in the matched events.

In this test, the 2 subflow closed events should have an error.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 15cc10453398 ("mptcp: deliver ssk errors to msk")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260127-net-mptcp-dup-nl-events-v1-4-7f71e1bc4feb@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in mptcp_join.sh, because in this version, commit
  20ccc7c5f7a3 ("selftests: mptcp: join: validate event numbers") has
  been backported with adaptations to display results correctly, see
  commit 5dc9170eee96 ("selftests: mptcp: join: validate event numbers")
  for more details. The same type of adaptations had to be made here as
  well. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 25 ++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f5ae51dcf811..7d4df90d6281 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3212,21 +3212,28 @@ userspace_pm_add_sf()
 	sleep 1
 }
 
-# $1: ns ; $2: event type ; $3: count
+# $1: ns ; $2: event type ; $3: count ; [ $4: attr ; $5: attr count ]
 chk_evt_nr()
 {
 	local ns=${1}
 	local evt_name="${2}"
 	local exp="${3}"
+	local attr="${4}"
+	local attr_exp="${5}"
 
 	local evts="${evts_ns1}"
 	local evt="${!evt_name}"
+	local attr_name
 	local count
 
+	if [ -n "${attr}" ]; then
+		attr_name=", ${attr}: ${attr_exp}"
+	fi
+
 	evt_name="${evt_name:16}" # without MPTCP_LIB_EVENT_
 	[ "${ns}" == "ns2" ] && evts="${evts_ns2}"
 
-	printf "%-${nr_blank}s %s" " " "event ${ns} ${evt_name} (${exp})"
+	printf "%-${nr_blank}s %s" " " "event ${ns} ${evt_name} (${exp}${attr_name})"
 
 	count=$(grep -cw "type:${evt}" "${evts}")
 	if [ "${count}" != "${exp}" ]; then
@@ -3234,6 +3241,18 @@ chk_evt_nr()
 		fail_test
 		dump_stats
 		cat "${evts}"
+		return
+	elif [ -z "${attr}" ]; then
+		echo "[ ok ]"
+		return
+	fi
+
+	count=$(grep -w "type:${evt}" "${evts}" | grep -c ",${attr}:")
+	if [ "${count}" != "${attr_exp}" ]; then
+		echo "[fail] got ${count} event attributes, expected ${attr_exp}"
+		fail_test
+		dump_stats
+		grep -w "type:${evt}" "${evts}"
 	else
 		echo "[ ok ]"
 	fi
@@ -3375,7 +3394,7 @@ userspace_tests()
 			chk_subflow_nr "" "after reject" 1
 			userspace_pm_add_sf $ns2 10.0.1.2 0
 			wait_event ns2 MPTCP_LIB_EVENT_SUB_CLOSED 2
-			chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 2
+			chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 2 error 2
 		fi
 		kill_wait "${tests_pid}"
 		kill_events_pids
-- 
2.51.0


