Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65FB77BDE79
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346564AbjJINTz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376853AbjJINNx (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:13:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70F59F
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:13:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D34C433C9;
        Mon,  9 Oct 2023 13:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857231;
        bh=CyCch0Z7qxRekDi+Ho9q9smmS2i6KfrAXQIzYa+AfRs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JjFCxhmxUgGuxsQFWTelVp+EEq8a/ld9GvZ8hS15wifBSKb0isOSs7lxICn0O7ruL
         6kCe9n9wIXmNBW2YGBLTN47LKxjRvDFAMtbJmyPdYLzQC/2aXXRBhnuwaCh69Adrn6
         SyqYs8B3sQS0r5O8PIdVKDxJiw+cq24oRvaVVwvU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Fedor Pchelkin <pchelkin@ispras.ru>,
        Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH 6.5 140/163] dm zoned: free dmz->ddev array in dmz_put_zoned_devices
Date:   Mon,  9 Oct 2023 15:01:44 +0200
Message-ID: <20231009130127.911849066@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
References: <20231009130124.021290599@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fedor Pchelkin <pchelkin@ispras.ru>

commit 9850ccd5dd88075b2b7fd28d96299d5535f58cc5 upstream.

Commit 4dba12881f88 ("dm zoned: support arbitrary number of devices")
made the pointers to additional zoned devices to be stored in a
dynamically allocated dmz->ddev array. However, this array is not freed.

Rename dmz_put_zoned_device to dmz_put_zoned_devices and fix it to
free the dmz->ddev array when cleaning up zoned device information.
Remove NULL assignment for all dmz->ddev elements and just free the
dmz->ddev array instead.

Found by Linux Verification Center (linuxtesting.org).

Fixes: 4dba12881f88 ("dm zoned: support arbitrary number of devices")
Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/dm-zoned-target.c |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

--- a/drivers/md/dm-zoned-target.c
+++ b/drivers/md/dm-zoned-target.c
@@ -748,17 +748,16 @@ err:
 /*
  * Cleanup zoned device information.
  */
-static void dmz_put_zoned_device(struct dm_target *ti)
+static void dmz_put_zoned_devices(struct dm_target *ti)
 {
 	struct dmz_target *dmz = ti->private;
 	int i;
 
-	for (i = 0; i < dmz->nr_ddevs; i++) {
-		if (dmz->ddev[i]) {
+	for (i = 0; i < dmz->nr_ddevs; i++)
+		if (dmz->ddev[i])
 			dm_put_device(ti, dmz->ddev[i]);
-			dmz->ddev[i] = NULL;
-		}
-	}
+
+	kfree(dmz->ddev);
 }
 
 static int dmz_fixup_devices(struct dm_target *ti)
@@ -948,7 +947,7 @@ err_bio:
 err_meta:
 	dmz_dtr_metadata(dmz->metadata);
 err_dev:
-	dmz_put_zoned_device(ti);
+	dmz_put_zoned_devices(ti);
 err:
 	kfree(dmz->dev);
 	kfree(dmz);
@@ -978,7 +977,7 @@ static void dmz_dtr(struct dm_target *ti
 
 	bioset_exit(&dmz->bio_set);
 
-	dmz_put_zoned_device(ti);
+	dmz_put_zoned_devices(ti);
 
 	mutex_destroy(&dmz->chunk_lock);
 


