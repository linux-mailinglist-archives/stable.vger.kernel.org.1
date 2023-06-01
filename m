Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1BB1719DFE
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbjFAN2O (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233908AbjFAN17 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:27:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542F2E44
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:27:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE786644E1
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:27:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E59C4339B;
        Thu,  1 Jun 2023 13:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685626056;
        bh=ulvRY/7XrCE9eSQfr8Le5Vqa2oCCxGHbfF6+wbput/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aqeRGLXdrxjbeZ+W9HyTcZ6WNf79UKEl2QE5xZ3fPM39GLeafnDBEMdqevBQUPao1
         A7CKlnjTFmfGnfPkkydlM2d4XwirF1CJZLnxGfFBTIydaN1Q/w/ZY/EMZN9caiTi5a
         FsSGuJq318zud6JYft2+/vcoEy5KdLs54vTJddlU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jeremy Sowden <jeremy@azazel.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 04/42] selftests/bpf: Fix pkg-config call building sign-file
Date:   Thu,  1 Jun 2023 14:21:13 +0100
Message-Id: <20230601131939.253578766@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131939.051934720@linuxfoundation.org>
References: <20230601131939.051934720@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jeremy Sowden <jeremy@azazel.net>

[ Upstream commit 5f5486b620cd43b16a1787ef92b9bc21bd72ef2e ]

When building sign-file, the call to get the CFLAGS for libcrypto is
missing white-space between `pkg-config` and `--cflags`:

  $(shell $(HOSTPKG_CONFIG)--cflags libcrypto 2> /dev/null)

Removing the redirection of stderr, we see:

  $ make -C tools/testing/selftests/bpf sign-file
  make: Entering directory '[...]/tools/testing/selftests/bpf'
  make: pkg-config--cflags: No such file or directory
    SIGN-FILE sign-file
  make: Leaving directory '[...]/tools/testing/selftests/bpf'

Add the missing space.

Fixes: fc97590668ae ("selftests/bpf: Add test for bpf_verify_pkcs7_signature() kfunc")
Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
Link: https://lore.kernel.org/bpf/20230426215032.415792-1-jeremy@azazel.net
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 687249d99b5f1..0465ddc81f352 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -193,7 +193,7 @@ $(OUTPUT)/urandom_read: urandom_read.c urandom_read_aux.c $(OUTPUT)/liburandom_r
 
 $(OUTPUT)/sign-file: ../../../../scripts/sign-file.c
 	$(call msg,SIGN-FILE,,$@)
-	$(Q)$(CC) $(shell $(HOSTPKG_CONFIG)--cflags libcrypto 2> /dev/null) \
+	$(Q)$(CC) $(shell $(HOSTPKG_CONFIG) --cflags libcrypto 2> /dev/null) \
 		  $< -o $@ \
 		  $(shell $(HOSTPKG_CONFIG) --libs libcrypto 2> /dev/null || echo -lcrypto)
 
-- 
2.39.2



