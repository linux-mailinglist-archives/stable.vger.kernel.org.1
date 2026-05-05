Return-Path: <stable+bounces-244189-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qK5PCfsG+mkEIgMAu9opvQ
	(envelope-from <stable+bounces-244189-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 17:04:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4024CFE65
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 17:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 712C1303B0B8
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 15:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CBB481672;
	Tue,  5 May 2026 15:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pOr0LpLF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122DA481651;
	Tue,  5 May 2026 15:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777993311; cv=none; b=CG37yzyaeUBgFv7HXlQBsOqj52Adhz+NzE3rRlBe90WEmBhiXGaBY7/eWXcXhL2WoG+EnYOaI2FahGTAvLiF8zx10jc170FU4njPaE5RQUe44gYfbgLRO7GggJYIMqQa5kK3iYVfzJt9tEIf6b6HNwI+Sl1GyCyMn12PlG/7y90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777993311; c=relaxed/simple;
	bh=psg6PuHKEap4S5ZDHfd73t2Q2RVWzttWnMP4s8gpVik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aLz7la3r6NSD1rYMMxih1Mp8JyYATXERDiraWVFhBs4z7NjQ+ls5JycLL92b6+boRRMkMJtcjYt9cqDiOm6ZU3IzO137kyS9xWuP7EZYV9dP2vNqUVUQ5Q7uLxLiujzEIZMuoRECItIvXNi7kdZVRBUadDAVZ14w+gZThCc6tJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pOr0LpLF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A407DC2BCF4;
	Tue,  5 May 2026 15:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777993310;
	bh=psg6PuHKEap4S5ZDHfd73t2Q2RVWzttWnMP4s8gpVik=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pOr0LpLFWRp7B7jlv7b1c4BjY7iAqXGau7GSz+dIb1gYQU9dMMGJbAv0efAR8NYP8
	 OLrDyz1ztDjFXTxYhv1I3FYeAslT8oa3eyAHLoBUS5mZ++JlpDPJCAwyNosbarTUWy
	 FX5W8j/oMBgatPn2uy7PZocb/I8ywGfjWYT7YanThgYU2WY/3eTYdcS6xppA9EqfEw
	 e3YrHNza7OWwDfLh+66EZnKv9nsQBKKBOZb2n0e0t7QM3WY4IWJcIKiK/51R6GXgup
	 VNFmj3S26gfaeb0LxbDpOAUQeU8e6bkqFtyL+MIpkpcRdkHa/FWS7xxSFUUzb+CzJj
	 6XkF9fHTkg8vg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 05 May 2026 17:00:58 +0200
Subject: [PATCH net 10/11] selftests: mptcp: check output: catch cmd errors
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-net-mptcp-pm-fixes-7-1-rc3-v1-10-fca8091060a4@kernel.org>
References: <20260505-net-mptcp-pm-fixes-7-1-rc3-v1-0-fca8091060a4@kernel.org>
In-Reply-To: <20260505-net-mptcp-pm-fixes-7-1-rc3-v1-0-fca8091060a4@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Christoph Paasch <cpaasch@openai.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3950; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=psg6PuHKEap4S5ZDHfd73t2Q2RVWzttWnMP4s8gpVik=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJ/sTm3SQQ7hOc5ORaevPhnt6X8iT+WEfPNbLhv/NjMn
 RDeYdLZUcrCIMbFICumyCLdFpk/83kVb4mXnwXMHFYmkCEMXJwCMJGNWgy/mO9ELDnm8PhFhMlv
 w8AAhZfMi7h7xLuuFz8wnm7/N4olnuF/mtnx/ncxpqedOxeJul75I1sju2b6X6cEzZNK9s/W/Gf
 hAQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Queue-Id: 0D4024CFE65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244189-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pm_netlink.sh:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Using '${?}' inside the if-statement to check the returned value from
the command that was evaluated as part of the if-statement is not
correct: here, '${?}' will be linked to the previous instruction, not
the one that is expected here (${cmd}).

Instead, simply mark the error, except if an error is expected. If
that's the case, 1 can be passed as the 4th argument of this helper.
Three checks from pm_netlink.sh expect an error.

While at it, improve the error message when the command unexpectedly
fails or succeeds.

Note that we could expect a specific returned value, but the checks
currently expecting an error can be used with 'ip mptcp' or 'pm_nl_ctl',
and these two tools don't return the same error code.

Fixes: 2d0c1d27ea4e ("selftests: mptcp: add mptcp_lib_check_output helper")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh  | 16 ++++++++++------
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 10 ++++++----
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 5fea7e7df628..989a5975dcea 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -474,20 +474,24 @@ mptcp_lib_wait_local_port_listen() {
 	wait_local_port_listen "${@}" "tcp"
 }
 
+# $1: error file, $2: cmd, $3: expected msg, [$4: expected error]
 mptcp_lib_check_output() {
 	local err="${1}"
 	local cmd="${2}"
 	local expected="${3}"
+	local exp_error="${4:-0}"
 	local cmd_ret=0
 	local out
 
-	if ! out=$(${cmd} 2>"${err}"); then
-		cmd_ret=${?}
-	fi
+	out=$(${cmd} 2>"${err}") || cmd_ret=1
 
-	if [ ${cmd_ret} -ne 0 ]; then
-		mptcp_lib_pr_fail "command execution '${cmd}' stderr"
-		cat "${err}"
+	if [ "${cmd_ret}" != "${exp_error}" ]; then
+		mptcp_lib_pr_fail "unexpected returned code for '${cmd}', info:"
+		if [ "${exp_error}" = 0 ]; then
+			cat "${err}"
+		else
+			echo "${out}"
+		fi
 		return 2
 	elif [ "${out}" = "${expected}" ]; then
 		return 0
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 123d9d7a0278..b69f30fcb91e 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -122,10 +122,12 @@ check()
 	local cmd="$1"
 	local expected="$2"
 	local msg="$3"
+	local exp_error="$4"
 	local rc=0
 
 	mptcp_lib_print_title "$msg"
-	mptcp_lib_check_output "${err}" "${cmd}" "${expected}" || rc=${?}
+	mptcp_lib_check_output "${err}" "${cmd}" "${expected}" "${exp_error}" ||
+		rc=${?}
 	if [ ${rc} -eq 2 ]; then
 		mptcp_lib_result_fail "${msg} # error ${rc}"
 		ret=${KSFT_FAIL}
@@ -158,13 +160,13 @@ check "show_endpoints" \
 			    "3,10.0.1.3,signal backup")" "dump addrs"
 
 del_endpoint 2
-check "get_endpoint 2" "" "simple del addr"
+check "get_endpoint 2" "" "simple del addr" 1
 check "show_endpoints" \
 	"$(format_endpoints "1,10.0.1.1" \
 			    "3,10.0.1.3,signal backup")" "dump addrs after del"
 
 add_endpoint 10.0.1.3 2>/dev/null
-check "get_endpoint 4" "" "duplicate addr"
+check "get_endpoint 4" "" "duplicate addr" 1
 
 add_endpoint 10.0.1.4 flags signal
 check "get_endpoint 4" "$(format_endpoints "4,10.0.1.4,signal")" "id addr increment"
@@ -173,7 +175,7 @@ for i in $(seq 5 9); do
 	add_endpoint "10.0.1.${i}" flags signal >/dev/null 2>&1
 done
 check "get_endpoint 9" "$(format_endpoints "9,10.0.1.9,signal")" "hard addr limit"
-check "get_endpoint 10" "" "above hard addr limit"
+check "get_endpoint 10" "" "above hard addr limit" 1
 
 del_endpoint 9
 for i in $(seq 10 255); do

-- 
2.53.0


