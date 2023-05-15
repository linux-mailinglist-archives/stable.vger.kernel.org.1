Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995C770330D
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242703AbjEOQci (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242718AbjEOQcd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:32:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D7710C3
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:32:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED82B62792
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:32:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E257AC433EF;
        Mon, 15 May 2023 16:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684168351;
        bh=5wrs2YwhIfIgGlE5xIuSlmeURhjYYFBwdUzLbNskQMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MSUS4qTpLZLq4AZ/WbXbXQ/ISsUpb+P0XkpT5W2L2NSJsDiyQ120Ha+wlXJbConeS
         v3ATrw1hsxFipYigerRVLhHEvidZThuDnCLc7HbKXLj88T7KqUMx2Z/8ffu9bO022d
         wBblbNsKBWzSPX6uMYri25tzRjSRsYK5fOWOTZD8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 021/116] media: bdisp: Add missing check for create_workqueue
Date:   Mon, 15 May 2023 18:25:18 +0200
Message-Id: <20230515161658.988231158@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161658.228491273@linuxfoundation.org>
References: <20230515161658.228491273@linuxfoundation.org>
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

From: Jiasheng Jiang <jiasheng@iscas.ac.cn>

[ Upstream commit 2371adeab717d8fe32144a84f3491a03c5838cfb ]

Add the check for the return value of the create_workqueue
in order to avoid NULL pointer dereference.

Fixes: 28ffeebbb7bd ("[media] bdisp: 2D blitter driver using v4l2 mem2mem framework")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/sti/bdisp/bdisp-v4l2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/sti/bdisp/bdisp-v4l2.c b/drivers/media/platform/sti/bdisp/bdisp-v4l2.c
index 79de7d413cf5e..d7432e0e3e6e1 100644
--- a/drivers/media/platform/sti/bdisp/bdisp-v4l2.c
+++ b/drivers/media/platform/sti/bdisp/bdisp-v4l2.c
@@ -1308,6 +1308,8 @@ static int bdisp_probe(struct platform_device *pdev)
 	init_waitqueue_head(&bdisp->irq_queue);
 	INIT_DELAYED_WORK(&bdisp->timeout_work, bdisp_irq_timeout);
 	bdisp->work_queue = create_workqueue(BDISP_NAME);
+	if (!bdisp->work_queue)
+		return -ENOMEM;
 
 	spin_lock_init(&bdisp->slock);
 	mutex_init(&bdisp->lock);
-- 
2.39.2



