Return-Path: <stable+bounces-222853-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qK2aAC7ApmlDTQAAu9opvQ
	(envelope-from <stable+bounces-222853-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 12:04:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F3A1ED4B3
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 12:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55604315E630
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 10:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF77C382289;
	Tue,  3 Mar 2026 10:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zu8lvysj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43DA3CC9EB;
	Tue,  3 Mar 2026 10:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772535395; cv=none; b=EMJgJKLTTSAEG2vI3OjPwzokRTFlKGsAls997oMlnaGWoH6rmrCmdcbxgxdp5WXZIreDjhyq2JEAlCNs7XNfUiSkY1DZ/88d9z87jEvWfeSdA4bwPPHk65frgFkkCeWVI7FPWDRbLjAlNIOM3AeXb/DnUCUyrr3XoSrJu5T6rQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772535395; c=relaxed/simple;
	bh=FFMlO/2VSIT4Y74XGRmhekzQB204Lkh4fCnE8YpYa8M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eteRKo9cFIr7E27UWiJqaQoRD8/imUvbeF12AYQYVVE7WVEVmyGwfETBvCW6i9oSdeHtcTZE0qiB397hqGG1qFDWdocpcq3v4znqQpp0h45GNHpABSJ2JNSXWdunw+8jNKIrhqRjgW6a9kC+frgulTJOcWID3rBS8duVnZQXcE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zu8lvysj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F578C2BC9E;
	Tue,  3 Mar 2026 10:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772535395;
	bh=FFMlO/2VSIT4Y74XGRmhekzQB204Lkh4fCnE8YpYa8M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Zu8lvysjTi4lDp0yFcSrSBKnPMPILaESMMpFodfNakkt5Etk3ef296BP0spi+JdOx
	 E1W/2ZeHK4KZTWYJmnhZGOlklP2aN5qLSuB4TiW/fUsDlJ7jaoxfNraLtahLQwGXuy
	 LvsdpJ9I7R/TQpb/mY5wjmaRhJDmmefK/qyhs5V84kOPYg8Sf9yz8vUfT68vBvzmdp
	 P27tNypWVUVlk/BnheGZbm/NfenvFX3v96j4oo2WntXBMfwlpEqHy2BaLDcS41Gw/8
	 EzO8WIZ2HCnIkVG5Q6q2ICSamyY+CEV8vFyXh6dPG9hzAd5sbBcdMM31zWkidPBsd9
	 rOql4FF1uW/RQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 03 Mar 2026 11:56:04 +0100
Subject: [PATCH net 3/5] selftests: mptcp: join: check RM_ADDR not sent
 over same subflow
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-net-mptcp-misc-fixes-7-0-rc2-v1-3-4b5462b6f016@kernel.org>
References: <20260303-net-mptcp-misc-fixes-7-0-rc2-v1-0-4b5462b6f016@kernel.org>
In-Reply-To: <20260303-net-mptcp-misc-fixes-7-0-rc2-v1-0-4b5462b6f016@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3877; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=FFMlO/2VSIT4Y74XGRmhekzQB204Lkh4fCnE8YpYa8M=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKX7Qv5zLm3bZP5FPeNLzo1b8wTZw6Z4pF78NiRszO4T
 heXTFoxu6OUhUGMi0FWTJFFui0yf+bzKt4SLz8LmDmsTCBDGLg4BWAiS00YGV7GTJT2NFootOKs
 XsGnxMxiWd4M7vi34Y5BU27GPb0qGsXwv+xzlMD2i0run11VWhUvytiXvY2evTtkHU9KfF5Kvkg
 kNwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Queue-Id: 65F3A1ED4B3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222853-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

This validates the previous commit: RM_ADDR were sent over the first
found active subflow which could be the same as the one being removed.
It is more likely to loose this notification.

For this check, RM_ADDR are explicitly dropped when trying to send them
over the initial subflow, when removing the endpoint attached to it. If
it is dropped, the test will complain because some RM_ADDR have not been
received.

Note that only the RM_ADDR are dropped, to allow the linked subflow to
be quickly and cleanly closed. To only drop those RM_ADDR, a cBPF byte
code is used. If the IPTables commands fail, that's OK, the tests will
continue to pass, but not validate this part. This can be ignored:
another subtest fully depends on such command, and will be marked as
skipped.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 8dd5efb1f91b ("mptcp: send ack for rm_addr")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 36 +++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index dc1f200aaa81..058ad5a13d24 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -104,6 +104,24 @@ CBPF_MPTCP_SUBOPTION_ADD_ADDR="14,
 			       6 0 0 65535,
 			       6 0 0 0"
 
+# IPv4: TCP hdr of 48B, a first suboption of 12B (DACK8), the RM_ADDR suboption
+# generated using "nfbpf_compile '(ip[32] & 0xf0) == 0xc0 && ip[53] == 0x0c &&
+#				  (ip[66] & 0xf0) == 0x40'"
+CBPF_MPTCP_SUBOPTION_RM_ADDR="13,
+			      48 0 0 0,
+			      84 0 0 240,
+			      21 0 9 64,
+			      48 0 0 32,
+			      84 0 0 240,
+			      21 0 6 192,
+			      48 0 0 53,
+			      21 0 4 12,
+			      48 0 0 66,
+			      84 0 0 240,
+			      21 0 1 64,
+			      6 0 0 65535,
+			      6 0 0 0"
+
 init_partial()
 {
 	capout=$(mktemp)
@@ -4217,6 +4235,14 @@ endpoint_tests()
 		chk_subflow_nr "after no reject" 3
 		chk_mptcp_info subflows 2 subflows 2
 
+		# To make sure RM_ADDR are sent over a different subflow, but
+		# allow the rest to quickly and cleanly close the subflow
+		local ipt=1
+		ip netns exec "${ns2}" ${iptables} -I OUTPUT -s "10.0.1.2" \
+			-p tcp -m tcp --tcp-option 30 \
+			-m bpf --bytecode \
+			"$CBPF_MPTCP_SUBOPTION_RM_ADDR" \
+			-j DROP || ipt=0
 		local i
 		for i in $(seq 3); do
 			pm_nl_del_endpoint $ns2 1 10.0.1.2
@@ -4229,6 +4255,7 @@ endpoint_tests()
 			chk_subflow_nr "after re-add id 0 ($i)" 3
 			chk_mptcp_info subflows 3 subflows 3
 		done
+		[ ${ipt} = 1 ] && ip netns exec "${ns2}" ${iptables} -D OUTPUT 1
 
 		mptcp_lib_kill_group_wait $tests_pid
 
@@ -4288,11 +4315,20 @@ endpoint_tests()
 		chk_mptcp_info subflows 2 subflows 2
 		chk_mptcp_info add_addr_signal 2 add_addr_accepted 2
 
+		# To make sure RM_ADDR are sent over a different subflow, but
+		# allow the rest to quickly and cleanly close the subflow
+		local ipt=1
+		ip netns exec "${ns1}" ${iptables} -I OUTPUT -s "10.0.1.1" \
+			-p tcp -m tcp --tcp-option 30 \
+			-m bpf --bytecode \
+			"$CBPF_MPTCP_SUBOPTION_RM_ADDR" \
+			-j DROP || ipt=0
 		pm_nl_del_endpoint $ns1 42 10.0.1.1
 		sleep 0.5
 		chk_subflow_nr "after delete ID 0" 2
 		chk_mptcp_info subflows 2 subflows 2
 		chk_mptcp_info add_addr_signal 2 add_addr_accepted 2
+		[ ${ipt} = 1 ] && ip netns exec "${ns1}" ${iptables} -D OUTPUT 1
 
 		pm_nl_add_endpoint $ns1 10.0.1.1 id 99 flags signal
 		wait_mpj 4

-- 
2.51.0


