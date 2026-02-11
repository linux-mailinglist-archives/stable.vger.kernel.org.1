Return-Path: <stable+bounces-215873-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEB3H13TjGm+tgAAu9opvQ
	(envelope-from <stable+bounces-215873-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 20:07:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ED54412707D
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 20:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 68081300D90F
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 19:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CAE346E56;
	Wed, 11 Feb 2026 19:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="srcnZadh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4F427707;
	Wed, 11 Feb 2026 19:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770836826; cv=none; b=udgRDL9xWS6ZQ2dOc3Q0ZJAo0Q8PUU22dxLXQLue8Cx5r3p88BrOD06aJz9t0EVJXWiPikmqD6L6d/rc9xyi8aZ5FbbvD6jN9sO7j88Yme5WYaSnnO8QiBwWODcIlabjf9HmnRHurTzR0VI33iKnFz30NlDtCJ8S4c4V/rstXJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770836826; c=relaxed/simple;
	bh=4ilfBfueSL/qCRRY/D5V1mAmH6Qzgsf5jWHBTlRngKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=efHqvUiKuVYQ0SNzDDEnbdXccNr7o8G/belNS247z6IlwOINMXSQTXXnSoEXev79DD3+bxpjUp1nZsjtaD2K4jxiGKBlpSU+4ua74EcPZMii16Xrr2FMADajlvPk/AKZe0odgQ70mGCtjUsQM/lwwWk2pqdH6Y6rw8ljTf8/srQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=srcnZadh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5498BC19424;
	Wed, 11 Feb 2026 19:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770836826;
	bh=4ilfBfueSL/qCRRY/D5V1mAmH6Qzgsf5jWHBTlRngKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=srcnZadhU6ao5uJGSJSNkIzFXciqlGREg0vzSD4r3u/NyQs2oBjpuYqQNlYWnetBu
	 WXtizJ8xqncXtCUUrNQ4EGK53JfR35SbYRtGBP3QjNAdxzeYm0OyLi+ZOliIdnWWYb
	 DstLF8Hwgiaq7nV1Gsfoj2DG8YQtD0u7xsWAANgjdn/0oJnMiXyMBiOrW8Ct6MyBpH
	 Dqtnc+tDvXtMkOQt/tUO3CHPBJ0Vwmi8Esr7r3wXEJle2T5oWuibzkvSW0VTlwmgb0
	 rz0hdeUbRPe0nmSKcYA7a+d8yR738shBMlD1ykw8wXPiPyxQjeo4WuDO6w3P+65zbv
	 0csdoZRp/iXbg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y 6/6] selftests: mptcp: join: fix local endp not being tracked
Date: Wed, 11 Feb 2026 20:06:24 +0100
Message-ID: <20260211190617.77192-14-matttbe@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211190617.77192-8-matttbe@kernel.org>
References: <20260211190617.77192-8-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2716; i=matttbe@kernel.org; h=from:subject; bh=4ilfBfueSL/qCRRY/D5V1mAmH6Qzgsf5jWHBTlRngKo=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJ7LhtM6PFeGNi90sd4+lnJbZkLdk6YYlK3f/fdPs6MC f/nHK1Q7ChlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZjImSpGhssRP37Mb1l/Krel eq/8zHWr1yl8mzf/BePWju4H5hPML6xkZFhQ8bNYVfLo1gK9OYe1Zs225tN3qd4g3eZX+c92ucO NFl4A
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-215873-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,mptcp_join.sh:url]
X-Rspamd-Queue-Id: ED54412707D
X-Rspamd-Action: no action

commit c5d5ecf21fdd9ce91e6116feb3aa83cee73352cc upstream.

When running this mptcp_join.sh selftest on older kernel versions not
supporting local endpoints tracking, this test fails because 3 MP_JOIN
ACKs have been received, while only 2 were expected.

It is not clear why only 2 MP_JOIN ACKs were expected on old kernel
versions, while 3 MP_JOIN SYN and SYN+ACK were expected. When testing on
the v5.15.197 kernel, 3 MP_JOIN ACKs are seen, which is also what is
expected in the selftests included in this kernel version, see commit
f4480eaad489 ("selftests: mptcp: add missing join check").

Switch the expected MP_JOIN ACKs to 3. While at it, move this
chk_join_nr helper out of the special condition for older kernel
versions as it is now the same as with more recent ones. Also, invert
the condition to be more logical: what's expected on newer kernel
versions having such helper first.

Fixes: d4c81bbb8600 ("selftests: mptcp: join: support local endpoint being tracked or not")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260127-net-mptcp-dup-nl-events-v1-5-7f71e1bc4feb@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in mptcp_join.sh, because commit e571fb09c893 ("selftests:
  mptcp: add speed env var") is not in this version, and caused
  conflicts in the context. The same modification can still be applied
  at the same place. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 7d4df90d6281..5a40e09e8374 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2181,17 +2181,16 @@ signal_address_tests()
 		# the peer could possibly miss some addr notification, allow retransmission
 		ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		chk_join_nr 3 3 3
 
 		# It is not directly linked to the commit introducing this
 		# symbol but for the parent one which is linked anyway.
-		if ! mptcp_lib_kallsyms_has "mptcp_pm_subflow_check_next$"; then
-			chk_join_nr 3 3 2
-			chk_add_nr 4 4
-		else
-			chk_join_nr 3 3 3
+		if mptcp_lib_kallsyms_has "mptcp_pm_subflow_check_next$"; then
 			# the server will not signal the address terminating
 			# the MPC subflow
 			chk_add_nr 3 3
+		else
+			chk_add_nr 4 4
 		fi
 	fi
 }
-- 
2.51.0


