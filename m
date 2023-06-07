Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73E6726FEB
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 23:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236126AbjFGVDR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 17:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236017AbjFGVC5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 17:02:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8011230EB
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 14:02:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EDA761EA2
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 21:02:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70391C433EF;
        Wed,  7 Jun 2023 21:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171746;
        bh=oJKK9qIShrjckbREnntpRlC5yHfLX2vzMfaH5BMsbqY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QGNV5mqxld8hX5APCIxlZn9RVUwyd796XbFJM386CHS2RlfMmRnNOWN5vW42m3fAC
         VQWu86762DlUnhuvb4T3wQMGgy9uoVDcvwcvF+9okkRmMz/ksw40HLY+1XWbzF4dSR
         BqoRYHbDbLzZqaH2ot+dTxbVFexThsua+lTCs1vE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH 5.15 133/159] selftests: mptcp: connect: skip if MPTCP is not supported
Date:   Wed,  7 Jun 2023 22:17:16 +0200
Message-ID: <20230607200908.027369227@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200903.652580797@linuxfoundation.org>
References: <20230607200903.652580797@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Matthieu Baerts <matthieu.baerts@tessares.net>

commit d83013bdf90a7994a474b0e650a7fc94b0d4ded6 upstream.

Selftests are supposed to run on any kernels, including the old ones not
supporting MPTCP.

A new check is then added to make sure MPTCP is supported. If not, the
test stops and is marked as "skipped". Note that this check can also
mark the test as failed if 'SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES' env
var is set to 1: by doing that, we can make sure a test is not being
skipped by mistake.

A new shared file is added here to be able to re-used the same check in
the different selftests we have.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 048d19d444be ("mptcp: add basic kselftest for mptcp")
Cc: stable@vger.kernel.org
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/Makefile         |    2 -
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |    4 ++
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |   40 +++++++++++++++++++++
 3 files changed, 45 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/net/mptcp/mptcp_lib.sh

--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -10,7 +10,7 @@ TEST_PROGS := mptcp_connect.sh pm_netlin
 
 TEST_GEN_FILES = mptcp_connect pm_nl_ctl
 
-TEST_FILES := settings
+TEST_FILES := mptcp_lib.sh settings
 
 EXTRA_CLEAN := *.pcap
 
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -1,6 +1,8 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+. "$(dirname "${0}")/mptcp_lib.sh"
+
 time_start=$(date +%s)
 
 optstring="S:R:d:e:l:r:h4cm:f:tC"
@@ -138,6 +140,8 @@ cleanup()
 	done
 }
 
+mptcp_lib_check_mptcp
+
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -0,0 +1,40 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+readonly KSFT_FAIL=1
+readonly KSFT_SKIP=4
+
+# SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var can be set when validating all
+# features using the last version of the kernel and the selftests to make sure
+# a test is not being skipped by mistake.
+mptcp_lib_expect_all_features() {
+	[ "${SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES:-}" = "1" ]
+}
+
+# $1: msg
+mptcp_lib_fail_if_expected_feature() {
+	if mptcp_lib_expect_all_features; then
+		echo "ERROR: missing feature: ${*}"
+		exit ${KSFT_FAIL}
+	fi
+
+	return 1
+}
+
+# $1: file
+mptcp_lib_has_file() {
+	local f="${1}"
+
+	if [ -f "${f}" ]; then
+		return 0
+	fi
+
+	mptcp_lib_fail_if_expected_feature "${f} file not found"
+}
+
+mptcp_lib_check_mptcp() {
+	if ! mptcp_lib_has_file "/proc/sys/net/mptcp/enabled"; then
+		echo "SKIP: MPTCP support is not available"
+		exit ${KSFT_SKIP}
+	fi
+}


