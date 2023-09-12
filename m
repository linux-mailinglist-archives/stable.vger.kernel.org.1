Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8847479B621
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243125AbjIKU7G (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239968AbjIKOcv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:32:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133BCF2
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:32:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D46C433C8;
        Mon, 11 Sep 2023 14:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442766;
        bh=Yi4tbYHiWD6lFZa80tnWZTGshfk98PvJXTCrAP6QrRU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S1HOp4mDpuLl2k5QIrCaE2zP/6S68KrK3Q/8QEQzCklqqLZnMZtafok6RP0H+t0uF
         7Lw+NfkGjpq94wQXtYUWHUDLmzLydRhgMOG/doLudH2+3Vv8LffuN5bOGD4UUXoTjT
         FiJAj9xect1vu+zdLVw0/dTwe3rLyIdEXl/+SkyM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 140/737] selftests/bpf: Fix bpf_nf failure upon test rerun
Date:   Mon, 11 Sep 2023 15:39:59 +0200
Message-ID: <20230911134654.409755962@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit 17e8e5d6e09adb4b4f4fb5c89b3ec3fcae2c64a6 ]

Alexei reported:

  After fast forwarding bpf-next today bpf_nf test started to fail when
  run twice:

  $ ./test_progs -t bpf_nf
  #17      bpf_nf:OK
  Summary: 1/10 PASSED, 0 SKIPPED, 0 FAILED

  $ ./test_progs -t bpf_nf
  All error logs:
  test_bpf_nf_ct:PASS:test_bpf_nf__open_and_load 0 nsec
  test_bpf_nf_ct:PASS:iptables-legacy -t raw -A PREROUTING -j CONNMARK
  --set-mark 42/0 0 nsec
  (network_helpers.c:102: errno: Address already in use) Failed to bind socket
  test_bpf_nf_ct:FAIL:start_server unexpected start_server: actual -1 < expected 0
  #17/1    bpf_nf/xdp-ct:FAIL
  test_bpf_nf_ct:PASS:test_bpf_nf__open_and_load 0 nsec
  test_bpf_nf_ct:PASS:iptables-legacy -t raw -A PREROUTING -j CONNMARK
  --set-mark 42/0 0 nsec
  (network_helpers.c:102: errno: Address already in use) Failed to bind socket
  test_bpf_nf_ct:FAIL:start_server unexpected start_server: actual -1 < expected 0
  #17/2    bpf_nf/tc-bpf-ct:FAIL
  #17      bpf_nf:FAIL
  Summary: 0/8 PASSED, 0 SKIPPED, 1 FAILED

I was able to locally reproduce as well. Rearrange the connection teardown
so that the client closes its connection first so that we don't need to
linger in TCP time-wait.

Fixes: e81fbd4c1ba7 ("selftests/bpf: Add existing connection bpf_*_ct_lookup() test")
Reported-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/CAADnVQ+0dnDq_v_vH1EfkacbfGnHANaon7zsw10pMb-D9FS0Pw@mail.gmail.com
Link: https://lore.kernel.org/bpf/20230626131942.5100-1-daniel@iogearbox.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/bpf_nf.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_nf.c b/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
index c8ba4009e4ab9..b30ff6b3b81ae 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
@@ -123,12 +123,13 @@ static void test_bpf_nf_ct(int mode)
 	ASSERT_EQ(skel->data->test_snat_addr, 0, "Test for source natting");
 	ASSERT_EQ(skel->data->test_dnat_addr, 0, "Test for destination natting");
 end:
-	if (srv_client_fd != -1)
-		close(srv_client_fd);
 	if (client_fd != -1)
 		close(client_fd);
+	if (srv_client_fd != -1)
+		close(srv_client_fd);
 	if (srv_fd != -1)
 		close(srv_fd);
+
 	snprintf(cmd, sizeof(cmd), iptables, "-D");
 	system(cmd);
 	test_bpf_nf__destroy(skel);
-- 
2.40.1



