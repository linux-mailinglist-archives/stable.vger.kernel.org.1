Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D407ECD1B
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234326AbjKOTeZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234310AbjKOTeZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:34:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1C41A8
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:34:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 978FDC433CC;
        Wed, 15 Nov 2023 19:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076859;
        bh=spnA0tdjKs01s53+aBG2tJJW9IzNYyecRmYc5KHq+rA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EwXZ80hZDjzXUr93Hf8VJhTPUGettq8aY1jPbk9ruKh+DMC2OybyCH+xQnusZb3Fo
         mWYKJm9Ioo98N8IQNs6PCfIoywATnEOxz43Y0naWjTau1tB/rqGwiKUOoy8/U3RwSw
         46JHd81J3Qda93XvbyBa7G4uX5nNcNV49sUkB55o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Binbin Wu <binbin.wu@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 031/603] selftests/x86/lam: Zero out buffer for readlink()
Date:   Wed, 15 Nov 2023 14:09:36 -0500
Message-ID: <20231115191615.336203599@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Binbin Wu <binbin.wu@linux.intel.com>

[ Upstream commit 29060633411a02f6f2dd9d5245919385d69d81f0 ]

Zero out the buffer for readlink() since readlink() does not append a
terminating null byte to the buffer.  Also change the buffer length
passed to readlink() to 'PATH_MAX - 1' to ensure the resulting string
is always null terminated.

Fixes: 833c12ce0f430 ("selftests/x86/lam: Add inherit test cases for linear-address masking")
Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Link: https://lore.kernel.org/r/20231016062446.695-1-binbin.wu@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/x86/lam.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
index eb0e46905bf9d..8f9b06d9ce039 100644
--- a/tools/testing/selftests/x86/lam.c
+++ b/tools/testing/selftests/x86/lam.c
@@ -573,7 +573,7 @@ int do_uring(unsigned long lam)
 	char path[PATH_MAX] = {0};
 
 	/* get current process path */
-	if (readlink("/proc/self/exe", path, PATH_MAX) <= 0)
+	if (readlink("/proc/self/exe", path, PATH_MAX - 1) <= 0)
 		return 1;
 
 	int file_fd = open(path, O_RDONLY);
@@ -680,14 +680,14 @@ static int handle_execve(struct testcases *test)
 		perror("Fork failed.");
 		ret = 1;
 	} else if (pid == 0) {
-		char path[PATH_MAX];
+		char path[PATH_MAX] = {0};
 
 		/* Set LAM mode in parent process */
 		if (set_lam(lam) != 0)
 			return 1;
 
 		/* Get current binary's path and the binary was run by execve */
-		if (readlink("/proc/self/exe", path, PATH_MAX) <= 0)
+		if (readlink("/proc/self/exe", path, PATH_MAX - 1) <= 0)
 			exit(-1);
 
 		/* run binary to get LAM mode and return to parent process */
-- 
2.42.0



