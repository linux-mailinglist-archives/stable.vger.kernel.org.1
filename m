Return-Path: <stable+bounces-211890-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDITKcYSeWkcvAEAu9opvQ
	(envelope-from <stable+bounces-211890-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 20:32:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4065599E73
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 20:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4CDC53092561
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 19:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B27136D4F8;
	Tue, 27 Jan 2026 19:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="szfTpObo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A57D371068;
	Tue, 27 Jan 2026 19:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769542069; cv=none; b=C0ABTDKk3pSOvOYdh6RGRT/wvUPym2fhsEaDSPSjWU0yFg9blJP12ASqvToHqAExEoURrpZ4Br2bRjOMMVTd5g7je9gElycbQsFahsF1+qjv/wg6mMN9dCyg5WcmhrlX4szigBefXfuC2LGHY/SbcSHRJR6d62V3XHR2u0OI2vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769542069; c=relaxed/simple;
	bh=YWZ4ix1ch5qlLuSWWbNRRB4AMzc3t2vkQ0rmfUvdMo0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GMgfhX/fenyz5rgPhavB4ifYr61jlSEf8dXQG15sndQ3na8Ui3dYnEf42IBelwRgGCivvPXfSkXumOWFpbUjDd61+qpncmyJfgyGq9Q84pEECaQ6cquB4WLLvMbureicZIZtxh0V4GMCpADtNUUmrLVgmttWyrqUAWt27yskUk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=szfTpObo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9648CC116C6;
	Tue, 27 Jan 2026 19:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769542068;
	bh=YWZ4ix1ch5qlLuSWWbNRRB4AMzc3t2vkQ0rmfUvdMo0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=szfTpOboUfJWOHlZcHnbxz0OhgcZEuMPpOl6s1H1HPdFIp0BveXba9y+ggpzyRhrJ
	 rjHoaCuIFYFSUltPebBtL8CJtoFScroTAKaBSE/ClqzzOpr0SgK0HI9GAA3ZEOq1KU
	 URhiaE3HVQ6jDXwSIfT7U+OtBTj+VwrGaVCA8qG6gT/wTciTBTaidx4+9zIbfj4tsm
	 LYNuklkYSLb/O8p3nAVGCG8axJjKSlDZNEnK2JsiFmmJWZ/uqEyxfVLyfsxcO5D9uD
	 L4IKh7Avz4tVNz0N3mV15U+zRvZDdQnuP7Oq8IkwcULnbuKBRfqMCcIDl7ZGKOHH4s
	 SFMlhshg+Zsgw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 27 Jan 2026 20:27:26 +0100
Subject: [PATCH net 4/5] selftests: mptcp: check subflow errors in close
 events
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-net-mptcp-dup-nl-events-v1-4-7f71e1bc4feb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2760; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=YWZ4ix1ch5qlLuSWWbNRRB4AMzc3t2vkQ0rmfUvdMo0=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIrBZcXf331L8B469Rqh+akg4LnlGy4XMxtls3dYKZVI
 rbqbfeFjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIlcM2f4H7+37WS+oE6JSOrV
 zVtWz3+1tq5qMlPbTeF5vWwTeOqZjjMyTPP23bfDjeONcnvq2qsO4gmXfhQwdob6Tq2//WNa9fQ
 cHgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211890-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 4065599E73
X-Rspamd-Action: no action

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
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 1765714a1e2f..3fc29201362a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3847,21 +3847,28 @@ userspace_pm_chk_get_addr()
 	fi
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
 
-	print_check "event ${ns} ${evt_name} (${exp})"
+	print_check "event ${ns} ${evt_name} (${exp}${attr_name})"
 
 	if [[ "${evt_name}" = "LISTENER_"* ]] &&
 	   ! mptcp_lib_kallsyms_has "mptcp_event_pm_listener$"; then
@@ -3873,6 +3880,16 @@ chk_evt_nr()
 	if [ "${count}" != "${exp}" ]; then
 		fail_test "got ${count} events, expected ${exp}"
 		cat "${evts}"
+		return
+	elif [ -z "${attr}" ]; then
+		print_ok
+		return
+	fi
+
+	count=$(grep -w "type:${evt}" "${evts}" | grep -c ",${attr}:")
+	if [ "${count}" != "${attr_exp}" ]; then
+		fail_test "got ${count} event attributes, expected ${attr_exp}"
+		grep -w "type:${evt}" "${evts}"
 	else
 		print_ok
 	fi
@@ -4131,7 +4148,7 @@ userspace_tests()
 			chk_subflows_total 1 1
 			userspace_pm_add_sf $ns2 10.0.1.2 0
 			wait_event ns2 MPTCP_LIB_EVENT_SUB_CLOSED 2
-			chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 2
+			chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 2 error 2
 		fi
 		kill_events_pids
 		mptcp_lib_kill_group_wait $tests_pid

-- 
2.51.0


