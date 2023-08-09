Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B7D77579C
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbjHIKsF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbjHIKsE (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:48:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40F410FF
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:48:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 793DA63121
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:48:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E25C433C7;
        Wed,  9 Aug 2023 10:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578082;
        bh=LgBpsATyBUPWy4Kr/KjD51qnxxijMEVwoeXls8XSSbI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s1p3Xz0hJjLcQ1LfIZ2b5asoVnXZjHZLmNFY//ABoEqXEoLMl5q6ou5GBSgUm7+rZ
         tbuM2B701SOtyh4PZGaH18PW2BTT6ffFmK3rqmntSG2FUYtbJMa5ZbXwfqBU9hm8l2
         7MmJsOG7w9ZHiWzE5+n1CCbDeUzvcCqXsPmv9DF0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hou Tao <houtao1@huawei.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 070/165] bpf, cpumap: Handle skb as well when clean up ptr_ring
Date:   Wed,  9 Aug 2023 12:40:01 +0200
Message-ID: <20230809103645.096395664@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
References: <20230809103642.720851262@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

[ Upstream commit 7c62b75cd1a792e14b037fa4f61f9b18914e7de1 ]

The following warning was reported when running xdp_redirect_cpu with
both skb-mode and stress-mode enabled:

  ------------[ cut here ]------------
  Incorrect XDP memory type (-2128176192) usage
  WARNING: CPU: 7 PID: 1442 at net/core/xdp.c:405
  Modules linked in:
  CPU: 7 PID: 1442 Comm: kworker/7:0 Tainted: G  6.5.0-rc2+ #1
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
  Workqueue: events __cpu_map_entry_free
  RIP: 0010:__xdp_return+0x1e4/0x4a0
  ......
  Call Trace:
   <TASK>
   ? show_regs+0x65/0x70
   ? __warn+0xa5/0x240
   ? __xdp_return+0x1e4/0x4a0
   ......
   xdp_return_frame+0x4d/0x150
   __cpu_map_entry_free+0xf9/0x230
   process_one_work+0x6b0/0xb80
   worker_thread+0x96/0x720
   kthread+0x1a5/0x1f0
   ret_from_fork+0x3a/0x70
   ret_from_fork_asm+0x1b/0x30
   </TASK>

The reason for the warning is twofold. One is due to the kthread
cpu_map_kthread_run() is stopped prematurely. Another one is
__cpu_map_ring_cleanup() doesn't handle skb mode and treats skbs in
ptr_ring as XDP frames.

Prematurely-stopped kthread will be fixed by the preceding patch and
ptr_ring will be empty when __cpu_map_ring_cleanup() is called. But
as the comments in __cpu_map_ring_cleanup() said, handling and freeing
skbs in ptr_ring as well to "catch any broken behaviour gracefully".

Fixes: 11941f8a8536 ("bpf: cpumap: Implement generic cpumap")
Signed-off-by: Hou Tao <houtao1@huawei.com>
Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
Link: https://lore.kernel.org/r/20230729095107.1722450-3-houtao@huaweicloud.com
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/cpumap.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 7eeb200251640..286ab3db0fde8 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -131,11 +131,17 @@ static void __cpu_map_ring_cleanup(struct ptr_ring *ring)
 	 * invoked cpu_map_kthread_stop(). Catch any broken behaviour
 	 * gracefully and warn once.
 	 */
-	struct xdp_frame *xdpf;
+	void *ptr;
 
-	while ((xdpf = ptr_ring_consume(ring)))
-		if (WARN_ON_ONCE(xdpf))
-			xdp_return_frame(xdpf);
+	while ((ptr = ptr_ring_consume(ring))) {
+		WARN_ON_ONCE(1);
+		if (unlikely(__ptr_test_bit(0, &ptr))) {
+			__ptr_clear_bit(0, &ptr);
+			kfree_skb(ptr);
+			continue;
+		}
+		xdp_return_frame(ptr);
+	}
 }
 
 static void put_cpu_map_entry(struct bpf_cpu_map_entry *rcpu)
-- 
2.40.1



