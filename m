Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBED6FAB34
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbjEHLKf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233850AbjEHLKX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:10:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C21534133
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5B8762B41
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A39C4339B;
        Mon,  8 May 2023 11:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544221;
        bh=qyyPlVsgzeq49LuCrJDjq9+rJyja6bS0cfDPV+OUx50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZHE2AX1VNITwdNJu4pB/n262kmO4lXs6HyXrKVw6FNMX9LzfWHN2gkaSJv6qXl/r3
         TvHEMLXmUh6BcjYfdIrmSi4aHpqwDHXS9bByeWlsyk/Lfvco8KGHNl8F16zACJghh9
         oAtbBs+OI80KxPiwvV6NwU4jcAXlfVnj4TZdgPVE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 340/694] selftests/bpf: Fix flaky fib_lookup test
Date:   Mon,  8 May 2023 11:42:55 +0200
Message-Id: <20230508094443.540009604@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Martin KaFai Lau <martin.lau@kernel.org>

[ Upstream commit a6865576317f6249f3f83cf4c10ab56e627ee153 ]

There is a report that fib_lookup test is flaky when running in parallel.
A symptom of slowness or delay. An example:

Testing IPv6 stale neigh
set_lookup_params:PASS:inet_pton(IPV6_IFACE_ADDR) 0 nsec
test_fib_lookup:PASS:bpf_prog_test_run_opts 0 nsec
test_fib_lookup:FAIL:fib_lookup_ret unexpected fib_lookup_ret: actual 0 != expected 7
test_fib_lookup:FAIL:dmac not match unexpected dmac not match: actual 1 != expected 0
dmac expected 11:11:11:11:11:11 actual 00:00:00:00:00:00

[ Note that the "fib_lookup_ret unexpected fib_lookup_ret actual 0 ..."
  is reversed in terms of expected and actual value. Fixing in this
  patch also. ]

One possibility is the testing stale neigh entry was marked dead by the
gc (in neigh_periodic_work). The default gc_stale_time sysctl is 60s.
This patch increases it to 15 mins.

It also:

- fixes the reversed arg (actual vs expected) in one of the
  ASSERT_EQ test
- removes the nodad command arg when adding v4 neigh entry which
  currently has a warning.

Fixes: 168de0233586 ("selftests/bpf: Add bpf_fib_lookup test")
Reported-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/20230309060244.3242491-1-martin.lau@linux.dev
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/fib_lookup.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/fib_lookup.c b/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
index 429393caf6122..a1e7121058118 100644
--- a/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/fib_lookup.c
@@ -54,11 +54,19 @@ static int setup_netns(void)
 	SYS(fail, "ip link add veth1 type veth peer name veth2");
 	SYS(fail, "ip link set dev veth1 up");
 
+	err = write_sysctl("/proc/sys/net/ipv4/neigh/veth1/gc_stale_time", "900");
+	if (!ASSERT_OK(err, "write_sysctl(net.ipv4.neigh.veth1.gc_stale_time)"))
+		goto fail;
+
+	err = write_sysctl("/proc/sys/net/ipv6/neigh/veth1/gc_stale_time", "900");
+	if (!ASSERT_OK(err, "write_sysctl(net.ipv6.neigh.veth1.gc_stale_time)"))
+		goto fail;
+
 	SYS(fail, "ip addr add %s/64 dev veth1 nodad", IPV6_IFACE_ADDR);
 	SYS(fail, "ip neigh add %s dev veth1 nud failed", IPV6_NUD_FAILED_ADDR);
 	SYS(fail, "ip neigh add %s dev veth1 lladdr %s nud stale", IPV6_NUD_STALE_ADDR, DMAC);
 
-	SYS(fail, "ip addr add %s/24 dev veth1 nodad", IPV4_IFACE_ADDR);
+	SYS(fail, "ip addr add %s/24 dev veth1", IPV4_IFACE_ADDR);
 	SYS(fail, "ip neigh add %s dev veth1 nud failed", IPV4_NUD_FAILED_ADDR);
 	SYS(fail, "ip neigh add %s dev veth1 lladdr %s nud stale", IPV4_NUD_STALE_ADDR, DMAC);
 
@@ -158,7 +166,7 @@ void test_fib_lookup(void)
 		if (!ASSERT_OK(err, "bpf_prog_test_run_opts"))
 			continue;
 
-		ASSERT_EQ(tests[i].expected_ret, skel->bss->fib_lookup_ret,
+		ASSERT_EQ(skel->bss->fib_lookup_ret, tests[i].expected_ret,
 			  "fib_lookup_ret");
 
 		ret = memcmp(tests[i].dmac, fib_params->dmac, sizeof(tests[i].dmac));
-- 
2.39.2



