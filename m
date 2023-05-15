Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1024703954
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244571AbjEORlV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244564AbjEORlB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:41:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF333100EA
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:38:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE4D762DDB
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:38:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD5CC433EF;
        Mon, 15 May 2023 17:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172297;
        bh=hAH0M2YpQkc4i4mY8Kl41/9GQaNyr/0AZsDDFALuWfY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pROfjsYlWIrm4qz2gv+NHJnypRBZ+7/6rcVlYXx9MnK3zfr+gQO9cTrSrzIhHkVSQ
         0zmxCD8DZvgeknjp9Ri9/ybBuz4H5c19UivsuIvSF4H/mNJye979KtxSyScqsKb/AQ
         sHKhmV+f3xzWlFMD5eefvIfhuVaYsRrrg3KSzNWQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zheng Wang <zyytlz.wz@163.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 108/381] media: saa7134: fix use after free bug in saa7134_finidev due to race condition
Date:   Mon, 15 May 2023 18:25:59 +0200
Message-Id: <20230515161741.681574771@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
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

[ Upstream commit 30cf57da176cca80f11df0d9b7f71581fe601389 ]

In saa7134_initdev, it will call saa7134_hwinit1. There are three
function invoking here: saa7134_video_init1, saa7134_ts_init1
and saa7134_vbi_init1.

All of them will init a timer with same function. Take
saa7134_video_init1 as an example. It'll bound &dev->video_q.timeout
with saa7134_buffer_timeout.

In buffer_activate, the timer funtcion is started.

If we remove the module or device which will call saa7134_finidev
to make cleanup, there may be a unfinished work. The
possible sequence is as follows, which will cause a
typical UAF bug.

Fix it by canceling the timer works accordingly before cleanup in
saa7134_finidev.

CPU0                  CPU1

                    |saa7134_buffer_timeout
saa7134_finidev     |
  kfree(dev);       |
                    |
                    | saa7134_buffer_next
                    | //use dev

Fixes: 1e7126b4a86a ("media: saa7134: Convert timers to use timer_setup()")
Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/saa7134/saa7134-ts.c    | 1 +
 drivers/media/pci/saa7134/saa7134-vbi.c   | 1 +
 drivers/media/pci/saa7134/saa7134-video.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/media/pci/saa7134/saa7134-ts.c b/drivers/media/pci/saa7134/saa7134-ts.c
index 6a5053126237f..437dbe5e75e29 100644
--- a/drivers/media/pci/saa7134/saa7134-ts.c
+++ b/drivers/media/pci/saa7134/saa7134-ts.c
@@ -300,6 +300,7 @@ int saa7134_ts_start(struct saa7134_dev *dev)
 
 int saa7134_ts_fini(struct saa7134_dev *dev)
 {
+	del_timer_sync(&dev->ts_q.timeout);
 	saa7134_pgtable_free(dev->pci, &dev->ts_q.pt);
 	return 0;
 }
diff --git a/drivers/media/pci/saa7134/saa7134-vbi.c b/drivers/media/pci/saa7134/saa7134-vbi.c
index 3f0b0933eed69..3e773690468bd 100644
--- a/drivers/media/pci/saa7134/saa7134-vbi.c
+++ b/drivers/media/pci/saa7134/saa7134-vbi.c
@@ -185,6 +185,7 @@ int saa7134_vbi_init1(struct saa7134_dev *dev)
 int saa7134_vbi_fini(struct saa7134_dev *dev)
 {
 	/* nothing */
+	del_timer_sync(&dev->vbi_q.timeout);
 	return 0;
 }
 
diff --git a/drivers/media/pci/saa7134/saa7134-video.c b/drivers/media/pci/saa7134/saa7134-video.c
index 85d082baaadc5..df9e3293015a2 100644
--- a/drivers/media/pci/saa7134/saa7134-video.c
+++ b/drivers/media/pci/saa7134/saa7134-video.c
@@ -2153,6 +2153,7 @@ int saa7134_video_init1(struct saa7134_dev *dev)
 
 void saa7134_video_fini(struct saa7134_dev *dev)
 {
+	del_timer_sync(&dev->video_q.timeout);
 	/* free stuff */
 	saa7134_pgtable_free(dev->pci, &dev->video_q.pt);
 	saa7134_pgtable_free(dev->pci, &dev->vbi_q.pt);
-- 
2.39.2



