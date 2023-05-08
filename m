Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23046FA970
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235128AbjEHKvQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235122AbjEHKu4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:50:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F8F2A9F5
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:50:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9214562926
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA34EC433D2;
        Mon,  8 May 2023 10:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543016;
        bh=eCFHU+S1dsdT4iPuQcKU2ajIAJsaOfZZkJqUsGVtogE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T7PxdDsTdeVzrUnHhQvnmmGag6wYZo5Us5/r0AjYbl/CUIJxe6SMjaavMcJMx+yFk
         33HvW73AbiheszskDTLuxqcxo88BnWJaduufoX1/bmbmtUq2le86ZJRrNhInz6V9vo
         Cs/im0rS71tN+6upMRKINcNFJ2qH4rCl+oBgwQx4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Li Nan <linan122@huawei.com>,
        Song Liu <song@kernel.org>
Subject: [PATCH 6.2 622/663] md/raid10: fix null-ptr-deref in raid10_sync_request
Date:   Mon,  8 May 2023 11:47:28 +0200
Message-Id: <20230508094449.964026050@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

From: Li Nan <linan122@huawei.com>

commit a405c6f0229526160aa3f177f65e20c86fce84c5 upstream.

init_resync() inits mempool and sets conf->have_replacemnt at the beginning
of sync, close_sync() frees the mempool when sync is completed.

After [1] recovery might be skipped and init_resync() is called but
close_sync() is not. null-ptr-deref occurs with r10bio->dev[i].repl_bio.

The following is one way to reproduce the issue.

  1) create a array, wait for resync to complete, mddev->recovery_cp is set
     to MaxSector.
  2) recovery is woken and it is skipped. conf->have_replacement is set to
     0 in init_resync(). close_sync() not called.
  3) some io errors and rdev A is set to WantReplacement.
  4) a new device is added and set to A's replacement.
  5) recovery is woken, A have replacement, but conf->have_replacemnt is
     0. r10bio->dev[i].repl_bio will not be alloced and null-ptr-deref
     occurs.

Fix it by not calling init_resync() if recovery skipped.

[1] commit 7e83ccbecd60 ("md/raid10: Allow skipping recovery when clean arrays are assembled")
Fixes: 7e83ccbecd60 ("md/raid10: Allow skipping recovery when clean arrays are assembled")
Cc: stable@vger.kernel.org
Signed-off-by: Li Nan <linan122@huawei.com>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20230222041000.3341651-3-linan666@huaweicloud.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/raid10.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -3302,10 +3302,6 @@ static sector_t raid10_sync_request(stru
 	sector_t chunk_mask = conf->geo.chunk_mask;
 	int page_idx = 0;
 
-	if (!mempool_initialized(&conf->r10buf_pool))
-		if (init_resync(conf))
-			return 0;
-
 	/*
 	 * Allow skipping a full rebuild for incremental assembly
 	 * of a clean array, like RAID1 does.
@@ -3321,6 +3317,10 @@ static sector_t raid10_sync_request(stru
 		return mddev->dev_sectors - sector_nr;
 	}
 
+	if (!mempool_initialized(&conf->r10buf_pool))
+		if (init_resync(conf))
+			return 0;
+
  skipped:
 	max_sector = mddev->dev_sectors;
 	if (test_bit(MD_RECOVERY_SYNC, &mddev->recovery) ||


