Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A59B7ECD38
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbjKOTfI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234374AbjKOTfI (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:35:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CE019F
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:35:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 158B5C433C9;
        Wed, 15 Nov 2023 19:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076904;
        bh=ZK7W2LK4RnayVyMvXCSsnGQkeOrAyNGdqzcQNU1f2NU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DLclPL+DIvd+v1a38rK7ayWigqBrYsKbZSTsIElcTln4GpwNPDsQNj7R0CZmdi05k
         cwK0EiDxi7Oc7d3UpgZ4ai2/ARXqze/JRC9tzV2cZzNhQFCJ2fiCO1rrxtJjTURqHQ
         NZo6MUL66iOkqxciQIrplVEge7Z1f2B1VvJl4MDs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Leon Hwang <hffilwlqm@gmail.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 049/603] selftests/bpf: Correct map_fd to data_fd in tailcalls
Date:   Wed, 15 Nov 2023 14:09:54 -0500
Message-ID: <20231115191616.555227294@linuxfoundation.org>
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

From: Leon Hwang <hffilwlqm@gmail.com>

[ Upstream commit 96daa9874211d5497aa70fa409b67afc29f0cb86 ]

Get and check data_fd. It should not check map_fd again.

Meanwhile, correct some 'return' to 'goto out'.

Thank the suggestion from Maciej in "bpf, x64: Fix tailcall infinite
loop"[0] discussions.

[0] https://lore.kernel.org/bpf/e496aef8-1f80-0f8e-dcdd-25a8c300319a@gmail.com/T/#m7d3b601066ba66400d436b7e7579b2df4a101033

Fixes: 79d49ba048ec ("bpf, testing: Add various tail call test cases")
Fixes: 3b0379111197 ("selftests/bpf: Add tailcall_bpf2bpf tests")
Fixes: 5e0b0a4c52d3 ("selftests/bpf: Test tail call counting with bpf2bpf and data on stack")
Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Link: https://lore.kernel.org/r/20230906154256.95461-1-hffilwlqm@gmail.com
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../selftests/bpf/prog_tests/tailcalls.c      | 32 +++++++++----------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
index 58fe2c586ed76..09c189761926c 100644
--- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
+++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
@@ -271,11 +271,11 @@ static void test_tailcall_count(const char *which)
 
 	data_map = bpf_object__find_map_by_name(obj, "tailcall.bss");
 	if (CHECK_FAIL(!data_map || !bpf_map__is_internal(data_map)))
-		return;
+		goto out;
 
 	data_fd = bpf_map__fd(data_map);
-	if (CHECK_FAIL(map_fd < 0))
-		return;
+	if (CHECK_FAIL(data_fd < 0))
+		goto out;
 
 	i = 0;
 	err = bpf_map_lookup_elem(data_fd, &i, &val);
@@ -352,11 +352,11 @@ static void test_tailcall_4(void)
 
 	data_map = bpf_object__find_map_by_name(obj, "tailcall.bss");
 	if (CHECK_FAIL(!data_map || !bpf_map__is_internal(data_map)))
-		return;
+		goto out;
 
 	data_fd = bpf_map__fd(data_map);
-	if (CHECK_FAIL(map_fd < 0))
-		return;
+	if (CHECK_FAIL(data_fd < 0))
+		goto out;
 
 	for (i = 0; i < bpf_map__max_entries(prog_array); i++) {
 		snprintf(prog_name, sizeof(prog_name), "classifier_%d", i);
@@ -442,11 +442,11 @@ static void test_tailcall_5(void)
 
 	data_map = bpf_object__find_map_by_name(obj, "tailcall.bss");
 	if (CHECK_FAIL(!data_map || !bpf_map__is_internal(data_map)))
-		return;
+		goto out;
 
 	data_fd = bpf_map__fd(data_map);
-	if (CHECK_FAIL(map_fd < 0))
-		return;
+	if (CHECK_FAIL(data_fd < 0))
+		goto out;
 
 	for (i = 0; i < bpf_map__max_entries(prog_array); i++) {
 		snprintf(prog_name, sizeof(prog_name), "classifier_%d", i);
@@ -631,11 +631,11 @@ static void test_tailcall_bpf2bpf_2(void)
 
 	data_map = bpf_object__find_map_by_name(obj, "tailcall.bss");
 	if (CHECK_FAIL(!data_map || !bpf_map__is_internal(data_map)))
-		return;
+		goto out;
 
 	data_fd = bpf_map__fd(data_map);
-	if (CHECK_FAIL(map_fd < 0))
-		return;
+	if (CHECK_FAIL(data_fd < 0))
+		goto out;
 
 	i = 0;
 	err = bpf_map_lookup_elem(data_fd, &i, &val);
@@ -805,11 +805,11 @@ static void test_tailcall_bpf2bpf_4(bool noise)
 
 	data_map = bpf_object__find_map_by_name(obj, "tailcall.bss");
 	if (CHECK_FAIL(!data_map || !bpf_map__is_internal(data_map)))
-		return;
+		goto out;
 
 	data_fd = bpf_map__fd(data_map);
-	if (CHECK_FAIL(map_fd < 0))
-		return;
+	if (CHECK_FAIL(data_fd < 0))
+		goto out;
 
 	i = 0;
 	val.noise = noise;
@@ -872,7 +872,7 @@ static void test_tailcall_bpf2bpf_6(void)
 	ASSERT_EQ(topts.retval, 0, "tailcall retval");
 
 	data_fd = bpf_map__fd(obj->maps.bss);
-	if (!ASSERT_GE(map_fd, 0, "bss map fd"))
+	if (!ASSERT_GE(data_fd, 0, "bss map fd"))
 		goto out;
 
 	i = 0;
-- 
2.42.0



