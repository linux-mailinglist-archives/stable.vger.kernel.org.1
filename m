Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F313A70C6A3
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234354AbjEVTUa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjEVTU3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:20:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98ABEA3
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:20:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D43A6281C
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:20:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F48EC433EF;
        Mon, 22 May 2023 19:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783227;
        bh=fOwIFYWjJIRFJ2uBBoNzjUgcDBx6eU7xuY2CunyT2nM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kUbgRWBHJPrhE5NCRLrQhE1VDp585xVNv14z5VrAMf6vPb4MqEbpdJrmk1bRGW+oo
         VOOWlStQuZ9fYMNVd4MVFheVPmRJ2PsEKK8M+YvY8huAZXCb4u3b5vQf0ZhvWsVVdO
         pibecJ/sdRJOvoUUDfRKox8uj67rfwVa5UZ7HsNo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, John Starks <jostarks@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 153/203] scsi: storvsc: Dont pass unused PFNs to Hyper-V host
Date:   Mon, 22 May 2023 20:09:37 +0100
Message-Id: <20230522190359.213126672@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190354.935300867@linuxfoundation.org>
References: <20230522190354.935300867@linuxfoundation.org>
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

From: Michael Kelley <mikelley@microsoft.com>

[ Upstream commit 4e81a6cba517cb33584308a331f14f5e3fec369b ]

In a SCSI request, storvsc pre-allocates space for up to
MAX_PAGE_BUFFER_COUNT physical frame numbers to be passed to Hyper-V.  If
the size of the I/O request requires more PFNs, a separate memory area of
exactly the correct size is dynamically allocated.

But when the pre-allocated area is used, current code always passes
MAX_PAGE_BUFFER_COUNT PFNs to Hyper-V, even if fewer are needed.  While
this doesn't break anything because the additional PFNs are always zero,
more bytes than necessary are copied into the VMBus channel ring buffer.
This takes CPU cycles and wastes space in the ring buffer. For a typical 4
Kbyte I/O that requires only a single PFN, 248 unnecessary bytes are
copied.

Fix this by setting the payload_sz based on the actual number of PFNs
required, not the size of the pre-allocated space.

Reported-by: John Starks <jostarks@microsoft.com>
Fixes: 8f43710543ef ("scsi: storvsc: Support PAGE_SIZE larger than 4K")
Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Link: https://lore.kernel.org/r/1684171241-16209-1-git-send-email-mikelley@microsoft.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/storvsc_drv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 83a3d9f085d84..c9b1500c2ab87 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1843,7 +1843,7 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 
 	length = scsi_bufflen(scmnd);
 	payload = (struct vmbus_packet_mpb_array *)&cmd_request->mpb;
-	payload_sz = sizeof(cmd_request->mpb);
+	payload_sz = 0;
 
 	if (sg_count) {
 		unsigned int hvpgoff, hvpfns_to_add;
@@ -1851,10 +1851,10 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 		unsigned int hvpg_count = HVPFN_UP(offset_in_hvpg + length);
 		u64 hvpfn;
 
-		if (hvpg_count > MAX_PAGE_BUFFER_COUNT) {
+		payload_sz = (hvpg_count * sizeof(u64) +
+			      sizeof(struct vmbus_packet_mpb_array));
 
-			payload_sz = (hvpg_count * sizeof(u64) +
-				      sizeof(struct vmbus_packet_mpb_array));
+		if (hvpg_count > MAX_PAGE_BUFFER_COUNT) {
 			payload = kzalloc(payload_sz, GFP_ATOMIC);
 			if (!payload)
 				return SCSI_MLQUEUE_DEVICE_BUSY;
-- 
2.39.2



