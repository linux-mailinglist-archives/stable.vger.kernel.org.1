Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17214703956
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244325AbjEORlY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244128AbjEORlE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:41:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA38106F9
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:38:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E298D62DFC
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:38:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8AD9C433EF;
        Mon, 15 May 2023 17:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172303;
        bh=FKQliO2HJDCQSwslC89Yr+EOytJmpJIXDvsUaNIGtNY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PQweJNv9mBXDCATg1DWINlRgqm/PXK2+3XjE9Zqz2YQ6Mm6Jn8cT9C17DN4RJpI5J
         UczetwXVIg0asMeaDFfkwciuWxulbv1SRRsQYJWlfIC+mdci7QUb+VeSdtZtRUW2IB
         YJnfGxoPVCCX81xasDZDl54EiDwVOsmcjYES3SUE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 110/381] media: rcar_fdp1: fix pm_runtime_get_sync() usage count
Date:   Mon, 15 May 2023 18:26:01 +0200
Message-Id: <20230515161741.778817016@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
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

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

[ Upstream commit 45e75a8c6fa455a5909ac04db76a4b15d6bb8368 ]

The pm_runtime_get_sync() internally increments the
dev->power.usage_count without decrementing it, even on errors.
Replace it by the new pm_runtime_resume_and_get(), introduced by:
commit dd8088d5a896 ("PM: runtime: Add pm_runtime_resume_and_get to deal with usage counter")
in order to properly decrement the usage counter, avoiding
a potential PM usage counter leak.

Also, right now, the driver is ignoring any troubles when
trying to do PM resume. So, add the proper error handling
for the code.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Stable-dep-of: c766c90faf93 ("media: rcar_fdp1: Fix refcount leak in probe and remove function")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/rcar_fdp1.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/rcar_fdp1.c b/drivers/media/platform/rcar_fdp1.c
index ac2e7b2c60829..cedae184c6ad4 100644
--- a/drivers/media/platform/rcar_fdp1.c
+++ b/drivers/media/platform/rcar_fdp1.c
@@ -2139,7 +2139,9 @@ static int fdp1_open(struct file *file)
 	}
 
 	/* Perform any power management required */
-	pm_runtime_get_sync(fdp1->dev);
+	ret = pm_runtime_resume_and_get(fdp1->dev);
+	if (ret < 0)
+		goto error_pm;
 
 	v4l2_fh_add(&ctx->fh);
 
@@ -2149,6 +2151,8 @@ static int fdp1_open(struct file *file)
 	mutex_unlock(&fdp1->dev_mutex);
 	return 0;
 
+error_pm:
+       v4l2_m2m_ctx_release(ctx->fh.m2m_ctx);
 error_ctx:
 	v4l2_ctrl_handler_free(&ctx->hdl);
 	kfree(ctx);
@@ -2356,7 +2360,9 @@ static int fdp1_probe(struct platform_device *pdev)
 
 	/* Power up the cells to read HW */
 	pm_runtime_enable(&pdev->dev);
-	pm_runtime_get_sync(fdp1->dev);
+	ret = pm_runtime_resume_and_get(fdp1->dev);
+	if (ret < 0)
+		goto disable_pm;
 
 	hw_version = fdp1_read(fdp1, FD1_IP_INTDATA);
 	switch (hw_version) {
@@ -2385,6 +2391,9 @@ static int fdp1_probe(struct platform_device *pdev)
 
 	return 0;
 
+disable_pm:
+	pm_runtime_disable(fdp1->dev);
+
 release_m2m:
 	v4l2_m2m_release(fdp1->m2m_dev);
 
-- 
2.39.2



