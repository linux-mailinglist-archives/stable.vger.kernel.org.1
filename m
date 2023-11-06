Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3826C7E22D6
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbjKFNGA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbjKFNF6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:05:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC43A10B
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:05:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 278F5C433C7;
        Mon,  6 Nov 2023 13:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699275954;
        bh=cYH1lHayyxbOCMCMjN/1I6ACfomSjpnvIILpaAJ2kn8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vjC/mr09zEoj3iwB8AjLHpibaxZAm3a88/lDN2x41aW/WcTt3WXBp/RjVEGGTjSKw
         m74wU5dHeMCGADVQcy3VnVRd3m6+X9xLI9K9zjL/5TozaChH+RKOnBFQ75lzMIqGHF
         TxTi/D/S1Vywmf7MM6WifuIMmWsPfhou43Utommw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Gavin Shan <gshan@redhat.com>,
        Zhenyu Zhang <zhenyzha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH 4.14 03/48] virtio_balloon: Fix endless deflation and inflation on arm64
Date:   Mon,  6 Nov 2023 14:02:54 +0100
Message-ID: <20231106130257.976698340@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130257.862199836@linuxfoundation.org>
References: <20231106130257.862199836@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gavin Shan <gshan@redhat.com>

commit 07622bd415639e9709579f400afd19e7e9866e5e upstream.

The deflation request to the target, which isn't unaligned to the
guest page size causes endless deflation and inflation actions. For
example, we receive the flooding QMP events for the changes on memory
balloon's size after a deflation request to the unaligned target is
sent for the ARM64 guest, where we have 64KB base page size.

  /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64      \
  -accel kvm -machine virt,gic-version=host -cpu host          \
  -smp maxcpus=8,cpus=8,sockets=2,clusters=2,cores=2,threads=1 \
  -m 1024M,slots=16,maxmem=64G                                 \
  -object memory-backend-ram,id=mem0,size=512M                 \
  -object memory-backend-ram,id=mem1,size=512M                 \
  -numa node,nodeid=0,memdev=mem0,cpus=0-3                     \
  -numa node,nodeid=1,memdev=mem1,cpus=4-7                     \
    :                                                          \
  -device virtio-balloon-pci,id=balloon0,bus=pcie.10

  { "execute" : "balloon", "arguments": { "value" : 1073672192 } }
  {"return": {}}
  {"timestamp": {"seconds": 1693272173, "microseconds": 88667},   \
   "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
  {"timestamp": {"seconds": 1693272174, "microseconds": 89704},   \
   "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
  {"timestamp": {"seconds": 1693272175, "microseconds": 90819},   \
   "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
  {"timestamp": {"seconds": 1693272176, "microseconds": 91961},   \
   "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
  {"timestamp": {"seconds": 1693272177, "microseconds": 93040},   \
   "event": "BALLOON_CHANGE", "data": {"actual": 1073676288}}
  {"timestamp": {"seconds": 1693272178, "microseconds": 94117},   \
   "event": "BALLOON_CHANGE", "data": {"actual": 1073676288}}
  {"timestamp": {"seconds": 1693272179, "microseconds": 95337},   \
   "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
  {"timestamp": {"seconds": 1693272180, "microseconds": 96615},   \
   "event": "BALLOON_CHANGE", "data": {"actual": 1073676288}}
  {"timestamp": {"seconds": 1693272181, "microseconds": 97626},   \
   "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
  {"timestamp": {"seconds": 1693272182, "microseconds": 98693},   \
   "event": "BALLOON_CHANGE", "data": {"actual": 1073676288}}
  {"timestamp": {"seconds": 1693272183, "microseconds": 99698},   \
   "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
  {"timestamp": {"seconds": 1693272184, "microseconds": 100727},  \
   "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
  {"timestamp": {"seconds": 1693272185, "microseconds": 90430},   \
   "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
  {"timestamp": {"seconds": 1693272186, "microseconds": 102999},  \
   "event": "BALLOON_CHANGE", "data": {"actual": 1073676288}}
     :
  <The similar QMP events repeat>

Fix it by aligning the target up to the guest page size, 64KB in this
specific case. With this applied, no flooding QMP events are observed
and the memory balloon's size can be stablizied to 0x3ffe0000 soon
after the deflation request is sent.

  { "execute" : "balloon", "arguments": { "value" : 1073672192 } }
  {"return": {}}
  {"timestamp": {"seconds": 1693273328, "microseconds": 793075},  \
   "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
  { "execute" : "query-balloon" }
  {"return": {"actual": 1073610752}}

Cc: stable@vger.kernel.org
Signed-off-by: Gavin Shan <gshan@redhat.com>
Tested-by: Zhenyu Zhang <zhenyzha@redhat.com>
Message-Id: <20230831011007.1032822-1-gshan@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/virtio/virtio_balloon.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -341,7 +341,11 @@ static inline s64 towards_target(struct
 	if (!virtio_has_feature(vb->vdev, VIRTIO_F_VERSION_1))
 		num_pages = le32_to_cpu((__force __le32)num_pages);
 
-	target = num_pages;
+	/*
+	 * Aligned up to guest page size to avoid inflating and deflating
+	 * balloon endlessly.
+	 */
+	target = ALIGN(num_pages, VIRTIO_BALLOON_PAGES_PER_PAGE);
 	return target - vb->num_pages;
 }
 


