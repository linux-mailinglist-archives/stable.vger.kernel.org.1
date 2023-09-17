Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94997A3C79
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241052AbjIQUbe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241102AbjIQUb0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:31:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BE7AF
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:31:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03ABBC433C8;
        Sun, 17 Sep 2023 20:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982680;
        bh=d/r8kp2K1qez2+oyH5+p2yyc8wNY1d86pKwm5DvdbBI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JjldJHlXyeDAU8KYEEB7EY7XwYNtjhDkq8ZOuSGy2FPFbn/xXZr90w87BuEGLbLLi
         /+DtM6Loe3WxCRghsQQprtqKWtHg2ZbO78Mo9RzIzZDs+8/W6/NhuTQ6wmm6kVN69o
         LIrlCaWPIOZ9fOsdeSQzyfZ7d6FXsM7T0O+U9pqM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Dhruva Gole <d-gole@ti.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 5.15 322/511] PM / devfreq: Fix leak in devfreq_dev_release()
Date:   Sun, 17 Sep 2023 21:12:29 +0200
Message-ID: <20230917191121.595066941@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Boris Brezillon <boris.brezillon@collabora.com>

commit 5693d077595de721f9ddbf9d37f40e5409707dfe upstream.

srcu_init_notifier_head() allocates resources that need to be released
with a srcu_cleanup_notifier_head() call.

Reported by kmemleak.

Fixes: 0fe3a66410a3 ("PM / devfreq: Add new DEVFREQ_TRANSITION_NOTIFIER notifier")
Cc: <stable@vger.kernel.org>
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/devfreq/devfreq.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -762,6 +762,7 @@ static void devfreq_dev_release(struct d
 		dev_pm_opp_put_opp_table(devfreq->opp_table);
 
 	mutex_destroy(&devfreq->lock);
+	srcu_cleanup_notifier_head(&devfreq->transition_notifier_list);
 	kfree(devfreq);
 }
 


