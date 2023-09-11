Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C877F79BDB0
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240086AbjIKVEa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238844AbjIKOFy (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:05:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45EAE40
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:05:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C3FC433CA;
        Mon, 11 Sep 2023 14:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441149;
        bh=6OWAg0ZdYXRhBAANZhI73RlElyOPkday7oL+mhUQv18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KbFGM0y7XBrFryhmDZyY9vxITFnk7tzzscugOe5GOpJ41uvzZI3SVCRPM6s3bDqju
         hoTDgvRAVivggC6aEGC8BL6e/VcTPh1PC5yZyNs3TeJwb8zP2MOm4r2D5rawRMuW6O
         ohY39RQpa0CgYUlPoepBHxdrYFImZnnB4UzCaU/Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yu Kuai <yukuai3@huawei.com>,
        Song Liu <song@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 285/739] md: restore noio_flag for the last mddev_resume()
Date:   Mon, 11 Sep 2023 15:41:24 +0200
Message-ID: <20230911134659.096575210@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit e24ed04389f9619e0aaef615a8948633c182a8b0 ]

memalloc_noio_save() is called for the first mddev_suspend(), and
repeated mddev_suspend() only increase 'suspended'. However,
memalloc_noio_restore() is also called for the first mddev_resume(),
which means that memory reclaim will be enabled before the last
mddev_resume() is called, while the array is still suspended.

Fix this problem by restore 'noio_flag' for the last mddev_resume().

Fixes: 78f57ef9d50a ("md: use memalloc scope APIs in mddev_suspend()/mddev_resume()")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Link: https://lore.kernel.org/r/20230628012931.88911-3-yukuai1@huaweicloud.com
Signed-off-by: Song Liu <song@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/md.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 78be7811a89f5..2a4a3d3039fae 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -465,11 +465,13 @@ EXPORT_SYMBOL_GPL(mddev_suspend);
 
 void mddev_resume(struct mddev *mddev)
 {
-	/* entred the memalloc scope from mddev_suspend() */
-	memalloc_noio_restore(mddev->noio_flag);
 	lockdep_assert_held(&mddev->reconfig_mutex);
 	if (--mddev->suspended)
 		return;
+
+	/* entred the memalloc scope from mddev_suspend() */
+	memalloc_noio_restore(mddev->noio_flag);
+
 	percpu_ref_resurrect(&mddev->active_io);
 	wake_up(&mddev->sb_wait);
 	mddev->pers->quiesce(mddev, 0);
-- 
2.40.1



