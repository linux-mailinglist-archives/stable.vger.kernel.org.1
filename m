Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC48675D2C5
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjGUTD3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbjGUTD1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:03:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9E130E1
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:03:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEC4761D79
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:03:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F159CC433C7;
        Fri, 21 Jul 2023 19:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966205;
        bh=yhG/YMYhY9c4XWokA3lRF1vHsgwAFlGdBr1Pw4LEDAs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SoR5a76s/6mjCTgnAwxd1DeknP84cOwp4drZdNq7mlxxGtJv9HJwgb86XcPqR2lYf
         w9ds32/DEVizyQrRyuNb3ROIh+t7DkH2qJBWTI/JmjkDa/Nwq496prWkPtaShdHIhP
         XbNjZrrJc4ECYmhmv4AgO1roQRmXRAPnYR6GoAX4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christoph Hellwig <hch@infradead.org>,
        Demi Marie Obenour <demi@invisiblethingslab.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.15 262/532] block: increment diskseq on all media change events
Date:   Fri, 21 Jul 2023 18:02:46 +0200
Message-ID: <20230721160628.556684467@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Demi Marie Obenour <demi@invisiblethingslab.com>

commit b90ecc0379eb7bbe79337b0c7289390a98752646 upstream.

Currently, associating a loop device with a different file descriptor
does not increment its diskseq.  This allows the following race
condition:

1. Program X opens a loop device
2. Program X gets the diskseq of the loop device.
3. Program X associates a file with the loop device.
4. Program X passes the loop device major, minor, and diskseq to
   something.
5. Program X exits.
6. Program Y detaches the file from the loop device.
7. Program Y attaches a different file to the loop device.
8. The opener finally gets around to opening the loop device and checks
   that the diskseq is what it expects it to be.  Even though the
   diskseq is the expected value, the result is that the opener is
   accessing the wrong file.

>From discussions with Christoph Hellwig, it appears that
disk_force_media_change() was supposed to call inc_diskseq(), but in
fact it does not.  Adding a Fixes: tag to indicate this.  Christoph's
Reported-by is because he stated that disk_force_media_change()
calls inc_diskseq(), which is what led me to discover that it should but
does not.

Reported-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
Fixes: e6138dc12de9 ("block: add a helper to raise a media changed event")
Cc: stable@vger.kernel.org # 5.15+
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20230607170837.1559-1-demi@invisiblethingslab.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/disk-events.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/disk-events.c b/block/disk-events.c
index 8b1b63225738..0cfac464e6d1 100644
--- a/block/disk-events.c
+++ b/block/disk-events.c
@@ -307,6 +307,7 @@ bool disk_force_media_change(struct gendisk *disk, unsigned int events)
 	if (!(events & DISK_EVENT_MEDIA_CHANGE))
 		return false;
 
+	inc_diskseq(disk);
 	if (__invalidate_device(disk->part0, true))
 		pr_warn("VFS: busy inodes on changed media %s\n",
 			disk->disk_name);
-- 
2.41.0



