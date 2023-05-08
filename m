Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28206FAAA2
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbjEHLEn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235337AbjEHLE0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:04:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67CA21553
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:03:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4DB262A7A
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:03:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8F0FC433D2;
        Mon,  8 May 2023 11:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543806;
        bh=jRLtxG5tSTMrQuSMQyWL7k7PI8ZB0IP2qc5T4CAcYxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ywWEkjXBVZWIpCvAR/4WVEljxezulhZuY1KSVkK7b+scnRrmEhklHYwyff0QWRxF+
         p5G0WYgCQPVSe34oOawf2ssS6Um3+UuPz97KJmtug99IajlXl4iUP+dob5smP4Tk4s
         vMO7OKOGb/BqpOU9mErXwPsX88QnOTOEqsJeEP1E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 206/694] media: bdisp: Add missing check for create_workqueue
Date:   Mon,  8 May 2023 11:40:41 +0200
Message-Id: <20230508094439.064218403@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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
 drivers/media/platform/st/sti/bdisp/bdisp-v4l2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/st/sti/bdisp/bdisp-v4l2.c b/drivers/media/platform/st/sti/bdisp/bdisp-v4l2.c
index dd74cc43920d3..080da254b9109 100644
--- a/drivers/media/platform/st/sti/bdisp/bdisp-v4l2.c
+++ b/drivers/media/platform/st/sti/bdisp/bdisp-v4l2.c
@@ -1309,6 +1309,8 @@ static int bdisp_probe(struct platform_device *pdev)
 	init_waitqueue_head(&bdisp->irq_queue);
 	INIT_DELAYED_WORK(&bdisp->timeout_work, bdisp_irq_timeout);
 	bdisp->work_queue = create_workqueue(BDISP_NAME);
+	if (!bdisp->work_queue)
+		return -ENOMEM;
 
 	spin_lock_init(&bdisp->slock);
 	mutex_init(&bdisp->lock);
-- 
2.39.2



