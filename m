Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9AF36FA80C
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234726AbjEHKhN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234763AbjEHKgy (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:36:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0262ADC5E
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:36:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E59A627D1
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:36:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DBB5C433EF;
        Mon,  8 May 2023 10:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542211;
        bh=GX31uYiQd+Qe+Ty2GIohKZrgGp6XxUZxZqptURN6Eas=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mLqAv3t7XyxTvcT5cjVceEA/lTEVIenuuGagLk8Z5axhBnLrcNB2SkqadoxKf5bVv
         hIMqPGSutkkcE17DBCYSGkfUg4+/iLNDGb62Mh6Zyd6Lmp6KLVbl+lZ8RN+qmxOZ5p
         UFPzfpbwmXkknleZoJc0zRm+Ic8XDGkIrbuOprXE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Song Liu <song@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 363/663] selftests/bpf: Fix leaked bpf_link in get_stackid_cannot_attach
Date:   Mon,  8 May 2023 11:43:09 +0200
Message-Id: <20230508094439.930291019@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Song Liu <song@kernel.org>

[ Upstream commit c1e07a80cf23d3a6e96172bc9a73bfa912a9fcbc ]

skel->links.oncpu is leaked in one case. This causes test perf_branches
fails when it runs after get_stackid_cannot_attach:

./test_progs -t get_stackid_cannot_attach,perf_branches
84      get_stackid_cannot_attach:OK
test_perf_branches_common:PASS:test_perf_branches_load 0 nsec
test_perf_branches_common:PASS:attach_perf_event 0 nsec
test_perf_branches_common:PASS:set_affinity 0 nsec
check_good_sample:FAIL:output not valid no valid sample from prog
146/1   perf_branches/perf_branches_hw:FAIL
146/2   perf_branches/perf_branches_no_hw:OK
146     perf_branches:FAIL

All error logs:
test_perf_branches_common:PASS:test_perf_branches_load 0 nsec
test_perf_branches_common:PASS:attach_perf_event 0 nsec
test_perf_branches_common:PASS:set_affinity 0 nsec
check_good_sample:FAIL:output not valid no valid sample from prog
146/1   perf_branches/perf_branches_hw:FAIL
146     perf_branches:FAIL
Summary: 1/1 PASSED, 0 SKIPPED, 1 FAILED

Fix this by adding the missing bpf_link__destroy().

Fixes: 346938e9380c ("selftests/bpf: Add get_stackid_cannot_attach")
Signed-off-by: Song Liu <song@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/20230412210423.900851-3-song@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/get_stackid_cannot_attach.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/get_stackid_cannot_attach.c b/tools/testing/selftests/bpf/prog_tests/get_stackid_cannot_attach.c
index 5308de1ed478e..2715c68301f52 100644
--- a/tools/testing/selftests/bpf/prog_tests/get_stackid_cannot_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/get_stackid_cannot_attach.c
@@ -65,6 +65,7 @@ void test_get_stackid_cannot_attach(void)
 	skel->links.oncpu = bpf_program__attach_perf_event(skel->progs.oncpu,
 							   pmu_fd);
 	ASSERT_OK_PTR(skel->links.oncpu, "attach_perf_event_callchain");
+	bpf_link__destroy(skel->links.oncpu);
 	close(pmu_fd);
 
 	/* add exclude_callchain_kernel, attach should fail */
-- 
2.39.2



