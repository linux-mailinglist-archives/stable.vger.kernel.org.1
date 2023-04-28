Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6916F16BB
	for <lists+stable@lfdr.de>; Fri, 28 Apr 2023 13:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345760AbjD1LaD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 07:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345860AbjD1LaA (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 07:30:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCFF5BAC
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 04:29:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 554A564304
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 11:29:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6810CC433EF;
        Fri, 28 Apr 2023 11:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682681395;
        bh=5jKGg+kksyoy3/ViMtyVzqSuv73GO3htbOWLcm00Tos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nIyXBCLz1zqiKfi/dsJZwjpVR2NEf3DdjYOkMwGBXqU5T5SEWmZM9GQss7OjII3yT
         ovMaqBQLN4eiZw3lcKExQvKeQadLw+abToNbv4S2VOxV9BOgJvOQH2PbsNjNRm9TpW
         0US6UR1VZoj2YGjoHGrbFVKvAAY+FA7HFQrbVpjo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, SeongJae Park <sjpark@amazon.de>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.15 02/13] selftests/kselftest/runner/run_one(): allow running non-executable files
Date:   Fri, 28 Apr 2023 13:28:06 +0200
Message-Id: <20230428112039.230577601@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230428112039.133978540@linuxfoundation.org>
References: <20230428112039.133978540@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

commit 303f8e2d02002dbe331cab7813ee091aead3cd39 upstream.

When running a test program, 'run_one()' checks if the program has the
execution permission and fails if it doesn't.  However, it's easy to
mistakenly lose the permissions, as some common tools like 'diff' don't
support the permission change well[1].  Compared to that, making mistakes
in the test program's path would only rare, as those are explicitly listed
in 'TEST_PROGS'.  Therefore, it might make more sense to resolve the
situation on our own and run the program.

For this reason, this commit makes the test program runner function still
print the warning message but to try parsing the interpreter of the
program and to explicitly run it with the interpreter, in this case.

[1] https://lore.kernel.org/mm-commits/YRJisBs9AunccCD4@kroah.com/

Link: https://lkml.kernel.org/r/20210810164534.25902-1-sj38.park@gmail.com
Signed-off-by: SeongJae Park <sjpark@amazon.de>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/kselftest/runner.sh |   28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -33,9 +33,9 @@ tap_timeout()
 {
 	# Make sure tests will time out if utility is available.
 	if [ -x /usr/bin/timeout ] ; then
-		/usr/bin/timeout --foreground "$kselftest_timeout" "$1"
+		/usr/bin/timeout --foreground "$kselftest_timeout" $1
 	else
-		"$1"
+		$1
 	fi
 }
 
@@ -65,17 +65,25 @@ run_one()
 
 	TEST_HDR_MSG="selftests: $DIR: $BASENAME_TEST"
 	echo "# $TEST_HDR_MSG"
-	if [ ! -x "$TEST" ]; then
-		echo -n "# Warning: file $TEST is "
-		if [ ! -e "$TEST" ]; then
-			echo "missing!"
-		else
-			echo "not executable, correct this."
-		fi
+	if [ ! -e "$TEST" ]; then
+		echo "# Warning: file $TEST is missing!"
 		echo "not ok $test_num $TEST_HDR_MSG"
 	else
+		cmd="./$BASENAME_TEST"
+		if [ ! -x "$TEST" ]; then
+			echo "# Warning: file $TEST is not executable"
+
+			if [ $(head -n 1 "$TEST" | cut -c -2) = "#!" ]
+			then
+				interpreter=$(head -n 1 "$TEST" | cut -c 3-)
+				cmd="$interpreter ./$BASENAME_TEST"
+			else
+				echo "not ok $test_num $TEST_HDR_MSG"
+				return
+			fi
+		fi
 		cd `dirname $TEST` > /dev/null
-		((((( tap_timeout ./$BASENAME_TEST 2>&1; echo $? >&3) |
+		((((( tap_timeout "$cmd" 2>&1; echo $? >&3) |
 			tap_prefix >&4) 3>&1) |
 			(read xs; exit $xs)) 4>>"$logfile" &&
 		echo "ok $test_num $TEST_HDR_MSG") ||


