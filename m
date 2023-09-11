Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6E979B10A
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376756AbjIKWU0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241455AbjIKPJP (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:09:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74153FA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:09:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA68BC433C7;
        Mon, 11 Sep 2023 15:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444951;
        bh=KrYrGeLCNjQ8KeRbgNJChZOii5P7ezgwiXpj7T0z9Qs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yNt7bcbIR1h4UAuwkgOSedr1wBZIev6lmYNkzUVEJ9a7qGCMqaffWU/g2Kp4pR4mq
         uDyKVU9QmJEzKvWaWxPtvEFF+JPuf24fKRA1FNBC5bsnyu3xQvxu97GenzlNxwQFGL
         g/pNCKsBpDY6qZBaPzu5rK+atUaSY4ojrcS8JttQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yipeng Zou <zouyipeng@huawei.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 175/600] selftests/bpf: Clean up fmod_ret in bench_rename test script
Date:   Mon, 11 Sep 2023 15:43:28 +0200
Message-ID: <20230911134638.768931579@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yipeng Zou <zouyipeng@huawei.com>

[ Upstream commit 83a89c4b6ae93481d3f618aba6a29d89208d26ed ]

Running the bench_rename test script, the following error occurs:

  # ./benchs/run_bench_rename.sh
  base      :    0.819 ± 0.012M/s
  kprobe    :    0.538 ± 0.009M/s
  kretprobe :    0.503 ± 0.004M/s
  rawtp     :    0.779 ± 0.020M/s
  fentry    :    0.726 ± 0.007M/s
  fexit     :    0.691 ± 0.007M/s
  benchmark 'rename-fmodret' not found

The bench_rename_fmodret has been removed in commit b000def2e052
("selftests: Remove fmod_ret from test_overhead"), thus remove it
from the runners in the test script.

Fixes: b000def2e052 ("selftests: Remove fmod_ret from test_overhead")
Signed-off-by: Yipeng Zou <zouyipeng@huawei.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/20230814030727.3010390-1-zouyipeng@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/benchs/run_bench_rename.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/benchs/run_bench_rename.sh b/tools/testing/selftests/bpf/benchs/run_bench_rename.sh
index 16f774b1cdbed..7b281dbe41656 100755
--- a/tools/testing/selftests/bpf/benchs/run_bench_rename.sh
+++ b/tools/testing/selftests/bpf/benchs/run_bench_rename.sh
@@ -2,7 +2,7 @@
 
 set -eufo pipefail
 
-for i in base kprobe kretprobe rawtp fentry fexit fmodret
+for i in base kprobe kretprobe rawtp fentry fexit
 do
 	summary=$(sudo ./bench -w2 -d5 -a rename-$i | tail -n1 | cut -d'(' -f1 | cut -d' ' -f3-)
 	printf "%-10s: %s\n" $i "$summary"
-- 
2.40.1



