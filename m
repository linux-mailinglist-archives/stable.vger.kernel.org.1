Return-Path: <stable+bounces-254790-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id HSQAMs8SGGr0cAgAu9opvQ
	(envelope-from <stable+bounces-254790-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 12:02:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1EB5F025D
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 12:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 635B0310A737
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 09:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7713B5E01;
	Thu, 28 May 2026 09:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UH6eK/ah"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649B93B6BF5
	for <stable@vger.kernel.org>; Thu, 28 May 2026 09:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779962366; cv=none; b=P4fYct5ozQnTAEetxneeA3nDqXgI+kJQ0ChZe6kwacaSCFtfGC8cFDOCaH9qfyIvU7PQEuCj7NRqPNz7fTaEPlAAH5qa66d8iRwKe6m4KxpRGCvN+SR6dFbIFbfDioKGXFQEMzhJcfioxWdq7x2C2/e0/xnPAQAZ/8mFYQg1s9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779962366; c=relaxed/simple;
	bh=RRs9HBjAPkULcyOcSWAafxiWgM/PrHGkOac1mq9lduA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pmaU9BOG27hIMSD7qnA43Fd/uk5ZJZOBuRxRYkcZ9utYtY73htvwa1omTWG1KdtWMcqgInhApUFwTFyyWItpIht/UGPIqgiQrztvNknCJj9o/Bw37ghmlSJWwnvFf3qitfp7+Sbc3hQ82Z4i2QQkkVA9zT/vpcZ38YW1LJVpCck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UH6eK/ah; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C05F1F00A3A;
	Thu, 28 May 2026 09:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779962365;
	bh=B6KlU4vb4qA9bqZBa8bmJdLt6MCQVuSs8O452E2pFRk=;
	h=Subject:To:Cc:From:Date;
	b=UH6eK/ah+SWox2AdXkaWrKm10c5fGF+OcQsb9mbttKc26HQD2lfuVQe6lOnvjZ+FH
	 2Bwnkfrt/qgXGeYoyq0wkSQgdJajSnC08SsRBj5kq3S3bhltSyfRmnL/+Mr7UXqVwQ
	 cGuyaOvnB/wwn6/UytGg3Va3gvYLdNDaF2uTkveQ=
Subject: FAILED: patch "[PATCH] selftests: mptcp: drop nanoseconds width specifier" failed to apply to 6.18-stable tree
To: matttbe@kernel.org,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 May 2026 11:58:26 +0200
Message-ID: <2026052826-strep-drum-dc14@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254790-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:dkim,msgid.link:url,gregkh:email]
X-Rspamd-Queue-Id: 5D1EB5F025D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 01ff78e4b3d98689184c52d97f9575dfbdc3b10f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052826-strep-drum-dc14@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 01ff78e4b3d98689184c52d97f9575dfbdc3b10f Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 15 May 2026 06:27:37 +0200
Subject: [PATCH] selftests: mptcp: drop nanoseconds width specifier

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
Link: https://patch.msgid.link/20260515-net-mptcp-misc-fixes-7-1-rc4-v2-6-701e96419f2f@kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

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


