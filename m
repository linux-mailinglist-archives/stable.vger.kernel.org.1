Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8B17ECB50
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbjKOTVi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbjKOTV3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:21:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37978D67
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:21:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B168C433C8;
        Wed, 15 Nov 2023 19:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076083;
        bh=oYhAJ6fpWc+1X99dmGMNbmwHcd/XnszLb5STI4lWuxw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jzkhn/7kl7r1n3hKF9TSbwDOi3dMMNcFWVPe2M55/2WSQvTr9QN0Yb/bLi9P/RBR/
         YYjtB+K43hIBN4a2JBtKL36mT20k+mlT/LHya0IQUCj+UraLVq17s3594ZCWtdrRKc
         brXsbkGfAJu3HwW7TTY3bEyjNp4nliFQ7yPiY4zI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Artem Savkov <asavkov@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 066/550] selftests/bpf: Skip module_fentry_shadow test when bpf_testmod is not available
Date:   Wed, 15 Nov 2023 14:10:50 -0500
Message-ID: <20231115191605.266922852@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Artem Savkov <asavkov@redhat.com>

[ Upstream commit 971f7c32147f2d0953a815a109b22b8ed45949d4 ]

This test relies on bpf_testmod, so skip it if the module is not available.

Fixes: aa3d65de4b900 ("bpf/selftests: Test fentry attachment to shadowed functions")
Signed-off-by: Artem Savkov <asavkov@redhat.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20230914124928.340701-1-asavkov@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/module_fentry_shadow.c  | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/module_fentry_shadow.c b/tools/testing/selftests/bpf/prog_tests/module_fentry_shadow.c
index c7636e18b1ebd..aa9f67eb1c95b 100644
--- a/tools/testing/selftests/bpf/prog_tests/module_fentry_shadow.c
+++ b/tools/testing/selftests/bpf/prog_tests/module_fentry_shadow.c
@@ -61,6 +61,11 @@ void test_module_fentry_shadow(void)
 	int link_fd[2] = {};
 	__s32 btf_id[2] = {};
 
+	if (!env.has_testmod) {
+		test__skip();
+		return;
+	}
+
 	LIBBPF_OPTS(bpf_prog_load_opts, load_opts,
 		.expected_attach_type = BPF_TRACE_FENTRY,
 	);
-- 
2.42.0



