Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBA17551CD
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjGPUAZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjGPUAU (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:00:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7353DE79
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:00:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0521860EB0
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A139C433C8;
        Sun, 16 Jul 2023 20:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537616;
        bh=ToNcB7jvpqHgvbgoDoun2FE3xPmLGJvSCXx22ZcyV2w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iq6lmQET54aoJFw1ws4O1ucNPCd+dbh0Xezkw1SdRdD9Vg8OU4uqClzAAdjI/swgH
         duDD03ZE7BbuWirHjZ+ELU4g2doKkJCZPmNg0r47yqN+9qCDZb8rqQ0EqbyhZBGpEU
         xKvleDcadcu6ckws4sHazowfxO7RZHxKCN/aU6Po=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 160/800] selftests/bpf: Fix invalid pointer check in get_xlated_program()
Date:   Sun, 16 Jul 2023 21:40:13 +0200
Message-ID: <20230716194952.827567751@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Eduard Zingerman <eddyz87@gmail.com>

[ Upstream commit b23ed4d74c4d583b5f621ee4c776699442833554 ]

Dan Carpenter reported invalid check for calloc() result in
test_verifier.c:get_xlated_program():

  ./tools/testing/selftests/bpf/test_verifier.c:1365 get_xlated_program()
  warn: variable dereferenced before check 'buf' (see line 1364)

  ./tools/testing/selftests/bpf/test_verifier.c
    1363		*cnt = xlated_prog_len / buf_element_size;
    1364		*buf = calloc(*cnt, buf_element_size);
    1365		if (!buf) {

  This should be if (!*buf) {

    1366			perror("can't allocate xlated program buffer");
    1367			return -ENOMEM;

This commit refactors the get_xlated_program() to avoid using double
pointer type.

Fixes: 933ff53191eb ("selftests/bpf: specify expected instructions in test_verifier tests")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Closes: https://lore.kernel.org/bpf/ZH7u0hEGVB4MjGZq@moroto/
Link: https://lore.kernel.org/bpf/20230609221637.2631800-1-eddyz87@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/test_verifier.c | 24 +++++++++++----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index e4657c5bc3f12..4683ff84044d6 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -1227,45 +1227,46 @@ static bool cmp_str_seq(const char *log, const char *exp)
 	return true;
 }
 
-static int get_xlated_program(int fd_prog, struct bpf_insn **buf, int *cnt)
+static struct bpf_insn *get_xlated_program(int fd_prog, int *cnt)
 {
+	__u32 buf_element_size = sizeof(struct bpf_insn);
 	struct bpf_prog_info info = {};
 	__u32 info_len = sizeof(info);
 	__u32 xlated_prog_len;
-	__u32 buf_element_size = sizeof(struct bpf_insn);
+	struct bpf_insn *buf;
 
 	if (bpf_prog_get_info_by_fd(fd_prog, &info, &info_len)) {
 		perror("bpf_prog_get_info_by_fd failed");
-		return -1;
+		return NULL;
 	}
 
 	xlated_prog_len = info.xlated_prog_len;
 	if (xlated_prog_len % buf_element_size) {
 		printf("Program length %d is not multiple of %d\n",
 		       xlated_prog_len, buf_element_size);
-		return -1;
+		return NULL;
 	}
 
 	*cnt = xlated_prog_len / buf_element_size;
-	*buf = calloc(*cnt, buf_element_size);
+	buf = calloc(*cnt, buf_element_size);
 	if (!buf) {
 		perror("can't allocate xlated program buffer");
-		return -ENOMEM;
+		return NULL;
 	}
 
 	bzero(&info, sizeof(info));
 	info.xlated_prog_len = xlated_prog_len;
-	info.xlated_prog_insns = (__u64)(unsigned long)*buf;
+	info.xlated_prog_insns = (__u64)(unsigned long)buf;
 	if (bpf_prog_get_info_by_fd(fd_prog, &info, &info_len)) {
 		perror("second bpf_prog_get_info_by_fd failed");
 		goto out_free_buf;
 	}
 
-	return 0;
+	return buf;
 
 out_free_buf:
-	free(*buf);
-	return -1;
+	free(buf);
+	return NULL;
 }
 
 static bool is_null_insn(struct bpf_insn *insn)
@@ -1398,7 +1399,8 @@ static bool check_xlated_program(struct bpf_test *test, int fd_prog)
 	if (!check_expected && !check_unexpected)
 		goto out;
 
-	if (get_xlated_program(fd_prog, &buf, &cnt)) {
+	buf = get_xlated_program(fd_prog, &cnt);
+	if (!buf) {
 		printf("FAIL: can't get xlated program\n");
 		result = false;
 		goto out;
-- 
2.39.2



