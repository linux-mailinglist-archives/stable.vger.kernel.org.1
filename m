Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BFA7A7B5C
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234676AbjITLv1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234697AbjITLv0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:51:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81627F4
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:51:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6222C433B8;
        Wed, 20 Sep 2023 11:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210679;
        bh=KSIiGgRM0LBEgmUUTtrAzG4Iz2d9EKc6tHK5lqpgQcI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qsGrsJx31wBs5oWLzJpUDsPwdqxHR0UpGcIRqjEMD7pgpc98yx8hvh6vzugoj5Qus
         k3PuxS/8bvPJm4Qdaums1u/wo7PBDMsRCfuNAvHJrFpgwGw+Qo9Xg/ik1nfG+CIIHC
         yCluZ8TjtUoI+D+Oikyx8FO19K+0ejilBE5huNzU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nigel Croxon <ncroxon@redhat.com>,
        Song Liu <song@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 165/211] md/raid1: fix error: ISO C90 forbids mixed declarations
Date:   Wed, 20 Sep 2023 13:30:09 +0200
Message-ID: <20230920112851.002611645@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
References: <20230920112845.859868994@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Nigel Croxon <ncroxon@redhat.com>

[ Upstream commit df203da47f4428bc286fc99318936416253a321c ]

There is a compile error when this commit is added:
md: raid1: fix potential OOB in raid1_remove_disk()

drivers/md/raid1.c: In function 'raid1_remove_disk':
drivers/md/raid1.c:1844:9: error: ISO C90 forbids mixed declarations
and code [-Werror=declaration-after-statement]
1844 |         struct raid1_info *p = conf->mirrors + number;
     |         ^~~~~~

That's because the new code was inserted before the struct.
The change is move the struct command above this commit.

Fixes: 8b0472b50bcf ("md: raid1: fix potential OOB in raid1_remove_disk()")
Signed-off-by: Nigel Croxon <ncroxon@redhat.com>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/46d929d0-2aab-4cf2-b2bf-338963e8ba5a@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/raid1.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 80aeee63dfb78..a60acd72210aa 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1829,12 +1829,11 @@ static int raid1_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
 	struct r1conf *conf = mddev->private;
 	int err = 0;
 	int number = rdev->raid_disk;
+	struct raid1_info *p = conf->mirrors + number;
 
 	if (unlikely(number >= conf->raid_disks))
 		goto abort;
 
-	struct raid1_info *p = conf->mirrors + number;
-
 	if (rdev != p->rdev)
 		p = conf->mirrors + conf->raid_disks + number;
 
-- 
2.40.1



