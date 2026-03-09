Return-Path: <stable+bounces-223704-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJLhAEX4rmnZKgIAu9opvQ
	(envelope-from <stable+bounces-223704-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 17:41:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6BE23CE45
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 17:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB1D530C21CA
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 16:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053AE3ED5A2;
	Mon,  9 Mar 2026 16:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnEv4i3D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800F83ED5B1
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 16:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773073727; cv=none; b=DZoDZWpz7JAxdOFHsB8OcSCZpVGYROusTRBN0TYK3WyV62k0wCq1TaJbOCJwicEXnn6b3clRR4PlkGZbSPl87feDq1mu9NPmKgAmUAdcTUE/jm94zqajkEGrdbWzr1UaMZLlbffRrJWS2GqIGX9UbSzG+LZGrjnQatje9/7Q1l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773073727; c=relaxed/simple;
	bh=5gZ/3USY9shJ1Pd18Cs47gsYJE7+71UldjPHOlDLpMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GrfZmpZAinfU2I9eFhH7mKMkoid0C1zyJSlhP2p+ZeoK5A6SxLt+pgLpUxXWDLAld1RGWEEmrWr0AF+CM9gKe8qvK8lpagpA6d+sALUNGYyBkMTi13skeMrWekqS3A2ejYxXHTG047BmyNzwMkO8/nLaQ+vJmg5r4nw8G2iisE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnEv4i3D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C094C2BCAF;
	Mon,  9 Mar 2026 16:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773073727;
	bh=5gZ/3USY9shJ1Pd18Cs47gsYJE7+71UldjPHOlDLpMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lnEv4i3D0NCj1E8Bzq0ESq3/SRKLvciUm24niVEjoukRtYiMZgHLTIf1F/JkCqqLq
	 JSOzkCNp+7GIZ3pulndsspRei8+SQTDoirnnMRU/LHNjey7BrnV+FIsJPO1TVhU7wu
	 KysIhQWVegSch2ZywaJP4+b9EYgI6/6t+AsFwVSdhye/Mi8RoeJt0WhS9kFpk3F3Pb
	 o+veORq3y22Hh2pVA85ht6HUB272dZvXvcUWRZqDodndqpOUR8IJugwHShb+RmmsZ0
	 0x9XgbEwvGMxnSNtZFGKMw3AoorwRopVAiZ8vPeDG3ssMmVg0dipr4ccefTr8W4TJz
	 q5hW1TIUeKdSw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] selftests: mptcp: join: check RM_ADDR not sent over same subflow
Date: Mon,  9 Mar 2026 12:28:43 -0400
Message-ID: <20260309162844.1306091-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260309162844.1306091-1-sashal@kernel.org>
References: <2026030947-unbend-embezzle-26de@gregkh>
 <20260309162844.1306091-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6C6BE23CE45
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223704-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.986];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Action: no action

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

[ Upstream commit 560edd99b5f58b2d4bbe3c8e51e1eed68d887b0e ]

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
Link: https://patch.msgid.link/20260303-net-mptcp-misc-fixes-7-0-rc2-v1-3-4b5462b6f016@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index e3b95a25de9cf..18e50b9262645 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -81,6 +81,24 @@ CBPF_MPTCP_SUBOPTION_ADD_ADDR="14,
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
@@ -3867,6 +3885,14 @@ endpoint_tests()
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
@@ -3879,6 +3905,7 @@ endpoint_tests()
 			chk_subflow_nr "after re-add id 0 ($i)" 3
 			chk_mptcp_info subflows 3 subflows 3
 		done
+		[ ${ipt} = 1 ] && ip netns exec "${ns2}" ${iptables} -D OUTPUT 1
 
 		mptcp_lib_kill_group_wait $tests_pid
 
@@ -3937,11 +3964,20 @@ endpoint_tests()
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
 		wait_mpj $ns2
-- 
2.51.0


