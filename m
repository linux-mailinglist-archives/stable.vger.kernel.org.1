Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2967B89C8
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244217AbjJDS3L (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244285AbjJDS3K (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:29:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0FFE4
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:29:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDBCC433C9;
        Wed,  4 Oct 2023 18:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444146;
        bh=SxY+RZ/gAqeaYC3xVDJGBjg+aJpqf3pQIPGmzsrFXFY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gAy/3UEZyOuxe9N50oDiQaKMns0BDAatHS7D+28QRfKS3C4OBu4t9zxcQmfl7yJek
         mT+JosMPYHDM78MKzlu7OESb+WEAuy0stAYH/aU7Ne5quw+mqb+yxmuNjGjVQQm9Y6
         KbCBpjY49sAWELWUXVWHBbEnC+ESDzLcGMmuzXYE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 145/321] selftests/powerpc: Fix emit_tests to work with run_kselftest.sh
Date:   Wed,  4 Oct 2023 19:54:50 +0200
Message-ID: <20231004175235.967961962@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit 58b33e78a31782ffe25d404d5eba9a45fe636e27 ]

In order to use run_kselftest.sh the list of tests must be emitted to
populate kselftest-list.txt.

The powerpc Makefile is written to use EMIT_TESTS. But support for
EMIT_TESTS was dropped in commit d4e59a536f50 ("selftests: Use runner.sh
for emit targets"). Although prior to that commit a548de0fe8e1
("selftests: lib.mk: add test execute bit check to EMIT_TESTS") had
already broken run_kselftest.sh for powerpc due to the executable check
using the wrong path.

It can be fixed by replacing the EMIT_TESTS definitions with actual
emit_tests rules in the powerpc Makefiles. This makes run_kselftest.sh
able to run powerpc tests:

  $ cd linux
  $ export ARCH=powerpc
  $ export CROSS_COMPILE=powerpc64le-linux-gnu-
  $ make headers
  $ make -j -C tools/testing/selftests install
  $ grep -c "^powerpc" tools/testing/selftests/kselftest_install/kselftest-list.txt
  182

Fixes: d4e59a536f50 ("selftests: Use runner.sh for emit targets")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20230921072623.828772-1-mpe@ellerman.id.au
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/powerpc/Makefile     |  7 +++----
 tools/testing/selftests/powerpc/pmu/Makefile | 11 ++++++-----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/powerpc/Makefile b/tools/testing/selftests/powerpc/Makefile
index 49f2ad1793fd9..7ea42fa02eabd 100644
--- a/tools/testing/selftests/powerpc/Makefile
+++ b/tools/testing/selftests/powerpc/Makefile
@@ -59,12 +59,11 @@ override define INSTALL_RULE
 	done;
 endef
 
-override define EMIT_TESTS
+emit_tests:
 	+@for TARGET in $(SUB_DIRS); do \
 		BUILD_TARGET=$(OUTPUT)/$$TARGET;	\
-		$(MAKE) OUTPUT=$$BUILD_TARGET -s -C $$TARGET emit_tests;\
+		$(MAKE) OUTPUT=$$BUILD_TARGET -s -C $$TARGET $@;\
 	done;
-endef
 
 override define CLEAN
 	+@for TARGET in $(SUB_DIRS); do \
@@ -77,4 +76,4 @@ endef
 tags:
 	find . -name '*.c' -o -name '*.h' | xargs ctags
 
-.PHONY: tags $(SUB_DIRS)
+.PHONY: tags $(SUB_DIRS) emit_tests
diff --git a/tools/testing/selftests/powerpc/pmu/Makefile b/tools/testing/selftests/powerpc/pmu/Makefile
index 2b95e44d20ff9..a284fa874a9f1 100644
--- a/tools/testing/selftests/powerpc/pmu/Makefile
+++ b/tools/testing/selftests/powerpc/pmu/Makefile
@@ -30,13 +30,14 @@ override define RUN_TESTS
 	+TARGET=event_code_tests; BUILD_TARGET=$$OUTPUT/$$TARGET; $(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET run_tests
 endef
 
-DEFAULT_EMIT_TESTS := $(EMIT_TESTS)
-override define EMIT_TESTS
-	$(DEFAULT_EMIT_TESTS)
+emit_tests:
+	for TEST in $(TEST_GEN_PROGS); do \
+		BASENAME_TEST=`basename $$TEST`;	\
+		echo "$(COLLECTION):$$BASENAME_TEST";	\
+	done
 	+TARGET=ebb; BUILD_TARGET=$$OUTPUT/$$TARGET; $(MAKE) OUTPUT=$$BUILD_TARGET -s -C $$TARGET emit_tests
 	+TARGET=sampling_tests; BUILD_TARGET=$$OUTPUT/$$TARGET; $(MAKE) OUTPUT=$$BUILD_TARGET -s -C $$TARGET emit_tests
 	+TARGET=event_code_tests; BUILD_TARGET=$$OUTPUT/$$TARGET; $(MAKE) OUTPUT=$$BUILD_TARGET -s -C $$TARGET emit_tests
-endef
 
 DEFAULT_INSTALL_RULE := $(INSTALL_RULE)
 override define INSTALL_RULE
@@ -64,4 +65,4 @@ sampling_tests:
 event_code_tests:
 	TARGET=$@; BUILD_TARGET=$$OUTPUT/$$TARGET; mkdir -p $$BUILD_TARGET; $(MAKE) OUTPUT=$$BUILD_TARGET -k -C $$TARGET all
 
-.PHONY: all run_tests ebb sampling_tests event_code_tests
+.PHONY: all run_tests ebb sampling_tests event_code_tests emit_tests
-- 
2.40.1



