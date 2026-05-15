Return-Path: <stable+bounces-247325-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +P+/OGihBmoMlgIAu9opvQ
	(envelope-from <stable+bounces-247325-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 06:30:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEB654938E
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 06:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C42903035B19
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 04:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA8D3D522F;
	Fri, 15 May 2026 04:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JyRd8jHh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFA83D4103;
	Fri, 15 May 2026 04:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778819321; cv=none; b=oP2zv+cajHkqrb57ossCKbljJkrNs3zLCAB5yVwlIJlfTOamv69jyfC/y8xPJ3JuDQ7WSB2ihZUHP+RrmZA/gBCxnLxwWlHBK9qYdH1a+QlmzjmdyHw1mvLtYh3YT1xXU5V6g0HgDFcT2e9AZtw7mK+WIYt6VYGCUuaQ5nZ8JgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778819321; c=relaxed/simple;
	bh=p8Ag+VQTdpeP2qTjHzEKq0SZLd+visfTveYHoYzjYvI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pfxfv0ekulAd2exjvkwMj2LgCwol+VqRSRrzhYvtfEsOZZ2HQT/nA/CVavz00AUsV9EspQTFGdYlt9olgHiw2Tk1pgW5ClrkjMOn7uk0t8M6VEkJ1Znv6aKvQOZzmyrKZwMAfJ4pRz2EOati2uX3yAHvR+4mlr7fP7AL1eqHR04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JyRd8jHh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 187CDC2BCC7;
	Fri, 15 May 2026 04:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778819321;
	bh=p8Ag+VQTdpeP2qTjHzEKq0SZLd+visfTveYHoYzjYvI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JyRd8jHhSblDBehunLDIXFMVK0YVc9hgDXLjT7VQboY3Iu1doG/1F9Mlb2AamzQ5C
	 OMYEll0E891JMIJvyXAdWapNWstkmxnImRPhShsXmKBjfbrSnEZvHpJyKb1h6wNmlb
	 vtebA5WNM4pi995YAF0lpSsPu0/YZOUoR4XCg7idqIgnUSceoej3g/xFlbmF9+Jjmx
	 Q4R0G2Ge7ErmVyR95JHPtWsP83EfbBUBOIrBYtvD4iffyMuIbNQ+9CH3MLiYYFYYK7
	 lnzXnfuSKwRewbBFx5IFjPhJ5hSHUbl7CCZyd4ttbgeL4G/YPhuM9ywu5JUFrkzBUL
	 MZeayu2FyPW9w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 15 May 2026 06:27:37 +0200
Subject: [PATCH net v2 6/6] selftests: mptcp: drop nanoseconds width
 specifier
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-net-mptcp-misc-fixes-7-1-rc4-v2-6-701e96419f2f@kernel.org>
References: <20260515-net-mptcp-misc-fixes-7-1-rc4-v2-0-701e96419f2f@kernel.org>
In-Reply-To: <20260515-net-mptcp-misc-fixes-7-1-rc4-v2-0-701e96419f2f@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 linux-kselftest@vger.kernel.org, Eric Dumazet <edumaze@google.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3811; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=p8Ag+VQTdpeP2qTjHzEKq0SZLd+visfTveYHoYzjYvI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqBqDLmm2dxmHj049HWW99vHr1qVTNX6z3DKVz7
 DbYIxGVV9eJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCagagywAKCRD2t4JPQmmg
 c7daEACJ1ZIXprKjL4UrJ7FWSx7uc/k1IZutTAqcHotyaQe5zXLx44nNJJ/p8/RmGa9D2K58iSZ
 /uypMNr60hM3kKF/IPsuUkZj488KUakzeeO5vhhQz6nuPp/aXuX9UxpqWjS1gWnaX44tNIFVqZv
 e73yAdL3EHIjjlYZxVGp3kaHus9qaYP9kTgMXHdrCDnmFm65y5UqGq4Kr5aVJo2DJ2agh2OpmCM
 TUQWw7bXvZuOiV/ylADurVC+fFDf3X9PGwfmWx1bs2J6BvPImzwOmwb1i7FYTl+hkXARTlmjRJa
 E9g1ylkzhjzPOGl7HWNodxnTHUuK429UmZLiVQsAZK75cmggoe+mfOWnDFvEZINEHFxlOTHGveM
 iH1TMPT8yzMEg/6vKkqfpZJIbdEvrmsOTGd7cnVzM7VYHZVFLXv9TFluvyaY3ef19osuBqpdDtc
 5L6oPcyerkj8baW0tYc80mKpcjzhot7vdMDA/9z0nKLz/W3WcSo1ndv6xv3ov2kgGovG3IC+QiJ
 95xbCSJbBdTvOAb33nzSoWTZqJu5vD86WBIev2sT9gy8F0ErzSw1hN416DiOc/9Moa4T8E+sURX
 +nm00fzjOBwcixoKcowmZipbkebYZ8+vDuOlztSY7BXjPYTVErwmAcQp2aM9Ug4ZqjZK09unSJQ
 mGa/E4TQtvdcCQg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Queue-Id: 8AEB654938E
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
	TAGGED_FROM(0.00)[bounces-247325-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Using the format specifier +%s%3N with GNU date is honoured, and only
prints 3 digits of the nanoseconds portion of the seconds since epoch,
which corresponds to the milliseconds.

The uutils implementation of date currently does not honour this, and
always prints all 9 digits. This is a known issue [1], but can be worked
around by adapting this test to use nanoseconds instead of microseconds,
and then divide it by 1e6.

This fix is similar to what has been done on systemd side [2], and it is
needed to run the selftests on Ubuntu 26.04, containing uutils 0.8.0.

Note that the Fixes tag is there even if this patch doesn't fix an issue
in the kernel selftests, but it is useful for those using uutils 0.8.0.

Fixes: 048d19d444be ("mptcp: add basic kselftest for mptcp")
Cc: stable@vger.kernel.org
Link: https://github.com/uutils/coreutils/issues/11658 [1]
Link: https://github.com/systemd/systemd/pull/41627 [2]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |  6 +++---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index a6447f7a31fe..d158678fa6ab 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -401,7 +401,7 @@ do_transfer()
 	mptcp_lib_wait_local_port_listen "${listener_ns}" "${port}"
 
 	local start
-	start=$(date +%s%3N)
+	start=$(date +%s%N)
 	ip netns exec ${connector_ns} \
 		./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
 			$extra_args $connect_addr < "$cin" > "$cout" &
@@ -423,7 +423,7 @@ do_transfer()
 	fi
 
 	local stop
-	stop=$(date +%s%3N)
+	stop=$(date +%s%N)
 
 	if $capture; then
 		sleep 1
@@ -439,7 +439,7 @@ do_transfer()
 	fi
 
 	local duration
-	duration=$((stop-start))
+	duration=$(((stop-start) / 1000000))
 	printf "(duration %05sms) " "${duration}"
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ] || [ ${timeout_pid} -ne 0 ]; then
 		mptcp_lib_pr_fail "client exit code $retc, server $rets"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 989a5975dcea..5ef6033775c8 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -28,7 +28,7 @@ declare -rx MPTCP_LIB_AF_INET6=10
 MPTCP_LIB_SUBTESTS=()
 MPTCP_LIB_SUBTESTS_DUPLICATED=0
 MPTCP_LIB_SUBTEST_FLAKY=0
-MPTCP_LIB_SUBTESTS_LAST_TS_MS=
+MPTCP_LIB_SUBTESTS_LAST_TS_NS=
 MPTCP_LIB_TEST_COUNTER=0
 MPTCP_LIB_TEST_FORMAT="%02u %-50s"
 MPTCP_LIB_IP_MPTCP=0
@@ -236,7 +236,7 @@ mptcp_lib_kversion_ge() {
 }
 
 mptcp_lib_subtests_last_ts_reset() {
-	MPTCP_LIB_SUBTESTS_LAST_TS_MS="$(date +%s%3N)"
+	MPTCP_LIB_SUBTESTS_LAST_TS_NS="$(date +%s%N)"
 }
 mptcp_lib_subtests_last_ts_reset
 
@@ -255,7 +255,7 @@ __mptcp_lib_result_check_duplicated() {
 __mptcp_lib_result_add() {
 	local result="${1}"
 	local time="time="
-	local ts_prev_ms
+	local ts_prev_ns
 	shift
 
 	local id=$((${#MPTCP_LIB_SUBTESTS[@]} + 1))
@@ -265,9 +265,9 @@ __mptcp_lib_result_add() {
 	# not to add two '#'
 	[[ "${*}" != *"#"* ]] && time="# ${time}"
 
-	ts_prev_ms="${MPTCP_LIB_SUBTESTS_LAST_TS_MS}"
+	ts_prev_ns="${MPTCP_LIB_SUBTESTS_LAST_TS_NS}"
 	mptcp_lib_subtests_last_ts_reset
-	time+="$((MPTCP_LIB_SUBTESTS_LAST_TS_MS - ts_prev_ms))ms"
+	time+="$(((MPTCP_LIB_SUBTESTS_LAST_TS_NS - ts_prev_ns) / 1000000))ms"
 
 	MPTCP_LIB_SUBTESTS+=("${result} ${id} - ${KSFT_TEST}: ${*} ${time}")
 }

-- 
2.53.0


