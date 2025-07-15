Return-Path: <stable+bounces-162100-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F12BCB05B8A
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A2EE1C20140
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFA72E339E;
	Tue, 15 Jul 2025 13:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KZc1eaHo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4AA2E3372;
	Tue, 15 Jul 2025 13:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585672; cv=none; b=BlWlZr3kizElafr4Z28FT/TWPMEXh/rIQSptYfQcxi+VImQCQOYVIMPCA7f+tzevZfcA5ToXaXRErZS6/4uYQOQPFNvd9KnFofMSVyBxqhaNZubyZAuwVIAHJTuau2Hmgg7nPfc82s2vaOoW3vkYMoIuh2dJd/VVCzo6C7UmWzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585672; c=relaxed/simple;
	bh=0kivPY3C4D+DBmOuF/5MUds8s7Vky50fX01EWfU+k5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t/Mz4WCdSwwbNzekwSAOXY1g7DBGCsApdvMNdgs5e0YVWYDYwBni2FbeVYS+Gg02torCCjL3XhQtagrvirlGhL1jKtXlnAq303zHlOOMrGY8Si3oPXE+Goc9tV6oqAZW8t5P8DJT+H3/N/dL2QY2u1CK47PZPD70UpMkleIdPjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KZc1eaHo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42292C4CEF6;
	Tue, 15 Jul 2025 13:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752585672;
	bh=0kivPY3C4D+DBmOuF/5MUds8s7Vky50fX01EWfU+k5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KZc1eaHoQMmUSCEoZZ12UmNTPtPE0AqIu3/qfraybAyqcb6OXEx1lmZfI9Scjb2ie
	 COJmmD71K2mI1MbI2L9mt9qJub5VXS+Qi3SBTWDeO/3cv24LBP0DUa3M+mkKyxwgHw
	 UJTQeSMrb1tzn2vgDLbMk/XbprDWzNRW5LtqnYbo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Petr Machata <petrm@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 129/163] selftests: net: lib: Move logging from forwarding/lib.sh here
Date: Tue, 15 Jul 2025 15:13:17 +0200
Message-ID: <20250715130814.017568803@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130808.777350091@linuxfoundation.org>
References: <20250715130808.777350091@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Petr Machata <petrm@nvidia.com>

[ Upstream commit b219bcfcc92e9bd50c6277ac68cb75f64b403e5e ]

Many net selftests invent their own logging helpers. These really should be
in a library sourced by these tests. Currently forwarding/lib.sh has a
suite of perfectly fine logging helpers, but sourcing a forwarding/ library
from a higher-level directory smells of layering violation. In this patch,
move the logging helpers to net/lib.sh so that every net test can use them.

Together with the logging helpers, it's also necessary to move
pause_on_fail(), and EXIT_STATUS and RET.

Existing lib.sh users might be using these same names for their functions
or variables. However lib.sh is always sourced near the top of the
file (checked), and whatever new definitions will simply override the ones
provided by lib.sh.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Link: https://patch.msgid.link/edd3785a3bd72ffbe1409300989e993ee50ae98b.1731589511.git.petrm@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 47c84997c686 ("selftests: net: lib: fix shift count out of range")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/forwarding/lib.sh | 113 -----------------
 tools/testing/selftests/net/lib.sh            | 115 ++++++++++++++++++
 2 files changed, 115 insertions(+), 113 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index c992e385159c0..195360082d949 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -48,7 +48,6 @@ declare -A NETIFS=(
 : "${WAIT_TIME:=5}"
 
 # Whether to pause on, respectively, after a failure and before cleanup.
-: "${PAUSE_ON_FAIL:=no}"
 : "${PAUSE_ON_CLEANUP:=no}"
 
 # Whether to create virtual interfaces, and what netdevice type they should be.
@@ -446,22 +445,6 @@ done
 ##############################################################################
 # Helpers
 
-# Exit status to return at the end. Set in case one of the tests fails.
-EXIT_STATUS=0
-# Per-test return value. Clear at the beginning of each test.
-RET=0
-
-ret_set_ksft_status()
-{
-	local ksft_status=$1; shift
-	local msg=$1; shift
-
-	RET=$(ksft_status_merge $RET $ksft_status)
-	if (( $? )); then
-		retmsg=$msg
-	fi
-}
-
 # Whether FAILs should be interpreted as XFAILs. Internal.
 FAIL_TO_XFAIL=
 
@@ -535,102 +518,6 @@ xfail_on_veth()
 	fi
 }
 
-log_test_result()
-{
-	local test_name=$1; shift
-	local opt_str=$1; shift
-	local result=$1; shift
-	local retmsg=$1; shift
-
-	printf "TEST: %-60s  [%s]\n" "$test_name $opt_str" "$result"
-	if [[ $retmsg ]]; then
-		printf "\t%s\n" "$retmsg"
-	fi
-}
-
-pause_on_fail()
-{
-	if [[ $PAUSE_ON_FAIL == yes ]]; then
-		echo "Hit enter to continue, 'q' to quit"
-		read a
-		[[ $a == q ]] && exit 1
-	fi
-}
-
-handle_test_result_pass()
-{
-	local test_name=$1; shift
-	local opt_str=$1; shift
-
-	log_test_result "$test_name" "$opt_str" " OK "
-}
-
-handle_test_result_fail()
-{
-	local test_name=$1; shift
-	local opt_str=$1; shift
-
-	log_test_result "$test_name" "$opt_str" FAIL "$retmsg"
-	pause_on_fail
-}
-
-handle_test_result_xfail()
-{
-	local test_name=$1; shift
-	local opt_str=$1; shift
-
-	log_test_result "$test_name" "$opt_str" XFAIL "$retmsg"
-	pause_on_fail
-}
-
-handle_test_result_skip()
-{
-	local test_name=$1; shift
-	local opt_str=$1; shift
-
-	log_test_result "$test_name" "$opt_str" SKIP "$retmsg"
-}
-
-log_test()
-{
-	local test_name=$1
-	local opt_str=$2
-
-	if [[ $# -eq 2 ]]; then
-		opt_str="($opt_str)"
-	fi
-
-	if ((RET == ksft_pass)); then
-		handle_test_result_pass "$test_name" "$opt_str"
-	elif ((RET == ksft_xfail)); then
-		handle_test_result_xfail "$test_name" "$opt_str"
-	elif ((RET == ksft_skip)); then
-		handle_test_result_skip "$test_name" "$opt_str"
-	else
-		handle_test_result_fail "$test_name" "$opt_str"
-	fi
-
-	EXIT_STATUS=$(ksft_exit_status_merge $EXIT_STATUS $RET)
-	return $RET
-}
-
-log_test_skip()
-{
-	RET=$ksft_skip retmsg= log_test "$@"
-}
-
-log_test_xfail()
-{
-	RET=$ksft_xfail retmsg= log_test "$@"
-}
-
-log_info()
-{
-	local msg=$1
-
-	echo "INFO: $msg"
-}
-
 not()
 {
 	"$@"
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index be8707bfb46e5..6839514a176d3 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -6,6 +6,9 @@
 
 : "${WAIT_TIMEOUT:=20}"
 
+# Whether to pause on after a failure.
+: "${PAUSE_ON_FAIL:=no}"
+
 BUSYWAIT_TIMEOUT=$((WAIT_TIMEOUT * 1000)) # ms
 
 # Kselftest framework constants.
@@ -17,6 +20,11 @@ ksft_skip=4
 # namespace list created by setup_ns
 NS_LIST=()
 
+# Exit status to return at the end. Set in case one of the tests fails.
+EXIT_STATUS=0
+# Per-test return value. Clear at the beginning of each test.
+RET=0
+
 ##############################################################################
 # Helpers
 
@@ -233,3 +241,110 @@ tc_rule_handle_stats_get()
 	    | jq ".[] | select(.options.handle == $handle) | \
 		  .options.actions[0].stats$selector"
 }
+
+ret_set_ksft_status()
+{
+	local ksft_status=$1; shift
+	local msg=$1; shift
+
+	RET=$(ksft_status_merge $RET $ksft_status)
+	if (( $? )); then
+		retmsg=$msg
+	fi
+}
+
+log_test_result()
+{
+	local test_name=$1; shift
+	local opt_str=$1; shift
+	local result=$1; shift
+	local retmsg=$1; shift
+
+	printf "TEST: %-60s  [%s]\n" "$test_name $opt_str" "$result"
+	if [[ $retmsg ]]; then
+		printf "\t%s\n" "$retmsg"
+	fi
+}
+
+pause_on_fail()
+{
+	if [[ $PAUSE_ON_FAIL == yes ]]; then
+		echo "Hit enter to continue, 'q' to quit"
+		read a
+		[[ $a == q ]] && exit 1
+	fi
+}
+
+handle_test_result_pass()
+{
+	local test_name=$1; shift
+	local opt_str=$1; shift
+
+	log_test_result "$test_name" "$opt_str" " OK "
+}
+
+handle_test_result_fail()
+{
+	local test_name=$1; shift
+	local opt_str=$1; shift
+
+	log_test_result "$test_name" "$opt_str" FAIL "$retmsg"
+	pause_on_fail
+}
+
+handle_test_result_xfail()
+{
+	local test_name=$1; shift
+	local opt_str=$1; shift
+
+	log_test_result "$test_name" "$opt_str" XFAIL "$retmsg"
+	pause_on_fail
+}
+
+handle_test_result_skip()
+{
+	local test_name=$1; shift
+	local opt_str=$1; shift
+
+	log_test_result "$test_name" "$opt_str" SKIP "$retmsg"
+}
+
+log_test()
+{
+	local test_name=$1
+	local opt_str=$2
+
+	if [[ $# -eq 2 ]]; then
+		opt_str="($opt_str)"
+	fi
+
+	if ((RET == ksft_pass)); then
+		handle_test_result_pass "$test_name" "$opt_str"
+	elif ((RET == ksft_xfail)); then
+		handle_test_result_xfail "$test_name" "$opt_str"
+	elif ((RET == ksft_skip)); then
+		handle_test_result_skip "$test_name" "$opt_str"
+	else
+		handle_test_result_fail "$test_name" "$opt_str"
+	fi
+
+	EXIT_STATUS=$(ksft_exit_status_merge $EXIT_STATUS $RET)
+	return $RET
+}
+
+log_test_skip()
+{
+	RET=$ksft_skip retmsg= log_test "$@"
+}
+
+log_test_xfail()
+{
+	RET=$ksft_xfail retmsg= log_test "$@"
+}
+
+log_info()
+{
+	local msg=$1
+
+	echo "INFO: $msg"
+}
-- 
2.39.5




