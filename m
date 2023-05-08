Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B81D6FAB86
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbjEHLOS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbjEHLOR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:14:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E66435D9E
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:14:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14A5A62BAA
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:14:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D50C433D2;
        Mon,  8 May 2023 11:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544455;
        bh=T4lFvYqzYjnYn0Z8YC51MaobAwSZ0/2uBIWk7ifnslc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mJWeHPFxgr6IS/hWeSl2Kccs0NJ+JTABWqLFgHEfNHdqK3TJ3sgYSfKplcj1rp12T
         0nNrPC4P95GHCDjcr+IL4nc3AE6LY8yAOxz6Pz40VBlgdddxXpWkW5D2TiOpigiaEE
         a6wuRTBjRaWHftXYq3sj5Nr7B8H7CDbQrr9V2IKk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kal Conley <kal.conley@dectris.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 386/694] selftests: xsk: Use correct UMEM size in testapp_invalid_desc
Date:   Mon,  8 May 2023 11:43:41 +0200
Message-Id: <20230508094445.511920523@linuxfoundation.org>
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

From: Kal Conley <kal.conley@dectris.com>

[ Upstream commit 7a2050df244e2c9a4e90882052b7907450ad10ed ]

Avoid UMEM_SIZE macro in testapp_invalid_desc which is incorrect when
the frame size is not XSK_UMEM__DEFAULT_FRAME_SIZE. Also remove the
macro since it's no longer being used.

Fixes: 909f0e28207c ("selftests: xsk: Add tests for 2K frame size")
Signed-off-by: Kal Conley <kal.conley@dectris.com>
Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
Link: https://lore.kernel.org/r/20230403145047.33065-2-kal.conley@dectris.com
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/xskxceiver.c | 9 +++++----
 tools/testing/selftests/bpf/xskxceiver.h | 1 -
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index a17655107a94c..5f1471f84d4bb 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -1635,6 +1635,7 @@ static void testapp_single_pkt(struct test_spec *test)
 
 static void testapp_invalid_desc(struct test_spec *test)
 {
+	u64 umem_size = test->ifobj_tx->umem->num_frames * test->ifobj_tx->umem->frame_size;
 	struct pkt pkts[] = {
 		/* Zero packet address allowed */
 		{0, PKT_SIZE, 0, true},
@@ -1645,9 +1646,9 @@ static void testapp_invalid_desc(struct test_spec *test)
 		/* Packet too large */
 		{0x2000, XSK_UMEM__INVALID_FRAME_SIZE, 0, false},
 		/* After umem ends */
-		{UMEM_SIZE, PKT_SIZE, 0, false},
+		{umem_size, PKT_SIZE, 0, false},
 		/* Straddle the end of umem */
-		{UMEM_SIZE - PKT_SIZE / 2, PKT_SIZE, 0, false},
+		{umem_size - PKT_SIZE / 2, PKT_SIZE, 0, false},
 		/* Straddle a page boundrary */
 		{0x3000 - PKT_SIZE / 2, PKT_SIZE, 0, false},
 		/* Straddle a 2K boundrary */
@@ -1665,8 +1666,8 @@ static void testapp_invalid_desc(struct test_spec *test)
 	}
 
 	if (test->ifobj_tx->shared_umem) {
-		pkts[4].addr += UMEM_SIZE;
-		pkts[5].addr += UMEM_SIZE;
+		pkts[4].addr += umem_size;
+		pkts[5].addr += umem_size;
 	}
 
 	pkt_stream_generate_custom(test, pkts, ARRAY_SIZE(pkts));
diff --git a/tools/testing/selftests/bpf/xskxceiver.h b/tools/testing/selftests/bpf/xskxceiver.h
index 3e8ec7d8ec32a..03ed33a279774 100644
--- a/tools/testing/selftests/bpf/xskxceiver.h
+++ b/tools/testing/selftests/bpf/xskxceiver.h
@@ -53,7 +53,6 @@
 #define THREAD_TMOUT 3
 #define DEFAULT_PKT_CNT (4 * 1024)
 #define DEFAULT_UMEM_BUFFERS (DEFAULT_PKT_CNT / 4)
-#define UMEM_SIZE (DEFAULT_UMEM_BUFFERS * XSK_UMEM__DEFAULT_FRAME_SIZE)
 #define RX_FULL_RXQSIZE 32
 #define UMEM_HEADROOM_TEST_SIZE 128
 #define XSK_UMEM__INVALID_FRAME_SIZE (XSK_UMEM__DEFAULT_FRAME_SIZE + 1)
-- 
2.39.2



