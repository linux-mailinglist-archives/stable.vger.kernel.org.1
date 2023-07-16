Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB81755650
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbjGPUtb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbjGPUtX (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:49:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BEBE7B
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:49:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC1CA60EA2
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:49:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C1EC433C7;
        Sun, 16 Jul 2023 20:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540560;
        bh=TXdBClRXVvi48yJrwfyN5ghEtX7rxVGUBD6tVegiZis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r1vbL5xDa2/bGP7tHBQpN8jW8drxQgll7f/fnLQs6t6QkOYqhSA5KMX2IE1qXoDSk
         JHuuPfZFIc2dyTTCummSMwF2lxLoyDgTinuYkgzXEYetCbPatuOIDibt/8YyrExQ4t
         Cn+UJJJpvmWrpvtAUrbk8E0EMiHKph78lGE6fz5o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christoph Hellwig <hch@infradead.org>,
        Demi Marie Obenour <demi@invisiblethingslab.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.1 379/591] block: increment diskseq on all media change events
Date:   Sun, 16 Jul 2023 21:48:38 +0200
Message-ID: <20230716194933.726121320@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 block/disk-events.c |    1 +
 1 file changed, 1 insertion(+)

--- a/block/disk-events.c
+++ b/block/disk-events.c
@@ -307,6 +307,7 @@ bool disk_force_media_change(struct gend
 	if (!(events & DISK_EVENT_MEDIA_CHANGE))
 		return false;
 
+	inc_diskseq(disk);
 	if (__invalidate_device(disk->part0, true))
 		pr_warn("VFS: busy inodes on changed media %s\n",
 			disk->disk_name);


