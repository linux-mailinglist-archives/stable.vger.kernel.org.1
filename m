Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A4A6FA7AA
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbjEHKdi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234706AbjEHKdQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:33:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C866926744
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:32:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE6A462714
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:32:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D464DC4339E;
        Mon,  8 May 2023 10:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541944;
        bh=Xy+BvZGyEipNBxUZR0L1092kcoflM3Nty4IXV4AJ8HA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AQboazG71PENyRQM5vuuXFk9huDLjb6guIo2gx5hzEHOGvDKPZtJKlYztfeVOOQ0I
         IbncTpff3pEeCocmXz/pmgZUz+fIEjyKWP0WNzyLvmlGUYyZyP/3U+X5R80xMl5KCR
         D0Dwomb/lpHcfQoCDaOWOtYwDmJaw8hEVvT08SkA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zheng Wang <zyytlz.wz@163.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 245/663] media: rkvdec: fix use after free bug in rkvdec_remove
Date:   Mon,  8 May 2023 11:41:11 +0200
Message-Id: <20230508094436.222513566@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

From: Zheng Wang <zyytlz.wz@163.com>

[ Upstream commit 3228cec23b8b29215e18090c6ba635840190993d ]

In rkvdec_probe, rkvdec->watchdog_work is bound with
rkvdec_watchdog_func. Then rkvdec_vp9_run may
be called to start the work.

If we remove the module which will call rkvdec_remove
 to make cleanup, there may be a unfinished work.
 The possible sequence is as follows, which will
 cause a typical UAF bug.

Fix it by canceling the work before cleanup in rkvdec_remove.

CPU0                  CPU1

                    |rkvdec_watchdog_func
rkvdec_remove       |
 rkvdec_v4l2_cleanup|
  v4l2_m2m_release  |
    kfree(m2m_dev); |
                    |
                    | v4l2_m2m_get_curr_priv
                    |   m2m_dev->curr_ctx //use

Fixes: cd33c830448b ("media: rkvdec: Add the rkvdec driver")
Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/media/rkvdec/rkvdec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
index 7bab7586918c1..82806f198074a 100644
--- a/drivers/staging/media/rkvdec/rkvdec.c
+++ b/drivers/staging/media/rkvdec/rkvdec.c
@@ -1066,6 +1066,8 @@ static int rkvdec_remove(struct platform_device *pdev)
 {
 	struct rkvdec_dev *rkvdec = platform_get_drvdata(pdev);
 
+	cancel_delayed_work_sync(&rkvdec->watchdog_work);
+
 	rkvdec_v4l2_cleanup(rkvdec);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
-- 
2.39.2



