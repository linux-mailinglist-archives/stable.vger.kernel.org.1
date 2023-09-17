Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7495E7A3A05
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239501AbjIQT5w (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240203AbjIQT5V (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:57:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D220EE
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:57:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5893BC433C8;
        Sun, 17 Sep 2023 19:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980635;
        bh=Bw3Nk7PrgzSbvDXDTe8dKPqMGcKpUjqQ6N6EI6+kOc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MHZT7TCEqKGpmQWat53suRr7YIRdaKRTzxOIDx5XSUj37yNCykSODq2vPXrmo14eD
         7MboSQuGJPdwLRu2kcs9lImUn39fif+L3Oafi9Mzczs7eOHkDNA7wVU4/+HgRzUZdk
         JM+KvMmsvvNqsbuP7edRkqg0QUecl6nmBbkBYqH0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Benjamin Poirier <bpoirier@nvidia.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 249/285] selftests: Keep symlinks, when possible
Date:   Sun, 17 Sep 2023 21:14:09 +0200
Message-ID: <20230917191059.937141826@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Björn Töpel <bjorn@rivosinc.com>

[ Upstream commit 3f3f384139ed147c71e1d770accf610133d5309b ]

When kselftest is built/installed with the 'gen_tar' target, rsync is
used for the installation step to copy files. Extra care is needed for
tests that have symlinks. Commit ae108c48b5d2 ("selftests: net: Fix
cross-tree inclusion of scripts") added '-L' (transform symlink into
referent file/dir) to rsync, to fix dangling links. However, that
broke some tests where the symlink (being a symlink) is part of the
test (e.g. exec:execveat).

Use rsync's '--copy-unsafe-links' that does right thing.

Fixes: ae108c48b5d2 ("selftests: net: Fix cross-tree inclusion of scripts")
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
Reviewed-by: Benjamin Poirier <bpoirier@nvidia.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/lib.mk | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index d17854285f2b6..118e0964bda94 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -106,7 +106,7 @@ endef
 run_tests: all
 ifdef building_out_of_srctree
 	@if [ "X$(TEST_PROGS)$(TEST_PROGS_EXTENDED)$(TEST_FILES)" != "X" ]; then \
-		rsync -aLq $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES) $(OUTPUT); \
+		rsync -aq --copy-unsafe-links $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES) $(OUTPUT); \
 	fi
 	@if [ "X$(TEST_PROGS)" != "X" ]; then \
 		$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) \
@@ -120,7 +120,7 @@ endif
 
 define INSTALL_SINGLE_RULE
 	$(if $(INSTALL_LIST),@mkdir -p $(INSTALL_PATH))
-	$(if $(INSTALL_LIST),rsync -aL $(INSTALL_LIST) $(INSTALL_PATH)/)
+	$(if $(INSTALL_LIST),rsync -a --copy-unsafe-links $(INSTALL_LIST) $(INSTALL_PATH)/)
 endef
 
 define INSTALL_RULE
-- 
2.40.1



