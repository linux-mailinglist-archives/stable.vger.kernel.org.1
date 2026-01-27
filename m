Return-Path: <stable+bounces-211891-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +B7RHCoSeWkcvAEAu9opvQ
	(envelope-from <stable+bounces-211891-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 20:29:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F48A99DAB
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 20:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CD305301E323
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 19:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2979372B38;
	Tue, 27 Jan 2026 19:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnNTQJto"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB90371046;
	Tue, 27 Jan 2026 19:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769542071; cv=none; b=ZzxF5vfUpvu4isy4V9+5mzqigu+aDhg8ykJEIR6WtYPCf99mmIWvc0mwiCTbV6sXwlN1+V92tlMmBOGesTtOyYAYRkEMynbVnJt8+vOr81sWsbRu9hSzTW71O8G40GKJP6780U9iW8spMozg46ZHRmimDQMKGQO4hot59YM+bgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769542071; c=relaxed/simple;
	bh=ytjJ25Q1jmwXE29IQbjqiVL3coToMRadyXhmXWtjND8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=REbOz8ytgi10EedfoAEMhlYKYROnz5ZfYZphu0d3tBu/RANE6uCV+N2hmhKHuozBRX31lfZ53Ok+qOT8Zd5PujYaAhy4hExCKuGDoRUwRO7lNulZhmktJvWmQ+1bcoKWe4BVQ9/4W99kruxEz76siUs5G+Ht7MfnoOFNQPFA8ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnNTQJto; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E283C19425;
	Tue, 27 Jan 2026 19:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769542071;
	bh=ytjJ25Q1jmwXE29IQbjqiVL3coToMRadyXhmXWtjND8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UnNTQJtoSVqy9mLMLJ2g0son1lXJ7iQ8GevQnsC3V6Ny+XKz5OWLiv+ewt8gilpth
	 13b61T3CgpcvbizoZAQ7OIzB4o2dR/WXGgK5UP6bshYgCyVluTBShM1udB0RIUtZbF
	 /pV2vILb0FgWu4a/QREO7y9D21mgs9tg1hZssRqPM/wvhBnbM1nvj0vg9JQdCHWBM6
	 lEPOVPPNcyusNnqxU951RnQDcct4tLMpE4sHZWdjIVh3FOYhOTR+8L0I84kcCj3kpL
	 ENQLW7mVAQ0mPaojxEXbpZfzNqNc+JvduiZAhZIN00+gMo0QaRfMTUQehXkycBDTxU
	 IbepUWMs5717g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 27 Jan 2026 20:27:27 +0100
Subject: [PATCH net 5/5] selftests: mptcp: join: fix local endp not being
 tracked
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-net-mptcp-dup-nl-events-v1-5-7f71e1bc4feb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2148; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ytjJ25Q1jmwXE29IQbjqiVL3coToMRadyXhmXWtjND8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIrBZfnbsn02dD+KTqoor5G+3r8av1V/x+o9E2Y47q0t
 8W88/nPjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgImUX2P4w+uzxCLT70JehuLU
 FD2btzN8167r36puLmi7/ormd4VN5owMewzurdFKddtles1kth8D0+rpP87N5GaXTJHJ3xdkUX6
 dBQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211891-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 5F48A99DAB
X-Rspamd-Action: no action

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
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 3fc29201362a..e70d3420954f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2329,17 +2329,16 @@ signal_address_tests()
 		ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
 		speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
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


