Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D5A742C4D
	for <lists+stable@lfdr.de>; Thu, 29 Jun 2023 20:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbjF2Spn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 29 Jun 2023 14:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbjF2Spe (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Jun 2023 14:45:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2923030F0
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 11:45:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7A21615F2
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 18:45:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87C8C433C0;
        Thu, 29 Jun 2023 18:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688064332;
        bh=LBjn/Pz+9UNS62YtSJIUKTSQKpSSxxVma/nFzlqTTaw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dh/FJOJAZId2JezTG3w79ep5994ZHhZ7JUhDmi9ejVzxq5Gn+xMssuEwlcsIT5GlF
         u3IzMVjuWp14stwKGUuUuYY8eP6dJdtk7Dem5sV3Kt5DD0aO7ppF6M5f9zb8T3xixq
         jOii1BMLE/YBSge60nCglwvDm/pMyooccIvtAwnw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Ludvig Michaelsson <ludvig.michaelsson@yubico.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 6.1 27/30] HID: hidraw: fix data race on device refcount
Date:   Thu, 29 Jun 2023 20:43:46 +0200
Message-ID: <20230629184152.744413892@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629184151.651069086@linuxfoundation.org>
References: <20230629184151.651069086@linuxfoundation.org>
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

From: Ludvig Michaelsson <ludvig.michaelsson@yubico.com>

commit 944ee77dc6ec7b0afd8ec70ffc418b238c92f12b upstream.

The hidraw_open() function increments the hidraw device reference
counter. The counter has no dedicated synchronization mechanism,
resulting in a potential data race when concurrently opening a device.

The race is a regression introduced by commit 8590222e4b02 ("HID:
hidraw: Replace hidraw device table mutex with a rwsem"). While
minors_rwsem is intended to protect the hidraw_table itself, by instead
acquiring the lock for writing, the reference counter is also protected.
This is symmetrical to hidraw_release().

Link: https://github.com/systemd/systemd/issues/27947
Fixes: 8590222e4b02 ("HID: hidraw: Replace hidraw device table mutex with a rwsem")
Cc: stable@vger.kernel.org
Signed-off-by: Ludvig Michaelsson <ludvig.michaelsson@yubico.com>
Link: https://lore.kernel.org/r/20230621-hidraw-race-v1-1-a58e6ac69bab@yubico.com
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/hidraw.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -272,7 +272,12 @@ static int hidraw_open(struct inode *ino
 		goto out;
 	}
 
-	down_read(&minors_rwsem);
+	/*
+	 * Technically not writing to the hidraw_table but a write lock is
+	 * required to protect the device refcount. This is symmetrical to
+	 * hidraw_release().
+	 */
+	down_write(&minors_rwsem);
 	if (!hidraw_table[minor] || !hidraw_table[minor]->exist) {
 		err = -ENODEV;
 		goto out_unlock;
@@ -301,7 +306,7 @@ static int hidraw_open(struct inode *ino
 	spin_unlock_irqrestore(&hidraw_table[minor]->list_lock, flags);
 	file->private_data = list;
 out_unlock:
-	up_read(&minors_rwsem);
+	up_write(&minors_rwsem);
 out:
 	if (err < 0)
 		kfree(list);


