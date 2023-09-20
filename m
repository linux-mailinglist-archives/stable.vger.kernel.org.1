Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90557A8166
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbjITMpY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236443AbjITMo6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:44:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC025B4
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:44:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8078C433C8;
        Wed, 20 Sep 2023 12:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213891;
        bh=la+2+/i0dupowSAFVOMW5iaENFtVyqJhi/l8VOVkylc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vOTJNj1dhn5Tyz4h5vI4pTtUQ+xxY8b7eJ9TKMNWv8yFmamGe0SWApDtAgfV1VESL
         jVZE1/DbeHLdFYMEJXn+QWY7syhDUefvMWJWbF04kjX94xW517Nahf/FGObtpXTlRt
         Uxhn7ZWQ6cTsTYQU318OB8AXWFi5cx+eSkRozqBA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhang Shurong <zhang_shurong@foxmail.com>,
        Yu Kuai <yukuai3@huawei.com>, Song Liu <song@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 036/110] md: raid1: fix potential OOB in raid1_remove_disk()
Date:   Wed, 20 Sep 2023 13:31:34 +0200
Message-ID: <20230920112831.716804481@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112830.377666128@linuxfoundation.org>
References: <20230920112830.377666128@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhang Shurong <zhang_shurong@foxmail.com>

[ Upstream commit 8b0472b50bcf0f19a5119b00a53b63579c8e1e4d ]

If rddev->raid_disk is greater than mddev->raid_disks, there will be
an out-of-bounds in raid1_remove_disk(). We have already found
similar reports as follows:

1) commit d17f744e883b ("md-raid10: fix KASAN warning")
2) commit 1ebc2cec0b7d ("dm raid: fix KASAN warning in raid5_remove_disk")

Fix this bug by checking whether the "number" variable is
valid.

Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Link: https://lore.kernel.org/r/tencent_0D24426FAC6A21B69AC0C03CE4143A508F09@qq.com
Signed-off-by: Song Liu <song@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/raid1.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 084bfea6ad316..5360d6ed16e05 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1820,6 +1820,10 @@ static int raid1_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
 	struct r1conf *conf = mddev->private;
 	int err = 0;
 	int number = rdev->raid_disk;
+
+	if (unlikely(number >= conf->raid_disks))
+		goto abort;
+
 	struct raid1_info *p = conf->mirrors + number;
 
 	if (rdev != p->rdev)
-- 
2.40.1



