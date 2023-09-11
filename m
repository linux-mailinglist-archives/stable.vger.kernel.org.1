Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A367579B474
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351104AbjIKVmm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239823AbjIKO3i (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:29:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC96F0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:29:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58DB1C433C7;
        Mon, 11 Sep 2023 14:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442573;
        bh=bVdzUn5wNl/zXaNxov04aAb65eCejgLXsSLNsFnwUAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uEV+oHZZ9Eze1Cjf+2yOCBsuCDrOo+bYc+AOtbA96ZIyfdn9CGYjrbBf6d6v8ASLt
         Vb23+M97aw05JcqlNA78/WPuf3UeuuTB1wwsLEmlI9SqWxcNOHgx1/VWZxa58Pd0rp
         /gc6/+7j5ojK7DtC/qB36kmMpXceBoqqfDFVKntU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, David Hildenbrand <david@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 073/737] virtio-mem: check if the config changed before fake offlining memory
Date:   Mon, 11 Sep 2023 15:38:52 +0200
Message-ID: <20230911134652.555867926@linuxfoundation.org>
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

From: David Hildenbrand <david@redhat.com>

[ Upstream commit f55484fd7be923b740e8e1fc304070ba53675cb4 ]

If we repeatedly fail to fake offline memory to unplug it, we won't be
sending any unplug requests to the device. However, we only check if the
config changed when sending such (un)plug requests.

We could end up trying for a long time to unplug memory, even though
the config changed already and we're not supposed to unplug memory
anymore. For example, the hypervisor might detect a low-memory situation
while unplugging memory and decide to replug some memory. Continuing
trying to unplug memory in that case can be problematic.

So let's check on a more regular basis.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20230713145551.2824980-5-david@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/virtio/virtio_mem.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index a5cf92e3e5af2..fa5226c198cc6 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -1189,7 +1189,8 @@ static void virtio_mem_fake_online(unsigned long pfn, unsigned long nr_pages)
  * Try to allocate a range, marking pages fake-offline, effectively
  * fake-offlining them.
  */
-static int virtio_mem_fake_offline(unsigned long pfn, unsigned long nr_pages)
+static int virtio_mem_fake_offline(struct virtio_mem *vm, unsigned long pfn,
+				   unsigned long nr_pages)
 {
 	const bool is_movable = is_zone_movable_page(pfn_to_page(pfn));
 	int rc, retry_count;
@@ -1202,6 +1203,14 @@ static int virtio_mem_fake_offline(unsigned long pfn, unsigned long nr_pages)
 	 * some guarantees.
 	 */
 	for (retry_count = 0; retry_count < 5; retry_count++) {
+		/*
+		 * If the config changed, stop immediately and go back to the
+		 * main loop: avoid trying to keep unplugging if the device
+		 * might have decided to not remove any more memory.
+		 */
+		if (atomic_read(&vm->config_changed))
+			return -EAGAIN;
+
 		rc = alloc_contig_range(pfn, pfn + nr_pages, MIGRATE_MOVABLE,
 					GFP_KERNEL);
 		if (rc == -ENOMEM)
@@ -1951,7 +1960,7 @@ static int virtio_mem_sbm_unplug_sb_online(struct virtio_mem *vm,
 	start_pfn = PFN_DOWN(virtio_mem_mb_id_to_phys(mb_id) +
 			     sb_id * vm->sbm.sb_size);
 
-	rc = virtio_mem_fake_offline(start_pfn, nr_pages);
+	rc = virtio_mem_fake_offline(vm, start_pfn, nr_pages);
 	if (rc)
 		return rc;
 
@@ -2149,7 +2158,7 @@ static int virtio_mem_bbm_offline_remove_and_unplug_bb(struct virtio_mem *vm,
 		if (!page)
 			continue;
 
-		rc = virtio_mem_fake_offline(pfn, PAGES_PER_SECTION);
+		rc = virtio_mem_fake_offline(vm, pfn, PAGES_PER_SECTION);
 		if (rc) {
 			end_pfn = pfn;
 			goto rollback;
-- 
2.40.1



