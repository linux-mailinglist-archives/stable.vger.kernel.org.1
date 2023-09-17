Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5097B7A38B1
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239056AbjIQTjM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239825AbjIQTip (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:38:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5279C103
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:38:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A5BAC433C7;
        Sun, 17 Sep 2023 19:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979520;
        bh=eNOA853EauaSXqhqyPJEdLUlPyO+ugjrBNpJK0zFGcg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mMGIuxNQufZp2BuTjLr8zY3kaC3CIBlcxjkFvRIue3cz9EuYAOmh/s6/zmBDcV9rp
         H3dTalQJsLNUtCjQ/V0jHKJP62Z87sggFEsB8ZuGDd9M0z3aoJ9Xz7ZLqNdErkBKxy
         t/Eebfk211FKtluz9j/jrFyCT1lpp30t4P7eW56U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yu Kuai <yukuai3@huawei.com>,
        Song Liu <song@kernel.org>
Subject: [PATCH 5.10 311/406] md/md-bitmap: remove unnecessary local variable in backlog_store()
Date:   Sun, 17 Sep 2023 21:12:45 +0200
Message-ID: <20230917191109.514922325@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yu Kuai <yukuai3@huawei.com>

commit b4d129640f194ffc4cc64c3e97f98ae944c072e8 upstream.

Local variable is definied first in the beginning of backlog_store(),
there is no need to define it again.

Fixes: 8c13ab115b57 ("md/bitmap: don't set max_write_behind if there is no write mostly device")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Link: https://lore.kernel.org/r/20230706083727.608914-2-yukuai1@huaweicloud.com
Signed-off-by: Song Liu <song@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/md-bitmap.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -2512,8 +2512,6 @@ backlog_store(struct mddev *mddev, const
 			mddev_destroy_serial_pool(mddev, NULL, false);
 	} else if (backlog && !mddev->serial_info_pool) {
 		/* serial_info_pool is needed since backlog is not zero */
-		struct md_rdev *rdev;
-
 		rdev_for_each(rdev, mddev)
 			mddev_create_serial_pool(mddev, rdev, false);
 	}


