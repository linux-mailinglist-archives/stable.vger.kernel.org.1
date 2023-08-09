Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9677758B4
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbjHIKzI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbjHIKy5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:54:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9DB2D4D
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:53:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D0B9630D2
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:53:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BCBBC433C7;
        Wed,  9 Aug 2023 10:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578401;
        bh=ZDRv62iHnx15vR5/unuhXh0ZVIK1FV3ojU97Kwd0vUE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nQbIRxPcqU9jT4kK3OIOyp9qV20YWQ0pqdK4lO+21q1IzvgMK7ISOZ2vPNM5eGh4q
         eHgjrpOAoX3/Ns6i9x0MO1/fM4sfv9YoK3NIErO8B11x2lrHCk0zE6KGl/zD8FOS6t
         vDqLugMB4GmPYILK+Na/y8haqRmC0tp2EDDItSsA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hou Tao <houtao1@huawei.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 047/127] bpf, cpumap: Handle skb as well when clean up ptr_ring
Date:   Wed,  9 Aug 2023 12:40:34 +0200
Message-ID: <20230809103638.242033030@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.615294317@linuxfoundation.org>
References: <20230809103636.615294317@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
index 09141351d5457..e5888d401d799 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -134,11 +134,17 @@ static void __cpu_map_ring_cleanup(struct ptr_ring *ring)
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



