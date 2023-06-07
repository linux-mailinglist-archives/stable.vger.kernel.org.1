Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C14E726E74
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbjFGUuo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235592AbjFGUuL (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:50:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9364A2109
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:49:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C6B8643B1
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:49:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D679C433D2;
        Wed,  7 Jun 2023 20:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170997;
        bh=jXyeWu7J1vpGdlWJwZfkHZ8ILypI0JONqg8icPURwSA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rCEwUBlC2idYlUUmQDXtdLbg2aPxq02UkxhhH0xS0uNOR5pOcmiP3KAk5jEm8FqIs
         bXtPEdeGcLqjVFei4wv/m3ouzdZgAyH2bJOcix3DnbGuhPf/x4x7JK7YPbbjLrcE5Q
         ZdI/xkr9m64QpXbuiD+dWR6/XtG90ziMwwE3noQQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 072/120] mailbox: mailbox-test: fix a locking issue in mbox_test_message_write()
Date:   Wed,  7 Jun 2023 22:16:28 +0200
Message-ID: <20230607200903.148559027@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200900.915613242@linuxfoundation.org>
References: <20230607200900.915613242@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 8fe72b76db79d694858e872370df49676bc3be8c ]

There was a bug where this code forgot to unlock the tdev->mutex if the
kzalloc() failed.  Fix this issue, by moving the allocation outside the
lock.

Fixes: 2d1e952a2b8e ("mailbox: mailbox-test: Fix potential double-free in mbox_test_message_write()")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Lee Jones <lee@kernel.org>
Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mailbox/mailbox-test.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/mailbox-test.c b/drivers/mailbox/mailbox-test.c
index 6dd5b9614452b..abcee58e851c2 100644
--- a/drivers/mailbox/mailbox-test.c
+++ b/drivers/mailbox/mailbox-test.c
@@ -97,6 +97,7 @@ static ssize_t mbox_test_message_write(struct file *filp,
 				       size_t count, loff_t *ppos)
 {
 	struct mbox_test_device *tdev = filp->private_data;
+	char *message;
 	void *data;
 	int ret;
 
@@ -112,12 +113,13 @@ static ssize_t mbox_test_message_write(struct file *filp,
 		return -EINVAL;
 	}
 
-	mutex_lock(&tdev->mutex);
-
-	tdev->message = kzalloc(MBOX_MAX_MSG_LEN, GFP_KERNEL);
-	if (!tdev->message)
+	message = kzalloc(MBOX_MAX_MSG_LEN, GFP_KERNEL);
+	if (!message)
 		return -ENOMEM;
 
+	mutex_lock(&tdev->mutex);
+
+	tdev->message = message;
 	ret = copy_from_user(tdev->message, userbuf, count);
 	if (ret) {
 		ret = -EFAULT;
-- 
2.39.2



