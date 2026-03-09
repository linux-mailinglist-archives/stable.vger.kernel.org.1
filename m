Return-Path: <stable+bounces-223715-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGmBJPQGr2knLwIAu9opvQ
	(envelope-from <stable+bounces-223715-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 18:44:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B49523DCA2
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 18:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 99927300C6DE
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 17:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D6A2BDC2C;
	Mon,  9 Mar 2026 17:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QoZ2/+66"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5546E1DBB3A
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 17:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773078253; cv=none; b=cHMvVSc8kK12ziopKG6oeEaPQu9Bg7Uq7d/5gJc+eNsBi9e3bTMddAZgDL6kMf/rUnG5B+j6+N+Qkn6Pen1jUa7tXTxJk8RM9Xdi3qRqQkH2NGzRvh7vKw/Y+jzwupZU/fndz77Vq09wudtO231OtZzWmrryoJ4uQJdL9S2LNcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773078253; c=relaxed/simple;
	bh=Jzk+ucn/WH/5zGBO+VxCCIEBO/0YSsBqdLSbafGQu1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQ7GpaRKFpbtYV7gWp277cXtv5LAqSXWm/cyWcjRQwDVvoWfK2Z4kNCEMy8ZIE5dCO7pldzgtJ6l22y9FuR2+UJsmFVYvdk4enQgNgy87pFVHbroKH4RbKYdFO5LgxT5yvBnsETXleRyWR0kvYOxTR/2U7CFN0T4vHoOTos3tFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QoZ2/+66; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60CAAC4CEF7;
	Mon,  9 Mar 2026 17:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773078253;
	bh=Jzk+ucn/WH/5zGBO+VxCCIEBO/0YSsBqdLSbafGQu1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QoZ2/+66pckAKVGxHmfL4TSL7W3YwcN1mPePTHrLuMU0hGrrNtzT6paeZCHze1+gC
	 YXcosIMa8oJx4EvwByUxqG2mif4iMbKfU451ISQA1Z7xTG+t4V8scJajg8Lfigsj9u
	 F2LkPbUEDiq18PjTN4StH71eqD+rcFF3YTcR3tgsZvKVg7pAFatWHlzdvrSIYh8Gru
	 7g/Jk7dlm6XuFb1NPEALqMJQdRBHn+/oWIs+gQA4/NKRnFv6WHt1wy8KX3dVMpZ/YX
	 TZhNYtRDnEOsIQ6jLw+Y3GW10H3fMeKdgJnMDUo6Rj17R1bM8IV8E4soW+6LNnA8il
	 UEHOiG9ptBM1w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] selftests: mptcp: join: check RM_ADDR not sent over same subflow
Date: Mon,  9 Mar 2026 13:44:10 -0400
Message-ID: <20260309174410.1333230-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026030947-outcome-ferris-731b@gregkh>
References: <2026030947-outcome-ferris-731b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9B49523DCA2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223715-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
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
[ adapted chk_subflow_nr calls to include extra empty first argument ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 5a40e09e8374c..80497053fe2f4 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -64,6 +64,24 @@ CBPF_MPTCP_SUBOPTION_ADD_ADDR="14,
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
@@ -3455,6 +3473,14 @@ endpoint_tests()
 		wait_mpj $ns2
 		chk_subflow_nr "" "after no reject" 3
 
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
@@ -3465,6 +3491,7 @@ endpoint_tests()
 			wait_mpj $ns2
 			chk_subflow_nr "" "after re-add id 0 ($i)" 3
 		done
+		[ ${ipt} = 1 ] && ip netns exec "${ns2}" ${iptables} -D OUTPUT 1
 
 		kill_wait "${tests_pid}"
 		kill_events_pids
@@ -3514,9 +3541,18 @@ endpoint_tests()
 		wait_mpj $ns2
 		chk_subflow_nr "" "after re-add" 3
 
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
 		chk_subflow_nr "" "after delete ID 0" 2
+		[ ${ipt} = 1 ] && ip netns exec "${ns1}" ${iptables} -D OUTPUT 1
 
 		pm_nl_add_endpoint $ns1 10.0.1.1 id 99 flags signal
 		wait_mpj $ns2
-- 
2.51.0


