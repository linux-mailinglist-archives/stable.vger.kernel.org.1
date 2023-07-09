Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A31574C286
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjGILVf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjGILVe (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:21:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F79B5
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:21:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4085B60BC0
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:21:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2F1C433C8;
        Sun,  9 Jul 2023 11:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901692;
        bh=sBUJ8ybF0GOqBJDIqoc1bqU5xEkn/bcDBo49I0iRFN0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=shug2pp8f27bdr5DF+jYVod2JFebLxdODj86o0yP/pMBPXyO14mSdDqn0jqLDVLxv
         TJtRu7Q34FmzTPB0LHIrDE1IvfgxS9HpmyPz+VCWFQ0+6dpYkKC+79Xj03SBY7PohA
         hMyvYXSp8bffU8cCQ3zsTzQa3H6/642FPkqDPbNg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alexey Gladkov <legion@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Stanislav Fomichev <sdf@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 093/431] selftests/bpf: Do not use sign-file as testcase
Date:   Sun,  9 Jul 2023 13:10:41 +0200
Message-ID: <20230709111453.332030229@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alexey Gladkov <legion@kernel.org>

[ Upstream commit f04a32b2c5b539e3c097cb5c7c1df12a8f4a0cf0 ]

The sign-file utility (from scripts/) is used in prog_tests/verify_pkcs7_sig.c,
but the utility should not be called as a test. Executing this utility produces
the following error:

  selftests: /linux/tools/testing/selftests/bpf: urandom_read
  ok 16 selftests: /linux/tools/testing/selftests/bpf: urandom_read

  selftests: /linux/tools/testing/selftests/bpf: sign-file
  not ok 17 selftests: /linux/tools/testing/selftests/bpf: sign-file # exit=2

Also, urandom_read is mistakenly used as a test. It does not lead to an error,
but should be moved over to TEST_GEN_FILES as well. The empty TEST_CUSTOM_PROGS
can then be removed.

Fixes: fc97590668ae ("selftests/bpf: Add test for bpf_verify_pkcs7_signature() kfunc")
Signed-off-by: Alexey Gladkov <legion@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
Acked-by: Stanislav Fomichev <sdf@google.com>
Link: https://lore.kernel.org/bpf/ZEuWFk3QyML9y5QQ@example.org
Link: https://lore.kernel.org/bpf/88e3ab23029d726a2703adcf6af8356f7a2d3483.1684316821.git.legion@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index ad01c9e1ff12b..625eedb84eecc 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -88,8 +88,7 @@ TEST_GEN_PROGS_EXTENDED = test_sock_addr test_skb_cgroup_id_user \
 	xskxceiver xdp_redirect_multi xdp_synproxy veristat xdp_hw_metadata \
 	xdp_features
 
-TEST_CUSTOM_PROGS = $(OUTPUT)/urandom_read $(OUTPUT)/sign-file
-TEST_GEN_FILES += liburandom_read.so
+TEST_GEN_FILES += liburandom_read.so urandom_read sign-file
 
 # Emit succinct information message describing current building step
 # $1 - generic step name (e.g., CC, LINK, etc);
-- 
2.39.2



