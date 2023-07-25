Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1013761793
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbjGYLtb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbjGYLtS (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:49:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6391BC5
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:49:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EF0A616B0
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:49:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 704ACC433C8;
        Tue, 25 Jul 2023 11:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690285745;
        bh=jUhbEftmrigVy0ZpEyKAif+Nlw1+PA3ipwv8vwIBxfI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zwtk2x//F7iRjCl4utSLjTXpzj81tFa1Fp/IeAYQInJPLf5g/dVPnx+aAwPpyBhDb
         BSLH8RxoSpIN/SRJDiwtTAD547xkQgrzistc+LPetsCM1cxfnA0lpo0H0GRB2qyiu+
         kpst/By5PkW2AvKJAFTaQSClrn58jXLkhRgo0Ngk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Peter Neuwirth <reddunur@online.de>,
        Yu Kuai <yukuai3@huawei.com>, Song Liu <song@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 286/313] md: fix data corruption for raid456 when reshape restart while grow up
Date:   Tue, 25 Jul 2023 12:47:19 +0200
Message-ID: <20230725104533.447182917@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit 873f50ece41aad5c4f788a340960c53774b5526e ]

Currently, if reshape is interrupted, echo "reshape" to sync_action will
restart reshape from scratch, for example:

echo frozen > sync_action
echo reshape > sync_action

This will corrupt data before reshape_position if the array is growing,
fix the problem by continue reshape from reshape_position.

Reported-by: Peter Neuwirth <reddunur@online.de>
Link: https://lore.kernel.org/linux-raid/e2f96772-bfbc-f43b-6da1-f520e5164536@online.de/
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20230512015610.821290-3-yukuai1@huaweicloud.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/md.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 0765712513e7d..a006f3a9554bf 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -4743,11 +4743,21 @@ action_store(struct mddev *mddev, const char *page, size_t len)
 			return -EINVAL;
 		err = mddev_lock(mddev);
 		if (!err) {
-			if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
+			if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
 				err =  -EBUSY;
-			else {
+			} else if (mddev->reshape_position == MaxSector ||
+				   mddev->pers->check_reshape == NULL ||
+				   mddev->pers->check_reshape(mddev)) {
 				clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 				err = mddev->pers->start_reshape(mddev);
+			} else {
+				/*
+				 * If reshape is still in progress, and
+				 * md_check_recovery() can continue to reshape,
+				 * don't restart reshape because data can be
+				 * corrupted for raid456.
+				 */
+				clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 			}
 			mddev_unlock(mddev);
 		}
-- 
2.39.2



